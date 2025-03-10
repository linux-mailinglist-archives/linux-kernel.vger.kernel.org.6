Return-Path: <linux-kernel+bounces-554222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD03A594E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA8A161AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1F22D78B;
	Mon, 10 Mar 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wvFNxV/a"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDB22B8BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610445; cv=none; b=aGr6kAafLhE/YTJigtbgTDLXKPZagNAwnF4c7tQxflqVfAN5v5n3H7zRhMiFG9R2u3lCCM4TLX9IzafjsoKCCfP36bMsZhoQ99UqLIF9n6DCgvxRwrcFpU1bV+FXXKA3t0sCSuvZsYXQPRxP8DYU+AWMuJlQkALsOqFbP9UDzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610445; c=relaxed/simple;
	bh=KjNVSxMUcxXw2e8AzNxM5jaOttfS+Kefz7x1bNsPa9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSJUDiwQcOukY4k2K8bA8/dp/YcDyeW8DqlroBkrXvU1PpvziNkWa0jJtkmtUDHMC63F2FktX4JF7AQb8VASS9jsHyymXXrjpl/jgxIOxQ6FyPz8p81I0xnLIIK9EFFFcZNE+WKoUzOFX0zsM2ejksIRmz+nK4J54Jaa12zivYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wvFNxV/a; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso24712245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741610440; x=1742215240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUhOpFTq7T4Vaw84Qb5mjT/Mv6Dno+d4OQdMzLiCIb4=;
        b=wvFNxV/af+3MaPFV0qs199GuwUAAzPpxtqchTU79Ub5sdS9lhlYCLlF497AIe/qkBO
         GCJJWRbiK/9T0w1S32bHJRtbtz0IqrAU+V07V/b+dcSk1RshHvY2GvpZHTNFeZr9P4oR
         lajRT3cJ61bOxnF0gC2D0ocUIzUWClEWKqZXuEUwbx5XMzZ4R34H2hbLK6CzKLIfXcj1
         WcibZXYELoYcAVWpA2keEa45mp4PZW2qRaLm5GQedCKWdP7YN47krgbLGrF730YN0GHQ
         Myn14mb0qMprjmPogDxu/eGZ2jGe78R3bRTlT9JrnmgLwUipRC04gzTGPk5oohQiRFBc
         O7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610440; x=1742215240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUhOpFTq7T4Vaw84Qb5mjT/Mv6Dno+d4OQdMzLiCIb4=;
        b=WwT7PBh0g1KWQO0HiFHtj9gT+2zG4BY1FwEWS4f/twi7Bq+zEwcaqjqCrX/xOX3hCX
         KR/3jAZum4ZPCP64b3G53/tJ25Sc/dExlMnIx1sD/T3Hk0Lxto4ubLUyOiyzUSDZHxFH
         UJgAfaFWsvpyDicrZQbcTTtE+UbRtSye5t0D0AfIwlrQrwlAR1cqmUL1Coz1ryUFihun
         Ur1+VpHj5r+rw16PIdtRFSLdeAg9Kw8INkJkw8BDD25TGqmc3G7yU0CBg3lGERiIIcmy
         ZoPqyfCD+zvwPVpVjLMPngexMFzf9DemPmv3igUZ8irtcCCji0u6y3GeqgwGWtGWVD0Y
         U1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP/e2PiP/wy8OvUVW7pVbnOj+5LkpfwhTc2fdW5IjDcLS90vf/sP1S46X4FRvS4Vspf9MMDwZfTMyl7TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sy2782f3LetGl5JtlktIEYob2JKgSMTRF473xepmPcxH1pi8
	Zgi4vLecavSTsqUeVRfskbtBeoYnJyEcBGeE/EdGW5X1ML9m4V1HNwIi5Hprx4c=
X-Gm-Gg: ASbGncv/6U5qZIfSdN4erGOA4ZSSYtPJdeV4MJSKKui+cN1gkEya3MTsYmTTVp2XhxI
	m/Yg18fpKCQ2oc7tHXtSvizS5ko8hnXVwTJC/llP55EOeOBwcXIIbwz8jpvwweE4cQV2WyVxjDt
	a48N6hAon10CTleVk9fwddLrud7ZL5jMa5RUVhVt/3h/fQmGcaZ2genxFZUW+EsPpQV+HaZLL5Z
	150/BU5zGhhqXkOhP0KYqz2kMenTOvoqG6V8Su2TxJSE2X8luBzoRcowfrb84NVXFCJ7UwyWE0v
	pzDr+2ZUrTaCn61OU73JFV0lQyggluXErAussQ==
