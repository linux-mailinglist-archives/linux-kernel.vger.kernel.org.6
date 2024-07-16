Return-Path: <linux-kernel+bounces-254281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5AE93316B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AEE280F78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E51A909A;
	Tue, 16 Jul 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBPrnUuG"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5691A83DF;
	Tue, 16 Jul 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156342; cv=none; b=HN5D1OjXXXaTJqHFrXqjpalW2xfHFT8uBkG1y+qCeceNK5XczPeyZmisDy7zA9/59zp0dKNvLm3dxrZ9gUAwyka3X/T41AftTo87T8LhFJVDjVLM1A1r6YWV6RHMtOF6NHR+Fbv6KEHK/OIkHLhmky8jlpksleLPZfW4vory5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156342; c=relaxed/simple;
	bh=ruM/z33ybyG4BT7EGafatX+PVpfZYy41EY6pGKapSCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEgrog49JwrbCboIrfmWcANisou93TsFGNt+FIw4ikLJ1+Sjf2K+MphLAFP11taCWZxFQKLe+PFiDVPD9KMib+fVUuobIW0enViFo78wTLZurL5CWMM/L9ja4RWr4gwD6ty9IxP+3vkYVbz/z5wb977n/DRhWlTbdAd8CDeJbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBPrnUuG; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-816d9285ebdso1242939f.0;
        Tue, 16 Jul 2024 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156339; x=1721761139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt92vv+l+QrwNWjlUzQRBip24zXOkaNnGwWlphVTLFQ=;
        b=HBPrnUuGTdKX/tKLv4f7UzJukIXOnJBS+Y0uz55iRdgNlvIyyQtgX3MqtsbKLekoEm
         Tjh3x/0nSdwWOTaDwKx2YiW1xbWRKgtDvTNQ+WI5PqWQ/jCY/O67Lne1Dj/GT60RKN4N
         ujekN7BpOhPThQAFBE9MEwtXqk4U2+c7DnUsbMHGYabOJTq0hGDHmpalsrKeoYBbgNQq
         o+o49TGOHYbAQDhAwuy7NrKM/8ONFbld87YYjwsToYVzee+b66i/Xwoo5/UN2M8QjCyT
         nI9+IjSb5iMzW/8e7LGAx5wW5LnSbSmjgKbBvq3w7SWd6bbcAV1o3/oDrIxgk4M7WeJM
         glbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156339; x=1721761139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt92vv+l+QrwNWjlUzQRBip24zXOkaNnGwWlphVTLFQ=;
        b=cGAM3mIpiRnefA3O7LYMjv4LZ2XYSla0Yjq+X5XbUPm+JWKOtRxm2FkCshZ6mvRio7
         X/aQcAWlOZs7INx953u8kdsFkz34EvqY/NWb92/+O0YlSDA/CdWM5mDm/02bkBGVlDnl
         VD55wvJBj4PJflV+xwBkwCS/Cb7pQKZKOO7+sfen5OANg9opFQe2g0skoSwACT35v0k0
         jPcLJYqrU66VMRImwXzqR5Rxi6FiwmRJDD47HrNPPWPu3FEzKXfg6sOL/vg80bAuAc/w
         FTe6gnEZbahyaz99BORp6w3+ssWJyvheFFpNatZEge6NJNBWSZqxdjypnipUu0SVzTOC
         Tjuw==
X-Forwarded-Encrypted: i=1; AJvYcCUNWBxDGqeEXVkJ7FlWJhu96u+LGZSN23MnEQ8VaipH8P1udMjJb24lLxalL1EruUUjyNr/BOtdMIWTL1R2Z3jjnbeO8UeCvN6M
X-Gm-Message-State: AOJu0Yw0bpxHf6qSpP62o6zI0HKqE+XekI1Zen6GmTuCK46xdbtKTbI+
	/XlkANlYj9fKF96ItLmubeQn53vXAgZnZ7yy5WyNFIpOpaZCDnbJMrftix7p
X-Google-Smtp-Source: AGHT+IESuQloCkkuiShxJ11MDx3bp9+KgwgbKFyqWB/fqDDPxPeZjdAkYWwkkPnxEDOpSZ924Swh/g==
X-Received: by 2002:a05:6602:26c1:b0:7fa:8178:d672 with SMTP id ca18e2360f4ac-816c2a1fd63mr53177739f.4.1721156339610;
        Tue, 16 Jul 2024 11:58:59 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:59 -0700 (PDT)
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
Subject: [PATCH v9-resend 27/54] selftests-dyndbg: check KCONFIG_CONFIG to avoid silly fails
Date: Tue, 16 Jul 2024 12:57:39 -0600
Message-ID: <20240716185806.1572048-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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


