Return-Path: <linux-kernel+bounces-201431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE55D8FBE71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FD2B22178
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFF56B81;
	Tue,  4 Jun 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjblrvLp"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE9320C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538508; cv=none; b=gzWcVjcRXeFMbeg3sm4duYzurxaOg4OFYvzfLQy3q8mWQMFrIDffUYiHEySVHPOrHXYnERcrExp3Vrm36zy/KxHlyYSRdkEyc5rcMWTfCisnZnxrwLwxZL+ZRBgWczDFvH+a402TmzeDPH7QyMyDtBurY1KUQ9VKq3T1O8wrfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538508; c=relaxed/simple;
	bh=AoLRjCk7Gy+e+NqCwI7iR2QlaUB3i7o+sdNHdzHRKy4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qgqx/fbku6oHJkuSwfJQKg8vNGtWMXU4oTaSXnxS08VSFfDAQivV/DIaZ2jUNMppiyQeYG0i25xpVSFqnAup1E/+D29lkB5x23PqJhre1LxPYquFUzif6wCOsZntKNTEWvdNAwNs6eb3Sg1EJsToUAwZyDGgFudefrWMxzLDc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjblrvLp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c21571e99bso458322a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717538507; x=1718143307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IukKNUeQwFyeGm++e5Ng9ZtZqlsDoJ65zsIQjpZSzD0=;
        b=BjblrvLpckTs4atViKrxi2Lbiw9qtu9UtX0V/rCE5mP0HcWQQjqL6+6wxNhZURocmT
         XFACsgnq+dNbkl2rdZte8pspOP3vdJxoG/VroIetembHzmbAt+LK/ImXTJ8OXz8ID38h
         2FYxbFnyYCBrIq1/FSjZvqmzIM8SPtlXPWla3Yvjw1MzFZk23qx3uF3VTxIb/1RAIlVC
         E4LrTCuAxxMHfVCBxIcr8CoIDt2AzukE8d0QKxpGlXbGW3aISiJpWqCgAfE+/Emq4xRx
         dZHFfVVRCF86f3QJAlZ5gjNBHapG/o6ABlJSHYZCLdd5NtX69cwd1CcYjs1bcI6mxbGC
         x2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717538507; x=1718143307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IukKNUeQwFyeGm++e5Ng9ZtZqlsDoJ65zsIQjpZSzD0=;
        b=dll4Ue04D9TytBgm9J1IjUnOYL7gO6l2ULob3pDENwqYjFeJwxTe5Aw/5QZqI7Pll/
         L12UVRtJpXirEK2s5AT29g21opbyVDA7exL7tqhw2WVMBa8FzArA/aGtBG6EEqBAMGfe
         Fr2rFUhgzh1+9PYMwUCG5hoK23ZYkvtXmAmdjK7c0wkbgTA3wQGSd53RTzFx3OdEXSwb
         wOKIOwj/TkTXyFPY8ERKuZOwqLe3h5ic2K4fxfJCLIQ5OCAP2I8ap4f9Bk+lwLjVjBaS
         Cfuwq7jDbHpmInUz5uLxiIaTfxEABRJ3iTHrh8Lnn5PKesk2Sre3H+0rAy2lPGSUkbFB
         2O+A==
X-Forwarded-Encrypted: i=1; AJvYcCWzgO8P1ROTJLBNzkcLJINY1ibkXKG2ZtJG4sT8qSyvZ6w0PHGNZGqLJT1/hvFN3brmK6TecDE5jMwXnIfIrBqiecIEFoVyVCgzNWFR
X-Gm-Message-State: AOJu0Ywquiog/IVqCo8hWDyIXxnLCWd+XDGQ+C9tqTtfMj9B2kaktwfz
	HyCy9BVxwYma6FBnK4Fj0peDIULmZyica8P3AG3w8tUqcRJXduaA
X-Google-Smtp-Source: AGHT+IFGYwHxVsNfoxbt2CzK5l4eYIyE35Rx9m0srIscTGbYXyaHlNMMP3LgYVtHRyNy/za7Z3REpA==
X-Received: by 2002:a17:902:cec2:b0:1f6:1bbb:e07d with SMTP id d9443c01a7336-1f6a5868539mr9569905ad.0.1717538506583;
        Tue, 04 Jun 2024 15:01:46 -0700 (PDT)
Received: from localhost (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f677fc9f24sm45772085ad.309.2024.06.04.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:01:46 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] resource: add a simple test for walk_iomem_res_desc()
Date: Tue,  4 Jun 2024 15:01:14 -0700
Message-ID: <20240604220128.682745-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mainly tests that find_next_iomem_res() does not miss resources.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

---
v2: update subject, use DEFINE_RES_NAMED and hardcoded offsets
---
 kernel/resource_kunit.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 58ab9f914602..c3a3f3bdf5d5 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -6,6 +6,7 @@
 #include <kunit/test.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 
 #define R0_START	0x0000
@@ -137,9 +138,75 @@ static void resource_test_intersection(struct kunit *test)
 	} while (++i < ARRAY_SIZE(results_for_intersection));
 }
 
+static int resource_walk_count(struct resource *res, void *data)
+{
+	int *count = data;
+	(*count)++;
+	return 0;
+}
+
+static void resource_test_walk_iomem_res_desc(struct kunit *test)
+{
+	struct resource root = {
+		.name = "Resource Walk Test",
+	};
+	struct resource res[8];
+	int count;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			allocate_resource(&iomem_resource, &root, SZ_1M,
+				0, ~0, SZ_1M, NULL, NULL));
+
+	/* build the resource tree */
+
+	res[0] = DEFINE_RES_NAMED(root.start, SZ_1K, "SYSRAM 1",
+			IORESOURCE_SYSTEM_RAM);
+	res[1] = DEFINE_RES_NAMED(root.start + SZ_1K, SZ_1K, "OTHER", 0);
+
+	res[2] = DEFINE_RES_NAMED(root.start + SZ_1K * 3, SZ_1K, "NESTED", 0);
+	res[3] = DEFINE_RES_NAMED(root.start + SZ_1K * 3 + SZ_512, SZ_512,
+			"SYSRAM 2", IORESOURCE_SYSTEM_RAM);
+
+	res[4] = DEFINE_RES_NAMED(root.start + SZ_1K * 4, SZ_1K, "SYSRAM 3",
+			IORESOURCE_SYSTEM_RAM);
+
+	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[0]));
+	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[1]));
+	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[2]));
+	KUNIT_EXPECT_EQ(test, 0, request_resource(&res[2], &res[3]));
+	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[4]));
+
+	/* walk the entire region */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			root.start, root.end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 3);
+
+	/* walk the region requested by res[1] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[1].start, res[1].end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 0);
+
+	/* walk the region requested by res[2] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[2].start, res[2].end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 1);
+
+	/* walk the region requested by res[4] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[4].start, res[4].end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 1);
+
+	release_resource(&root);
+}
+
 static struct kunit_case resource_test_cases[] = {
 	KUNIT_CASE(resource_test_union),
 	KUNIT_CASE(resource_test_intersection),
+	KUNIT_CASE(resource_test_walk_iomem_res_desc),
 	{}
 };
 
-- 
2.45.1.288.g0e0cd299f1-goog


