Return-Path: <linux-kernel+bounces-234344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76891C576
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204FA286C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46CD1CF3F1;
	Fri, 28 Jun 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxyinHEQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C91CE0BA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598151; cv=none; b=Q0Q9gwl5rToctz4ToTP1R7r5SlOYJAIR/FUa5VRzAQunVPrSonAmhDdYyBd3r/TpG0WLgNZ1XchBa66NUSa2+5oQCx6JYrQPqpDOpTkfVMr7LehqD+L6xdiJbpMh0tSr6N9S2TfUWEIQvCl3+q06m3IHVGY4zzQB151pHG/bF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598151; c=relaxed/simple;
	bh=anDuepRKOPsxjBvbzbzwrrTngbIsz2SzLe9MowNxA4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVuT0nB2OIUNtcVp7R4nRFz0f1oXAkA6oSem4po3uhRFAQUhhJeHi76//W388qXJ+/pP/GclsJACZOPIGZyVvhg7GIjWW4SJ5GkoR1QMPz6LUn17xjwY0OY1PeDlCWNEFc6DlcfTOrhPYWBlm0/bkfRuvTLlAyScIgCq+88e2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxyinHEQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706b539fcaeso1467412b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598149; x=1720202949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay9TI8HWK+oR18tT8EQNVS4HczzSY9JpQeS8IURTtMg=;
        b=ZxyinHEQBTm8cG1sefWWwYr79plzHPthJVzMvBymJcmVkinXWOxuAtQ77/iH6+kkBH
         eFTfMQjsaIRqWcTqtWJorZ1OttEqrrJWsX8lyovMr9YPvJZSeKvdPHzkxUI6tu/cJzIQ
         4UwRLdGOmyxMu8ZNyiGhfXFI9L89hEZzq6da4EIXRVoUa3OD5JtOBHGzF0a05TtIgzz1
         zRVDScggp6pVGnC5jfX4ehkXuBcfqFjU3iBwBC4vJoYg9y3hkGsYwAzzya10pLDwub+x
         ZJ6vc8Th773y6jzl+61ObpVXbsxrvmfwKD2F24rHfPEn7esqThWxi1bJwSWd/OUNgQhv
         iG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598149; x=1720202949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay9TI8HWK+oR18tT8EQNVS4HczzSY9JpQeS8IURTtMg=;
        b=mGOqYz+bgtGSfSVLzm8SkVHZLG4kxhAthgcO7kN9GjNG0sA+Hd3CeTMlbsWz/PtP83
         9cM/A1PrWgJ2xwmXHdhaRu8BLmOosoho1M/iwnQ4K0n9CT3Leh5w54gRdrKtF4y1HNiB
         F6STIdSeZ++kpnvcfxIHF8RtMLxILk6DHuE63p83h2Tkl72jAuFIBppM9cQGtBOnqMhh
         8yUEP9nt7HaOvauLT31gldRsBkaY5DTolSGI4UcB/mxHEvdv7mszV5VwKUo0EV7eTChb
         kTt/xEMZWtky7Uf0LzUOidKL+aCuyl4hP1UOP4tw3eFK3G4Y3uWaX7IkkyELEP9AYNrE
         LcBg==
X-Forwarded-Encrypted: i=1; AJvYcCU+dwf62O0QZpxess2ajDZvAv6aIqY/diZyeqpI/GBOSXcHUYG3v7dbTR8Ix4892WnHSBhMvkU0jLhKyBSGg+NQpp7u5100KErxpcNf
X-Gm-Message-State: AOJu0YyAqTTo75/tJU5NgYvjvA5jb6Dopte58SyjR9oT1RpdU5eFONLg
	hq8jRB+0hQnTJOoCq8AR8rNDevI1Ygxj+T+xj0kNmdvOwuTeGI2k
