Return-Path: <linux-kernel+bounces-571728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0BDA6C14C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5A54610EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D722DFB9;
	Fri, 21 Mar 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK+4yxdu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5D22DFB6;
	Fri, 21 Mar 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577807; cv=none; b=OEm6Zcuj2+vtcZRADqKTuOjjfbuBga901FfLTskE4+bpX+FBgJVGT5yuD5S2yv3iS9qHNWJ6QfudUpiLklsnV57tCJbgOWNM2FjH8jfI6hPmaFrmJisru11KVLFinOL/S3wrKA8y4ZXMeXlrMgTldUfUNK2oIcm1skZmuz/TETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577807; c=relaxed/simple;
	bh=S+IAkPHhQIDmnUuM0W5Ap4K+77XsCuqQSs9MmB3xYv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N53ddlCj6CI8n6j1ONIn+4d1eDcT/UiyslH6hSmJy5fVhWEe3lp9tm6YE+170687YE3DVt2dcsV8jJbqd7wolbmBeqdvEZbdVn3HIVpws99PgQAglOhR+4B2PeaAkttw5pan4BFDCjwrxX7efCGpIb6WpQp8uR+La6hb8u+oeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK+4yxdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB746C4CEE3;
	Fri, 21 Mar 2025 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577807;
	bh=S+IAkPHhQIDmnUuM0W5Ap4K+77XsCuqQSs9MmB3xYv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fK+4yxduEx8oCoOWJjSxQs1pUOZQ6bR7PJbKvE+s9PsbtAel2XT+dn/CPPP8uIpO2
	 zeCf18LtNLR0wGOUk1Rl9mG8tx9RHRl562shuvbG8/Xg0GSSr8ObOlAsu2qJTOOfay
	 hLbv3OUHlvUIcdHXtmfePtImVGGCL6Nz/bappqGglFgHnoQPpAuACUs+W6K0z0FrXM
	 iOwkZRjaD6MNbsPuKadjLtB0j6EWHXEIriaoM5/P1T1GDvn0QupRx8enedSynaWSrM
	 fUB8IAYU/er4RbkfSdRelJUCQJ8BphSJvPddZtxSRVsLm1Fj+Vy/6jD/kOGjuFN9ck
	 3vrk+qAWYZvxA==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/9] reset: mpfs: add non-auxiliary bus probing
Date: Fri, 21 Mar 2025 17:22:37 +0000
Message-ID: <20250321-trident-attractor-3b381fd4896a@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6069; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=lwHXgfxRoeE8U0XE5wHFIhgKB1I59PI2wnRhoeZm8OM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0SW7PK1XLDvOPPz7C2erNPz/N4sLZvIbaJ0T+Dv8 oO94T0vOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRPesZGY4EfePNZpdnfV+w 9JP6/IDfYe27VCS+8hX0LzZiWsVSWMjwPzBJcM4MBw1Fw5sRbdc27l6ivvPfY6bFMbY50gkcMfG 3mAE=
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
v2:
Implement the request to use regmap_update_bits(). I found that I then
hated the read/write helpers since they were just bloat, so I ripped
them out. I replaced the regular spin_lock_irqsave() stuff with a
guard(spinlock_irqsave), since that's a simpler way of handling the two
different paths through such a trivial pair of functions.
---
 drivers/reset/reset-mpfs.c | 81 ++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index 574e59db83a4..9c3e996f3a09 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -7,12 +7,15 @@
  *
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
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
@@ -27,11 +30,14 @@
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
 
@@ -46,41 +52,50 @@ static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_dev *rcde
 static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&mpfs_reset_lock, flags);
+	guard(spinlock_irqsave)(&mpfs_reset_lock);
+
+	if (rst->regmap) {
+		regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), BIT(id));
+		return 0;
+	}
 
 	reg = readl(rst->base);
 	reg |= BIT(id);
 	writel(reg, rst->base);
 
-	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
-
 	return 0;
 }
 
 static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&mpfs_reset_lock, flags);
+	guard(spinlock_irqsave)(&mpfs_reset_lock);
+
+	if (rst->regmap) {
+		regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), 0);
+		return 0;
+	}
 
 	reg = readl(rst->base);
 	reg &= ~BIT(id);
 	writel(reg, rst->base);
 
-	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
-
 	return 0;
 }
 
 static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	u32 reg = readl(rst->base);
+	u32 reg;
+
+	if (rst->regmap)
+		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
+	else
+		reg = readl(rst->base);
 
 	/*
 	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
@@ -130,11 +145,45 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
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
@@ -145,8 +194,8 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 
 	rcdev = &rst->rcdev;
 	rcdev->dev = dev;
-	rcdev->dev->parent = dev->parent;
 	rcdev->ops = &mpfs_reset_ops;
+
 	rcdev->of_node = dev->parent->of_node;
 	rcdev->of_reset_n_cells = 1;
 	rcdev->of_xlate = mpfs_reset_xlate;
@@ -222,12 +271,12 @@ static const struct auxiliary_device_id mpfs_reset_ids[] = {
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


