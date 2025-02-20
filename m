Return-Path: <linux-kernel+bounces-523373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75442A3D5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4949416DC56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A21F5616;
	Thu, 20 Feb 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HMbU8BGC"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BDE1F460E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045451; cv=none; b=G0z39P3ZZ3/JeIW4+2yiG/wC5MEcBBAIpg8Nwc7Q3qgk2TvZy4kWUmp3sMZ8QNnFSrMGOgGytGj9R09ft1gWHD/l8lTR/4IJbqt4rcZLqoL+KwNoyFyBi3VjeQ4ro/4+mY7Yx+eGMUbEYMNMidTb4pFUTgBhXC759J+OGdi9+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045451; c=relaxed/simple;
	bh=oNMBdRZqUQCqeYdhk0xPtgNTqSfkbaSpML+Q07cXQ+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVHyrCJcD9Xn8D96xEesQEezPtpdb+EjWqDyqrvdGn43HodwKkfVHSY9x2rwgpsyFD4O15ggGgK+a1NBpS/bbJBwTRMB9PxExDIUiuy8svw3JadDMysaC9IJsFd7IfeDqucZuV4ZWXNLLi13UH3XIixSbBWsFCNpHXntDXnKN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HMbU8BGC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f286b5281so354790f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045447; x=1740650247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfqQhzIbPAlLlEplcRJK9DNV0YYD2STndi/P+xKMNHo=;
        b=HMbU8BGChMxsHNWcb6TRKA9VYOrIbgG8+3iOQ2mIL0UXswWshpJMpyNPbykVDQubEJ
         /sZkIUV41pd5vsC6WTkBViYc9ozXm6mT+RJMFSIgK39XMc2asyA0Uk2XZsWt1dDHEQdE
         EvRmk/x/jtaFGSH1NFQoiK/ZHezwVhIwWAFYPokKqLpIjw5CqPXUxQlXmNpmq1XmxtEI
         v9S2DKINCSwVKr0vcqKWvSlPnUY/hiKyU8PDp5K2HICiUes+KLOLYHIXjIMgrtQZLnY2
         cD4IsKiyt+cVTI5Z0a5VQlNyp2LY/443zcGZqgF6LDt7i1ZgTcBcIM3R25R6dJL1G+EM
         fkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045447; x=1740650247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfqQhzIbPAlLlEplcRJK9DNV0YYD2STndi/P+xKMNHo=;
        b=FfvddZLRfcHQJdS9DoTXSpSs694twaa8/BU/M6tP+m/67eQ7QW8nkqGNxN6HEIdu42
         AExGtz52mg2ZuYfuVkFP93xoY/LW9CO8M2mw3a+nPiYhzd7SX5EhalNTp+w+Xa/LFOMt
         gIVNVFdNJ6jMoHci9TD3qMP9mhsBoTMf+kjiLpeQQ/btLOJLKLE83ct28XzK/IfpgxND
         MxIN9tp45STBxebyLes6GteY+SU+PI9pYf2CAhc/EwXGulUs+9HdpoYKx+89ySE/cdom
         HlhzV1BQ8XuYQFAVlXsfF8gA1DJwCXqCx/SYelHmrI4W/JpnJHmrCimu+1H1nXe7YLu/
         lzTg==
X-Forwarded-Encrypted: i=1; AJvYcCUbTWQSmeSivq5dNkrtnPX4PMNa7CMs9hYvJO+WfQ5nIbpuQQ7ePbNl32Ndx6En7dFDum5/KFx+bl1+0gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0r0F4mEcOykmx868bBSYexGMf8s0foL82oBFk6DbUswqFTT17
	VV99y12igSxvYhGqAMxwpj4Ji7sF7yekDurDl/51pTnFxqpNiIQafdpSkmGy8Gg=
