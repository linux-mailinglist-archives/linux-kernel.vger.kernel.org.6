Return-Path: <linux-kernel+bounces-371307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E09A3983
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E40828191A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CB190684;
	Fri, 18 Oct 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xjCahh9M"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABE18C92E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242626; cv=none; b=QdIDpTSl5GNM8LZIdZ6Y8DVE/UCIW8JZSrhgAuwXNG3LQpEWqAX2Ti5Mt28fG4YoV6tYRkRCmH0Qy+SV0jP9k0NrkNydUHMPcReG6XW8wQXau9W7sHNGzCz4yc00rkyeO1jWQV4gydCttdGwHOz/x448BJlVCS1MTREf79AN/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242626; c=relaxed/simple;
	bh=ND47jIbOYDmJs8MpSoNGSSJKSen6G5z88AQQSxF1llA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sODSFEWNBwk9QwmMkSrzcOhb3fC7LReZ6nNVOAZSCdBxMdH2tFr7/cYuoGFc7tFFW4nj+2xSt2C/8QbpI02sLcdMdhd3bVybZNRVHUyd0wftnEsfFsHiAAnRhf07dfYQkpoRAwIxWuJWtwAKyU5RotBGZheo7r6gsibqENwhnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xjCahh9M; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314b316495so17862965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729242623; x=1729847423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLpytUujQtrQRxKwGItE9MBF3PBkf2ocRMe5UxADIfc=;
        b=xjCahh9Mst/98YF9esMi2Cfz7eLRZoT41B5yhFSnamT/qQMD62YNHBNohtmlqsDFzW
         G4IMDo6pazOLl5LVmaBjNGUFKxqJhXWr/MojPF7Y7pQKyIkqBCqkdfkLLjKzB6Phngb2
         Jn2hu6pIu3MjjMb7Ojbn1e/cX81HkXtXBewKkvnMYy+ip1rrNOnySQDOdV/etI0nk050
         r4AFCtLJCIkZL2ILYla6snUwwYMaakmcetqN0jit6xyhPiszVOhY7y2IxjpWUc86HpMu
         qzns6+SIC6d02b1vD4rNHDG31DQgkvZ3RFcs3R1XqRiFgnCikUs3JrL5hTKTDResPpPN
         haZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242623; x=1729847423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLpytUujQtrQRxKwGItE9MBF3PBkf2ocRMe5UxADIfc=;
        b=WAR60m7fbJjzEnHmw+IMiriLLcQ/ZyTMxtLE9JILfLGjdPQmYZB00nIaMniE4HWy3I
         NGbLxwn37AqNlEAkifXQ2TohUJtW6MG/UsztC3x9aqTW+uxpA+hZbH4SHneqtPBct7bE
         4IY3mR3FMfspXY2gaxPSwQvujNlPb7gdDr+QCooShs4vRQ+GyrUXVAJL6I947gEUgf/B
         /406vXz7eqxPKcXVz/m+6qMa16lkMVDSLFvDGz2yxvFQfzYo6cV6mBfGcERtiV47bg6h
         W1ruex1YWAfDvv5M+ivwbP0AF9l3dn3kS1EC6O7Sj/rJDQT21zTVrzWoGdV0YawdsL+n
         APdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9LKzp8afMlNlGusBgB0VaRNRODtzQpOlUlwIx5I4fEavUUVoPVmHUy5qg0ELZKIpOuyQx9B5gWv7CAG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DbjwoH5L2kuXSO9IELdHVgeyYSzA5Nz1eOPFXHqb6qILGBrM
	CXtDLSigKp9w0xpa/Vt4MVrHLXsFqtGfDlfuiBIMBGpkjJP3y8vfC4iuZ+1MA8o=
X-Google-Smtp-Source: AGHT+IFCMIdzGCoR1Stri6zpATjzmnSwe19p+msFa8rRRyEbXbIPNr2a35ZEDvgCQun0IL97qDF2fw==
X-Received: by 2002:a05:600c:4ed3:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-43161636fcbmr10386125e9.4.1729242623517;
        Fri, 18 Oct 2024 02:10:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dbe76bsm18700455e9.10.2024.10.18.02.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:10:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 11:10:10 +0200
