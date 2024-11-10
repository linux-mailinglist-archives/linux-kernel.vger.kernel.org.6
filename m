Return-Path: <linux-kernel+bounces-403365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2989C34A0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F780281877
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9F15535B;
	Sun, 10 Nov 2024 21:00:56 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119A154457
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272456; cv=none; b=aECyTVdtrsMd8/4GUviqloUyh5Xw5yjn0rsyjX4+lkTIGbJYVJV8c24qudEq5UFDqjOV/c77Xeb6+t0f3F7tx8/Q9IjtV7LaCLApLCK9nugHoqUvQVd31xFvRhQmdLBYDZKaZQJSiy+iZ26TqSMLLmKHr/Q24OX1+27UU0c8N6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272456; c=relaxed/simple;
	bh=StWURDzPXrrNwdPZqNvuhg+95fYmCc2elITSw30Am9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alNVLj9xgAudRL1uRYyF1nu0E3ow5tesoA1framzviYLzvhMrsPeGtYCqtZpcS+mkJuxVlCXa/sCb0Nz3TVjkRw9yyAgg9EM5JuFM2lUJ6qq3LYdEDqkSgNpaeAEEB0WZ4I7Qe4UhIxy0+2bLHL+B5gJdMMNHPA798n3OqgDItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id de7c4074-9fa6-11ef-8261-005056bdf889;
	Sun, 10 Nov 2024 23:00:51 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 4/6] pinctrl: cy8c95x0: Use temporary variable for struct device
Date: Sun, 10 Nov 2024 22:59:44 +0200
Message-ID: <20241110210040.18918-5-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241110210040.18918-1-andy.shevchenko@gmail.com>
References: <20241110210040.18918-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a temporary variable for the struct device pointers to avoid
dereferencing. This makes code a bit neater.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 54b080f63226..8b118fd09e9e 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1429,16 +1429,17 @@ static int cy8c95x0_detect(struct i2c_client *client,
 
 static int cy8c95x0_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct cy8c95x0_pinctrl *chip;
 	struct regmap_config regmap_conf;
 	struct regmap_range_cfg regmap_range_conf;
 	int ret;
 
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	chip->dev = &client->dev;
+	chip->dev = dev;
 
 	/* Set the device type */
 	chip->driver_data = (uintptr_t)i2c_get_match_data(client);
@@ -1467,14 +1468,14 @@ static int cy8c95x0_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "failed to enable regulator vdd\n");
+		return dev_err_probe(dev, ret, "failed to enable regulator vdd\n");
 
 	/* bring the chip out of reset if reset pin is provided */
-	chip->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	chip->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->gpio_reset))
-		return dev_err_probe(chip->dev, PTR_ERR(chip->gpio_reset), "Failed to get GPIO 'reset'\n");
+		return dev_err_probe(dev, PTR_ERR(chip->gpio_reset), "Failed to get GPIO 'reset'\n");
 	gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");
 	if (chip->gpio_reset) {
 		fsleep(1000);
-- 
2.47.0


