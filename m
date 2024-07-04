Return-Path: <linux-kernel+bounces-241641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF5927D74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF70D1F24B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CB137764;
	Thu,  4 Jul 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUZ12dwo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01E13A87C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119723; cv=none; b=TxR2CZh7B2iPQxVeRfuWtMwTride9P730SOJEYgxjh2k4bkWdAEPk7epNASQ2BWKLOP5H/3gH0RZv54jj9Q9tND2vUeDEfGt9CWaWV6nm7julySohf8uMtjBCWWrbYoR4aSNES94hTA/3AFFMB6A+UqSZucrZdCxQJVOCcFmVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119723; c=relaxed/simple;
	bh=2UKYq5bhPsPv12mO8kx6pTkKpzG9k1rkOi+Jc8rQ//g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WDwWJKZoy7reCsDblujnTOqvYgDRI4eDd0dFQI3XHVeTNIPN4elRDeSeGEg18S2c0u6vk1vFJeYZRybnCAHABk9ifjpiI9KqQk8hwUgj9KzPBuJP3DkrA3BRVTsQeQBpTaHmj/VUTNh8okDs9wpyp6PfL5006x//qQd279oibfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUZ12dwo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb4a1f7bfso16544807b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720119720; x=1720724520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9G8g66vcUfsbATIp2mXIZzia2L3xSDwYH8ppQZgSmM=;
        b=VUZ12dwo+udhtJLAc4eY17apeKP3vP4W3sxqs0/CGQ5L12AmNEUgG/eF/1jeoKw4cy
         i6Nbf7+v7o+ou37PtDaj+eCQ9s3rSI+MwzaqTQIY2ghIZX8vV4EMrQd1rdWdH7/eFPuL
         thxaz1RFXaTnCJ+ZsZts1sfBSw/n5o8riQKFggonFpGgJS/AdtQrg8I+oC8rMmTe8vK/
         /979bwBy22beXy/ThaAE1+DAk0TxlDhZnRu3VFFneyrVc58CC5vMTimanap3aCDe5p/U
         eGWez35PWt8nYBmzSRX6Bz7E6rkHY8kCPCu3gzdyzQWPbGeVCgjYfxUY3sT44Wa9NJSJ
         CIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720119720; x=1720724520;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9G8g66vcUfsbATIp2mXIZzia2L3xSDwYH8ppQZgSmM=;
        b=ihvpfSWikDn3yHdvBM6bmjUxLJJ3W4wTN55VLVLMwwB/blQV+Egbq/VVr4Q8oseVlI
         pfaGch7deaZX3gvXYOlIlSuDfPQC+otIrfyLvbbv9GFgN+mH1Iy04QkUjPMbeTrvHEqM
         cOvcm2FdNrAx/C68zR8qMXnLJMhdUb8fhHcbAXACBj22KiuRe9HRRuF8EMXU0C3/sL5H
         kbRZQL965wwoDRM20PCDNbTdsvmpou3wQmtoUnyH/C57xCUyzjRX/I6bBz7It0MNaFz9
         2G2vg9lj8THLxv9JMYnJL2sYOe+A5xrNyGIZNPA3NNUxdOTInnVFLml40qg305bMLslo
         3J3g==
X-Forwarded-Encrypted: i=1; AJvYcCWssXV9VzFd+YvnPPamt974bzYKDqHIslw0n2j9fWRTWxl1fPZ098tlVxGRgjYWf2pQbzrdKjQoObFCFe9ft3UQ+nDY6NWpqXt1WqRV
X-Gm-Message-State: AOJu0YxQ+x13j58LTJXNeXS6ymffzQnGwzO56s7YwKQv4yRCk774YkB6
	k06ItLJFiR3qIu/NElFUjl9mtpdgi/PHAJ/GnSDp7j7orZenWEH5dH//OaSbV4oNYtX5LOdFz7p
	gwlr7hYNXdPMyWrHQjg==
X-Google-Smtp-Source: AGHT+IGKlUQ0UPyTqub9i9vt+OGJA5Ys/6xr3OtS7RcyTnEAky7OPp/BWLiMwIAdNqU90IW4m6vBjJ5IWXeUaDHs
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a25:6941:0:b0:e03:5050:acc5 with SMTP
 id 3f1490d57ef6-e03c19b030bmr51437276.7.1720119720128; Thu, 04 Jul 2024
 12:02:00 -0700 (PDT)
Date: Thu,  4 Jul 2024 15:01:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704190157.712590-1-zenghuchen@google.com>
Subject: [PATCH] leds: lm3601x: Calculate max_brightness and brightness properly
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
index 7e93c447fec5..fc4df904ea90 100644
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
+	led_cdev->max_brightness = DIV_ROUND_UP(
+			led->torch_current_max - LM3601X_MIN_TORCH_I_UA + 1,
+			LM3601X_TORCH_REG_DIV);
 	led_cdev->flags |= LED_DEV_CAP_FLASH;
 
 	init_data.fwnode = fwnode;
@@ -386,6 +387,14 @@ static int lm3601x_parse_node(struct lm3601x_led *led,
 		goto out_err;
 	}
 
+	if (led->torch_current_max > LM3601X_MAX_TORCH_I_UA) {
+		dev_warn(&led->client->dev,
+			 "led-max-microamp cannot be higher than %d\n",
+			 LM3601X_MAX_TORCH_I_UA);
+		led->torch_current_max = LM3601X_MAX_TORCH_I_UA;
+	}
+
+
 	ret = fwnode_property_read_u32(child, "flash-max-microamp",
 				&led->flash_current_max);
 	if (ret) {
-- 
2.45.2.803.g4e1b14247a-goog


