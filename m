Return-Path: <linux-kernel+bounces-301043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9677995EBCE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7701F22B43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A3156236;
	Mon, 26 Aug 2024 08:21:05 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332B140E29
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660464; cv=none; b=gk+fHaoDfP7hnal+wuxAFrqeieGSMDdnixBtSgpA79L8GSdsgZVTD1cYerIsrx3ivGdTu1UMd5OVl8d9fgZ+iRgZHri1AGYfPN3/GIxSiJ9XT7reZ+9prdQTW2NfvAn8REWm97MfZZO9tcjd7ejljmzHInXcuUH4XejUa3RTIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660464; c=relaxed/simple;
	bh=df5D92/twkTlA+QLMEAQkUMWu59nT3h+JvEl8ZoQRgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvTrTTYEDjfUlDNs1UzQ/uE7NIqsSv8B3qfx8PFjvdsmxLXSuhU3a1r8fksdLg14d92vzqMEnpDxoCZOofI3rh70MGfch5y1f9FpDj7fsJTF097vA0EisMcJh59eIm+wK6JEzhsu+kb/Znz54r/RIPJ6aOE+KjjbDGtDhS1nSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WskBR0rGcz14GKW;
	Mon, 26 Aug 2024 16:20:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DF5818006C;
	Mon, 26 Aug 2024 16:21:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 04/12] mtd: rawnand: cadence: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:39 +0800
Message-ID: <20240826082847.2591036-5-ruanjinjie@huawei.com>
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
from the loop by using for_each_child_of_node_scoped().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index ff92c17def83..3bc89b356963 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2836,7 +2836,6 @@ static void cadence_nand_chips_cleanup(struct cdns_nand_ctrl *cdns_ctrl)
 static int cadence_nand_chips_init(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	struct device_node *np = cdns_ctrl->dev->of_node;
-	struct device_node *nand_np;
 	int max_cs = cdns_ctrl->caps2.max_banks;
 	int nchips, ret;
 
@@ -2849,10 +2848,9 @@ static int cadence_nand_chips_init(struct cdns_nand_ctrl *cdns_ctrl)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = cadence_nand_chip_init(cdns_ctrl, nand_np);
 		if (ret) {
-			of_node_put(nand_np);
 			cadence_nand_chips_cleanup(cdns_ctrl);
 			return ret;
 		}
-- 
2.34.1


