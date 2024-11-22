Return-Path: <linux-kernel+bounces-418298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45C9D6012
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D667A1F22C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B537346F;
	Fri, 22 Nov 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsedbVrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F89BA20;
	Fri, 22 Nov 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283857; cv=none; b=DSsEHjc+j8g9Xm7zoL+4ZlxYmPEbr6SvONX1HCEixWvsjN3bYNu7CQjv4Y+7RMZ4w/o1dvEjmW1nKUZfmLYgFkrsJda1xUd1W1WhEPel1AMdvfTboJzB3vpxM3JRgKuAtM3RT74D1V2kYdLla7hq1RWSraw7PE4FHKobxbuTIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283857; c=relaxed/simple;
	bh=d7kw5ktReFj4yWWGLaWBCguRiCMPqtIMkHdyyZNbx1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tUcpydFQmDssUs1m0D7xm8f0B4I7clyS09zuDt3AYo++QyS9O34Gq8KGQe9NbUnevub/5FIDo+8M6lYD6rizyM6G4wn/fkxT8+1GOVU7h8PmY6KPApuhPNbOv9oFvraaifBDa7PFxw9YLSoiAi0HF6JQs70LzmldVhR8p9UJ/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsedbVrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABE7C4CECF;
	Fri, 22 Nov 2024 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283857;
	bh=d7kw5ktReFj4yWWGLaWBCguRiCMPqtIMkHdyyZNbx1k=;
	h=From:Date:Subject:To:Cc:From;
	b=jsedbVrbtL9x//s30pVbM0Zlq6hwTFww1uLBxd4dbdNZZZbFC5rCkWauyhuM7dig0
	 p11T9ESDM6DP50/pEdtPmApBoNRnL8f9MmGPVojslMPi0ctTdW/8vkoQcxClUbDH8q
	 GWancxR3zJVq08sBDu1VN9DByUXr3SZLDYVTKx+ueSSdw0y36TE5ET3oc0NrB+BxM8
	 jQNLmxBSW28DQ3Xqg2Jel67UlyQkZV4X6rkZ0ihNTm8R97T3xds/ibx3hYIUB2twV+
	 ddj7uRrEuCQUK4cBcsF2VMBt/MlOjzQGlh+zk+39Pc2f5QcHWPg+mLAwIP+9/q6oIl
	 8Q17WND/3oX4Q==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 22 Nov 2024 15:57:26 +0200
Subject: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMWNQGcC/x3MPQqAMAxA4atIZgNtKqJeRRz6EzWDVVpQQby7x
 fEb3nsgcxLOMFQPJD4lyx4LdF2BX21cGCUUAylqtCZCu7WE4fIGZccQEhrnXdsZ22uroGRH4ln
 ufzlO7/sBP1rRoWIAAAA=
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5191; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=d7kw5ktReFj4yWWGLaWBCguRiCMPqtIMkHdyyZNbx1k=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnQI3MRr6qWu6GVIYKlp87kEv5Q14fQ6K9wyhWa
 FL76JL409OJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ0CNzAAKCRDSWmvTvnYw
 k0xrD/4uWs5BBkfPo8CztYD4V+ZAS3uIBSL/lbxznMwFfzKFE06hab+kVLdAvWUGtmacWxfIolq
 bqKJz81SSAe7jjJmo27abEZop/9HbMP8XTTiIeNfBUuBs0VApdqjDGpwMA6aP9DSTaQEVCrvMIr
 M0AvlcXzJyvw2fuNmRNGX+u+0a1xdwh0WlAPLL5gtJ1OSk5DFhPUcrkQN0pDXP+nVxp5tZqKB0z
 W8FewWwpFioOuL71dp+COAedQ4pw4kYR6f6bpyBI9JMVAgSEVXsZxa5b6Sm8J6bxht0HvPcCqrv
 6jR4LPjyc3qVVOvGjzxrrc2oGzLzl7a1AvaxxNy1+t4CuLWpmG8NVUmWJU0edueOcDmr4EaYZ0K
 UVqkj3lnNMvyJk64EFXSAF+RhcWmCa8AbrshxPoNPHNnC8CJmWXCatlbKypCrm0MTpivjCSMatR
 ER7iGDtPdXHNPtQRlxVfkg6gCPaIuVLbu3/xFQnLE3EoMIluOTWtWwUmE7A3hwq5Da3/vk6mXEc
 wAAUxGlCzpekIc2Ut91EmUyqOQn8Gh5O5F2cgDtsgM0CQivmXS6TmBKgTPJkGm9Xy3TKygb8JV5
 pF0OC99uk+5Z1bVSg3ZxYZs1gFO4CQyyvvzbx4CEL5nysGZElP/KEwnIvlWSckm4qfQmFLmZoc3
 mteHaNwi4svjCYA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

