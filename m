Return-Path: <linux-kernel+bounces-541783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC2A4C195
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240353A91CD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B632116ED;
	Mon,  3 Mar 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Fwyvdffa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C91F0E4F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007923; cv=none; b=j326+3yEls7YkLQBYXi/ziiJInFT9K1A+30inS5lHZI32xvoMbwvAIJmB/X1yvoPgVoVPhNQdnVQLt1UEbb6TX0XznMnoHlARFWu3MIXUY69hzfyy/Ox5JK41x1yEHjcJT9yja1p1avfKNOAHx3+kAyJlL8aeCRP1q8VFodE/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007923; c=relaxed/simple;
	bh=9lzejMsgIcVx6o3k2HM9XE0p8xgIq5wdNaTmJJ8s+zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUUjM1lha/lgbOxQ9E4F4RpovBUC5ie41PM2jKnHLutCHcyqaD7v1gFvGuz6UnfIybdQd72Ax7ppFclXg6dm7NuCMps5p2KDII2ujTu6QVm4Wgd+Xvg3ILPTqLWMERwwM0z/Nb0DtLw2lBj2RUpXBlEU8JFpTx2rpNZKYHCeEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Fwyvdffa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso30218615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007919; x=1741612719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TidBt2SWkGKP+ilcC4ucnacYIVlA19tuK+wOmbWsRkQ=;
        b=FwyvdffaDwH2VzM0BeDLEDW21LffWk9fbARXXaFO1ugV159wMmG1Ufm/wqMdwWZURU
         4AYRczxNR6s1uF/EzW7mXd78bf1wm34/dLIPKodSvvHNzLK2TZH72wknNy8aGBk1EfK+
         PX/XdnTbcfvHdDLf0UyWxKSu48g2O6PwYrA5UasFulq7u9eTosUfQNwZ3+bmBv+q8LIw
         PkFfw+0mgXorh7rtgoWtRMk5xnt0W5CF8ZPpf4r9PU/q/JBB4qJ34hh9DfCvYxS0wsu1
         nbVfsDYC2auVNniJYEz2lpA/lrvzloG9IYuRnKB1C4XBu4oeEvu9j5Wscb29gFgroLNg
         xaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007919; x=1741612719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TidBt2SWkGKP+ilcC4ucnacYIVlA19tuK+wOmbWsRkQ=;
        b=ciNPd+Sr6ygpbmpJeRJwC+ijT9vZa6XaraIbJHQulyAWKjRnSrpzSYZ/JZnzhUHHbE
         4GDsk68VQXUciO8RJf4orKofY7LyY7MSYN2/Z1AQ7pJBA70XhCo9enyHEM2VaVUNs52C
         w8gqFGHxod6OTOl2bv0zJodkTNzmKD852VMv9WVVY62nwsHpaSJGb8HshVGLbsppaK3V
         H8KJgXipnfufnAQHlNdCSNngrBKG49PZsz/cuZgj/4HYx8OzP7AyojjERUTE3hwuBvHg
         HZ23qT9RVKcsb7ytdsEFppVQG3EisO9M8MuaLVofzTJmheGYdcQPapjUfJvC/GfuMWPs
         BhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8LNLnAgnYP3KUvu0YeGTA7zwlQIPbkF7ilQwonjGAMts3sFCw/7anqTOI72AHzSk43L5sZTeEoZWRwnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXkQ89U7Aa7ll80HyfmZl94Bss2v1PuXibxig56rFl2gUB8uV
	j3XVcXG9ehJzOdIfLiGRulm/ISQL1A3jjMRvsTU15O5Gnecw1NbHrQpskC6qiD4=
X-Gm-Gg: ASbGnctTRBBwUp74Pq/R9WXg1i81zWngjqMU7gw8y4xkn5MC5EdSQEuFvOAoad0hd9z
	uzemx/3LCVpr5QfBHaT/gWG/+csYASv5GflbafLuWbVJJeKBseAwPXu+9UlMjBLHaK3/8Vu/WzB
	rKzv6tUVSgsVBhMYZEkYTaJednU4VR27L4QWFnzqWdix6CSS7M7PzI/vfQZUhDdgUM13OvbOMxL
	d5gLqr+aGS/ic58qSRgCIa2xvbRTKPsR0fhXJe2Zfaxgx4TDGXfhUvDErEK4B4/z1GUqwr4qr/0
	UTo7cn0TdLE2w+ukRFmwimfVt/fWC5MU6KC42w==
