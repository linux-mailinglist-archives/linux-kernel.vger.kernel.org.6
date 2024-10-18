Return-Path: <linux-kernel+bounces-371309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F19A3986
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5831F2272C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35997191F6D;
	Fri, 18 Oct 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="idSIUf6+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF119068E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242629; cv=none; b=FHKAtaZlQvhXH6Ey42FmzuIbNpwK/U+SDSBWyzs6SVU7xSjiOrhtIJBGhY0MaSde3S580mJhiSV7nFRXJRD4VpEHDJ+SXXJzOpd0px/7ddICOJkfE+tWVZEs3+g0jQm9IgASYolsuR885gIwi8v3n8xdJ+06AAdYatARMPCgYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242629; c=relaxed/simple;
	bh=z0csyQTjaj+C9yhlJD2YwA9SB2zPsh7lfK9AhF+081E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBptPSPHdZhInmRWnsM7IFp/vl3W/jcMdYW6HPqB6YT1v03awaNFujZXpvLvh71tXPFI2fI7iRHCH5HnjbcvuVeXwpGW+Bvmh4h5/IP6njj886QlA6wLT3DJet6Vn7GbkBj4hhqPODIGTbA6kaXMIHgT3cE0h8/ZkyB3uOIDC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=idSIUf6+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so13980775e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729242626; x=1729847426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHDTJ05rGXvacOTESnBohjwJkgn6HYTuHVXiH2uivgs=;
        b=idSIUf6+u1mNZ50IjPJIVLHN5Tes9w9yW+APNi0ycGkjiFLJyVoko7nvNUSoVJsHSW
         mOawWkRTPd+gbhGpcBsfXOAnTXyVu2qSJgOpsBNxxOIn0wE63SrTpJtl41OicY9O08lw
         zYEVmvGvOvvbJyFAjFo1ux1bC1BCu46ZS5HGuCd/sHwrMDyiix2CnVqYHTy+9Lem04yd
         6uKDkiZBWRoWxpvwn3uDo0tDbCuWLEgRRSJDYxntoUyrDtHOM96aIJA62mNIqtf+QLrj
         tN+EJ4Y8HA3YRmEm2kKrChGJeOkNz6kwWMxFgizC9dJhPKdUTMvrVRwkhT/quLHv2/H+
         618w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242626; x=1729847426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHDTJ05rGXvacOTESnBohjwJkgn6HYTuHVXiH2uivgs=;
        b=fwzwJHDOCqnjraaAraDk57L0wgEufhhoTCaQn0SkMBlw2rEgT2XTg9UQhxyd3LSiaK
         eOWRRKsL9SKy1jCklVIZHdR+foQ4WW61kc2RVg+LlfaQbdyriyHkCb96XDTgC6/iq03V
         fAwbAWT1pdqpgM5nKkwjaKd/mWLbOH+H3hPGyHebF5tjF2tyeNmXcz9Lqm5Z7uMeCWVy
         j7CvDu95/meclpoQVKkIkeZifSfwSmaQTvBca82bZrKxgfetSxlB6Nyb/oaKSI3tFFn6
         UqsOQtG/4496eN4jo/PvGJfkkJpL9VLkq5g23S9kRZmj98WXQGp+EqAQA7I/tyAFFAQP
         I9fw==
X-Forwarded-Encrypted: i=1; AJvYcCW7eQ9Rc0zFbUkkT2/Yo+rCLDnRT7VXg8q5HLJhbuzFQo55/ESCGy4t8OSJ5W4u3+XC5+mJtND1NUkSCIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/xbL9CLGjSqKYuZUsFjAkhKxa7yIp9OFwNuB5Qo3DzQaxTSW
	aeB6K185gQCfW1qg2ZuTBbLxzSAkoky4/vWb82riQXaPxAZ2euPlAqM3jFmI7Ww=
X-Google-Smtp-Source: AGHT+IES1IoNjDrz0TOAvS0YIAGB73A/rzQcSM5bfAyLw2pzQkicscGsqdiDu7hrrbHf6vGBfzFz7Q==
X-Received: by 2002:a05:600c:4f92:b0:431:557e:b40c with SMTP id 5b1f17b1804b1-43161686a3fmr13507805e9.27.1729242626147;
        Fri, 18 Oct 2024 02:10:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dbe76bsm18700455e9.10.2024.10.18.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:10:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 11:10:12 +0200
Subject: [PATCH v5 4/8] gpio: cdev: prepare gpio_desc_to_lineinfo() for
 being called from atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-gpio-notify-in-kernel-events-v5-4-c79135e58a1c@linaro.org>
References: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
In-Reply-To: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+3Qa4JomiJeerbr48n315kA/cYd1bccbsc5mhXSvDl0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEiX6AMg2yIFfHM89i0pjfrYEikDVt2jKpX101
 iy2kjiUPNKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxIl+gAKCRARpy6gFHHX
 cuRtEAC9Fh4vr20FzXpGw7RMH/B8XmRwgmQWWzWFk8Yi9bhqW3snQaNE03AksJiQBn5mEPvhkSN
 83rg+KCopLioRjV3NZJZ7oHaBg3xo02hUtls8RuTlksKpBwn7p3CNpNChcEwgizv4IBxZ1aAwhN
 P2KBuuk/pvnVv/w2gDYoahFlhFiHr6QBB9OmQD9XzkjqWQoB5rQNIoRkAxcXnHZQrMGGT24EEn1
 iFRdBcMxTvp4YLxFVg5tLnmHkxOYihXlT/ZSZ9RGP2h8ZjmAeI/AtRSHclH4V8//GnCCpW4zYQh
 XzAsUXOjFzH3/LRZ+8OKVvfIu7gzW8UHwCGTJlscvYAR6iN62F3fYkDa+45+W1DegjelRrmUcjK
 1x2NyV5VpqrFdGRKzp04gI3uhHN1BAq8iRRPFSLgKK42+frvEw/CyXILBjsfvCE1Rw/8+xTQ/Vv
 K+6Ltia0k9mK/3xFeL8efu5JBxn7T91hrWyPSKhf/LntFrw+ZDLsSvU5Zvxw01RhBqO7UxAY+L5
 WfiMcjZmqN1TGbfQ3+t6Yt+aCsmzJzSz8cIUCXrj8WtvNN+jmc9twkV8/Y67q3ckV6zZUUlCLoW
 MhiEMYYTYnTwIeHDqjJ7xIrLBcWSYlV0fZgSTfFBLYmAU9x0xhLNkF80wnUDI1zUfJLjPm3Vc+H
 ddlNGxe3m+3nkBw==
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


