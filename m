Return-Path: <linux-kernel+bounces-308123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BB965795
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5576285638
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F0155332;
	Fri, 30 Aug 2024 06:24:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE344C7C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999069; cv=none; b=N3kIfJkkWAM2kPwQ11BA7EAinTYcBbEPyxHc64qIOWpDY0JjqfALl5vTMqb9lq3JZOwVF5DjJ1aHacMSJbGHu8IAF8vFjQTY5JnYXZ3SE8PsqPglS1fVCAcqmcDrXNXSmang4SSZStjv5jAhYhpWoOcgqIZc/yLna4R7ZBVCNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999069; c=relaxed/simple;
	bh=17UmYdRDdA0n2Xm8qnAv+pEzia4GZ2vXwqeWsE3MvXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heJLeJm6QhoA2gIEsFmoUJQzbqfcAviRH41/g5lyif5RvJS2Hcd/j81Vjzf5V3qA5rfbL4or/9nHZYmaLCrDbApzqR6gvI4/GRHqDPu2HBihsqX7wNznu/ZFeIlH57WNLjJf9GRg0Ndb1DOWen1Msct3YE1eybLb9Ij3pXfGtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww7Qd1Hfrz1j7PT;
	Fri, 30 Aug 2024 14:24:09 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EA3F140136;
	Fri, 30 Aug 2024 14:24:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:24:22 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 4/4] soc: ti: knav_qmss_queue: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 14:32:28 +0800
Message-ID: <20240830063228.3519385-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830063228.3519385-1-ruanjinjie@huawei.com>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use the dev_err_probe() helper to simplify error handling
during probe.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split into 2 patches.
- Rebased the newest next.
- Update the commit message.
---
 drivers/soc/ti/knav_qmss_queue.c | 33 +++++++++++---------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 02983f8ba1b6..d583a86028af 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1091,10 +1091,8 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 
 	for_each_child_of_node_scoped(regions, child) {
 		region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
-		if (!region) {
-			dev_err(dev, "out of memory allocating region\n");
-			return -ENOMEM;
-		}
+		if (!region)
+			return dev_err_probe(dev, -ENOMEM, "out of memory allocating region\n");
 
 		region->name = knav_queue_find_name(child);
 		of_property_read_u32(child, "id", &region->id);
@@ -1407,10 +1405,8 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
 
 	for_each_child_of_node_scoped(qmgrs, child) {
 		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
-		if (!qmgr) {
-			dev_err(dev, "out of memory allocating qmgr\n");
-			return -ENOMEM;
-		}
+		if (!qmgr)
+			return dev_err_probe(dev, -ENOMEM, "out of memory allocating qmgr\n");
 
 		ret = of_property_read_u32_array(child, "managed-queues",
 						 temp, 2);
@@ -1505,10 +1501,8 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 
 	for_each_child_of_node_scoped(pdsps, child) {
 		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
-		if (!pdsp) {
-			dev_err(dev, "out of memory allocating pdsp\n");
-			return -ENOMEM;
-		}
+		if (!pdsp)
+			return dev_err_probe(dev, -ENOMEM, "out of memory allocating pdsp\n");
 		pdsp->name = knav_queue_find_name(child);
 		pdsp->iram =
 			knav_queue_map_reg(kdev, child,
@@ -1784,16 +1778,12 @@ static int knav_queue_probe(struct platform_device *pdev)
 	u32 temp[2];
 	int ret;
 
-	if (!node) {
-		dev_err(dev, "device tree info unavailable\n");
-		return -ENODEV;
-	}
+	if (!node)
+		return dev_err_probe(dev, -ENODEV, "device tree info unavailable\n");
 
 	kdev = devm_kzalloc(dev, sizeof(struct knav_device), GFP_KERNEL);
-	if (!kdev) {
-		dev_err(dev, "memory allocation failed\n");
-		return -ENOMEM;
-	}
+	if (!kdev)
+		return dev_err_probe(dev, -ENOMEM, "memory allocation failed\n");
 
 	if (device_get_match_data(dev))
 		kdev->version = QMSS_66AK2G;
@@ -1810,8 +1800,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		pm_runtime_disable(&pdev->dev);
-		dev_err(dev, "Failed to enable QMSS\n");
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to enable QMSS\n");
 	}
 
 	if (of_property_read_u32_array(node, "queue-range", temp, 2)) {
-- 
2.34.1


