Return-Path: <linux-kernel+bounces-203462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E88FDB93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9973A1F248F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC398827;
	Thu,  6 Jun 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRBHNVmD"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B1168DC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634411; cv=none; b=RisK/agBnPOCzjdIUcHmEEk+0G0Md/JodeIzheeAaJB5Opv0tewbyhf0L6QC3Jg1DW1048zvG9DqBb8S9MYBiML8HEhzLG+LGPsP4LaT6OslyO6e7k6AkeYiNxyWtQQfsIOOSw+cyiVxtSgUgfkCgaseC+h6d2Omgh2Fq4nzQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634411; c=relaxed/simple;
	bh=ZcT37JIqEmGXAzXFcS0WyyMsGDu3RMFcf2dGO0jMyQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EH+i/gREX+qeaAhwnqvK6SZ5a3hVT5RRK94wokR5PiGl3NnfZMY3o2S738yr3caZ4Uv0SMsAR8qoSEnihqwTFNlWvFyU9/f12w26ZrPm4LOPUfD7vVe5IGC65JbiM3Uf0MgoMGuJHg8uBniU6MANUTFsrPCvaKN1vqURgLX4wQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRBHNVmD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70270ac0a65so10940b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717634409; x=1718239209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cS6FugUVB3/3Y4e21JFd/Y1hvecnSt+szCteq88Egbc=;
        b=LRBHNVmDOIOpNyzs5oQjLp/C0Jv99bMib+jmRo3BfWk5sGCw4EWI0B5mx7yePiMzt/
         LFlMCZiJ55avEXmmQ7sGtk4BHZKzz6Jdy9kRgALd3FIVfdU+cYejrtvIoIIzJckXN1XR
         oHiHB2442vbQEiFj52oDhEWPj2Og0Awtdb24mwWN8FzVaYJtJCzezGcwU6AVzSDLxNTv
         3PrHMfIIlGRfVFWsdXAnn6qKbjz8FCIIKU9SXQCOMrl3psQlQeqNQ0CIU0vC6yktoumw
         sb9ULU3vEYv21gEDf2pBgkIAD3dWy4TSlxaAsaSQWWVzFyg19B8DsFp4WEL9yObIlYXp
         RX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717634409; x=1718239209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS6FugUVB3/3Y4e21JFd/Y1hvecnSt+szCteq88Egbc=;
        b=GeTtlmp5qH6+zi/WVxzjHE1w63DRbpQKIsEYqCKNyIQ96J7WVJYURt7YLE7JCipVzP
         +sLc6DvEW4716phst3WdF8jFcmxpBijlhawQR4c4mUYhjBtQYMAasfNQ/+Gn0j3NzXPN
         cJwS0R6s6tPV+fqj8RfM02VtNL7UXW8TMnJjCV4+1KajVFBmj19MAdcZ1bPzR5MAbrQ1
         iX1W9TlNxTybGTCwjLrYFCnzC+mzyx1W+MSphQGnDJtPOxHjNddi1Uu+mjhI/CnG1Kfn
         K0oZS/rJ4WpAQe2XtGnCbRp8ovyPiFVamPrr1ay71MOZCsOe8JFHbDLu6oOf3g6YdTYc
         JtAA==
X-Forwarded-Encrypted: i=1; AJvYcCW8uw2F+4bQ9E8ZAZ5Pa3AlI70g4AyO0cSNbFo8VXgltjbzr1yWLhHKGeLFT8eMuvLURwwEH3ge8mveIuSGUxv/2C61coJxtLtJmsPN
X-Gm-Message-State: AOJu0YxTnzYgv16m7NDGvRzV0lc24R6Tcbq+UQwMUvjd7fUeGvLePI6z
	ekMz6DFOIHUuX9L/euhJm6AUOejFGaf53vwErVAKdFMhJIZMaEpG
X-Google-Smtp-Source: AGHT+IEU6DmEtaIokxqtJrCwfJ7j1o/4bs1D98al/iv9dN7oy3NgaFQhIp98eUy70YnVSAlhPeSw2Q==
X-Received: by 2002:a05:6a20:f39e:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1b2b6f40317mr4449874637.1.1717634409063;
        Wed, 05 Jun 2024 17:40:09 -0700 (PDT)
Received: from localhost (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd500c6asm96035b3a.172.2024.06.05.17.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 17:40:08 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] resource: add a simple test for walk_iomem_res_desc()
Date: Wed,  5 Jun 2024 17:39:48 -0700
Message-ID: <20240606004002.3280960-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
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
v3: really hardcode offsets, with 4KB intervals since 0x1000 is easier
    to read than 0x400
v4: use RESOURCE_SIZE_MAX, split allocate_resource and KUNIT_ASSERT_EQ,
    and other cosmetic changes
v5: include linux/limits.h, add a comment on the resource layout, and
    add more negative tests for holes
---
 kernel/resource_kunit.c | 99 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 58ab9f914602b..b13f01f290606 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -6,6 +6,7 @@
 #include <kunit/test.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/string.h>
 
 #define R0_START	0x0000
@@ -137,9 +138,107 @@ static void resource_test_intersection(struct kunit *test)
 	} while (++i < ARRAY_SIZE(results_for_intersection));
 }
 
+static int resource_walk_count(struct resource *res, void *data)
+{
+	int *count = data;
+
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
+	int ret;
+
+	ret = allocate_resource(&iomem_resource, &root, 0x100000,
+			0, RESOURCE_SIZE_MAX, 0x100000, NULL, NULL);
+	KUNIT_ASSERT_EQ(test, 0, ret);
+
+	/* build the resource tree under the test root:
+	 *
+	 *   0x0000-0x0fff: res[0], a match
+	 *   0x1000-0x1fff: res[1], a non-match
+	 *   0x2000-0x2fff: a hole
+	 *   0x3000-0x3fff: res[2], a non-match
+	 *     0x3800-0x3bff: res[3], a match
+	 *   0x4000-0x4fff: res[4], a match
+	 */
+	res[0] = DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYSRAM 1",
+			IORESOURCE_SYSTEM_RAM);
+	res[1] = DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTHER", 0);
+
+	res[2] = DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NESTED", 0);
+	res[3] = DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYSRAM 2",
+			IORESOURCE_SYSTEM_RAM);
+
+	res[4] = DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYSRAM 3",
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
+	/* walk the region requested by res[0] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[0].start, res[0].end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 1);
+
+	/* walk the region requested by res[1] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[1].start, res[1].end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 0);
+
+	/* walk the hole between res[1] and res[2] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[1].end + 1, res[2].start - 1, &count,
+			resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 0);
+
+	/* walk the region requested by res[2] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[2].start, res[2].end, &count, resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 1);
+
+	/* walk the holes before and after res[3] nested under res[2] */
+	count = 0;
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[2].start, res[3].start - 1, &count,
+			resource_walk_count);
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
+			res[2].end + 1, res[3].end, &count,
+			resource_walk_count);
+	KUNIT_EXPECT_EQ(test, count, 0);
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
2.45.1.467.gbab1589fc0-goog


