Return-Path: <linux-kernel+bounces-362888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C799BABE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355B91C208E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65853148304;
	Sun, 13 Oct 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMs/EBa6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF8148308;
	Sun, 13 Oct 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843561; cv=none; b=UJiHt3Uyv18ssVrPr4ZbLfPB2C5wBQNOo7ejSWbK0EOiXsoR8JHKLGw4PZk0inGZU+mlh53hVgHvfWOYA0Rc8H91KPo+AJoakvrVm1I8WMfYMxY1fgTyPT0aRDf3j3K8ejjSRhvsYfRlMcmubPzTPxGmtjZ6KtPLo8uazCc5IQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843561; c=relaxed/simple;
	bh=ru2Ad8Dlv3l1WvgpQf0mf8wNVEUpc32oxgOvikO/3+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1CycqtsWdHvYl1IpVdNvBqw+/HD0aY8PvyhOq/IjnderwvWhuf+Xgn9Kpb4dSTx3wzm+V8gym5phDmlbj4PW7yNx8E/BXcCkLM9vx//L0pU1z23hgJXgoaDG/H1RiqzD+HWuTqbEX8apleAWUCiT09WqI7ACPwsZ+hb1izrocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMs/EBa6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0cee600aso39108366b.1;
        Sun, 13 Oct 2024 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728843558; x=1729448358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X56ki4zUkTbfkScVrmia1mDMQKgiUsSq+BtzwCXhyN8=;
        b=BMs/EBa6WfrfkW5acLWQAQP7uZrQSmBvc+Tq7P6A7nGdOS/9nEirXb1yzW70wsQTZY
         B+2wieFfp3BtHKpq+rddtydJEV6JyAdxr9X3K9HpLD7p592QFsKTgGq3cKJNUbsGtIqS
         XzKhrFiiDwbqrCvwd5IiJ294lmpV3wyOVbqVGHF1zeIcSGu3m6FCcEcra7siDNEpzp+l
         mfhCd862eaLXOfOHOjgyjd5lqgT9FZE8EmLVSozXbsPvBHnUFzaQMkGuJHE7aTm+aNwJ
         xsaen6P08Z/0fhkZyTBeyhP8QnrItDt/v5AxPAw9f5fON8i1ASWIBNc+Yu52+9PmLa4M
         fTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728843558; x=1729448358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X56ki4zUkTbfkScVrmia1mDMQKgiUsSq+BtzwCXhyN8=;
        b=DAKRVsyenZPP8Gkhs96OLeUjljAKlD4KGC+2w0RO+o2sGToTvP4xBDPfANeyh6trt9
         1xWNOErlhlTcavNK5asaYuqJ73cGgoeoew3LABHcwH2KVpoa0s0sYhtD3KYKlZLhf+nz
         ijmoA5qhRe/ueURZcSAeJURqsr4RDwYI2Mbr1/5dXCju51FdvD9tiIp+nuX9gB0hglsL
         yRbL7J/0Wku6btf+3miRnGJVv44nEx3bE41SMU8tuv9H6eRy8BMgk9GPIALP7V0LSUMX
         0sc+FCG7iT//n4MxZOmJilYoWavlFpmcTFSbF5JPBfJ0TpfTW4c4r8fHS5tO0bEhlP5T
         QUWw==
X-Forwarded-Encrypted: i=1; AJvYcCVwxPKBa4/gEooi3WEmZIuMOD/vft/olt++OntT+0427+DYv32mIq6RV8XRRE4liMszhHx08hZF0CY=@vger.kernel.org, AJvYcCWGCwGIOsC0R6rN0t6ySgkFNRpIoAriLRfO1lnVDk1lFGBwEPu7BO/pQln09cG5FMd3U9PS7TMv+79PlKiR@vger.kernel.org, AJvYcCWaZWw9doIhcBC/AiBD+27Ib2OCiwygq8ffyWL+xCWbzHjyPj2Mux7GWm5qo0zyZOwRxnIioJAfPL/S@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq8VLywxP0AndK0EzwrG4juq++svxjE+BkJtIV1xEVhp20/1q
	3FX2yFKfsnIG5T4o0sBJM6g/Pzpt8XKlQ5GmJeM/hvPNkmy2wRb9
X-Google-Smtp-Source: AGHT+IEPuqRk1fF+DzXKNYdEqvVLvn9/MKGMqgO/l9jzR0cpo8qxe+FtFoILPmStmwoQA5yi91dqsQ==
X-Received: by 2002:a17:906:fe41:b0:a99:c075:6592 with SMTP id a640c23a62f3a-a99c075952emr779610666b.56.1728843557929;
        Sun, 13 Oct 2024 11:19:17 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99e57f763bsm249937066b.85.2024.10.13.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:19:17 -0700 (PDT)
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
Subject: [PATCH v3 2/3] kasan: migrate copy_user_test to kunit
Date: Sun, 13 Oct 2024 23:20:16 +0500
Message-Id: <20241013182016.3074875-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZfL2LHP7rBqCK5ZbsYu-jJ+2YbV4f0ijjDd_gQGiivNWg@mail.gmail.com>
References: <CA+fCnZfL2LHP7rBqCK5ZbsYu-jJ+2YbV4f0ijjDd_gQGiivNWg@mail.gmail.com>
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


