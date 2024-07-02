Return-Path: <linux-kernel+bounces-238448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B68924B14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA451C22B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DA191F8C;
	Tue,  2 Jul 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duWbtE5O"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9B18DB31
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957529; cv=none; b=BGAyJEZmRyCWRyUaeOiq8vB+w20DgKjRAcJS8oGWI+CVFHOQGqCPMG5uKC0GGun4PneCiFVbAkLoIEoBTmrYKRBFYTN7OgmusQe+ydAR4vtFhPSuuRq4TZXBrRc2cUnPs98diFzdunqk0OcBDFdEXNjPBg0E4Q7xC9DP5+Inarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957529; c=relaxed/simple;
	bh=ruM/z33ybyG4BT7EGafatX+PVpfZYy41EY6pGKapSCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3SczcwpGErv5CX7rxKjzbEYCkTL+5CGfIcXI3lqkYXfSbdoT3zgaTKBAL8mUwDon6FsqHK+WTvSiwBuEve+L5bzlKkHrO8vdPHTWzcPSpPrblDZ90c3sZ2X4WS+yPw7zNCZD6DMygMOsp6yIT4gIkPcR+OoptKNr7+2zQ64F8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duWbtE5O; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f63db7a69cso142342639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957527; x=1720562327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt92vv+l+QrwNWjlUzQRBip24zXOkaNnGwWlphVTLFQ=;
        b=duWbtE5OIn/38AMUZrLNRaW1P8wd/508o+V0Vo1VymiHl2sg1czQ2p0VPfUQ1qUQ7H
         Xj/RgPwv6WQXIobXYe17TeFOC81HeqJeIlBvoZEegqJS2CsoqA/Himp4g1zY7HMmpzaW
         aNN3/G7O07lvjGYWRQM7r7mll627PpCykmxQIcxWbH4DhrLQFcVrcSSyV5dElStsblw/
         EIB1S0tqPdt2zW0xp07Wh4gNRDaz1qUUPhI4xYM3WbrgMUYhYryXgK00nKhjr0yy5Az7
         hAQlAxlyv/VBQjbAdYCOFRpMhIhz6oF/rUepc8rECB9yQql0BpL5njNI54taMjqrsjgR
         ihdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957527; x=1720562327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt92vv+l+QrwNWjlUzQRBip24zXOkaNnGwWlphVTLFQ=;
        b=e9MI0Cx0pRBdkt+oa60/NnzhqfFLzHmiscyTYmIjGSAxR8z+9MlYWj996P4gev8LEv
         tSgBvTgH1MrTh6x+mmOAptsmWz2UZ2P006lNyExurf1UueIsIeZG3om/Uuy5emC7ET9c
         /R4uXHpG/MwC2SL1UFFkuDuPpIFGl7o2rImcBRmD3v1ogK+2XM0iiPsPt+AnO3Gw+enR
         MlZJfUWqAkEAz2fXQwQQBhpKGng5W/5qobp8WtVWA0uvgd2FZmggyJdQCt8w5vYOUZKo
         EaeyyJywr+eWRtAOT1skEisQx2gg5PaV96pdSSNYYS3N+AZL8DDQGK0sV8gTjiFf/bGJ
         M3ZA==
X-Gm-Message-State: AOJu0YyJrnFwyc/3G79p2WG0I6XJXqZBExnZkuy1/YohvGSiM5i0BN39
	T1a+phC0Fp8Q54NGb7nFih7bPwTiAojfwhVV/HGWAGfiB0qgyEPg
X-Google-Smtp-Source: AGHT+IF3h87zduF7F4ddnH2q9ze+NFD9i3fNyFNxg/0ttCijjGWkOENGZRuQmey084nqd6Ft/oa1CQ==
X-Received: by 2002:a5e:de4c:0:b0:7f6:20dd:7117 with SMTP id ca18e2360f4ac-7f62ed4675fmr1103892639f.0.1719957527247;
        Tue, 02 Jul 2024 14:58:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:46 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 27/52] selftests-dyndbg: check KCONFIG_CONFIG to avoid silly fails
