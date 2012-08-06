import System.IO
import System.Exit
import XMonad
import XMonad.Core
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M

newKeys conf@(XConfig {XMonad.modMask = modm}) = [
      ((modm .|. shiftMask, xK_0 ), io (exitWith ExitSuccess)),
      ((modm, xK_0 ), restart "xmonad" True)
    ]

myKeys x = M.delete (XMonad.mod1Mask .|. shiftMask, xK_q) (M.delete (XMonad.mod1Mask, xK_q) (M.union (M.fromList (newKeys x)) (keys defaultConfig x)))

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/xinuc/.xmobarrc"
    xmproc <- spawnPipe "/home/xinuc/bin/tray"
    xmproc <- spawnPipe "/home/xinuc/bin/dmenu"
    xmonad $ defaultConfig
        {
          manageHook = manageDocks <+> manageHook defaultConfig,
          layoutHook = avoidStruts  $  layoutHook defaultConfig,
          normalBorderColor  = "#000000",
          focusedBorderColor = "#7c7c7c",
          startupHook = setWMName "LG3D",
          keys = myKeys,
          borderWidth = 1,
          terminal      = "terminator"
        } `additionalKeys`
        [
          ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
          ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
          ((0, xK_Print), spawn "scrot"),
          ((mod4Mask, xK_n), spawn "nautilus"),
          ((mod4Mask, xK_f), spawn "firefox"),
          ((mod4Mask, xK_e), spawn "exaile"),
          ((mod4Mask, xK_c), spawn "gnome-control-center"),
          ((mod4Mask, xK_p), spawn "pidgin"),
          ((mod4Mask, xK_g), spawn "chromium")
        ]
