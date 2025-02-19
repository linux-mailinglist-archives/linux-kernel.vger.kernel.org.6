Return-Path: <linux-kernel+bounces-521326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07938A3BBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E2416AD68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E291D63FD;
	Wed, 19 Feb 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XTByGZiU"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD951C3F0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960880; cv=none; b=YI3RanCQGF6k1R1Q8FG1LoyekyMTSqq6qN/sY55JmoeaNsCztkPFuzfMS/h3A22bp/CRpZlHlq/u2qs/ZlEUmf0NcvmYJ+O2BIhNZAWcIEnBToeQ9T+gSm5Pd677qavHdFHN45Kw8LJs+2TrqVWquwcoiP+93qCstLVOCAvDnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960880; c=relaxed/simple;
	bh=6VKE6e/GxYsDY3pcRKjEGiXCqUCbFBAOACkB4hJUJgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/uKPxrwO/dhBYN8vsuErw6wkXzE4a43xL6gdDrYASH+aaBAZlGkOTtgxB6LlwzLglCnv47TN6MoYi/ovTw9N2R7kVQ2/AYqqAxr0RNrb6yvlf/UQD44efpExcGdaFM8xcwSONCozTSNsUOy3vf0y1Y+BaZyiXtgOQyabsk2itM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XTByGZiU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f31f7732dso410290f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739960876; x=1740565676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvFx40Wkz1+EUgvvJu1sZ6LkhHVZr+FyaICn1UZ2ZFQ=;
        b=XTByGZiUC0g6XyQvAMQKKDgZIlICOqthC7lfgHRhLu8hAjbOUzBO2myjzMMTHMEWaG
         jGHMJrXGP6svTrcLcyELnkegZ5uzyU77ssIYBEM/S4AODB4gIrScvxoFnhbwLW8v3J12
         0YUdP/72sMf+v+JJ/cxaSkyt2OU+8tvTszna9xqy/C+/dBPk/En8/syHVAnau+OjYGIk
         mtLnES0xY1gUIKFIGbJmoJZIwEVlBRUT4+JnIlRZ965O78E8kD2sQHMWwoloJj9+Kces
         cUPj7SbUJ8W8fyw8kO2yNsSkDSVwrWafMqAGP3MIf+f9ZNZIvCg4fpUREj9Z9kTJldFj
         b89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739960876; x=1740565676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvFx40Wkz1+EUgvvJu1sZ6LkhHVZr+FyaICn1UZ2ZFQ=;
        b=KUkZsKD3Kc8SwN3ukH6S9Psf78jcjX414Ra5yIqQMzZpyYA5r+J+VHsJdYHP+yKNuS
         KIOZki+TXlCXIc2sc16qsZG3ydfWnb9oxpCImInqnyFqiBt5aTFqFlACes3fzWB/8rni
         Rm/0B+U3ZOV8770EWMt6Cfws8xOZgq/VEDGmCRPNpVmNrv2WJTUngB3eC2XatlbOfUpq
         CPuvXU4MHKmscd9sgI7x6WanAny21D73wQ9CAqf8WoCAdg2qk9yJ7ZMdG7Tsr0Sx4/zn
         1y0leGzbQFC7wA3FQfmuj8NSAGrYo9oOP2ZsqxGpN6es74PoRIptwXaGGQjsdjeWCh3z
         p4JA==
X-Forwarded-Encrypted: i=1; AJvYcCUb47z+gdM01CldpLQuEytzu6jPVq6JfXih+1cyLGn/JLlFp1TU+k7I8iLwqmU0PUexHXD+F0bsjt0WjFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RBs6+pHkd8BTaZhXnwgZXtj5g6tWEg8wTsWyImQ884TOXUkz
	JGAqtemxL3eGYkBl1Hk/FVUCWzZqC46gMyBpUufqSAWWpQnMU1wE3yfX+8+1fsg=
X-Gm-Gg: ASbGnctsc9xwucgUKXS/fUy/V+bUmQxIDuwbjLY64Fo0064Y5y5bzVu1c+5Ql2/h3QO
	0IJqMvrLxnI098yy0A1oMi3zJQEicLVb7gu9/ExVrjALI0s1PUei69hjl/7r+33x5CvvWWPqexd
	JOacmFV8OM6q9M8TYb02Ck9afvJ9xdQ+szW2dKaIrELukTux0+oSzS+WI4e0OCmh1QuwvcXlnlB
	04fcPyIAHkRQPYDKmdCJjvSEJNOzB0z6nYVRXtYK9UZU94b2b/a08LQmGHuU4ptspC1Z60wHs1k
	PQG3WkgozIIFCQ==
X-Google-Smtp-Source: AGHT+IFlkOBpfCVx9q6F8niujWCdyL0EtEeWnSdwbrl7CVR7yKaGyBHih66p6S5yCje9Vgk4wUHg3A==
X-Received: by 2002:a05:6000:1fa7:b0:38d:d222:ee70 with SMTP id ffacd0b85a97d-38f57d93168mr2442618f8f.20.1739960874730;
        Wed, 19 Feb 2025 02:27:54 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f0ed:3532:fe6:315c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5f4fsm17492626f8f.78.2025.02.19.02.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:27:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Liao Chen <liaochen4@huawei.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC/RFT PATCH] pinctrl: bcm2835: don't -EINVAL on alternate funcs from get_direction()
Date: Wed, 19 Feb 2025 11:27:50 +0100
Message-ID: <20250219102750.38519-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since commit 9d846b1aebbe ("gpiolib: check the return value of
gpio_chip::get_direction()") we check the return value of the
get_direction() callback as per its API contract. This driver returns
-EINVAL if the pin in question is set to one of the alternative
(non-GPIO) functions. This isn't really an error that should be
communicated to GPIOLIB so default to returning the "safe" value of
INPUT in this case. The GPIO subsystem does not have the notion of
"unknown" direction.

Fixes: 9d846b1aebbe ("gpiolib: check the return value of gpio_chip::get_direction()")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/Z7VFB1nST6lbmBIo@finisterre.sirena.org.uk/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index cc1fe0555e19..eaeec096bc9a 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -346,14 +346,14 @@ static int bcm2835_gpio_get_direction(struct gpio_chip *chip, unsigned int offse
 	struct bcm2835_pinctrl *pc = gpiochip_get_data(chip);
 	enum bcm2835_fsel fsel = bcm2835_pinctrl_fsel_get(pc, offset);
 
-	/* Alternative function doesn't clearly provide a direction */
-	if (fsel > BCM2835_FSEL_GPIO_OUT)
-		return -EINVAL;
+	if (fsel == BCM2835_FSEL_GPIO_OUT)
+		return GPIO_LINE_DIRECTION_OUT;
 
-	if (fsel == BCM2835_FSEL_GPIO_IN)
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
+	/*
+	 * Alternative function doesn't clearly provide a direction. Default
+	 * to INPUT.
+	 */
+	return GPIO_LINE_DIRECTION_IN;
 }
 
 static void bcm2835_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-- 
2.45.2


