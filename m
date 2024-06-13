Return-Path: <linux-kernel+bounces-212482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32395906197
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E8285A18
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447512C460;
	Thu, 13 Jun 2024 02:08:10 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0582D6D;
	Thu, 13 Jun 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244489; cv=none; b=nM3L4RGNKQVSdquo1aDFdADVPQ+aAzS9S/IkT7CAm1G2R97yz0gZ2xPzV0jVrjyOXCUteXAbEFsCDGbqaLaYToCoi5xvCrTPCzXIlQqM/vJgL/iq/kGrcuCK9KHXw2N03uLkt6obi3ezJ7hEF6dMFvGocA/dW05UGIWf+W4J/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244489; c=relaxed/simple;
	bh=YPgb+EPpvBCyCUn2T8yebqm7ABelOMAksMUoCilfuQE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Iv/kpLTIduc34D43XmBiOX7/udHesCS2B7z/qlTmZ1uX8+Tbj6RM8+8ezxchb8JnmNByavdpVzx6X7xEeBGocCA+rMfjog/gMg7y4klSQ2bW0Z962Vnq1ntpVfPKqA9E7VCxSG2tGg6jfYlY6NNkO5bfp2Nq12sF26+/WyHcRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 67BB22002A5;
	Thu, 13 Jun 2024 04:08:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDA42201460;
	Thu, 13 Jun 2024 04:08:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 65607181D0F9;
	Thu, 13 Jun 2024 10:08:02 +0800 (+08)
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
Subject: [PATCH v7 3/5] reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
Date: Thu, 13 Jun 2024 09:51:20 +0800
Message-Id: <1718243482-18552-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718243482-18552-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718243482-18552-1-git-send-email-shengjiu.wang@nxp.com>
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
---
 drivers/reset/Kconfig                 |   8 ++
 drivers/reset/Makefile                |   1 +
 drivers/reset/reset-imx8mp-audiomix.c | 103 ++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
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
index 000000000000..f3f9f5420c14
--- /dev/null
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -0,0 +1,103 @@
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
+struct imx8mp_audiomix_reset_priv {
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+};
+
+static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
+					unsigned long id)
+{
+	struct imx8mp_audiomix_reset_priv *priv = container_of(rcdev,
+					struct imx8mp_audiomix_reset_priv, rcdev);
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
+	struct imx8mp_audiomix_reset_priv *priv = container_of(rcdev,
+					struct imx8mp_audiomix_reset_priv, rcdev);
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
+	struct imx8mp_audiomix_reset_priv *priv;
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


