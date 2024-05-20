#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Define the path to the configuration file
CONFIG_FILE="$SCRIPT_DIR/conf.yml"  # Corrected line, added missing closing quote

# Check if the file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file does not exist in the script directory."
  exit 1
fi


# Determine which shell configuration file to update
case $SHELL in
  */zsh)
    SHELL_CONFIG="${HOME}/.zshrc"
    ;;
  */bash)
    SHELL_CONFIG="${HOME}/.bashrc"
    ;;
  *)
    echo "Unsupported shell. Defaulting to Bash settings."
    SHELL_CONFIG="${HOME}/.bashrc"
    ;;
esac

# Ask the user if they want to add git aliases for the cheat repository
read -p "Do you want to add git aliases for the cheat repository? (y/N) " add_aliases
if [[ $add_aliases =~ ^[Yy]$ ]]; then
    # Add aliases to the shell configuration file
    echo "alias cheatcommit='git --git-dir=${HOME}/.config/cheat/.git --work-tree=${HOME}/.config/cheat add . && git --git-dir=${HOME}/.config/cheat/.git --work-tree=${HOME}/.config/cheat commit'" >> "$SHELL_CONFIG"
    echo "alias cheatpush='git --git-dir=${HOME}/.config/cheat/.git --work-tree=${HOME}/.config/cheat push'" >> "$SHELL_CONFIG"
     echo "alias cheatpull='git --git-dir=${HOME}/.config/cheat/.git --work-tree=${HOME}/.config/cheat pull'" >> "$SHELL_CONFIG"

    echo "Aliases added to $SHELL_CONFIG."
    echo "You may need to reload your shell configuration by running: source $SHELL_CONFIG"
else
    echo "No aliases were added."
fi
