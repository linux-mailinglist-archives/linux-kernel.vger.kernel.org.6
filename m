Return-Path: <linux-kernel+bounces-353226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF9992AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEB0B22C04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96B1D2700;
	Mon,  7 Oct 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JHW2tjgK"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0E1D14EC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301765; cv=none; b=C4yqFuhYGBj6AP8OM8e3BwWdm2cfieC+TQU6hDHSaOhaM2WUDCybxnN/B58/PD+gNhuQToZgiwEqep268hSUwMojRYAbXjB8jyjR8WqYRIeVV6FcUkcEzUT8QOI4Nj/UkfrBzAipdnSSkByGHeGljQIWO+HM4PxfNUrMwE7oT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301765; c=relaxed/simple;
	bh=CwpOFg4bgrjWyI+5S61q1hT+KgK4ZNfQCXjlswun6jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCKBWlEXE3tqB9TATu9+Y8ENzxIhbMbXGY3+V8ybuSGEgZgigZVCjJOK/JUCZeYB9RnpNgdwr3jhktacq+3Q+Gu/bX9tTgXdhlu1eCOlqVoM81MAWE0aVXS3jE8HLgzlcwUaTPF+RsJxST3/Gk7vFUAiE0eZtNt6wlfURYsP/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JHW2tjgK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso2894442f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728301762; x=1728906562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ1GRfK/HWDCVNGLvs5ZEQCWn2sGXdSUqplniVgccr8=;
        b=JHW2tjgKK29fB2qySkPju7KsNUOUKe6FcC3uDEelNB42/hv9j+3OihWu8dgy0yBJHG
         lSFHceTpX5ilbTS0KeNUlJ9gMEWs4jhTbK4b2S735rXHGF6aGDHfRnqY8eHk9js5cs4e
         vxjDPxItkneKZYyRLdvISXfL2sGRTegBMVxYGqXG/SI8egQoHm7fOhILABgqjZhIT6fo
         aEg/DbIIdD8weAcVDfk2QVFnNNFQVGCG0YHGKaNA1aahXO3Sh8XHaC3b2TxotU1Zwf/t
         4uyE5qxhATdEAXz2RO80N79qfXcNMRrjnOzCcE6x5olN2xMfFW50mSokwCm3v6kLy+p3
         e0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301762; x=1728906562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ1GRfK/HWDCVNGLvs5ZEQCWn2sGXdSUqplniVgccr8=;
        b=jf8XNyBrDyXgjNLR9D0tZ1DC2VJoZkiPWmppbFNfP53lliTv8gjVzsBZAy9UAWD7ju
         AsvlzJ1sMpOnI45Z1glJf7jW6PooklCAb4jHKlHahZfTwBl26ANTthd8Y14b8flOGEOD
         Z156ijUMS4x3SEuUuCGTn/S58I2dSPevIjwrpJOeQG5zjFP9LsUZvehYIFJEPtKpp03l
         QZhw0tuxhOpeRCEhXQqj4KYjxs+W5a+6U0s/2dqxFC906pv9fYW26VpdI4EhFGK+6sYK
         tuYUWys1KBqdE7sylII8KSM1zXjK2TGqrxDBKMwVRHzgrtfW2cjmOM4K3KXV8T5PUt+/
         bYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0x9WnJsDDQn7jNB521QCn6htYIuOcqSiQR2eWG0JnHkeFlQqOekC9e6GacxNSXke5v/4imR8s+JZN+uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVV7XN7KzPsDVW/UqAruPL8Fwu/BDixz5dXTze3U8CBAbwOL02
	t8v7ugEqhdNsNKCSn8y/5etfwxEW4d2i/oOWp9gBh47jjCSlOV9ZuUS39fFVO2o=
X-Google-Smtp-Source: AGHT+IEwMe0aQIiePL+driFAFg5OQweZ9DeNFvdb5Z7/K3dj+OH4I/ZCu5wOlj/zuMs5TASSSQk3rQ==
X-Received: by 2002:a5d:6b0b:0:b0:374:cea0:7d3d with SMTP id ffacd0b85a97d-37d0eae49b7mr6321283f8f.53.1728301761703;
        Mon, 07 Oct 2024 04:49:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920549sm5548261f8f.54.2024.10.07.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:49:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] mmc: davinci: use generic device_get_match_data()
Date: Mon,  7 Oct 2024 13:49:18 +0200
Message-ID: <20241007114918.52066-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007114918.52066-1-brgl@bgdev.pl>
References: <20241007114918.52066-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no reason for this driver to use the OF-specific variant so
switch to using the generic device_get_match_data() helper instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index fe7712532e84..cde4c4339ab7 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -21,9 +21,9 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 /*
  * Register Definitions
@@ -1228,7 +1228,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
-	pdev->id_entry = of_device_get_match_data(&pdev->dev);
+	pdev->id_entry = device_get_match_data(&pdev->dev);
 	if (pdev->id_entry) {
 		ret = mmc_of_parse(mmc);
 		if (ret) {
-- 
2.43.0


