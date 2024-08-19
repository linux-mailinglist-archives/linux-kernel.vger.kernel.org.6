Return-Path: <linux-kernel+bounces-292369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5908956E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708DE1F22AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E43C482;
	Mon, 19 Aug 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Osb214R0"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626C29D0C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080639; cv=none; b=NhUe90dcd3nVmc7jXlklzOezqZl6hWBZf6UeL6mdfeNM5iMWPXlWuo+VbPCTNuQ0TUddj3oxVj+wndPgV1nxl3UqkyWxvt8EfcI+/3gS2zyrRTL4ubaMuqC95QCkMmhmamqsXXSxRHHlnPbDrpP/Jq6E/4akpNC0ARrzsVpv6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080639; c=relaxed/simple;
	bh=j5udxdIWVGHFaedMJxO5+4BIfCOKJA6HahlitIk4aiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI4elybVZb+KkpZyEqT73lM2+OHh8DKoYq6Xp4uGQYEIQIuAAHb5W4CNMKF3mznjGlKEmtsADgYIhX6uNO1UTO+ThQfOQo+ZhoDryUz3qQVBdHdXooIgyHoXWMO3ot3uNDKHNRoAqshfeoQ64v56lkAArnLQtZbwxsnzcLtdeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Osb214R0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428243f928fso49154785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724080636; x=1724685436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqUcdqoma3yEribKkds5RbXbnSPHrBvT9Ses3Sf2wf0=;
        b=Osb214R0A5WpUy8Dj4htFrmnfH6JoxeJ670Q5fQ5MS18SpT4sXjHMocxfGh2xeCSX6
         9VP7HKckTn3vmM5uKAz5s0tOCU1lSYb5XCFFDeX8xR4jdVINdiKoNIKAWQxplSgOJXjE
         ZMWgGVnsrsCmxCR7eYFUlyYJcNxhNHS9ehbhdl/V1g88e/oAxFdewAKWWYAJCCs86fJL
         GQFAWcZCot4K278jUuSx0oUwWj2hrhoprmMBJx45zPP/kcr8f+N7XI2r8JoVD/RcFjK+
         SBhry3XV8D+DxVqDLpwT1OR2PLCuCmI05AEnyw91pfL+7rtWVMJfFILiHS6V/6++BnAK
         MI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080636; x=1724685436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqUcdqoma3yEribKkds5RbXbnSPHrBvT9Ses3Sf2wf0=;
        b=cyqBeYgHfE/mHfu+ykABhxZ8bS3O+2fvCz8FBDXuHvE/zcgVfErehhr1RSYgwcPG5B
         Y3vQqJxl4Vwz8MmEBGi4gVDDwRJ8ARDgD+2Ai3/EUP7h6bhbAzPTFxDaAoG5K69dCgNh
         g+dvwdzjjVAI1AqaISr9PpiiFERcHoJadDhvNOMUOzR+rLqW8PrIhi1KiKgqYstgcCCg
         /L8YCq81nMBKUe8uHMmkwY+vPHQHABtb9FjmZCtTUxKniYzKOW/GB0FGsz50JKJtqRVk
         IG7lyESMYmg+EiG99epR7mHw8GwALCkClm08+zGXwgGmjSe0viHbTwhada22hlPzP7+g
         DURg==
X-Gm-Message-State: AOJu0Ywr9iI30Czh2qciNFEGJ6TGwK6DCeLXoBVIeXahBLeySS6PDCQy
	YC4kyoOJfrKCK5R3BXhrW9BtmNV03m83p+Ch5FoLNT4t4k8VrlogEfXWkEDTNFI=
X-Google-Smtp-Source: AGHT+IFycE0vkMb6t+Imzv6t2U25JQV5b89k+Yg0j+IKsM2yvax8C7e62XrWiuukNLdbHjhhJ8Kj+w==
X-Received: by 2002:adf:b34f:0:b0:368:7f53:6b57 with SMTP id ffacd0b85a97d-3719443d292mr10026374f8f.18.1724080636071;
        Mon, 19 Aug 2024 08:17:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aad70sm10788324f8f.104.2024.08.19.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:17:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: davinci: use devm_clk_get_enabled()
Date: Mon, 19 Aug 2024 17:17:05 +0200
Message-ID: <20240819151705.37258-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819151705.37258-1-brgl@bgdev.pl>
References: <20240819151705.37258-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simplify the code in error paths by using the managed variant of the
clock getter that controls the clock state as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-davinci.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 7763b99f814a..b54fef6b1e12 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -446,7 +446,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 {
 	unsigned	gpio, bank;
 	int		irq;
-	int		ret;
 	struct clk	*clk;
 	u32		binten = 0;
 	unsigned	ngpio;
@@ -467,21 +466,16 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 
 	ngpio = chips->chip.ngpio;
 
-	clk = devm_clk_get(dev, "gpio");
+	clk = devm_clk_get_enabled(dev, "gpio");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "Error %ld getting gpio clock\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	if (chips->gpio_unbanked) {
 		irq = devm_irq_alloc_descs(dev, -1, 0, ngpio, 0);
 		if (irq < 0) {
 			dev_err(dev, "Couldn't allocate IRQ numbers\n");
-			clk_disable_unprepare(clk);
 			return irq;
 		}
 
@@ -490,7 +484,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 							chips);
 		if (!irq_domain) {
 			dev_err(dev, "Couldn't register an IRQ domain\n");
-			clk_disable_unprepare(clk);
 			return -ENODEV;
 		}
 	}
@@ -559,10 +552,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 				       sizeof(struct
 					      davinci_gpio_irq_data),
 					      GFP_KERNEL);
-		if (!irqdata) {
-			clk_disable_unprepare(clk);
+		if (!irqdata)
 			return -ENOMEM;
-		}
 
 		irqdata->regs = g;
 		irqdata->bank_num = bank;
-- 
2.43.0


