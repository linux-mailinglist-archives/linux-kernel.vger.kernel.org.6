Return-Path: <linux-kernel+bounces-289926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EC954D66
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED936286A80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EFC1BD4E7;
	Fri, 16 Aug 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixuVVsQP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF34817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821241; cv=none; b=tWLqbKzKoUc9DY2HWW+v8r7eHRadruA/RN/aT1oOGEuY/E41kiEyTZCfMQh9CYZm8f8VxhGrPfejLyjNmMKTz0imVkUw08dlj/5tMLKlDthkO5zeVD46vcib1Anccb0dguxogZcJK1iufPXNnXfUCDqQ0thbKLh5bfhkr9qKk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821241; c=relaxed/simple;
	bh=xCFg6KZE5Oj2UzLzP2Qjl6B3J0PAi9e0GTdP+tWb+54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcbFACwGGlPKlMCHGjh8HS0Sug8sQVoHmmE0CrqGULUBrX3/VXelNMwLgeOIuq6bmE2d7VzZiNCYbhKzxQ6AVIiNg4Y3qoipqKJZpsA1hFASQ8CadWpyu04SL3rCS32wmq9pBz9U2Fu4kWAQRWLi/5/d78ft4h85cOiiStzSoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixuVVsQP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso15962615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723821239; x=1724426039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9eluJtrARg9/OnGUybOshC4XIYqnchlo0yRM5uQjvn8=;
        b=ixuVVsQPBOqj/gRy8w1X1bAJM3QBebrAs2HNmgFZxgvW2ZlJt+EJMg8hThtzobSHRG
         ytxL+fCedUPfI402RDcu5CyGksJB340RZcOCwXvn9R6XVDw4D3WgETZRTMPbw38Nzk1Z
         E3hsebrXfWA3HYpC6h2i8erElVVxNg8XTSRI1EibO4zGDb/y2Nx3Pfo3xvrR6dcbSYmF
         u37pm9vEZiS+2vNAwazg9mELBi/wOTKoBXILFwjGAZT8EBJ6+XyCcCruJo6xbOKYHk7z
         x6kYFYCX5gSIx8+CapBp+eJgy41FPHVBoRJOaRmekPUYGjyxSqiynJN4HC36HJyCw0qX
         M34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821239; x=1724426039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eluJtrARg9/OnGUybOshC4XIYqnchlo0yRM5uQjvn8=;
        b=npQt2oJJTS29pC3ncQ+9PkB4Qi+/39388DgjrEsOijt3PFoDZg2qDbTI6DcLlsmQ1t
         aEt6yazaj2qQcJUNnBf52zhve7VS3RjrdJ5nFMlG+hBOpNIbEhQhtdIfNLIo6w/h25Vp
         SnKJLIbGgtPSSkijNfc1m26ItaxFg7Gn+V3u0rgsYD6uryt7ldHVlkpylGdmk3DezLQD
         7g1pkqf9szI7yYiN2GKbUmhdJp9u4CTrOnMjRPSJUsS4w5ITp46cor7SumL6PvXz7/g/
         kt4kGmmqG1jNELOafZFMyReeWD683qoRx8r1QJ6HY6yrd+lNjo0tI4r9zMxVdNPEMv/B
         +EVA==
X-Forwarded-Encrypted: i=1; AJvYcCW7OC9UuH574PT80nFuQc0lHciUYSeHdcKFi1ZFQl0KDOUATTzf9f6hhcjxxAphkvxdOtG4UiyPp8UUkMCagDxagp5fEvkoEMs8pt80
X-Gm-Message-State: AOJu0YxU3Zf5TiIAF12hq4GOjUuejSCN9Dtq2Lg5M6yYWAit+oNuqAA6
	Jwmzs/OO7FNyozIvUyA24GePzzTtQtbMM8jpjcTXRiOzLxkqS+6WWP5gMrkmA94=
X-Google-Smtp-Source: AGHT+IGEXZPcxdMf9EZC4H7bVC3zSyxPXRSy+acQZMoOdOaHVxss6WFCXBQPK58z2Gp4TocBg1gP7g==
X-Received: by 2002:a5d:6805:0:b0:371:93aa:4056 with SMTP id ffacd0b85a97d-371946c2fafmr1888445f8f.61.1723821238538;
        Fri, 16 Aug 2024 08:13:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650402sm25205815e9.11.2024.08.16.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:13:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: of: simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:13:56 +0200
Message-ID: <20240816151356.154991-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_xxx loop when iterating over device nodes to make
code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6683e531df52..3bd3283b349c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -338,11 +338,10 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 	 */
 	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
 	    of_property_read_bool(np, "cs-gpios")) {
-		struct device_node *child;
 		u32 cs;
 		int ret;
 
-		for_each_child_of_node(np, child) {
+		for_each_child_of_node_scoped(np, child) {
 			ret = of_property_read_u32(child, "reg", &cs);
 			if (ret)
 				continue;
@@ -363,7 +362,6 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 								"spi-cs-high");
 				of_gpio_quirk_polarity(child, active_high,
 						       flags);
-				of_node_put(child);
 				break;
 			}
 		}
@@ -836,18 +834,15 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
  */
 static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 {
-	struct device_node *np;
 	int ret;
 
-	for_each_available_child_of_node(dev_of_node(&chip->gpiodev->dev), np) {
+	for_each_available_child_of_node_scoped(dev_of_node(&chip->gpiodev->dev), np) {
 		if (!of_property_read_bool(np, "gpio-hog"))
 			continue;
 
 		ret = of_gpiochip_add_hog(chip, np);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			return ret;
-		}
 
 		of_node_set_flag(np, OF_POPULATED);
 	}
-- 
2.43.0


