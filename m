Return-Path: <linux-kernel+bounces-531285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E664A43E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B817A4E37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DDA26869C;
	Tue, 25 Feb 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f4e6axpg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF4267B14
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484593; cv=none; b=TIVowqKEajkzDq8sv2jsJEJ1h2Cux95KYgaSQ3B9oOjkh/mipQBUVyjS73E1mdtq09ynKtyBmoYphwMK2U5uwSgsOZF7j4uveWZ9AM6tHZ5csIRbvDCeez4BhD9E1izwL7RxmymoJehRIaBVeKZg5gndWSgDazM67WdOsayoDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484593; c=relaxed/simple;
	bh=YGO460ES0PrvtUVk1u55ClcB0fzrhT+lCjeLiVsXEQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oez2+wPWVNL8pHOfcWMSbfeWhFRsUN8ERBZ6MwYPMqToegoD5I9P4c2gwhvft3/WogSU1k7D/BxLQNtMN+ycfA9G4XrCVqkMt4ndGoJLw0Mk4WGTr56zKKUdwOPVsbyHzLY7sphI5xqQl17ikmKukYOMp0sYY0+19eeFVi5saPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f4e6axpg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so48098955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740484589; x=1741089389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbyzciQhn2JO10NIz132GUVY7KJkuW4I/yRQ2WvjRfY=;
        b=f4e6axpgyyc1ihcz97Cu+t1QIeJP89fNksN/ISLQSWR3Enj6BXHeEVvF22PjPaQ3bW
         jz0Wvyv4mmh7wA4d0P/Lk0ha2eqypnSW7lr4EYyNKtd5Ol3VWvAPCslE8jqLZBnO9Krw
         WghoPPBtFCY8KnJkwY0F/bB9HMoXFHkjhKje6cuaw1B1VUX7BChoQhoPO3Lsn3MLKPCR
         9a48hIR80VDnqZ+M+HOD21PORDZnHCSJbch8+676YUqkGvFgplQ8+gOgrAGPL+ZsUITF
         pxSjoEZLLeM/sz255gcm/QRk4Ho/cHgs2TxABr4RRG+zxKKiUuu2g+jP+42bH78BmAip
         F39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484589; x=1741089389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbyzciQhn2JO10NIz132GUVY7KJkuW4I/yRQ2WvjRfY=;
        b=TNvEPD7GqVa89LaJPUxMAgYcQkiYX/FcsXE1uUYrXWDNvh+M/YQH6unh1QMFzF0vjl
         q5KqZfIE8qRn9NRGMwFecBwQ0w+esNdKud5PSN52HMXUwgbruhMYXaqM03doK7xbpi+Z
         FP9wXNM5Du/wuoHUpTtXlLkyIUDoLb2l8RwApyc+On5iETvWvoUsuVZB1zvACeu2Euin
         5hJzw2un0LhuB8qP7DJij3TZS6QIgk2xbtEbHr0KzRlmYn6dBTacwuWxlEnBsPHwYTzX
         HJZF3VNX+9b9Hnqdj2dsrvfypwg/cAX0s/RzwxEGwKHIKfncv5pUSIASti42rbHltt/D
         OIEA==
X-Forwarded-Encrypted: i=1; AJvYcCWQqD7LjszOBH6fT06iR2zDVUZfq9TJleBnjIZxXIAMrj3Ki4vMHS+Ii+iwEo5zg2emmxug4NOY6PbsIy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+Ghh8rryGApgmwsN0cxz85VMj568a9YUgBpx1WyNDZb3wpf6
	ERqRHjgUg4xBCVn7k1yk9wS1mwZx+uraMmqfr8q79RHTlYDIz9AdEgismZfyO2g=
X-Gm-Gg: ASbGncv+hXUjIwWASTpddVSY6AYR6MyQ/vu7MlNm/f671rCHoGgqmsiYLbh3U+4ei9o
	ZDDkgvgHosSfuQLUJOPdLBsFfd/KC4bFkaYO2WmNPTSwNaxNNpIYmmJwwIFSm9eHhfj7BcXwWj5
	acv8MU0sAMIQb8HmHYLmyPX+JPGGzcDzeXs5mpPDd8oXbDTsvmB/zPaJuggomsuxAU1UUbseAvI
	qCIRCMR6pxB7aoaG05Qgc9L4hbJ433f5+jyawphsXb7FPmvhgVuBMCUs931HmVaWkeONMZw6drF
	XwnC11YueZ+SmSzSy5I=
