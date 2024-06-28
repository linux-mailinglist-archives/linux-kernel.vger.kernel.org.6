Return-Path: <linux-kernel+bounces-234343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE82191C575
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309AEB25C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FC1CF3D9;
	Fri, 28 Jun 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abxVNaZf"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76E1CE094
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598150; cv=none; b=XHkn7D3h39qp4lgPhOQ/U1bW2HO1yGA+ACR7v01nf2uqwp7JCNqU5kuEZN3xopYSpEKac3F44lO4n3q4STRhwNIRrThHa+aFfY4m0RVnJLSlscMzY3qVJ/YUt+QkZts6MfUX/DK+eUoOTqieUHISYTmKVavVFy0yCaNku9AZThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598150; c=relaxed/simple;
	bh=rl1wjAs5QJ6h0B0kclVXLFOa9kbDihXJxFlq+OFbjlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awJAq7ch4TJNgl8kau6hbp+jXQHDB+2B+9/uSQdAMPIJgJZuNXlQkmxRY/GYpAsDoO6nk5oeQwei8P9WJNzqYQMhKa2a4YNoRM+1h8efC+7UOsVEc774X5RJ51ttxbjzcGH4D5G3HGOnEzQFPlXEE1lyYYVZBBc19x7CnHgt63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abxVNaZf; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9b94951cfso499983b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598147; x=1720202947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVMwheqA5PLjXICrqtVucOfQhWX0Fpnfz1fEEhxd/KA=;
        b=abxVNaZfz3kLKZ4LeR+2zng1f17rvLIEJuyPh0cpqOowPVu6lGVgf6Rj8bsX3fAiR4
         E8JeCa7pOIx3uWbWTGYUh0RSvG1BheB1hrtcvKn/FvmD6BYvQilrmCG48dHDNUvAk53U
         InWlOlPyQSF28rRqNxGq6zQC+Ma8GcpxMy/bj0Ww1QoXPPZB/psRczlxtl/muz4cv9Yw
         VIjfKSZz6P4xlW2qlnp/SpYr1o4icJafZrq7YmvVNM+FjJX5WpXazpX1aYaCpiqbT57n
         6+wxVw+Qt0gT2LaYQNiKvpRs8Yk427ctujNXTBYxBg7O1z6UM7vyAXLppK74gOWeS3lb
         9sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598147; x=1720202947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVMwheqA5PLjXICrqtVucOfQhWX0Fpnfz1fEEhxd/KA=;
        b=NNHO+j1GmkdDE1uBpy0zjHK5vGGiRUsNwBxQ26ACDOiro6qw8QkJmb1G1LSwe367FZ
         50IRgkw2o9IFdK3wOA/Sf/gg/PNWADdPkx5L7bFaDuaZdjHrukTtOjaqINACiFdFo4cM
         /mnATWRjREe+bi3P+xqk8Rbh474EIkHq60L+IzllMNiqrhHVloiBq8bAgqkpKdOjw3gW
         K0uiL6T6a9hLio2T23lMHKlyzdo5uq4lL+7cgK+u8swiC6tYgxylDqlPn8YUCpYnFDqF
         v+CLUVqAa0Zcd2mxjKanJy5Sv/kiWtJXbX/LA6x/DOB5oiiExoOcoT0WJ3VVunobvJoy
         9zog==
X-Forwarded-Encrypted: i=1; AJvYcCWvRSdm3XP9QVTIScrgYkpJ5lrOvMISw+orbdALVMSq1otrJyBiAArEbyHrD0OzPSxMBMRuFtIU3XbbzkBb7cz5iwEimWqWqCM99QtI
X-Gm-Message-State: AOJu0Yxtm8tC1efpNtjsfeNdzghkQTabeYstj3PO4wo06agJ1lUn8RaV
	FK62uw4DDAbvgCbT/OgjDbG3xsigYpTIKbksIJPzAqolb45EU/Fc
X-Google-Smtp-Source: AGHT+IGNZSGJXSF1ny8x7rMmOSnm4p25k/DcV8pt4n6UZoIc2gM1XH3BV8U4qDA1RrIettcCykcLqQ==
X-Received: by 2002:a05:6808:2219:b0:3d2:212e:71a0 with SMTP id 5614622812f47-3d54594bcd4mr20676903b6e.6.1719598147504;
        Fri, 28 Jun 2024 11:09:07 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] ARM: spitz: Use software nodes to describe SPI CS lines
Date: Fri, 28 Jun 2024 11:08:45 -0700
Message-ID: <20240628180852.1738922-6-dmitry.torokhov@gmail.com>
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

From: Linus Walleij <linus.walleij@linaro.org>

Convert the Spitz to use software nodes for specifying SPI CS. Because
the SPI core can figure out the number of chipselects from the number
of GPIO handles specified in properties, setting "num-cs" property is
no longer needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/pxa27x.c |  1 +
 arch/arm/mach-pxa/spitz.c  | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index b135b9ef665c..f8382477d629 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -341,6 +341,7 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
 		if (!of_have_populated_dt()) {
+			software_node_register(&pxa2xx_gpiochip_node);
 			pxa2xx_set_dmac_info(&pxa27x_dma_pdata);
 			ret = platform_add_devices(devices,
 						   ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b14eb2a54f80..504d04bb2df7 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -14,6 +14,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
@@ -28,6 +29,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/memblock.h>
 
@@ -128,7 +130,6 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
 };
 
-
 /******************************************************************************
  * Scoop GPIO expander
  ******************************************************************************/
@@ -565,18 +566,17 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
-static struct gpiod_lookup_table spitz_spi_gpio_table = {
-	.dev_id = "spi2",
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_ADS7846_CS, "cs", 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_LCDCON_CS, "cs", 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_MAX1111_CS, "cs", 2, GPIO_ACTIVE_LOW),
-		{ },
-	},
+static const struct software_node_ref_args spitz_spi_gpio_refs[] = {
+	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, SPITZ_GPIO_ADS7846_CS,
+				GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, SPITZ_GPIO_LCDCON_CS,
+				GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, SPITZ_GPIO_MAX1111_CS,
+				GPIO_ACTIVE_LOW),
 };
 
 static const struct property_entry spitz_spi_properties[] = {
-	PROPERTY_ENTRY_U32("num-cs", 3),
+	PROPERTY_ENTRY_REF_ARRAY("gpios", spitz_spi_gpio_refs),
 	{ }
 };
 
@@ -598,7 +598,6 @@ static void __init spitz_spi_init(void)
 		gpiod_add_lookup_table(&spitz_lcdcon_gpio_table);
 
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
-	gpiod_add_lookup_table(&spitz_spi_gpio_table);
 
 	pd = platform_device_register_full(&spitz_spi_device_info);
 	err = PTR_ERR_OR_ZERO(pd);
-- 
2.45.2.803.g4e1b14247a-goog


