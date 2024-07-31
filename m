Return-Path: <linux-kernel+bounces-268646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E831942743
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2990B1F23360
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A31A4B3A;
	Wed, 31 Jul 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNgtwcfF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AC15884D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409345; cv=none; b=K6rraw4Hz+AK53ZaNqto2P4/YhljyBtRYyrMgG6Mdr1ELt77ZhHDXYyIysZcsfX1BnAGrYk85q8fiv1a0gRpM5WXHCyy1SO1OtkkRrkTPK2447+8DGeRu0Ro6PJ+G1/5tsedjvD7nuEb3IXVAmr8W4ePXGh6IoDeTTuyMADsf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409345; c=relaxed/simple;
	bh=UvGS2KNgksmGdxRxMB/KVioF0rHo3JEoWgRJlI3psks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJjqT85Rb2dbXC0eP4BFrAX7KRQ1WUz08N2zt1caxeVeiF1gUv/SmfRbTosPMgRZ2Yk7ti4i9NVVvxumVGcIMeTMTGspg3paqYHeW+n8OQs0cGDLIZsMUKPSqQQ43KoNqx0lEN9BzfCmvJti8/ahFlhJwAaa9Wx5xj+Utzqu6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNgtwcfF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a694ba5aso7862547276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722409343; x=1723014143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=088JFC1WZ8ZgSpH7zRMZEF3/RcvpIxuKl/0OLwbt5dE=;
        b=qNgtwcfFVQdzzMsxEn63UyeFDKtU0eC7NRQgJrIxzyOnZJtx+RxDBoq1ptDKqZC52Y
         rymLI1CIR4o+Z5uvcwX38hqmyp5liRDBZmJMYJKFSgI6FFnON+NZPDNg+taEQFdeQjOy
         zJ5Ka5qRr2hfwq3wDpQZV8QOOQYVXiPP3Z427eIaiOWaPtK3o41qdVm7PQUx31tGIe+0
         063hoiix+b97XVqcKGGvg5xX2xtpb9XJ4zRgj+7Wb8CAxc/TQqHHtNo9yoze1LkNc3X4
         kTH3hhXYFBpToQHeZr8mut4eS10j01kK8DpCwyod3Hx2Q1HbRKG/+U4j3NYFf+4Xl8vh
         Lc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409343; x=1723014143;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=088JFC1WZ8ZgSpH7zRMZEF3/RcvpIxuKl/0OLwbt5dE=;
        b=GAm/51LPlgE/29Vn0/OqSdKnxEqsil61Nn3t3wiJLXLMNS5iQ+ykLxK60vc8bg9nIb
         hTmRX5QtzHut9dvpUiRG/l/mwDOQj48xTIjMi6/teqsHi6l6OnwHnYBUtoquuQtclGB+
         pVcifXee3Qq3piH5R24uZP/NrVIWSDSxWSRTraEDrCn4Eg2aezA1JlDtIDpnngPOQMxq
         7DbFKFZbVDf1wvYSNRJQptNXJqCOCdaV6WMCk2h9+wV6toza9oUlQK+HJiwtJjUlIMFE
         LfGhPiweN/paQIL38fo8uTFu281MD8f9hEDIV7KhXJAlJuYVRQY6sFpRQBgvo5MmRtrq
         2SQA==
X-Forwarded-Encrypted: i=1; AJvYcCX84vFyQyJ8uHqMNhSQ6DMx7H9lR28nf8KCW1JeafcKOOURk153GlutpKRXVsI0mnrwIzkmmEmYIC7aFfKDYyydW7OKTu+GIn0nNaE5
X-Gm-Message-State: AOJu0YzcUXDa1AYY6aD85bBZCGo9na6rGTvKVYE0a/YeCFuIgiUto7D+
	MqUFRP4sN7AoNZutD7LbLHm8GlxpZCjRA9QK2qH+u09SCZXeS0KwyKVf2EQOjR0Gb2fkRHSx2t/
	cxtjTDDbZ9g==
X-Google-Smtp-Source: AGHT+IEvcL19rB/+XJE1g92cQ/lu74+Om7niyk0FqxVzSWQtmKy7T05Ze92qeC+Wk1rlur/edUgwreXL+ZLrXg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:949:0:b0:e0b:bafe:a7ff with SMTP id
 3f1490d57ef6-e0bbafea980mr1564276.6.1722409342902; Wed, 31 Jul 2024 00:02:22
 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:02:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240731070207.3918687-1-davidgow@google.com>
