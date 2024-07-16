Return-Path: <linux-kernel+bounces-254270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E58933144
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC481F2339F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E51A3BDF;
	Tue, 16 Jul 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+kWA2ZF"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960CF1A3BBF;
	Tue, 16 Jul 2024 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156328; cv=none; b=REHykA4s4WCz1FesgJOn/Qpmj8EBUu4Y3DsS1TNhcaxYOoCkQFmO6j6whKzhC4aG2stYkoNpoiB70ZMwxhQG4owTcV1YSLhiUiPg+N/WRB7cePy0xJD/jp097zRlK0XV+VyhYY2kA94Wd+Wj23QCiQGt/wKnlbm14BbN25p23dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156328; c=relaxed/simple;
	bh=qPoHeHKaNt2ADRpuU/hSuSHZCiAloyydafxYcBbGtoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBcE/xS1wO+l2GoJwPNODfeROqKEcUdKlYemxtxvP+HPURPdYO0RN3805FhlVtIrj4doCMOx0r0vqP5IOHjCcrWPsuyOBXISLNVzZTfEfNJjWwcSdhkVsr57EF5HvVra7qi/GhtaA2MvRRRZRMbMZfgW2bPaRbltNm6lLN/Seok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+kWA2ZF; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7fedb09357aso5211239f.2;
        Tue, 16 Jul 2024 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156325; x=1721761125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S+2qr0Nx8V7Wt9mGFuHZ4lGBCN5y3YK4bB9crjyLn8=;
        b=T+kWA2ZF5roFDpVv5uOpWsL4v2Q9a1k2VLD4N6eenkXLciw3WAnpIi5p8cz3bwCBUC
         zpJWZ6IIhUCjYV8POitJvo+SRgw3cbcw0X9qJ4hiIPKSGxqqR86x1sOlZ+zBQV1mKsoT
         cDRIiiZ1bvSYsKxavq4BybpZXMhzxJaG08rViWlI8A1AMODMhh9bxGqgX9pghdJChtJH
         ZoguG8fKsg6ye6aH6dXysjz8d/lp6I0tha6ukFlV3N0ubb50zZUG60pccKUL7sL7RfAa
         5BTmHavebzC5lxDYwu0H60Mh2dAz+SoVViIG0VPYSjOYAMTUsaMIXyVfBZXnlKDZJDiA
         XRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156325; x=1721761125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S+2qr0Nx8V7Wt9mGFuHZ4lGBCN5y3YK4bB9crjyLn8=;
        b=JSwA7cD0mVLqRe2HfU3bPpa6xiy2F0rHpRQGJ9nTEH2dUVjnaLvPND+wVtDGy35hnW
         BVgwkcmnD76qOYMJqbQiAFDiUK0XUoQZ4VifgIst3f0YKGDSCYEYOS0Am34hL77rS1EH
         /+zPU7u2Kwah87dsDzHdNqegFkiAMI0UTFZasrzhjkBU3LMkr9o6Ke4ehJIvStNk+sgE
         STGA0R8qvkaYbrCC3Of4a20wQ5rpK5KVBiRL3yjIqB/VgvL/AwdMisMTnNCppG5BRSvT
         yX69Nk4loCQLtTvcbXgg1BFlPTrn33+v16r7vjhzDUxwueSx58sUHbY5CEwLr0xbB8MB
         qwIA==
X-Forwarded-Encrypted: i=1; AJvYcCWaiFgrkcRTNYIKBpb+EG3qtdeSIomQg0ACCAxkGW+b27+AdZ/td9A/MUCjrisk0M8FwArxBKNJRZMn2hm21iZOvSU2pIea/uy7
X-Gm-Message-State: AOJu0YzK1Dw9TVJdu8bCG2+J+istOHryZBSNipvqpolM/sdi502OL8/3
	IRv/n+r/Vr+yIWyVIrT6CVEcjZHrfnPRuuC3d9z+tZFMRBZm+AEkHtJSMjpb
X-Google-Smtp-Source: AGHT+IEETisqF8AasMqCEUvxhtG5T7JwD3BrHas/WSaIXmjat8emY/K+TY8RKhes7qhIA0B+W/k69A==
X-Received: by 2002:a05:6602:1493:b0:807:4340:947e with SMTP id ca18e2360f4ac-816c4a15d70mr32237839f.15.1721156325487;
        Tue, 16 Jul 2024 11:58:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 16/54] selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
Date: Tue, 16 Jul 2024 12:57:28 -0600
Message-ID: <20240716185806.1572048-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a selftest script for dynamic-debug.  The config requires
CONFIG_TEST_DYNAMIC_DEBUG=m (and CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m),
which tacitly requires either CONFIG_DYNAMIC_DEBUG=y or
CONFIG_DYNAMIC_DEBUG_CORE=y

ATM this has just basic_tests(), it modifies pr_debug flags in a few
builtins (init/main, params), counts the callsite flags changed, and
verifies against expected values.

This is backported from another feature branch; the support-fns (thx
Lukas) have unused features at the moment, they'll get used shortly.

