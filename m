Return-Path: <linux-kernel+bounces-541791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADCA4C1B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788777A6CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068602144D3;
	Mon,  3 Mar 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uyMXxpVX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE0213E91
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007930; cv=none; b=LryboABUOwXHbT3I4Xrqs2aAvWSkjG5hxaWra2xqivYwAoMt2I1Yuk3FzOGz3WZ218pfisSCH8tgNSy9dROw0gZf8Tk0Lb573NRziK/B/VD9qrZOAfJTzxcCIyX2csXxWLDPJA4hQmOwLGRaDQYNMQSebytw1Eg8uNDwntz0I8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007930; c=relaxed/simple;
	bh=pNFZLswBAGvHZgnszFpzGA3Zwifb9QpDP0WoiQWGE14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqzVApJTXYMxnQ3WRNf6/52kwB9tklV5TOn5HDy1citLLgPfSDlAc2CaDQumXuNylgBL5s6JaMnML5dFqAk+m65nXFvVyfpd8ek1mGkuMtxcgNdr/ql3f/dY/1/BWB2qISKktsRq30yvwb3t0Gir1kP4Xmm6fVQSBebJp8kIndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uyMXxpVX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso5915845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007926; x=1741612726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
        b=uyMXxpVXvID0PXrjwZjYyxx2FfGD+4e/p68FyjiCRpx7Nl5X5YTO/EuMYUEdHNiIdL
         mZb198mI5SsJfSF8NvLq1eg5XMRDBv24y+Mrf3BpIGiPr6jG6WhduXqVMei0wKbBOlKB
         7MRcMJd5dJSbUg8sZdo0qNgHIg+e3c8Uq88raTYa+6uKvUMXVGnz9o+BW2PMZffXCn86
         5/ODKa/9qW9sj4IAOv4DelvX0WZ224Q6wcs7orc8y/2zGsq/0GhbKfpYuX+f5ihkxW1Y
         9TRqm/7S54qi1aCTmOhJxojkln0VpheuTRxL/XWcTvDK9eCUxUnFrO3rZSk1mWQYKxvi
         LSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007926; x=1741612726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
        b=S9uauNRav6IkmUEqMB7h6puukwYvjP6WgV5jjYUM0AeqwgmME4ZqitgZ5/hV14u7CU
         AK/OHwVwtFfqmA9NbB7oXntb3aRen37lvVzICZNj4i512gGV9gyTlNfcQe4FNP/p4vTr
         p0hvElKWMdk+pKh5H1JRW8oNNv5JyUcjJXCVMmbYLr5S82gVL+MMGgAcv8Eotyo9h0aK
         7wGbK2eNOnEWWIwbharRHtdFRypo6Iss4Qase30pLC0SSBqN43cY8DMvP5UywW8b/xB8
         NZ/q5yxex1zUdZwX46TuAcacdcgllQeDAQFcCIHrV3M3P8cVuZG5njVTbwa7r5Snxixr
         Vghw==
X-Forwarded-Encrypted: i=1; AJvYcCVVBkcZFK+j1g09e4dwewC+G0Mprn7TzgfpMy8Qhl41bahHYaTN2rpEwYnCZXNseSFl8VdoZkphwpxP0mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTQNB0yaKN3yKAKIi5DZGyNXnJnlR22iWN4ZRJkVlPgJm5Ev2
	s/EMr6b4+HXQlEtK7kaZWQ97ngH/nuVHgn0Ne8Xqpv2OUT+1ZiquVOEQH6FMn20=
X-Gm-Gg: ASbGnctImdfnY4aGNltXTk8ZcNFNJdBUkBY3cdZ/8W5Kw4HnsY4Ip1/kXup4Y/qLNCQ
	11Tj60Y12nudkBQAPfeWd3z11VHX1Me4oLqcvuI82bNE93DCgLU69u6vy+6lMKTAJbHujst1pRS
	IMM/bj1gCN1WXd/RN5EfDXS7rvBhLO5E44/oRQoIxv41w5hbHG5VdsSJMVZ1Da3vFWnwDUtA3qx
	HPg1JnwfsMqcPraqtN2azXaYgtKLE9b7unNPi2gsQydO3ZvqKcgFGoRiM2SmIRNWVHmZpFzVQU2
	BWTkFxHdUfU0U3U2eeu3wPpjG17mtc4o8znFYQ==
