Return-Path: <linux-kernel+bounces-554223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA83A594E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84F816BE0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212022D7AF;
	Mon, 10 Mar 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Nic+D6DQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85522D4DB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610446; cv=none; b=eR9tSDDG+8v0iSi6/UgV89ixOSxn9iXi11xrkqiEY/rezl8QSJ0DdMeZQ1fS2qfTquBy0QPnW3LW93HnytF4Qi2nsXMS/UVjonU2S5Q0WAhCBshqmglUz4kMuM4rJKeFyi5vba2Om4iXK73DvgU4Mi067obXrLNNG0bAzVXohds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610446; c=relaxed/simple;
	bh=JCZwjmhHkI7UGuyylm3hmg1ybe6vyUyFrcZEROggpDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=depaXuslziEfl0evFSzMaVUCY4kqdn71tyFWxWLnxXuGwVkJcYZrJHu1k7Pob/96d8d9u42L8bfhhVQGMdRomHHCBLTjKAhFVt4wlGMS4mrhxdACPYa1fIqrnBdsveEaRUKcHlnQMcxx85yCHF3xwWIPc0LW0a1ZouBpUEu9Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Nic+D6DQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso7445445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741610442; x=1742215242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNtczHCYOvGzkg4rCw2cTpCLRIRLWrJdIViZwBgDUNE=;
        b=Nic+D6DQQagsZe1PK2xtlYSRwDO+piDdGyt/HwRI5KcP9Vw7y5V0G7m7zZ/QANbYcG
         Vc29uqqLfzKDCLJXoo9ObQsOKeZ/XtiW92ePG33T7M4ON/9p8SN+7XIcCD/sd39+0kZU
         FhTzLqiRJQQuraE/wsI6SerVD5m8vEOTNdeHXfx/rnAqqqLsGoMAMKwp6hCa67r4xge6
         EKZapVNjUWPaMtf4xeGzXf4hWfFDwfF1iIy0zeZHrNxoD6FqzJ3NmIoZ4sJSYkh/9OoQ
         d7OQXsalVJgy1gRIWOj+bE8tDnqUrP2e0BHj60n4HEuuXXI7MnoKLqAn99bB0vzPaUx4
         qEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610442; x=1742215242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNtczHCYOvGzkg4rCw2cTpCLRIRLWrJdIViZwBgDUNE=;
        b=fczA5d24fP+rvJW92xS7QHOrI2Iy6dFP620LKyZDIDmu/vbzYW0yG3wOAEOWsE8M0O
         0n3TkEwCrfc7bylbKBput6qKpTDx3uUoXpEN/bUjOMtYGLcF/3VZ+ZXxZbWpG4GW3BFl
         9fUtJ6HdQLvsKogWwome5dqQLQyvq6hOKC1RIjomprc7E6+hxkN5pAPTNW0AFmc6HuIG
         7ixn6RGvWwYcaIvitWTrz+RWZ8gfixxht2RcGcfi0lnFRuQbZLRwkHhn+s6ULa3Q/wIT
         e/vPI64MF809dAvesRyRezIhRn/qaqOz2e1I7wp/F4wErfCkP2UTZu0LiURTmc16KYQ7
         0jpg==
X-Forwarded-Encrypted: i=1; AJvYcCVcyWgLAI307HV+vEhvXVyEcMSPobINt8Rm+n4iDOalGTAG+9NVJq7VRMfltXOVX4VEHaD4YAghKX8n3Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJIUp0hjJq7oWIoFM1o1slvalibFxJj6L/0UMjLJo3o6lujhV
	k2ZhwC5/PmTr8ZyjNbxV+hh4crOyXppwnldApXBgEW2yybhWjCpje3Zy6scJInQ=
X-Gm-Gg: ASbGncusegaHCtQMb8dSo3gGeExGQRxHHJkyMFkb36ewqdJmIK0JfqVW6yZWD/FAyvc
	7hmqoZwbTn35XMKBnnq7DPqOUBhB3n+o5I/utDv9tv7nZgBPaB+1vtdtmDIybY2QFQthSG196eR
	OwqswsMNJ3X/Hq4tD4Ft4kB/bjbeKR38DI+z+1fWcCq+JELOzzo32jPcPKNMGR1IJN/b4m4n2EE
	Vln0muCcHWNLnkYvB7quTWXSJn9R3Ev9hevODir0BrbXj0I6MvMgnoMVC+5z7YYjQR1ZIMzgjN6
	bcwyJvyMBjm6GUOi32yetGIOeGQfgp39Z0wI/w==
