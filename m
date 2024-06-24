Return-Path: <linux-kernel+bounces-226609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D29140E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD931F22512
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF198C13;
	Mon, 24 Jun 2024 04:02:59 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D8376;
	Mon, 24 Jun 2024 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719201779; cv=none; b=tj0LYav/2kdjm1r3m+ff6SL+6KCMOUVY+yRccKmZ+acRwh1dUE7EGDsuLI1fpaxJCEK3ex5/LVQ3gj0kiIllG1CMpCiG95D591jNN8c00zv4SgD3PLByQXrN3nGUQtvfLUHbDSdpFety9Av4KwsT5TnR7U198/qouKNq2RAMk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719201779; c=relaxed/simple;
	bh=ohUxX1PvWv6zwsoCgYQIQEDysh4aaTx6J6uvF2CJn9E=;
	h=From:To:Subject:Date:Message-Id; b=RimOash39jyZnWjOiiDeyvruP6+cx3tL/gUxWm3IIk9UlMm8gYYQ2Xf0wR5yK569Q81VqZ1KueS4jYZEjeHiSlYTjjq7b1CcuyP9mbUi698wB9AqnvAU45SpeMuhNvGI6gNhmxw/oY2wUEpoZ6C5RMfEuIXnNFdv+LiZuyvx0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B755A2000BA;
	Mon, 24 Jun 2024 05:56:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A08920134F;
	Mon, 24 Jun 2024 05:56:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C41BC183C309;
	Mon, 24 Jun 2024 11:56:28 +0800 (+08)
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
Subject: [PATCH v9] reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
Date: Mon, 24 Jun 2024 11:39:05 +0800
Message-Id: <1719200345-32006-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
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
changes in v9:
- only send this commits because others have been applied
- remove depends on in config
- add spin lock
- call iounmmap()

changes in v8:
https://lore.kernel.org/linux-arm-kernel/27ea1bf7de6f349426fcd7ddb056a1adfae47c73.camel@pengutronix.de/T/

 drivers/reset/Kconfig                 |   7 ++
 drivers/reset/Makefile                |   1 +
 drivers/reset/reset-imx8mp-audiomix.c | 128 ++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..509f70e5c4c0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -91,6 +91,13 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_IMX8MP_AUDIOMIX
+	tristate "i.MX8MP AudioMix Reset Driver"
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
index 000000000000..6e3f3069f727
--- /dev/null
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -0,0 +1,128 @@
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
+#include <linux/reset-controller.h>
+
+#define EARC			0x200
+#define EARC_RESET_MASK		0x3
+
+struct imx8mp_audiomix_reset {
+	struct reset_controller_dev rcdev;
+	spinlock_t lock; /* protect register read-modify-write cycle */
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
+	unsigned long flags;
+
+	mask = BIT(id);
+	spin_lock_irqsave(&priv->lock, flags);
+	reg = readl(reg_addr + EARC);
+	writel(reg & ~mask, reg_addr + EARC);
+	spin_unlock_irqrestore(&priv->lock, flags);
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
+	unsigned long flags;
+
+	mask = BIT(id);
+	spin_lock_irqsave(&priv->lock, flags);
+	reg = readl(reg_addr + EARC);
+	writel(reg | mask, reg_addr + EARC);
+	spin_unlock_irqrestore(&priv->lock, flags);
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
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+
+	priv->rcdev.owner     = THIS_MODULE;
+	priv->rcdev.nr_resets = fls(EARC_RESET_MASK);
+	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
+	priv->rcdev.of_node   = dev->parent->of_node;
+	priv->rcdev.dev	      = dev;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->base            = of_iomap(dev->parent->of_node, 0);
+	if (!priv->base)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	ret = devm_reset_controller_register(dev, &priv->rcdev);
+	if (ret)
+		goto out_unmap;
+
+	return 0;
+
+out_unmap:
+	iounmap(priv->base);
+	return ret;
+}
+
+static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
+{
+	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
+
+	iounmap(priv->base);
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
+	.remove		= imx8mp_audiomix_reset_remove,
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


