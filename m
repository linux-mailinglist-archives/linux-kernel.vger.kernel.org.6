Return-Path: <linux-kernel+bounces-523376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B0DA3D5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B23E174FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993641F8ACA;
	Thu, 20 Feb 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3VjTw9Dj"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176661F7069
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045454; cv=none; b=OEiqC9aYrQ1EMOZlNnYHV6aclCyGKM4LMN8F4j3JoWg8H6Fw8wt1LYiKUYeVlc5Fa4xjrpnRzIRx/p0bPoZc7YBgZ/jsIxoKPMo1Ss/0DTuHZ5x7O01ZegGFIX696TKYxZzXMBcEC0F0SsX5QRcBdLSjSXjF3O6JplpCzNIVvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045454; c=relaxed/simple;
	bh=5q+ozCGvBlVKS0bQz6pJVL03Ts8jJDfVfcDaV/932UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scUaqBPGC78I8SUsaTiW+++CgU/Oiv4rNW+OFHaUeLhbeIEHs+pvWgVxnh4xc5BOdliSE7x0dMrCL0YQPeGPmUlsj47ZH6xpqmDM0Z4hv9bJqxDAcfui5EL3eF+zabrqp/Vxsndm/l3ASvcK5wgW2FBZM2Z1WVDRjgQhaccHpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3VjTw9Dj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so379980f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045451; x=1740650251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lu5UW1vhx5BjNJKHUqstOFRRMZJhr1Zsm1iPcXqqQ0=;
        b=3VjTw9Dj1KCllwIcUdImXroqnN0VmcNiRUcAxwE9UCCfWpuFpvNDMnh4Co46E/kAS/
         wdfljYB5Balf4WfHyWEGIGY40TRr0nrFuvwsWfwzK53MEkaA5lPY3jet/7Du9zA8KnYo
         +Q4/WS3iJ3kQfrqUyNyOEd57VEHcIhM1+kXV1qGe06XlycsJfmYO1Ah6kty2cf3W20EL
         xpRABssOBIjxY/0S7JCXjYZIf5Nm1sKNrh9/qgIYxzLO5xs6vw+3jOVjP8OmLZFzBpj6
         4cjeuG0i9fCm6rbQQiSQISqCbiFBdR1UUb5jJH7qVK4ANrQiy7LmzhoZQqpC2xZBOkYS
         e6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045451; x=1740650251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lu5UW1vhx5BjNJKHUqstOFRRMZJhr1Zsm1iPcXqqQ0=;
        b=LOypQ0jaTKgRiyPGLHLN80brX47EuEPqtldZS3s/5beBRAsSxRdqbj4VxkTbEsJVnC
         Vc9ErV995FbqbVJfg568/OxE0QZJXLAD8FuuyF57dTWYleEFIVEb9vKkw4Ws7uAW8o6O
         wRDRj1c/N+WPVvYJ+DFeGrQAHNhSFj12a4PN213TjaP9me6X2vvguonNqEGVIu8mpK7Y
         yjMWQd3+eGSr1ElXTIeF334cHT3YK3fkaDI3C061lBXXJsh/o7vcE+CJkdhBupO2rAwZ
         Y9mDMZuMJcbJSsrpxME/MR6fraCTUTiCOfIpkx4OBwkNDt9NLjn2qBsTz/Yfa05h7Esl
         utFw==
X-Forwarded-Encrypted: i=1; AJvYcCUPYNZBCiJWbZcXDZBb3+v6sjU/8T4GjV/YdEC5xBy8O43Lz+F1bQCiNFmGlZa2uldr7mHWcb+132zNVAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnBIzAWcTPdok+jEFQpqjb5XsMflM2AyyC9oYNIJPj9XqyoVa
	qQ3DTCuINjVTEibgE2hQtOJx3ngophiwchjmwOxWkyHlE9LBPlNw52arKpTWQd26XBwmtwQtYuy
	4etw=
