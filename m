Return-Path: <linux-kernel+bounces-368103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DA9A0B39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B81C21922
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31088209F22;
	Wed, 16 Oct 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJv6AZ6C"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35520ADDA;
	Wed, 16 Oct 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084701; cv=none; b=k2FGyPdLhNelC+NM9msINZ1YZr/Asol4m301nyK6hLrq4og4/hWlYbhiaGL6is0CMfSaDqS8zVsNOzwfT+zjjqIsJZZDqVcFYOQEVxty9N/q257TmoejZpfk/UBcwobsaDLUorDhZwYgxMRqbuisv+VzrtkwiRObstInnOLX2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084701; c=relaxed/simple;
	bh=3nJnFVnwR+L3Z18DYoST7sOHYfHg//9WUdBRCtPPyWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiwkgVbygaEt1bth4qZccIW73y6SrJoFze7zbFgsHUkR6ywnKvJzNFm9AnPeTPnbVsZZu1ErQYwb4sappFwcNc8Dic+eyRjxxjE8yWEsxr75xU833cO+7fs/AcFs27Qjp6hnuO+PkbZbHo7wBql16ZftB6uRWjS0skTlRsKSRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJv6AZ6C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314311959aso14595265e9.1;
        Wed, 16 Oct 2024 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084698; x=1729689498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8xPPGnp2eNdFzyDsH77udpuxb5hGHHiKYVsaBBQcww=;
        b=dJv6AZ6C+50MKDw33WRDZu5TNWmQhc7BCQQQrUEAx/1SniRVEAw7nAagPv1849n5V/
         llyhkBYgpO8uTwbILkH9iteOSaW+4lZtZ0jER4dfCf+9NuMUNnbBAoeORRdQm7872IWB
         LfCrNuWsc0NsKQP2t0lNHFgZe3Nnxm42DK4ZHmsMejGp8rn/W32bqr77xINBa/p0f0jI
         APCOC0oKNjVsAMsnxBhE5H4G2UUWbhzTnzS9FqVd9ubSmOrFX1nYkZtGZl9oFbs1EzKq
         th5v9THksMR4e508qC9l+eQW/TvfAZtn6U/Ecjenm76jDzPNbZHqQdLIxZ/yM3uh50Ic
         xzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084698; x=1729689498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8xPPGnp2eNdFzyDsH77udpuxb5hGHHiKYVsaBBQcww=;
        b=h+P59+V2XJ2TwMZXZHywsl3A36VHsv2ma5dX/9fM+HdfCh8w2GLFP8R3635MXu+U1z
         HqUEr1XwUhLS+2ZeVQaA2BHHzeKE/bVpRE/LUbl7Eha9T1VIjPRvkZxV6kvP64ncuRHL
         YGG2/O+YEUEvP5xmrlccd5R0Aj+1ybFtYpQ30MRe1ElSR02Kop5NrwtxJQhPMf3R1FKd
         98JQ1IjJEM8/mBxyT/HoFFUideTjyO/UCk/LGINgrBxMR4rMjcAbC+Oa2gf+plw+H9EX
         wpQQfqAMx/WAiXVSy79TOqaYHXjzQiXPsm9oMPaLU01MeeUHwZYDxb4x+r20I3aNM5ES
         vi+w==
X-Forwarded-Encrypted: i=1; AJvYcCUHSXMuzjThKTwzYudlj1ifHMM7Hge5L68Xm2WTD2DPBzAe8BRlGO/q0xlXucx2+GXFlkauIFKuFLlvgsfE@vger.kernel.org, AJvYcCUMg/nTpMR0bgA0IvgjB4wraPKa8vG2ccfPGu8oM9MhP60VUFwhrz0P3+DqSywW5txFvcRc61sbHzk=@vger.kernel.org, AJvYcCViuOpjKX6wpILhhkeV+saCOnLsBixXx1S36iLfzQMaZA+T18U1Y2DFbZjkiZXvyss6a4fXgceVgteF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VM8FCdegaTwr/aAnCwppPJhLCx36+de2y+He7eJ5hvtpP1Fm
	4DaNByQ1vGyANjvc8UynY/Hg1R6XLfN4SQ6uep6Qp9rte8JQO5Ac
X-Google-Smtp-Source: AGHT+IH3FuLlFjmqTs3wizKlwLXV6vFTExlSBMXK4B6QAGh74FnpgDABFCIjNm+jC+pHYvNYiZORlg==
X-Received: by 2002:a05:600c:4fd3:b0:431:5503:43ca with SMTP id 5b1f17b1804b1-43155035333mr7296085e9.28.1729084697677;
        Wed, 16 Oct 2024 06:18:17 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5698aesm49612825e9.11.2024.10.16.06.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:18:17 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: 2023002089@link.tyut.edu.cn,
	akpm@linux-foundation.org,
	alexs@kernel.org,
	corbet@lwn.net,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	siyanteng@loongson.cn,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	workflows@vger.kernel.org
Subject: [PATCH v4 2/3] kasan: migrate copy_user_test to kunit
Date: Wed, 16 Oct 2024 18:18:01 +0500
Message-Id: <20241016131802.3115788-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016131802.3115788-1-snovitoll@gmail.com>
References: <CA+fCnZf8YRH=gkmwU8enMLnGi7hHfVP4DSE2TLrmmVsHT10wRQ@mail.gmail.com>
 <20241016131802.3115788-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate the copy_user_test to the KUnit framework to verify out-of-bound