X-Google-Smtp-Source: AGHT+IFVuyRiKFOOAXDZU5l6h/TGQ2xggZC6+4dIULrDNG5L2YF0yi09dTRtPuRjwegzC6F/xDPbXg==
X-Received: by 2002:a5d:648f:0:b0:391:3150:96ff with SMTP id ffacd0b85a97d-39132d57d7emr8406280f8f.32.1741610442247;
        Mon, 10 Mar 2025 05:40:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2711:39c0:fb51:b639])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdc5sm14535865f8f.25.2025.03.10.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:40:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Mar 2025 13:40:29 +0100
Subject: [PATCH 15/15] gpio: da9055: use new line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-gpiochip-set-conversion-v1-15-03798bb833eb@linaro.org>
References: <20250310-gpiochip-set-conversion-v1-0-03798bb833eb@linaro.org>
In-Reply-To: <20250310-gpiochip-set-conversion-v1-0-03798bb833eb@linaro.org>
To: Ray Jui <rjui@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, Michael Buesch <m@bues.ch>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=aX+Sc7fT/BffIdWWzJi16XZBvVpXWWKC15xKXdoh/ts=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnzt24DB5SoA3hXBMRBC6RePpPoJYAb2N8IdI5i
 pcr3SXpATaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ87duAAKCRARpy6gFHHX
 cimWD/98dfw0xWyjhT1TCRNPGdqbkj2nQnmfYJC8g42IGydzwqwzSN7m6xgIlZL5yQJ74CjTNIq
 9zx2WmSkS9S7588Gi0ihnRPW/sA04phIaDLWiLDK2YpSI21KDCGEsVOa1Sua7LP+ocVdXL0y5Dl
 fojCC2iWXNQEaHr/gWiPoktUcwODCRnKzP4Hkaj3fZ5yAleEYanJve+yvCEXSDQfjyetqR5Dj8j
 NUgBSu0fUzZqtcezJoxnsV1hUfXGLeE3nCABFzZEOjAHvYCQTXUugJ0NpRrzO5omloRmYltItnw
 mL6cpyrRR0CCohWjQwbvTFtMVbB06mzFVZO/2/XK4+0/4rQN9uDRJVnme3b+qulhOSopMdKpybk
 n6hGsKM/zWn0vDAaM22cVeBrBsWJBOPrpe1mbUAQxfM+3ZlT/Qvet2Oi/diAKsqASoXEumH374N
 tOQioORX2FMyUTAJ2hSLK60xJHWRcGunqLTzM0zdbbruDBC/xhYA7qlT9HLkpAB0qnAQBkxSjMi
 jI70EtKxQfPccNt3EAjVZtBWPizGrbS+qDe55Cs/jK9KhfT9oP9d1JiUUWXKWr4PWnaCiq9KD+w
 oKxxGJa5QZmrir/4qi1+OCJ4vMc1kRpkir+a1wFlfEzZRCy4Uzq676K6WWHtidzMnjq9yMiZuSq
 1ZPwoMDDsmuemPQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-da9055.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
index 49446a030f10..3d9d0c700100 100644
--- a/drivers/gpio/gpio-da9055.c
+++ b/drivers/gpio/gpio-da9055.c
@@ -59,14 +59,12 @@ static int da9055_gpio_get(struct gpio_chip *gc, unsigned offset)
 
 }
 
-static void da9055_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+static int da9055_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct da9055_gpio *gpio = gpiochip_get_data(gc);
 
-	da9055_reg_update(gpio->da9055,
-			DA9055_REG_GPIO_MODE0_2,
-			1 << offset,
-			value << offset);
+	return da9055_reg_update(gpio->da9055, DA9055_REG_GPIO_MODE0_2,
+				 1 << offset, value << offset);
 }
 
 static int da9055_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
@@ -102,9 +100,7 @@ static int da9055_gpio_direction_output(struct gpio_chip *gc,
 	if (ret < 0)
 		return ret;
 
-	da9055_gpio_set(gc, offset, value);
-
-	return 0;
+	return da9055_gpio_set(gc, offset, value);
 }
 
 static int da9055_gpio_to_irq(struct gpio_chip *gc, u32 offset)
@@ -120,7 +116,7 @@ static const struct gpio_chip reference_gp = {
 	.label = "da9055-gpio",
 	.owner = THIS_MODULE,
 	.get = da9055_gpio_get,
-	.set = da9055_gpio_set,
+	.set_rv = da9055_gpio_set,
 	.direction_input = da9055_gpio_direction_input,
 	.direction_output = da9055_gpio_direction_output,
 	.to_irq = da9055_gpio_to_irq,

-- 
2.45.2