X-Google-Smtp-Source: AGHT+IHm6EaYBn70SJkUBa0sIwAoFeDNkswqub4neNrYccFomXUwUOGpuKJlkXEU0LDo4dNArOpzqQ==
X-Received: by 2002:a05:600c:3ba9:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ba66e0a61mr112280175e9.7.1741007926409;
        Mon, 03 Mar 2025 05:18:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:33 +0100
Subject: [PATCH 08/15] gpio: altera: use new line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-8-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SMOq2xgstETx1JyBNH5vYamCTElxv0DKa/FsWx+nPds=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawrqlWF7E8xNzhaiQDDre2OcEVZwl9/RTexY
 M26Lfz22DaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 cmqwD/4phcgUzCpl6mKnD/IdnZIH9RNk3LmcqASY0VFf4EbXRAfUJVTaMQeDgSgk24dtEjEosuC
 bpBw1QzXfAFamKZKIQDyNKjXPzE/Hoe1EDCF34rZuNHNHPI0UBjmxJ1HQiXsaiOvcp6YuN90LqU
 IruTx8dSh8NomvJYZNovzKeon6/LRWzKlWb+uZYczW7uUFTXZL+T5oLS7DO99kqZsTCTfVU6Ul0
 3OFRD6NQ0Ihy9l2k1V7lqCDuH+qJyDeuUNq2LtUBuuX+2I8AY3ESBJp2i+MBGELCLWfwR6b1xxT
 LeM5r6nSFUOHN/2f46OZqPlXo+/06oFEI5JqVGow8tZdNrM6mq6cPa5erpnMrWDBhkLZOUeMhCt
 DWHujIwH4kTX+GRjsbuNjNbgHqGEDhX4l7xuIqaQFgkjS5/dRaSQ62lfMxG5PRYtYAOb417XaMv
 6t9tvs9wnV8Sijw4pvvP23BSDop9+n7LfOH20zHB8z38ZXbJcRKZJoWG+Brj5qdvrQmskwcQC0u
 MK94saNiUr6TGH1b7JaI0RM1SXCnT+wdiP5hdJBrPc9ZvTC7wVF5ruvBjzyMXjf9DAdh/hou8W1
 S4LR1Rq4rbXXTZk3VddxFwUqAmWQKWmlpqvYKvAjKmoq6Au2FAByQj/JHUPyd3iJAIjpfvDLzrN
 e1HgWPF2h6MAoxw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-altera.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 17ab039c7413..1b28525726d7 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -113,7 +113,7 @@ static int altera_gpio_get(struct gpio_chip *gc, unsigned offset)
 	return !!(readl(altera_gc->regs + ALTERA_GPIO_DATA) & BIT(offset));
 }
 
-static void altera_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+static int altera_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct altera_gpio_chip *altera_gc = gpiochip_get_data(gc);
 	unsigned long flags;
@@ -127,6 +127,8 @@ static void altera_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 		data_reg &= ~BIT(offset);
 	writel(data_reg, altera_gc->regs + ALTERA_GPIO_DATA);
 	raw_spin_unlock_irqrestore(&altera_gc->gpio_lock, flags);
+
+	return 0;
 }
 
 static int altera_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
@@ -257,7 +259,7 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	altera_gc->gc.direction_input	= altera_gpio_direction_input;
 	altera_gc->gc.direction_output	= altera_gpio_direction_output;
 	altera_gc->gc.get		= altera_gpio_get;
-	altera_gc->gc.set		= altera_gpio_set;
+	altera_gc->gc.set_rv		= altera_gpio_set;
 	altera_gc->gc.owner		= THIS_MODULE;
 	altera_gc->gc.parent		= &pdev->dev;
 	altera_gc->gc.base		= -1;

-- 
2.45.2


