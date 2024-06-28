Return-Path: <linux-kernel+bounces-234339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF191C571
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D5EB25838
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA351CD5AB;
	Fri, 28 Jun 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mankVIHm"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9725634
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598145; cv=none; b=YZk+sPnBpCHWXcx0VbWWHaaoLzUhVGV4NDHbQSjO0rh5b0Wennidct9B/AcDWiV1606p5x4ebtkJ6HJYOWuczwYBPhUMvZh7+fLyW+DxVeme9exymDb8RrzqYasExrm51rPzGJVIbj5Y+e8SaJqzlRWAywLj2X7zUOYSwqZFGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598145; c=relaxed/simple;
	bh=YBl3Vp7yBZBVTQv/MQDss0dcvX5XDavuIcIOOYpfHaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkWeSQZUnruH/y9ytMIz/P66Onm+a/wsTrMmQQ6/QIgeiCrjMeVgboHQPkCfUvykh9zg7YSvcZo6FwoZPQWDMNpvmH3+yKLs/ga4qQmR9nhv2qv+rfzBqdBfiqlbTlropAR435UuHBakH1YMM4irBbgN8BeABrlvtJm+DdFsYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mankVIHm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-707040e3017so640065a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598143; x=1720202943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBCvkVyfkbdo7pnt4Aoi2nCfq7+jAcbsmUlNqiZyQyk=;
        b=mankVIHmmolyM71O9cvKniMmZOssDIpc8bvLLKMbjuut0ehHVCIBVDmWkK5QVcI8Et
         BigBVWZ3h2KyUjEsa4Q4i55adCVZbnmZo1ufBpPSJMINmx5UIBC99tm8LaAVPXSY6XBd
         Iavl43yAntZ15dKymgHwo5jSGTceSgotBGOt912jjJ3JTZEwDxn3CFl+mTMvdLfa2lQq
         h8JS0hOKbaZfRR1Of+4H2j93XSunZa4vG8vkvVOBPU0C5dchGzRCxfArf0uSBAR//SXp
         prOr6YJtIqmGqHLooxTqYOhlEjkb1981G7ywj5HMfPNkEnSFVtKje4R78vkCkCxxaJzG
         0VEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598143; x=1720202943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBCvkVyfkbdo7pnt4Aoi2nCfq7+jAcbsmUlNqiZyQyk=;
        b=Pp4Ahvmv4wzlzTNTRCzd+u8gqR2ThYsU2VHLlZL/RSXpjEkEmNbYLrq8whkFWTGnDW
         oxHfJ49l+9CfpSIhAF8hhdUJIShm1AFKW1U9dDpvRorurNCQ0KCm6iQoprV55e1pQjYi
         weE5lIApVI8wycb9Hmu1/ek+uRLGpy1FulfnUy3etihzGltfRHbBXZ4oNKl/UWLhf+vG
         VfvlQgO+KFJYk5tTC6ijuriE+kBGFisyQp0YlXTphrvIoYMIwh2hdxrQCPi+RH6O2orr
         f/99FgqGctq5Lds5ZZ4+iOWpIsov9CgwT9E8GA4MWNGXzoleVy0QXu1AZ6cqYvN4yuR5
         ubeg==
X-Forwarded-Encrypted: i=1; AJvYcCVWD4J0sfDKQDPD7q5lByZx2PLdnJzwhKn0Ls7EmJb1yAFdoppiuvq4wfvo+z+oYFFgjR/m2/soAJpZJCwCkMf/gbLeeHPK/yFR+HQL
X-Gm-Message-State: AOJu0YxMvmyumH49te7lx+KYutA/LcvQ7LvgEowolZ+OTYBseGLfdlJe
	GGtbPGSUXctCOpSOpKLLQvAtwqYts6eHUJZwx3HZO3sKkGr52b7r
X-Google-Smtp-Source: AGHT+IGwdjUnAxnrdNhQ33UTdibVtsjtn7lXpV2d4m+C6E3UaoUTdQmOGIj57QB+hbO2gd1xcDLN7w==
X-Received: by 2002:a05:6a20:3ca1:b0:1be:c699:6aea with SMTP id adf61e73a8af0-1bec6996ff2mr9156618637.47.1719598143323;
        Fri, 28 Jun 2024 11:09:03 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:02 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM: spitz: fix GPIO assignment for backlight
Date: Fri, 28 Jun 2024 11:08:41 -0700
Message-ID: <20240628180852.1738922-2-dmitry.torokhov@gmail.com>
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

GPIOs controlling backlight on Spitz and Akita are coming from GPIO
expanders, not the pxa27xx-gpio block, correct it.

Additionally GPIO lookup tables operate with pin numbers rather than
legacy GPIO numbers, fix that as well. Use raw numbers instead of legacy
GPIO names to avoid confusion.

Fixes: ee0c8e494cc3 ("backlight: corgi: Convert to use GPIO descriptors")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 3c5f5a3cb480..10ab16dcd827 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -520,10 +520,8 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_BACKLIGHT_CONT,
-			    "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_BACKLIGHT_ON,
-			    "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.1", 6, "BL_CONT", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("sharp-scoop.1", 7, "BL_ON", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
@@ -531,10 +529,8 @@ static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 static struct gpiod_lookup_table akita_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_BACKLIGHT_CONT,
-			    "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_BACKLIGHT_ON,
-			    "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 3, "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 4, "BL_CONT", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -964,12 +960,9 @@ static inline void spitz_i2c_init(void) {}
 static struct gpiod_lookup_table spitz_audio_gpio_table = {
 	.dev_id = "spitz-audio",
 	.table = {
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
-			    "mute-l", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
-			    "mute-r", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.1", SPITZ_GPIO_MIC_BIAS - SPITZ_SCP2_GPIO_BASE,
-			    "mic", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.1", 8, "mic", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
@@ -977,12 +970,9 @@ static struct gpiod_lookup_table spitz_audio_gpio_table = {
 static struct gpiod_lookup_table akita_audio_gpio_table = {
 	.dev_id = "spitz-audio",
 	.table = {
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
-			    "mute-l", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
-			    "mute-r", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("i2c-max7310", AKITA_GPIO_MIC_BIAS - AKITA_IOEXP_GPIO_BASE,
-			    "mic", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 2, "mic", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
-- 
2.45.2.803.g4e1b14247a-goog


