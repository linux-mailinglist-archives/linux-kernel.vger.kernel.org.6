Return-Path: <linux-kernel+bounces-300986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603195EB42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EB1F22648
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259CF1474B9;
	Mon, 26 Aug 2024 07:56:25 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453213AA4C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658984; cv=none; b=IrnyID7V1X1JgGcGfb/ybUvI1ftGUnRLymCTdU3ouSa+F0xtfo9BHqzfiNarIMgAucjBm6261rW9e1BynGfFKXmdfw6oNwQzHpDUXjBkw41zEq6X5cxvpGdOQkVx/oKOov2Oin2yHj8exIWu+oGE4JVP5WyY6twVeAvdTMzkiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658984; c=relaxed/simple;
	bh=yl2J7lxhc61TQUz0GPf28a5fKqHnTpQ4Z0kdUH6ewNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9CvTO6VMyBCtG8Lh/OUkXLzbByb0I6i5ixXU0mDitAw3Sbj/5GhBdtTiN6vKXuUAC9UiozGrM5d0Li41MZ7jy1n5FGENur5FHVjwrVzyrZcpbHACyxpPMRW7D9u/uYa1IP76QBEQdEN4eotQJgVGLr3MoQstURhwnXtQb4t9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WsjYH4HlYz20mg2;
	Mon, 26 Aug 2024 15:51:31 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 97E4F140120;
	Mon, 26 Aug 2024 15:56:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 15:56:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] mtd: rawnand: denali: Use the devm_clk_get_enabled() helper function
Date: Mon, 26 Aug 2024 16:04:08 +0800
Message-ID: <20240826080408.2522978-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The devm_clk_get_enabled() helper:
  - calls devm_clk_get()
  - calls clk_prepare_enable() and registers what is needed in order to
    call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mtd/nand/raw/denali_dt.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index edac8749bb93..2f5666511fda 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -145,15 +145,15 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (IS_ERR(denali->host))
 		return PTR_ERR(denali->host);
 
-	dt->clk = devm_clk_get(dev, "nand");
+	dt->clk = devm_clk_get_enabled(dev, "nand");
 	if (IS_ERR(dt->clk))
 		return PTR_ERR(dt->clk);
 
-	dt->clk_x = devm_clk_get(dev, "nand_x");
+	dt->clk_x = devm_clk_get_enabled(dev, "nand_x");
 	if (IS_ERR(dt->clk_x))
 		return PTR_ERR(dt->clk_x);
 
-	dt->clk_ecc = devm_clk_get(dev, "ecc");
+	dt->clk_ecc = devm_clk_get_enabled(dev, "ecc");
 	if (IS_ERR(dt->clk_ecc))
 		return PTR_ERR(dt->clk_ecc);
 
@@ -165,18 +165,6 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (IS_ERR(dt->rst_reg))
 		return PTR_ERR(dt->rst_reg);
 
-	ret = clk_prepare_enable(dt->clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(dt->clk_x);
-	if (ret)
-		goto out_disable_clk;
-
-	ret = clk_prepare_enable(dt->clk_ecc);
-	if (ret)
-		goto out_disable_clk_x;
-
 	denali->clk_rate = clk_get_rate(dt->clk);
 	denali->clk_x_rate = clk_get_rate(dt->clk_x);
 
@@ -187,7 +175,7 @@ static int denali_dt_probe(struct platform_device *pdev)
 	 */
 	ret = reset_control_deassert(dt->rst_reg);
 	if (ret)
-		goto out_disable_clk_ecc;
+		return ret;
 
 	ret = reset_control_deassert(dt->rst);
 	if (ret)
@@ -222,12 +210,6 @@ static int denali_dt_probe(struct platform_device *pdev)
 	reset_control_assert(dt->rst);
 out_assert_rst_reg:
 	reset_control_assert(dt->rst_reg);
-out_disable_clk_ecc:
-	clk_disable_unprepare(dt->clk_ecc);
-out_disable_clk_x:
-	clk_disable_unprepare(dt->clk_x);
-out_disable_clk:
-	clk_disable_unprepare(dt->clk);
 
 	return ret;
 }
@@ -239,9 +221,6 @@ static void denali_dt_remove(struct platform_device *pdev)
 	denali_remove(&dt->controller);
 	reset_control_assert(dt->rst);
 	reset_control_assert(dt->rst_reg);
-	clk_disable_unprepare(dt->clk_ecc);
-	clk_disable_unprepare(dt->clk_x);
-	clk_disable_unprepare(dt->clk);
 }
 
 static struct platform_driver denali_dt_driver = {
-- 
2.34.1


