Return-Path: <linux-kernel+bounces-237610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABB923B77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC916281D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4915887D;
	Tue,  2 Jul 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="KmZhuMAB"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB12AD17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916387; cv=none; b=MzeToFIC1cSNfty5urxTtioRf9GAh0LGy2+s7qzeKA0GUVq+zrKs+OBkSJl7GbeQqdA7SUBu1LrGfuZtY4AWqEOnzO/jebSaHeYwlsjoD5mSV11BFYmDNbvVjNq8BbSanY4692c3jk+0wP2WD0JyZ7kWtogLiLTRfOI0uiSPFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916387; c=relaxed/simple;
	bh=Q0WlQsT+sfGd9MDgDc3rO8/gjW0FJPFUpaxCbJNQ6NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTraFwxXFKhfvX/J4cYpZgL4aO1j4nWVoOu5QTCahvyBXKetKijyyn2BRYvahhv4UYBTVn9iGtBRFmR8zi0K3dD23ADkb5tlIBQ/RDdoZNYAp+iq8yC+7FO45o8n/Zk6v7Fq1WUEQBUCYLqzpFwmMp/iAkxQ2GhvcoevSZBb6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=KmZhuMAB; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42503BFC22;
	Tue,  2 Jul 2024 12:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719916382; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WjUMr+oTPhCNu/UoVZDEPwzZPd8HmMnqLmAW7x3pgnU=;
	b=KmZhuMABtchHtNnW7vidc2L0N+eDY86DpJOcmWsQpNX4D45gOru0WoJTA3hP4sGDxBzhS2
	KkHRZLqsoHknzu1Aavq+ad2i7PUiSJ6cwbwchf0C9SPZ9Broz37nmIdfsPCRUOYvVOv32X
	eGm4JsMZrbZ3+JXRFwAda6ozD+Ki5WIV7qoB6wbsrn0EjLKzOMs+o5s1x4Hzzd939f9ZNe
	DSKtPliiZC/DtRjRw5TcopNsJgN/ohGyP6qW3cklNMxIM/4L7QV2gvuw6t3qLNGNqP3nuF
	SUg1Rn26Ea1y028X3LJmYOB5ZCn3KJC8N2ureLF5r+sJfFYBbedowG6jWhEWFQ==
From: Frieder Schrempf <frieder@fris.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bo Liu <liubo03@inspur.com>,
	Joy Zou <joy.zou@nxp.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 6/7] regulator: pca9450: Make IRQ optional
Date: Tue,  2 Jul 2024 12:31:18 +0200
Message-ID: <20240702103155.321855-7-frieder@fris.de>
In-Reply-To: <20240702103155.321855-1-frieder@fris.de>
References: <20240702103155.321855-1-frieder@fris.de>
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


