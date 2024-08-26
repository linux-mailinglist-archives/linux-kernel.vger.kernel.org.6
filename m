Return-Path: <linux-kernel+bounces-301050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182695EBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C121F2342C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC913E8B6;
	Mon, 26 Aug 2024 08:21:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002413F01A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660466; cv=none; b=uqPfyODpnBCtEDLRCxLjGttUJ6ilr2DCypFYHVaIZ/BgJXI0zkQwN39iT0U8jq2J+CjMs6b/nVUObzjfOv0qXM3MGYLitOQVgLCOPPUInEU7TQU7s/3jK1D0bQQ9tucJnNBopPWnzn+iJU3l6Uobp6ZvOr/zeBVoOs/FBeB5Vdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660466; c=relaxed/simple;
	bh=BizNWYM6Kr4faisHfJ7LjecVmx3Bm/gbwgObz66plVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUGO8tbDGji4hnY6eiWozIKFnkQgtM8p+Q4vnG9/4qDW2HrZhevPIChUpSmt5rQ3UaYFIgmdyIWoIMwM+phDGsiX2y0OD4INspmoJED+nAAZdmzJT3B27Lce/YwqVxqAjaprH0kKpg26yfsfzg8TAOtq4cXH/ujX5yvwbXJVSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WskC858g7z1j6NG;
	Mon, 26 Aug 2024 16:20:52 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 258891A016C;
	Mon, 26 Aug 2024 16:21:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 06/12] mtd: rawnand: marvell: drm/rockchip: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:41 +0800
Message-ID: <20240826082847.2591036-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826082847.2591036-1-ruanjinjie@huawei.com>
References: <20240826082847.2591036-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 5b0f5a9cef81..26648b72e691 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2771,7 +2771,6 @@ static void marvell_nand_chips_cleanup(struct marvell_nfc *nfc)
 static int marvell_nand_chips_init(struct device *dev, struct marvell_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *nand_np;
 	int max_cs = nfc->caps->max_cs_nb;
 	int nchips;
 	int ret;
@@ -2798,20 +2797,15 @@ static int marvell_nand_chips_init(struct device *dev, struct marvell_nfc *nfc)
 		return ret;
 	}
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = marvell_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
-			of_node_put(nand_np);
-			goto cleanup_chips;
+			marvell_nand_chips_cleanup(nfc);
+			return ret;
 		}
 	}
 
 	return 0;
-
-cleanup_chips:
-	marvell_nand_chips_cleanup(nfc);
-
-	return ret;
 }
 
 static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
-- 
2.34.1


