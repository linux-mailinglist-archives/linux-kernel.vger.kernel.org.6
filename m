Return-Path: <linux-kernel+bounces-288049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B2B953234
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A566287F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849571AD9D6;
	Thu, 15 Aug 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOqlzuML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E24762D2;
	Thu, 15 Aug 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730520; cv=none; b=E+NaMS34CDrlAIob+nhANK5rERf4eeF5OVTnugSBVUaYTsr20keVWud584Zmcf0U+v9e8d7QZYBi4UDNMQqFZC2Dijc65k1b2kSR/aAQv/ve0jjQeC3d+xxo15je1xJkSE77ft62HBhqHKuQbYXwOL6GyA8SO8z2yfkPp6rd2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730520; c=relaxed/simple;
	bh=6yhvBvaGny+69tZh8nZxve26/b/KbXhb3BRlyWJ7W+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSlLo584UWREEktfSY27NDmGGcHr7agI5Yz0fuFyVXPu1f8PVsNhv/pQM4suRsy8n4zmHznip119GnLi6ubLbgAtXo7pIe2tgxbX/8NDP7snCJ6ocXA78F1YWLOJnmdGuFDd8ugmiqN35oTSGfxbJWlxScjNSxvEOJtx/OfbJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOqlzuML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2374C4AF0A;
	Thu, 15 Aug 2024 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730520;
	bh=6yhvBvaGny+69tZh8nZxve26/b/KbXhb3BRlyWJ7W+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOqlzuMLSub6ZxlDDOKcQCu5vgxtpICLFbQRzwogjPi2T8/YV4bu/VwqrCv3rPZr4
	 VHUWFG7YBPO9KGHLWtU/WGL55M3u3xunNoSDzP7vHdTJTA/jFaoPL56Qt2CXepJ8Yt
	 8DDMXjbu0kNlbw3MzdxZ+jbH/rye7RBJocMGXUTsj4u2ZYY5PVgMNXpwJN5U9FBZuO
	 /oywWnU2mPRbw9g2UtKrkESm/ai7/K4aIkzErfABVKLwZCi47q0HK+iL/e1WQIm0tq
	 YwbufTcrM4sKc8VajiXAc2dTBneMjedl8Ou/R3GyP//DfxZsx//E4vhnLUWcX5GT9L
	 gzNpEtyo6NRMw==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/11] reset: mpfs: add non-auxiliary bus probing
Date: Thu, 15 Aug 2024 15:01:10 +0100
Message-ID: <20240815-applicant-finch-0419dfefb71a@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5379; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=wWv2IKjZ/+NYYa1Ld7U/AwY7oWpSP4gWZ0iOuf4p1PE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHQ7Zl0XN76VLdvEKfxs84YY0Sk95Rn/S5rVxTcqT HMWlH3ZUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIk4hTP8lX1aKb0rkJnpsuoU yVan26WCDTIZkud26KyOOrnywkNPfYafjL33mJPXLGQ/vTk9+d5bts6Uq7Z/D77Qzo5+4JpzSGo uIwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

While the auxiliary bus was a nice bandaid, and meant that re-writing
the representation of the clock regions in devicetree was not required,
it has run its course. The "mss_top_sysreg" region that contains the
clock and reset regions, also contains pinctrl and an interrupt
controller, so the time has come rewrite the devicetree and probe the
reset controller from a dedicated devicetree node, rather than implement
those drivers using the auxiliary bus. Wanting to avoid propagating this
naive/incorrect description of the hardware to the new pic64gx SoC is a
major motivating factor here.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/reset/reset-mpfs.c | 86 +++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index 710f9c1676f9..3b5c1f680e79 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -9,10 +9,12 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
@@ -27,11 +29,14 @@
 #define MPFS_SLEEP_MIN_US	100
 #define MPFS_SLEEP_MAX_US	200
 
+#define REG_SUBBLK_RESET_CR	0x88u
+
 /* block concurrent access to the soft reset register */
 static DEFINE_SPINLOCK(mpfs_reset_lock);
 
 struct mpfs_reset {
 	void __iomem *base;
+	struct regmap *regmap;
 	struct reset_controller_dev rcdev;
 };
 
@@ -51,9 +56,17 @@ static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	spin_lock_irqsave(&mpfs_reset_lock, flags);
 
-	reg = readl(rst->base);
+	if (rst->regmap)
+		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
+	else
+		reg = readl(rst->base);
+
 	reg |= BIT(id);
-	writel(reg, rst->base);
+
+	if (rst->regmap)
+		regmap_write(rst->regmap, REG_SUBBLK_RESET_CR, reg);
+	else
+		writel(reg, rst->base);
 
 	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
 
@@ -68,9 +81,17 @@ static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	spin_lock_irqsave(&mpfs_reset_lock, flags);
 
-	reg = readl(rst->base);
+	if (rst->regmap)
+		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
+	else
+		reg = readl(rst->base);
+
 	reg &= ~BIT(id);
-	writel(reg, rst->base);
+
+	if (rst->regmap)
+		regmap_write(rst->regmap, REG_SUBBLK_RESET_CR, reg);
+	else
+		writel(reg, rst->base);
 
 	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
 
@@ -130,11 +151,54 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
 	return index - MPFS_PERIPH_OFFSET;
 }
 
-static int mpfs_reset_probe(struct auxiliary_device *adev,
-			    const struct auxiliary_device_id *id)
+static int mpfs_reset_of_probe(struct platform_device *pdev)
 {
-	struct device *dev = &adev->dev;
 	struct reset_controller_dev *rcdev;
+	struct device *dev = &pdev->dev;
+	struct mpfs_reset *rst;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(rst->regmap))
+		dev_err_probe(dev, PTR_ERR(rst->regmap), "Failed to find syscon regmap\n");
+
+	rcdev = &rst->rcdev;
+	rcdev->dev = dev;
+	rcdev->ops = &mpfs_reset_ops;
+
+	rcdev->of_node = dev->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	printk("of probe\n");
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
+static const struct of_device_id mpfs_reset_of_match[] = {
+	{ .compatible = "microchip,mpfs-reset", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpfs_reset_of_match);
+
+static struct platform_driver mpfs_reset_of_driver = {
+	.probe		= mpfs_reset_of_probe,
+	.driver = {
+		.name = "mpfs-reset",
+		.of_match_table = mpfs_reset_of_match,
+	},
+};
+module_platform_driver(mpfs_reset_of_driver);
+
+static int mpfs_reset_adev_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	struct reset_controller_dev *rcdev;
+	struct device *dev = &adev->dev;
 	struct mpfs_reset *rst;
 
 	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
@@ -145,8 +209,8 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 
 	rcdev = &rst->rcdev;
 	rcdev->dev = dev;
-	rcdev->dev->parent = dev->parent;
 	rcdev->ops = &mpfs_reset_ops;
+
 	rcdev->of_node = dev->parent->of_node;
 	rcdev->of_reset_n_cells = 1;
 	rcdev->of_xlate = mpfs_reset_xlate;
@@ -222,12 +286,12 @@ static const struct auxiliary_device_id mpfs_reset_ids[] = {
 };
 MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
 
-static struct auxiliary_driver mpfs_reset_driver = {
-	.probe		= mpfs_reset_probe,
+static struct auxiliary_driver mpfs_reset_aux_driver = {
+	.probe		= mpfs_reset_adev_probe,
 	.id_table	= mpfs_reset_ids,
 };
 
-module_auxiliary_driver(mpfs_reset_driver);
+module_auxiliary_driver(mpfs_reset_aux_driver);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-- 
2.43.0


