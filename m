Return-Path: <linux-kernel+bounces-369398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2739A1CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8960B1F23451
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BA1D4161;
	Thu, 17 Oct 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WSkheO3q"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50F1D3185
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152871; cv=none; b=HEgOElfxv6uXklo/ovAIiTSW45t1n2/ZhSSkNK7aIz86quc1y1MIpkYIpHs2beB3enePThU3OWLQxD3dl9w6LQuVH8haiNj+nxRlKG8KQuLlaxDoLyRxnsoVyhIrGMFHOxRWOtyC0vCczdyUVqpPinbXUQEAxxFFsx0SXBnb+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152871; c=relaxed/simple;
	bh=z0csyQTjaj+C9yhlJD2YwA9SB2zPsh7lfK9AhF+081E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mURvUunrxqRIrDBfq2wpTsZ9PcgHKyi3zn8TmM8kNemSu4maAywitKnLYXtWRORNn4Tw+p4TCsanBVbNj7B5XGWph/q05JZ6KIc4s8/DNSz8TKeuuomY7H9IOaocGOWebWOe9z7dH9g3WfbjyvaXvvIRGCQXgIji7sMc86wYG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WSkheO3q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso9214905e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729152868; x=1729757668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHDTJ05rGXvacOTESnBohjwJkgn6HYTuHVXiH2uivgs=;
        b=WSkheO3qyWCWj1gJb3YN/+wsjButcnQ0PDnEY3DeWFU+hD5T6VxUVbkBQzsXTiifAK
         w9JsGQ+PsZHlRMqAGLOYfx1i/2XPhxoCuQe4nEI1qWRQ0FxMFRVQCBSkT3M8qmXoBp//
         2CUSYBxr2yo6WWKW9R++FxXDCi5a1V0JUUYOV27hQV76PuH7XeCGhaJXb1MnKSfB1daS
         ROpYuZwzy+0QDXJbB9Or+3R6VLwPhn5ijHrMj79O6AC23xUOABROITrPilYdB8RFJ5NB
         IqKV16WElE0mLuOB7vOe3bB4pewZ8mn8Ffk/tIpM/fudYDkKMJQZm4oJhFvgIZddw2yQ
         7Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152868; x=1729757668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHDTJ05rGXvacOTESnBohjwJkgn6HYTuHVXiH2uivgs=;
        b=NBuqrR48hkvXA/gSDBS0gzEtD2HQRSGGWCuSz3xuVZqv32PMC8ZOh9jeqKkLNE+zeH
         6M0kA4seP1R5jwLUo5iCR1JWxAz8EZp5njiPnXIOMHm6tq1DBHEbsPv7RzEgnnOoGUIT
         I++/XuDWQ5afJPt8KJ9EKig9Wz0UHfVT513PDEZC55G5fIZ8GcXLgtxn97ZHt15S//ZQ
         f5PXsdEQsW3J4kq3LgbUeQ6i1+OopkoljuSynGsL7XafObrLdu9scbc15W3xtUjb0iCh
         ZEhgqY/CnpzJSY7imk+kUn9EHRnjvYbD3ZXcGBzJiWlBbDmcuSUe2Q47zChM2yCgPa2Y
         b59A==
X-Forwarded-Encrypted: i=1; AJvYcCXaof5rRbItBzAiBeTANJv2vrXA4I48O7+VoJGlbFqZIq9teL/DhULuKIlOJi3gLWL8pyOSGM5W6/MCAXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmdb9SuSmxAkndfHv3Np80Ut6vW0i77n407RLKypgRYnFvK5P0
	mTFNKG508/RvIl4ZAYqzD85nGCc7Gk7TE0KV8o/Bxr5xX99FoOc1mrsDHj7wQgs=
X-Google-Smtp-Source: AGHT+IH3/1WlsDT6/Zc59vQeFvCFJ9N1TfZKMWDWbZ4p5wQUNtEVdd5EZt+NPo7ptrlLM6oENQXwTg==
X-Received: by 2002:a05:600c:1c9c:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-431255df67amr189626375e9.15.1729152867674;
        Thu, 17 Oct 2024 01:14:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c61ae2sm17855695e9.46.2024.10.17.01.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:14:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 10:14:12 +0200