Subject: [PATCH] kunit: Device wrappers should also manage driver name
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, Nico Pache <npache@redhat.com>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kunit_driver_create() accepts a name for the driver, but does not copy
it, so if that name is either on the stack, or otherwise freed, we end
up with a use-after-free when the driver is cleaned up.

Instead, strdup() the name, and manage it as another KUnit allocation.
As there was no existing kunit_kstrdup(), we add one. Further, add a
kunit_ variant of strdup_const() and kfree_const(), so we don't need to
allocate and manage the string in the majority of cases where it's a
constant.

This fixes a KASAN splat with overflow.overflow_allocation_test, when
built as a module.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Reported-by: Nico Pache <npache@redhat.com>
Closes: https://groups.google.com/g/kunit-dev/c/81V9b9QYON0
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---

There's some more serious changes since the RFC I sent, so please take a
closer look.

Thanks,
-- David

Changes since RFC:
https://groups.google.com/g/kunit-dev/c/81V9b9QYON0/m/PFKNKDKAAAAJ
- Add and use the kunit_kstrdup_const() and kunit_free_const()
  functions.
- Fix a typo in the doc comments.


---
 include/kunit/test.h | 58 ++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/device.c   |  7 ++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e2a1f0928e8b..da9e84de14c0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 
 #include <asm/rwonce.h>
+#include <asm/sections.h>
 
 /* Static key: true if any KUnit tests are currently running */
 DECLARE_STATIC_KEY_FALSE(kunit_running);
@@ -480,6 +481,63 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
 }
 
+
+/**
+ * kunit_kfree_const() - conditionally free test managed memory
+ * @x: pointer to the memory
+ *
+ * Calls kunit_kfree() only if @x is not in .rodata section.
+ * See kunit_kstrdup_const() for more information.
+ */
+static inline void kunit_kfree_const(struct kunit *test, const void *x)
+{
+	if (!is_kernel_rodata((unsigned long)x))
+		kunit_kfree(test, x);
+}
+
+/**
+ * kunit_kstrdup() - Duplicates a string into a test managed allocation.
+ *
+ * @test: The test context object.
+ * @str: The NULL-terminated string to duplicate.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kstrdup() and kunit_kmalloc_array() for more information.
+ */
+static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp)
+{
+	size_t len;
+	char *buf;
+
+	if (!str)
+		return NULL;
+
+	len = strlen(str) + 1;
+	buf = kunit_kmalloc(test, len, gfp);
+	if (buf)
+		memcpy(buf, str, len);
+	return buf;
+}
+
+/**
+ * kunit_kstrdup_const() - Conditionally duplicates a string into a test managed allocation.
+ *
+ * @test: The test context object.
+ * @str: The NULL-terminated string to duplicate.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * Calls kunit_kstrdup() only if @str is not in the rodata section. Must be freed with
+ * kunit_free_const() -- not kunit_free().
+ * See kstrdup_const() and kunit_kmalloc_array() for more information.
+ */
+static inline const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
+{
+	if (is_kernel_rodata((unsigned long)str))
+		return str;
+
+	return kunit_kstrdup(test, str, gfp);
+}
+
 /**
  * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
  * @test: The test context object.
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 25c81ed465fb..520c1fccee8a 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -89,7 +89,7 @@ struct device_driver *kunit_driver_create(struct kunit *test, const char *name)
 	if (!driver)
 		return ERR_PTR(err);
 
-	driver->name = name;
+	driver->name = kunit_kstrdup_const(test, name, GFP_KERNEL);
 	driver->bus = &kunit_bus_type;
 	driver->owner = THIS_MODULE;
 
@@ -192,8 +192,11 @@ void kunit_device_unregister(struct kunit *test, struct device *dev)
 	const struct device_driver *driver = to_kunit_device(dev)->driver;
 
 	kunit_release_action(test, device_unregister_wrapper, dev);
-	if (driver)
+	if (driver) {
+		const char *driver_name = driver->name;
 		kunit_release_action(test, driver_unregister_wrapper, (void *)driver);
+		kunit_kfree_const(test, driver_name);
+	}
 }
 EXPORT_SYMBOL_GPL(kunit_device_unregister);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


