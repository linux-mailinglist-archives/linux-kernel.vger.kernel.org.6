Return-Path: <linux-kernel+bounces-238445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A158924B11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53E9286FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A618DB1D;
	Tue,  2 Jul 2024 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjlces7C"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881518B440
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957526; cv=none; b=rIX5DJhbo7L9iwlt8yY0I/qD1qBxOl6yUqFDx1aDBJVQ8fYs8aY6DJGbVSJCdp+tKtj4HJ3mZ3DGELkuY/q7miVj949L0xDl9HBhW+F77x3ojwblaVVrryeCQy3InSVRPx2BxFCgYNDcksVP54heI/EUksRJ3Wp6Y7D06e3dZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957526; c=relaxed/simple;
	bh=kN/R7Fl1F1fcLv8VsLR2kYVGn+R+bGjHHORasn7sytk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY3hksE2v3nitmCevTjqxpeoS/KY64UUIoUd0G1ytUQEjQOLppaMmbabRrHXDRyyUF2obC1RuOlr1HrIyfG88Q6rhGc5emdJ8UyGxDOvZ83NIYVZDJZKyKaUFetlAAAaJCSyJFXiXXXsRcq3P5dYwQiZOHF3Nn0w6Y5z2zRj7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjlces7C; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f3cc78afb6so165123539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957524; x=1720562324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJdYoevwZB2aGfv474+weXhid0sQKo8sv3F+UqQdL9E=;
        b=Yjlces7CuTWkj2oVILF5DJhk5j57veL/Buf3ux70FlJDFiI3MQHBN1RNJD9xet866P
         KCCVfhOVKPyqoFXSKhi6Uh2L029bUT8p/VAQquBorbZUia624B56/Yk4Otw/6ZPrnngd
         sr8GzCfgzaSFJVjyWEd/WoQwu8HhFzkzWHMFxzLfew3+avOSEa3+/iEvM0+0dIDgNX8R
         6vUg1aKHw/pMd5haowayihPkwIqosnqtegyNVwAUOqMCTpxH6InfcL5+xEEqVtGzlKeM
         nY2PEkaucACaS5unaOc+ziNvdc5gPQjWAP6tOq1RyPv3fm32+MQ4XTby5+SQ2cNZwjrQ
         ADug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957524; x=1720562324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJdYoevwZB2aGfv474+weXhid0sQKo8sv3F+UqQdL9E=;
        b=DJUh3RNS+fPvnOahOs9nOCBz376a6QJjiq6d6Yx05eTP3USeFEFYimoLNK7k82I25g
         tG8adsJYkmPvZrmIolGAb5gNQwyysAadcc3/FA/jlb6VRXG6+c868qCn+HVd4ybYxrMQ
         ipfaG3OpukuKxhNORdPGJdyeKXX0qujZtBBQRyU3YcJIvdOM4njMc3t5ZGAbbp9EI0sS
         CF/qpX7Ayvip3QgY0AHO3w8cdysUCwkD0II2Qu7r/pYQFdj81CNfYnxe2T360G7NhOyW
         DI9RpGypWRKzqwfaPM8S44bg34a9nxYOIpUo6nAf58aM/e56m4QhsB8TEAxJGN29/dQ8
         Bblg==
X-Gm-Message-State: AOJu0YzEW+VFbyGR/DRmxnv+D1nfCyU8vusX9XOWoV4NNRCMG+kxQVQ0
	LQrPjkBJRF3JJevGve1KrltiBYKqZMRedG2PAi0VERIgV5z71QKG
X-Google-Smtp-Source: AGHT+IEgboiDOACnMDW/LW0FiCtZfq/bakC9SgKt/T+YKx18pvft97POgcA+NAVH1NrTKBqUsmzF2g==
X-Received: by 2002:a5e:d606:0:b0:7eb:d640:274 with SMTP id ca18e2360f4ac-7f62ee622b1mr1057775039f.10.1719957524024;
        Tue, 02 Jul 2024 14:58:44 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:43 -0700 (PDT)
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
Subject: [PATCH v9 24/52] selftests-dyndbg: add test_mod_submod
Date: Tue,  2 Jul 2024 15:57:14 -0600
Message-ID: <20240702215804.2201271-25-jim.cromie@gmail.com>
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

This new test-fn runs 3 module/submodule modprobe scenarios, variously
using both the generic dyndbg=<queries> modprobe arg, and the
test-module's classmap-params to manipulate the test-mod*'s pr_debugs.
In all cases, the current flag-settings are counted and tested vs
expectations.

The 3rd scenario recapitulates the DRM_USE_DYNAMIC_DEBUG=y failure.

1. 2 modprobes (super then sub), with separate dyndbg=class-settings
   check module specific flag settings

2. modprobe submod, supermod is auto-loaded
   set supermod class-params
   check expected enablements in super & submod

3. modprobe super, with param=setting (like drm.debug=0x1ef)
   modprobe submod
   validate submod's class'd pr_debugs get properly enabled

The test uses multi-queries, with both commas and percents (to avoid
spaces and quoting).  This is the main reason the test wasn't earlier
in the patchset, closer to the classmap patches its validating.

With some tedium, the tests could be refactored to split out early
tests which avoid multi-cmds, and test only the class-params.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 996e6fdcfb52..fccd2012b548 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -246,10 +246,77 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug \
+	dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    modprobe test_dynamic_debug_submod
+    check_match_ct test_dynamic_debug_submod 23 -r
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct test_dynamic_debug 46 -r
+
+    # no enablements propagate here
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    # change classes again, this time submod too
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1 -v
+    check_match_ct =plt 1 -v
+    check_match_ct =pml 1 -v
+    #  submod changed too
+    check_match_ct =mf 1 -v
+    check_match_ct =lt 1 -v
+    check_match_ct =ml 1 -v
+
+    # now work the classmap-params
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    modprobe test_dynamic_debug_submod # get supermod too
+
+    echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( V1-3 + D2_CORE )
+    check_match_ct =p 8 -v
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4 -v
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6 -v
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7 -v
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14 -v
+}
+
 tests_list=(
     basic_tests
+    # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
+    test_mod_submod
 )
 
 # Run tests
-- 
2.45.2


