Return-Path: <linux-kernel+bounces-541785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A673A4C19D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DE716E14D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50021325D;
	Mon,  3 Mar 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="j8KUUEra"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036521018F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007924; cv=none; b=Mf7kKOjy+gnrZkZceKEBermoil39aBBxWetJiGQjrW5SmW8Hwl893ieu5RsVxeUbl7tFsMETtMs+NUOj4ipUOTu6gW5qrDgYtrA5yNmVdRJEfoz2BeDUM3xl4o8xm0aIbGFNG52vQs0LIWbHRNnmzbzLL9VKTkLw3Qnaz4a7iKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007924; c=relaxed/simple;
	bh=anSaUmMeHudTcMnfZKAkZFKa1ZvxOcZSds714KGyGrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSijoc26b/Ba3tWdd3rRTN+Ob4Jt5sVLH/wYJcZyItAfFbKgJoY5CpRFYTx+/YCmGdc1oIlKULuIzsdh83O4jhHxUt62bRacuSq8PVkJcxxGgmlCXxt7jY491Irs/mgwdnnuQYuwF2ALXI9F8jVOSsTioA+9SMKLFuyfUC7AMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=j8KUUEra; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so11520115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007920; x=1741612720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ5oJp3c5WFM4WouXer3X9uqb/QndY0s4T1ZVpIJ/XI=;
        b=j8KUUErar2T7AjTHAujEJu9Uk/FAb0hKMWIWoz/s0pd9MlzYzAWH4ScoJbnNjPICy0
         OInWP6oLG2kFVmZ8GRA3qHWNQHNzHDNq7NXawrN9ZPtW8G6V57GzLOdBsuxoq6zPFN/q
         fgAUnjJygH5vX7mksebGT8zJF5zhzbLBAshpSXPuR8qnD11Dd07TM1OGSthb9pEFA8Q5
         otBmsEmIMMZnjJOPr4Z2rkA5KXwbAzxj2h8GQRMYwHuaWhskLQCMryQMKsODaQrohvpj
         M061SwGPcAh9jPaJA9XdgzNCWxVOW6fUilXL9qCipXeZgxR7UxFizAPfvrngW2i+/odU
         WxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007920; x=1741612720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ5oJp3c5WFM4WouXer3X9uqb/QndY0s4T1ZVpIJ/XI=;
        b=rRWTrLvXUP5dqA4ePavJmLTVkY3VM/7A1YHrr3Yugplt8UDKL31BU8IZGRxVxg/ZMa
         ie7hNSNQb6lM+GpmzgMiDrhjIUnpSr0hyMj02ne/yy+ZZnDpP6pnYsuut7DPVowPUtAK
         KBF2eB+UOPOLTzq9qJAMM+hHeDJqWWdW2K0i75KQ647jwsnq6fezCXbWI+5eaJUfuPCy
         HnObn44chNMSpBPUGSL+q0I8Hs1ziSvWi5JpWq/xkjUNiaFAQSzhmrbwsba2FPxzakO3
         WA/58mk0+4DIK4fyg+IBqCHdWK0M4i4cY1/VqoZkm09nUSeNc3ufvo/g3476KWnsZnjv
         Nc6A==
X-Forwarded-Encrypted: i=1; AJvYcCVKOEOaG0AHG1Uf93t9BXicCkp4qmEgzPK9J3bK0wbHApr1XG27EuqAOb92MovgINnOf+dYclQz5QyUCLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xlkLdJVZq3oJOGPCx2nklFR2we6H/0PY+YI7uSIxgeFH0zD1
	IFFMuwni1ioMSOFU13Kr10so0lreGUzbfJVYMYo3CeTrvRshsvu7PPsgs9UGvB8=
X-Gm-Gg: ASbGncvjt8mxgBhu4zw0gEAfCb4qVyV31nNsy3lMixP3nc9TZea53ieME2ayHz+Y5ZQ
	0A8cJqFfregvYXUOmtQbLgT2hAp++z39Gw4mZ0Nij8avHydhN7FOzm5XJ0Uq/VkS0d3ai8pbG6l
	lJs2ylG2niuxrCDsdSp0tHW+F7O5GP8LmDqg8KTUpZyayA45mpX9V7JaKAHn/6VMSsONBkmFDnd
	DZygzat23Ib7HVBFEua8m7rV8buDzTuopGPwdE63Myb8fW0/OmC2Kh1YXk+VVn2mqgP2FF+hfYC
	K+pH0gClqgxoDtO61EmkNCaJYLXCvzLGtNeeEg==
X-Google-Smtp-Source: AGHT+IG5s1ruT1nmumvD1vz4k/PQPFk73wz70YSES2dlvEwqzkFmq0l7g9gUOgUlEDWIW1/6NKwMVQ==
X-Received: by 2002:a05:600c:1990:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-43bad205987mr116763645e9.5.1741007920075;
        Mon, 03 Mar 2025 05:18:40 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:27 +0100
Subject: [PATCH 02/15] gpio: adnp: use lock guards for the I2C lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5610;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=7cE7tXYd+kBXXnaURava5I+mvo86dKpC24i0n29V+bg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawpxuJoIV5NMGocJt+m6HFa4mYBXmmZlg4hw
 8wwnHfFcfGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKQAKCRARpy6gFHHX
 cvjzEADPodYCLVwjeMTiGTqPipprljvQCB/GL3xqqTvapt8laajCeEP13MAl+wEQgOI0PZjtgmX
 IfA0F82Ky3uW/F57NzwGDDUbhJo1kkawv/eZOqQ+iySkYpAjFaF1eV+oboYthMguItGFy3KWAQ5
 JqKgAdn7TqGMrZWB4xBd2Nfu71VA+FhqgEXam6X9yeI0uNeMN0yeLZsyxvTZq66ZVrt0yop3Pg5
 kp6deFDMu8Jn1//eSLL+8uVpdoKB+Cj7AT/AUl6/5x69brbHiORb03ioq1Nv4XPE2Bva+/oCBw/
 aCFfEOyJrsROsvx1dYpcXMWytgBgxj6wM3OhAa4dXuPWGxKFq3inPX7XxK2YoKp/HlfRCs3Bv0Y
 MPsQNxupceBB6eNWtP3bk0r92+8D0i5+m3NMGz2zq83unvXskmb8q+LiwAQ79DL72CednxwdxTu
 Bj6tysTCulxtGU5NqYQDAgmXUbdvRiqUrSAmCUQAvmQ2b5Gf+VaMZIj/V+Z7gfj5/emjbGC9rem
 R+EAqun19YF+NX/B2DOft33MLhn9mZThlbEy6JE1cTaXqDp/Tq2AArFUUx/C0JDRf+HzB+Mx3q5
 dNl7v/Pp8yfkP/IZCSnqtnNj1sUXTVN69sTh4L4X2UV96caMerMTa59SIBSU4eZPg8a9MdsOwj/
 UB9QF8bbNI/2ffQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reduce the code complexity by using automatic lock guards with the I2C
mutex.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 118 +++++++++++++++++++----------------------------
 1 file changed, 47 insertions(+), 71 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 6dafab0cf964..dc87768276ec 100644
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
@@ -189,25 +179,24 @@ static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for (i = 0; i < num_regs; i++) {
 		u8 ddr, plr, ier, isr;
 
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
@@ -252,28 +236,20 @@ static irqreturn_t adnp_irq(int irq, void *data)
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


