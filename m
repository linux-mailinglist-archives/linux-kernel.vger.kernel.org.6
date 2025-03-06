Return-Path: <linux-kernel+bounces-549451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107ADA552C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123C03A8E24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFCB25CC68;
	Thu,  6 Mar 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZZjchcRr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72D214805
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281577; cv=none; b=mgxURetFct4ILnkDTg2DocDnP22mkkEsMaHxm1Ty7hex1HdW4n6hH2van+lUirsWMVJ/XL16FB9ff231IBB7DiJU354X+BTJBUBgi/PMj94MYYkPnVAGI18PF/FHX5d5PK5EK6zhoqU+o5HZGSjTUugZMdccVehc8DTp95sCLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281577; c=relaxed/simple;
	bh=n0O0Tj/cxjFkRs9/6vOfTa7XNH3IBMWM07hdD+wUTHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgpSoJ860WbJWtS1scEM6y7PQhyrm01MsTWi7cRZIC6vSPmbOPR2XLlkKGa0oiifySQMmWHw4l5NVkduq5xVGBc6W1Xf3kbmRN98AsSOwttGc7tmCI6vtzpxOkcaKLK3Q1RUX7CsakUBWhssX8o/T1Oj0gDNy0dk/Z+cJcDm/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZZjchcRr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so6016225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741281573; x=1741886373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kyHgVZhc600PXZ8OEx3rlFbLkHugaQwdjxo+/xhLGo=;
        b=ZZjchcRrCwcREhf26UjAJQjaISQxKs1l06uww0ISIlrMnUoh3enZHu7jibPVj/urSD
         a2+SebBybGzLORs2+Wky1f2PnXmpkNS3u0RyLnYWjGscUPwdn1B/hu+hZvuNeVVHcq9t
         d6B7lrznJ+CtfgEtmCB7sjryPvvZ+RGII+fJznzq6FGYevy2LcLgHKTIu3ZBSxe7SMJz
         cX3cnrsqQTuLDi6ICGjcLZRqkdFaVBE+EtYMuqeCwKIwfB14CsX9ygqukcuNOE5ZNVUM
         eJ40b0k14I26Lrg071qR1UnGv1hoWww+jYiNdACw9hJK/mY5Kn3g7Gf42IWvcTBX5weC
         dI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281573; x=1741886373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kyHgVZhc600PXZ8OEx3rlFbLkHugaQwdjxo+/xhLGo=;
        b=VFtFfxE4RcVtrQYV9/KyYQlPjcaKw7dqjGEGQrjUkIvBMkOs9IfaVq5AcJyRdDnP4p
         5sd3wCgPEIIYxZ/kiQDNrSUQlcrbQPenj1vTv1uau7lAm3fkYeXbdnqQsNJ32PSsZs1q
         sX2qgBMCJ9DgOkbHPSAT9RDp7HYNQpQhv0rukkCZqR12ka9eOL27KptMq0Itp46EHPDQ
         +PU4TFPAQqjdGWCOMBSeqTUktra32UoXFD+Q5G8gSxIjWSHkYk5qulaRcWrHu7RXmn0M
         0OUgfvt7e2fwMi5bLZJMQ3QukCAB1H6Yz2elky1YhFS1xFhCduSv7ji7WI8EytnSZoqn
         NYeA==
X-Forwarded-Encrypted: i=1; AJvYcCX3NnkSDeKG4NUxncRead0Jo5YMWwdSLOa8SkQ4sxLgvrYrXIUVRbDS5Cmxya6aQM8+IzsJ5MCXwcuYZrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnA3Bt4N4dh492d19XXJLB10/DkrWG6vh+ijn+FlXE3D0uCbM/
	nQE6cTDBWVdlYWcJMNGB4AUxq/Zsp01OSlNBIKU2uW325xyocm14PWKY8NGACWO/pwV+4E7MIIy
	S
X-Gm-Gg: ASbGncuvMr5TOZgReOOi5mO7Y550g9WrhBh43xOfgU1/XO0ufOfTw26EYcvsm6dWxO/
	SXkDT0aAKoK04NbybUZ6IM5UdVgmR6oBKxS6PrMsCIDIxB1MyemRj8S9TaKuNzw6Wz51gJ/d+9S
	E22eEDOTHsUUKwQwYSsiaJjVwj+vhDgE8TOz0r1+5jBoAoziKW+C61zVaJvtRs7krn8BulAm5Aa
	F2bFPEnn5cMQFkX2yTUPLRvuePeNWCxuQBKOEJ26X1aw3iAaxhSzY2RX7LHyjGnsA1ZkAbxQRYC
	FiQr47zDMW3zXtTvl/G+WMk3Qy9PVQ41Ho4J