X-Google-Smtp-Source: AGHT+IFUdHHXsh+kQq1MNIc7SmoyKk0Wy8cjfjvnFWozynmhMcEHlK3wZYCzHdSPBhIp8OVcAk/pbA==
X-Received: by 2002:a05:6a20:3947:b0:1bd:208a:3b20 with SMTP id adf61e73a8af0-1bee4926d26mr3662610637.14.1719598148636;
        Fri, 28 Jun 2024 11:09:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:08 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] ARM: spitz: Use software nodes to describe audio GPIOs
Date: Fri, 28 Jun 2024 11:08:46 -0700
Message-ID: <20240628180852.1738922-7-dmitry.torokhov@gmail.com>
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

Convert Spitz to use software nodes for specifying GPIOs for the audio
chip.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 66 ++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 504d04bb2df7..278d49ed7a9c 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -130,6 +130,20 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
 };
 
+static const struct software_node spitz_scoop_1_gpiochip_node = {
+	.name = "sharp-scoop.0",
+};
+
+/* Only on Spitz */
+static const struct software_node spitz_scoop_2_gpiochip_node = {
+	.name = "sharp-scoop.1",
+};
+
+/* Only on Akita */
+static const struct software_node akita_max7310_gpiochip_node = {
+	.name = "i2c-max7310",
+};
+
 /******************************************************************************
  * Scoop GPIO expander
  ******************************************************************************/
@@ -950,24 +964,24 @@ static void __init spitz_i2c_init(void)
 static inline void spitz_i2c_init(void) {}
 #endif
 
-static struct gpiod_lookup_table spitz_audio_gpio_table = {
-	.dev_id = "spitz-audio",
-	.table = {
-		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.1", 8, "mic", GPIO_ACTIVE_HIGH),
-		{ },
-	},
+static const struct property_entry spitz_audio_props[] = {
+	PROPERTY_ENTRY_GPIO("mute-l-gpios", &spitz_scoop_1_gpiochip_node, 3,
+			    GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("mute-r-gpios", &spitz_scoop_1_gpiochip_node, 4,
+			    GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("mic-gpios", &spitz_scoop_2_gpiochip_node, 8,
+			    GPIO_ACTIVE_HIGH),
+	{ }
 };
 
-static struct gpiod_lookup_table akita_audio_gpio_table = {
-	.dev_id = "spitz-audio",
-	.table = {
-		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("i2c-max7310", 2, "mic", GPIO_ACTIVE_HIGH),
-		{ },
-	},
+static const struct property_entry akita_audio_props[] = {
+	PROPERTY_ENTRY_GPIO("mute-l-gpios", &spitz_scoop_1_gpiochip_node, 3,
+			    GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("mute-r-gpios", &spitz_scoop_1_gpiochip_node, 4,
+			    GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("mic-gpios", &akita_max7310_gpiochip_node, 2,
+			    GPIO_ACTIVE_HIGH),
+	{ }
 };
 
 /******************************************************************************
@@ -975,12 +989,14 @@ static struct gpiod_lookup_table akita_audio_gpio_table = {
  ******************************************************************************/
 static inline void spitz_audio_init(void)
 {
-	if (machine_is_akita())
-		gpiod_add_lookup_table(&akita_audio_gpio_table);
-	else
-		gpiod_add_lookup_table(&spitz_audio_gpio_table);
-
-	platform_device_register_simple("spitz-audio", -1, NULL, 0);
+	struct platform_device_info audio_info = {
+		.name = "spitz-audio",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = machine_is_akita() ?
+				akita_audio_props : spitz_audio_props,
+	};
+
+	platform_device_register_full(&audio_info);
 }
 
 /******************************************************************************
@@ -1003,6 +1019,12 @@ static void spitz_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init spitz_init(void)
 {
+	software_node_register(&spitz_scoop_1_gpiochip_node);
+	if (machine_is_akita())
+		software_node_register(&akita_max7310_gpiochip_node);
+	else
+		software_node_register(&spitz_scoop_2_gpiochip_node);
+
 	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
 	pm_power_off = spitz_poweroff;
 
-- 
2.45.2.803.g4e1b14247a-goog


