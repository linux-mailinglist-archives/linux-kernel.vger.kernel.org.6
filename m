Return-Path: <linux-kernel+bounces-234341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309391C573
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981EDB24BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B41CE093;
	Fri, 28 Jun 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hERyvxaF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B11CD5A1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598147; cv=none; b=almI72a5GPcoFPhutI/IfyHtKN/F8jm08vGMNskrE56mo2j/4k+tLTwO+kkxEYjf4qxlv+SVHSav9WWAXbPTCRc8MjRN75g0f2PTomgGlqMRj4ea+1cSNx4kwe29UJTy3ShvXGJKx07bxcwdCNZ8m6PQlo1bqVM63L9gbhYfS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598147; c=relaxed/simple;
	bh=0olKAO9HXAhRAMVqDdhNkV31EKnRWHiB0iT1VMovycM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnGKPDIm8ZMm3tkZOW5jH6XM5cV4FWhZe6KHu3SvJyRTIDklJztTNrFYyB8ZNqV3pQNF4G0Akf3pdeGnm/aR6tvHj4zAp+pvViiBiFD8vWGjr4yhDex1bH0doR9NmHQxukRxjSw4Tfy1LBSTB2mgjZmaFBP10vnfhUf2MUZObME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hERyvxaF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-706627ff48dso704211b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598145; x=1720202945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPjL6ORxfcbcSywP6tXKN3XgBVxZ1+LizFBx1kUWvpM=;
        b=hERyvxaFOgk3HokslMa3zDQKEyznhXhBxXpoRS4Lg9ClSJKdnkmizyYKJdx0sfP9Su
         ijpR0HP+UK99XU2awXaYnsLut6AlGGGJpKNzVnYxzJnwoogElvsT/FtfNf+jxbJQ2TJK
         gyJh4nIhCOp9/K+VYTaHi0ZHbEHXforeRMc9C9G5wBRNAvJ/ekONaj4SSchIQk6+y3Nm
         eW5hOEerdXTEEPzRJi4KD9gZovg4VX9zrM9iX0sH+CDjXNtvuKjKffFkBSUeB7Mv3IAF
         DKEhOCzk1iwNWxlQQwoMbWvrAitBacSJP0EEKD2aQkBmRyXx0hsB9kzQVYCEgRhQIxBA
         B6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598145; x=1720202945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPjL6ORxfcbcSywP6tXKN3XgBVxZ1+LizFBx1kUWvpM=;
        b=Bbrk+6L2g2i2jda3yRIHRNKFabGajnYwuTSnFp45V3adprWFDPysOA9lH5S4vHSokN
         byHS2yPvaIsHb/4rN484kIHdIH9iLzN9+E4chxs28x6cXTMeoJDWsa3fu90mZxQFIlgq
         318PyWoeMrtI5CurDYzhprKUZKtKlkVpOdow84J+ZnoVYs1CkSkYcLe65AHhvcbp9q16
         S/il0Stgeb+mZrR5vznkmc4hll4X72kwBy89L9huBCDbiPweLIu5+T/Hqz2lnFkdk7MD
         OEvXMxVH3MbvGdwZBoDIAkv9EsnOAfCfWQrjMIaOWViUXHr/4xwVFgFKdyPj36ai9nSf
         2/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc9LGJHG8KxcOpieOvX7R2adw4NI3fqURaKIh+QCzzqqkoEZyfUafidOO13OGaXJUzMlZTdNBuP5xq1zIY6cEJJmjQAi/fPbcs19Zv
X-Gm-Message-State: AOJu0Yw38TrWxXe/5HhEq3WJZBOgfRiBzLRhXSTwubNOEt3vhBO9EWOR
	QLbRL1c5K764rwMrC+MCZEH5haDVbDxJTkvCb17FBx5HIfij4vF5
