Return-Path: <linux-kernel+bounces-169298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F218BC679
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BE91F21C90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E34C62E;
	Mon,  6 May 2024 04:17:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79454438F;
	Mon,  6 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969064; cv=none; b=JvB0bDK4Tdlwx2ZMRLaaUuKXuSxq7912SDOdN7sEAJi3rbu5ojK4jtS9Da3/xYCS4B6cOW18ByFhjYrnqz5KQHLyXyDwwkiis7ZpEYAEomCaIB4FdxUh4xGoF8hk07+1fuuTP+hOQ2GicFtRZ+J8cztBNKPJQ+0JQZFiOgGTkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969064; c=relaxed/simple;
	bh=4CEjQSYX3GXUZ4ocoRPzhRwNngXzTisWUSOPcHSJ/4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uTcUsWZtQvtMsCDMMWSZWkiAWuYHyNWhHT8v2a+ScqgTnGBTP24hC1sOJfowd/lNBrZ3T/ATd061Jnd+fcW9UsvhsHDgEmHyGPjYwWGoaJ453gr58XiD3Cvv0NTxpqu7Q/Tdm2m3XqDrWPdecQOiKd276ODChb5WpAzGVq1XO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05FDB200444;
	Mon,  6 May 2024 06:08:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B81B20032E;
	Mon,  6 May 2024 06:08:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 29905181D0FD;
	Mon,  6 May 2024 12:08:16 +0800 (+08)
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
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/4] clk: imx: clk-audiomix: Add reset controller
Date: Mon,  6 May 2024 11:49:17 +0800
Message-Id: <1714967359-27905-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
References: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Audiomix block control can be a reset controller for
Enhanced Audio Return Channel (eARC).

The eARC PHY software reset and eARC controller software
reset can be supported.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 82 +++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index ae2c0f254225..58630b521e67 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset-controller.h>
 
 #include <dt-bindings/clock/imx8mp-clock.h>
 
@@ -36,6 +37,8 @@
 #define SAI_PLL_MNIT_CTL	0x410
 #define IPG_LP_CTRL		0x504
 
+#define EARC_RESET_MASK		0x3
+
 #define SAIn_MCLK1_PARENT(n)						\
 static const struct clk_parent_data					\
 clk_imx8mp_audiomix_sai##n##_mclk1_parents[] = {			\
@@ -213,6 +216,7 @@ static const u16 audiomix_regs[] = {
 struct clk_imx8mp_audiomix_priv {
 	void __iomem *base;
 	u32 regs_save[ARRAY_SIZE(audiomix_regs)];
+	struct reset_controller_dev rcdev;
 
 	/* Must be last */
 	struct clk_hw_onecell_data clk_data;
@@ -233,6 +237,80 @@ static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
 	}
 }
 
+static int clk_imx8mp_audiomix_reset_set(struct reset_controller_dev *rcdev,
+					 unsigned long id, bool assert)
+{
+	struct clk_imx8mp_audiomix_priv *drvdata = container_of(rcdev,
+				struct clk_imx8mp_audiomix_priv, rcdev);
+	unsigned int mask = BIT(id);
+	u32 reg;
+
+	pm_runtime_get_sync(rcdev->dev);
+
+	/* bit = 0 reset, bit = 1 unreset */
+	reg = readl(drvdata->base + EARC);
+	if (assert)
+		writel(reg & ~mask, drvdata->base + EARC);
+	else
+		writel(reg | mask, drvdata->base + EARC);
+
+	pm_runtime_put_sync(rcdev->dev);
+
+	return 0;
+}
+
+static int clk_imx8mp_audiomix_reset_reset(struct reset_controller_dev *rcdev,
+					   unsigned long id)
+{
+	clk_imx8mp_audiomix_reset_set(rcdev, id, true);
+
+	return clk_imx8mp_audiomix_reset_set(rcdev, id, false);
+}
+
+static int clk_imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
+					    unsigned long id)
+{
+	return clk_imx8mp_audiomix_reset_set(rcdev, id, true);
+}
+
+static int clk_imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
+					      unsigned long id)
+{
+	return clk_imx8mp_audiomix_reset_set(rcdev, id, false);
+}
+
+static int clk_imx8mp_audiomix_reset_xlate(struct reset_controller_dev *rcdev,
+					   const struct of_phandle_args *reset_spec)
+{
+	unsigned long id = reset_spec->args[0];
+
+	if (!(BIT(id) & EARC_RESET_MASK))
+		return -EINVAL;
+
+	return id;
+}
+
+static const struct reset_control_ops clk_imx8mp_audiomix_reset_ops = {
+	.reset		= clk_imx8mp_audiomix_reset_reset,
+	.assert		= clk_imx8mp_audiomix_reset_assert,
+	.deassert	= clk_imx8mp_audiomix_reset_deassert,
+};
+
+static int clk_imx8mp_audiomix_register_reset_controller(struct device *dev)
+{
+	struct clk_imx8mp_audiomix_priv *drvdata = dev_get_drvdata(dev);
+
+	drvdata->rcdev.owner     = THIS_MODULE;
+	drvdata->rcdev.nr_resets = fls(EARC_RESET_MASK);
+	drvdata->rcdev.ops       = &clk_imx8mp_audiomix_reset_ops;
+	drvdata->rcdev.of_node   = dev->of_node;
+	drvdata->rcdev.dev	 = dev;
+	drvdata->rcdev.of_reset_n_cells = 1;
+	drvdata->rcdev.of_xlate  = clk_imx8mp_audiomix_reset_xlate;
+
+	return devm_reset_controller_register(dev, &drvdata->rcdev);
+}
+
 static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 {
 	struct clk_imx8mp_audiomix_priv *priv;
@@ -338,6 +416,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_register;
 
+	ret = clk_imx8mp_audiomix_register_reset_controller(dev);
+	if (ret)
+		goto err_clk_register;
+
 	pm_runtime_put_sync(dev);
 	return 0;
 
-- 
2.34.1


