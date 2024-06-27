Return-Path: <linux-kernel+bounces-232643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0391AC40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99280284D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C0199393;
	Thu, 27 Jun 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="b76MvPX4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614C199254
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504344; cv=none; b=NN1jvU6GD9M7w1yi92/tPy+pgsfwRR5QgA9s031wHOexGRB6W+dhlgHZjfSbjPZBuZsbctqotCx4BmSP9EuVXWPiCXmnJH9VRqEIsF/88fizqAjJYoVUD+h3nODGk7kIo9V44VpEOyCLQ9lP3Y42cdV1Rmerm2gYdzQafNib0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504344; c=relaxed/simple;
	bh=L5mkXD5zVVQu9YpRwyWdMkObLsTkmQTCYOs8qYThsZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgmgKsVwAJDHXU77kEFQabKToot2+G+pdpCK0R3bOeAqzOzNJjs4YzmuiVZFugH9xgKNz1FShv5OT709W54cvwz/iSAsPRn9+JC92BCwAOollu7GOdr7zXZIAIwwxodODSNI7b1BOiMUPcFUaO9CSjoSGdX4QMdlFeND10t1n3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=b76MvPX4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id F187A1C0005;
	Thu, 27 Jun 2024 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1719504338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/F6X4rUaUT62SKKSOeWMriVtMrBxmj7Qe14pCP9AiM=;
	b=b76MvPX4KnkFO6JvB0ADN8awbVKTZMg0hb+gUo0Q1PvBm3YGftglPYWsRvwD4WyQ73Rt+5
	sgAULYoAunZrtOIPCXMVGHL7frMCO10en1Qu+Gt+5vOXdT6om6+CnolhlvQM6eS8gPWqw4
	ZMU3lXU4E7eLoaGkKpUWk4/mR8XLzdiUyf53uMgGo0G6xP/CVv5/Yt7PPBMZw0r1nLA8n3
	HcVTBjzCrF3nZziFWt37w+zlYARx2MKxefBzPLm/Te7acjLFFP7M42w/9WRVwtvArWCneY
	dHygddslgW//KAqY5bM7jD33TMOr/kW93e7vabrGJvbMy59/h7Ga9etdNyl6bw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 27 Jun 2024 18:05:29 +0200
Subject: [PATCH v2 2/2] mtd: nand: Add support for M5441x NFC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-upstream-nfc-mcf5441x-v2-2-312929d09ee5@yoseli.org>
References: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
In-Reply-To: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Stefan Agner <stefan@agner.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719504334; l=6726;
 i=jeanmichel.hautbois@yoseli.org; s=20240608; h=from:subject:message-id;
 bh=L5mkXD5zVVQu9YpRwyWdMkObLsTkmQTCYOs8qYThsZo=;
 b=Ytk6wHocEqGvUrABXF7NyDmNx8aG+yeVebk0+kzOnGnhxvF5OUkBblYKQYJQQNX14uEhN4Jnd
 jHCXGrxpkL4Bd1N6uweRNrH6vh9paLCUj/lPsb6Ijyx9TH+Ou2TRpnh
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=oMZuYhJzT0j5MI73RlNUVYaA8VdWpFR/Sao0JKz1D2I=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

The vf610_nfc driver is also the one which should be used for the
coldfire series. Sadly, these device don't support device-tree and so we
need to do a few modifications:
- Adapt the probe to use pdata if available
- Add a new variant as there is a small part to adapt in
vf610_nfc_select_target()
- Add the corresponding missing register definitions

Tested successfully on a 54418 custom board with a raw NAND:
[    2.640000] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
[    2.650000] nand: Micron MT29F4G08ABADAWP
[    2.650000] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/mtd/nand/raw/Kconfig     |   2 +-
 drivers/mtd/nand/raw/vf610_nfc.c | 102 +++++++++++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index cbf8ae85e1ae..2ea3ee32a540 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -252,7 +252,7 @@ config MTD_NAND_FSL_UPM
 
 config MTD_NAND_VF610_NFC
 	tristate "Freescale VF610/MPC5125 NAND controller"
-	depends on (SOC_VF610 || COMPILE_TEST)
+	depends on (SOC_VF610 || COMPILE_TEST || M5441x)
 	depends on HAS_IOMEM
 	help
 	  Enables support for NAND Flash Controller on some Freescale
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index f31d23219f91..9d46b4f57f31 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -146,6 +146,7 @@
 
 enum vf610_nfc_variant {
 	NFC_VFC610 = 1,
+	NFC_M54418 = 2,
 };
 
 struct vf610_nfc {
@@ -486,10 +487,24 @@ static void vf610_nfc_select_target(struct nand_chip *chip, unsigned int cs)
 	if (nfc->variant != NFC_VFC610)
 		return;
 
-	tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
-	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
-	tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
-	tmp |= BIT(cs) << ROW_ADDR_CHIP_SEL_SHIFT;
+	if (nfc->variant == NFC_M54418) {
+		/*
+		 * According to the Reference Manual:
+		 * bit 24: Reserved, must be set (ROW_ADDR_CHIP_SEL_SHIFT)
+		 * bit 25-27: Reserved, must be cleared
+		 * bit 28: Reserved, must be set (ROW_ADDR_CHIP_SEL_RB_SHIFT)
+		 * bit 29-31: Reserved, must be cleared
+		 */
+		tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
+		tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
+		tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
+		tmp |= 1 << ROW_ADDR_CHIP_SEL_SHIFT;
+	} else {
+		tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
+		tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
+		tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
+		tmp |= BIT(cs) << ROW_ADDR_CHIP_SEL_SHIFT;
+	}
 
 	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
 }
