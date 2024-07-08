Return-Path: <linux-kernel+bounces-244049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96200929E66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39671C20DED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778B4AEF7;
	Mon,  8 Jul 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="gFwAX/Il"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8842033A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428095; cv=none; b=ti2lBZZgciscqGQiIHRu4DZiFi4MJCssHgbn4UcyPOfhqgbDSH6qdb8BK7IXfJTHIku9h2H5TP3WXQafeE0joB7x1GqlJDNgs+IZy6qRgZ4N6ks7pwDCnDh/QLojHBy0/KaXF8ynYYDpInX7nU4hZdC9Fw6qsdX3l+DtoM7hRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428095; c=relaxed/simple;
	bh=p2rxEF5VMZjtICNyZJPHmhFLE1AycL7XT30yF4aoSrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOkG+6mx6ZFLx9jfZj/aUQ7VECaXSK02Tkin3r26i9ufv/p/YptIKZhil2o/wgF6+2B+mXteCrPOCXUm2RSloFgav3zUvHUHmvzGLRg+BXLVXjWhpu8xQnC8FQIpW8u3ugfpbJFfcwoVuXunp+cGH4fQp6//4HYM3aHwx8N8F1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=gFwAX/Il; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67B0BBFBAD;
	Mon,  8 Jul 2024 10:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1720428090; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bie3S+NRtQsHAbGNnD72XIrDGSrQyPJe4739teujuCY=;
	b=gFwAX/IlJ/OIRFFh7HeljCxmKKXyLq/p50urW+HdWGK20Q/9ie59qwOyWue2L4WvZ3UypY
	ddsTNmyQRcr0R96zvA/paTezwWxsr6DKWH4Fe7BXnw6m5Q5MvIh3JGMCGuUrVZf8Zu+s1B
	XnsZ4ZABy1OsurU/rscboX5yFBRU/ot2cujdkVgNncR67jHMeS+lG8CCOdFt4FJwDElPfu
	1LX7YbCoVBjv4BsiMy4qGQ2Qt/gCBKhOknc64oqbFJpJ1wuxQ+8NmFBWJPKYavnJ1umq9j
	hvxYwx6YcCpJxDxS+BIZQUPHhAqlCH/4Chd79rSyGh+r6i7m27H1CICs9h8RTw==
From: Frieder Schrempf <frieder@fris.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bo Liu <liubo03@inspur.com>,
	Joy Zou <joy.zou@nxp.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/5] regulator: pca9450: Make IRQ optional
Date: Mon,  8 Jul 2024 10:40:34 +0200
Message-ID: <20240708084107.38986-5-frieder@fris.de>
In-Reply-To: <20240708084107.38986-1-frieder@fris.de>
References: <20240708084107.38986-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The IRQ line might not be connected on some boards. Allow the driver
to be probed without it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 drivers/regulator/pca9450-regulator.c | 41 +++++++++++++--------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index be488c5dff140..9714afe347dcc 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -891,11 +891,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	unsigned int reset_ctrl;
 	int ret;
 
-	if (!i2c->irq) {
-		dev_err(&i2c->dev, "No IRQ configured?\n");
-		return -EINVAL;
-	}
-
 	pca9450 = devm_kzalloc(&i2c->dev, sizeof(struct pca9450), GFP_KERNEL);
 	if (!pca9450)
 		return -ENOMEM;
@@ -967,23 +962,25 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
-	ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
-					pca9450_irq_handler,
-					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
-					"pca9450-irq", pca9450);
-	if (ret != 0) {
-		dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
-			pca9450->irq);
-		return ret;
-	}
-	/* Unmask all interrupt except PWRON/WDOG/RSVD */
-	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
-				IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
-				IRQ_THERM_105 | IRQ_THERM_125,
-				IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
-	if (ret) {
-		dev_err(&i2c->dev, "Unmask irq error\n");
-		return ret;
+	if (pca9450->irq) {
+		ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
+						pca9450_irq_handler,
+						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+						"pca9450-irq", pca9450);
+		if (ret != 0) {
+			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
+				pca9450->irq);
+			return ret;
+		}
+		/* Unmask all interrupt except PWRON/WDOG/RSVD */
+		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
+					IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
+					IRQ_THERM_105 | IRQ_THERM_125,
+					IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
+		if (ret) {
+			dev_err(&i2c->dev, "Unmask irq error\n");
+			return ret;
+		}
 	}
 
 	/* Clear PRESET_EN bit in BUCK123_DVS to use DVS registers */
-- 
2.45.2


