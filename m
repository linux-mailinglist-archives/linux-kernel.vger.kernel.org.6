Return-Path: <linux-kernel+bounces-363686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AA99C5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5661C2255E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73165156227;
	Mon, 14 Oct 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w8/AEkM8"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CE1BC58
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898153; cv=none; b=qPJ8AhCuP93dXpmUql1ZR2x5JAG1dKsuKatNJ4wdacvOPPE45hB3aBFliHKcLEQnrc3zB2hL6Q2NkdgjpWpmiZ7+ri0CfhTvAztmX/8qcRKOHyp0ljd+fi6vctCzzjzLcslRPchemyWPNqzmVTdS1n6zezOLA49Ev47DGYuCeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898153; c=relaxed/simple;
	bh=WLA9L9pdv3sxmXcLYM9Ypg7L2IaBx3L9nrYm4gJtSHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrvlvYFaMvmwBGeaZjmwmd8HgOkxctAX7DA/MTldxVJxzmbNRwkx7BB7sAMJ2Xs+WvdY27H4vcQ1mN87NpnvqO/wizhZNV01S4Jp0+TCIxUFBVqtXSWXQZpe0FuNmwdKG2kFyaQ08q+J2RWoXMKNCJQpMdIVMkezFIUaLTLnKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w8/AEkM8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2629648f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728898151; x=1729502951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iT0S1elQH6COXcV2ZCabsoooWG/D7LPeGbtOThLu/1I=;
        b=w8/AEkM848+g97QzL4DQjj4ZC4LVMYMYtdJ/FVrxvBM5Kqa8PR9+nF7vOVq3OAcNk9
         LAFOlpFrc/xMIFQy9TVHJscIAzO2umV6913c/7SrE2Yi979rxRLnOoBGij7zITtC+WQE
         tY0LpiaCBtyWlaanEXsEMuvYH24gBwo2nrE+SRHmkozh7XKm1P64qR7OZz3UCqH2YBlv
         dTMqevvVOUoA7ho45NKtgt339C7SlXSTXVZVcHyPVzEqSt7nvsX/a5WfmGSwqL5+ZnR+
         S54gjD2Ng45AiBSIHWwil1mAf7WGWctERx1cVxgURZJNlrBLiN9BIL/kM1Ym2nAIVRzY
         DJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898151; x=1729502951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iT0S1elQH6COXcV2ZCabsoooWG/D7LPeGbtOThLu/1I=;
        b=uFlpsm1+9muWktUJalckxfCnN4ZOIn0u45+gWWHtfS5mfq799TUnNWqeUBH6cLNFmC
         vgecJdnTCf49iKRgY1HLWQILEGsYCRdiU+5FwPwLgbLLE+DIRX6axksKTxwbSCrVDPlk
         1pO3spaTiozTrZLRnHRGpixZrJwOco11hx0ih0qOOG0/VDGTf4iR9v+gDOCSy3Uh7dAy
         iYoQtbTxWQ8JXdLbt1LHm5teC2sTnboxFhYWtJ73weiQTt9awHSGSazSwnlwhpVo4ar1
         EspG7NqsMghmOs9/fHqRE5zbA4HTncZVWiAjslVxHdS7/nch72nI8e/IxZlgySV3jL09
         KSaA==
X-Forwarded-Encrypted: i=1; AJvYcCV+5ZiBjvMdMjx6Iu6HS4JEV8bFjQGWo67qMuMxOqmh7PRypAu8LsRxoBfLXnQsCAf+fgk/uxywR0qRlSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJzmhiaBJGV7/Bl3NrlmIvrIAfNX+QYiDK6k+zDahz6LwnHNq
	/E2WvkuvEvsikBiK97HTjBJl9h2un3uRDVMjFoPwSpmiB2TWLt0yO/fhHN+1J7I=
X-Google-Smtp-Source: AGHT+IF52oSlvv3yB48bMA6zpJaOLlCUS9OYV+iikvcgWp6N41ZQRFgI8YhtZ53eiXef8MY7Ayvvjg==
X-Received: by 2002:adf:f38b:0:b0:37d:3541:5643 with SMTP id ffacd0b85a97d-37d552cb091mr6799074f8f.51.1728898150556;
        Mon, 14 Oct 2024 02:29:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee49bsm10875384f8f.100.2024.10.14.02.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:29:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: amdpt: remove remove()
Date: Mon, 14 Oct 2024 11:29:09 +0200
Message-ID: <20241014092909.90607-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the managed variant of gpiochip_add_data() and remove the remove()
callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-amdpt.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 0a2ea9db4682..b70036587d9c 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -106,7 +106,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	pt_gpio->gc.free             = pt_gpio_free;
 	pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
 
-	ret = gpiochip_add_data(&pt_gpio->gc, pt_gpio);
+	ret = devm_gpiochip_add_data(dev, &pt_gpio->gc, pt_gpio);
 	if (ret) {
 		dev_err(dev, "Failed to register GPIO lib\n");
 		return ret;
@@ -122,13 +122,6 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void pt_gpio_remove(struct platform_device *pdev)
-{
-	struct pt_gpio_chip *pt_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&pt_gpio->gc);
-}
-
 static const struct acpi_device_id pt_gpio_acpi_match[] = {
 	{ "AMDF030", PT_TOTAL_GPIO },
 	{ "AMDIF030", PT_TOTAL_GPIO },
@@ -143,7 +136,6 @@ static struct platform_driver pt_gpio_driver = {
 		.acpi_match_table = ACPI_PTR(pt_gpio_acpi_match),
 	},
 	.probe = pt_gpio_probe,
-	.remove_new = pt_gpio_remove,
 };
 
 module_platform_driver(pt_gpio_driver);
-- 
2.43.0


