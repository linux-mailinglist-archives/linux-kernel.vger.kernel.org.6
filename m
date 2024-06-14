Return-Path: <linux-kernel+bounces-214491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010190857D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35012281EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF750184113;
	Fri, 14 Jun 2024 07:59:18 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E771836C7;
	Fri, 14 Jun 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351958; cv=none; b=p/TD4FSVxpfogrwxrq69uGGq2bvczxM9PDs61Q5d6ngpptxkH1Bnvp8BdHzb+gwY8rHUttNchS6ZcQxbTVYAxn+AnIal0EKoqtPtY4baYejGGh05ULz1J8uGm1SKjwErRQRIluyG9+XXJn6Nu8ctJ5LAmpFei551rtfZFLmG0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351958; c=relaxed/simple;
	bh=9WuykSLDvgrkD83NKcuDTuqiituZEcT1+6M80EnAUsk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=MhW4IIKMz0b/qNSE6OOy8qakwyrhr+IvMJvt29I+Zq2GCryG6W7p5dM0mHLhCsl5Qft+1gPcjyDTGHHKqcoySB0VBhEElzOcurMeHDSK3gUYKan3+mFBkYQhsQ3NvVBTRNQd6U1FP91Bn7QakgPVhEcVegf/PUwt3VN2yO14dvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 33A57201714;
	Fri, 14 Jun 2024 09:59:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AAD57201712;
	Fri, 14 Jun 2024 09:59:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DA5B41820F76;
	Fri, 14 Jun 2024 15:59:06 +0800 (+08)
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
Subject: [PATCH v8 2/5] clk: imx: clk-audiomix: Add reset controller
Date: Fri, 14 Jun 2024 15:42:00 +0800
Message-Id: <1718350923-21392-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Audiomix block control can be a reset controller for
Enhanced Audio Return Channel (EARC), which is one of
modules in this audiomix subsystem.

The reset controller is supported by the auxiliary device
framework.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/clk/imx/Kconfig               |  1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c | 63 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 6da0fba68225..6ff6d934848a 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -81,6 +81,7 @@ config CLK_IMX8MP
 	tristate "IMX8MP CCM Clock Driver"
 	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
+	select AUXILIARY_BUS if RESET_CONTROLLER
 	help
 	    Build the driver for i.MX8MP CCM Clock Driver
 
diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..517b1f88661b 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Marek Vasut <marex@denx.de>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -13,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/clock/imx8mp-clock.h>
 
@@ -217,6 +219,63 @@ struct clk_imx8mp_audiomix_priv {
 	struct clk_hw_onecell_data clk_data;
 };
 
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
+
+static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
+							 struct clk_imx8mp_audiomix_priv *priv)
+{
+	struct auxiliary_device *adev __free(kfree) = NULL;
+	int ret;
+
+	if (!of_property_present(dev->of_node, "#reset-cells"))
+		return 0;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "reset";
+	adev->dev.parent = dev;
+	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
+					no_free_ptr(adev));
+}
+
+#else /* !CONFIG_RESET_CONTROLLER */
+
+static int clk_imx8mp_audiomix_reset_controller_register(struct clk_imx8mp_audiomix_priv *priv)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_RESET_CONTROLLER */
+
 static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
 {
 	struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
@@ -337,6 +396,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_register;
 
+	ret = clk_imx8mp_audiomix_reset_controller_register(dev, priv);
+	if (ret)
+		goto err_clk_register;
+
 	pm_runtime_put_sync(dev);
 	return 0;
 
-- 
2.34.1


