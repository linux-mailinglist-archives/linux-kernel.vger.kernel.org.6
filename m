Return-Path: <linux-kernel+bounces-174047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17F8C0997
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0DB1F22090
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038E13D248;
	Thu,  9 May 2024 02:03:39 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E613CAB5;
	Thu,  9 May 2024 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220219; cv=none; b=IVHQtL0jilLUgN2VyRjLIBo2N6ca4R4eas1qMpaMqjXjIWmMrQUEXCDRNUPwrjdx2NcNfHg7gX8rZlkA8cMJAH0CBZIbOwrBGZfZQ+2QuIoAOwJZukun6rdYO3ApemD4L2uUE3okMTmIj0l9cI4KX+Dl1xBkAqpQ3bqebeUCIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220219; c=relaxed/simple;
	bh=56mHVeFdfvxE2yIKn/Gg33/t+3cYTSavu7fC7I3BoYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qwCjhIS5goy29awtBXLtg8aiMeD+LdeW/htiEQhzNTfdR6niMYkD0WCHWsVfEtyntmSU7fC8fizkFFA6H5jcK4qEEQop2U6qES4bepifzBf763RWqcPvG60yDo2r22s9wf4GypGO4wTzI3JSiHud7UT+LwkR+OyLMrazq4DDPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CE751A1352;
	Thu,  9 May 2024 04:03:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9625E1A1349;
	Thu,  9 May 2024 04:03:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 85ABE181D0FC;
	Thu,  9 May 2024 10:03:27 +0800 (+08)
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
Subject: [PATCH v2 2/4] clk: imx: clk-audiomix: Add reset controller
Date: Thu,  9 May 2024 09:43:56 +0800
Message-Id: <1715219038-32453-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
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
 drivers/clk/imx/clk-imx8mp-audiomix.c | 82 +++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..e84365cef71b 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset-controller.h>
 
 #include <dt-bindings/clock/imx8mp-clock.h>
 
@@ -35,6 +36,8 @@
 #define SAI_PLL_MNIT_CTL	0x410
 #define IPG_LP_CTRL		0x504
 
+#define EARC_RESET_MASK		0x3
+
 #define SAIn_MCLK1_PARENT(n)						\
 static const struct clk_parent_data					\
 clk_imx8mp_audiomix_sai##n##_mclk1_parents[] = {			\
@@ -212,6 +215,7 @@ static const u16 audiomix_regs[] = {
 struct clk_imx8mp_audiomix_priv {
 	void __iomem *base;
 	u32 regs_save[ARRAY_SIZE(audiomix_regs)];
+	struct reset_controller_dev rcdev;
 
 	/* Must be last */
 	struct clk_hw_onecell_data clk_data;
@@ -232,6 +236,80 @@ static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
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
@@ -337,6 +415,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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


