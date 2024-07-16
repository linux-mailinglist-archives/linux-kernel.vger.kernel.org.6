Return-Path: <linux-kernel+bounces-254282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6B93316D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C9283ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37131A98F3;
	Tue, 16 Jul 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhA6KHh7"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB01A9085;
	Tue, 16 Jul 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156343; cv=none; b=nnDTOFZeOlDRHs5IZZZDteDSHqRp4UHWxgMbN6F7C26Vst6CVSXmndUBSi1OGiducPfhfS2vAf1wenQNew6Z7KoJ7dUt5M371TzpBbxH/C4DfcNCpMr6z2eRd1HqfhlKWGtPvOB/lL1ZBUPOVvKIzqySlBPVxP20t8y4t+0gLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156343; c=relaxed/simple;
	bh=hyHbJk6o2snR4KrsEWVQDXEtI57f/QBUmVmXmJ8RFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyLtj2MmumqLW1YWbVNHPFJGCtoP0xuwki6ERzurcCBf683fXpF1lTL1TOIADwvmUmymqUVlHlPRb8e53CmHN71nhgHrBBdmnGHGQQikXZOSYlHfqCrPBzYUKKPicw9B3iMXahMADG+7PA3NEBeNo++Tn2A3zq6hgy0PcFA818s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhA6KHh7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f684af6af1so6704439f.2;
        Tue, 16 Jul 2024 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156341; x=1721761141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUz2fuyNm0/W+cer/IlT8tdUcSLjwR0swYFnYz1+7bA=;
        b=AhA6KHh7Dk/PC3xV4LMdVmJQhRdCc7Zt+OhmM51BC2yWMEYuCzJNcu7EsSqfWNI5WH
         GNK62rYakSjqJu7INr7qAtmP1+wHOcoWFsC1+whGsYvA3PYSgTU8+bUu9N/UcHb0g7kO
         dLjtDFK4QHzWeI9BHojWOiFw92dsHk8ODG+3XSFMOG7yRVyWWs7jBakrclEkyBTSQLgT
         Kcrk6MAFcA1/+Dz/U1q55d9AgBjlaSUgQKfLlnRmniwZagiKaLCNenL3LpEUZGp/WFIO
         RKwNgI9ZHvZoy8jyvjl/CF5tvpfc38+KdtMl5EjF2IQOknsC7pvtEERjpEB9o96WwhRs
         1DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156341; x=1721761141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUz2fuyNm0/W+cer/IlT8tdUcSLjwR0swYFnYz1+7bA=;
        b=ZzjAvPCqo+vGUCIHwNFvAJkFg0rIaPeCNzwmojhqmmYZbmb/EX4UKtSLwvWFrPYD2Z
         fQSno/KavGT8tKay2Q56ncN2RLvP0WH18IUjZnnrPZrgra5Oy8WwmnYQuQmUr3mm1CfS
         TLTU/eKsjDUvA4Z8E+IPN3o4DKfQlgZiIcdBEl+OVSC5gC/B6w2alAOGqiXtkI2qaQIH
         5PdoMMIUJSJb01lWa0dLW9fJzopV+Hf1UhIm9J1ajiHTUa127ehfkuv6Ef7y29tB0SUv
         CpuQKBLKdAwlsJsQdnTds/YIChFuBkdoxexAQHLqVlZSx4oQ/hiuF8v8FuwBjXf4XHOk
         8IFg==
X-Forwarded-Encrypted: i=1; AJvYcCUgfeakGxVWD63kH0cFiuro8kYYpzDSABix1izeqwjhHrJYW8ADTylzZO9Du+soKLVSdFIVcpMy+DPnF7XAc0ulGxxEh4nzmktm
X-Gm-Message-State: AOJu0YwubsH4bmKd/ejb4qSayfKYG1SKeXrzxAAD4xnahc6IV1NfwrRC
	aagJp45HvG3o9qUmrhZW9GR/kQvrRewf17+yZrJlPwvxijpgWC7EC2ASEOgN
X-Google-Smtp-Source: AGHT+IF4Unf7gwTLxZgnHey2dXasTlyxLHDEt1SBVRbfc0oATB2X5dpSsvnnnOAQb/XIyfd8CFvaag==
X-Received: by 2002:a05:6602:3c6:b0:7f6:1cd3:9659 with SMTP id ca18e2360f4ac-816c4c041ecmr47881339f.6.1721156341182;
        Tue, 16 Jul 2024 11:59:01 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:00 -0700 (PDT)
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
Subject: [PATCH v9-resend 28/54] dyndbg-selftest: reduce default verbosity
Date: Tue, 16 Jul 2024 12:57:40 -0600
Message-ID: <20240716185806.1572048-29-jim.cromie@gmail.com>
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

Remove the '-v' arg from the tests in test_mod_submod().
Setting V=1 in the environment turns it back on, for all tests.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index d09ef26b2308..b3d7155cb45c 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -168,7 +168,6 @@ function error_log_ref {
 }
 
 function ifrmmod {
-    lsmod | grep $1 2>&1>/dev/null || echo $1 not there
     lsmod | grep $1 2>&1>/dev/null && rmmod $1
 }
 
@@ -316,13 +315,13 @@ function test_mod_submod {
 
     # change classes again, this time submod too
     ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
-    check_match_ct =pmf 1 -v
-    check_match_ct =plt 1 -v
-    check_match_ct =pml 1 -v
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
     #  submod changed too
-    check_match_ct =mf 1 -v
-    check_match_ct =lt 1 -v
-    check_match_ct =ml 1 -v
+    check_match_ct =mf 1
+    check_match_ct =lt 1
+    check_match_ct =ml 1
 
     # now work the classmap-params
     # fresh start, to clear all above flags (test-fn limits)
@@ -333,25 +332,25 @@ function test_mod_submod {
     echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
     echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
     # 2 mods * ( V1-3 + D2_CORE )
-    check_match_ct =p 8 -v
+    check_match_ct =p 8
     echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
     echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
     # 2 mods * ( D2_CORE, D2_DRIVER )
-    check_match_ct =p 4 -v
+    check_match_ct =p 4
     echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
     echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
     # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
-    check_match_ct =p 6 -v
+    check_match_ct =p 6
 
     # recap DRM_USE_DYNAMIC_DEBUG regression
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
     # set super-mod params
     modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
-    check_match_ct =p 7 -v
+    check_match_ct =p 7
     modprobe test_dynamic_debug_submod
     # see them picked up by submod
-    check_match_ct =p 14 -v
+    check_match_ct =p 14
 }
 
 tests_list=(
-- 
2.45.2


