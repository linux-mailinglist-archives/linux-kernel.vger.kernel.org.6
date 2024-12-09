Return-Path: <linux-kernel+bounces-437714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2259E978F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F0D282424
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654E3596F;
	Mon,  9 Dec 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npFX9uzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B5233137;
	Mon,  9 Dec 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751863; cv=none; b=D9PA+BeKOewBwbhOGP17wABxsJCdpD1cIxAHzaPV09P95oKUoST2h69XiYM1GdqIunz2uF46CLJkyWE+BJxzElC1sqtWkQTG78/rvVD4S4lhe1G6FVoWOvd8uqVLeNZcuo4lqLTxUNXIECuxU4c8yiHEeHGX1ovquMdNV1G+TCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751863; c=relaxed/simple;
	bh=hkcPvzYZ1cJqOuDOrMYctQwlwcRvk9AzBUG3CgnlyNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WXtd+44Baf0ndLKuKaswjG5dmEQJMPrKU/TtquW4eRRVWxFrWOqZGWqggWLpZ1zgCEtHZgLiSCMTTV0Jc8aVQwsRtuY7AQhPRXtHT9FsZ/cV9firWqr8GGVheZH4gL3/VjgNoQ6rRJD8rccORFV6sW9RR5ojhNnLqOrT2O6cTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npFX9uzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB310C4CED1;
	Mon,  9 Dec 2024 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733751862;
	bh=hkcPvzYZ1cJqOuDOrMYctQwlwcRvk9AzBUG3CgnlyNE=;
	h=From:Date:Subject:To:Cc:From;
	b=npFX9uzdwZjU/v5zg+qBK2PnxHBELZodQX9+VgJyfKlhK3Xh5BLFLzKicTARLFfiJ
	 /2Wu/VcGAyds77mi3TAwO9Bwi3Je3dAcYHdQICcl12PIcajE57I4TcelWfwMpfcNUP
	 i4wdBJaanliZMOHHfo2nWzegm2LwXFuhOUY09a996OTUpCtwpE+RR5kYCQt0lLuriB
	 P+kpq08u7Rv8w1xLJe/apDvLW8kUu5D/fdwNUN6cEhobX1OFitI8/VmMDbujGDhoxh
	 RNw7qSDJS6yg5DQvGqf8ctiyyb4GhGZXmD15bdGGisUVe33VddWU3gcAzNj69h85IZ
	 LHKVVakBTEaEA==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 09 Dec 2024 15:44:11 +0200
Subject: [PATCH v2] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-am62-dwc3-io-ddr-v2-1-da320392b509@kernel.org>
X-B4-Tracking: v=1; b=H4sIACr0VmcC/32NQQ6CMBBFr0Jm7Rg6VCKuvIdhUdoRJiolU4Maw
 t2tHMDle8l/f4HEKpzgVCygPEuSOGagXQF+cGPPKCEzUEnWGCJ0j5owvHyFEjEExarzXX2sXGN
 cCXk2KV/lvSUvbeZB0jPqZ3uYzc/+ic0GDXpvm0NtbWOpPN9YR77vo/bQruv6BZL+a0CxAAAA
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5348; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=hkcPvzYZ1cJqOuDOrMYctQwlwcRvk9AzBUG3CgnlyNE=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnVvQ0clFiE6SfPWncli/jyojy+8aGtMEY2MCFj
 dxmOCfvLAKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ1b0NAAKCRDSWmvTvnYw
 kxZuEACB2MRhl0MEcfI1bW+SWZW8xuCa4dnPZ/LE16NhA4V06mm6djNz3EEvItJ+6AW+ZSIABCb
 /khDZjFakHw4U/QkAT+nE650Os499Jz0ElRMPWuHiXJEDsNog81zWZcYMBD+EWnzl+ucKBAoBVR
 jmFnKvVFSMmT1j9MA8yWm302KKOk1IGCMv0uuLJGDZWS8RGoUwvpB8OUpP2L0xKHQBLyVoIZA/h
 UX3pS5uwW1umdZHMGSWRo/GY3jJsQgr+XA/M3pDSEFzLQJtV8YEkp+IpDcQnwfhnxw5hnSE/5/x
 BcA1nuhWBg80QmP24e8WnixUUARKmVCOiDYK8Vo4BG3z1AdNSgcKBtPMn/tSIAj2fR2vg2p3zFO
 UdmWMaWucYf/WoTTsu2SF7KZTHZgAZwBijbmEy1gDLemnmsCvy21gZ5XZvHLnKurG+cShGQPHsP
 jZmuKk77NQknULeV8Jmn6O6XyfPpsky9ajdxvm5IwaxdzI5p2R5sQ7lrEQ4aTyiehVdEl3hx1Qq
 xVuUK/lceuQ5i6nPvnhNJHcEqzO+AVHhtN7q8qF8gbW/jylS0pM9p2XonaCil9G051oF8wSswT/
 eJHthCt2D5gnjJVsEl+0EHY0bsTzhzCPSL9HViUwNphgO+bMwSl9FGOhC5GT8KfJqzuyhNQc1jM
 Nc++bT94I50QW2w==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

If controller looses power during PM suspend then re-initialize
it. We use the DEBUG_CFG register to track if controller lost power
or was reset in PM suspend.

Move all initialization code into dwc3_ti_init() so it can be re-used.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v2:
- fixed macro USBSS_DEBUG_CFG_OFF to 0
- Link to v1: https://lore.kernel.org/r/20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org
---
 drivers/usb/dwc3/dwc3-am62.c | 82 +++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 5e3d1741701f..7eef945b1f89 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -108,6 +108,9 @@
 
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
+#define USBSS_DEBUG_CFG_OFF		0x0
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
base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
change-id: 20241122-am62-dwc3-io-ddr-3bcb683a91a0

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