detection via KASAN reports in copy_from_user(), copy_to_user() and
their static functions.

This is the last migrated test in kasan_test_module.c, therefore delete
the file.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes v2 -> v3:
- added a long string in usermem for strncpy_from_user. Suggested by Andrey.
---
 mm/kasan/Makefile            |  2 -
 mm/kasan/kasan_test_c.c      | 47 +++++++++++++++++++++
 mm/kasan/kasan_test_module.c | 81 ------------------------------------
 3 files changed, 47 insertions(+), 83 deletions(-)
 delete mode 100644 mm/kasan/kasan_test_module.c

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index b88543e5c0c..1a958e7c8a4 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -46,7 +46,6 @@ endif
 
 CFLAGS_kasan_test_c.o := $(CFLAGS_KASAN_TEST)
 RUSTFLAGS_kasan_test_rust.o := $(RUSTFLAGS_KASAN)
-CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
 
 obj-y := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
@@ -59,4 +58,3 @@ ifdef CONFIG_RUST
 endif
 
 obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_test.o
-obj-$(CONFIG_KASAN_MODULE_TEST) += kasan_test_module.o
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9..382bc64e42d 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,6 +1954,52 @@ static void rust_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
 }
 
+static void copy_user_test_oob(struct kunit *test)
+{
+	char *kmem;
+	char __user *usermem;
+	unsigned long useraddr;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
+	int __maybe_unused unused;
+
+	kmem = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kmem);
+
+	useraddr = kunit_vm_mmap(test, NULL, 0, PAGE_SIZE,
+					PROT_READ | PROT_WRITE | PROT_EXEC,
+					MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	KUNIT_ASSERT_NE_MSG(test, useraddr, 0,
+		"Could not create userspace mm");
+	KUNIT_ASSERT_LT_MSG(test, useraddr, (unsigned long)TASK_SIZE,
+		"Failed to allocate user memory");
+
+	OPTIMIZER_HIDE_VAR(size);
+	usermem = (char __user *)useraddr;
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = copy_from_user(kmem, usermem, size + 1));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = copy_to_user(usermem, kmem, size + 1));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = __copy_from_user(kmem, usermem, size + 1));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = __copy_to_user(usermem, kmem, size + 1));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = __copy_from_user_inatomic(kmem, usermem, size + 1));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = __copy_to_user_inatomic(usermem, kmem, size + 1));
+
+	/*
+	* Prepare a long string in usermem to avoid the strncpy_from_user test
+	* bailing out on '\0' before it reaches out-of-bounds.
+	*/
+	memset(kmem, 'a', size);
+	KUNIT_EXPECT_EQ(test, copy_to_user(usermem, kmem, size), 0);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = strncpy_from_user(kmem, usermem, size + 1));
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2028,6 +2074,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
 	KUNIT_CASE(rust_uaf),
+	KUNIT_CASE(copy_user_test_oob),
 	{}
 };
 
diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
deleted file mode 100644
index 27ec22767e4..00000000000
--- a/mm/kasan/kasan_test_module.c
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- * Copyright (c) 2014 Samsung Electronics Co., Ltd.
- * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
- */
-
-#define pr_fmt(fmt) "kasan: test: " fmt
-
-#include <linux/mman.h>
-#include <linux/module.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-
-#include "kasan.h"
-
-static noinline void __init copy_user_test(void)
-{
-	char *kmem;
-	char __user *usermem;
-	size_t size = 128 - KASAN_GRANULE_SIZE;
-	int __maybe_unused unused;
-
-	kmem = kmalloc(size, GFP_KERNEL);
-	if (!kmem)
-		return;
-
-	usermem = (char __user *)vm_mmap(NULL, 0, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE | PROT_EXEC,
-			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-	if (IS_ERR(usermem)) {
-		pr_err("Failed to allocate user memory\n");
-		kfree(kmem);
-		return;
-	}
-
-	OPTIMIZER_HIDE_VAR(size);
-
-	pr_info("out-of-bounds in copy_from_user()\n");
-	unused = copy_from_user(kmem, usermem, size + 1);
-
-	pr_info("out-of-bounds in copy_to_user()\n");
-	unused = copy_to_user(usermem, kmem, size + 1);
-
-	pr_info("out-of-bounds in __copy_from_user()\n");
-	unused = __copy_from_user(kmem, usermem, size + 1);
-
-	pr_info("out-of-bounds in __copy_to_user()\n");
-	unused = __copy_to_user(usermem, kmem, size + 1);
-
-	pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
-	unused = __copy_from_user_inatomic(kmem, usermem, size + 1);
-
-	pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
-	unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
-
-	pr_info("out-of-bounds in strncpy_from_user()\n");
-	unused = strncpy_from_user(kmem, usermem, size + 1);
-
-	vm_munmap((unsigned long)usermem, PAGE_SIZE);
-	kfree(kmem);
-}
-
-static int __init kasan_test_module_init(void)
-{
-	/*
-	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
-	 * report the first detected bug and panic the kernel if panic_on_warn
-	 * is enabled.
-	 */
-	bool multishot = kasan_save_enable_multi_shot();
-
-	copy_user_test();
-
-	kasan_restore_multi_shot(multishot);
-	return -EAGAIN;
-}
-
-module_init(kasan_test_module_init);
-MODULE_LICENSE("GPL");
-- 
2.34.1