X-Gm-Gg: ASbGncvm4MyWjqm8cH7un7bBdrks05AsJrsiViodRgmRjnoMSTM9XF/c9qyzt7nekod
	sV9c64JUjCltOjDfKnn8pYhsaGYbmPndMQSRyqQv0SEouK6+SbTMQTwOsa4atMp3pJgwIDn8N3i
	IQeCKdM+h7YNj+jdW+v/ianOxAxsvoT+v9S3UHZOeJgBT8yv22MjKsO4RH7Yj7eJ54iGx2wNxJT
	jS0VmpfnBhGTwiTwxhq5HgRg/QhGD7RjhXM1iW0UeM/MM9dhWIq5+UwPC2ECso1ryFzpXExHBmL
	AJ8pVJc=
X-Google-Smtp-Source: AGHT+IEesjZmZYobgjhT/KsvHGhJ4/uJ96MmYOnkUp8TEDV29vEvKyBue0fV4qqalBxAWQRNOOTd1Q==
X-Received: by 2002:a05:6000:1cf:b0:38d:e6f4:5a88 with SMTP id ffacd0b85a97d-38f33f1b5bemr12896873f8f.12.1740045447286;
        Thu, 20 Feb 2025 01:57:27 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:09 +0100
Subject: [PATCH v2 12/15] gpio: latch: use lock guards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-12-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GmNqVVnBfzS1ierDztOpK5GOdKITHuunFEXdWyqcpSA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx4XkZq/c6JUz5aMuMrXDx9YfeWhQw7bw089
 7pXZO8o7LKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eAAKCRARpy6gFHHX
 cuYnD/kBzNfzsHamKa/Gd1E9IV807ikL7snAjFvcGlR5Fpu6zV4Z/tVOtkCEkLy9BQGuLOKfr45
 r8GzkZxvFSKPn47eDyxDaO6lVGhKsfeD+O+wTpnaevueqRyPcFlkp2mDoTjKfpq5bFc7W0lxhr3
 Fzp6dr9ktW2FtwTwfwE9A/DyrDQT7Wiw75gapDVOiGlFad7x8pohK07RCsjWtPbqAsfMC2K4m7W
 Hl26bwR/JQkixA14VLJzr1l2udnwmRiILOn1K6CNRntIx3nO95r1hR5sygIt+c2/Z7PYlL5zTZ2
 /sT6bVf11YoyJ9S7dx+bXeZPNUys37FoEq8YvQ7ytv5K/EzDSCcUxSPqFEDMKucsUL/Weq7Zgxv
 BJVCJDJTNlTPgymJNlh+wUDe6r4RA3h0lDANZEAt9Y2rUbR/rk0V7+2wdhMxP09TeeW3zhsDswd
 851NTRV/XUSf8O6TaOlQXzLpm6/OqPLs3+k103mBZUrwj6yjmUSiVbOCLZJsu3dXrVzFc0qi++n
 EzkyVwBTMyPO/5f9hxkimzhZXKLGvctXrnhDpjH5Hp7EYOUN9i0gOtUGA5cqOf14kVjTTkIMpoF
 Oq2Ywv21u8ELAXkkyMYLAZ/d0/TPEwNFwnMBEUPIK4OQzrKQ25QU89ub6S1Ok8JN0mBuVCHJgYh
 O+Z8hE7aBdYSXEg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use lock guards from linux/cleanup.h. This will make the subsequent
commit that switches to using value returning GPIO line setters much
simpler as we'll be able to return values without caring about releasing
the locks.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index 64174ea7d008..f227966c50d5 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -38,6 +38,7 @@
  * in the corresponding device tree properties.
  */
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
@@ -94,24 +95,19 @@ static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
 static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->spinlock, flags);
+	guard(spinlock_irqsave)(&priv->spinlock);
 
 	gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
-
-	spin_unlock_irqrestore(&priv->spinlock, flags);
 }
 
 static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
-	mutex_lock(&priv->mutex);
+	guard(mutex)(&priv->mutex);
 
 	gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
-
-	mutex_unlock(&priv->mutex);
 }
 
 static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv, unsigned int n_latches)

-- 
2.45.2


