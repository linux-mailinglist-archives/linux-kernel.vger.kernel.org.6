Return-Path: <linux-kernel+bounces-234348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A991C57A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BB41C223D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8261D0535;
	Fri, 28 Jun 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbAXL6sD"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053A1CFD63
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598155; cv=none; b=ZzvrQMP/DKadDmM1Ih7T2aWKBxSEBd+vEM9gv0bv1UX7XZob6/ny9FrML/FqIqNbSh+yl8QrbEEeA0GHpXKZJMwVwYUPaxzR6nTML9VObqVW0GuwJP09uW56CXNaoevq26hL6ptldb5HU2JCnTA/cq6mD1x4W3S9kluT5lWxKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598155; c=relaxed/simple;
	bh=nEquWj09CBDGh7TAVmDojA4lpqQnX4I5G8/DCoLB9ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDa15AD23hvzwswBj3W8+MpPFBMkQNmSOSKEbUvbLXXq6pjI5iCofRXpPWBcnXlsFkixQprKzVbb012Agpq88csqFz++rXb3nTacMpqkdJrWL6pmq5dvEyRg6BWiwbsFCWfGqYKItzMS7JPiE/svkusww63ftMgdmIhdDj7C19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbAXL6sD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7066f68e22cso745503b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598153; x=1720202953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UaptWOE/d6S6pBZfH91tBCmSGK27RbRnUptUO4PI8g=;
        b=cbAXL6sDqhl6QiNwgDGbxmRrWSjt3Z/i3qcKmQJzHSh4noR8va2VHIEuiWThE5a5A9
         czlPElgEQtLT1QJ7uTf7lRsZND5P3C+z5ZjC/l72rr2dpVrwrbGDVbmUqTJ+/cwo7DoC
         b0ayZZbis6rvq95cKo0iepMcbZjSuTA0V2a3ARE2GQIO4jRQ5V/iL2yUB5FsULQEdFK3
         SaMKrkLDApn64WPtj5/0cJHJAoO5akbTyBzEgXd6r0SdgJdLSu+T7KzayUqvV+C9snlO
         OofRiU2PKlzg8nEBJQ19jSbMxjctfa4JkC7I4o4S5yAb9n/WxM3k5Dygcqu9/X0MpHDv
         6BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598153; x=1720202953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UaptWOE/d6S6pBZfH91tBCmSGK27RbRnUptUO4PI8g=;
        b=qZBifFngBME9DYKPEU7jCprzT0rAqPK5itIeo+aVa3JUIRrRwVXbfMNPv3XS6712rg
         CxxRTCbptU3tYKin4yjMUdlTBLrvMp97Zu23Hn/3qYhZGqN19YAvgUVyhFN3gQxfaLKq
         GDjcCjZ+/AMnQ/105KvshGqDsdzEDSQgMZFn0XJkom7rwTMlyDO3DMtUqQSGiXUy8E5Z
         CyddQP4yMtc39s8zEtCLJOz1xotW/8wmwRo5JC8rKVNP9sT//K0k9lOT+RvMCC48+9h1
         dyx9SzbQ80J6Fzxb9D9qq+yxQuddTjaLPbfgW5cVhtEFSCABM74PjESKSMoFQm+k5OzH
         DFXA==
X-Forwarded-Encrypted: i=1; AJvYcCUOMkFOjBOavlKRWMZaV+0q491e8eBqatz0MwtPk/yg2Z2VJoAH4OHR2zgOhJSRWexHUZop/dNyjHQevdNQaUoue7GeF6mZsELQY+57
X-Gm-Message-State: AOJu0YxFpiGrOlnGbhmPfHZsUhkrdkjVkxsKTzO1vnT3FqLGnCLA2Vwt
	lTgd36yd2v8FzD0DHu/A2ySYqU1ENLT9kdeVAvAa0m2DEqFxU69c
X-Google-Smtp-Source: AGHT+IEo27gQsi1ZqtXMWNPG5YGN57sEOTwCgh0eIFUABFtz/d5KvfYYUSc8KC42EYmSwAdXlE8ycw==
X-Received: by 2002:a05:6a00:884:b0:705:940a:c80e with SMTP id d2e1a72fcca58-70670e7a740mr22843851b3a.3.1719598152869;
        Fri, 28 Jun 2024 11:09:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] ARM: spitz: Use software nodes for the ADS7846 touchscreen
Date: Fri, 28 Jun 2024 11:08:50 -0700
Message-ID: <20240628180852.1738922-11-dmitry.torokhov@gmail.com>
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

Convert the Spitz to use software nodes to describe GPIOs for the
ADS7846 touchscreen. As part of the conversion switch from the custom
wait_for_sync() callback to defining hsync GPIO that can be used by
the ads7846 driver to detect hsync.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 40 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b19d4ed35192..452bf7aac1fa 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -534,31 +534,23 @@ static inline void spitz_leds_init(void) {}
  * SSP Devices
  ******************************************************************************/
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static void spitz_ads7846_wait_for_hsync(void)
-{
-	while (gpio_get_value(SPITZ_GPIO_HSYNC))
-		cpu_relax();
-
-	while (!gpio_get_value(SPITZ_GPIO_HSYNC))
-		cpu_relax();
-}
 
-static struct ads7846_platform_data spitz_ads7846_info = {
-	.model			= 7846,
-	.vref_delay_usecs	= 100,
-	.x_plate_ohms		= 419,
-	.y_plate_ohms		= 486,
-	.pressure_max		= 1024,
-	.wait_for_sync		= spitz_ads7846_wait_for_hsync,
+static const struct property_entry spitz_ads7846_props[] = {
+	PROPERTY_ENTRY_STRING("compatible", "ti,ads7846"),
+	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 1024),
+	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 419),
+	PROPERTY_ENTRY_U16("ti,y-plate-ohms", 486),
+	PROPERTY_ENTRY_U16("ti,vref-delay-usecs", 100),
+	PROPERTY_ENTRY_GPIO("pendown-gpios", &pxa2xx_gpiochip_node,
+			    SPITZ_GPIO_TP_INT, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_GPIO("ti,hsync-gpios", &pxa2xx_gpiochip_node,
+			    SPITZ_GPIO_HSYNC, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
-	.dev_id = "spi2.0",
-	.table = {
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_TP_INT,
-			    "pendown", GPIO_ACTIVE_LOW),
-		{ }
-	},
+static const struct software_node spitz_ads7846_swnode = {
+	.name = "ads7846",
+	.properties = spitz_ads7846_props,
 };
 
 static const struct property_entry spitz_lcdcon_props[] = {
@@ -595,7 +587,7 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.max_speed_hz		= 1200000,
 		.bus_num		= 2,
 		.chip_select		= 0,
-		.platform_data		= &spitz_ads7846_info,
+		.swnode			= &spitz_ads7846_swnode,
 		.irq			= PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT),
 	}, {
 		.modalias		= "corgi-lcd",
@@ -638,8 +630,6 @@ static void __init spitz_spi_init(void)
 	struct platform_device *pd;
 	int err;
 
-	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
-
 	pd = platform_device_register_full(&spitz_spi_device_info);
 	err = PTR_ERR_OR_ZERO(pd);
 	if (err)
-- 
2.45.2.803.g4e1b14247a-goog