The script enables simple virtme-ng testing:

  $> vng --verbose --name v6.8-32-g30d431000676 --user root \
     --cwd ../.. -a dynamic_debug.verbose=2 -p 4 \
     ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

virtme: waiting for virtiofsd to start
virtme: use 'microvm' QEMU architecture
...
[    4.136168] virtme-init: Setting hostname to v6.8-32-g30d431000676...
[    4.240874] virtme-init: starting script
test_dynamic_debug_submod not there
test_dynamic_debug not there
...
[    4.474435] virtme-init: script returned {0}
Powering off.
[    4.529318] ACPI: PM: Preparing to enter system sleep state S5
[    4.529991] kvm: exiting hardware virtualization
[    4.530428] reboot: Power down

And add dynamic_debug to TARGETS, so `make run_tests` sees it properly

for the impatient, set TARGETS explicitly:

bash-5.2# make TARGETS=dynamic_debug run_tests
make[1]: ...
TAP version 13
1..1
[   35.552922] dyndbg: read 3 bytes from userspace
[   35.553099] dyndbg: query 0: "=_" mod:*
[   35.553544] dyndbg: processed 1 queries, with 1778 matches, 0 errs
...

TLDR:

This selftest is slightly naive wrt the init state of call-site flags.

In particular, it fails if class'd pr_debugs have been set

  $ cat /etc/modprobe.d/drm-test.conf
  options drm dyndbg=class,DRM_UT_CORE,+mfslt%class,DRM_UT_KMS,+mf

By Contract, class'd pr_debugs are protected from alteration by
default (only by direct "class FOO" queries), so the "=_" logged above
(TAP version 13) cannot affect the DRM_UT_CORE,KMS pr_debugs.

