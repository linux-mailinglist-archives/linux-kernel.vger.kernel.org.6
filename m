Return-Path: <linux-kernel+bounces-203294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A808FD906
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958EB1F21BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7615FA9C;
	Wed,  5 Jun 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXGAz6Qf"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBE139D00
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622926; cv=none; b=J2ZVWGXQdtGNDAjxysPgENiIlEJwTz0K5wAJWSub/6hMrHjmEdQkkYlvz4I+yHkJ2A5c8jH6BdeTKakCzHNMu3X88kaWeb0zUi1Wai+rmwpsI59k/SUESpuyDJ/2j1ad+r74YQHsY3yeHV27eHTk3MojitaRuWa1UNmKhF7crgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622926; c=relaxed/simple;
	bh=Excgb63xVZGyWTqKoH5jAenSZG2GrIsKB955IrOXy5E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kUaUDMSSi2I5BaoqTOXpFgTOoNV800K4/5lhmGHAiR7kB7TL/JMkm8D60AoxRRT5hxdXZuC7n6mIIKdF3oFz9SC7FDCJHNpms9iGpfyTHu6UxKxbBaq3P3qwxEajkW+0nRhBJHJt36dmuOjZwvrZDOSm1fc+GJaFJrk7hiKpHAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXGAz6Qf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c46ed74937so18659a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717622924; x=1718227724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFxzmDIore9jmqsJAJlrgYm+dC8T1yTrzRhVBhmJPZw=;
        b=QXGAz6QfNIMTv/RhuCgg9yjT8huzUOTA63etJmnKHDBW9EhtfHPJTgI2FG7AFZ/Om/
         EcsOc875C06IoxaHHNX83iH+V1fQV8XpYKoBnMZBPB5zq/3yQp2DcoVMFvyq/85j8T+d
         CQEpWxgKoHrNdaw18U5tSu1sGqMdI9TSXeMwsT/xJTs9AS+ooWKSy854prnHJ6BMM46g
         HDsPYHc05YugboUH6GuuG5Zu40mCPOZtcP7K+BN5uJADh8eaDmMFEb+pWJNcbaXdUaCW
         i4x6Aj9xaYvGo4hwnpV7WXb+IIxzc+AXRvZYf7tS1f+Afcz/u+qGyK94Sch/qYts2sD/
         9vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717622924; x=1718227724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFxzmDIore9jmqsJAJlrgYm+dC8T1yTrzRhVBhmJPZw=;
        b=IyHY9VYEHG4qhrGw1k8a5HT5jf24eZOo4sUpdCvIWQP2g4YkkaxJdf1JPQm32jhcea
         uqzsEg0TdAB10wTnHnGDzywxgsUMY0lmO37zs/RkVgEg22ZqgswurAXctSQHsm5zlYNm
         LsX6GiQQDHG7cRmv6GTEQxr/SOZYVR3GrSFcp6gXq/s+U3I30hDnHuOeLFIDbs2ze2gr
         AtjfHUhSUU8mj/6ATkJU/jU2pKZ7/JsbYn9gTUWG5uKd5Z9EcmjsDQ6ziKl/w6Dp4r6X
         PZHJ0x0Js0HA5ieuxBCSugyvtFwalz+PTfZ9jIp3soPkLq1g7GlHzR8+LBQluKvyzYqT
         OrYg==
X-Forwarded-Encrypted: i=1; AJvYcCU9cN9cb5sT0F6bwQAUPdY7AU1cHKujbo3fL1gwzq9FtUZ7Z+7urMdMgmFpPvk9BBdt7g7tkeCApjImHHd696mTakj3ujdfT15UMoBS
X-Gm-Message-State: AOJu0YxkG6PsF/9Lb1vzvjtyqChybylvATl9R81WvITQ35xbYDqzmeZv
	BujML0SyMU5roPt5IdxEm6XfcD8NuwF+D5PY5hdGCgNloFdNJoEs
X-Google-Smtp-Source: AGHT+IH/MSSmdUN4rl5I0/fszVrCrfO7eI5sJAmU4cvrcTKmzNVwoX75MA3mgQOx4zqia+pSZFjTzg==
X-Received: by 2002:a05:6a21:19f:b0:1b0:1ce1:e7b2 with SMTP id adf61e73a8af0-1b2b71c8ee1mr4671388637.4.1717622923790;
        Wed, 05 Jun 2024 14:28:43 -0700 (PDT)
Received: from localhost (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423e0132sm9065701b3a.67.2024.06.05.14.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:28:43 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] resource: add a simple test for walk_iomem_res_desc()
Date: Wed,  5 Jun 2024 14:28:26 -0700
Message-ID: <20240605212840.3227774-1-olvaffe@gmail.com>
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
---
 kernel/resource_kunit.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 58ab9f914602b..580c9ff6940f8 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -137,9 +137,76 @@ static void resource_test_intersection(struct kunit *test)
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


