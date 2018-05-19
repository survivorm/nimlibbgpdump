# Package

version       = "0.1.0"
author        = "survivorm"
description   = "libbgpdump wrapper in Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.1.5"

import distros

var cmd = ""
var ldpath = ""
var ext = ""
if detectOs(Windows):
    cmd = "cmd /c "
    ext = ".exe"
if detectOs(Linux):
    ldpath = "LD_LIBRARY_PATH=x64 "

task setup, "Download and generate":
    exec cmd & "nimgen nimbgpdump.cfg"

before install:
    setupTask()

task test, "Test nimbgpdump":
    exec "nim c -d:nimDebugDlOpen tests/bgpdump.nim"
    withDir("nimbgpdump"):
        exec ldpath & "../tests/bgp" & ext