X-Google-Smtp-Source: AGHT+IFQaf2/quvTqoYP56zHi7rDJ1kU/oDCjLOtAqY2CrIIfApBxqj0fRiT+qyx0t2yLBZe47FKRA==
X-Received: by 2002:a05:6000:402b:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39132db746amr7831737f8f.49.1741610440032;
        Mon, 10 Mar 2025 05:40:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2711:39c0:fb51:b639])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdc5sm14535865f8f.25.2025.03.10.05.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:40:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Mar 2025 13:40:27 +0100
Subject: [PATCH 13/15] gpio: cs5535: use new line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-gpiochip-set-conversion-v1-13-03798bb833eb@linaro.org>
References: <20250310-gpiochip-set-conversion-v1-0-03798bb833eb@linaro.org>
In-Reply-To: <20250310-gpiochip-set-conversion-v1-0-03798bb833eb@linaro.org>
To: Ray Jui <rjui@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, Michael Buesch <m@bues.ch>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=upkC0sTnirOv8jzXmgfAKpOw7VETHSI74rIvOJP9nNY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnzt24AJd+rA6oBAhfBjVrJiAiOO4rj4bvTZfgG
 LSaiIwYXbCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ87duAAKCRARpy6gFHHX
 cqFOEACetKHZ/3lXaDvu8xFsxkNP8cTKKcRF4221b90RoiJjw/dnUkAA1kFBAbNJsiuDNXhkGIH
 bjlGhxIoSV5KpWVGB8pDYH2YD1uJFHda7kXeZMoEzX0/R5mNw9qR0xwvXNy7x6nf5fdJIgwxNjR
 bEp5lAhjCw3D3VwvSmWgMzAZDKh09heJCGEw2ChM6CxyxV1SokLgFPM9LH8cqgQM0vVUwxn3Isy
 ncFXWgcMSJE68btyjRjEqs/ErRld0BpnEy+vMOa1fbLXsdk42eTsS6YVOWY2e6uLjCw7oPhhPP6
 418wKqULs3D/IMVbpfmfv5Pcr5EJz99hqm/zhjBgTdkBBe5FpOMsr0AuipkrsPq1Hj5Y5xeyt2U
 8lvDLwMF4ttEGMg3m3AUK8OMezkI21iei50FlV9shyKvqYDZ+drlPDFfy4rV+bTPhpHfEUT6CuH
 Ojq/DU1m0I1s4i9ryGQwdrLYotl4eSTY+OYXeqmuVvTOwQ6RNTf8jH3LJ4aZpfsfxCMtXilYanL
 OcY+h5dXmJ/1lxjTNoY/4pBZR7QFKX+i85Yb/zScLcILVujiCsbdKafvj43EbZh/+ATx+BIk8xp
 k4904Acu1ocjMI0Kc4CU1DfrqzPC9U4XclfcQxpOKDlsWPHnFNbeyhKgxkRuXpD2q4b7LAfdf3V
 pa2oV6E+9zRBYIA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-cs5535.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-cs5535.c b/drivers/gpio/gpio-cs5535.c
index 6da3a247614a..143d1f4173a6 100644
--- a/drivers/gpio/gpio-cs5535.c
+++ b/drivers/gpio/gpio-cs5535.c
@@ -232,12 +232,14 @@ static int chip_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return cs5535_gpio_isset(offset, GPIO_READ_BACK);
 }
 
-static void chip_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
+static int chip_gpio_set(struct gpio_chip *chip, unsigned int offset, int val)
 {
 	if (val)
 		cs5535_gpio_set(offset, GPIO_OUTPUT_VAL);
 	else
 		cs5535_gpio_clear(offset, GPIO_OUTPUT_VAL);
+
+	return 0;
 }
 
 static int chip_direction_input(struct gpio_chip *c, unsigned offset)
@@ -294,7 +296,7 @@ static struct cs5535_gpio_chip cs5535_gpio_chip = {
 		.request = chip_gpio_request,
 
 		.get = chip_gpio_get,
-		.set = chip_gpio_set,
+		.set_rv = chip_gpio_set,
 
 		.direction_input = chip_direction_input,
 		.direction_output = chip_direction_output,

-- 
2.45.2


