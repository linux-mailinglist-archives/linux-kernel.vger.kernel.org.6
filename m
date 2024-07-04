Return-Path: <linux-kernel+bounces-241655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4A927DA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC661F23C44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CE13958F;
	Thu,  4 Jul 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGqONJEJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B213790F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120505; cv=none; b=uQjzrOa+Gyp5abbtt+2pqXjptmdlKEZaFCbw9Q0JH7SE6KkJEmXQEDlXb7k7uwkTT4hTTd/1ijDOMiyeXaWO57urmtST01TlPZcVcBM6g12CJMQJUzm0lUXMqQBj1Fvgx183sO2ZSFtYIhhGgpjf8F27YT3KyGmUwrLXIlJAG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120505; c=relaxed/simple;
	bh=UBrj0apH+HQSLddbFx/5OxnKoZB9AnNCZZsQ+0n+gjw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fHPGUPW6L/4Kw+H9r14HeUMCVVBehjc1qvN+G/oYMBONYdXqMShL6gkfNJaoS1Ss7IGBcW5IUVSk2dNTUo/fQbdhRPgmxQwgrOb81qNBUWAV9QYAfAJIlHAyHxCnlhuWh+Uv+4EdvnvJFH6gaM9rvkpB2AL4Z3Czwapo7AIIWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGqONJEJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6506bfeaf64so14593437b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720120503; x=1720725303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i80ZUBWAx84nOrbGT0/9WVkfDYOHwt33QWZ6oeCQ+nI=;
        b=EGqONJEJnxbYB4+DLthVwxZ/Ada30iTXJanZa7gixEAeX/MogBOKGr+E9iD4uwAKyx
         X6XgBrun30L3nLH0b0vs5TzeF6BTmHplEYhJ+WSVWKriQwjHq0DXRBlZlW7NbC2ElwyJ
         Y5ZZYf6a0OGJpsqd59S1SRE9na+Xp4a6DmTgSGYoX55442LL7crlqWyI6etEnKWpGrDK
         a11wAwLRskFs0vTsKirTvML+dBnUT8+GSfjhV20v2PuCDKwDcwvQ3Tv4VzjVDAKI+FeW
         zmCuqED6w/WO33TEqcPncOTUVp5d9QanZHUGt6oX7yLPnlSD9ldWwjB7zz8H57r5qXKu
         JJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720120503; x=1720725303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i80ZUBWAx84nOrbGT0/9WVkfDYOHwt33QWZ6oeCQ+nI=;
        b=bIqI05GoyChh55QhGMokyglKstZPr9H+ZuQZWY2gaTfnCHpRRhypFBuLGvAZY56Evm
         YsARj1mqgmpAhPFcwA5JjV9wm68w1fs08WqeV1MNz60tIXebYzU59AGbZaEaHwepJkuv
         sNJUXdr5xEP0gUH9FF05truPAQ677wVA9B2V1qVLHq+v3e2MZadNRJ4TWakVhzluszpM
         WlcvTS9DvUoMNj7PqiIiZEWm7mrQI/QuXqPY67Qp6LQkfg+IZdVKoZFqA1xNxxhlID/B
         YM4ZLX02avzepjOOisOFwPw2ueqikJ1HPwopRkUOT8vctEzWcUP06BJlnJ7/QfgV/p0N
         dYwA==
X-Forwarded-Encrypted: i=1; AJvYcCVr1jEb0HUn6AaCZLo3pVKcBdOXcIJ6/Et7/c010Pwo4v1QMo93DBJnmB8I8PrkvdgyTYguq0+kIQOpyGBafOIO5535ZTYDkNKQnopV
X-Gm-Message-State: AOJu0YzHlvGvCq9im9HO4MV+DuLHHIKUnfUmvSbGKyILztJPJtDbeRz0
	YC+Mr51cKRLYHOlhXuRMDCn2wUNEdcZeSxIqEh6ArNQqXP6VSLN5EqSKuT2UR7nI0FNlXQe/WSL
	KzkOMVU5LGTS56PTZ8A==
X-Google-Smtp-Source: AGHT+IEFo7twwokc7q361Gzc055ltY960yY6+o9Hm6sqtfHJ+rYNiyNteCDo92gvoK4d/xqYoU0bNAJTduQOEDwz
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a05:6902:1002:b0:e03:b3e8:f9a1 with
 SMTP id 3f1490d57ef6-e03c192c3b3mr153902276.2.1720120503461; Thu, 04 Jul 2024
 12:15:03 -0700 (PDT)
Date: Thu,  4 Jul 2024 15:15:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704191500.766846-1-zenghuchen@google.com>
Subject: [PATCH v2] leds: lm3601x: Calculate max_brightness and brightness properly
From: Jack Chen <zenghuchen@google.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jack Chen <zenghuchen@google.com>, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The torch_current_max should be checked not exceeding the upper bound.
If it does, throw a warning message and set to LM3601X_MAX_TORCH_I_UA.

LM3601x torch brigthness register (LM3601X_LED_TORCH_REG) takes 0 as the
minimum output (2.4 mA). However, 0 of led_brightness means LED_OFF.
Adding a -1 offset to brightness before writing to brightness
register, so when users write minimum brightness (1), it sets lm3601x
output the minimum.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/leds/flash/leds-lm3601x.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
index 7e93c447fec5..1a6b9ee9e582 100644
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
@@ -190,7 +190,7 @@ static int lm3601x_brightness_set(struct led_classdev *cdev,
 		goto out;
 	}
 
-	ret = regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightness);
+	ret = regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightness - 1);
 	if (ret < 0)
 		goto out;
 
@@ -341,8 +341,9 @@ static int lm3601x_register_leds(struct lm3601x_led *led,
 
 	led_cdev = &led->fled_cdev.led_cdev;
 	led_cdev->brightness_set_blocking = lm3601x_brightness_set;
-	led_cdev->max_brightness = DIV_ROUND_UP(led->torch_current_max,
-						LM3601X_TORCH_REG_DIV);
+	led_cdev->max_brightness =
+			DIV_ROUND_UP(led->torch_current_max - LM3601X_MIN_TORCH_I_UA + 1,
+				     LM3601X_TORCH_REG_DIV);
 	led_cdev->flags |= LED_DEV_CAP_FLASH;
 
 	init_data.fwnode = fwnode;
@@ -386,6 +387,14 @@ static int lm3601x_parse_node(struct lm3601x_led *led,
 		goto out_err;
 	}
 
+	if (led->torch_current_max > LM3601X_MAX_TORCH_I_UA) {
+		dev_warn(&led->client->dev,
+			 "Max torch current set too high (%d vs %d)\n",
+			 led->torch_current_max,
+			 LM3601X_MAX_TORCH_I_UA);
+		led->torch_current_max = LM3601X_MAX_TORCH_I_UA;
+	}
+
 	ret = fwnode_property_read_u32(child, "flash-max-microamp",
 				&led->flash_current_max);
 	if (ret) {
-- 
2.45.2.803.g4e1b14247a-goog


