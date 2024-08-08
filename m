Return-Path: <linux-kernel+bounces-278835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B97A94B571
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8751C21A25
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA643AA4;
	Thu,  8 Aug 2024 03:28:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89B2CCC2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087717; cv=none; b=nif/gPx9fljS1SCg4qgLn8Y/eHGJH9y2cF75Dp4IsxwtNslzKHQ+10qDkAYT+Vf5SgNmEJlojphd5g3NhbwkkCYbShhlaKKqVYKvdDIWpLJ6bysXOnFIwjjnGiISSJcXMpEK8Nm3FHxDMb9OMQ7vcchFPzBF3yDd4xXZA8W7b3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087717; c=relaxed/simple;
	bh=fhTkVA2dvWlQ69GwxtpyE3hnO1a3ZbbT3UVy1PUGsn0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VMOLL2MEqq28oY8SOCkNjm2Zfy7noRqmrRh78K67udPOsEt9EBRo2+DczTPPLiMMLOCEVEQFn7bFtn/q5dd1gmbTFiL2PCQC29wpNSmyHljF1qG4pdAbfxazb6WzAxWy4FKtl3u3uf2n4QNoaPdMWXXdNegOp5YGX1ZF+qLMmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WfXSz0dm1zQp7f
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:24:03 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 89B49140604
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:28:30 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 11:28:30 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/mbigen: Simplify code logic with for_each_child_of_node_scoped()
Date: Thu, 8 Aug 2024 11:15:52 +0800
Message-ID: <20240808031552.3156-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

for_each_child_of_node_scoped() can put the device_node
automaticlly. So, using it to make the code logic more simple
and remove the device_node clean up code.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 53cc08387588..6f69f4e5dbac 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -234,37 +234,27 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
 	struct platform_device *child;
-	struct device_node *np;
 	u32 num_pins;
-	int ret = 0;
 
-	for_each_child_of_node(pdev->dev.of_node, np) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
 		child = of_platform_device_create(np, NULL, NULL);
-		if (!child) {
-			ret = -ENOMEM;
-			break;
-		}
+		if (!child)
+			return -ENOMEM;
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
-		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
-			ret = -ENOMEM;
-			break;
-		}
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip))
+			return -ENOMEM;
 	}
 
-	if (ret)
-		of_node_put(np);
-
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1