Subject: [PATCH v5 2/8] gpiolib: unduplicate chip guard in set_config path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-gpio-notify-in-kernel-events-v5-2-c79135e58a1c@linaro.org>
References: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
In-Reply-To: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5bkoQOmE+e79NCUZkE2hkqB3kJJTpG+Rd7AZwxRE2E4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEiX6hXHkiMrjbf6lTzXJR07uV8mFVAuQTiD5k
 kOzCzc77sCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxIl+gAKCRARpy6gFHHX
 cnBUEACPPBwp33JScr/PgbuGXaIiVAxqhCZaIQ5u5075zGxd9ymdgB6nmxIyvgRR5A9aUUZBESV
 FAWuvQjjPSGymT6U95dTe10VtsRWbCtrPnazCZ8IKaCRIas7z4mWSu1GPu+Au0DjUKAJWEvnK4s
 Uhr6mexIVi1DsHUwBkCmkqWJ19Iz/qESf3J5V3hT9F0bYoNfZZb6s8KjYwU+3XJi7i7Z9lhEL7p
 xNDANoQydhU0nXe4rDk0biFYdanzXYWayZjZIXjWhlR16GEEVo6onB9dgVmPFGr3koK1Kv+OHEp
 4Fdgpr0MMjSi+i/RPBD0VmGFmz7Q9kR2xzzaI40uwFr4iPK/5mVWAkKPtknuq2FcGlk1wHp61sI
 GqfCIIliq5JiSwRy3dz1+ycalnPDB6xT7rnDVkhG0+Qe4hP9Au3J81csOFXY1S5NIBAC9I7Un2Z
 YWT/VkrPiWuzac9cQKjdIY6PqfHmUObL543xt5BhnBTATghihdaAQZozUKIIvt92OruUrV/G6kF
 H/uON1F6FeluHOCas45NTvykxUybKprxAvVaiBX1iB2ak0mXJ97nM4sV5L2mjIZMAMTGVEqwSty
 qaLMQMf9uOz6iwLTF/74utIQNLyaq8JEqo6vt9gusstbwMprSMVuarehIoQjuvqjoFMf1UmjrYw
 oSV6LiLrnG3Jllw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't need to guard the GPIO chip until its first dereference in
gpio_do_set_config().

First: change the prototype of gpio_do_set_config() to take the GPIO
line descriptor as argument, then move the gpio_chip protection into it
and drop it in two places where it's done too early.

This has the added benefit of making gpio_go_set_config() safe to use
from outside of this compilation unit without taking the gdev SRCU read
lock and will come in handy when we'll want to make it available to the
character device code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c09464f70f73..b1ce213d3a23 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2562,13 +2562,16 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
-static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
-			      unsigned long config)
+static int gpio_do_set_config(struct gpio_desc *desc, unsigned long config)
 {
-	if (!gc->set_config)
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
+	if (!guard.gc->set_config)
 		return -ENOTSUPP;
 
-	return gc->set_config(gc, offset, config);
+	return guard.gc->set_config(guard.gc, gpio_chip_hwgpio(desc), config);
 }
 
 static int gpio_set_config_with_argument(struct gpio_desc *desc,
@@ -2577,12 +2580,8 @@ static int gpio_set_config_with_argument(struct gpio_desc *desc,
 {
 	unsigned long config;
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
-		return -ENODEV;
-
 	config = pinconf_to_config_packed(mode, argument);
-	return gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(desc, config);
 }
 
 static int gpio_set_config_with_argument_optional(struct gpio_desc *desc,
@@ -2944,11 +2943,7 @@ int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
 {
 	VALIDATE_DESC(desc);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
-		return -ENODEV;
-
-	return gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(desc, config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_config);
 

-- 
2.43.0