If controller looses power during PM suspend then re-initialize
it. We use the DEBUG_CFG register to track if controller lost power
or was reset in PM suspend.

Move all initialization code into dwc3_ti_init() so it can be re-used.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 82 +++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index fad151e78fd6..2192222faf4f 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -108,6 +108,9 @@
 
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
+#define USBSS_DEBUG_CFG_OFF		0x7
+#define USBSS_DEBUG_CFG_DISABLED	0x7
+
 struct dwc3_am62 {
 	struct device *dev;
 	void __iomem *usbss;
@@ -117,6 +120,7 @@ struct dwc3_am62 {
 	unsigned int offset;
 	unsigned int vbus_divider;
 	u32 wakeup_stat;
+	void __iomem *phy;
 };
 
 static const int dwc3_ti_rate_table[] = {	/* in KHZ */
@@ -184,15 +188,47 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 	return 0;
 }
 
+static int dwc3_ti_init(struct dwc3_am62 *am62)
+{
+	int ret;
+	u32 reg;
+
+	/* Read the syscon property and set the rate code */
+	ret = phy_syscon_pll_refclk(am62);
+	if (ret)
+		return ret;
+
+	/* Workaround Errata i2409 */
+	if (am62->phy) {
+		reg = readl(am62->phy + USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		writel(reg, am62->phy + USB_PHY_PLL_REG12);
+	}
+
+	/* VBUS divider select */
+	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
+	if (am62->vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
+
+	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
+
+	clk_prepare_enable(am62->usb2_refclk);
+
+	/* Set mode valid bit to indicate role is valid */
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
+
+	return 0;
+}
+
 static int dwc3_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
 	struct dwc3_am62 *am62;
 	unsigned long rate;
-	void __iomem *phy;
 	int i, ret;
-	u32 reg;
 
 	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
 	if (!am62)
@@ -228,29 +264,17 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 
 	am62->rate_code = i;
 
-	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(am62);
-	if (ret)
-		return ret;
-
-	/* Workaround Errata i2409 */
-	phy = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(phy)) {
+	am62->phy = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(am62->phy)) {
 		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
-		phy = NULL;
-	} else {
-		reg = readl(phy + USB_PHY_PLL_REG12);
-		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
-		writel(reg, phy + USB_PHY_PLL_REG12);
+		am62->phy = NULL;
 	}
 
-	/* VBUS divider select */
 	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-	if (am62->vbus_divider)
-		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
+	ret = dwc3_ti_init(am62);
+	if (ret)
+		return ret;
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -258,7 +282,6 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	 * Don't ignore its dependencies with its children
 	 */
 	pm_suspend_ignore_children(dev, false);
-	clk_prepare_enable(am62->usb2_refclk);
 	pm_runtime_get_noresume(dev);
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
@@ -267,11 +290,6 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
 	/* Device has capability to wakeup system from sleep */
 	device_set_wakeup_capable(dev, true);
 	ret = device_wakeup_enable(dev);
@@ -338,6 +356,9 @@ static int dwc3_ti_suspend_common(struct device *dev)
 		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
 	}
 
+	/* just to track if module resets on suspend */
+	dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_DISABLED);
+
 	clk_disable_unprepare(am62->usb2_refclk);
 
 	return 0;
@@ -348,7 +369,14 @@ static int dwc3_ti_resume_common(struct device *dev)
 	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
 	u32 reg;
 
-	clk_prepare_enable(am62->usb2_refclk);
+	reg = dwc3_ti_readl(am62, USBSS_DEBUG_CFG);
+	if (reg != USBSS_DEBUG_CFG_DISABLED) {
+		/* lost power/context */
+		dwc3_ti_init(am62);
+	} else {
+		dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_OFF);
+		clk_prepare_enable(am62->usb2_refclk);
+	}
 
 	if (device_may_wakeup(dev)) {
 		/* Clear wakeup config enable bits */

---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20241122-am62-dwc3-io-ddr-3bcb683a91a0

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


