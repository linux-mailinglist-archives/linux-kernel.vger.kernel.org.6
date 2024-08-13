Return-Path: <linux-kernel+bounces-284320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00B94FFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAC01C22733
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27013B797;
	Tue, 13 Aug 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="twMYYR8z"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3E13AD3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537663; cv=none; b=gScCP5WleQzD5t61qx6ZSJOd62HGWdxdRNV0toflAMBwlgiIScK5HJaemCOEV6AJOG5dPFG9XRqqpLHIaEVsdAr8AtWzofdV/457huXtdcSuPgaw0Vbj7p931AykC7A9klR7yVSZJF9z3kayi1byBPA4B/GQwBI8msLj7DLCiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537663; c=relaxed/simple;
	bh=mdFRkDAirghnDPIOy6KONEfVZD9BXGFjMD0EfxhiJdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGcJqU0Ia0+BlzhGz/ZR4OHVq0m0PgHhrCTW4pxPc7I57qzpqwoGunlQzbWVgiyBS12TuZr18A/TGVq2nhTcbGM7zZZzQ+mkwMfglhEKDgq2CbPQXc+RpT355CBEYzrKWeZExotKufDkckmJ63aoJq1iDM1RJQn21T2fRKip3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=twMYYR8z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso7233734e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723537658; x=1724142458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+WcU1i8Pfa7H0Uw57fEoiqtGdX8zfLORzxJutrBiD0=;
        b=twMYYR8zQOO05flMkalfXKomEAErBXUjFtkWa0idC9yCppp23a2zwgPpNoyKBc9JoY
         vuSE/JAdYObZ3EmUuHtZQ5y2PR+f93/zX6xniy92vOJtbWv8qnfSZKaqk5WQbZTdkTtI
         6KxVfDl6XsLoKkDKdYqTL+vFMuKPP9l1DYzX1JiD8t5i4vesODUiHtlOXj6I8obUGFyb
         dGXs+pBJl5PscYvOx9DTXzoM14kptQ+blty7QNiVP1gc6wyth9lhKT95Q1HD0MMaTHZ1
         G/TwIk1ZXsDrczep4NlKES/mLt5lIg5dlnMpPYgNpgBkBnONbgEyCCR/vtA2AzdltEYv
         FZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537658; x=1724142458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+WcU1i8Pfa7H0Uw57fEoiqtGdX8zfLORzxJutrBiD0=;
        b=NR3U/DcI/Ftprivzb+DRi9uJTjM6SFml31uPIq3UMY6AqxyXcwIWYWsuKfn45IPoPK
         OoQb5PKnRs+jeB8EFc1kTzAMC4lbayCVGiTDeYJ2iTRB4fhJJoSeD4uZIr0RotKvSkgR
         ZdMRM5hrlwCLecWgnFqBEJlSBpbzztqcLjE820p4UDU+JiRCDQ98ALPrNwuWuLlCmek2
         tTbF84y0ViKD45HZm+XW9wyfgyIvggJ7IkxWiNaIw9lyBjxMDOx1vx7ji6Sjqb5NhLAG
         RFtCL7kHKjMAiYacwAJsuTTnSBSv178mA2qJgTzGTk2k0DeuQONtm4LgKh2crH+O+hZT
         Cf3A==
X-Forwarded-Encrypted: i=1; AJvYcCWDlqBfuhb1jBiCoT2oi7giY50fOlMIGWVUr4RFT8cyPRzslxu/S/TCkdBovOfeH77AXRqfE3V/nko57mtjr0Kk/eGqh3krm3ef3h6k
X-Gm-Message-State: AOJu0Yw1ze8jSsIBwZlLCO6qgGAuFcGIK/iQ7CkpN1LyF5Ix650qbM7r
	vXWvPtq7tnNI0COibm2j3NabNPrUkpibkGwU62c+JI/iP7s8G98Lg4oHWROXJQn0GVhJ/SrBLH7
	RiWo=
X-Google-Smtp-Source: AGHT+IGMAfyqcznoapwAUt9cItTGv63DkeWVVnGXL12Ac4luSAMASdQbRlHZOzzQ21n7a3N4b4VP8w==
X-Received: by 2002:a05:6512:b25:b0:52c:def4:386b with SMTP id 2adb3069b0e04-532136637b3mr1972548e87.35.1723537657992;
        Tue, 13 Aug 2024 01:27:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm13865605e9.0.2024.08.13.01.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 01:27:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] ARM: davinci: remove unused cpuidle code
