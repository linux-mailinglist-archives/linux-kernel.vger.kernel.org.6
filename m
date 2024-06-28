Return-Path: <linux-kernel+bounces-234340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2391C572
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3944FB25929
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552E1CD5CE;
	Fri, 28 Jun 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhbpnaSW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146731CCCA6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598146; cv=none; b=gJYKHA1fXPxC4NdSHNMprLP+EMAR8n0us36o5GHqNoCod9ibHvZ7fcwQjInpWeXF4AqmDu0fMpbo0pAAdPeicDV37OOebOoZYIWwlaw2HsDksDcJRiHaHhrXYhBavdNK0Q5QT+EBjHcigMLZ7o4KWxQMtxa64GPlGufTYemZmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598146; c=relaxed/simple;
	bh=0JfetHvFGQKBCEIAYvXWJQH0dRz7eUH0j6VBsWHnq1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj/Vy6HCbhqHI9e2uwKqvyQrmh/xqsIRXrE0cbk4oHmLRUyC4mdjsgI+qZvmTzQym+cWHGiGlG6at3TdVONP/Wnkh2vD8ZyQXjPIy5x7sho8T/yRo9/GTpiEVrDi2XqHlIp2Z7WIDdr/0suW22DaFtN1qnC51U3xT/irqCAVaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhbpnaSW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-701b0b0be38so752038b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598144; x=1720202944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up/qg8WDCqy4xhIoMEE6lkWQO4HcB5nnKXIU51pcsyE=;
        b=GhbpnaSWlXIG2t7j4yZMSmPHrKvQFHX6ZPYpaIuKLFh1fKBStxEppt9h8gaJxZGt6h
         sqpFeW0PchjEaY9gUO0Sj1Ha3W5SnGqlrCp+A52PRIr+A4Bzp83jnhSeCd8vBTPYK18P
         mF1YzMNWol4egf6uDovz5J9NC5aCpnoyzWDih+ZJE+OB2E7v5G/w56honGf0/JOiHBB1
         U1RFOjxWajtt6nDZbrCSQ+aeja1IF2oZzi9c5PXN6bEeNxwbFKRmavjHQNn55hqqMsmn
         vJ0KK2WRy1Wcw1uanRKp1FEA66u8oANTIetCU78UhC7eDGN5JehFBiUDyZGi7MQ73z7b
         IAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598144; x=1720202944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up/qg8WDCqy4xhIoMEE6lkWQO4HcB5nnKXIU51pcsyE=;
        b=MRok/Z9PRgwGbwnLIOkLPwoMaMrkIvWyPxWsoaps7KRH4a3hpW0En/Xsu4hNNmmUyc
         X78bQ1HuBIb6ThYGvuUxk1fUPVNcYhg3dD8pjCw8fQ/4IH3AEaXMQ6yJmWeTjMzCVf7o
         f23V3QZNKgNgsaW4sK3K0WYEEcaFYA4fLFc5UmIDAbY0S55flR3f1tNRTVezp69O7+nt
         724tlptx+ibBVZs8LBSnNqonSlc3a7gh9CuXlFxm8Mu2e6ZRAbgGQMc3rL2CrOuWEHgI
         BzTCfkGdQNq9AbevlNjSzWrhejm2BOgQJ2geK2iCsJ49iVSVohjw2FaR2WtCKltr35/t
         dZog==
X-Forwarded-Encrypted: i=1; AJvYcCXy7n9yAlM7860bznH15QtCIhbBEWTFUoIjdZiKaFN3MdOf5ujj9+aSshlhouZtFHrqIAG3Q0u1p2xLlsiixznIy3gS8vdVN3RNF2Nq
X-Gm-Message-State: AOJu0YyEprjESxSF04ZZiKvVlcE9XEhE4IOESDTb2qCzijmdi4cte+JV
	ZnaDqqnHH7k/5DtIApJBZbA3Db4FkyuqunXBOO8yfDTz5Z9OfZ8b
