Return-Path: <linux-kernel+bounces-317650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F096E173
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD225287F70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26331714BC;
	Thu,  5 Sep 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQQ5DJfv"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA0748F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559358; cv=none; b=rmA6MQ2lk/KjFnVFqkVTu3wKLYGKfN0ZaYRvg9HH5yTvXWP1TIulfxagLIIth2+n5zTG7E8K0HClqw++aLj5XsZO4wyEPwMOT9P1+dpekCYaN7YU/fIFrD87RZePT1rSoWePIdTGKuqdYc9F2QgAxHzVgAhtqICayOke7mEDox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559358; c=relaxed/simple;
	bh=c+hUATrufVSIL/JQLMUihzPOI7uEoWoqXiWz7naeVAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JjSmD2Dw0zcwrncKGWtPHJoUD7syWOXiYujUtLKWpWYd6jPQdW1WfK1HyBAltZei3aEfMGt37XYtWCJUh7dyY/qKsq7P6aH4lfcRkCcWS67GgaJUwyEFkZ0+UMZa5S6fcZQuMjUsrrKjkngK90Wl1Ax9S6cpk7QjGx1dtXXZO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQQ5DJfv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so912594b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725559355; x=1726164155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoGES1YpvJ5nBfBcX7roaXp3pwydYetkTgC+UcIGmPU=;
        b=GQQ5DJfv97J0NxoELw4SCGFW/pP9GgOm2H3OTpaJPSkg2PDfq4AT5rz/MkVrAO9y5c
         GorM2IsiIiqlzefBtx2cRUitpjc02T6Me3qqrcnXxLie8B4NrDmWrBSfRmkaqvaNrn1W
         yoz+lju13ZoPL53Q9caMOSyvU4GISFPvDPNTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559355; x=1726164155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoGES1YpvJ5nBfBcX7roaXp3pwydYetkTgC+UcIGmPU=;
        b=JqhbeCu2/kT7rcdsxBkpTSjW211aylC7QgF4BOn7oPxO6KnwJEvXctF5kuRD2SHKbv
         4FSfXWnz2cODRe//H0dTs3E/F+m+ZhgW/iNBWhLjCxHlKMz8ucBdzzY2d2tdxBZNSY2C
         HHPka6mtb/bI6jvhN4KD16vZshXYC3LkuIQmybQfuMzxLIEojuQyacwW3ame+KOBlftX
         xstEfouUrznhgaRdJXOcLUTxFr0DRA9MHLvE512ZtKjpuTysmSfv4r0aEj2aP/FY/oEp
         PNM1sfnRAq8z3+0NPU/qvyfQBweHwaH1A5mq8B21GNuMb/YtONufP7LCFjA0ugXdypsa
         +80A==
X-Forwarded-Encrypted: i=1; AJvYcCUFxu0cVAwhaXxh9vd8paVkifMGc5M02fEquI6/Ww0bQQpJ4chtAH20DwQNMUuZrzVqv5YNIpcHq9LZLEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHfF+3SNhWkNDW0/VqOGSLdSP5h6YEN2KU4A+VuHE8GowrgfX
	QmDlXrAGePtr2WZxEQPUDhkeuos35iCNZ+BmaH/dRT3hfCM/12ZAE1vpqTEY6U8=
X-Google-Smtp-Source: AGHT+IHz5NeNHP3/EHb0dJvhP/OuhLXZQ+bmPFUYBO+MeLL43tewTI4Oz91ohUAJCAtuEh1AFicZNA==
X-Received: by 2002:a17:903:188:b0:202:4047:e419 with SMTP id d9443c01a7336-205841a5f3bmr171050145ad.25.1725559354286;
        Thu, 05 Sep 2024 11:02:34 -0700 (PDT)
Received: from shuah-tx13.internal ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee8e01sm3673555173.172.2024.09.05.11.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:02:33 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	ilpo.jarvinen@linux.intel.com,
	usama.anjum@collabora.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests:resctrl: Fix build failure on archs without __cpuid_count()
Date: Thu,  5 Sep 2024 12:02:31 -0600
Message-Id: <20240905180231.20920-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When resctrl is built on architectures without __cpuid_count()
support, build fails. resctrl uses __cpuid_count() defined in
kselftest.h.

Even though the problem is seen while building resctrl on aarch64,
this error can be seen on any platform that doesn't support CPUID.

CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
will fail to build on all other architectures.

All others tests call __cpuid_count() do so from x86/x86_64 code paths
when _i386__ or __x86_64__ are defined. resctrl is an exception.

Fix the problem by defining __cpuid_count() only when __i386__ or
__x86_64__ are defined in kselftest.h and changing resctrl to call
__cpuid_count() only when __i386__ or __x86_64__ are defined.

In file included from resctrl.h:24,
                 from cat_test.c:11:
In function ‘arch_supports_noncont_cat’,
    inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
../kselftest.h:74:9: error: impossible constraint in ‘asm’
   74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
      |         ^~~~~~~
cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
  304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~
../kselftest.h:74:9: error: impossible constraint in ‘asm’
   74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
      |         ^~~~~~~
cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
  306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest.h        | 2 ++
 tools/testing/selftests/resctrl/cat_test.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8967b6e29d5..e195ec156859 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -61,6 +61,7 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
 /*
  * gcc cpuid.h provides __cpuid_count() since v4.4.
  * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
@@ -75,6 +76,7 @@
 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
 			      : "0" (level), "2" (count))
 #endif
+#endif /* end arch */
 
 /* define kselftest exit codes */
 #define KSFT_PASS  0
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 742782438ca3..ae3f0fa5390b 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
-	unsigned int eax, ebx, ecx, edx;
-
 	/* AMD always supports non-contiguous CBM. */
 	if (get_vendor() == ARCH_AMD)
 		return true;
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	unsigned int eax, ebx, ecx, edx;
 	/* Intel support for non-contiguous CBM needs to be discovered. */
 	if (!strcmp(test->resource, "L3"))
 		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
@@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 		return false;
 
 	return ((ecx >> 3) & 1);
+#endif /* end arch */
+	return false;
 }
 
 static int noncont_cat_run_test(const struct resctrl_test *test,
-- 
2.40.1