Date: Tue, 13 Aug 2024 10:27:35 +0200
Message-ID: <20240813082735.52402-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The cpuidle driver in mach-davinci is no longer used by anyone.
Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm/mach-davinci/Makefile        |  1 -
 arch/arm/mach-davinci/cpuidle.c       | 99 ---------------------------
 arch/arm/mach-davinci/cpuidle.h       | 15 ----
 arch/arm/mach-davinci/devices-da8xx.c |  1 -
 4 files changed, 116 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cpuidle.c
 delete mode 100644 arch/arm/mach-davinci/cpuidle.h

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 450883ea0e73..31d22a5d8e1e 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o pdata-quirks.o
 obj-y					+= da8xx-dt.o
 
 # Power Management
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_HAVE_CLK)			+= pm_domain.o
 ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pm.o sleep.o
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
deleted file mode 100644
index 78a1575c387d..000000000000
--- a/arch/arm/mach-davinci/cpuidle.c
+++ /dev/null
@@ -1,99 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU idle for DaVinci SoCs
- *
- * Copyright (C) 2009 Texas Instruments Incorporated. https://www.ti.com/
- *
- * Derived from Marvell Kirkwood CPU idle code
- * (arch/arm/mach-kirkwood/cpuidle.c)
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <asm/cpuidle.h>
-
-#include "cpuidle.h"
-#include "ddr2.h"
-
-#define DAVINCI_CPUIDLE_MAX_STATES	2
-
-static void __iomem *ddr2_reg_base;
-static bool ddr2_pdown;
-
-static void davinci_save_ddr_power(int enter, bool pdown)
-{
-	u32 val;
-
-	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
-
-	if (enter) {
-		if (pdown)
-			val |= DDR2_SRPD_BIT;
-		else
-			val &= ~DDR2_SRPD_BIT;
-		val |= DDR2_LPMODEN_BIT;
-	} else {
-		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
-	}
-
-	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
-}
-
-/* Actual code that puts the SoC in different idle states */
-static __cpuidle int davinci_enter_idle(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index)
-{
-	davinci_save_ddr_power(1, ddr2_pdown);
-	cpu_do_idle();
-	davinci_save_ddr_power(0, ddr2_pdown);
-
-	return index;
-}
-
-static struct cpuidle_driver davinci_idle_driver = {
-	.name			= "cpuidle-davinci",
-	.owner			= THIS_MODULE,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= davinci_enter_idle,
-		.exit_latency		= 10,
-		.target_residency	= 10000,
-		.name			= "DDR SR",
-		.desc			= "WFI and DDR Self Refresh",
-	},
-	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
-};
-
-static int __init davinci_cpuidle_probe(struct platform_device *pdev)
-{
-	struct davinci_cpuidle_config *pdata = pdev->dev.platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "cannot get platform data\n");
-		return -ENOENT;
-	}
-
-	ddr2_reg_base = pdata->ddr2_ctlr_base;
-
-	ddr2_pdown = pdata->ddr2_pdown;
-
-	return cpuidle_register(&davinci_idle_driver, NULL);
-}
-
-static struct platform_driver davinci_cpuidle_driver = {
-	.driver = {
-		.name	= "cpuidle-davinci",
-	},
-};
-
-static int __init davinci_cpuidle_init(void)
-{
-	return platform_driver_probe(&davinci_cpuidle_driver,
-						davinci_cpuidle_probe);
-}
-device_initcall(davinci_cpuidle_init);
-
diff --git a/arch/arm/mach-davinci/cpuidle.h b/arch/arm/mach-davinci/cpuidle.h
deleted file mode 100644
index 976d43073597..000000000000
--- a/arch/arm/mach-davinci/cpuidle.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * TI DaVinci cpuidle platform support
- *
- * 2009 (C) Texas Instruments, Inc. https://www.ti.com/
- */
-#ifndef _MACH_DAVINCI_CPUIDLE_H
-#define _MACH_DAVINCI_CPUIDLE_H
-
-struct davinci_cpuidle_config {
-	u32 ddr2_pdown;
-	void __iomem *ddr2_ctlr_base;
-};
-
-#endif
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 6939166c33c2..5e73a725d5da 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -21,7 +21,6 @@
 #include "common.h"
 #include "cputype.h"
 #include "da8xx.h"
-#include "cpuidle.h"
 #include "irqs.h"
 #include "sram.h"
 
-- 
2.43.0


