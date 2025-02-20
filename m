Return-Path: <linux-kernel+bounces-523375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE8A3D5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE3189F1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE231F869E;
	Thu, 20 Feb 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hJS9EAFo"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4201F584D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045454; cv=none; b=s+vWDaCVbB2wLfaKlVV5wom9FmB9ONWBKuuWyuCDB7H/ur8ItCuDXdEVnkHTwMAnAPcL6csKT7v9wnQFj4ylsD9bfhVxa4aMZ7wIBcD+Dnm0sk1CmFPsscI4CuSDUpWP6Ky6KuzBawnnsIZ/BEI+ZlqtwFCqQyW1HZKpB8tnKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045454; c=relaxed/simple;
	bh=NnBp0w2M0mG/BKyGhs8L3ZC35EcY3EHpBmbW/9My7kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rowSd+/58oCDeM1ofg4Lkk2NWrxIflmkh64WQ+XYWhfpXr/EA7SQNfOt5EMWc+tcNhHxXCWwRYtEZCn/+80t4S1nTxP92tbml3pClhq7km+IvGJR8x/Iun/USZst9tlaASAU+ftEMzdTJF9lBO+Tk6H38wRZpmbR5/zuF8G8qTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hJS9EAFo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2f391864so376825f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045450; x=1740650250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFP3BWLRoarTDuzkFu54gj+7G/B3xWzwQYpBIvwtezE=;
        b=hJS9EAFob9UDnPWThgmkDIfZnqARjfWWBFh94AoyjaLz8gn8JFJRcggneWvvNpn+Vq
         cAhtfGKb+xSdnB2RJDB+Y07es7K7opJZDVmBQyrt1hN9VbZnZFyqd+xGLCRM13+8nHgQ
         MlKId7iSomwPILzJ4L/pJC57j7P6idogtHf20FEbAbSEZ1A/AXs63BCUot3MDitfJP4y
         pAE749gMTvz0yC1hPcQn2Z02Pcp+8reIDAh6Wn8LeFZYEqJDBOMpNZ89+37gAk0Pg06z
         b6RUme4MkN0TREOmGwuTvB4M/0Y1DBRGKNeLEhIMvO3WPi1s92w33hjv41yA5sIIzDpu
         zFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045450; x=1740650250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFP3BWLRoarTDuzkFu54gj+7G/B3xWzwQYpBIvwtezE=;
        b=UwtYmzxbO4O3iAup40baevXyCG30Fm284JdBNmo2wZ9oTG3SHSWjqB9+FYIb+bGqQZ
         Wa2tNgVtjDhCBu7K8senSlAsDS0soSy1NJgBHT5unOoYgweChf/sAbKbQbB/by7vlfXS
         D4FXndrXn6vvmTJ6TGl0PY3iyNF8Lrj3mQsdX9eGB52VZaLyYLhwmEPpajtlj/9NOOUW
         UJScVwuszbDEjsVUKTPidrY6Y0WJ6xFRlQjFxcTXxtdaDgZm7uU1ols15taRmk3wySW8
         +oODr9b9vI5Z4/VKxhXEqaOve1zhqBT7NYlT8dwyMSQ8pjSfBimHrt9ObdIB0XTG1D30
         MbBw==
X-Forwarded-Encrypted: i=1; AJvYcCWUbs5YnVA5rJ25hdKlAYSqJ84iacV4+OciuZmbNlm53dhVSFqWWUXRJikGULWbezfnr2E/m/yMp2WJuss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWECFP0msEBQ4iaBZYxV2wrbds8yuS60STiHwV5hkKcKGKyMM
	+o81YIP3CRp/lfL8DFxmLSLA9rmx1mLf7DOUdxV+0NGXKZ2PMc+xKNt2EYkzv+c=
X-Gm-Gg: ASbGncu8WagAPYvI9l2Bn7zE24v9Y5ieGJvVvUFL0SOoj0BSEluSK+q6ooC2/B13zBI
	A6ndzwAuUA8iBziaFROssiUS77wgdeDB1OUnew7+q/roK/eQehpPp8Mrho3CqqFhohUH4ZgerVf
	wiwoKG11YOZCuyhDNdbo+ApxBF/XMiGkbG/GRvz97ydsgMa5kVpX2JXL51YzKQWftx85OPn6JqO
	pEO3bQLxflcauDdednkTQTgDMzGE7oXYJw2xSWZ/TYVYNJphUwiEh308qNI5SNP30fIUj8QxX8x
	+otH/5U=
