Return-Path: <linux-kernel+bounces-370028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25FB9A261A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91E62821F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6191DE4FD;
	Thu, 17 Oct 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IDkS9FkW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E341DC747
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177725; cv=none; b=nwuRaIEXp9tQq6VGC4isMeeSvrbN+I6VYkTD5BtayvPf3TKelYaCPPhw/1RBPW+rJfb7MzU0pR8jaJeB0sax1Luy5oyFeobeqmulc12XoXqF1v9v3B+z89RLrHVA6uU4+UVHDm4ln9qCq5gixvfkDdUIa9VfvfcASU+wvXAJo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177725; c=relaxed/simple;
	bh=bYxrg/kZoAAa+n7YrhEXhQrh2GUR3qqKt0lQD9KKWFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/2eow2+EYlPq0y5KY+bz03jn3gQgGMTOXZMYlLyiE94O3MrR2REPyf9GgWQxrmJLy92k3+C3g0PHTvwAz/dswPxVDj2KyuixwhL7SPjK/e8pXcDnJkm4/j1aPRMLK4lFRwYxvYgpfKN1kWjm5cPgHQiSa7HKogR3GEuNyBpM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IDkS9FkW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4ba20075so790279f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729177717; x=1729782517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Rzm2SctSx8M+Aj5G3T9Np9fOCdYF6YWUNZMHc53Mc=;
        b=IDkS9FkWI+o11ZJMLyOYr2zKoPSqmwjILvWju+rmqa3tEsDUvlXzW1qre8leX272FE
         jRzV96vMW8ZJynx7G9HsyUjE2VwNj+DtCFceboddYe9VDvl8t5d4ml7NgOPDhqbEbh4U
         53O/CXMZ7fACyuMpvK2H+FLO1Ykld7uIkj6e43vyH9Wh6zzZxb+JwWqUyKq44duWHwhd
         +TBXwd3lbo8KiozI7gtASTSq5xM33lo3iIb419JoiZTLPCMCbWCKVDazOfLaVk98mnjx
         Mm4s5GCkFRRf1zlBg0OWFJCvU7hheaCJjvbMHA4JGudnFFigpmuFmaXSt+EFG6DoVRsy
         LPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177717; x=1729782517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Rzm2SctSx8M+Aj5G3T9Np9fOCdYF6YWUNZMHc53Mc=;
        b=OZKELBOrylf9rczmDZ7e7y9Hkf5gKcD6b52C22Cx/BCtKgIMAiJro7ilHxMcMKUD5h
         zbdGriTAT0ZmSZkhgHg2EO91DrjNfWKKUOMFK3i7vHhvJ+Pga63t0k4H367JiYvM81Bu
         tnUBCXZx1M/i/7dbExv2sN3rwS9VcEnlm5fPflMU3Q3j+dwVWZbUZN0DIkIrbUMATNQf
         PRsYcrfjhvsIvZwKqGfB83A9a07CBzMe7uvrJi7U06WvEPJKykaJcVN8ZQBfomFNh/Ve
         WZbGcyNwxkwttiSN229WTfpR0C5pm9yVZTrcQJBrTn3Opo2xy/hKuhnCqC9zx43foa7O
         WgCA==
X-Forwarded-Encrypted: i=1; AJvYcCXc9PNHehvHYoUtFUZTdtdd2DUANFjtPVPevhRrRCLMaP6taiMA0GXx+heeITcHqf6zl1wPAkLvj9oIu+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VDIyx5SmDQnq6JnvQ0yV3sdNCPK8grbPAgxZtFIlVM54UfS1
	I7NttI8NfHTVZyhczRVz4yAJHXCnIZ7pqDrz7IR49UMHeJDtJ7nnBo1iOBbfJys=
X-Google-Smtp-Source: AGHT+IH+q4HZLHosS8VQN8UfaYGSyuRYVzKPyzy0hkDMdVbG1ZXKGA7oDI6nkH6TRh0oO5d6oloNZA==
X-Received: by 2002:adf:e44c:0:b0:37d:4f1b:361 with SMTP id ffacd0b85a97d-37d551fabc4mr13795169f8f.25.1729177717395;
        Thu, 17 Oct 2024 08:08:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa882acsm7516635f8f.38.2024.10.17.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:08:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: 74x164: shrink code
Date: Thu, 17 Oct 2024 17:08:35 +0200
Message-ID: <20241017150835.105676-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use managed helpers to drop the goto label from probe() and shrink the
remove() callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-74x164.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 753e7be039e4..fca6cd2eb1dd 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -143,24 +143,17 @@ static int gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.parent = &spi->dev;
 	chip->gpio_chip.owner = THIS_MODULE;
 
-	mutex_init(&chip->lock);
+	ret = devm_mutex_init(&spi->dev, &chip->lock);
+	if (ret)
+		return ret;
 
 	ret = __gen_74x164_write_config(chip);
-	if (ret) {
-		dev_err(&spi->dev, "Failed writing: %d\n", ret);
-		goto exit_destroy;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Config write failed\n");
 
 	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
 
-	ret = gpiochip_add_data(&chip->gpio_chip, chip);
-	if (!ret)
-		return 0;
-
-exit_destroy:
-	mutex_destroy(&chip->lock);
-
-	return ret;
+	return devm_gpiochip_add_data(&spi->dev, &chip->gpio_chip, chip);
 }
 
 static void gen_74x164_remove(struct spi_device *spi)
@@ -168,8 +161,6 @@ static void gen_74x164_remove(struct spi_device *spi)
 	struct gen_74x164_chip *chip = spi_get_drvdata(spi);
 
 	gpiod_set_value_cansleep(chip->gpiod_oe, 0);
-	gpiochip_remove(&chip->gpio_chip);
-	mutex_destroy(&chip->lock);
 }
 
 static const struct spi_device_id gen_74x164_spi_ids[] = {
-- 
2.43.0


