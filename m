Return-Path: <linux-kernel+bounces-234345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57291C577
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF56FB23175
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A51C9EC6;
	Fri, 28 Jun 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jahm3RKS"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E591CF3D5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598152; cv=none; b=JLMT9m7a3OypuV7yqavbBydA2+fknIGIeD2RQyl6hWu1BhWZRdguN6ENMimIWs1rt/QBspN3C1F8bWlvqr40bsYQQ1QcfLf5BVoqjsY0YgSW4Db/uBG1u9rohrppj8xpotwCDQ/oPKrlvGG0kvyfe5NfXlk7gaNx2tS71wOgfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598152; c=relaxed/simple;
	bh=1zcd4R2lp/AHuk9JVpfb/S63amBrYlrQkTGPofwNVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQH+otLCJM5tbbHjIGydWF9jRzWpLLJMCO6MvPMkxTe9xk9zIi2s6GqM6iNIedNvYxS3YMZKS75YMJqdHn4CtLmee1VN+62Jq94o6bnucTvZjTyfInvbV+pGfc2oagxUokixRcy9W172OHbzmp4nfKVPnKA8phw/uK1Tn8V7a1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jahm3RKS; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d5666a4860so530686b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598150; x=1720202950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TES+PR3oco/zso5TBiV82fiMxzPeRQiTqnjOENaSm6Y=;
        b=Jahm3RKSKbufnKSnf+owRUrpug7OdGCOI1sPDzDWolJrhEu8vw33+XkFkFjZIr+IWF
         nhfzthGgYXIXAzG6PZMFMuy128SnKgChCeMY/nDe+K1KekaxywqH9XXl+wrIeSHOEbyk
         GJe+/cTt/3oE0uT94DjXnO9UwbQ+wLmrkvh/sA9cdyDTzqcoIsu7nWvr0QAZg+oOhvPO
         TCdB/tqT1t2/+jOKEJpFWtOEHAoi3WmU/i9FtyJcxrvqHD7gBW6+gO4t86qYq0JpZl26
         lLfp01FLCT3Vgw23ukTTnDNxXZ90H1OVN8gmlx7cD3Pi8j0FdKTnzmOA/SsvaB2q2776
         NSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598150; x=1720202950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TES+PR3oco/zso5TBiV82fiMxzPeRQiTqnjOENaSm6Y=;
        b=ZTpGrlekvQIvjWbvHM6Q5mCbl6CMRHYyXxR99kc+52QL3BlTVGlcEfciHksJy8EyGw
         ffh5nl62SQqq8xrmNbzfY7i4/zkX1nQZ7kUHCrXcAK4f19oXuRqqirLVaM2GEpi/f9CA
         1XbvWZVhRPtz08yXopIyXUNKMl5unhYI3xFOlR3g6mLZw8S4Ipy/U8Le363yB2T3xz50
         x+aYRV18K1vTNMtahDABvhplcKdJu8jpMWuJIlGTaJgL7XekBSbaWn0hH2panSXRO8BU
         ukpdc8jlUiWhRyhnmPcDVJYTC0xIrtwKkwSm/0ugDq8T0sLqwTksDQBPFqMTK7HVo9/K
         cxgg==
X-Forwarded-Encrypted: i=1; AJvYcCVNl/Z6hmSdF2WubxKhNXYCRUhjh8nJxCVazmhgCqwfhxJ0qlKFZeD/iiFNYVj60ZnduD/O9EYUm+N3uQ+us4skzAnr2eKcnQSwUGUi
X-Gm-Message-State: AOJu0Yxiv4nSKdvKHSltVTdGe6CHHkGYcflplMJveMnnJroJpckK+PIf
	E15MrRnK08ldJMIaeyIk2qNNsx1GJXFnYyQF3IKIOl7ZuLuO88Q+
X-Google-Smtp-Source: AGHT+IFbVQmOnqIXtYzrw7G3AGIcltAq/SwDu0tAxwBmNb/x6ZxkTvrB7B5PQEu7pirK0ugnnATPyg==
X-Received: by 2002:a05:6808:16a6:b0:3d2:22c6:59d3 with SMTP id 5614622812f47-3d541c50f73mr19803715b6e.6.1719598149794;
        Fri, 28 Jun 2024 11:09:09 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:09 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ARM: spitz: Use software nodes to describe LCD GPIOs
Date: Fri, 28 Jun 2024 11:08:47 -0700
Message-ID: <20240628180852.1738922-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Spitz to use software nodes for specifying GPIOs for the LCD.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 278d49ed7a9c..c79510185ce3 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -532,22 +532,24 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
 	},
 };
 
-static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
-	.dev_id = "spi2.1",
-	.table = {
-		GPIO_LOOKUP("sharp-scoop.1", 6, "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("sharp-scoop.1", 7, "BL_ON", GPIO_ACTIVE_HIGH),
-		{ },
-	},
+static const struct property_entry spitz_lcdcon_props[] = {
+	PROPERTY_ENTRY_GPIO("BL_CONT-gpios",
+			    &spitz_scoop_2_gpiochip_node, 6, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_GPIO("BL_ON-gpios",
+			    &spitz_scoop_2_gpiochip_node, 7, GPIO_ACTIVE_HIGH),
+	{ }
 };
 
-static struct gpiod_lookup_table akita_lcdcon_gpio_table = {
-	.dev_id = "spi2.1",
-	.table = {
-		GPIO_LOOKUP("i2c-max7310", 3, "BL_ON", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("i2c-max7310", 4, "BL_CONT", GPIO_ACTIVE_LOW),
-		{ },
-	},
+static const struct property_entry akita_lcdcon_props[] = {
+	PROPERTY_ENTRY_GPIO("BL_ON-gpios",
+			    &akita_max7310_gpiochip_node, 3, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("BL_CONT-gpios",
+			    &akita_max7310_gpiochip_node, 4, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static struct software_node spitz_lcdcon_node = {
+	.name = "spitz-lcdcon",
 };
 
 static struct corgi_lcd_platform_data spitz_lcdcon_info = {
@@ -572,6 +574,7 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.bus_num		= 2,
 		.chip_select		= 1,
 		.platform_data		= &spitz_lcdcon_info,
+		.swnode			= &spitz_lcdcon_node,
 	}, {
 		.modalias		= "max1111",
 		.max_speed_hz		= 450000,
@@ -606,11 +609,6 @@ static void __init spitz_spi_init(void)
 	struct platform_device *pd;
 	int err;
 
-	if (machine_is_akita())
-		gpiod_add_lookup_table(&akita_lcdcon_gpio_table);
-	else
-		gpiod_add_lookup_table(&spitz_lcdcon_gpio_table);
-
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
 
 	pd = platform_device_register_full(&spitz_spi_device_info);
@@ -619,6 +617,8 @@ static void __init spitz_spi_init(void)
 		pr_err("pxa2xx-spi: failed to instantiate SPI controller: %d\n",
 		       err);
 
+	spitz_lcdcon_node.properties = machine_is_akita() ?
+					akita_lcdcon_props : spitz_lcdcon_props;
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }
 #else
-- 
2.45.2.803.g4e1b14247a-goog


