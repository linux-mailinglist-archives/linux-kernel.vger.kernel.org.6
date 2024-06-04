Return-Path: <linux-kernel+bounces-201406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DA8FBE14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FEF1F22329
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBA14B95F;
	Tue,  4 Jun 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzC3pI8r"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEB84E1C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536730; cv=none; b=YgBHNc9CHz7UGryttPrhXBIBQjt8C/1GhIGUKSpxBq01FnbYvaMTiGno63f7eqvx9DyU7JNEARjTE8z4cj7Um6pVtXmbIHjKF5nUsrrPsua+S86JjmFJk2Iab9T94OjiUzutcuis3Y2KRjyfhqLo8SycOWNTKrSdqkNT7aJpkfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536730; c=relaxed/simple;
	bh=m3dDas0clsrGaGIyLTBKgF2yMVGjZPTMNU0t2WsL8kE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Da8vXokTNuuLLdxsmWTP+6ps8riIQTGT8w9XIX9NPvigR8MOeskbwuqjkLRCiacymjK0QDT6i28wOnlAu2F2jcbb3dsw6pk1n2zu2X/JUDTC9VDMM5bREIYP5AcBFzRUHfSlLjTIS3gUWykhEzYNDZnQi60ON+G+NSFPSI7KZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzC3pI8r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f2e3249d5eso5089825ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717536728; x=1718141528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xczI7Fw8ihY2GJQ7xJJ7qToPNGT2Ft+3JlNRhzE1Eg=;
        b=ZzC3pI8rWTCDDBsnyomVyg+VKhvOpLCS4MXFx7tHnzbJ9fUzve8Kv82G8PKNLSmyvg
         GtczDWieDEsV1EDu4qqtBUw/FM5G3sJm0a4nF7l44Zz2uWd2m0gztykq2iuYBT0u7EBs
         33W2I6r/LUDGbr75yK8zFvfC+yaLJqv7ienypugbb/WeK7YP04ymwslWGLrjiU4b4ojd
         bd9B1Q4JZf27Rao3eG2HfymkflK0GkI3EbFWtfiZ5n3ThggluiZ5zJY1JvKS1HUFuFsV
         iU4dDRo7ucuIu1R9r2hK/rDtuVuV9VnvKfWzdZruvd/oN3DGIBprWB155O6E8ClqLbDy
         99ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717536728; x=1718141528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xczI7Fw8ihY2GJQ7xJJ7qToPNGT2Ft+3JlNRhzE1Eg=;
        b=gibwVvl/MJ3o6zep6eY3eUvPOS3BEAU7mhsxW8oGb569O8iro0L6vEbzjK3ej2rrvz
         01fi+tnfPx1HX3KOhQaNYQjCgXFpREjY4iuMWZGYy7Ozo0lDn/KsHtEXdDlCXmgOx3T0
         perKU6VW3nqf8ogNhliU+ynReq8fYda0YkkiilznbIjPH0mh1w1LVpKbgkBv9tU1029a
         95qVfHcoHc+OJAJlp8xkbC2boWUEES961tBVcRcu64K5BCy5d1Uy9LNd2jy3b6GjhewV
         jUXXzWI3q/gz0fVjB/Fu55lSn+8u20bD4Yyf69sZNjWVvNs2WywOebzmP5ygWW2OdXrA
         TB0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmMtiSACb/WptsQ7XDY+PqNT2V3rE/WvQ6xre4ShW0QndVFHiScACJuGbHCTQIwFp2BjjczJrwB+6GHyUkdR6PWBFf0gQHKS9r6BXl
X-Gm-Message-State: AOJu0YzFQ5jdpobFPAUmkjfH6JrWeV7uByzvHiDS9lKhCzRYY5TLDFOR
	fhmt19TfiHriJnYMAm5Rw40T0tuwzSHhTflTJoenF/FcPzR5pFob
X-Google-Smtp-Source: AGHT+IEPLHIF1pPpQIekgPRMDE5Q89jim+kiEvlofET0w9Fc2rVPPrCnAQyYwoITl01Dyl3W8ODZ+Q==
X-Received: by 2002:a17:903:2445:b0:1f6:226f:cc44 with SMTP id d9443c01a7336-1f6a5a84e75mr8220585ad.3.1717536728435;
        Tue, 04 Jun 2024 14:32:08 -0700 (PDT)
Received: from localhost (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6939bc65dsm21923045ad.136.2024.06.04.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:32:08 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] resource: add a basic test for walk_iomem_res_desc
Date: Tue,  4 Jun 2024 14:31:46 -0700
Message-ID: <20240604213200.672279-1-olvaffe@gmail.com>
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
 kernel/resource_kunit.c | 96 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 58ab9f914602b..1cbeeb44d0822 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -6,6 +6,7 @@
 #include <kunit/test.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 
 #define R0_START	0x0000
@@ -137,9 +138,104 @@ static void resource_test_intersection(struct kunit *test)
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
+	resource_size_t offset;
+	int count;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			allocate_resource(&iomem_resource, &root, SZ_1M,
+				0, ~0, SZ_1M, NULL, NULL));
+
+	/* build the resource tree */
+	offset = root.start;
+	res[0] = (struct resource){
+		.start = offset,
+		.end = offset + SZ_1K - 1,
+		.name = "SYSRAM 1",
+		.flags = IORESOURCE_SYSTEM_RAM,
+	};
+	offset += SZ_1K;
+
+	res[1] = (struct resource){
+		.start = offset,
+		.end = offset + SZ_1K - 1,
+		.name = "OTHER",
+	};
+	offset += SZ_1K;
+
+	/* hole */
+	offset += SZ_1K;
+
+	res[2] = (struct resource){
+		.start = offset,
+		.end = offset + SZ_1K - 1,
+		.name = "NESTED",
+	};
+	res[3] = (struct resource){
+		.start = offset + SZ_512,
+		.end = offset + SZ_1K - 1,
+		.name = "SYSRAM 2",
+		.flags = IORESOURCE_SYSTEM_RAM,
+	};
+	offset += SZ_1K;
+
+	res[4] = (struct resource){
+		.start = offset,
+		.end = offset + SZ_1K - 1,
+		.name = "SYSRAM 3",
+		.flags = IORESOURCE_SYSTEM_RAM,
+	};
+	offset += SZ_1K;
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


