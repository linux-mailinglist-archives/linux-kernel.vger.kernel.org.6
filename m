Return-Path: <linux-kernel+bounces-358619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F39981A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BF01C20F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510001BC066;
	Thu, 10 Oct 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XVJQeAiy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511A18C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551438; cv=none; b=GEjJmhMeFxJYZDHzk+UqdTb8w1Y6/9sNufezbktl/6Cw9zWWfdOABAikhdZKYJA9gfHCFrcNr3yeuGp7UD89KcHlJSvZjvdm/3h/Gg8EWbw66W3W/lRHkjm4dgBFUt0JZ4KB9dQ0SFfG639hz0pqH86v1a6avgOsNctwC6mZhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551438; c=relaxed/simple;
	bh=Md/Hr1eDm9gZYFElgpFpc1dlcVMo6FQJMk2O8wt4kIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmnECcutK2SHqzLR5g4adgnMzI55g7uAE8p0OyIbM5YIWtTd4NT9Q5tmHqg2HR9gdwpJH/yHXu7HqcKHygxSIXhwjtio/9KouMwbqVut0fCjMDHi1DEnHezQ9beyTXilMKTp8XEkY3s1CnZ3NhsGCJoxqiuJGz5BGhAtDO/gVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XVJQeAiy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43118c9a955so2911445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728551435; x=1729156235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2U+DP+Po3cvK+C6hThGA3u/rzX4mk6Ylhzlg9JhIjgE=;
        b=XVJQeAiy00Avhx9JhO4zlrjYQR7CwYBDPcnnJPBNTairgjUmAtXoiJi5nf5ztcBYcn
         YeX4mi8ZxyS/uX6QtU2rmHJIcQhTyIExqFoGZVL9g0TRz2sE1BwQ3im7MRe4GHxwc1NC
         0N7Vmnqh5zQSwB7dFKXys+ub7xhbcRohswVK5Mhufs52TszWewmSzYcI2t86+++EuyKU
         Ojck+tOeeblGYeu+obXpEJ3ELy/Dsfv8YSt6BHtIzontQnJsi4Tyg7xEG2er1g/IRb9j
         d6YSdnQyUHcW82QUfLL8Pc09+cK9XLm/zms336dgcjlRl3gp2FdoE77AtP1tohLbJc+2
         tR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551435; x=1729156235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U+DP+Po3cvK+C6hThGA3u/rzX4mk6Ylhzlg9JhIjgE=;
        b=v1L9HotVrrW24PbMY+HoPULgAujrdyBC3lQZhqoHpIcz3zE+sHhuqQH9gHL1ygFNbb
         OjZHrGC64tGxPlEq/xdoV8EzThfJMCBlY1PPZhLeuHJNJV+esRvnHqXkFe4byf8+5K4x
         MJP487UAeKp7rJe3RsXmzGvZIMRTNrIcQQzg/Fq8Rk41mdlTu6Cxs0s7UUA1KfJDw1Qk
         M+KFIA/tH6TKCs0QjndJHWbZvhX/1b9Edsj04GAstTo9v8PHdb95ougC2bLrrlCaPvdf
         s4F7WXukJfrWyOWJv8faj5wwbckTW7xnxOGipk8KPdxbwahsiu5BR6ZVcKDN0QrIvnKZ
         q5bw==
X-Forwarded-Encrypted: i=1; AJvYcCVqvQYlA65pOimNIAu7NuiH+DzTDrvF7QSVLEvo6nakVI6lNC8K3RYEBs9FzzR+8aqCm0Sk+PYXw8tgdcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbv92hPtwVp1HJZvEbqfrURjbA7H24j8wX/FybXZFmBrXdxcrD
	1SboyIoXJM3eqE71yEe5qw7Bk+H8Nrvn5VU9KzsRYExhHVUNL094IXSGSdCJhL0=
X-Google-Smtp-Source: AGHT+IGfYH5TMRPFMNDfM7MKJx1q8rzTx6kEhvkJP3Xs1zFlvZk3XQ747bwhNr1VAbjBZTXKbKv8Zg==
X-Received: by 2002:a05:600c:1c29:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-430ccef6313mr52014515e9.1.1728551435094;
        Thu, 10 Oct 2024 02:10:35 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5e5d:bfca:20cc:60ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff785sm9913305e9.13.2024.10.10.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:10:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 10 Oct 2024 11:10:23 +0200