X-Google-Smtp-Source: AGHT+IHl5Hkg3zTbLOFzM8iN/UjEZ0JCZYz7drxxPW4g1Ndh3zPD3L4duozHiDSYrQjf9NwirFH/xA==
X-Received: by 2002:a05:6a20:6a90:b0:1bd:91aa:79a0 with SMTP id adf61e73a8af0-1bd91aa7a7dmr8588298637.12.1719598144351;
        Fri, 28 Jun 2024 11:09:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:04 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ARM: pxa: consolidate GPIO chip platform data
Date: Fri, 28 Jun 2024 11:08:42 -0700
Message-ID: <20240628180852.1738922-3-dmitry.torokhov@gmail.com>
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

The platform data for the GPIO controllers for the boards using non-DT
setup is the same between PXA25x (gumstix) and PXA27x (Spitz) devices.
Move it into devices.c to consolidate code. It will help with conversion
to software nodes/properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/devices.c | 13 +++++++++++++
 arch/arm/mach-pxa/pxa25x.c  |  7 +------
 arch/arm/mach-pxa/pxa27x.c  |  8 +-------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 1e4cd502340e..7cc6db2d1615 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/gpio-pxa.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/soc/pxa/cpu.h>
 
@@ -17,6 +18,7 @@
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmp_dma.h>
 
+#include "mfp-pxa2xx.h"
 #include "regs-ost.h"
 #include "reset.h"
 #include "devices.h"
@@ -650,11 +652,19 @@ struct resource pxa_resource_gpio[] = {
 	},
 };
 
+static struct pxa_gpio_platform_data pxa2xx_gpio_info = {
+	.irq_base	= PXA_GPIO_TO_IRQ(0),
+	.gpio_set_wake	= gpio_set_wake,
+};
+
 struct platform_device pxa25x_device_gpio = {
 	.name		= "pxa25x-gpio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
 	.resource	= pxa_resource_gpio,
+	.dev		= {
+		.platform_data	= &pxa2xx_gpio_info,
+	},
 };
 
 struct platform_device pxa27x_device_gpio = {
@@ -662,6 +672,9 @@ struct platform_device pxa27x_device_gpio = {
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
 	.resource	= pxa_resource_gpio,
+	.dev		= {
+		.platform_data	= &pxa2xx_gpio_info,
+	},
 };
 
 static struct resource pxa_dma_resource[] = {
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 02712d24be82..2ab3d8d66466 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -178,12 +178,8 @@ void __init pxa25x_map_io(void)
 	pxa25x_get_clk_frequency_khz(1);
 }
 
-static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
-	.irq_base	= PXA_GPIO_TO_IRQ(0),
-	.gpio_set_wake	= gpio_set_wake,
-};
-
 static struct platform_device *pxa25x_devices[] __initdata = {
+	&pxa25x_device_gpio,
 	&pxa25x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -244,7 +240,6 @@ static int __init pxa25x_init(void)
 
 		if (!of_have_populated_dt()) {
 			pxa2xx_set_dmac_info(&pxa25x_dma_pdata);
-			pxa_register_device(&pxa25x_device_gpio, &pxa25x_gpio_info);
 			ret = platform_add_devices(pxa25x_devices,
 						   ARRAY_SIZE(pxa25x_devices));
 		}
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index d71491e2e1d6..b135b9ef665c 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -276,12 +276,8 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 	pxa_register_device(&pxa27x_device_i2c_power, info);
 }
 
-static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
-	.irq_base	= PXA_GPIO_TO_IRQ(0),
-	.gpio_set_wake	= gpio_set_wake,
-};
-
 static struct platform_device *devices[] __initdata = {
+	&pxa27x_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -345,8 +341,6 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
 		if (!of_have_populated_dt()) {
-			pxa_register_device(&pxa27x_device_gpio,
-					    &pxa27x_gpio_info);
 			pxa2xx_set_dmac_info(&pxa27x_dma_pdata);
 			ret = platform_add_devices(devices,
 						   ARRAY_SIZE(devices));
-- 
2.45.2.803.g4e1b14247a-goog


