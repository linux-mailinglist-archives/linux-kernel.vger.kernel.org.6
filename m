Return-Path: <linux-kernel+bounces-353139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37D99294C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F411F21427
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813751CCEE6;
	Mon,  7 Oct 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CuasdO7U"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB781C7612
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297288; cv=none; b=ZaFG+Vo7pxjrVSb+HguG5RS772+Jy8kymZ46zys//Af0TJQjd25GhBEkTGvfJrtotJtZ+BSHdChVrnd1inZsWZHorLcbyc8SqdO2elIxpC2JSxAmKQSvniFUYHTlpN63wprKC7mRwt9G0NgZkGzQF3S5J/Cq3iAjlhD0NyfMEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297288; c=relaxed/simple;
	bh=SlaDyFesZTgQKQBDcA7YzZjmZ0V26ueX++PITxWWe6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baOs40D1DfZcQTRKXJV9WCKRdrwa6EW8WqT8wpHhXhpeFjDni+IkUR4srtV05/noqT7/9icDgWpMyrqyNB25a02XyfIvjCawGXckkodSNnwhAFyT1EO8FS3fPmJQ3mDdq/j56lM4mstly7WPr6JAqq2clS751e7UKKuXtdL9IYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CuasdO7U; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso2917900f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728297285; x=1728902085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V+P9/krCI5PRnaWkpVBM3gsH3UMygBswIg4oiT5dmQ=;
        b=CuasdO7UcA/kgbt5/6/rmx3vng5YYobiQvi8WnGPdtfsH2yGkwtqHhNOwqn+shiIti
         QQbj9NYl02DmJLRoFVnF8mddVSEJle6LOvIDaZSZymNQTADh9wd8PAr42BYCPWYAlXZw
         at4uNVNkPfH7vtwN3ynjBwTMexafi14JusGRkCzKMsn3UniFEQnNZfHqWQE6blCz5ofA
         qpL93FpT0fo5bbmLmKDxsc13fBmakrcu+uqbL5xf3AFTXWXHbPnxJ4GstmW2xaNQV8B7
         xJGYbW9rya2UfAySUzdfSxK9WwBG1VVW90luwiNzB15UvHTbf9Hnqd6qJNWBKPkDSClB
         aXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728297285; x=1728902085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V+P9/krCI5PRnaWkpVBM3gsH3UMygBswIg4oiT5dmQ=;
        b=EFerVOFv2ttbHww3oykxmP3vky6nMRphmcMVHjBbY3m5nrKX7/4L4RYkaL02tMiie4
         65FTsBoEPiFREzZMb8rPRAfUvH83VFSLtpwMcuO3sVxi4ChMEE+ZZOZ0hcEputO1eGcy
         O8+CF1hv0IEY3lklNjHfgzVTIKDtVydKy7v3DLv+uPYTl+2xczxLhajf7WyURlsr18nS
         CDmlHFstmLrg+CXFZsyzpjHQSnV/npEVlADCqjVCJ6VVlvZM/9DN5MV+pXNAtTFxcpx9
         AlghgdXPoNrMw3iO+mGLgNdEOUFIFU2hww1Ssa3aC1U3nX0eEPTYXLJzjWNed8ZatJc8
         jgxg==
X-Gm-Message-State: AOJu0Yy23w4z2DE5B5t0W9ZQZ+0HQS1JcArfxojBgYOS/Ub/VxVeZH5g
	mEubfcTLqIkpaDF8y+t6XxqLi7i+OF/e9BP2IZWzFkfW1JONgwhRS49hNJ5BgJM=
X-Google-Smtp-Source: AGHT+IG/u/VAP2bgAPDTl8iKAoB4INOf9h+ecMtARiYm1MEkHNdb3d3Ak/A841OAWDa1qYCK09ojcw==
X-Received: by 2002:a05:6000:ec7:b0:37c:cfeb:e612 with SMTP id ffacd0b85a97d-37d0e6caf25mr6882490f8f.1.1728297285391;
        Mon, 07 Oct 2024 03:34:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16973c2asm5423555f8f.111.2024.10.07.03.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:34:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/2] gpio: davinci: use generic device properties
Date: Mon,  7 Oct 2024 12:34:40 +0200
Message-ID: <20241007103440.38416-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007103440.38416-1-brgl@bgdev.pl>
References: <20241007103440.38416-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

OF-specific routines should not be used unless necessary. Generic device
properties are preferred so switch to using them in the driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-davinci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 1da1d7c7ac2d..8c033e8cf3c9 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -15,7 +15,6 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -159,14 +158,13 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	unsigned int ngpio, nbank, nirq, gpio_unbanked;
 	struct davinci_gpio_controller *chips;
 	struct device *dev = &pdev->dev;
-	struct device_node *dn = dev_of_node(dev);
 
 	/*
 	 * The gpio banks conceptually expose a segmented bitmap,
 	 * and "ngpio" is one more than the largest zero-based
 	 * bit index that's valid.
 	 */
-	ret = of_property_read_u32(dn, "ti,ngpio", &ngpio);
+	ret = device_property_read_u32(dev, "ti,ngpio", &ngpio);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get the number of GPIOs\n");
 	if (ngpio == 0)
@@ -177,8 +175,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	 * interrupts is equal to number of gpios else all are banked so
 	 * number of interrupts is equal to number of banks(each with 16 gpios)
 	 */
-	ret = of_property_read_u32(dn, "ti,davinci-gpio-unbanked",
-				   &gpio_unbanked);
+	ret = device_property_read_u32(dev, "ti,davinci-gpio-unbanked",
+				       &gpio_unbanked);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get the unbanked GPIOs property\n");
 
-- 
2.43.0


