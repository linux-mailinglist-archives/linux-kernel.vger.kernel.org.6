Return-Path: <linux-kernel+bounces-313285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AB96A320
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6841C2187C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8057188921;
	Tue,  3 Sep 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bQsXSQxO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCD13F43E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378342; cv=none; b=EcrxB9g8Ks5fgNEHhd9J5zWP/1swWZkHy+ds8FJo7bcDRbkmBrUQWAywSy5ukinNbf24Ra42PNVRaMTx2RuAz1u6SxLQP7HDH6zj1bEF36sEWCPRxumpqRGtwIak73F6tadxob5i5ewCKFH+Itu9Q8UVtZGooRgE6+o8a65PxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378342; c=relaxed/simple;
	bh=744I/wZQKWyPOh5U3pqr85EuPnBBmQ6CMfkMIEazKng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0pCHnfHXjDF8fnYNYMVhov/4hNZB/7444iGv1DY7UQOdaiE73mTEDm/rdFo4kWSXqm3w8nC0keyw8zBRRyY4ZMaxxFVOLJLmJ3jFYTEXtoDiIlmhvKOcNZQtWBoAsj9JB6+SnOiOzCyaByUlAdMBkUG55vjGz7v6saF7m4FEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bQsXSQxO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso61827285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725378338; x=1725983138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1X1Xz/aK7oJBE8r6yGDDbc+O0HogrYYxQPJLz3AbE8=;
        b=bQsXSQxOWlCkGFtyu4o566SjdiDDJO2hB+5hTlSrKcammFlreehKeELKgbYDzRYKsd
         jekSM+ZTClZXENJvT/tb9mqg/bRLMVkwL6CShH19wDn8sZ9Etx+dfT5JEY2zBXUpCTbf
         GygnYjOk/zbomjqU5i3dRcl89CZ0exSpInMj8Ta87TiMg6v6frm1qCs8MzCDxokjql9T
         EOQXZYViBeTdbDwwUaBZW26vBtu6c2nIk3BwqA12LXUzIQF+bemYzHSpVHOL3emBtcKG
         LXMd+ZRm8nmfuow/I8OPJsnuYcecqS2LvoRVedL+zFq8kBGHKL99Mpyec48a31RCQDvl
         gZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378338; x=1725983138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1X1Xz/aK7oJBE8r6yGDDbc+O0HogrYYxQPJLz3AbE8=;
        b=egK84/QlkT7r6/0ZqgbdbBBMD86gOMsqwWW7VuErhBW9rgBidMPaGInPYBLH28Sybu
         3T/fiFcH7TurlhVNCXmtypci9weQRdtmFEiSLmU8zixx77ITFCUWTbRicpU39+O07g2c
         TTDKy6y953mxgyCmjKwPjJONoiYjf7OVDZc7i8xL390bOl6O5pWYrru2FZ/lSJOs1iy8
         hOdZBRszFv+nkGGUiOhv7t36GUgPfX+Ub7ZKCmzQO8umdG+c68R3d3hlQ8gC9Dte2kdO
         sPw99K+cLB0mevO6WcFnCAHCao18RBgxJMDkg9Y8ZqzDMjuno6YbCie2U0hiBt+9pCzQ
         NCZw==
X-Forwarded-Encrypted: i=1; AJvYcCW/D8xVA761GkTBIsrW2rarLOl5DitjXwGC5vUDkwZsWQiR+4c4E8nsSztgRa11fy/1VEm9gRGnoaDIAx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwyJqbXR/Mpqd26X8eroD2hTYE8jpKStO9Lm0cG69K+jTom2+
	Q04O9QZYf0EKddS6GhqAv55F6LNYH9KiEshRDUZsIeOrclp0gPO1RPVip2Pa2aE=
X-Google-Smtp-Source: AGHT+IEhqzjHoaNT2CAv83hbKqh3ToB731ohp4V6Jef3U2B0Y2zPUAXgLnFnUptFhMGoznfvj2kLyg==
X-Received: by 2002:a05:600c:5102:b0:426:690d:d5b7 with SMTP id 5b1f17b1804b1-42bb01ee5b3mr159410145e9.25.1725378337695;
        Tue, 03 Sep 2024 08:45:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6a50:a260:3846:9065])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a42sm172256465e9.11.2024.09.03.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:45:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Martyn Welch <martyn.welch@collabora.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: mpc8xxx: switch to using DEFINE_RUNTIME_DEV_PM_OPS()
Date: Tue,  3 Sep 2024 17:45:33 +0200
Message-ID: <20240903154533.101258-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903154533.101258-1-brgl@bgdev.pl>
References: <20240903154533.101258-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the preferred API for assigning system sleep pm callbacks in drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mpc8xxx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index e084e08f54387..edb228d9af277 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -431,30 +432,28 @@ static void mpc8xxx_remove(struct platform_device *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
-static int mpc8xxx_suspend(struct platform_device *pdev, pm_message_t state)
+static int mpc8xxx_suspend(struct device *dev)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = platform_get_drvdata(pdev);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = dev_get_drvdata(dev);
 
-	if (mpc8xxx_gc->irqn && device_may_wakeup(&pdev->dev))
+	if (mpc8xxx_gc->irqn && device_may_wakeup(dev))
 		enable_irq_wake(mpc8xxx_gc->irqn);
 
 	return 0;
 }
 
-static int mpc8xxx_resume(struct platform_device *pdev)
+static int mpc8xxx_resume(struct device *dev)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = platform_get_drvdata(pdev);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = dev_get_drvdata(dev);
 
-	if (mpc8xxx_gc->irqn && device_may_wakeup(&pdev->dev))
+	if (mpc8xxx_gc->irqn && device_may_wakeup(dev))
 		disable_irq_wake(mpc8xxx_gc->irqn);
 
 	return 0;
 }
-#else
-#define mpc8xxx_suspend NULL
-#define mpc8xxx_resume NULL
-#endif
+
+static DEFINE_RUNTIME_DEV_PM_OPS(mpc8xx_pm_ops, mpc8xxx_suspend,
+				 mpc8xxx_resume, NULL);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id gpio_acpi_ids[] = {
@@ -467,12 +466,11 @@ MODULE_DEVICE_TABLE(acpi, gpio_acpi_ids);
 static struct platform_driver mpc8xxx_plat_driver = {
 	.probe		= mpc8xxx_probe,
 	.remove_new	= mpc8xxx_remove,
-	.suspend	= mpc8xxx_suspend,
-	.resume		= mpc8xxx_resume,
 	.driver		= {
 		.name = "gpio-mpc8xxx",
 		.of_match_table	= mpc8xxx_gpio_ids,
 		.acpi_match_table = ACPI_PTR(gpio_acpi_ids),
+		.pm = pm_sleep_ptr(&mpc8xx_pm_ops),
 	},
 };
 
-- 
2.43.0


