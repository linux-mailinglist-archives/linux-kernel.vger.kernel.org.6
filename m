Return-Path: <linux-kernel+bounces-344276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F400098A7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2348B1C2347C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1D199246;
	Mon, 30 Sep 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MQnPF69R"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D71991A5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707696; cv=none; b=sbITQyFdRcB1SKIRbrVIXGSoGbtZpTXYNotWzhqP/fQgsvKe0DyVMcpB0g71Ysrh5SKnFYPOBDsTPNfNe5qZA7i+TV4oVLND8ejyYL4kRD6rfouUV63d8yIwTMy+abois0ySO69Yo/aP+sB0U4/jxy1sJcan7TW4BGdcse0+RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707696; c=relaxed/simple;
	bh=XyeXw8eHm4U0xRIzD5hFcCRVmwEbNSDv589PG5lUl74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYcN88zZF24A4q3wHlrgrEyoimKmY9vuP3DMIu86cvKzx56WT6sAkT6cKHwd+7YE7En2SAqzFUxHQwX2d2m59KqIy8+OatIQIPOMAzwnukyfFf536+ttGuGvcMWfi0cN8qdIim8GppSWBbmC7X0hy7t2LnYd4MYIdUUuy0nOOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MQnPF69R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so2964995f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727707693; x=1728312493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfRPqMQ2YRL7cytKg67BDcrJy4YgVjPhIG+hcafClNU=;
        b=MQnPF69RLDKe2DhPGAmndJgnKxSniaiyRZkyaX2Nm4adIw9A8ciIB0yIDSTg6Fyh0J
         PLZTWpe+dUaVelgYYgvzZqREeKn41hv/jBSAzQdK1GodsLqvsWFdscuH1EeeNrTURjdG
         AagOwC7biLl7CuD5VGey7U9ZgMrKRDqSvfB4rfa1HEMunu+xllnKlEDV5Ief0Kc0Ybvi
         KIBeI0pV+Pc8qRUUI4LN46qkEeDjjnbj9qYSZkCuLE5zrLxnu4KBTaDXES3rM+ULtLJ6
         IWUIEtZsDVeOXc4GKmxGAnua3fePAMhHeL54V4L5QHQKklgSWlKZVbl/sMINlChrPiJo
         0dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707693; x=1728312493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfRPqMQ2YRL7cytKg67BDcrJy4YgVjPhIG+hcafClNU=;
        b=Calb4iJHbtH+Jg6/L9xjhQZNBjqhs6N1vh5cHFSAVyjN0CmRWFHPIKABvwknddiTez
         2iGuQe7sqRjlkgRuFR+m+4xKpykCvN34X8ncVh/qJiXjqwSkeNVJ/9AqMKyTC5zJBBRQ
         GhbDG0ITWKivVLQ/m6XGHWXAAGbGdXYIscG2dyVxD6FGbgFjTrPJliWj6OZQp4tF7d6e
         jBqAcKxWM9bxSWSaPbIqERu4asIJC6eVYEhaUZJBnj04DetZoXLDKZrgk36EdfVlzwn/
         sWu+y/schfV3SNFKQybDYya1iv3lVV0dspssEroATPQU6DqpNhIvKRLDWPtRCaRbTM+k
         y9fw==
X-Forwarded-Encrypted: i=1; AJvYcCUOtmkI928dMe3cKlfvMEKnhjSFeKPv7YzDyYL5En/nibSKznRP3gJwUlGDSnN/EdqIWo8fAZb8CpjHH5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aDtiypG6OSvPsXxNPPK6FXLtSnVOlxtBG57Xr1xrpY4RMl7F
	yzcwDTwT+6Ngpq7viCxut4B/k9V1erBmu03n3V1Sc9JQxi1rOej+BvdQuuoWB0o=
X-Google-Smtp-Source: AGHT+IFS82UmXpIStxa6SqM6CC7PH3OIn3uYOLSrafHNIkj5K/JZaHIK6K+sosLECIqdEFs+/WLaOw==
X-Received: by 2002:a5d:644c:0:b0:37c:c4b4:339e with SMTP id ffacd0b85a97d-37cd5acba99mr8323137f8f.25.1727707693439;
        Mon, 30 Sep 2024 07:48:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd566a41fsm9241505f8f.45.2024.09.30.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:48:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] gpio: xilinx: use generic device properties
Date: Mon, 30 Sep 2024 16:48:04 +0200
Message-ID: <20240930144804.75068-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930144804.75068-1-brgl@bgdev.pl>
References: <20240930144804.75068-1-brgl@bgdev.pl>
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
 drivers/gpio/gpio-xilinx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index d99824d42c77..41c552a58059 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -564,7 +563,6 @@ static int xgpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct xgpio_instance *chip;
 	int status = 0;
-	struct device_node *np = dev->of_node;
 	u32 is_dual = 0;
 	u32 width[2];
 	u32 state[2];
@@ -579,7 +577,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 
 	/* First, check if the device is dual-channel */
-	of_property_read_u32(np, "xlnx,is-dual", &is_dual);
+	device_property_read_u32(dev, "xlnx,is-dual", &is_dual);
 
 	/* Setup defaults */
 	memset32(width, 0, ARRAY_SIZE(width));
@@ -587,14 +585,14 @@ static int xgpio_probe(struct platform_device *pdev)
 	memset32(dir, 0xFFFFFFFF, ARRAY_SIZE(dir));
 
 	/* Update GPIO state shadow register with default value */
-	of_property_read_u32(np, "xlnx,dout-default", &state[0]);
-	of_property_read_u32(np, "xlnx,dout-default-2", &state[1]);
+	device_property_read_u32(dev, "xlnx,dout-default", &state[0]);
+	device_property_read_u32(dev, "xlnx,dout-default-2", &state[1]);
 
 	bitmap_from_arr32(chip->state, state, 64);
 
 	/* Update GPIO direction shadow register with default value */
-	of_property_read_u32(np, "xlnx,tri-default", &dir[0]);
-	of_property_read_u32(np, "xlnx,tri-default-2", &dir[1]);
+	device_property_read_u32(dev, "xlnx,tri-default", &dir[0]);
+	device_property_read_u32(dev, "xlnx,tri-default-2", &dir[1]);
 
 	bitmap_from_arr32(chip->dir, dir, 64);
 
@@ -602,13 +600,13 @@ static int xgpio_probe(struct platform_device *pdev)
 	 * Check device node and parent device node for device width
 	 * and assume default width of 32
 	 */
-	if (of_property_read_u32(np, "xlnx,gpio-width", &width[0]))
+	if (device_property_read_u32(dev, "xlnx,gpio-width", &width[0]))
 		width[0] = 32;
 
 	if (width[0] > 32)
 		return -EINVAL;
 
-	if (is_dual && of_property_read_u32(np, "xlnx,gpio2-width", &width[1]))
+	if (is_dual && device_property_read_u32(dev, "xlnx,gpio2-width", &width[1]))
 		width[1] = 32;
 
 	if (width[1] > 32)
-- 
2.43.0