Subject: [PATCH v2 2/6] gpio: cdev: prepare gpio_desc_to_lineinfo() for
 being called from atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-gpio-notify-in-kernel-events-v2-2-b560411f7c59@linaro.org>
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
In-Reply-To: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=hJXOR0yJYCJfsL+TmH/jw016J3uAhH62oK/KOdi1k0I=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnB5oGjSwEYXib+XZ21p/SuNORc1oC0p1EE0/8J
 drAnwmFJVKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZweaBgAKCRARpy6gFHHX
 cutVD/9gzcyiCBHbwNEqZFcoHr14MA1mOkJnkB2Rp7I2Y8AKcoBpD69jha+emJQO5FcolxravSe
 /8w/w6VAKG9oyG99STzDtyF+bBgT5uoNPDbgGfU82WqKKgH+6mnbOFvZyEXmFovpkhDtcU3SCwN
 DLb1Ar3klfSexGW1k1pt1dVThBx2kmexzeCHgtFFaqTJksXPjyCp+BGIRjJXaW5BdoKTUlRmL6J
 Y9j5jZkMGNKPgFohUp9+5W6hy2Qch4dIJh9iOBS/VAX6KHboD+1VM7kjTKUBPX7EsQUzcO4BYCO
 Tqnn+cFBzb3Kf/iCDj6zT/422IGOK8IWVOnNnkROXYpv+Kr8Ng0mQqYaiupGxRu4IYy2uTYqWJM
 si7GpoGbrmf2DL/84lb3cLptpOeycWGKHVlRx+QkQ5b40nHVrePDh8uWTicxNqPgxDKmAHsn+Dv
 s3ozdcWPGRDld8ncE99rx1JHkAlILg9tiDfIy5a0BakXLbsrIVFUw45j/Ap6WienPNSYC4gEqZZ
 V/SgXUXVdNHwz0eUCjCikEAWoMY4wl5XmXSqRPdWnU0RbuKMBN5ALUjyU7rx95YZslhp1svKK08
 qNLi0Zozzo7YZAZFc9ZfbG3vRIPKu5Lrc4VEpnBG8I2gpdvZlVO5hCjKFOcX1+9ESx4955RBHTZ
 Vu45kdUpjcIod1w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to prepare gpio_desc_to_lineinfo() to being called from atomic
context, add a new argument - bool atomic - which, if set, indicates
that no sleeping functions must be called (currently: only
pinctrl_gpio_can_use_line()).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b0050250ac3a..8c48a53b4fa8 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2361,7 +2361,7 @@ static void gpio_v2_line_info_changed_to_v1(
 #endif /* CONFIG_GPIO_CDEV_V1 */
 
 static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
-				  struct gpio_v2_line_info *info)
+				  struct gpio_v2_line_info *info, bool atomic)
 {
 	unsigned long dflags;
 	const char *label;
@@ -2402,9 +2402,13 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	    test_bit(FLAG_USED_AS_IRQ, &dflags) ||
 	    test_bit(FLAG_EXPORT, &dflags) ||
 	    test_bit(FLAG_SYSFS, &dflags) ||
-	    !gpiochip_line_is_valid(guard.gc, info->offset) ||
-	    !pinctrl_gpio_can_use_line(guard.gc, info->offset))
+	    !gpiochip_line_is_valid(guard.gc, info->offset))
 		info->flags |= GPIO_V2_LINE_FLAG_USED;
+	
+	if (!atomic) {
+		if (!pinctrl_gpio_can_use_line(guard.gc, info->offset))
+			info->flags |= GPIO_V2_LINE_FLAG_USED;
+	}
 
 	if (test_bit(FLAG_IS_OUT, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_OUTPUT;
@@ -2502,7 +2506,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 
-	gpio_desc_to_lineinfo(desc, &lineinfo_v2);
+	gpio_desc_to_lineinfo(desc, &lineinfo_v2, false);
 	gpio_v2_line_info_to_v1(&lineinfo_v2, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2539,7 +2543,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 		if (test_and_set_bit(lineinfo.offset, cdev->watched_lines))
 			return -EBUSY;
 	}
-	gpio_desc_to_lineinfo(desc, &lineinfo);
+	gpio_desc_to_lineinfo(desc, &lineinfo, false);
 	supinfo_to_lineinfo(desc, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2632,7 +2636,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	memset(&chg, 0, sizeof(chg));
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &chg.info);
+	gpio_desc_to_lineinfo(desc, &chg.info, false);
 	supinfo_to_lineinfo(desc, &chg.info);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);

-- 
2.43.0


