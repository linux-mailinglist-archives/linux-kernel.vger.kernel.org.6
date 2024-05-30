Return-Path: <linux-kernel+bounces-194893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D498D43CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC1CB24752
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80918210E4;
	Thu, 30 May 2024 02:47:30 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629731D531;
	Thu, 30 May 2024 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037250; cv=none; b=ch1zuZalzQmUempUzwxRrESEgF66/C5TA7lwl+6l0j71B0m5PbBdksWh6m+oyX/166RIFcCIN74WwRkHEDVqQp49Pp0ZH/HrFnpFqX+Ou7fLp9c4IM5GQUVS7sKnhFE48npQ+hTNweni0K0kw4rYoE43GF97rmzk9BIJqF8qLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037250; c=relaxed/simple;
	bh=mqiHu88SLDXDtaGXDAKBUHOn26hvhZJtfrW3LFLV710=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=UFcN7h6ZM7F+AWr7158oElwTzG09hjZo8xcimlR742ZTtPTeh3d/nDtNOlXwnZpIedhtTfP/YAETKBoXSXtKAhXnobO3fJQP8Xkh4yGFP180Ey69FYS2tnLx8tIxrvw2nLpmrK4RZSdFNrKuyEW1nBgP8zs0FgNT8R2B5s7gGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD05D1A1704;
	Thu, 30 May 2024 04:47:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42CE01A0483;
	Thu, 30 May 2024 04:47:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E6BDA180222C;
	Thu, 30 May 2024 10:47:23 +0800 (+08)
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
Subject: [PATCH v6 2/5] clk: imx: clk-audiomix: Add reset controller
Date: Thu, 30 May 2024 10:31:15 +0800
Message-Id: <1717036278-3515-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
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
 drivers/clk/imx/clk-imx8mp-audiomix.c | 60 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 6da0fba68225..9edfb030bea9 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -81,6 +81,7 @@ config CLK_IMX8MP
 	tristate "IMX8MP CCM Clock Driver"
 	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
+	select AUXILIARY_BUS
 	help
 	    Build the driver for i.MX8MP CCM Clock Driver
 
diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..a3dc2f3606ee 100644
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
 
@@ -217,6 +219,60 @@ struct clk_imx8mp_audiomix_priv {
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
@@ -337,6 +393,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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


