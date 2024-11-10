Return-Path: <linux-kernel+bounces-403364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3BA9C34A1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630F7B20B69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFF155342;
	Sun, 10 Nov 2024 21:00:56 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FD13A3F3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272456; cv=none; b=GwXomeaTgzpzVtVwYafJs+bgj1qYxEoMqQt+NYIqSyPfeWqzG6E2dvqjFc4h65nsBtMDhnp7UOcwMMCGfb0k6pAgVxEmaROokyVXyEbC3RqbML+5JQdumqgbxaRTSfqC6jOXV/wZj5JBIt9VLdxvdAlgfljlvHzvrVyjfqrPHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272456; c=relaxed/simple;
	bh=QZQswWBjiA6sKRY7WdJThEE2ZM5Xh2HKQzfY+W6JxpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF+diwrLbz4qt5kRUZKELE/puEIJEF8gDe5PPVqyoODoGbx7LJ7GHEY5RvgmxuXBpw7hrs3n3FiY3Pr9RL0TVUS6JMFzbL+6s3CtzFDFPIhDLeiPyqyo11ZrpCMP5pQcCBs8MnXgoXj3ahXGxzBo1adLlCY01ulCOroV4F/kQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id dd80ce7b-9fa6-11ef-9b01-005056bd6ce9;
	Sun, 10 Nov 2024 23:00:50 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 3/6] pinctrl: cy8c95x0: use flexible sleeping in reset function
Date: Sun, 10 Nov 2024 22:59:43 +0200
Message-ID: <20241110210040.18918-4-andy.shevchenko@gmail.com>
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

The device reset assert and deassert length was created by usleep_range()
but that does not ensure optimal handling of all the different values from
device tree properties. By switching to the new flexible sleeping helper
function, fsleep(), the correct delay function is called depending on
delay length, e.g. udelay(), usleep_range() or msleep().

While at it, move out GPIO consumer name setting of the reset conditional,
the all necessary checks are already done there, so logically that call is
not related to the reset sequence.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index cb6d9458c1e8..54b080f63226 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1475,12 +1475,11 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	chip->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->gpio_reset))
 		return dev_err_probe(chip->dev, PTR_ERR(chip->gpio_reset), "Failed to get GPIO 'reset'\n");
+	gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");
 	if (chip->gpio_reset) {
-		usleep_range(1000, 2000);
+		fsleep(1000);
 		gpiod_set_value_cansleep(chip->gpio_reset, 0);
-		usleep_range(250000, 300000);
-
-		gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");
+		fsleep(250000);
 	}
 
 	/* Regmap for direct and paged registers */
-- 
2.47.0