X-Google-Smtp-Source: AGHT+IFx64qNX8KOE0m+03lf77OqC2vUhSphiuS13cJJQb1D+TEOQwbLCi2vw2cl9KR30DrjKU0vhw==
X-Received: by 2002:a05:600c:4ece:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43c601cdc0emr2490865e9.3.1741281573439;
        Thu, 06 Mar 2025 09:19:33 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ce13:b3e4:d0d:c6a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c33asm57673915e9.3.2025.03.06.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:19:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Mar 2025 18:19:26 +0100
Subject: [PATCH v2 1/2] gpio: adnp: use lock guards for the I2C lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-gpiochip-set-conversion-v2-1-a76e72e21425@linaro.org>
References: <20250306-gpiochip-set-conversion-v2-0-a76e72e21425@linaro.org>
In-Reply-To: <20250306-gpiochip-set-conversion-v2-0-a76e72e21425@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5836;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5uY7osM07/+oU72WUoWAWrPIBRSKfXw4Ey7fR/6GiBk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnydkj0xt4ax8CVco0/qLq5ODStvdLa26DV3+Ek
 JWO2+RzO/iJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8nZIwAKCRARpy6gFHHX
 crB5EACfqVtvGK0iiZZEbWdbMMVlwpR76SgbdqvhbmJCBWTCsF32NTetkOk9X8gULH6P/7R8gvr
 E84GPeP2CziFcjg8e7r3d/juW89JuTNfMaBD+tWcAdN5H+2b3Cfva3uCnUlM0VUH+U3h+FU782o
 JsEL8Sw0NsgHsoEjFS4V/aehGybtPrkktC8AVhLmSlQsyYqemJ/QkhdQaljVhPKHLVZgUNpgZFT
 tzFIPcVIsXfwLWwvDxEOOwxrfgIX014/rU+QYB9iyvORoWno4Nr/R1277KE3LDod+7JrMr0T6RF
 rJHzB0bKRK9VoPwiKQtTXWNQjTKv7gQpNCacFIrIZo55goBheDhY4W8zMOKNLBbw+3GAqCDGF+l
 e1HTnpm14rn/NpJ6ZR8PyesL4wZ+sdNqzldXUchvuShfQ+6ryoa18bg2beQ2QixOlx3t8wspPOg
 H6B2iTvZ/7oZn+G70v8Dpa3yKnJZZy2kRp44T1QiH8FtBNrAZkZmdz+xqcXSskF5ZKgP09eccP3
 Tc4pup+5PDlz42kififykByCN/8Plz00eVd6U1VtBLDeTPxcM9FOAd87NKFwmT4STHgjznUxxe6
 RT0t0nl+tHDUI8ijkWdOgGUwllh3ZlOdPzXcmnomOwPMa8avNxLqpX5/aG78hlzWychQL7NyogJ
 ib/bqjO6uNooIkw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reduce the code complexity by using automatic lock guards with the I2C
mutex.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 122 +++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 73 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 6dafab0cf964..1a282cba8489 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2011-2012 Avionic Design GmbH
  */
 
+#include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -101,9 +102,9 @@ static void adnp_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct adnp *adnp = gpiochip_get_data(chip);
 
-	mutex_lock(&adnp->i2c_lock);
+	guard(mutex)(&adnp->i2c_lock);
+
 	__adnp_gpio_set(adnp, offset, value);
-	mutex_unlock(&adnp->i2c_lock);
 }
 
 static int adnp_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -114,32 +115,26 @@ static int adnp_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	u8 value;
 	int err;
 
-	mutex_lock(&adnp->i2c_lock);
+	guard(mutex)(&adnp->i2c_lock);
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &value);
 	if (err < 0)
-		goto out;
+		return err;
 
 	value &= ~BIT(pos);
 
 	err = adnp_write(adnp, GPIO_DDR(adnp) + reg, value);
 	if (err < 0)
-		goto out;
+		return err;
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &value);
 	if (err < 0)
-		goto out;
+		return err;
 
-	if (value & BIT(pos)) {
-		err = -EPERM;
-		goto out;
-	}
+	if (value & BIT(pos))
+		return -EPERM;
 