X-Gm-Gg: ASbGnctvZ30lwF6xCbMsDCh+WcIj0d+BOUSrXuCpdoc0BUCOoq4wK+RTt/EI3VAq0Qu
	5d8T+2VSGjIBah0K15+v3RmlSo4E1SkXvq0BEQOuG1z7SpWaauwFLqVL5gCXJ0Qoc8RnaV+aW22
	p+S9GLsu5RwOnHgokro01i+v9IRHwsfXWmYGBwGvQdDJBNReeKIx+MEy0LVce8SG6Bm2YTbGLvp
	Rq8i/P/i6B9PWOPm6n8LCnoFKnooDh/BAugsS97JDaHootM/oFK6VVyuz9fIwxSE7OyZ3HAjJHr
	qIO6bjQ=
X-Google-Smtp-Source: AGHT+IHb1/ED6JU7/ktNUR0J94Bg2Zy3TWE3fvNC/JsHAq0gU0pnKj87k9wLwuouk1T7gFwq11Eipg==
X-Received: by 2002:a5d:4f0d:0:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38f3417149emr17792955f8f.54.1740045449816;
        Thu, 20 Feb 2025 01:57:29 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:12 +0100
Subject: [PATCH v2 15/15] gpio: mvebu: use value returning setters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-15-bc4cfd38dae3@linaro.org>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
In-Reply-To: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YB2ETZzeSuK+oO9OalIOyMZ8Kn0vhHKwlZK7hmcN1ck=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx50Z/qtp4HVTkNMOwSdS2Uq1in7tcnTkFkZ
 SFXTXNCsOCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eQAKCRARpy6gFHHX
 chpKD/9PfUAL5jRXD8svFFPSWC3ozmUvcSqjB921UX/5orReLzAcrYLgy0gExzwMVJocX42+nxV
 1x2PcEcjWOnT7lOO9qyDHyq62rHVgKcqsbJbDV9AQf6D5G7MsfZGLmMmt4nD99hT0p77+V6Ki1B
 iKkruCcOxQZLKyPUpLNDILH1sKdsDDTvYUDh+11sLyDcrM0xfB3+2OOxbIqNBMijpY/3qdEokX4
 tG6XWTsyzF5H3RCno4GFkBBy/LS9vcx2AFpNo2+uFs8c+Avy6aiu/MSmVf3gyKkZyKwuGVFQl+5
 1drSIMnr3xbuR+JnVZfjvXQySqV8XAJJHB1LjN0hoP5cFO6Xz8unPMR8U/Xi/xIEcKuPLD2eGYg
 H3OMzO+6ik5Ze049zDV+728tT6AV7o8khI+Lxhk9ITtDIzoFf8mFVCaEimdUxVx4dLlI3YIXVBo
 PXyh3/+npyr3+FS4FLFGODM9xfvUmTxWXRyvMvmX7i4H08tVB3oLYJmXD7GCfYs2fpQy64USE8/
 h/wVyQZ5gypJI0AdkBMA29Od7rU/XAis5kuJIHmz61c+OtlM64kJA58MwHJFHdwci7+7jBX90FR
 gGhWMq4eFgYZFCoDYV1uteqpLBQEHtRgb/h6E2NARirlPF9RkNlaKP+43kIC4LopEXdOn+HVG/R
 larCpF3f0JX8QKg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 363bad286c32..3604abcb6fec 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -298,12 +298,12 @@ static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
 /*
  * Functions implementing the gpio_chip methods
  */
-static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
+static int mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
 
-	regmap_update_bits(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
-			   BIT(pin), value ? BIT(pin) : 0);
+	return regmap_update_bits(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
+				  BIT(pin), value ? BIT(pin) : 0);
 }
 
 static int mvebu_gpio_get(struct gpio_chip *chip, unsigned int pin)
@@ -1173,7 +1173,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.direction_input = mvebu_gpio_direction_input;
 	mvchip->chip.get = mvebu_gpio_get;
 	mvchip->chip.direction_output = mvebu_gpio_direction_output;
-	mvchip->chip.set = mvebu_gpio_set;
+	mvchip->chip.set_rv = mvebu_gpio_set;
 	if (have_irqs)
 		mvchip->chip.to_irq = mvebu_gpio_to_irq;
 	mvchip->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;

-- 
2.45.2