These class'd flag-settings, added by modprobe, alter the counts of
flag-matching patterns, breaking the tests' expectations.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   2 +
 .../dynamic_debug/dyndbg_selftest.sh          | 231 ++++++++++++++++++
 5 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8312ea681f..a5197bac717f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7685,6 +7685,7 @@ S:	Maintained
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug*.c
+F:	tools/testing/selftest/dynamic_debug/*
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..1b4826d5d09c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -22,6 +22,7 @@ TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
 TARGETS += dt
+TARGETS += dynamic_debug
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += fchmodat2
diff --git a/tools/testing/selftests/dynamic_debug/Makefile b/tools/testing/selftests/dynamic_debug/Makefile
new file mode 100644
index 000000000000..6d06fa7f1040
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# borrowed from Makefile for user memory selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := dyndbg_selftest.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dynamic_debug/config b/tools/testing/selftests/dynamic_debug/config
new file mode 100644
index 000000000000..d080da571ac0
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/config
@@ -0,0 +1,2 @@
+CONFIG_TEST_DYNAMIC_DEBUG=m
+CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
new file mode 100755
index 000000000000..1be70af26a38
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -0,0 +1,231 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+V=${V:=0}  # invoke as V=1 $0  for global verbose
+RED="\033[0;31m"
+GREEN="\033[0;32m"
+YELLOW="\033[0;33m"
+BLUE="\033[0;34m"
+MAGENTA="\033[0;35m"
+CYAN="\033[0;36m"
+NC="\033[0;0m"
+error_msg=""
+
+function vx () {
+    echo $1 > /sys/module/dynamic_debug/parameters/verbose
+}
+
+function ddgrep () {
+    grep $1 /proc/dynamic_debug/control
+}
+
+function doprints () {
+    cat /sys/module/test_dynamic_debug/parameters/do_prints
+}
+
+function ddcmd () {
+    exp_exit_code=0
+    num_args=$#
+    if [ "${@:$#}" = "pass" ]; then
+	num_args=$#-1
+    elif [ "${@:$#}" = "fail" ]; then
+        num_args=$#-1
+	exp_exit_code=1
+    fi
+    args=${@:1:$num_args}
+    output=$((echo "$args" > /proc/dynamic_debug/control) 2>&1)
+    exit_code=$?
+    error_msg=$(echo $output | cut -d ":" -f 5 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function handle_exit_code() {
+    local exp_exit_code=0
+    [ $# == 4 ] && exp_exit_code=$4
+    if [ $3 -ne $exp_exit_code ]; then
+        echo -e "${RED}: $BASH_SOURCE:$1 $2() expected to exit with code $exp_exit_code"
+	[ $3 == 1 ] && echo "Error: '$error_msg'"
+        exit
+    fi
+}
+
+# $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
+# $2 - number of times the pattern passed in $1 is expected to match
+# $3 - optional can be set either to "-r" or "-v"
+#       "-r" means relaxed matching in this case pattern provided in $1 is passed
+#       as is without enclosing it with spaces
+#       "-v" prints matching lines
+# $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
+function check_match_ct {
+    pattern="\s$1\s"
+    exp_cnt=0
+
+    [ "$3" == "-r" ] && pattern="$1"
+    let cnt=$(ddgrep "$pattern" | wc -l)
+    if [ $V -eq 1 ] || [ "$3" == "-v" ] || [ "$4" == "-v" ]; then
+        echo -ne "${BLUE}" && ddgrep $pattern && echo -ne "${NC}"
+    fi
+    [ $# -gt 1 ] && exp_cnt=$2
+    if [ $cnt -ne $exp_cnt ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO check failed expected $exp_cnt on $1, got $cnt"
+        exit
+    else
+        echo ": $cnt matches on $1"
+    fi
+}
+
+# $1 - trace instance name
+# #2 - if > 0 then directory is expected to exist, if <= 0 then otherwise
+# $3 - "-v" for verbose
+function check_trace_instance_dir {
+    if [ -e /sys/kernel/tracing/instances/$1 ]; then
+        if [ "$3" == "-v" ] ; then
+            echo "ls -l /sys/kernel/tracing/instances/$1: "
+            ls -l /sys/kernel/tracing/instances/$1
+        fi
+	if [ $2 -le 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does exist"
+	    exit
+	fi
+    else
+	if [ $2 -gt 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does not exist"
+	    exit
+        fi
+    fi
+}
+
+function tmark {
+    echo $* > /sys/kernel/tracing/trace_marker
+}
+
+# $1 - trace instance name
+# $2 - line number
+# $3 - if > 0 then the instance is expected to be opened, otherwise
+# the instance is expected to be closed
+function check_trace_instance {
+    output=$(tail -n9 /proc/dynamic_debug/control | grep ": Opened trace instances" \
+	    | xargs -n1 | grep $1)
+    if [ "$output" != $1 ] && [ $3 -gt 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not opened"
+        exit
+    fi
+    if [ "$output" == $1 ] && [ $3 -le 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not closed"
+        exit
+    fi
+}
+
+function is_trace_instance_opened {
+    check_trace_instance $1 $BASH_LINENO 1
+}
+
+function is_trace_instance_closed {
+    check_trace_instance $1 $BASH_LINENO 0
+}
+
+# $1 - trace instance directory to delete
+# $2 - if > 0 then directory is expected to be deleted successfully, if <= 0 then otherwise
+function del_trace_instance_dir() {
+    exp_exit_code=1
+    [ $2 -gt 0 ] && exp_exit_code=0
+    output=$((rmdir /sys/kernel/debug/tracing/instances/$1) 2>&1)
+    exit_code=$?
+    error_msg=$(echo $output | cut -d ":" -f 3 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function error_log_ref {
+    # to show what I got
+    : echo "# error-log-ref: $1"
+    : echo cat \$2
+}
+
+function ifrmmod {
+    lsmod | grep $1 2>&1>/dev/null || echo $1 not there
+    lsmod | grep $1 2>&1>/dev/null && rmmod $1
+}
+
+# $1 - text to search for
+function search_trace() {
+    search_trace_name 0 1 $1
+}
+
+# $1 - trace instance name, 0 for global event trace
+# $2 - line number counting from the bottom
+# $3 - text to search for
+function search_trace_name() {
+	if [ "$1" = "0" ]; then
+	    buf=$(cat /sys/kernel/debug/tracing/trace)
+	    line=$(tail -$2 /sys/kernel/debug/tracing/trace | head -1 | sed -e 's/^[[:space:]]*//')
+	else
+	    buf=$(cat /sys/kernel/debug/tracing/instances/$1/trace)
+	    line=$(tail -$2 /sys/kernel/debug/tracing/instances/$1/trace | head -1 | \
+		   sed -e 's/^[[:space:]]*//')
+	fi
+	if [ $2 = 0 ]; then
+	    # whole-buf check
+	    output=$(echo $buf | grep "$3")
+	else
+	    output=$(echo $line | grep "$3")
+	fi
+	if [ "$output" = "" ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO search for '$3' failed \
+		    in line '$line' or '$buf'"
+	    exit
+	fi
+	if [ $V = 1 ]; then
+	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n$output \nin:${BLUE} $buf ${NC}"
+        fi
+}
+
+# $1 - error message to check
+function check_err_msg() {
+    if [ "$error_msg" != "$1" ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error message '$error_msg' \
+		does not match with '$1'"
+        exit
+    fi
+}
+
+function basic_tests {
+    echo -e "${GREEN}# BASIC_TESTS ${NC}"
+    ddcmd =_ # zero everything (except class'd sites)
+    check_match_ct =p 0
+    # there are several main's :-/
+    ddcmd module main file */module/main.c +p
+    check_match_ct =p 14
+    ddcmd =_
+    check_match_ct =p 0
+    # multi-cmd input, newline separated, with embedded comments
+    cat <<"EOF" > /proc/dynamic_debug/control
+      module main +mf                   # multi-query
+      module main file init/main.c +ml  # newline separated
+EOF
+    # the intersection of all those main's is hard to track/count
+    # esp when mixed with overlapping greps
+    check_match_ct =mf 21
+    check_match_ct =ml 0
+    check_match_ct =mfl 6
+    ddcmd =_
+}
+
+
+tests_list=(
+    basic_tests
+)
+
+# Run tests
+
+ifrmmod test_dynamic_debug_submod
+ifrmmod test_dynamic_debug
+
+for test in "${tests_list[@]}"
+do
+    $test
+    echo ""
+done
+echo -en "${GREEN}# Done on: "
+date
-- 
2.45.2


