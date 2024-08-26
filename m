Return-Path: <linux-kernel+bounces-301047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39495EBD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC0A1C21940
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24821172798;
	Mon, 26 Aug 2024 08:21:06 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3E14430E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660465; cv=none; b=gGHIpyGHLrvQegdK7iMVtluGurcgdHARiKoIXi6azESV0Ccx7LAyBuPfA50pyUKK6UunLITlNu7Ys9uEZC9AitgThN1aYeMS9h0xcpg7mI0R6TAdy5YA8rtYqzqJOgqNvvHo7gl1/YFYUOe6NyLRvqpjGwz7itBVFDCxAIwu7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660465; c=relaxed/simple;
	bh=CFXwQtaRxFYcIiQIJWllgwYc8dBwaJAt5TRD2jKy+yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwJAJmy1h4CSgJttiUnHN7esPstA2R6EtXT5lJ4VczijipL+jo0yU89139FW4Dbsaq207cGAS99bQYZrpwqh/+I9QiDsC7q3oGK7gsh7LdrJjvEHa7IlFt9L97StzoTU6fmA0AfudrjakZrOTeRyt2G4/xYbku5RIICiFCta58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WskC91Hfpz2CnbF;
	Mon, 26 Aug 2024 16:20:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id C1D1E1A0188;
	Mon, 26 Aug 2024 16:21:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:01 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 08/12] mtd: rawnand: meson: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:43 +0800
Message-ID: <20240826082847.2591036-9-ruanjinjie@huawei.com>
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
 drivers/mtd/nand/raw/meson_nand.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 9eb5470344d0..8806a06462ac 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1495,14 +1495,12 @@ static int meson_nfc_nand_chips_init(struct device *dev,
 				     struct meson_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *nand_np;
 	int ret;
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = meson_nfc_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
 			meson_nfc_nand_chip_cleanup(nfc);
-			of_node_put(nand_np);
 			return ret;
 		}
 	}
-- 
2.34.1


