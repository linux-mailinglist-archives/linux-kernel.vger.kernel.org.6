Return-Path: <linux-kernel+bounces-448878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6A9F46B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428AC188B406
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0571DDA09;
	Tue, 17 Dec 2024 08:59:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC4335C0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425977; cv=none; b=EzRw6dbkcwYHcJc860kCHxUIoUFQ93lEyajCOuAJ1QVeIK+SeZkenKXF3pH0OdVSj4KTIZgWoIvSGQXH8q9OltLjZtUtYmxbHESZtCjt4t1zFPszjtC9Q7PCEw6vt+kFMpmNT2l3LbtN1omIbhZYaalNQDEtkUZ9d3JVccYArJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425977; c=relaxed/simple;
	bh=EOFGNVLsG24xV1DOSnYy5OAb8BnBV32nXD1kHSxn5HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O6J6xJ/XNXicX9QVOA/7TVJ08qY40VDgRTrJax95gB5gIhAf9l2k4l6WMxaYU1KAdU5rZ90syOHjP5FjxicCLd9Y6Ohni3HmpW+mqWxEJakfmdJScC173oz6JhKmz0bmgW86U+ehKJkxY84+6XiLEEzW3qOaRHVlZL4CRfxqGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tNTQS-0002Hh-Vt; Tue, 17 Dec 2024 09:59:33 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tNTQR-003pr8-2X;
	Tue, 17 Dec 2024 09:59:32 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tNTQS-00CdUx-1c;
	Tue, 17 Dec 2024 09:59:32 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 17 Dec 2024 09:59:25 +0100
Subject: [PATCH] regulator: pca9450: use dev_err_probe on errors requesting
 resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pca9450-dev_err_probe-v1-1-04046092a92d@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAGw9YWcC/x3MQQqAIBBG4avErBNSDKurRITZX82mZIQIpLsnL
 b/Fe5kShJFoqDIJbk58nQW6rigc/tyheC0m0xirjXYqBt/btlEr7hkic5RrgXKu07YPHi1ApY2
 CjZ//O07v+wGeECj3ZwAAAA==
X-Change-ID: 20241217-pca9450-dev_err_probe-778149cae5ee
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Probe functions requesting resources may return -EPROBE_DEFER to
the driver core to instruct it to retry probe at a later time.
This is not unusual and printing an error message unconditionally
is just confusing to users:

  nxp-pca9450 0-0025: Failed to register regulator(buck1): -517

Using dev_err_probe remedies this:

The error message will only be shown if the error code is not
-EPROBE_DEFER and if it is, the deferral reason is saved for display
at a later time.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/regulator/pca9450-regulator.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 9714afe347dcc0205b40243252638dff5f9298ad..8f5ba59f7fe52bee1e467a3e6adf81a6a5476221 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -953,13 +953,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		config.dev = pca9450->dev;
 
 		rdev = devm_regulator_register(pca9450->dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			ret = PTR_ERR(rdev);
-			dev_err(pca9450->dev,
-				"Failed to register regulator(%s): %d\n",
-				desc->name, ret);
-			return ret;
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(pca9450->dev, PTR_ERR(rdev),
+				"Failed to register regulator(%s)\n",
+				desc->name);
 	}
 
 	if (pca9450->irq) {
@@ -968,9 +965,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
 						"pca9450-irq", pca9450);
 		if (ret != 0) {
-			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
-				pca9450->irq);
-			return ret;
+			return dev_err_probe(pca9450->dev, ret,
+					     "Failed to request IRQ: %d\n",
+					     pca9450->irq);
 		}
 		/* Unmask all interrupt except PWRON/WDOG/RSVD */
 		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
@@ -1022,10 +1019,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	 */
 	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
 
-	if (IS_ERR(pca9450->sd_vsel_gpio)) {
-		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return PTR_ERR(pca9450->sd_vsel_gpio);
-	}
+	if (IS_ERR(pca9450->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev,
+				     PTR_ERR(pca9450->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
 
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241217-pca9450-dev_err_probe-778149cae5ee

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


