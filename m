Return-Path: <linux-kernel+bounces-360639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87980999DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96961C221CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3C1EABDC;
	Fri, 11 Oct 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWAeYv/B"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7391BFDF7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630965; cv=none; b=YR4NhJscGs1MtPkBnNgkPkHnYmy/tB8uMcBjX1QvUN6KBH6BKDNCA3RPi2r1a4D7pCqgbdXCsKJHnitFJFE2SvNFfovfYfyv4yUvR2sHUDOHVuUATU2XkEuB4pZfbrPn66FlvSP9+1q5/QHMIIt68y04DJcTOP9jjAHxcdnOMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630965; c=relaxed/simple;
	bh=ep5Ousz4KUV7WjkypPanPqrD16iuYkSFF8WgIz6KeOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHVXV0Z9NWcMX4bsAzP2aLcVZNBT6H8jkDtuvZpG/HbhaaiEe9boZf4E4RMl904wLhIY67tFaDuz0xVWOJ2X+0t2n73WZ0lmpqt8Mj7o/Ra6WPrKkCh+nNkg+E/V88Pl9UBaXuHL2CnWtCAANEDmwbptWwcXPU4mN2wqZfXPtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWAeYv/B; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so26362441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728630961; x=1729235761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCjVoezSoJ9cXRJsoOufBJfIeNbu/4t5Ob362xE6LB4=;
        b=lWAeYv/BbqHHIp0mTjOcRgQAuRx9EGg6ZBzw3X8xl/c6jdgGUaC69PpTcwhuW3vQO+
         z2i/A50MlaNdnXYdv9ggg7T5Xp3de6QqLngUukdxxblHt0jKuLOsl+mwoB2zN/bBt8bt
         9/KzEUMb/bDQGI84YUMeCAKsTf9IkIOnjWyQfiNOVu5h6m6Bw0cMVr4+eOBiaKcGyxv4
         2men5+Yt5J1IP/jQG5x871qqMm4I8hRxQkg1yJPp2hpMaO7q65Uj/vlpyxycCTBAWgUh
         Q3hS7mLOwfIVGRr75RnHUXecb6Qe6uqRzNhiDASIfFCj1DL0dSWISJmdN7ttx9POmOHf
         tesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630961; x=1729235761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCjVoezSoJ9cXRJsoOufBJfIeNbu/4t5Ob362xE6LB4=;
        b=KEuKeSg1LHd8an2feBt/YzGnSCqQ5gf4n15G2SwklXQhx6LUfke6gyDo1Qk0wrwfnz
         pLey2MrblbHnLNE9UH9jf7ut6DtwEw21U0ICgviy9PQcTG0bfGJW/9OfHECS2/+uRLty
         D62xOAoZPLNGyvCilVItpaqwKmq45s6PjU2MfPuYSN9GeQlmzltLAokYJ4dV2V73SuKY
         2EcgOoFLw9/G/2aI36su8rar0tM6mL/QpYBH3rcw+h/lPf5GGK5HXk8NGW4BX43m8/RS
         F5oW9WDAnM+8M8F7NXi5G34Oa/uw0LoAYE4/l8cmG5SbOylgslzl3lBA42QnMbBMFwr4
         2z+g==
X-Forwarded-Encrypted: i=1; AJvYcCWxKa64EXwh9VMRfJJRFJZSUrLKXCrbkFQBn+rQIjoQ4aD8tB6cJRrXQS+orXoIeqKe4bV3SJxvQZiFrBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FfqE9D2tPQDkC5xbU+zhXSBpi1Le99rrd2Mm/Gim4UkAs2PY
	1zLSGrW9bbFn0/mqKIoimMlPnNIhGVaDFxFfCW83ktY3A2AyZy0d
X-Google-Smtp-Source: AGHT+IHGHEvUs3xWI1jtReT4fvaMSO60WKGEZ8r2YOVj6BQ+NL8Ck2EfTqsTW723edt2foFUb3OniA==
X-Received: by 2002:a05:6512:304c:b0:52f:36a:f929 with SMTP id 2adb3069b0e04-539c986474amr2004231e87.4.1728630960909;
        Fri, 11 Oct 2024 00:16:00 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ddf85cf4sm93946e87.68.2024.10.11.00.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:16:00 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: akpm@linux-foundation.org,
	ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com
Cc: glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH] kasan: migrate copy_user_test to kunit
Date: Fri, 11 Oct 2024 12:16:57 +0500
Message-Id: <20241011071657.3032690-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In order to detect OOB access in strncpy_from_user(), we need to move
kasan_check_write() to the function beginning to cover
if (can_do_masked_user_access()) {...} branch as well.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=212205
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 lib/strncpy_from_user.c      |  3 +-
 mm/kasan/kasan_test_c.c      | 39 +++++++++++++++++
 mm/kasan/kasan_test_module.c | 81 ------------------------------------
 3 files changed, 41 insertions(+), 82 deletions(-)
 delete mode 100644 mm/kasan/kasan_test_module.c

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 989a12a67872..55c33e4f3c70 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -120,6 +120,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	kasan_check_write(dst, count);
+
 	if (can_do_masked_user_access()) {
 		long retval;
 
@@ -142,7 +144,6 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		if (max > count)
 			max = count;
 
-		kasan_check_write(dst, count);
 		check_object_size(dst, count, false);
 		if (user_read_access_begin(src, max)) {
 			retval = do_strncpy_from_user(dst, src, count, max);
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..e71a16d0dfb9 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,6 +1954,44 @@ static void rust_uaf(struct kunit *test)
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
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		unused = strncpy_from_user(kmem, usermem, size + 1));
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2028,6 +2066,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
 	KUNIT_CASE(rust_uaf),
+	KUNIT_CASE(copy_user_test_oob),
 	{}
 };
 
diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
deleted file mode 100644
index 27ec22767e42..000000000000
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