X-Google-Smtp-Source: AGHT+IE+8ChQtulMhadJgbwyhFCNkwINJZRVm5GvacmeQhYE8fDwdcsKKYNUc1CNoqwRvnfviNUoGQ==
X-Received: by 2002:a05:6a00:990:b0:706:750c:8dda with SMTP id d2e1a72fcca58-706750c8efcmr27072902b3a.6.1719598145501;
        Fri, 28 Jun 2024 11:09:05 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] ARM: pxa/gumstix: convert vbus gpio to use software nodes
Date: Fri, 28 Jun 2024 11:08:43 -0700
Message-ID: <20240628180852.1738922-4-dmitry.torokhov@gmail.com>
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

Switch vbus gpios from using a custom GPIO lookup table to software
properties using PROPERTY_ENTRY_GPIO() constructs which closely mimic
device tree gpio properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/devices.c |  4 ++++
 arch/arm/mach-pxa/devices.h |  4 ++--
 arch/arm/mach-pxa/gumstix.c | 22 +++++++++-------------
 arch/arm/mach-pxa/pxa25x.c  |  1 +
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 7cc6db2d1615..e2758c94fd77 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -629,6 +629,10 @@ struct platform_device pxa27x_device_pwm1 = {
 };
 #endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
 
+const struct software_node pxa2xx_gpiochip_node = {
+	.name	= "gpio-pxa",
+};
+
 struct resource pxa_resource_gpio[] = {
 	{
 		.start	= 0x40e00000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 82c83939017a..b7c0e138ef61 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -53,8 +53,8 @@ extern struct platform_device pxa_device_asoc_ssp4;
 
 extern struct platform_device pxa25x_device_gpio;
 extern struct platform_device pxa27x_device_gpio;
-extern struct platform_device pxa3xx_device_gpio;
-extern struct platform_device pxa93x_device_gpio;
+
+extern const struct software_node pxa2xx_gpiochip_node;
 
 void __init pxa_register_device(struct platform_device *dev, void *data);
 void __init pxa2xx_set_dmac_info(struct mmp_dma_platdata *dma_pdata);
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index c9f0f62187bd..b9eddc691097 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -100,26 +100,22 @@ static void __init gumstix_mmc_init(void)
 #endif
 
 #ifdef CONFIG_USB_PXA25X
-static struct gpiod_lookup_table gumstix_gpio_vbus_gpiod_table = {
-	.dev_id = "gpio-vbus",
-	.table = {
-		GPIO_LOOKUP("gpio-pxa", GPIO_GUMSTIX_USB_GPIOn,
-			    "vbus", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-pxa", GPIO_GUMSTIX_USB_GPIOx,
-			    "pullup", GPIO_ACTIVE_HIGH),
-		{ },
-	},
+static const struct property_entry spitz_mci_props[] __initconst = {
+	PROPERTY_ENTRY_GPIO("vbus-gpios", &pxa2xx_gpiochip_node,
+			    GPIO_GUMSTIX_USB_GPIOn, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("pullup-gpios", &pxa2xx_gpiochip_node,
+			    GPIO_GUMSTIX_USB_GPIOx, GPIO_ACTIVE_HIGH),
+	{ }
 };
 
-static struct platform_device gumstix_gpio_vbus = {
+static const struct platform_device_info gumstix_gpio_vbus_info __initconst = {
 	.name	= "gpio-vbus",
-	.id	= -1,
+	.id	= PLATFORM_DEVID_NONE,
 };
 
 static void __init gumstix_udc_init(void)
 {
-	gpiod_add_lookup_table(&gumstix_gpio_vbus_gpiod_table);
-	platform_device_register(&gumstix_gpio_vbus);
+	platform_device_register_full(&gumstix_gpio_vbus_info);
 }
 #else
 static void gumstix_udc_init(void)
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 2ab3d8d66466..03e34841fc00 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -239,6 +239,7 @@ static int __init pxa25x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
 		if (!of_have_populated_dt()) {
+			software_node_register(&pxa2xx_gpiochip_node);
 			pxa2xx_set_dmac_info(&pxa25x_dma_pdata);
 			ret = platform_add_devices(pxa25x_devices,
 						   ARRAY_SIZE(pxa25x_devices));
-- 
2.45.2.803.g4e1b14247a-goog


