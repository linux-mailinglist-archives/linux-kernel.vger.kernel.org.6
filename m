Return-Path: <linux-kernel+bounces-234346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58291C578
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51891F2563D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB91CFD64;
	Fri, 28 Jun 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyIMfYI4"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826911CF3EC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598153; cv=none; b=NgLH++VThCQyT5IRSWGr0SClj8pCO1A9rbq1Ew8BxEff7F6uGqPUmoFKQFTX7GYftp0LGW5KPhg+X8pta2EvtzRNt9wmvr96xB3OT5FYClWocjvxMIs3lEhFOnMV+V+9TOP369Ey1nSoAH/ZaF1Pukn8iIaDCfggjsEB8pdkV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598153; c=relaxed/simple;
	bh=kx2w00EUkGBRq8ifttKE/WbhNNEqEK/tRx/av/kSf5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx3K8WScrIUwTA0JlPdA9wlkKPGGXfEwUuIFb7pPESFpFYx6dLZlkrZRtAQV60vtO5XHwAbuO5MI4LS3CfZMEKh9x60jqJji20US4+kwHv+YH3rkt3Z3+cGdR0cKt+D26CZ/OXyKSaDoOxr0rmaOvHJtB+5InuatoR5dwYxHu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyIMfYI4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066a4a611dso665268b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598151; x=1720202951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZZQERlIGvlDT2ctdsAJWWSJ3qbII640NDh+Pz14HqU=;
        b=hyIMfYI47wOHFwRIDoue3JH2s4rZkFA6fGfont5g2cXUP+Z5CbEbYqvTIketqc3hWX
         GNyqsZEd/tNPgMVGX/ooeMeon9RclzIFnfIUof0k6b4KryCJC7e+asnPGv3XvGE5s8y3
         TqLpp3h5hpUfafeDfNlnpBmWJPVta47Cf2tMXgBvcnzkJRRbeYTJ/6T5kZV0QYIwyKkg
         waij5xQciTbBIbQ2gXK2SNC4u6rR4SflhHu1Or3t1+F7U2Z0R56vqlpnqjMDdHb9YC7i
         poWRlu4xieVsd/lIE0RkjW/jd6aDdMbEdgGbq9fyzE3fH5dlZETmo5wCkmphqW98/6+E
         5U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598151; x=1720202951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZZQERlIGvlDT2ctdsAJWWSJ3qbII640NDh+Pz14HqU=;
        b=J2h3T/LjyGK3oZmxh5AGXz5UfE92qqrtNjet5qWYdTnnrspOpgm4+ea3mp73M5eJ6d
         MXk6SUlnUXcLwOH5LTt2AzuiRQHt4nqJ2f2t60a1++VGjMbeg2HskyOQOor6FJGOp1xe
         UxP/oW3eocuVr5S7eNvNPLi/mTMfoGnt6l8Brw4a59kH6u3/NL1WA3h7KWRitORZVoqL
         +sZ583seq5HAn1j6RoHcusDpwQmRgyia8y6U/q1crGyJ6AWdJFwM0Dce6ypfCINDJoFq
         OKEpHnygDAQl/ACyccw8dLqYRsQ+4G0DT9wc7Hn8iO1Tkd+O/+/Gxd6Ew8Xw6Re51X4+
         fWHg==
X-Forwarded-Encrypted: i=1; AJvYcCU3i2nz2rj92mC0aHVcL15kHyBED5GhyCp7L7Wy1tBlXQkny35qf4bNWIgnt826GyQlWNoGjHwufDHkhMiHCbjnF4sOcKbjb9XDxyQy
X-Gm-Message-State: AOJu0Yx9NVtDxeUVN+HoEuOaSJgI1Xm10iJbWfNQS/JI4o0ULcYQX2P2
	jIGoxxwGZKlHzMjB+gZ+skF/rjgxPkSAFnHEa1sIdFJ59TA6+M4I
X-Google-Smtp-Source: AGHT+IHkQkSp58snm0J9lMaUMbDp2cIe5JR1UZf7YHJIVSCoCLZlR/SP/vAyS5cqOgnfslds0UlWUA==
X-Received: by 2002:a05:6a20:1225:b0:1be:c7d9:ecc5 with SMTP id adf61e73a8af0-1bec7d9ef7bmr7626980637.19.1719598150756;
        Fri, 28 Jun 2024 11:09:10 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] ARM: spitz: Use software nodes to describe MMC GPIOs
Date: Fri, 28 Jun 2024 11:08:48 -0700
Message-ID: <20240628180852.1738922-9-dmitry.torokhov@gmail.com>
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

Convert Spitz to use software nodes for specifying GPIOs for the MMC.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/devices.c              | 36 +++++++++++++-----------
 arch/arm/mach-pxa/devices.h              |  1 -
 arch/arm/mach-pxa/gumstix.c              |  2 +-
 arch/arm/mach-pxa/spitz.c                | 18 +++++-------
 include/linux/platform_data/mmc-pxamci.h |  4 ++-
 5 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index e2758c94fd77..d050a4c78f97 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -48,7 +48,7 @@ struct platform_device pxa_device_pmu = {
 	.num_resources	= 1,
 };
 
