Return-Path: <linux-kernel+bounces-301042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBD95EBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C4EB24A61
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0926155A5B;
	Mon, 26 Aug 2024 08:21:04 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50013F458
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660464; cv=none; b=jy46/Fe/nseBZGcNdvytg2G0MB2OIcIk3wNllV3+MOVqpeLNf5rVFV4tDU9/kPyAEhyDqFZ0GZnRbasNonwReKRt/CtkJTz3z4+qWibb5Kan+YLK18rQl3FnBgGovwnvbN09qqkzEw8LEL3UOE9f6o6L7GAMRZdViEcjzZVvf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660464; c=relaxed/simple;
	bh=0EPYh1Vzx06q4ro7t88k1WvU2Ig0NleU9/qKXX5YAU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo8dKdVQGhsRbO9K7RdyYMQan2Xo6eQTxPRZj0Z85O+jLldAg2svaRSPjyaNK0QcVEwZ7GxBsL2w/mZ0d2nQhRO0eN2frvvmFlEAa3EvoOrWqJMEaauka/T1LPWPqtbC6v7MMPzhzmXhanpJo7BimFnhtB3r2d7GM+2nH+Cka2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WskBQ5Ybyz14Dr6;
	Mon, 26 Aug 2024 16:20:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E661140120;
	Mon, 26 Aug 2024 16:21:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:20:59 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 03/12] mtd: rawnand: arasan: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:38 +0800
Message-ID: <20240826082847.2591036-4-ruanjinjie@huawei.com>
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
 drivers/mtd/nand/raw/arasan-nand-controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 2ff1d2b13e3c..5436ec4a8fde 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -1360,7 +1360,7 @@ static void anfc_chips_cleanup(struct arasan_nfc *nfc)
 
 static int anfc_chips_init(struct arasan_nfc *nfc)
 {
-	struct device_node *np = nfc->dev->of_node, *nand_np;
+	struct device_node *np = nfc->dev->of_node;
 	int nchips = of_get_child_count(np);
 	int ret;
 
@@ -1370,10 +1370,9 @@ static int anfc_chips_init(struct arasan_nfc *nfc)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = anfc_chip_init(nfc, nand_np);
 		if (ret) {
-			of_node_put(nand_np);
 			anfc_chips_cleanup(nfc);
 			break;
 		}
-- 
2.34.1


