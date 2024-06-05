Return-Path: <linux-kernel+bounces-203126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E08FD6CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667C51C225C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749715444E;
	Wed,  5 Jun 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrsluVOf"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD512F373
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617212; cv=none; b=RzqScEkh0NS4GnT9qI9uXOPmR+pBC4os5ZRnAE6EK+iofxG4loqW4gf8rx2ip+DCZkEpTZlIEgnj+RM8IgDcwoQ3Kaoo529c/WnDnJ0nzIOsPjYIXU8UyZb6wXhhLLq7MbchqHFdtTH3vC6KwTxYaKJdPc1njWOvWXSEnONN2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617212; c=relaxed/simple;
	bh=kZgXdMWktxFXCzZLpPQ48hu5E83Hr7J7Cw61cWzEzek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PJ5UMYY3L20hIO4IADcFHBXbSl4U2kJGP6/aqvqQo3+CdgvUZ0YgKz8YASnGYGUSgfIkSDza7LzhIYW6Q4A3giB4X0c/o2AOTjZBdBMvwaKZguRbUP+auKxpZ48h+6FZQqpsUPnqyAyL0lbXw1ZkbUQB420NnFjQ/ELJ5ap1NbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrsluVOf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c2d04b0833so23955a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617210; x=1718222010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DuVX5g9JyMJ3EfYr4ZNGieSCq2niGnOrINp/guJRuJ4=;
        b=ZrsluVOfs4HZLhxF/uW7nYjmNAAr/DSm61aICUa0+YhUq4b9ZTe3R1RnB5Td97z3XW
         8E1/iQ7lYeBgzfIzbvDQ8xZcnCjQANc0UNn25xIAHpmbLfiXbC7W+55ZbRGVs80wGd4f
         yqmeTOtdguUESlWbj2EEyX+J1taN8ZdccOdLwFT6FjBtZeo32/TxQ3pcODZDTrGzLnTE
         QbSFO2h4WhuZyHp8bS+43pinYMHYyyTEZCOuOxwQTU7z/Pwne/uqI7TcGx0cDQg77cju
         AXQhKuMm36npmPijAvHFqaHU9gn8pU92APDvuDERSRXqb7T5a2oOhpQ3xb+5tDR8Gw5z
         c5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617210; x=1718222010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuVX5g9JyMJ3EfYr4ZNGieSCq2niGnOrINp/guJRuJ4=;
        b=F5qZfPJTpoeuugqzSCvnURt07OG20W8p92sdtYt4LlvGZ5HdM9Z6kic62+5VqrBKOp
         IPnrGSGeLkgaWsNzXJ9/YSIaU6c8+uLiC0eL9VcvctMdD+GVnymcrd5+1gcy/17mRaOR
         G64RuvnHuyeTtWTuPRVApTwJPwCisa0csGp8hIkm4I/Muhw0qTWHTSyPirYBMKQQ8n/F
         dQe7RfwL0GoNf7YB3VH+ozZunxh2QvHD6u42wQGWSRZhpcjVR8Sx+w69jcwnxX3ncOc7
         11T2OSVe6ObOQuIeta+YnHiHLI5wpF6U6ijLqaok3OknGgEn4EwOmAeF/jasZ/a3kNA3
         ibwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsNH6dkd6euXdtinSo7EQ33yRSU8+y/m1iIvYd2zPHhj2H+/woYrf/b+oBqaAvDNbKp4itc0+8uzGHkGJvSvrUWSnqgd47Nj50PZAi
X-Gm-Message-State: AOJu0Yxtq0GmhBCzQOvJejm7wdfS07/AnWQq+A3kMXibKJ317ECzDoZb
	6ksmXmNmLgnEa6g96ktmZEnz2Auw0wiFFiSrb0cpCowyLXpKQ8sV
X-Google-Smtp-Source: AGHT+IGLV56wuq7shmGu9GQb7mPlhApWnTHIr4/IzG1su90F963Il2jBOSHbTetOMvOKHRdAGd5J3A==
X-Received: by 2002:a17:903:2448:b0:1eb:50eb:c07d with SMTP id d9443c01a7336-1f6a5aa5a71mr38776755ad.4.1717617209766;
        Wed, 05 Jun 2024 12:53:29 -0700 (PDT)
Received: from localhost (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e181csm106587845ad.178.2024.06.05.12.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:53:29 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Baoquan He <bhe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] resource: add a simple test for walk_iomem_res_desc()
Date: Wed,  5 Jun 2024 12:53:10 -0700
Message-ID: <20240605195324.3213954-1-olvaffe@gmail.com>
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
v3: really hardcode offsets
---
 kernel/resource_kunit.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 58ab9f914602b..1a562d0978477 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -137,9 +137,74 @@ static void resource_test_intersection(struct kunit *test)
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
+			allocate_resource(&iomem_resource, &root, 0x100000,
+				0, ~0, 0x100000, NULL, NULL));
+
+	/* build the resource tree */
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
2.45.1.467.gbab1589fc0-goog