-static struct resource pxamci_resources[] = {
+static const struct resource pxamci_resources[] = {
 	[0] = {
 		.start	= 0x41100000,
 		.end	= 0x41100fff,
@@ -61,22 +61,26 @@ static struct resource pxamci_resources[] = {
 	},
 };
 
-static u64 pxamci_dmamask = 0xffffffffUL;
-
-struct platform_device pxa_device_mci = {
-	.name		= "pxa2xx-mci",
-	.id		= 0,
-	.dev		= {
-		.dma_mask = &pxamci_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(pxamci_resources),
-	.resource	= pxamci_resources,
-};
-
-void __init pxa_set_mci_info(struct pxamci_platform_data *info)
+void __init pxa_set_mci_info(const struct pxamci_platform_data *info,
+			     const struct property_entry *props)
 {
-	pxa_register_device(&pxa_device_mci, info);
+	const struct platform_device_info mci_info = {
+		.name		= "pxa2xx-mci",
+		.id		= 0,
+		.res		= pxamci_resources,
+		.num_res	= ARRAY_SIZE(pxamci_resources),
+		.data		= info,
+		.size_data	= sizeof(*info),
+		.dma_mask	= 0xffffffffUL,
+		.properties	= props,
+	};
+	struct platform_device *mci_dev;
+	int err;
+
+	mci_dev = platform_device_register_full(&mci_info);
+	err = PTR_ERR_OR_ZERO(mci_dev);
+	if (err)
+		pr_err("Unable to create mci device: %d\n", err);
 }
 
 static struct pxa2xx_udc_mach_info pxa_udc_info = {
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index b7c0e138ef61..72c556ff67db 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -4,7 +4,6 @@
 struct mmp_dma_platdata;
 
 extern struct platform_device pxa_device_pmu;
-extern struct platform_device pxa_device_mci;
 extern struct platform_device pxa3xx_device_mci2;
 extern struct platform_device pxa3xx_device_mci3;
 extern struct platform_device pxa25x_device_udc;
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index b9eddc691097..efa6faa62a2c 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -90,7 +90,7 @@ static struct pxamci_platform_data gumstix_mci_platform_data = {
 
 static void __init gumstix_mmc_init(void)
 {
-	pxa_set_mci_info(&gumstix_mci_platform_data);
+	pxa_set_mci_info(&gumstix_mci_platform_data, NULL);
 }
 #else
 static void __init gumstix_mmc_init(void)
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index c79510185ce3..4720a40587f1 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -651,21 +651,17 @@ static struct pxamci_platform_data spitz_mci_platform_data = {
 	.setpower		= spitz_mci_setpower,
 };
 
-static struct gpiod_lookup_table spitz_mci_gpio_table = {
-	.dev_id = "pxa2xx-mci.0",
-	.table = {
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_nSD_DETECT,
-			    "cd", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_nSD_WP,
-			    "wp", GPIO_ACTIVE_LOW),
-		{ },
-	},
+static const struct property_entry spitz_mci_props[] __initconst = {
+	PROPERTY_ENTRY_GPIO("cd-gpios", &pxa2xx_gpiochip_node,
+			    SPITZ_GPIO_nSD_DETECT, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_GPIO("wp-gpios", &pxa2xx_gpiochip_node,
+			    SPITZ_GPIO_nSD_WP, GPIO_ACTIVE_LOW),
+	{ }
 };
 
 static void __init spitz_mmc_init(void)
 {
-	gpiod_add_lookup_table(&spitz_mci_gpio_table);
-	pxa_set_mci_info(&spitz_mci_platform_data);
+	pxa_set_mci_info(&spitz_mci_platform_data, spitz_mci_props);
 }
 #else
 static inline void spitz_mmc_init(void) {}
diff --git a/include/linux/platform_data/mmc-pxamci.h b/include/linux/platform_data/mmc-pxamci.h
index 7e44e84e7150..652f323b5ecc 100644
--- a/include/linux/platform_data/mmc-pxamci.h
+++ b/include/linux/platform_data/mmc-pxamci.h
@@ -7,6 +7,7 @@
 
 struct device;
 struct mmc_host;
+struct property_entry;
 
 struct pxamci_platform_data {
 	unsigned int ocr_mask;			/* available voltages */
@@ -18,7 +19,8 @@ struct pxamci_platform_data {
 	bool gpio_card_ro_invert;		/* gpio ro is inverted */
 };
 
-extern void pxa_set_mci_info(struct pxamci_platform_data *info);
+extern void pxa_set_mci_info(const struct pxamci_platform_data *info,
+			     const struct property_entry *props);
 extern void pxa3xx_set_mci2_info(struct pxamci_platform_data *info);
 extern void pxa3xx_set_mci3_info(struct pxamci_platform_data *info);
 
-- 
2.45.2.803.g4e1b14247a-goog