Date: Tue,  2 Jul 2024 15:57:17 -0600
Message-ID: <20240702215804.2201271-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tests are dependent upon config choices. Lets avoid failing
where that is noise.

The KCONFIG_CONFIG var exists to convey the config-file around.  If
the var names a file, read it and extract the relevant CONFIG items,
and use them to skip the dependent tests, thus avoiding the fails that
would follow, and the disruption to whatever CI is running these
selftests.

If the envar doesn't name a config-file, ".config" is assumed.

CONFIG_DYNAMIC_DEBUG=y:

basic-tests() and comma-terminator-tests() test for the presence of
the builtin pr_debugs in module/main.c, which I deemed stable and
therefore safe to count.  That said, the test fails if only
CONFIG_DYNAMIC_DEBUG_CORE=y is set.  It could be rewritten to test
against test-dynamic-debug.ko, but that just trades one config
dependence for another.

CONFIG_TEST_DYNAMIC_DEBUG=m

As written, test_percent_splitting() modprobes test_dynamic_debug,
enables several classes, and count them.  It could be re-written to
work for the builtin module also, but builtin test modules are not a
common or desirable build/config.

CONFIG_TEST_DYNAMIC_DEBUG=m && CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m

test_mod_submod() recaps the bug found in DRM-CI where drivers werent
enabled by drm.debug=<bits>.  It modprobes both test_dynamic_debug &
test_dynamic_debug_submod, so it depends on a loadable modules config.

It could be rewritten to work in a builtin parent config; DRM=y is
common enough to be pertinent, but testing that config also wouldn't
really test anything more fully than all-loadable modules, since they
default together.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

fixup-kconfig
---
 .../dynamic_debug/dyndbg_selftest.sh          | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index fccd2012b548..d09ef26b2308 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -11,6 +11,30 @@ CYAN="\033[0;36m"
 NC="\033[0;0m"
 error_msg=""
 
+[ -e /proc/dynamic_debug/control ] || {
+    echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=y ${NC}"
+    exit 0 # nothing to test here, no good reason to fail.
+}
+
+# need info to avoid failures due to untestable configs
+
+[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=".config"
+if [ -f "$KCONFIG_CONFIG" ]; then
+    echo "# consulting KCONFIG_CONFIG: $KCONFIG_CONFIG"
+    grep -q "CONFIG_DYNAMIC_DEBUG=y" $KCONFIG_CONFIG ; LACK_DD_BUILTIN=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG=m" $KCONFIG_CONFIG ; LACK_TMOD=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m" $KCONFIG_CONFIG ; LACK_TMOD_SUBMOD=$?
+    if [ $V -eq 1 ]; then
+	echo LACK_DD_BUILTIN: $LACK_DD_BUILTIN
+	echo LACK_TMOD: $LACK_TMOD
+	echo LACK_TMOD_SUBMOD: $LACK_TMOD_SUBMOD
+    fi
+else
+    LACK_DD_BUILTIN=0
+    LACK_TMOD=0
+    LACK_TMOD_SUBMOD=0
+fi
+
 function vx () {
     echo $1 > /sys/module/dynamic_debug/parameters/verbose
 }
@@ -192,6 +216,10 @@ function check_err_msg() {
 
 function basic_tests {
     echo -e "${GREEN}# BASIC_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
     ddcmd =_ # zero everything (except class'd sites)
     check_match_ct =p 0
     # there are several main's :-/
@@ -214,6 +242,10 @@ EOF
 
 function comma_terminator_tests {
     echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
     # try combos of spaces & commas
     check_match_ct '\[params\]' 4 -r
     ddcmd module,params,=_		# commas as spaces
@@ -226,9 +258,12 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
-    
 function test_percent_splitting {
     echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
     ddcmd =_
@@ -248,6 +283,14 @@ function test_percent_splitting {
 
 function test_mod_submod {
     echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
+    if [ $LACK_TMOD_SUBMOD -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
     ddcmd =_
-- 
2.45.2


