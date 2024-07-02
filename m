Return-Path: <linux-kernel+bounces-238449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72A924B15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB37287FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530817DA15;
	Tue,  2 Jul 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg4EIwOC"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A6191F60
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957530; cv=none; b=GSB4l1lkYTzteoMba3CNitZc1SwHOlZTOEpv7RzdY0yOyzucVKoyidB9X3X1LhT15QFl6F2RBv/kUPMlJ2nPscgZlJPTft4+Qbdi6se9ge+eFVElczoELfniqde+aiLt/3eTz62LlcSaiKN7t5MlQSGmFBId9cyt/QstWMgu1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957530; c=relaxed/simple;
	bh=hyHbJk6o2snR4KrsEWVQDXEtI57f/QBUmVmXmJ8RFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFMuW6cW2yJb1x/lkEO+0B2Lbe2QuOxYRjiRoeUCVXEhkqFkZx0sPIkX0o+lyvNba3eSsRB9+iuMeIG7jBEYjGXeNTtrrlE24dWXvicclk2oRUlhm8hi7DaI0YA7be5c3eUqV5+V2GMLfvaqPpwVRo9ToqP9qnPw+sP0Ys6LuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg4EIwOC; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7eee7728b00so189222439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957528; x=1720562328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUz2fuyNm0/W+cer/IlT8tdUcSLjwR0swYFnYz1+7bA=;
        b=Bg4EIwOCbUgR+Z2uI7WAWdAhf+ETyTXCu1Oj10Jro0RvFBGzsbKEOdJ2U3qvIwXz3c
         f4S+PvdDr/NwPPRf9IJv9ck1LlI6pDPi1pQ6smomzujilUmLmTKuySMFaVwF44ZF6VFr
         A7pLP2S3uwDmz+3ZKk6kryxYSWyj5V02X9WcrOM8zLJhxS8YqgvZcYUYzul8nhBWIZsK
         fpRsWv/wffyew4AEr9FxzzaUT9wIXlNFnZZ0tZaJR2+KlTHHC+5V7Ak2n+pSxTm25VH8
         DR9ZwOvTOjw9oOV2PbgP6TwHpzhX5oRGzsq1D3T59eDvxaE4prGJeeVqGrw9eJFxXD1J
         iwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957528; x=1720562328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUz2fuyNm0/W+cer/IlT8tdUcSLjwR0swYFnYz1+7bA=;
        b=GX4sFVGoEd+LwU+BnVnoaQE35pUTS3A4u54uz4+f8ffpRizOkLmUpdCnD9GeOgXERl
         RbL+bFXBaiZgrmeyCFGZPsZ464uL6qsicFBCE8k/Ju3uWLiQtU09iLKWtZhtnzR4l27s
         Yz4EiykYLwH86/g6Q7obOmwo8InwgBmpVCUJcyAKMG9OipjryFclImy3THyQRQzxPtt6
         V6r8tptm/6ESl1BEqwMoOfsTS//6Us/yfWMch/C5z2s9eEtOUxIKSuwapasym7djaWYw
         vrTFWrqphp3OsQiJ0S539IR8Y5N7hLLBEXXdI5EbtUeA3nk+2w3s2IJ6cPhii/e0W2g8
         MpTg==
X-Gm-Message-State: AOJu0Yw8WVkZtaaK6MmUdDc0/HaumMotcPz4/68+k0mmKcxPxCy9ZUsL
	EDpoDxhqO7b02m5zoCrJ6/awi5eKr0kWIN4IQev7gwEIJUDsp9WL
X-Google-Smtp-Source: AGHT+IHBWcQbF7AzwbpraWmmrtlRBjOUVEzWk/QMFIDiv3bq2LCfSxlC7rVZKZrSP+Cf2khVoPBz0Q==
X-Received: by 2002:a5d:8453:0:b0:7f3:d649:9fff with SMTP id ca18e2360f4ac-7f62ed4c918mr1080653939f.0.1719957528255;
        Tue, 02 Jul 2024 14:58:48 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:47 -0700 (PDT)
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
Subject: [PATCH v9 28/52] dyndbg-selftest: reduce default verbosity
Date: Tue,  2 Jul 2024 15:57:18 -0600
Message-ID: <20240702215804.2201271-29-jim.cromie@gmail.com>
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


