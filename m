Return-Path: <linux-kernel+bounces-531116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A15A43C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF573A4081
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A302673B9;
	Tue, 25 Feb 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TjLBUDpV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D57266EE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481006; cv=none; b=L+fFOMACEi11Wr8lOMpghZActIaq85Kbf1t4k5/C1GSIJqnvgr35jeTQFthTxJWTu3JDCXZYvhlXf7gflUmlrTuzwlVN7WCq02Nk5uGXI6AZqjyqThkW9+vTfQDn/PbjCgytPdb8DgaSfuILNdT1US/JyCKrWkTlmU5ir0ozmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481006; c=relaxed/simple;
	bh=iKEf1m/m6BvXv4+yY+8cnvHqyOnvsNHZ2JRtdjVVX54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqBnhIec/HEfXXo4tmCOdvg9geJAdCT3nxEhUD7akNXgZxinLEW2T9tKMhfYQtn+rwYOLd/10WBVYgyUR7NTDtnsAmkDR7yv5yg9F2BaAWMHGEwoo86I3LS+LjVH3ATLj8FYEUvf+nuNBYVyxZ3O8gLtzYy+ZwpKP0vwQlYrSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TjLBUDpV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740481004; x=1772017004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iKEf1m/m6BvXv4+yY+8cnvHqyOnvsNHZ2JRtdjVVX54=;
  b=TjLBUDpV+XxgaGQdsAb98mfbN69i3dBcGIy5QZNgMWq0WHb4t/l+J7jF
   ZAsY/fpoKLBpkwK9uGLlreauihoEcMcys9+pwYqVnWFrWUzgjEXHUObzR
   nZd8797qFzlCiL82aST9QvapxiOhOAzhtQWwxLRFLVpYaTs/f2KEgn70T
   eIgd0dvZStgnXs/vv/Hz0i2/a5V+39Dyc8c3FGGolRhr93u+weKsFBjaS
   QVpd8NZuLaX8nuSNX74PYbTt8WcOBHvTR5q3ckmfEK4OegL5oI/L9WGAP
   j59IoL1ych4Wx7bd75YHUzoruBqXjjDJDgMSMRUYJyOyeuRk+pWQ0FDUO
   Q==;
X-CSE-ConnectionGUID: WaHEjTnNR0qMKpQFgGyzcA==
X-CSE-MsgGUID: 0peESw3nSGiMeEVGscga6w==
X-IronPort-AV: E=Sophos;i="6.13,314,1732604400"; 
   d="scan'208";a="269479111"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2025 03:56:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Feb 2025 03:56:20 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Feb 2025 03:56:18 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<herve.codina@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2] reset: mchp: sparx5: Fix for lan966x
Date: Tue, 25 Feb 2025 11:53:29 +0100
Message-ID: <20250225105329.3037853-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the blamed commit it seems that lan966x doesn't seem to boot
anymore when the internal CPU is used.
The reason seems to be the usage of the devm_of_iomap, if we replace
this with of_iomap, this seems to fix the issue as we use the same
region also for other devices.

Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v1->v2:
- make sure to use iounmap when driver is removed
---
 drivers/reset/reset-microchip-sparx5.c | 40 +++++++++++++++++++-------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index aa5464be7053b..cbe68026adc8d 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -8,6 +8,7 @@
  */
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -26,6 +27,7 @@ struct mchp_reset_context {
 	struct regmap *gcb_ctrl;
 	struct reset_controller_dev rcdev;
 	const struct reset_props *props;
+	void __iomem *base;
 };
 
 static struct regmap_config sparx5_reset_regmap_config = {
@@ -69,23 +71,27 @@ static const struct regmap_config mchp_lan966x_syscon_regmap_config = {
 };
 
 static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
-						    struct device_node *syscon_np)
+						    struct device_node *syscon_np,
+						    struct mchp_reset_context *ctx)
 {
 	struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
-	resource_size_t size;
-	void __iomem *base;
+	struct resource res;
 
-	base = devm_of_iomap(dev, syscon_np, 0, &size);
-	if (IS_ERR(base))
-		return ERR_CAST(base);
+	if (of_address_to_resource(syscon_np, 0, &res))
+		return ERR_PTR(-ENOMEM);
 
-	regmap_config.max_register = size - 4;
+	ctx->base = of_iomap(syscon_np, 0);
+	if (!ctx->base)
+		return ERR_PTR(-ENOMEM);
 
-	return devm_regmap_init_mmio(dev, base, &regmap_config);
+	regmap_config.max_register =  resource_size(&res) - 4;
+
+	return devm_regmap_init_mmio(dev, ctx->base, &regmap_config);
 }
 
 static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
-				  struct regmap **target)
+				  struct regmap **target,
+				  struct mchp_reset_context *ctx)
 {
 	struct device_node *syscon_np;
 	struct regmap *regmap;
@@ -103,7 +109,8 @@ static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
 	 * device removal.
 	 */
 	if (of_device_is_compatible(pdev->dev.of_node, "microchip,lan966x-switch-reset"))
-		regmap = mchp_lan966x_syscon_to_regmap(&pdev->dev, syscon_np);
+		regmap = mchp_lan966x_syscon_to_regmap(&pdev->dev, syscon_np,
+						       ctx);
 	else
 		regmap = syscon_node_to_regmap(syscon_np);
 	of_node_put(syscon_np);
@@ -146,7 +153,7 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
-	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl);
+	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl, ctx);
 	if (err)
 		return err;
 	err = mchp_sparx5_map_io(pdev, 0, &ctx->gcb_ctrl);
@@ -165,9 +172,19 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	dev_set_drvdata(&pdev->dev, ctx);
+
 	return devm_reset_controller_register(&pdev->dev, &ctx->rcdev);
 }
 
+static void mchp_sparx5_reset_remove(struct platform_device *pdev)
+{
+	struct mchp_reset_context *ctx = dev_get_drvdata(&pdev->dev);
+
+	if (ctx->base != NULL)
+		iounmap(ctx->base);
+}
+
 static const struct reset_props reset_props_sparx5 = {
 	.protect_reg    = 0x84,
 	.protect_bit    = BIT(10),
@@ -196,6 +213,7 @@ MODULE_DEVICE_TABLE(of, mchp_sparx5_reset_of_match);
 
 static struct platform_driver mchp_sparx5_reset_driver = {
 	.probe = mchp_sparx5_reset_probe,
+	.remove = mchp_sparx5_reset_remove,
 	.driver = {
 		.name = "sparx5-switch-reset",
 		.of_match_table = mchp_sparx5_reset_of_match,
-- 
2.34.1


