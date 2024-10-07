Return-Path: <linux-kernel+bounces-353144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07699992962
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18831F231E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA941CC15F;
	Mon,  7 Oct 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JR2MLbZi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903671C8FD4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297659; cv=none; b=TxC2UJaNvVhdGvnwvSrQY3Ud5wJew3OIvofedmKit+vD4ZyEu9mvf4OPpObXxhMgFfsJOtMGFvYY/esjOGVn0dMs2uX+EArj0z6jL0Ue2DX7aiVluWGB+NdkiY6AW9Poj0u285kZUSNMZjFhXzpuHalBKUlY0XJZiSBMvYgrtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297659; c=relaxed/simple;
	bh=nZiIh8wnlcFC+dC0TYEiUd7EAPU85KmiRp50eWjyx7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rR/TmgtEbRHxgYGj/za35gTD6K1+PjDVb7zZORuE7DjwQbSGM/zR5JCsGrj22Ll1KHaMd7A1QNQ76Ihz7n00sUQugOBxfU09Wz2j6gPfd79sW+OlOUcXau33iK/3StaeItoSS3UUobeaaTms1McoQB5e3ex4XIF7JexYufvq1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JR2MLbZi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccd81de57so2786895f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728297656; x=1728902456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gtX24rM5dRR0MpdZIAsxYJR5vb0OJDvfm8ACG2rLjE=;
        b=JR2MLbZiFOutfBRmHFa9FEwHUax0HjnsdoqQotrMHyUyNvJD2PXdW7maYbGHVmHWrd
         zYZ5qKo6sbL2Nkog+Pl57+uDEPhlVUEDSJmgd3D/9hoU30gI03ViPiymoIvykTWR0aW5
         WSnCTbkXHCmtCBIdAVDbgpx4f+s0AxWhz6DGtMwgussWkBt8MYVCcIBTorWo3qTWMKwS
         p9fZilryPjOIgzNwFOu4HFUkWeN8AjNoVNXRShPcQmsf1FvVOw1cx6oa7Lwg1tvNi/KD
         8tbbLX8Gsxfa914fm4GKdnxINKzIXsl03ol5PlMm220k3bo1CJWId86OV+p4zzYx86Bm
         wEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728297656; x=1728902456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gtX24rM5dRR0MpdZIAsxYJR5vb0OJDvfm8ACG2rLjE=;
        b=Zye9Q8ZiGzHGU7h/dLMX8fGmUVL8yaKZWxPXocWp8cHMXs93L+mPCA2Rm9YCi2rk0D
         9YFehBHWa7TBnG9Z6buQb0QiikQTTmMj05D8HrdDv+r6zjwOuK6ZtXuaTZ/85pYp32o4
         6ulH2DxfV6KpyCkDeoeh7DWzc0xpwsXjvOnob8tOS38Rsp9pV38Ei0oLiXJgG9GYj9P5
         czXOf12YeeITUWBm1fAgF2gWqdaC0DqQLHetRcVovBD7qyCV4hUEXGcRN7MJak+5T5AS
         NdEzY72iKHtJ8sSdR8jdADWyyNH+I6sWwNxYLnMiEODfnKzAWbIi5aKLKlPZXk7xqwzL
         9vjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw7JO3ppYVYdmNAwszxlKKEzkRvQHQv9sBFI4WfIqWzwMgbNwd+eDgG46HDoVJ9DpbVaVZn5lSSU+IKog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOTDhhC45RTsXMLWLRhblmbOlID8jE28E7u5l2KP6JNoZm0SL
	H62wXwl5kgMVzrz20LXjSoZLdfghKTxCq1baUf629iXEetUOXFhisGArlLKwo6VLt92wylQ6fhv
	M
X-Google-Smtp-Source: AGHT+IGN+INg7r1OPDUzlA14lgX4GmFkJL4YfoB6G2zzkWnUEno8sj+zxEMpBokOQaUuFIDxm/83vw==
X-Received: by 2002:a5d:4904:0:b0:374:be11:22d7 with SMTP id ffacd0b85a97d-37d0f6a4f46mr6254010f8f.13.1728297655930;
        Mon, 07 Oct 2024 03:40:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690fc53sm5474682f8f.4.2024.10.07.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:40:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: ts4900: use generic device properties
Date: Mon,  7 Oct 2024 12:40:52 +0200
Message-ID: <20241007104052.39374-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no reason to use OF-specific variants of property getters.
Switch to using the preferred, generic device property helpers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4900.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index 0f6397b77c9d..5c806140fdf0 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -8,8 +8,8 @@
 
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
-#include <linux/of.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #define DEFAULT_PIN_NUMBER	32
@@ -142,7 +142,7 @@ static int ts4900_gpio_probe(struct i2c_client *client)
 	u32 ngpio;
 	int ret;
 
-	if (of_property_read_u32(client->dev.of_node, "ngpios", &ngpio))
+	if (device_property_read_u32(&client->dev, "ngpios", &ngpio))
 		ngpio = DEFAULT_PIN_NUMBER;
 
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
@@ -153,7 +153,7 @@ static int ts4900_gpio_probe(struct i2c_client *client)
 	priv->gpio_chip.label = "ts4900-gpio";
 	priv->gpio_chip.ngpio = ngpio;
 	priv->gpio_chip.parent = &client->dev;
-	priv->input_bit = (uintptr_t)of_device_get_match_data(&client->dev);
+	priv->input_bit = (uintptr_t)device_get_match_data(&client->dev);
 
 	priv->regmap = devm_regmap_init_i2c(client, &ts4900_regmap_config);
 	if (IS_ERR(priv->regmap)) {
-- 
2.43.0