X-Google-Smtp-Source: AGHT+IHIzmnFe0wL3bd+qPFKv1f1nRGmaxVMrfrzshY6OWhKyRxO+hXZl+5icJa2+TqYCYcjMQncEQ==
X-Received: by 2002:a05:600c:3b1e:b0:439:6ab6:5d45 with SMTP id 5b1f17b1804b1-439ae221161mr132196715e9.28.1740484589543;
        Tue, 25 Feb 2025 03:56:29 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:15ae:2cfe:447a:4a32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883521sm2058054f8f.56.2025.02.25.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:56:28 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Feb 2025 12:56:24 +0100
Subject: [PATCH 2/3] gpiolib: use a more explicit retval logic in
 gpiochip_get_direction()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-retval-fixes-v1-2-078c4c98517a@linaro.org>
References: <20250225-retval-fixes-v1-0-078c4c98517a@linaro.org>
In-Reply-To: <20250225-retval-fixes-v1-0-078c4c98517a@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=NnHAWuzH40cQuDNG1I+t5WrVKSbiDQg/68nmaoJKiis=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnva/qIPZJ84lRhkSMi0g4Z1k1dJJa5Jn9etdFV
 Uf6uxDR3yGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ72v6gAKCRARpy6gFHHX
 ckpdD/4pwb5HoTcNJ2VQB2wPyjduGOYeH1LSwH17WtzrY7fh+XppIilM6adtRhSwEVv1eOl9fs5
 +JcSMJYgFuHXoodypkmoXEeIyDuU6PgRpLLPe7lg6tZsy1+Rpv4YGIb8koBfORqXbi2wxf/FaaL
 3K3m4B88NcOEogs1yuCyHtUHpGAC97+vHqqI7sab+P4jSyMLUf9xNyHVUQ3QBoJeQeWQp5X+l/s
 qYp74TtILFgmwLeQzF4Sofoy30uzOkrA+nET+ecHYmqPVDvPou/eDw2fJZOmtsiRdTCVj6z1FoS
 m1QvjZQC1+DhZae11jdybkzzcg/KsxbWAPPidT6jOiJ1UiaPVEr9q0H7hnZHaULe5iMqhSDSU7P
 gKIKfCyN5RD+qlh6ai0FAeCc7yLFTf4L0X5uDrbvAGnLsdjWYZDmJTHqyURngSm1HU/7u/1OG10
 COz6DcqxuSBvrUkQfpb1vbCeofUqSZqT7jAQ6gWIP3Iv1iEZAGktNgOj8+dEycftiM87dD2hnBX
 x1j6jOFsBzQGvMmMliB4hrUvQ3wmxKoLUUlj+kO5hXivSisviKbv02M7hzhow2WQPlo8pDKMJ0U
 STSkMsRstM+xEZajyuKVDMOwKqnSZINZcQ/ljmcS4uwxlDp4LoWj/kOhC5/nTCS5QFOb2vLL5/D
 B44aGoQdL2xto/Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have existing macros for direction settings so we don't need to rely
on the magic value of 1 in the retval check. Use readable logic that
explicitly says we expect INPUT, OUTPUT or a negative errno and nothing
else in gpiochip_get_direction().

Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: https://lore.kernel.org/all/Z7yfTggRrk3K6srs@black.fi.intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 31d400b10167..d076b2ec633f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -352,7 +352,8 @@ static int gpiochip_get_direction(struct gpio_chip *gc, unsigned int offset)
 		return -EOPNOTSUPP;
 
 	ret = gc->get_direction(gc, offset);
-	if (ret > 1)
+	if (!(ret == GPIO_LINE_DIRECTION_OUT ||
+	      ret == GPIO_LINE_DIRECTION_IN || ret < 0))
 		ret = -EBADE;
 
 	return ret;

-- 
2.45.2


