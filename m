Return-Path: <linux-kernel+bounces-178536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE898C4F25
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1D9B20BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7713AD2F;
	Tue, 14 May 2024 09:54:36 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8157880;
	Tue, 14 May 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680476; cv=none; b=ilyXTDNRND7IBkd80DtpkVlqa6C0hVEBJyxGNvQsoiSBD9FtdIyBoyM1m8hk9VloflDeqIOKMbHUO3vFt8SS6zlq5eRKDbZ4bXsz5zmAcjRcXZ693/zGHZe7pAeIBn6GYgiK6ddcEYWfzUO0BhQ6iDdJWCFN0AZ8qXFUjzgAiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680476; c=relaxed/simple;
	bh=GsrDLzJ8yr8yaREvNeORn0JlgmRhR20FlHA3DcMbeI8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=YYPega9c7UVG5CjMkxPaGsjA0JAeSpW1Ba28wD72/aWc0W1FByhCFD3qUNe5g9/PbwlvvLjQSJKcwPGKoDp+8It7D2YCPpou/lR0XPOrg3kXdyBNUjVRAlvS0mKOtqkiCRqyV7Rjw8ySZWfDz5UkkOxoJQE4ozgR/LLv2FdQlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F3779200B9F;
	Tue, 14 May 2024 11:52:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FE67200BC5;
	Tue, 14 May 2024 11:52:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 28378180222C;
	Tue, 14 May 2024 17:52:56 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
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
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 2/6] reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
Date: Tue, 14 May 2024 17:33:26 +0800
Message-Id: <1715679210-9588-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Audiomix block control can be a reset controller for
Enhanced Audio Return Channel (EARC), which is one of
modules in this audiomix subsystem.

The EARC PHY software reset and EARC controller software
reset need to be supported.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/reset/Kconfig                 |   8 ++
 drivers/reset/Makefile                |   1 +
 drivers/reset/reset-imx8mp-audiomix.c | 117 ++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..0e7da0bb0a21 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -91,6 +91,14 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_IMX8MP_AUDIOMIX
+	tristate "i.MX8MP AudioMix Reset Driver"
+	depends on HAS_IOMEM
+	depends on (ARM64 && ARCH_MXC) || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  This enables the reset controller driver for i.MX8MP AudioMix.
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
index 000000000000..8ba0d4406b36
--- /dev/null
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#define EARC			0x200
+#define EARC_RESET_MASK		0x3
+
+struct imx8mp_audiomix_rst_priv {
+	struct regmap *regmap;
+	struct reset_controller_dev rcdev;
+};
+
+static int imx8mp_audiomix_reset_set(struct reset_controller_dev *rcdev,
+				     unsigned long id, bool assert)
+{
+	struct imx8mp_audiomix_rst_priv *priv = container_of(rcdev,
+				struct imx8mp_audiomix_rst_priv, rcdev);
+	unsigned int mask = BIT(id);
+
+	/* bit = 0 reset, bit = 1 unreset */
+	if (assert)
+		regmap_update_bits(priv->regmap, EARC, mask, 0);
+	else
+		regmap_update_bits(priv->regmap, EARC, mask, mask);
+
+	return 0;
+}
+
+static int imx8mp_audiomix_reset_reset(struct reset_controller_dev *rcdev,
+				       unsigned long id)
+{
+	imx8mp_audiomix_reset_set(rcdev, id, true);
+
+	return imx8mp_audiomix_reset_set(rcdev, id, false);
+}
+
+static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
+					unsigned long id)
+{
+	return imx8mp_audiomix_reset_set(rcdev, id, true);
+}
+
+static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
+					  unsigned long id)
+{
+	return imx8mp_audiomix_reset_set(rcdev, id, false);
+}
+
+static int imx8mp_audiomix_reset_xlate(struct reset_controller_dev *rcdev,
+				       const struct of_phandle_args *reset_spec)
+{
+	unsigned long id = reset_spec->args[0];
+
+	if (!(BIT(id) & EARC_RESET_MASK))
+		return -EINVAL;
+
+	return id;
+}
+
+static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
+	.reset = imx8mp_audiomix_reset_reset,
+	.assert = imx8mp_audiomix_reset_assert,
+	.deassert = imx8mp_audiomix_reset_deassert,
+};
+
+static int imx8mp_audiomix_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	struct imx8mp_audiomix_rst_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->rcdev.owner     = THIS_MODULE;
+	priv->rcdev.nr_resets = fls(EARC_RESET_MASK);
+	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
+	priv->rcdev.of_node   = pdev->dev.of_node;
+	priv->rcdev.dev	      = &pdev->dev;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.of_xlate  = imx8mp_audiomix_reset_xlate;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
+static const struct of_device_id imx8mp_audiomix_reset_dt_match[] = {
+	{ .compatible = "fsl,imx8mp-audiomix-reset" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx8mp_audiomix_reset_dt_match);
+
+static struct platform_driver imx8mp_audiomix_reset_driver = {
+	.probe	= imx8mp_audiomix_reset_probe,
+	.driver	= {
+		.name = "imx8mp-audiomix-reset",
+		.of_match_table = imx8mp_audiomix_reset_dt_match,
+	},
+};
+module_platform_driver(imx8mp_audiomix_reset_driver);
+
+MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
+MODULE_DESCRIPTION("Freescale i.MX8MP Audio Block Controller reset driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


