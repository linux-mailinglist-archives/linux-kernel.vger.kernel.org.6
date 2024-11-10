Return-Path: <linux-kernel+bounces-403367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46959C34A4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D5A2820E8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB101547C8;
	Sun, 10 Nov 2024 21:01:00 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4B157487
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272460; cv=none; b=MZgG2hHLKGzxYhvdRseVScQg8wMQwgwzGGCsUcBFElG3lLNDN9DPYTtA9VnizO/VBavFa+u+LAGSCZkDzD0mvo7aB+8p00cdQtj4766wYK4bFxWbrq9QtonrLPT1pZaeh5Cp1drFtEIxCdMIzWA4lGYzh0Z7QiIZK+MnEu6lE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272460; c=relaxed/simple;
	bh=IAcBwFzWYVJh6SimAOjlIxXhGXkWE1ZKpdBpKfVlNUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI1AhDmYmFKQvJuR+B/lVAqlFP8FgwbAhcbCoruTO2Rs62uXWoQJEhKQMtLeFR/ZZEGR/Oe8b3JW9auAwaIFgSNE+3Tp+o6YBV+Jdxpo7PvttnAUaHDkdTP5Ur9Z7B+3Cl1S/j49vK1GSNO3oVq2uyvSOY7zjguS1Zg09iiGFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id db5f26d3-9fa6-11ef-9b01-005056bd6ce9;
	Sun, 10 Nov 2024 23:00:46 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/6] pinctrl: cy8c95x0: Use 2-argument strscpy()
Date: Sun, 10 Nov 2024 22:59:41 +0200
Message-ID: <20241110210040.18918-2-andy.shevchenko@gmail.com>
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

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 5096ccdd459e..5f533dff4417 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1424,7 +1424,7 @@ static int cy8c95x0_detect(struct i2c_client *client,
 	}
 
 	dev_info(&client->dev, "Found a %s chip at 0x%02x.\n", name, client->addr);
-	strscpy(info->type, name, I2C_NAME_SIZE);
+	strscpy(info->type, name);
 
 	return 0;
 }
@@ -1457,15 +1457,15 @@ static int cy8c95x0_probe(struct i2c_client *client)
 
 	switch (chip->tpin) {
 	case 20:
-		strscpy(chip->name, cy8c95x0_id[0].name, I2C_NAME_SIZE);
+		strscpy(chip->name, cy8c95x0_id[0].name);
 		regmap_range_conf.range_max = CY8C95X0_VIRTUAL + 3 * MUXED_STRIDE;
 		break;
 	case 40:
-		strscpy(chip->name, cy8c95x0_id[1].name, I2C_NAME_SIZE);
+		strscpy(chip->name, cy8c95x0_id[1].name);
 		regmap_range_conf.range_max = CY8C95X0_VIRTUAL + 6 * MUXED_STRIDE;
 		break;
 	case 60:
-		strscpy(chip->name, cy8c95x0_id[2].name, I2C_NAME_SIZE);
+		strscpy(chip->name, cy8c95x0_id[2].name);
 		regmap_range_conf.range_max = CY8C95X0_VIRTUAL + 8 * MUXED_STRIDE;
 		break;
 	default:
-- 
2.47.0