@@ -706,6 +721,19 @@ static const struct of_device_id vf610_nfc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, vf610_nfc_dt_ids);
 
+static const struct platform_device_id vf610_nfc_id_table[] = {
+	{
+		.name = "mcf5441x-nfc",
+		.driver_data = (kernel_ulong_t)NFC_M54418,
+	}, {
+		.name = "vf610-nfc",
+		.driver_data = (kernel_ulong_t)NFC_VFC610,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(platform, vf610_nfc_id_table);
+
 static void vf610_nfc_preinit_controller(struct vf610_nfc *nfc)
 {
 	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
@@ -810,7 +838,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	struct vf610_nfc *nfc;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
-	struct device_node *child;
+	struct nand_chip *pdata;
 	int err;
 	int irq;
 
@@ -820,47 +848,70 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	nfc->dev = &pdev->dev;
 	chip = &nfc->chip;
+	pdata = dev_get_platdata(&pdev->dev);
+	if (pdata)
+		*chip = *pdata;
+
 	mtd = nand_to_mtd(chip);
 
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = nfc->dev;
-	mtd->name = DRV_NAME;
+
+	/*
+	 * We keep the MTD name unchanged to avoid breaking platforms
+	 * where the MTD cmdline parser is used and the bootloader
+	 * has not been updated to use the new naming scheme.
+	 */
+	if (!nfc->dev->of_node)
+		mtd->name = "NAND";
+	else
+		mtd->name = DRV_NAME;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
 	nfc->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(nfc->regs))
+	if (IS_ERR(nfc->regs)) {
+		dev_err(nfc->dev, "Unable to map registers!\n");
 		return PTR_ERR(nfc->regs);
+	}
 
-	nfc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	nfc->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	if (IS_ERR(nfc->clk)) {
 		dev_err(nfc->dev, "Unable to get and enable clock!\n");
 		return PTR_ERR(nfc->clk);
 	}
 
-	nfc->variant = (enum vf610_nfc_variant)device_get_match_data(&pdev->dev);
-	if (!nfc->variant)
-		return -ENODEV;
+	if (pdev->dev.of_node) {
+		const void *data = device_get_match_data(&pdev->dev);
 
-	for_each_available_child_of_node(nfc->dev->of_node, child) {
-		if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {
+		nfc->variant = (enum vf610_nfc_variant)data;
+		if (!nfc->variant) {
+			dev_err(nfc->dev, "No variant data found!\n");
+			return -ENODEV;
+		}
 
-			if (nand_get_flash_node(chip)) {
-				dev_err(nfc->dev,
-					"Only one NAND chip supported!\n");
-				of_node_put(child);
-				return -EINVAL;
-			}
+		for_each_available_child_of_node_scoped(nfc->dev->of_node, child) {
+			if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {
 
-			nand_set_flash_node(chip, child);
+				if (nand_get_flash_node(chip)) {
+					dev_err(nfc->dev,
+						"Only one NAND chip supported!\n");
+					of_node_put(child);
+					return -EINVAL;
+				}
+
+				nand_set_flash_node(chip, child);
+			}
 		}
-	}
 
-	if (!nand_get_flash_node(chip)) {
-		dev_err(nfc->dev, "NAND chip sub-node missing!\n");
-		return -ENODEV;
+		if (!nand_get_flash_node(chip)) {
+			dev_err(nfc->dev, "NAND chip sub-node missing!\n");
+			return -ENODEV;
+		}
+	} else {
+		nfc->variant = (enum vf610_nfc_variant)platform_get_device_id(pdev)->driver_data;
 	}
 
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
@@ -937,11 +988,12 @@ static SIMPLE_DEV_PM_OPS(vf610_nfc_pm_ops, vf610_nfc_suspend, vf610_nfc_resume);
 static struct platform_driver vf610_nfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
-		.of_match_table = vf610_nfc_dt_ids,
+		.of_match_table = of_match_ptr(vf610_nfc_dt_ids),
 		.pm	= &vf610_nfc_pm_ops,
 	},
 	.probe		= vf610_nfc_probe,
 	.remove_new	= vf610_nfc_remove,
+	.id_table = vf610_nfc_id_table,
 };
 
 module_platform_driver(vf610_nfc_driver);

-- 
2.43.0


