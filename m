Return-Path: <linux-kernel+bounces-423727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E829DABF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B5C281B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8EE200BBF;
	Wed, 27 Nov 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="DqMa2xbP"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8884200BAE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725884; cv=none; b=i88nOLuRY1fIY3kUKwrKvJtC8iDZFhcTKCHXvu44J8K2gHDtSKpOskGWzrpYdXH7eV8k/9sOOe1QMuR4PZ31gsInIco3MmnFU7rmKeqzvIPqyvYc6Hn4azXQIU67QRP0gK2TdJPe6rBP3KNyT01HRFlBd1+byFc6fekjaKF2kBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725884; c=relaxed/simple;
	bh=1on6ivOx/h86syEfLDL3bCAbyzFwZwyNNwg5A0/EQ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7o+78TkDKpASym0YzReSb6avVnyBdMOhDW07J7hIwSE7dhAFOJdS9OFSNHtmQnc723wXBrBbo+3PDXG2oF47R8tUVtEK/5oGjLj6+FlyuG5m3tsUOFoURUjh9fJhNtlydNv3otTmsAZoGzSKsALU/Kh4hEeTxvDGkvB5LW8HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=DqMa2xbP; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9FDCBFBA9;
	Wed, 27 Nov 2024 17:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725880; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lCaePtDQjPCLIdCcCr6OunaIwfPqBEUXNIZ/ElYG08g=;
	b=DqMa2xbPOiYHmB00M8XGgKAx+DjXCOxQkjFDsSbLtpaxs1rfWfr8YLsgudXjw4NS5o3IZ5
	/8vmDOKhHvoFfhMwPvGAbh2d8OKAa5WfVolOiGbJyJwPdOzhj7m5yB58rVpYi/CadXHUCW
	wyX0t8/mhW1SV1EkKFJSj2aBiZFVa+B72sUHF6N40ATzo5FfKOIJ8OJKAq4rufg7GGJF2/
	myUD1A+WjC4vALZpQ7BNJS/l8tmEgHNcrpNn8S4/BxhamWj4HO1u3K6Lqm0muEoCrDce2P
	gqojdd5I4KeFqOEz/WEIalPVFZoOeQv1LJHYMABpVbJzAACU2DUTiAN/IIl7UQ==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bo Liu <liubo03@inspur.com>,
	Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v2 05/11] Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"
Date: Wed, 27 Nov 2024 17:42:21 +0100
Message-ID: <20241127164337.613915-6-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This reverts commit 8c67a11bae889f51fe5054364c3c789dfae3ad73.

It turns out that all boards using the PCA9450 actually have the
SD_VSEL input connected to the VSELECT signal of the SoCs SD/MMC
interface or use a fixed level.

The assumptions on which this was implemented were wrong. There
is no need for a GPIO-only-based approach and keeping this will
cause confusion and lead people to implement non-standard setups.

All in-tree users of this have been migrated and we can savely
remove this now and allow for a more future-proof approach
of syncing the actual status of SD_VSEL and the PMIC driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* rebase to current master
---
 drivers/regulator/pca9450-regulator.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 9714afe347dcc..0f8a515a0b11a 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -32,7 +31,6 @@ struct pca9450_regulator_desc {
 struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
-	struct gpio_desc *sd_vsel_gpio;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -1015,18 +1013,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
-	/*
-	 * The driver uses the LDO5CTRL_H register to control the LDO5 regulator.
-	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
-	 * check if the pin is available as GPIO and set it to high.
-	 */
-	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
-
-	if (IS_ERR(pca9450->sd_vsel_gpio)) {
-		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return PTR_ERR(pca9450->sd_vsel_gpio);
-	}
-
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
 		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
-- 
2.46.1


