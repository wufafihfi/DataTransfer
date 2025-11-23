@echo off
title Mixplorer Launcher - Smart Disconnect

echo ================================
echo   Mixplorer Smart Launcher
echo ================================
echo.

if not exist "adb.exe" (
    echo Error: adb.exe not found in current directory
    pause
    exit /b 1
)

echo Checking device connection...
adb devices >nul 2>&1

if errorlevel 1 (
    echo Error: No device connected
    pause
    exit /b 1
)

echo Device found. Launching Mixplorer...
adb shell monkey -p com.mixplorer.beta -c android.intent.category.LAUNCHER 1

if errorlevel 1 (
    echo Launch failed.
) else (
    echo Success! Mixplorer launched.
    echo Waiting 3 seconds for app to start...
    timeout /t 3 /nobreak >nul
)

echo.
echo Disconnecting ADB...
adb disconnect
adb kill-server

echo ADB disconnected successfully.
echo You can now unplug your device.
pause