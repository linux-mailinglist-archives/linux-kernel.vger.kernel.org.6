Return-Path: <linux-kernel+bounces-214494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DA908588
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91E11F275F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9C1862AB;
	Fri, 14 Jun 2024 07:59:20 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619614A09F;
	Fri, 14 Jun 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351960; cv=none; b=OCuWFE3m4TdtBM+PzSo64yc7bL+PSO7Cagd0a9qXA4CdvLIss0ygsHSdwuqJd4oJ8Ea2Nu8FNIFicZlwLbEqwicSuC5Macz+09Va7xr1ovY9cIH4pOSk2HQlJNSZQPgMaoJj8AusW0Ib8mURgvgSIUc2WBEh6s8tyzqkoQpKouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351960; c=relaxed/simple;
	bh=Q6Y2SlTjsLMz5xWfLUkFMfcfKjQqFQTLfuhstB6uWjw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Utxu/jiKehwdpyXDerldlFR7pLfcYm36VXmVB748VbqsmtGsplcB5GwoHmHKguATJISS0lDAiCtuckdV2dAhkdZWwtycaJvyg4+aPQOz/x+JVwoMtX/fq3kLLCeL7hN2JfOj43UMedbwJUKBZKQ0JMe5RqDM4csJqfFvtu/krcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2725200DAB;
	Fri, 14 Jun 2024 09:59:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C399200E13;
	Fri, 14 Jun 2024 09:59:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 794AF1820F59;
	Fri, 14 Jun 2024 15:59:08 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: p.zabel@pengutronix.de,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v8 3/5] reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
Date: Fri, 14 Jun 2024 15:42:01 +0800
Message-Id: <1718350923-21392-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for the resets on i.MX8MP Audio Block Control module,
which includes the EARC PHY software reset and EARC controller
software reset. The reset controller is created using the auxiliary
device framework and set up in the clock driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/reset/Kconfig                 |   8 ++
 drivers/reset/Makefile                |   1 +
 drivers/reset/reset-imx8mp-audiomix.c | 106 ++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..b3c0e528d08c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -91,6 +91,14 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_IMX8MP_AUDIOMIX
+	tristate "i.MX8MP AudioMix Reset Driver"
+	depends on CLK_IMX8MP
+	select AUXILIARY_BUS
+	default CLK_IMX8MP
+	help
+	  This enables the reset controller driver for i.MX8MP AudioMix
+
 config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index fd8b49fa46fc..a6796e83900b 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
 obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
+obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_K210) += reset-k210.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
new file mode 100644
index 000000000000..1fc984bc08c0
--- /dev/null
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#define EARC			0x200
+#define EARC_RESET_MASK		0x3
+
+struct imx8mp_audiomix_reset {
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+};
+
+static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct imx8mp_audiomix_reset, rcdev);
+}
+
+static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
+					unsigned long id)
+{
+	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
+	void __iomem *reg_addr = priv->base;
+	unsigned int mask, reg;
+
+	if (id >= fls(EARC_RESET_MASK))
+		return -EINVAL;
+
+	mask = BIT(id);
+	reg = readl(reg_addr + EARC);
+	writel(reg & ~mask, reg_addr + EARC);
+
+	return 0;
+}
+
+static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
+					  unsigned long id)
+{
+	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
+	void __iomem *reg_addr = priv->base;
+	unsigned int mask, reg;
+
+	if (id >= fls(EARC_RESET_MASK))
+		return -EINVAL;
+
+	mask = BIT(id);
+	reg = readl(reg_addr + EARC);
+	writel(reg | mask, reg_addr + EARC);
+
+	return 0;
+}
+
+static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
+	.assert   = imx8mp_audiomix_reset_assert,
+	.deassert = imx8mp_audiomix_reset_deassert,
+};
+
+static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
+				       const struct auxiliary_device_id *id)
+{
+	struct imx8mp_audiomix_reset *priv;
+	struct device *dev = &adev->dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->rcdev.owner     = THIS_MODULE;
+	priv->rcdev.nr_resets = fls(EARC_RESET_MASK);
+	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
+	priv->rcdev.of_node   = dev->parent->of_node;
+	priv->rcdev.dev	      = dev;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->base            = of_iomap(dev->parent->of_node, 0);
+
+	return devm_reset_controller_register(dev, &priv->rcdev);
+}
+
+static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
+	{
+		.name = "clk_imx8mp_audiomix.reset",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
+
+static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
+	.probe		= imx8mp_audiomix_reset_probe,
+	.id_table	= imx8mp_audiomix_reset_ids,
+};
+
+module_auxiliary_driver(imx8mp_audiomix_reset_driver);
+
+MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
+MODULE_DESCRIPTION("Freescale i.MX8MP Audio Block Controller reset driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


