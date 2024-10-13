Return-Path: <linux-kernel+bounces-362805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBD799B97B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B1DB212F7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4B14037F;
	Sun, 13 Oct 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUMSCvkC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B213B2A2;
	Sun, 13 Oct 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824544; cv=none; b=oCf9xlDCC6kXzF/26zMBrvlk7fUJEn1ZO6zEjkNVv1lXJlLf2WONxlAEWjDKw9fIW9BMonBU1p8OkIvauY2ypgjhL4hDYmwky+sQ3xzzXHuy65qVHGaVj0xDwR5YF4T/Z7XyiIQbPrZuq3luPBiVHvUQ0hzccUOLfrNQtraNRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824544; c=relaxed/simple;
	bh=48nguJIJIqrt68cC26/V2bcL81sYU6GUZ0U14Det/uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbrapwZPSQxX3qQPX/kbihQILA6HgXn1aKUEm+KhU5j10DHqqQYAAUu93S0B66e1zhbHCBX3AjdcSg32Cap/MAqpDE7sIBjQcTNADcdKxeFDPe/ylQRN3SoepdcoIAdEMMS94yn10kTsza9//DjQlZDdPec3vxpDyp0P7ZT+nZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUMSCvkC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so498675566b.0;
        Sun, 13 Oct 2024 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728824541; x=1729429341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOio8S+6KOqaUEgqnfvfmeW8wlYXV0IlIhkZKQFgu/c=;
        b=hUMSCvkCfDggaX1y5ll14eyZkgwOj7mIqbTR8ZMq98Y7xBPLAW+i8VvFSD5JBkL+1b
         geMNAmoC2ZdSqzoUkReBaJJdxqNC9hm838/wMUGzmh7AFFx0pLxkOLBdJ38O+DFSv49x
         mFluDuPqCGUAg9IpNqNYbNTejiE2AM5iDPJCWpNHSsPgQLJRDa+9MDaqkFer7/Rf4CF7
         3+MrCHvEmnxlOU/r/k+al42YXxK4YzPG7O/XUrcL4mWtUjKNPkwtZpUJ+Z8zsV0Ofbwg
         VInrB/t2yBbqC4ibP5TH8zEkArsYBfIehIOXB35ymo0a0FmTPmW4G29iUdHQvWeCP4Fx
         DvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824541; x=1729429341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOio8S+6KOqaUEgqnfvfmeW8wlYXV0IlIhkZKQFgu/c=;
        b=CiPPlNgJ/efJ906YT1ukWSxgEamMa4hNnfyliHmdhoaTnP0zKBQMV8Rxx/rlpXj3X3
         4Sn+hydGgHzu+BFFjcY6hM6njIfW4UJwhnqQzEpHmNbRvMDXeVnxdy1LsEB0OBIMlBiO
         +x6p9XUZxAytd65WMbDulNwUTXem+HBW92EOTmBSk1xLsr6wGJee2L5W2lWQlo4kTyOZ
         QhJagPYj4Iu3oa3QeQCLlLx5hdCcj5lUUVE4iixtdwKel/236XaH3xrs6niMNys47eLS
         PAXbLXptesBPKOcAFJgtwsjFzUJH2vgplgaLk0Szzqa/CCH4VMkRadJG0qGmD4PsHxmM
         GGwg==
X-Forwarded-Encrypted: i=1; AJvYcCUM57Ljje3NPK0rSo1PHXzG0K7NaLn2WWDZ+/dkQagKAuhnfC3o6nPzrrAQuObF9FXGmXlvxWOKf9k=@vger.kernel.org, AJvYcCVGG9nCwOo8bJiH0itXMn9Z+bDe/QI1f+7ybMXrUbXPs90o/azAfZ2DW3nTrKyAi4CkAz9Om7gRcfhGrhAm@vger.kernel.org, AJvYcCVYXrJAXopohFDO7p13tg7e+GdjPUDGRwBj9+C7DcZB5XTFruIeHuWzlVoGnEeZovMsRGTJP8TnSdK2@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiDmYHhMtloO7+vQ1oSqD2BoWceUa9ZdHjVZHJfqAwgzHPoV6
	i7zV6p2n7w3yd/Co/A+6WHUG7wL/5mabRR7KppoT6gsmOQYzL7fr
X-Google-Smtp-Source: AGHT+IGa72/I5E1R4rZXYJgY/jp96XXQXIIaDV5rRLP1ox3QbO7ExR6jmFn8fxtaiWDpevEMJRVjBQ==
X-Received: by 2002:a17:907:ea3:b0:a99:4e8c:e5c9 with SMTP id a640c23a62f3a-a99b937b7famr780021966b.20.1728824540497;
        Sun, 13 Oct 2024 06:02:20 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0d9de967sm19209666b.139.2024.10.13.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:02:19 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	corbet@lwn.net,
	alexs@kernel.org,
	siyanteng@loongson.cn,
	2023002089@link.tyut.edu.cn,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/3] kasan: migrate copy_user_test to kunit
Date: Sun, 13 Oct 2024 18:02:10 +0500
Message-Id: <20241013130211.3067196-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013130211.3067196-1-snovitoll@gmail.com>
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
 <20241013130211.3067196-1-snovitoll@gmail.com>
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

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/Makefile            |  2 -
 mm/kasan/kasan_test_c.c      | 39 +++++++++++++++++
 mm/kasan/kasan_test_module.c | 81 ------------------------------------
 3 files changed, 39 insertions(+), 83 deletions(-)
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
index a181e4780d9..e71a16d0dfb 100644
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


