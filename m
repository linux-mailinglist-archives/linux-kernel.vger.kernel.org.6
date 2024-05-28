Return-Path: <linux-kernel+bounces-192098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB88D185B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742AA1C221CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE5416B759;
	Tue, 28 May 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVfbZnEt"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A016ABFA;
	Tue, 28 May 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891637; cv=none; b=tB9UKVDxsiec7zqxAu0r396+XZsZvaRqaGdEnKlWSg5RndJDoFoNnhm/rI58Ls4v2MPOJKuJjjISJE3ZB1DiTr5HcjVv6e2+W+HonnGz0tyzEDZkC5EDbE9kKmLf6xxczecTyRHnawvBv2wm8NcsIGj2od1fVe/SeEpX4Mmzp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891637; c=relaxed/simple;
	bh=mNFOcqVPeiW0TBAqSKiAPvLe2JSjS3/1NaL2Fa9ZSGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abCOAyYFDq1J579HR0qCRdAQvWXBOePBsBrlTVI5Mx39Br7QkFNsfmiGmP/SEUjfILsd6QBT8a7vkbkqshhpRfO58IN8oQpmVXb+Dg17WA7BJ1cpZHBM38NbZYzMIg+QAgwNPGsvANIh/1YbhK/HPPw2CI1jOVykcfxKZwWO7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVfbZnEt; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 225EE24000E;
	Tue, 28 May 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716891630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt4vcaHEqIK7tEg5aEV04mxd2ZnC0k99FgLlkPj/PX8=;
	b=SVfbZnEtNR0BhLFE21BoJQ30/zXBsCr4v3wujLSLANi/Z2fjIJc88cBrYT2byO2SqyAA8R
	DTBP9fLHFBAz8W21/rcQOdumlCGeKpML5PfNftca7BRdwWJdfHMOzwGXlPMoBPk/nqiXme
	rWPReML+hVUs3P2zCqpIUe8reR/hc073JZoI0mTxmt06nS+w1FXEKV8lq3I/OhdnHldGE5
	bg1jhwUJ+DCl/0JEzl52Yql7zf5hjKsVBSo7qk4jnrkgHiGFkTXN9lYbGa+yluWXZHpUlK
	YnZvFO4iUoHG+qe7MUOjhGOD9JkRqaFfNBYFYUyNtILYyNwelzjdG7+3+g6ttQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 1/4] phy: ti: phy-da8xx-usb: Add runtime PM support
Date: Tue, 28 May 2024 12:20:23 +0200
Message-ID: <20240528102026.40136-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
References: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Runtime PM is not supported while USB PHY can be turned off from
register accesses.

Add runtime PM for the USB2.0 PHY. The PHY is entirely shut down to save
as much power as possible. This means that gadgets will not be discovered
once suspend state is entered, and suspend state can not be left without
an explicit user intervention (through sysfs). That's why runtime PM is
disabled by default.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/phy/ti/phy-da8xx-usb.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/phy/ti/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
index dc614aa09a5f..80bfe37cf846 100644
--- a/drivers/phy/ti/phy-da8xx-usb.c
+++ b/drivers/phy/ti/phy-da8xx-usb.c
@@ -15,11 +15,13 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_data/phy-da8xx-usb.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #define PHY_INIT_BITS	(CFGCHIP2_SESENDEN | CFGCHIP2_VBDTCTEN)
 
 struct da8xx_usb_phy {
+	struct device		*dev;
 	struct phy_provider	*phy_provider;
 	struct phy		*usb11_phy;
 	struct phy		*usb20_phy;
@@ -40,6 +42,12 @@ static int da8xx_usb11_phy_power_on(struct phy *phy)
 	regmap_write_bits(d_phy->regmap, CFGCHIP(2), CFGCHIP2_USB1SUSPENDM,
 			  CFGCHIP2_USB1SUSPENDM);
 
+	/*
+	 * USB1.1 can used USB2.0 output clock as reference clock so this is here to prevent USB2.0
+	 * from shutting PHY's power when USB1.1 might use it
+	 */
+	pm_runtime_get_sync(d_phy->dev);
+
 	return 0;
 }
 
@@ -50,6 +58,7 @@ static int da8xx_usb11_phy_power_off(struct phy *phy)
 	regmap_write_bits(d_phy->regmap, CFGCHIP(2), CFGCHIP2_USB1SUSPENDM, 0);
 
 	clk_disable_unprepare(d_phy->usb11_clk);
+	pm_runtime_put_sync(d_phy->dev);
 
 	return 0;
 }
@@ -119,6 +128,35 @@ static const struct phy_ops da8xx_usb20_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int __maybe_unused da8xx_runtime_suspend(struct device *dev)
+{
+	struct da8xx_usb_phy *d_phy = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Suspending ...\n");
+
+	regmap_set_bits(d_phy->regmap, CFGCHIP(2), CFGCHIP2_PHYPWRDN | CFGCHIP2_OTGPWRDN);
+
+	return 0;
+}
+
+static int __maybe_unused da8xx_runtime_resume(struct device *dev)
+{
+	u32 mask = CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN | CFGCHIP2_OTGPWRDN | CFGCHIP2_PHY_PLLON;
+	struct da8xx_usb_phy *d_phy = dev_get_drvdata(dev);
+	u32 pll_status;
+
+	regmap_update_bits(d_phy->regmap, CFGCHIP(2), mask, CFGCHIP2_PHY_PLLON);
+
+	dev_dbg(dev, "Resuming ...\n");
+
+	return regmap_read_poll_timeout(d_phy->regmap, CFGCHIP(2), pll_status,
+					pll_status & CFGCHIP2_PHYCLKGD, 1000, 500000);
+}
+
+static const struct dev_pm_ops da8xx_usb_phy_pm_ops = {
+	SET_RUNTIME_PM_OPS(da8xx_runtime_suspend, da8xx_runtime_resume, NULL)
+};
+
 static struct phy *da8xx_usb_phy_of_xlate(struct device *dev,
 					 const struct of_phandle_args *args)
 {
@@ -148,6 +186,8 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 	if (!d_phy)
 		return -ENOMEM;
 
+	d_phy->dev = dev;
+
 	if (pdata)
 		d_phy->regmap = pdata->cfgchip;
 	else
@@ -209,6 +249,14 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 	regmap_write_bits(d_phy->regmap, CFGCHIP(2),
 			  PHY_INIT_BITS, PHY_INIT_BITS);
 
+	pm_runtime_set_active(dev);
+	devm_pm_runtime_enable(dev);
+	/*
+	 * Prevent runtime pm from being ON by default. Users can enable
+	 * it using power/control in sysfs.
+	 */
+	pm_runtime_forbid(dev);
+
 	return 0;
 }
 
@@ -233,6 +281,7 @@ static struct platform_driver da8xx_usb_phy_driver = {
 	.remove_new = da8xx_usb_phy_remove,
 	.driver	= {
 		.name	= "da8xx-usb-phy",
+		.pm	= &da8xx_usb_phy_pm_ops,
 		.of_match_table = da8xx_usb_phy_ids,
 	},
 };
-- 
2.44.0


