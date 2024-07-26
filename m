Return-Path: <linux-kernel+bounces-263611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D587593D840
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D301C231E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0E155300;
	Fri, 26 Jul 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V4plbe+J"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517021494C4;
	Fri, 26 Jul 2024 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017888; cv=none; b=rPksxPzbhO/x7ebE8WOZujRqI873oKN8vnuFmThbETVLkYyPsnkvm37OdIJSUuf9A0BuOqDl/FAnlrYdfU/243sCjK85ZA2/3h4vH2T2SS11vQ0oIDRttRR+TciAENZN6FTKB1Wtq7Q/4hUfqp6ZJru/IOzN7T3Lzv3rNtOlb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017888; c=relaxed/simple;
	bh=WjEYjyDPZ04uHH112vUG09pL2xgwPjzyI56gEphZaJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBZPcOTi+ZYkI+2cjdEI5WG4xVBX8S7Z4G0S0I72VpqJ5w3rz5Nhnh7C8ywbb7k6M93nSJNu9UvzuxBjvzDhD0F9c6ont6uDEplXBVaNmiQvzjcoGvGG13JFapGTE6hGCg+8j2rPzvVt6C32TG5ZvNsytGi4dRJfaPkW6tJ/Lro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V4plbe+J; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DEEDC0008;
	Fri, 26 Jul 2024 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB2yJwdnYb2P4da/POGQoMfTHp7V1lBWEjlzymwP8HU=;
	b=V4plbe+JHBZ+BcsSSbMU3fD9SNLkG2/Xq0mSl2tN4CoE9T1+Fk2dKc/FeXqPhuq/Gfqg+Z
	BEbxnR4Yp5WUThk2P4kv8TLW7wQqzZzt5/7AS0URzoSC36hPZw2Pwb/fQ7p9/Dk2Sbe7ON
	leZ94Xgyf4TmW4TUTz3oCbP8pqEUzSbXP5TS9I3kOq4jqCZfzC72c0rDIcIp01+0uGjuoa
	rSSpA543jj9t5RR86KhDTafRh4mArEVIrU1fst/yc+vqFCr/UxVL8VM63SicJbDIRmy3yr
	eQKC3u7loCRRXtMu5uiJ94GuLUm7UNlMIkaQg5HyoxHO6xl/0Lxs6W+ddyj9cg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:54 +0200
Subject: [PATCH v5 06/12] usb: cdns3-ti: grab auxdata from match data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-6-8664bfb032ac@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
In-Reply-To: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Kevin Hilman <khilman@kernel.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Current code uses the global `cdns_ti_auxdata` variable as auxiliary
data passed to of_platform_populate(). Use match data to store a
pointer to auxdata.

Current behavior is not changed; it allows future compatibles to provide
different auxiliary data.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 618fba5fa2bb..159814dfc856 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -87,18 +87,6 @@ static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
 	writel(value, data->usbss + offset);
 }
 
-static struct cdns3_platform_data cdns_ti_pdata = {
-	.quirks = CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
-};
-
-static const struct of_dev_auxdata cdns_ti_auxdata[] = {
-	{
-		.compatible = "cdns,usb3",
-		.platform_data = &cdns_ti_pdata,
-	},
-	{},
-};
-
 static void cdns_ti_reset_and_init_hw(struct cdns_ti *data)
 {
 	u32 reg;
@@ -142,6 +130,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_dev_auxdata *auxdata;
 	struct cdns_ti *data;
 	unsigned long rate;
 	int error, i;
@@ -203,7 +192,8 @@ static int cdns_ti_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	error = of_platform_populate(node, NULL, cdns_ti_auxdata, dev);
+	auxdata = device_get_match_data(dev);
+	error = of_platform_populate(node, NULL, auxdata, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
 		goto err;
@@ -256,9 +246,21 @@ static const struct dev_pm_ops cdns_ti_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
+static struct cdns3_platform_data cdns_ti_pdata = {
+	.quirks = CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
+};
+
+static const struct of_dev_auxdata cdns_ti_auxdata[] = {
+	{
+		.compatible = "cdns,usb3",
+		.platform_data = &cdns_ti_pdata,
+	},
+	{},
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
-	{ .compatible = "ti,j721e-usb", },
-	{ .compatible = "ti,am64-usb", },
+	{ .compatible = "ti,j721e-usb", .data = cdns_ti_auxdata },
+	{ .compatible = "ti,am64-usb", .data = cdns_ti_auxdata },
 	{},
 };
 MODULE_DEVICE_TABLE(of, cdns_ti_of_match);

-- 
2.45.2