-	err = 0;
-
-out:
-	mutex_unlock(&adnp->i2c_lock);
-	return err;
+	return 0;
 }
 
 static int adnp_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -151,33 +146,28 @@ static int adnp_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 	int err;
 	u8 val;
 
-	mutex_lock(&adnp->i2c_lock);
+	guard(mutex)(&adnp->i2c_lock);
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &val);
 	if (err < 0)
-		goto out;
+		return err;
 
 	val |= BIT(pos);
 
 	err = adnp_write(adnp, GPIO_DDR(adnp) + reg, val);
 	if (err < 0)
-		goto out;
+		return err;
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &val);
 	if (err < 0)
-		goto out;
+		return err;
 
-	if (!(val & BIT(pos))) {
-		err = -EPERM;
-		goto out;
-	}
+	if (!(val & BIT(pos)))
+		return -EPERM;
 
 	__adnp_gpio_set(adnp, offset, value);
-	err = 0;
 
-out:
-	mutex_unlock(&adnp->i2c_lock);
-	return err;
+	return 0;
 }
 
 static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -187,27 +177,26 @@ static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int err;
 
 	for (i = 0; i < num_regs; i++) {
-		u8 ddr, plr, ier, isr;
+		u8 ddr = 0, plr = 0, ier = 0, isr = 0;
 
-		mutex_lock(&adnp->i2c_lock);
+		scoped_guard(mutex, &adnp->i2c_lock) {
+			err = adnp_read(adnp, GPIO_DDR(adnp) + i, &ddr);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_DDR(adnp) + i, &ddr);
-		if (err < 0)
-			goto unlock;
+			err = adnp_read(adnp, GPIO_PLR(adnp) + i, &plr);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_PLR(adnp) + i, &plr);
-		if (err < 0)
-			goto unlock;
+			err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
-		if (err < 0)
-			goto unlock;
+			err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
-		if (err < 0)
-			goto unlock;
-
-		mutex_unlock(&adnp->i2c_lock);
+		}
 
 		for (j = 0; j < 8; j++) {
 			unsigned int bit = (i << adnp->reg_shift) + j;
@@ -232,11 +221,6 @@ static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 				   direction, level, interrupt, pending);
 		}
 	}
-
-	return;
-
-unlock:
-	mutex_unlock(&adnp->i2c_lock);
 }
 
 static irqreturn_t adnp_irq(int irq, void *data)
@@ -248,32 +232,24 @@ static irqreturn_t adnp_irq(int irq, void *data)
 
 	for (i = 0; i < num_regs; i++) {
 		unsigned int base = i << adnp->reg_shift, bit;
-		u8 changed, level, isr, ier;
+		u8 changed, level = 0, isr = 0, ier = 0;
 		unsigned long pending;
 		int err;
 
-		mutex_lock(&adnp->i2c_lock);
+		scoped_guard(mutex, &adnp->i2c_lock) {
+			err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
+			if (err < 0)
+				continue;
 
-		err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
-		if (err < 0) {
-			mutex_unlock(&adnp->i2c_lock);
-			continue;
+			err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
+			if (err < 0)
+				continue;
+
+			err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
+			if (err < 0)
+				continue;
 		}
 
-		err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
-		if (err < 0) {
-			mutex_unlock(&adnp->i2c_lock);
-			continue;
-		}
-
-		err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
-		if (err < 0) {
-			mutex_unlock(&adnp->i2c_lock);
-			continue;
-		}
-
-		mutex_unlock(&adnp->i2c_lock);
-
 		/* determine pins that changed levels */
 		changed = level ^ adnp->irq_level[i];
 
@@ -365,12 +341,12 @@ static void adnp_irq_bus_unlock(struct irq_data *d)
 	struct adnp *adnp = gpiochip_get_data(gc);
 	unsigned int num_regs = 1 << adnp->reg_shift, i;
 
-	mutex_lock(&adnp->i2c_lock);
+	scoped_guard(mutex, &adnp->i2c_lock) {
+		for (i = 0; i < num_regs; i++)
+			adnp_write(adnp, GPIO_IER(adnp) + i,
+				   adnp->irq_enable[i]);
+	}
 
-	for (i = 0; i < num_regs; i++)
-		adnp_write(adnp, GPIO_IER(adnp) + i, adnp->irq_enable[i]);
-
-	mutex_unlock(&adnp->i2c_lock);
 	mutex_unlock(&adnp->irq_lock);
 }
 

-- 
2.45.2


