Return-Path: <linux-kernel+bounces-443097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245E9EE71F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F3A16619C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9022139CB;
	Thu, 12 Dec 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK/cACG2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6E1714D7;
	Thu, 12 Dec 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008035; cv=none; b=ZYGE/fLT77oo+KsjJrB6uzEne7r3cThKd0VKmaXDCNeCbMguELqddO5qouSs5YnjbM7xG/LgaCD7mOAWH4oC/tEc0o69YtLqrRURfhp6td4XbIyGhh9GJ9p13vtX0yDkDZ2Q2+bxY5+MCJnCdAxIlv3+yEfHS7xQsycSNm/7oXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008035; c=relaxed/simple;
	bh=9xK+bD2b7sbieZJy2qOzFPpKDsVao4fDuCk+++MxMe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XoK97X6P/LedhVIKf83KRPN27rhyUbZlMJnDFgKwVB11jPryzySIIwGev/fNeaptb92dsiTTwYCmlEju5jyY4mQducRFMhc1QdnNGBM8OQWY4h2sw+jPS7JqLLT7jn5cN56uoarsyyV5bKj6ymGpCvraURzWrwc60ntUWeEOt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK/cACG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DD1C4CED0;
	Thu, 12 Dec 2024 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734008034;
	bh=9xK+bD2b7sbieZJy2qOzFPpKDsVao4fDuCk+++MxMe8=;
	h=From:Date:Subject:To:Cc:From;
	b=NK/cACG2Tl7aQTGSCTD6oRjmGhKgx+HLEPnOBJObSwW65cLk7aua4BQrWKPj5bYo0
	 Al/+Bj3BPLdL3uSxM825THkprloIO89GF8UDrv3smxjmLEPDVPu4qZRjKpC3ugZuaq
	 hADAkEG8ldFJwPbs8b21NXLEMEPeAWe8K1UhGvCBrRg+QVtu+/A/XZK/NZTIxuITaR
	 eYr7MJ4m6TBgfbjRpcyaA1ehBnGN2eOWAJrvaf9POdxXKBXwn3v7+Dx7h2B1iusqZ4
	 UVM2np7IhMODrl5WenAg1+Uhw7N4V4y9gN9lI7u8LsHmQSrBN/hG74F1bWLe3RWBeN
	 Ih/coeBgkfUjg==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 12 Dec 2024 14:53:45 +0200
Subject: [PATCH v3] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-am62-dwc3-io-ddr-v3-1-10b95cd7e9c0@kernel.org>
X-B4-Tracking: v=1; b=H4sIANjcWmcC/33NQQrCMBCF4auUrB1JJmkxrryHuEiT2A5qUxKJS
 undTbsRQVz+D+abiSUfySe2ryYWfaZEYSghNxWzvRk6D+RKM+SohEAEc2sQ3MNKoADORZCtbZu
 dNFoYzsrZGP2Znit5PJXuKd1DfK0fsljWP1gWIMBapetGKa2QHy4+Dv66DbFji5bxIyDXPwQsg
 jMSudTY1lx/CfM8vwGPR9148wAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5647; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=9xK+bD2b7sbieZJy2qOzFPpKDsVao4fDuCk+++MxMe8=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnWtzg4Fwo7sKtT8PCFQGicSWwuJH+CA3VhsHID
 mFQnzugAleJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ1rc4AAKCRDSWmvTvnYw
 k2g9EADX+CQijhz6bAMSh28+1f/90Mf9WYzRocahYT+S6gnacnc5WteZ9beMxD5N4U5/GyUNpAP
 CotBCK+VjiBnjDUhn56kaQ6hoB66vC/WZ1aqR3tdAoSrhNMkjsZEf9lKFhCf8osUzk+PNfOQbaQ
 o2+oBVTisktRtyx71ZKS/D9TK49t/9T8TAvGFYSMtPhHyT/PLTMcBI5XJyizs7T+rdoGcrN1QNI
 80Fqy+D0b0IUAj/4MYWLTSrjSxIPBXD89KD0l1yuaxQPtsR1YgyLV8NW759LZ7qshp4cqKcMsN2
 LKmyeRssQSUJiIwBpimtLW0l5WoIkRXl/922B2HV0mMZznwW6NajAiAU5n3zLWeXc8roYy2E/EF
 33WJ1dh/R3HXGdVgD2ZuNGahU0dW8Cy9+iWMIGUH2Yxm0a78qwJaRR2Y+aV8lTXCI/w4/YZAQ64
 jJzeyKxv5XQRGltZP2yIoCn1VaWpWGg27SejDbDUqJD5qmGWocYpsvTnsqV+HC54gc04AZDNhUP
 ilTpxk3GFEV/JsEMDacWkZ2aJ7XEeMlwZmdVvpUiXjVPXnrwbn1B86RkFZeFur4k1FXLH7lbA3K
 Zu5bQM4pir1HfrGsM98uhynfE2JtOjVnrJtGlFAUQxh4K+AR95QGQ42krICaRhbM3Pjelr4geJ+
 FYBFZlhOsJ0gxsw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

If controller looses power during PM suspend then re-initialize
it. We use the DEBUG_CFG register to track if controller lost power
or was reset in PM suspend.

Move all initialization code into dwc3_ti_init() so it can be re-used.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changes in v3:
- renamed member phy to phy_regs as it is PHY register space
- Added Acked-by from Thinh Nguyen
- Link to v2: https://lore.kernel.org/r/20241209-am62-dwc3-io-ddr-v2-1-da320392b509@kernel.org

Changes in v2:
- fixed macro USBSS_DEBUG_CFG_OFF to 0
- Link to v1: https://lore.kernel.org/r/20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org
---
 drivers/usb/dwc3/dwc3-am62.c | 82 +++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 5e3d1741701f..a740d3d70e87 100644
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
+	void __iomem *phy_regs;
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
+	if (am62->phy_regs) {
+		reg = readl(am62->phy_regs + USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		writel(reg, am62->phy_regs + USB_PHY_PLL_REG12);
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
+	am62->phy_regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(am62->phy_regs)) {
 		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
-		phy = NULL;
-	} else {
-		reg = readl(phy + USB_PHY_PLL_REG12);
-		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
-		writel(reg, phy + USB_PHY_PLL_REG12);
+		am62->phy_regs = NULL;
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


