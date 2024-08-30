Return-Path: <linux-kernel+bounces-308124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80729965794
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B351B1C225FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906D1547F7;
	Fri, 30 Aug 2024 06:24:29 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256214882D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999069; cv=none; b=HabAqbli5GSihmo8w0pQVF0ai3W/Rj/0gP7SsEUpsIIITdWaZEeIxzVetiv7APx45f7ngVomQ19uvL/13vS9GI6DKLZo4RcHN4kGkerj+jbQJhEEKYINL0nPZUGV6SF3vd9vkFavubWu3DHzX8930f4WQewPgYVfBymvMD0FK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999069; c=relaxed/simple;
	bh=qDkA+oquu4u+k7V1LPRaq8PiyWtihhyUduWC7161rqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfBzmPD2Obv6VwbuQGd8kHVXkqLNAgPfrroQ8Sy4sPFNhEZNDKq/OJomruGs9p2ZIWHZ2A5KnjRRqKKagZX9d2EGbSPT71nTEa9r8cd2QBdqZ5yNOFclamlfDB83yr302j+g/CblkN4mjpW/KcT2AcT/F4bVepBe6vZrl2grWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ww7KG0yLhzQrBd;
	Fri, 30 Aug 2024 14:19:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B35140360;
	Fri, 30 Aug 2024 14:24:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:24:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to simplfy code
Date: Fri, 30 Aug 2024 14:32:26 +0800
Message-ID: <20240830063228.3519385-3-ruanjinjie@huawei.com>
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
---
 drivers/soc/ti/knav_dma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 15e41d3a5e22..eeec422a46f0 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -708,17 +708,13 @@ static int knav_dma_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int ret = 0;
 
-	if (!node) {
-		dev_err(&pdev->dev, "could not find device info\n");
-		return -EINVAL;
-	}
+	if (!node)
+		return dev_err_probe(&pdev->dev, -EINVAL, "could not find device info\n");
 
 	kdev = devm_kzalloc(dev,
 			sizeof(struct knav_dma_pool_device), GFP_KERNEL);
-	if (!kdev) {
-		dev_err(dev, "could not allocate driver mem\n");
-		return -ENOMEM;
-	}
+	if (!kdev)
+		return dev_err_probe(dev, -ENOMEM, "could not allocate driver mem\n");
 
 	kdev->dev = dev;
 	INIT_LIST_HEAD(&kdev->list);
-- 
2.34.1


