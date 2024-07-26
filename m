Return-Path: <linux-kernel+bounces-263606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F9293D838
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E56B1F22833
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2014F121;
	Fri, 26 Jul 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dq/p01nr"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D734963A;
	Fri, 26 Jul 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017886; cv=none; b=XrMU38g9dRCUQ9dh6jK5SeIN8er7O/208pFA7znB0NcQQyF/XRV02W9Wbo4gaJduDVHLThFg3Ac6LbBS2lxzU2l4/g6J6xZoUbZimUYD5tbQxs18RA7CHxEAdODuidYc8WiDlqslBH4jSfQRYBCghsrvVB2nRWCfLPFMHCy7ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017886; c=relaxed/simple;
	bh=400w7OVYcBUGnBGxpiXLcM4sNI7cCJW3QPiT2aDKQl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKi2BFM39JFk4B7Ylu7FRNT3e4AKnA89ZWAzmnTdCC2zO4JorfL+uQrpkddCpMpcFoW1HmduZjwrkcAAIgClmIswi0y7794zkItjQETSnLmHHiMUUJQMEE7uQS+ixCh5j8mp1kxDiiFjBNkvKCe4NK/nV0kYnXfA3JKwYXiV3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dq/p01nr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74BABC0004;
	Fri, 26 Jul 2024 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygFH1F/pP0x+mZLwLKNqGnH8mKaQf8msoqiAQ1GXuLM=;
	b=Dq/p01nrtDgkQW5H4QQBTf9w+n/h/3v2cu8ppA4toGNKWA6PMxSmFHBHjYxZ1c4BV7eLAq
	wAYfNP2to+B3+Ji9oHR9ldUO4IDI08GeP/sbF73EvBc7B/YEIcM2ywKhfNrfdbwCaFvS4f
	EOv70ZyfWgfmpFxAcM0h4kw7CshQwJKhobFZzLOhaev/ARgU2gGhtJMcv6S+vB6F+fXzj6
	NgiDP3CZWSJdE61PA6wScZig5YM175d1w4TaVGveuNeyyCKwsbPqlpAIcfj5mwdt2kFqyw
	+L6uysXUZgYMzPOgghHIAK4c6DgdC2H69F2P92+8WZgQdFKXzdF5fOeF8yX0Rg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:52 +0200
Subject: [PATCH v5 04/12] usb: cdns3-ti: run HW init at resume() if HW was
 reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-4-8664bfb032ac@bootlin.com>
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

At runtime_resume(), read the W1 (Wrapper Register 1) register to detect
if an hardware reset occurred. If it did, run the hardware init sequence.

This callback will be called at system-wide resume. Previously, if a
reset occurred during suspend, we would crash. The wrapper config had
not been written, leading to invalid register accesses inside cdns3.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 5253829ea1d8..618fba5fa2bb 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -188,6 +188,12 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
 	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
 
+	/*
+	 * The call below to pm_runtime_get_sync() MIGHT reset hardware, if it
+	 * detects it as uninitialised. We want to enforce a reset at probe,
+	 * and so do it manually here. This means the first runtime_resume()
+	 * will be a no-op.
+	 */
 	cdns_ti_reset_and_init_hw(data);
 
 	pm_runtime_enable(dev);
@@ -232,6 +238,24 @@ static void cdns_ti_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static int cdns_ti_runtime_resume(struct device *dev)
+{
+	const u32 mask = USBSS_W1_PWRUP_RST | USBSS_W1_MODESTRAP_SEL;
+	struct cdns_ti *data = dev_get_drvdata(dev);
+	u32 w1;
+
+	w1 = cdns_ti_readl(data, USBSS_W1);
+	if ((w1 & mask) != mask)
+		cdns_ti_reset_and_init_hw(data);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cdns_ti_pm_ops = {
+	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
 	{ .compatible = "ti,j721e-usb", },
 	{ .compatible = "ti,am64-usb", },
@@ -245,6 +269,7 @@ static struct platform_driver cdns_ti_driver = {
 	.driver		= {
 		.name	= "cdns3-ti",
 		.of_match_table	= cdns_ti_of_match,
+		.pm     = pm_ptr(&cdns_ti_pm_ops),
 	},
 };
 

-- 
2.45.2