X-Google-Smtp-Source: AGHT+IE7LTypG/R5CN/TOyG8sAm7zEA+o+H1HuE4eBAXwnbyVrvVBKMEJ+Ek6z9WOj0N2K/PYrT7oQ==
X-Received: by 2002:a05:6000:1888:b0:38f:2403:8e98 with SMTP id ffacd0b85a97d-38f5878e43amr6319178f8f.20.1740045448193;
        Thu, 20 Feb 2025 01:57:28 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:10 +0100
Subject: [PATCH v2 13/15] gpio: latch: use value returning setters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-13-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ukn05BqACGwwwWlKrdsOqwNXe7CEYNGDC4sytyH/SQg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx5ueiRKxKTIQAcW2Tr6mLrD6qXtYhcR1u5k
 XFRSkPV7HaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eQAKCRARpy6gFHHX
 cpCuEACVbwS5t2klGPSt1+JkfEwzGorD77BmVXhLCWRBp2jHj3eaLTOwFnRFJ+nbhOlo8EMbUF4
 CzMeo8IyJLaRY+286RSh84pQRfc/uHyL5O4Ne7gWw3m0Dl2jz25DHX3N/+ZhUkiBCt5YX6AptY1
 0z22+ObBU2GJ+7Z18U3Sa2oi76gvU6isDvkS2L3NXWEi+iCpMt9a18Geutk9bDLaGQ9q55IRuAN
 590AhgySSkN72x2Iv8+AahcNOy+rgbrdDMAquN/ULZRTe+cquDy3tyvFm9xtUyp3/oMQRB4fMz5
 i0pwWDi++4OhV1wWxisQiHqd6e/vNj4ceCGixC20sR+CbHdiRZckFTVD3dh/ynEO9vRcd/w16za
 SmNdmEgheWuWg2uNaHj/tPnftRGx3oBXAZ7AAxO9GBePUkobbTUuoRoDIxECpLMZW/Irb1eJA14
 FlFe1zkaLtuWMTEzdOlBG+mDC0oSTSFLe+/PhLKhiWyZYEDlbPP2UsosD4MI0ZdfZcdKF4eElQr
 AM+hPmcCMXFCy0R4A+vhGjDQoNnoYhvr6+hCZGQO8TmLFdMinTMiipJh5OHCL88Ei4hewO1RRp9
 QqqY01vdjNpbQHaEoAAoVZ9sjAezt2ktsN09+0jvBiCTxMXZR6LGYA3tM6gOlqei0uhs4sy7Erf
 gGhtXGADDS8VSOg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index f227966c50d5..3d0ff09284fb 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -73,41 +73,46 @@ static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
 	return GPIO_LINE_DIRECTION_OUT;
 }
 
-static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
-				    int (*set)(struct gpio_desc *desc, int value),
-				    unsigned int offset, bool val)
+static int gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
+				   int (*set)(struct gpio_desc *desc, int value),
+				   unsigned int offset, bool val)
 {
-	int latch = offset / priv->n_latched_gpios;
-	int i;
+	int latch = offset / priv->n_latched_gpios, i, ret;
 
 	assign_bit(offset, priv->shadow, val);
 
-	for (i = 0; i < priv->n_latched_gpios; i++)
-		set(priv->latched_gpios->desc[i],
-		    test_bit(latch * priv->n_latched_gpios + i, priv->shadow));
+	for (i = 0; i < priv->n_latched_gpios; i++) {
+		ret = set(priv->latched_gpios->desc[i],
+			  test_bit(latch * priv->n_latched_gpios + i,
+				   priv->shadow));
+		if (ret)
+			return ret;
+	}
 
 	ndelay(priv->setup_duration_ns);
 	set(priv->clk_gpios->desc[latch], 1);
 	ndelay(priv->clock_duration_ns);
 	set(priv->clk_gpios->desc[latch], 0);
+
+	return 0;
 }
 
-static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
+static int gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
 	guard(spinlock_irqsave)(&priv->spinlock);
 
-	gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
+	return gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
 }
 
-static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
+static int gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
 	guard(mutex)(&priv->mutex);
 
-	gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
+	return gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
 }
 
 static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv, unsigned int n_latches)
@@ -161,11 +166,11 @@ static int gpio_latch_probe(struct platform_device *pdev)
 
 	if (gpio_latch_can_sleep(priv, n_latches)) {
 		priv->gc.can_sleep = true;
-		priv->gc.set = gpio_latch_set_can_sleep;
+		priv->gc.set_rv = gpio_latch_set_can_sleep;
 		mutex_init(&priv->mutex);
 	} else {
 		priv->gc.can_sleep = false;
-		priv->gc.set = gpio_latch_set;
+		priv->gc.set_rv = gpio_latch_set;
 		spin_lock_init(&priv->spinlock);
 	}
 

-- 
2.45.2