Subject: [PATCH v4 4/8] gpio: cdev: prepare gpio_desc_to_lineinfo() for
 being called from atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-gpio-notify-in-kernel-events-v4-4-64bc05f3be0c@linaro.org>
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
In-Reply-To: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+3Qa4JomiJeerbr48n315kA/cYd1bccbsc5mhXSvDl0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEMddCQpAjEI8dh0CULt+YwvGOirfxhaucWIq9
 KvpIPXrYSOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxDHXQAKCRARpy6gFHHX
 conID/48a3ILF52224ZoPRxXd4KVoBkI97PaXpLW+KZLSy70G88RZ4xw63FSkarcHkSBjGlp7tf
 trUOcNupRtdOnhrh1AE0wbRxZBpWaqROoUeQszN/rV1lfJQvaKBNkS2lMHfnZwnc662y4bW5sW/
 LA2s0SeySjZDfr/tv8egzUWylc6O/mxUb8K6y8eylFHCI5Vykb9yzhSd2j1dgcfjZ6ijw/336Ip
 Rd6IXhY6BV5+3FzG8ntnsTjUC0FiP5yonHH7n6SG+I2IsT7zbvMpuRTFB0vo7EyxXu/4cc+ky4b
 ZKDoEDyhxkADl99DIOGyp8BQ6UGqohoxs7/kRSvy7Ac12gDNWXPibdPILwgrSYo/n/63btBouvy
 qtWEmlCOk/fzbhqwD0dW5VmpgiU2CcfM3eCs3/CAJOM5izX9uS+jPwde9Kd+Ug0d+Ryvm3YuOHF
 K1dMTfqh/K1XfO1EbOoPo5FkVjuw2X8WazwBRAKVQk24TLoE9OWKyMM98C1smfClxE4QYPeHJ4Y
 VcnHQu95ft08yPwSgb1I4Cm2koldNk/a8+Sqa9Q3qkgl/wqi59D7mTaKXI0pxejsAcXvc1WAjA3
 DCLSSmjp2zSlAGNGCku1PnXUn8MrKPi2Q54Qe5umHNqDBcTIKazgfYW7PieYIqj084H88a6BGzN
 kJbyGX8zgMwyOIg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to prepare gpio_desc_to_lineinfo() to being called from atomic
context, add a new argument - bool atomic - which, if set, indicates
that no sleeping functions must be called (currently: only
pinctrl_gpio_can_use_line()).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d55d2a246d41..0cba74381687 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2235,7 +2235,7 @@ static void gpio_v2_line_info_changed_to_v1(
 #endif /* CONFIG_GPIO_CDEV_V1 */
 
 static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
-				  struct gpio_v2_line_info *info)
+				  struct gpio_v2_line_info *info, bool atomic)
 {
 	u32 debounce_period_us;
 	unsigned long dflags;
@@ -2277,9 +2277,12 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	    test_bit(FLAG_USED_AS_IRQ, &dflags) ||
 	    test_bit(FLAG_EXPORT, &dflags) ||
 	    test_bit(FLAG_SYSFS, &dflags) ||
-	    !gpiochip_line_is_valid(guard.gc, info->offset) ||
-	    !pinctrl_gpio_can_use_line(guard.gc, info->offset))
+	    !gpiochip_line_is_valid(guard.gc, info->offset)) {
 		info->flags |= GPIO_V2_LINE_FLAG_USED;
+	} else if (!atomic) {
+		if (!pinctrl_gpio_can_use_line(guard.gc, info->offset))
+			info->flags |= GPIO_V2_LINE_FLAG_USED;
+	}
 
 	if (test_bit(FLAG_IS_OUT, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_OUTPUT;
@@ -2385,7 +2388,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 
-	gpio_desc_to_lineinfo(desc, &lineinfo_v2);
+	gpio_desc_to_lineinfo(desc, &lineinfo_v2, false);
 	gpio_v2_line_info_to_v1(&lineinfo_v2, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2422,7 +2425,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 		if (test_and_set_bit(lineinfo.offset, cdev->watched_lines))
 			return -EBUSY;
 	}
-	gpio_desc_to_lineinfo(desc, &lineinfo);
+	gpio_desc_to_lineinfo(desc, &lineinfo, false);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2514,7 +2517,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	memset(&chg, 0, sizeof(chg));
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &chg.info);
+	gpio_desc_to_lineinfo(desc, &chg.info, false);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
 	if (ret)

-- 
2.43.0


