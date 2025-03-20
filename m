Return-Path: <linux-kernel+bounces-570219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BFA6ADF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128DD4A13C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906B230BE6;
	Thu, 20 Mar 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNsWupFh"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010C23026C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496817; cv=none; b=IysJq/EBeOCP9R22DDfxW6Oq6B/6ZUcyrACkW460cQCXqh9Emzzw8kEqTDmIiU1eXw0BEeL8c04YWglw51FdbvkmrW31Ww7l8PSeSeilmDhBJ6IX/878kZfR+7pUVH4Dm4YwDoAxYff0cR+QcFzUuBXeEOMwi5m5tQtY6WRKEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496817; c=relaxed/simple;
	bh=zUYSWVbI/jO2yWMUF61GMoQxRdlb44fYpZGI20FCLcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTEQ0lKcLU7Kc/wAV07ECrUtICDxkMHD0Ub1wPPhI1hKVRakGuBDB3+N4qrCO4qOJpIxV7/CjX8RvDpsXrrrpV4f9R3taUaAYBT+3EeDWIbd1Fzh5iQKzoEPyGgw8w+BTx3Vn7Jrpt9GcxylkvB7mhLQHiaQtwm7VPQ0r5m6+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNsWupFh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85da5a36679so108949439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496815; x=1743101615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhXUt3GtFFD1CFOdu20/mAVQW9nyW0QG+7LpAH9FRGE=;
        b=QNsWupFhZ9Wh07XMtbN2bSnm7ZMg9i1HtfMh/hY9zrNO6nSNsdEUJceGZ8ghFjlWaK
         SLTbMmI5ERrjoPTlIOf7ceRCn09yGiFUGwbatdsWXzth+ik+4W7p3PHSV0P0vrgAXr/S
         ndqxfikdCNugZ4UdY1/D+WXn06OWiNR0wbbpjOph8NvbmC0i57CIq7MRZUGXuDGJFo/Y
         jlb/xK8UyOboxQm/9yznS70PqkB+7SgItbmHr064Blt3L/TzRVc7+ahc9V0nbxQtYQRB
         Fr088ZeJx2lG/KiB4YK8zW+bdoWzdz3pO5CufbbOxyIX+UuYMNIKFyP7AI5geamb1OD1
         8DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496815; x=1743101615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhXUt3GtFFD1CFOdu20/mAVQW9nyW0QG+7LpAH9FRGE=;
        b=BNgeCLNiYYwcKckNyTySNEQTaxTPpNiVugXWA3yVZ8tDSYZo/8yDUHHHl52J8f2lfB
         SZJ1JVxIaBrTV5h531qzzXcIOy0l2O2vK1hIaJoSpQ8futQJ9gBp5Py7Cc2bqtSb7uf9
         ObdW1yHc9V4kMKMWXinHF6h/qggUxu4ML4EyhyYu7nFlfJF2RkG/DRql0fQTirmn5qS/
         mLAQxpJFn0DdX8rTBSmPAYpfqqc1ESCDMN60/v6jVm50M7Zd727YUnbiXP6o/kRXacJT
         TAC/nbaGJ/TH9LsUoXE7AqsVpZ95TMM9Um6R/zH/n788ROwnP+uXgTFKJFtkJKk7TU3c
         sqVA==
X-Gm-Message-State: AOJu0Yynx4KoNBRrpjo9/YbuOATXIrJu0LZo1w/1mwtePyMHq/8wUxgB
	z/oqaXfMFZbB7xAUnLjOuCDvdZpJCXtwiDaTZMqno7MFpUwxfT6vEFLOs4gv
X-Gm-Gg: ASbGnctqhQRS7I8aMyvXh0sqE94jiTylePSCZiuzNsHMpw8rwsowV3SZ7X1BzPDhL9u
	bdEVfUrTjU1RoECLEQywrDK8vtLx00dQ4wATHbNymSK4PxUv4X1NgxIM+jVSWwNMe7n2Awsv1im
	Hwc2rl7QXRYTdyFuEaTPFlKLhD1Q9KY62JdRzebmMjyn6rIjIfa1v1eR7Pg5HkOYbl+N/GpXsWC
	RVmiodslNZ6NXssS811Od/hNCAkr6zvdpNS9apcy0+GP0yizNnQ58D89SL971oX+nGfjXLk4tLz
	PpytdW3WQPlujAuBJxKYMMOO8KKzuU2MtvQEWejIzv3i/hF3m9jJwhva2rDdy/JDyLYNCDVyaro
	8Ag==
X-Google-Smtp-Source: AGHT+IGUwJQCCV968viXZ2uAEZ46zasZ2WEK6BntArAqyb8MVxwaNX2kU6atjh/Jnd/hczHfTieubw==
X-Received: by 2002:a05:6602:4742:b0:85d:9a7a:8169 with SMTP id ca18e2360f4ac-85e2c904c6dmr48741739f.0.1742496815306;
        Thu, 20 Mar 2025 11:53:35 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 28/59] selftests-dyndbg: add test_mod_submod
Date: Thu, 20 Mar 2025 12:52:06 -0600
Message-ID: <20250320185238.447458-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
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
- drop -v used in test_mod_submod(). V=1 does it for whole test
- ifrmmod at test end (Lukasz)
---
 .../dynamic_debug/dyndbg_selftest.sh          | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c97c9391d0f4..cfed79b34996 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -275,10 +275,79 @@ function test_percent_splitting {
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
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    #  submod changed too
+    check_match_ct =mf 1
+    check_match_ct =lt 1
+    check_match_ct =ml 1
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
+    check_match_ct =p 8
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
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
2.49.0


