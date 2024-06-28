Return-Path: <linux-kernel+bounces-234347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDC91C579
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D621C22C60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7C1CFD78;
	Fri, 28 Jun 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLAjxYv6"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17141CFD44
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598154; cv=none; b=kfSTyjEYkPJqzyWSBeiP2ZtWHJDRtXQJktGf25vQCrX8A12T/xf6xAFkbvAKoBHc21G8Rv5Sr6/OuD5k0Vr+cZksMJVCG0tC4JTbK5KI8TWDopqL5YjIPMHsRJW1Z99kAL9aG8m0s5QZV7u/XiKwVIp3YexaqR6jLd5DPMs8YHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598154; c=relaxed/simple;
	bh=xCkAIhq6uUqRbebidLorwtSnHIaF9ApnVqjGUbpa9J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0wj/LdLfyH29QqosttyH9SVCs1oJkCwLDtVCOgSbiGh657yISaKq8/bbEqO8cAb+IwMLmAKPn/O+vP8gxfxXz0//Td7gokJg9+/Nt/BT1NaJ7KY5aRTx9nF2pfsGtsL1CHGanCra7FRsBiT/Dwy7h2Qa8JFF4b5blM8mGZ7DIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLAjxYv6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-726d9b3bcf8so785092a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598152; x=1720202952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3sk+VOjiapEEqjoqAeer5DFsWVZ6qfMsFkHqGpV/g=;
        b=RLAjxYv6IIolQQAi+bbGXF07RyChfNY/gKkIYqOcF18NPPIe3iF2//zH8ue1i5Rbr8
         sKzSlowzvfvYqYLBa1Q0SJ9Lgpka9TwGbtFKbceiHOQ9JqMUjur5TCPPkcx6jBIXJwJx
         urg+0ahnwx43TVsnNiDlvutkbl7C/p3CFXttmq/obnSbfM9VsGla4CVzLtRIuAEpVo1m
         KofaFLEfovfnP2OJTfVOjmqVWqG/EJ/0wIEvXqkiqp2CThvJwJFz1hDqfPJH5u+GAyJd
         VDkw1XSEF3Yx6e+NHn5He1lJQnbiyZ1b16G9+UkTV2ZvpyKpqXmaxLES2XTbJogPc2zr
         eayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598152; x=1720202952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG3sk+VOjiapEEqjoqAeer5DFsWVZ6qfMsFkHqGpV/g=;
        b=PhJOqNtgtpV2RJQVXAVxOcr8QRJgW/NykFKM8hGMvY8AN6kyL4qVumBzg/1zTRj+H+
         8gcC/+dwg1Ch4qAlv0g3BLwfNq3XWMrjlDhlyJLtQQfwWd6t//Q4u0HI9N3vvv44TkXg
         g8kIF3oRNQlKC7KsYYHG2RHeHZSA6Q/gJdcxAamY+y+Naaxsl902zYcN/s5JJNjzAIjb
         EJGJHGKBaJQfEd9wdXHM8gwjB5PP99UbmVJoL2MqmZT34Kf08s+KJWzHo++kbBYUedA8
         vyHdtONe1O0HIKUj8oNEVLbx4PGAS8qUuwnuJTMy5v2v1AcOXs+m82xQGawwXxwoqlj+
         WOJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+WiHgLr+/2tWoW/I0hSaN7v/6QPkZ5HVWXkvlBXbqxx3rRyYykZxqNtDRJjMPz5yL3QzFHYbo7mJZtpYpqvjRznmQIQ2n/Vm4by1
X-Gm-Message-State: AOJu0Yz4i60sNBJTfwFEk7KbLAM9DcrmZfp8O9CayZ9jl68F51IwCYCx
	3axKtd0s2ZGvxtN4VsyY3EYJkELOQwFi/VQZOop5rUKJdsh8m5+N
X-Google-Smtp-Source: AGHT+IE/uVGbMaIUFaLkhNGkXfqS8xVGatcfBWhmOGBmX0fUaCsObE8LAGJWprKosEFqJ28F7EkCSg==
X-Received: by 2002:a05:6a20:3c86:b0:1be:da68:1f26 with SMTP id adf61e73a8af0-1beda6820b8mr6390563637.59.1719598151928;
        Fri, 28 Jun 2024 11:09:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:11 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] ARM: spitz: Use software nodes to describe LED GPIOs
Date: Fri, 28 Jun 2024 11:08:49 -0700
Message-ID: <20240628180852.1738922-10-dmitry.torokhov@gmail.com>
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

Convert Spitz to use software nodes for specifying GPIOs for the LEDs.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 71 +++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 4720a40587f1..b19d4ed35192 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -467,35 +467,64 @@ static inline void spitz_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
-static struct gpio_led spitz_gpio_leds[] = {
-	{
-		.name			= "spitz:amber:charge",
-		.default_trigger	= "sharpsl-charge",
-		.gpio			= SPITZ_GPIO_LED_ORANGE,
-	},
-	{
-		.name			= "spitz:green:hddactivity",
-		.default_trigger	= "disk-activity",
-		.gpio			= SPITZ_GPIO_LED_GREEN,
-	},
+static const struct software_node spitz_gpio_leds_node = {
+	.name = "spitz-leds",
 };
 
-static struct gpio_led_platform_data spitz_gpio_leds_info = {
-	.leds		= spitz_gpio_leds,
-	.num_leds	= ARRAY_SIZE(spitz_gpio_leds),
+static const struct property_entry spitz_orange_led_props[] = {
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "sharpsl-charge"),
+	PROPERTY_ENTRY_GPIO("gpios",
+			    &spitz_scoop_1_gpiochip_node, 6, GPIO_ACTIVE_HIGH),
+	{ }
 };
 
-static struct platform_device spitz_led_device = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &spitz_gpio_leds_info,
-	},
+static const struct software_node spitz_orange_led_node = {
+	.name = "spitz:amber:charge",
+	.parent = &spitz_gpio_leds_node,
+	.properties = spitz_orange_led_props,
+};
+
+static const struct property_entry spitz_green_led_props[] = {
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "disk-activity"),
+	PROPERTY_ENTRY_GPIO("gpios",
+			    &spitz_scoop_1_gpiochip_node, 0, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node spitz_green_led_node = {
+	.name = "spitz:green:hddactivity",
+	.parent = &spitz_gpio_leds_node,
+	.properties = spitz_green_led_props,
+};
+
+static const struct software_node *spitz_gpio_leds_swnodes[] = {
+	&spitz_gpio_leds_node,
+	&spitz_orange_led_node,
+	&spitz_green_led_node,
+	NULL
 };
 
 static void __init spitz_leds_init(void)
 {
-	platform_device_register(&spitz_led_device);
+	struct platform_device_info led_info = {
+		.name	= "leds-gpio",
+		.id	= PLATFORM_DEVID_NONE,
+	};
+	struct platform_device *led_dev;
+	int err;
+
+	err = software_node_register_node_group(spitz_gpio_leds_swnodes);
+	if (err) {
+		pr_err("failed to register LED software nodes: %d\n", err);
+		return;
+	}
+
+	led_info.fwnode = software_node_fwnode(&spitz_gpio_leds_node);
+
+	led_dev = platform_device_register_full(&led_info);
+	err = PTR_ERR_OR_ZERO(led_dev);
+	if (err)
+		pr_err("failed to create LED device: %d\n", err);
 }
 #else
 static inline void spitz_leds_init(void) {}
-- 
2.45.2.803.g4e1b14247a-goog


