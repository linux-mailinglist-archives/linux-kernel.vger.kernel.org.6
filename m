Return-Path: <linux-kernel+bounces-347359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7198D1A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFFFB248F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17AF20126D;
	Wed,  2 Oct 2024 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuxCWszQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7320125B;
	Wed,  2 Oct 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866121; cv=none; b=B4YhkC+SkAEujfefYtP70nOTy4MV5O9V2MYNOm8wv1TfTsPOoWpp/7rKed0sEvSaa8ylaxSAjC037dyXtxI6CQKeJhY+LBt9NEZjhaGctQHfAS/X1Q5ZGRtM72hvhlz7K/3sUUV8xHU6+W34pbV9qdJj+YGbO/QoBOPeZQrMHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866121; c=relaxed/simple;
	bh=aO/B5sOpOxYNDl2NnVgAoNdJHBau2D0IQZssejD8wN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDM44nvbU42VXbRom4bSAGGIEKufzv4K6BNx6h8qg4nLb8Ua4c86d/p6it6F8XccTO70graLwb6nDIH5hm5MfJg+Hr8+9LtNanWynJhuO13HzlNkYZqHVpWykGD9b7DP1pbmLD7gjejU/UN0roPaKUp/8q2N0GKpaeOBYGqW4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuxCWszQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0F1C4CECF;
	Wed,  2 Oct 2024 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866120;
	bh=aO/B5sOpOxYNDl2NnVgAoNdJHBau2D0IQZssejD8wN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuxCWszQEiOTLxYShOLqf1wvo1xjoc0uyEKUXsZGcXfBoUydX7yRQ5gVt+SHtInch
	 lD/QqnAXK7g2wWxR5ma+NKH2tqS44Jp0moFVzFkzMvt1SfeWXHdCWv2QtkD72FgJAX
	 YJELvmMxa7y/02Fqb3NAkyVoxDZ/QgdvVmJgV3EneD+QJRgwfq51z+XcqlxnVZ+WIl
	 B8NNd0tRFKF+1jARSRlUKd5/SiMIzXd8Rhe9r9JbTEgPLBy6VNizK2SGewSgeiq9wv
	 juBNdYJFFTQap1Nd5xkSwuSkl3tWXiaWERUOQdwjYXbI/JeDHvqGOrZF5F1vAqT2px
	 pgu3gjpB0BM5g==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 06/11] reset: mpfs: add non-auxiliary bus probing
Date: Wed,  2 Oct 2024 11:48:04 +0100
Message-ID: <20241002-breeze-anywhere-4114da636ec6@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5754; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=i35+CsFCV6sYfJT3KjLRVBUt7UkYZ1HKKhA4wN86iUQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR6eDFO8tGTeB5GOJKuovLnZ50Jmp+88oLrKMq3ts 09enm54RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbC78nwP+KTgmbztesTTtTa WS9XXcj5U0ohW7nR0OX5k+Yj/OsKrzMy7LX5YqEg/G1yF6vTlJrZRqcfnakPjpc4s+KFYsJMa7V CTgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

While the auxiliary bus was a nice bandaid, and meant that re-writing
the representation of the clock regions in devicetree was not required,
it has run its course. The "mss_top_sysreg" region that contains the
clock and reset regions, also contains pinctrl and an interrupt
controller, so the time has come rewrite the devicetree and probe the
reset controller from an mfd devicetree node, rather than implement
those drivers using the auxiliary bus. Wanting to avoid propagating this
naive/incorrect description of the hardware to the new pic64gx SoC is a
major motivating factor here.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/reset/reset-mpfs.c | 83 ++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index 710f9c1676f93..ac72e0fc405ed 100644
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
@@ -27,14 +29,37 @@
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
 
+static inline u32 mpfs_reset_read(struct mpfs_reset *rst)
+{
+	u32 ret;
+
+	if (rst->regmap)
+		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &ret);
+	else
+		ret = readl(rst->base);
+
+	return ret;
+}
+
+static inline void mpfs_reset_write(struct mpfs_reset *rst, u32 val)
+{
+	if (rst->regmap)
+		regmap_write(rst->regmap, REG_SUBBLK_RESET_CR, val);
+	else
+		writel(val, rst->base);
+}
+
 static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct mpfs_reset, rcdev);
@@ -51,9 +76,9 @@ static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	spin_lock_irqsave(&mpfs_reset_lock, flags);
 
-	reg = readl(rst->base);
+	reg = mpfs_reset_read(rst);
 	reg |= BIT(id);
-	writel(reg, rst->base);
+	mpfs_reset_write(rst, reg);
 
 	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
 
@@ -68,9 +93,9 @@ static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	spin_lock_irqsave(&mpfs_reset_lock, flags);
 
-	reg = readl(rst->base);
+	reg = mpfs_reset_read(rst);
 	reg &= ~BIT(id);
-	writel(reg, rst->base);
+	mpfs_reset_write(rst, reg);
 
 	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
 
@@ -80,7 +105,7 @@ static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	u32 reg = readl(rst->base);
+	u32 reg = mpfs_reset_read(rst);
 
 	/*
 	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
@@ -130,11 +155,45 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
 	return index - MPFS_PERIPH_OFFSET;
 }
 
-static int mpfs_reset_probe(struct auxiliary_device *adev,
-			    const struct auxiliary_device_id *id)
+static int mpfs_reset_mfd_probe(struct platform_device *pdev)
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
+	rcdev = &rst->rcdev;
+	rcdev->dev = dev;
+	rcdev->ops = &mpfs_reset_ops;
+
+	rcdev->of_node = pdev->dev.parent->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	rst->regmap = device_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(rst->regmap))
+		dev_err_probe(dev, PTR_ERR(rst->regmap), "Failed to find syscon regmap\n");
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
+static struct platform_driver mpfs_reset_mfd_driver = {
+	.probe		= mpfs_reset_mfd_probe,
+	.driver = {
+		.name = "mpfs-reset",
+	},
+};
+module_platform_driver(mpfs_reset_mfd_driver);
+
+static int mpfs_reset_adev_probe(struct auxiliary_device *adev,
+				 const struct auxiliary_device_id *id)
+{
+	struct reset_controller_dev *rcdev;
+	struct device *dev = &adev->dev;
 	struct mpfs_reset *rst;
 
 	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
@@ -145,8 +204,8 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 
 	rcdev = &rst->rcdev;
 	rcdev->dev = dev;
-	rcdev->dev->parent = dev->parent;
 	rcdev->ops = &mpfs_reset_ops;
+
 	rcdev->of_node = dev->parent->of_node;
 	rcdev->of_reset_n_cells = 1;
 	rcdev->of_xlate = mpfs_reset_xlate;
@@ -222,12 +281,12 @@ static const struct auxiliary_device_id mpfs_reset_ids[] = {
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
2.45.2


