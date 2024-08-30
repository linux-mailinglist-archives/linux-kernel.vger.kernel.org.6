Return-Path: <linux-kernel+bounces-308120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2699B965791
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377D01C221C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C741531D3;
	Fri, 30 Aug 2024 06:24:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE1481AB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999067; cv=none; b=CjyEoOYq0xfZ92YhEg2+HMrOZQ16WX0VmYLo913ExhOuFdUqgKyD2TH4BgXebAxz4GNDfZTyplb30d2g4wQ2cdtl8WKmaWjIgRkrBjfyBApjlTOY0LTsZh2BPB/7e36gCEIQBjIfw6obEFdNbT+k+Ec5kqUj8KrfAkeyXIgxRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999067; c=relaxed/simple;
	bh=gd+aO52l1rCow7tkh7szgx8hR94Y2MtKVz/B1/ntNRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHtUePW0xuGcxSFTYwdt6Q5/8U136C+aV7bB/jsNxeEQ295OrfSjYvBdOmSlqLtHWEiqEmPByZ+BiII5d0SeYguwCZEdvRqYb9zq1pbS8mNlSHzAQgmU6boZ6c29wOdftXdwSVEztZt0XNOHQ2uD0usRPTbgIp+lgQ5Tjr56Syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ww7KG1XSVz20n3V;
	Fri, 30 Aug 2024 14:19:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EECA1A016C;
	Fri, 30 Aug 2024 14:24:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:24:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 1/4] soc: ti: knav_dma: Simplify with scoped for each OF child loop
Date: Fri, 30 Aug 2024 14:32:25 +0800
Message-ID: <20240830063228.3519385-2-ruanjinjie@huawei.com>
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

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split into 2 patches.
---
 drivers/soc/ti/knav_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index fb0746d8caad..15e41d3a5e22 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -706,7 +706,6 @@ static int knav_dma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *child;
 	int ret = 0;
 
 	if (!node) {
@@ -732,10 +731,9 @@ static int knav_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Initialise all packet dmas */
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		ret = dma_init(node, child);
 		if (ret) {
-			of_node_put(child);
 			dev_err(&pdev->dev, "init failed with %d\n", ret);
 			break;
 		}
-- 
2.34.1


