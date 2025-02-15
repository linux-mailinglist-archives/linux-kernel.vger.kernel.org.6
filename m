Return-Path: <linux-kernel+bounces-516129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D4A36D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090A73A3F85
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DA1A23BA;
	Sat, 15 Feb 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V8fxFeR9"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5D19E7ED
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739614132; cv=none; b=hXe4k1Oa+o8YJ4IjQo0fDwWBiseD7JhSJK1X78uA6zoZE2ks8X6i+Ca8QU73jZs4hu7fucHiDKiA7X0HxCRZZz/EPCb0AjQcV9EmWdV4Hagcrm5BRxN6Pk+M7vxMG9z3jd3qTDgqSa9qwQN6Pr15S6UhKzK1kFI1f4K2rP9AbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739614132; c=relaxed/simple;
	bh=BRmwtD3g4MdASxOYlwvxiLLUj13AgRdVvwTDU+wMxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVs87Ixp5ZeCLyi+cRVTMWXEG2CFe7U0uxtH8axcH+YLsiJCDuhis7YBZrCqRUVPlXIUcrNdLG7pbJjlb92vqUVrbTFL4vLbHQBCyg4viQ0saXd0OVt2Hslytbl5HBe+6nF4BgdSgrk137/0jRTAGZYz0xduChwVY7QJqopOb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V8fxFeR9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f2c4382d1so864512f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739614129; x=1740218929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONpnWz0CmHVgfVwLFdzwsY0uXxe9qG8gGGoClVT2HtQ=;
        b=V8fxFeR9FBNL2NfjASW4Qkwhckq8jR8lv6AldEXvHFqdhtYcESSN9msdipXv+3xrYy
         3lJWdApGBYdxsM+BqT0gmZw/cAJRza2vkeulktvrur1dZoktojaeWovw6ZNIEGFovvlv
         +VfZXEPZnvxPiVs2nCgHWxH5xCMh02IEjJUiGibQmlwdxey5/XqC/b7Yoth4d816ysVg
         gO8QPGxDFNKNtNm10Ai9sUmNMEZnMD7oeJsXZIzXogHfNIfHAtVpXN1Qe5xDU/bCGB5C
         Iw6yR7EdSsOZVTtFRzm1Gq516rtapBlYMUqoXuX5EP5yVY/4nUzkaH60wvCTVDYeq/ns
         fPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739614129; x=1740218929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONpnWz0CmHVgfVwLFdzwsY0uXxe9qG8gGGoClVT2HtQ=;
        b=KCOerU3x8aJzhuc8q1HgyNZglgdEq33wTrH1sL8dUCmB3HCf32V5z/7GCet0gQI5MF
         5ImLz0oqElKUkINWN5VLQ63L5GTtEUs+ynHmDXP4LUICvGDWiOlcKHPATH7dPA+e0fSR
         c6uVOLELGGagU3d37XBTv0aMz3tIydNhMQoAvSm9IzGcdw43bGpbpGOy6QqDIiQZ5FzB
         cgOmpQDgSnh6giD18VfdNLa/SxooEzwtIJo6xDu8EbR3YJ4lRR6pWVbkKPIRrpov9UTR
         /qVMqx74VPmVqK5hRLiNRQGRnnJka8URKQU6UqML29puVeaqkm0u/m0dVbXHzY0mPo90
         ptWg==
X-Forwarded-Encrypted: i=1; AJvYcCVgWhFb69a0MbpWgOmVuCGLX8rFZNiVPySA8C2xPnj1S2D0SxuVQsxRuGrV7EGlj8v1Wwe0ek8n9TgT33c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKCkXSFAzBNUKpmwjiKp6oAsDdVOwr014DF3U4eWym/YJyLm7
	DZv+UDkS5FufdLiYW+cZHXJhfKm1UGH6e+qk3zOjLfDfcT4Hyr5b3iLjyly7yjjZcUUODFEdYyK
	c66M=
X-Gm-Gg: ASbGncuGR4A6qKOvQ9Y4JX8b7TacNtPtSxFT0zFEBqay9dxpp+do2GJLqbg8URVX+Mo
	LG4rgJF+6UzIIE37YT31a4RPEKzGgG37O5OYTqV5nbXBq7QUoBX6kej0098KD1kYkuIG1l9Mhtd
	vNvT/JMSljoWJELuPbgedoFs3N9lC4XtHpYVRsF2Bs1M8+XHKrevnue2MY20iOPp4x/1dZqnavL
	9FBUv7eEhiSQ6fyoWY22cnoZaS+l0j9SS3kYmBggK6Zq80dBQzq+S/4zd19kXb1eSPsPONUlgMa
	8xBINfqzsv5n
X-Google-Smtp-Source: AGHT+IGh6i3Dj+Choh+Ag1DxD3ZJRrsDaj224k4gzjS6anWZyky52EcQ9UvX1NzyoZ1iyfF1U5sC4g==
X-Received: by 2002:a05:6000:18a9:b0:38f:221c:2c8e with SMTP id ffacd0b85a97d-38f339d8907mr2947145f8f.6.1739614128977;
        Sat, 15 Feb 2025 02:08:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de0:6b3:d799:3d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm6862411f8f.26.2025.02.15.02.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 02:08:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: read descriptor flags once in gpiolib_dbg_show()
Date: Sat, 15 Feb 2025 11:08:47 +0100
Message-ID: <20250215100847.30136-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For consistency with most other code that can access requested
descriptors: read the flags once atomically and then test individual
bits from the helper variable. This avoids any potential discrepancies
should flags change during the debug print.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f4e14a7dbc87..7dd054f8141e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5003,6 +5003,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 	unsigned int gpio = gdev->base;
 	struct gpio_desc *desc;
 	struct gpio_chip *gc;
+	unsigned long flags;
 	int value;
 
 	guard(srcu)(&gdev->srcu);
@@ -5015,12 +5016,13 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
 	for_each_gpio_desc(gc, desc) {
 		guard(srcu)(&desc->gdev->desc_srcu);
-		is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
-		if (is_irq || test_bit(FLAG_REQUESTED, &desc->flags)) {
+		flags = READ_ONCE(desc->flags);
+		is_irq = test_bit(FLAG_USED_AS_IRQ, &flags);
+		if (is_irq || test_bit(FLAG_REQUESTED, &flags)) {
 			gpiod_get_direction(desc);
-			is_out = test_bit(FLAG_IS_OUT, &desc->flags);
+			is_out = test_bit(FLAG_IS_OUT, &flags);
 			value = gpio_chip_get_value(gc, desc);
-			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
+			active_low = test_bit(FLAG_ACTIVE_LOW, &flags);
 			seq_printf(s, " gpio-%-3u (%-20.20s|%-20.20s) %s %s %s%s\n",
 				   gpio, desc->name ?: "", gpiod_get_label(desc),
 				   is_out ? "out" : "in ",
-- 
2.45.2