X-Google-Smtp-Source: AGHT+IEGZIkGsjS/ODOZpGkDFGZZ9llwwB4c/+lpidwwZqW9qJGdaX/avIm1867Tn1hlaTWUqZfeFA==
X-Received: by 2002:a05:600c:a01:b0:439:8a44:1e65 with SMTP id 5b1f17b1804b1-43ba66e67b6mr114493835e9.7.1741007919063;
        Mon, 03 Mar 2025 05:18:39 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:26 +0100
Subject: [PATCH 01/15] gpio: 74x164: use new line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-1-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mun Yew Tham <mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2379;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=fJTqv/+sZnRFGZ6FlOnt5hhk1BWl5pYK/rnPH5nY6Lg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawpW8tUrAxZZ/uk/w5xMTaLwsBNhfY98oNOV
 E6KDpZn+g2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKQAKCRARpy6gFHHX
 cpXFD/90YRmLFeyVnmIsi24hzo26FQhOWMYIRRDxzqpqNifd2b5mGvcBLkEwjzddss4IcMVw21Q
 gS0MpbNM+Rc/5g0YTAsQj5MKkpA5BSTvWyBUSA1trgrg0jZycAOGWBzRlpTYds/BH8yhCs/0pi6
 jmr90cZ6YXNnwnn6tU8Dmm+VOEDTnJimqBajFU+X9LDauS9ztFrbujTbVnfYMdSVjZHq6ZwLrIi
 qstWSErBzvhIAgAI0C/a2NrE6fh9Cw405kAE1wNI9DZAIo8gsSfP1leoDzVZ7i/LWurlnBRYmq0
 QapIAkzpl/Z1eBJkeS2ZR9OarmJeckFvuZHB96FRxvYG+wCYXxQYz25spUm8V5z4wxtxWKPA+5k
 5eA41bD5JlEtpb6QfTBin5dIlQU27UMrYZcZ7t6iBpE/gJyin7Os6R3fZaiM4qXR3wQ5RGYKJQz
 nGaaq5t6vTwUGDHsrJ4Bo1OQX/HISzfI5SGeaKUXhCfQ+1Geq8bLOD2wTeOt1BKtLvktU6CZh8a
 3V4IUfcddbMtemRGIcxcLM7Miy9cC+Kp/vZi4tWNpI6OwWkVg2C5WlBbKprsR39MQ9JqYdzS7RO
 PS3NYhJUj8YVocKe2vSeRtpW96rU3G1Qru8AXqkzD0URk7Nnbin41UUdW8Y+9ytmXjndYhGT1gh
 JDb3B9tKdW80oag==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-74x164.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 640ac24b72a2..4dd5c2c330bb 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -50,8 +50,8 @@ static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
 	return !!(chip->buffer[bank] & BIT(pin));
 }
 
-static void gen_74x164_set_value(struct gpio_chip *gc,
-		unsigned offset, int val)
+static int gen_74x164_set_value(struct gpio_chip *gc,
+				unsigned int offset, int val)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
 	u8 bank = chip->registers - 1 - offset / 8;
@@ -64,11 +64,11 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
 	else
 		chip->buffer[bank] &= ~BIT(pin);
 
-	__gen_74x164_write_config(chip);
+	return __gen_74x164_write_config(chip);
 }
 
-static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
-				    unsigned long *bits)
+static int gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+				   unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
 	unsigned long offset;
@@ -85,7 +85,7 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 		chip->buffer[bank] &= ~bankmask;
 		chip->buffer[bank] |= bitmask;
 	}
-	__gen_74x164_write_config(chip);
+	return __gen_74x164_write_config(chip);
 }
 
 static int gen_74x164_direction_output(struct gpio_chip *gc,
@@ -141,8 +141,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.label = spi->modalias;
 	chip->gpio_chip.direction_output = gen_74x164_direction_output;
 	chip->gpio_chip.get = gen_74x164_get_value;
-	chip->gpio_chip.set = gen_74x164_set_value;
-	chip->gpio_chip.set_multiple = gen_74x164_set_multiple;
+	chip->gpio_chip.set_rv = gen_74x164_set_value;
+	chip->gpio_chip.set_multiple_rv = gen_74x164_set_multiple;
 	chip->gpio_chip.base = -1;
 	chip->gpio_chip.ngpio = GEN_74X164_NUMBER_GPIOS * chip->registers;
 	chip->gpio_chip.can_sleep = true;

-- 
2.45.2


