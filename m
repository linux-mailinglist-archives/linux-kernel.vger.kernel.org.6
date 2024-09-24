Return-Path: <linux-kernel+bounces-336577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C4983CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A40B21D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11253373;
	Tue, 24 Sep 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D50YWglt"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA58063C;
	Tue, 24 Sep 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157917; cv=none; b=r2t6bhN9c/llYMeIz1e4pspUtgXDJDiKVNvlQksySmOI46ZWapeWBhdPNE3WrG9HlEgKYB97Jm4rg65WpDVl29RGSaBD1fga2FxXuuZusYVNChrAMNm259Q2+q0TIFRwhM6wy0A4AHMGQS9t/fkZ+RG8M1yAQPoTINJT2y7q44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157917; c=relaxed/simple;
	bh=RrOkY5/pGdg6idRlDIteI497S2pIK4FVkiRK5a1RPEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z36gO7tD7/8EEZWtO6tDK5Ak738LNDfJ6rGb17QCHEf59I4leRg/YLhsGByOUNgzI6MeMMLJXtK7C6btL4Owm2lZ4PZYTXaFOTvx4IRH2c+KQ0HOkfeI89lXLxiHWVE7L8nW9jEgTvB/sEdGiB9EHZJQ/j3Ppbhk1OmtbdQlO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D50YWglt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso4198630a91.0;
        Mon, 23 Sep 2024 23:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727157915; x=1727762715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+pg2Atz65JX+fd/Upr8BHJygQ9vmYJBNYP444GSXAI=;
        b=D50YWgltQBe1vNf6dZOoFb5S7sbrQLPgMQGmt4EwSxNHkdZswXa2vDhcKGnSk9oBtB
         XA6K2t3WpSOATr9C1EgZY7VHz4jejlrPZap9SbJiKUBT0nfmpK4XoynXiPfR9q5tPSjx
         tZgOOfGaVlUNfgpvOCstwmbIKcdR2Rnx1hhqofWUUmCedg/cUdTKM1VOeqQnUX74oyYb
         qeqNxKbDXWQNxA9Wi4KfJFBhpG0nXHbaFyFfVi5fY6B0YLZOLfVhF6M9SohoBadyFq1w
         eTRdZEMTqbwIvhKOwkHgJ4VkTMIWoGfX5fDipzEk/2r4h1TQxCX/exliURvuF8JP4C8/
         ZOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727157915; x=1727762715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+pg2Atz65JX+fd/Upr8BHJygQ9vmYJBNYP444GSXAI=;
        b=k56vM26SKe+Ujy3Iky4+oqmH3qWENGhzF9MbI2tVSb+sDT49NRKFIM64hY8Po7UEZx
         tEjK5kJ+McHrhvSWhmY7b6M7REZ1WsWM2Q3pj4+fxMAZohdS8QpqZuZV7jQ0jfGBhlzt
         OCMTL+ZPZP6H5OsP+fQPqkMzu2yPNV26foZLPWrUaWnvOBvxZmjzVhhJaTa3iask3OfT
         wksqIvQDakkDTzMkXbHaRm3kgDgFzFjzluxCV0vHeAXVpTmsj8/GHbLtvjVwu8NeXmUP
         WY70EbrIg31UZC/YjD4T30AzWQBThjL0TJWDU6dYIUZVJp/LtfGxrm9GGfpN09qPpRoE
         sHTg==
X-Forwarded-Encrypted: i=1; AJvYcCXpc7WqckveeLJBiCjJ3mw74DNqpPxVr0mJhh3foycy+tXmQKIiMw5xz8JNyKhP8pQzUqCK31twDUIQH14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJavX0i4pYP+Hs+4gc1JMjVIceA+gqLNPUcNbLNLMe6hEuXmwI
	X/Bty3MbVkTrgLkpLyRyRl2JlRDImtRyR/Ud9pwhx3nSXbN02b5b
X-Google-Smtp-Source: AGHT+IEceFZzIi3n/RITgks58HjUDivSe3Anu/iRufdOL4BO6WxZlA8lC3pwICFE1GrMAnoKspAjQg==
X-Received: by 2002:a17:90b:524f:b0:2d8:84df:fa0a with SMTP id 98e67ed59e1d1-2dd7f5c10acmr18239124a91.32.1727157914769;
        Mon, 23 Sep 2024 23:05:14 -0700 (PDT)
Received: from localhost ([188.253.115.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef95ad9sm10364641a91.56.2024.09.23.23.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:05:13 -0700 (PDT)
From: Junhui Liu <liujh2818@gmail.com>
X-Google-Original-From: Junhui Liu <liujh2818@outlook.com>
Date: Tue, 24 Sep 2024 14:00:41 +0800
Subject: [PATCH 2/2] reset: canaan: Add reset driver for Kendryte K230
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-k230-reset-v1-2-d0cdc11989eb@outlook.com>
References: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
In-Reply-To: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <liujh2818@outlook.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727157904; l=13262;
 i=liujh2818@outlook.com; s=20240831; h=from:subject:message-id;
 bh=YetNdoTFI/ZkZXdVqDmDT/X/UMYcmS7kp1DoQoZCSRA=;
 b=xa58k/MnfDMBxdnoV/yBetXGrDfN/GDSNwWcs/EurD7i/I02l2gpNEwPEXGvr/KA5iAexXLGU
 HITET3kobXBCIk6DVft1r5SvhcEquKeLwiBSc+hvnmpzJOgcyGmL+PS
X-Developer-Key: i=liujh2818@outlook.com; a=ed25519;
 pk=UPJ4WEhX1Oe+1ABSe4UlisQyfljdECO+XeTLv1VxTuY=

From: Junhui Liu <liujh2818@outlook.com>

Add support for the resets on Canaan Kendryte K230 SoC.

Signed-off-by: Junhui Liu <liujh2818@outlook.com>
---
 drivers/reset/Kconfig      |   8 ++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-k230.c | 321 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5484a65f66b95374e25bac31f539a2dd92ae007e..716c676e9b934dd3d2b1ee28f2c43ef38daf7dba 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -133,6 +133,14 @@ config RESET_K210
 	  Say Y if you want to control reset signals provided by this
 	  controller.
 
+config RESET_K230
+	bool "Reset controller driver for Canaan Kendryte K230 SoC"
+	depends on (ARCH_CANAAN || COMPILE_TEST) && OF
+	help
+	  Support for the Canaan Kendryte K230 RISC-V SoC reset controller.
+	  Say Y if you want to control reset signals provided by this
+	  controller.
+
 config RESET_LANTIQ
 	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
 	default SOC_TYPE_XWAY
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4411a2a124d7de29808fcf36d0829393fc79af72..f02c35607ba88947e868d33ead70e9ec91a85636 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_K210) += reset-k210.o
+obj-$(CONFIG_RESET_K230) += reset-k230.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
diff --git a/drivers/reset/reset-k230.c b/drivers/reset/reset-k230.c
new file mode 100644
index 0000000000000000000000000000000000000000..9c693e1cee35dd725bebb6916002f846e8b4003b
--- /dev/null
+++ b/drivers/reset/reset-k230.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2017 Linaro Ltd.
+ * Copyright (C) 2022-2024 Canaan Bright Sight Co., Ltd
+ * Copyright (C) 2024 Junhui Liu <liujh2818@outlook.com>
+ */
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <dt-bindings/reset/canaan,k230-rst.h>
+
+/**
+ * enum k230_rst_type - K230 reset types
+ * @RST_TYPE_CPU0: Reset type for CPU0
+ *	Automatically clears, has write enable and done bit, active high
+ * @RST_TYPE_CPU1: Reset type for CPU1
+ *	Manually clears, has write enable and done bit, active high
+ * @RST_TYPE_FLUSH: Reset type for CPU L2 cache flush
+ *	Automatically clears, has write enable, no done bit, active high
+ * @RST_TYPE_HW_DONE: Reset type for hardware auto clear
+ *	Automatically clears, no write enable, has done bit, active high
+ * @RST_TYPE_SW_DONE: Reset type for software manual clear
+ *	Manually clears, no write enable and done bit,
+ *	active high if ID is RST_SPI2AXI, otherwise active low
+ */
+enum k230_rst_type {
+	RST_TYPE_CPU0 = 0,
+	RST_TYPE_CPU1,
+	RST_TYPE_FLUSH,
+	RST_TYPE_HW_DONE,
+	RST_TYPE_SW_DONE,
+};
+
+struct k230_rst_map {
+	u32			offset;
+	enum k230_rst_type	type;
+	u32			done;
+	u32			reset;
+};
+
+struct k230_rst {
+	struct reset_controller_dev	rcdev;
+	struct device			*dev;
+	void __iomem			*base;
+	spinlock_t			lock;
+};
+
+static const struct k230_rst_map k230_resets[] = {
+	[RST_CPU0]		= { 0x4,  RST_TYPE_CPU0,    BIT(12), BIT(0) },
+	[RST_CPU1]		= { 0xc,  RST_TYPE_CPU1,    BIT(12), BIT(0) },
+	[RST_CPU0_FLUSH]	= { 0x4,  RST_TYPE_FLUSH,   0,       BIT(4) },
+	[RST_CPU1_FLUSH]	= { 0xc,  RST_TYPE_FLUSH,   0,       BIT(4) },
+	[RST_AI]		= { 0x14, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_VPU]		= { 0x1c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_HS]		= { 0x2c, RST_TYPE_HW_DONE, BIT(4),  BIT(0) },
+	[RST_HS_AHB]		= { 0x2c, RST_TYPE_HW_DONE, BIT(5),  BIT(1) },
+	[RST_SDIO0]		= { 0x34, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SDIO1]		= { 0x34, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_SDIO_AXI]		= { 0x34, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
+	[RST_USB0]		= { 0x3c, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_USB1]		= { 0x3c, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_USB0_AHB]		= { 0x3c, RST_TYPE_HW_DONE, BIT(30), BIT(0) },
+	[RST_USB1_AHB]		= { 0x3c, RST_TYPE_HW_DONE, BIT(31), BIT(1) },
+	[RST_SPI0]		= { 0x44, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SPI1]		= { 0x44, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_SPI2]		= { 0x44, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
+	[RST_SEC]		= { 0x4c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_PDMA]		= { 0x54, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SDMA]		= { 0x54, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_DECOMPRESS]	= { 0x5c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_SRAM]		= { 0x64, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SHRM_AXIM]		= { 0x64, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
+	[RST_SHRM_AXIS]		= { 0x64, RST_TYPE_HW_DONE, BIT(31), BIT(3) },
+	[RST_NONAI2D]		= { 0x6c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_MCTL]		= { 0x74, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_ISP]		= { 0x80, RST_TYPE_HW_DONE, BIT(29), BIT(6) },
+	[RST_ISP_DW]		= { 0x80, RST_TYPE_HW_DONE, BIT(28), BIT(5) },
+	[RST_DPU]		= { 0x88, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_DISP]		= { 0x90, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_GPU]		= { 0x98, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_AUDIO]		= { 0xa4, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_TIMER0]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(0) },
+	[RST_TIMER1]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_TIMER2]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(2) },
+	[RST_TIMER3]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(3) },
+	[RST_TIMER4]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(4) },
+	[RST_TIMER5]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(5) },
+	[RST_TIMER_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(6) },
+	[RST_HDI]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(7) },
+	[RST_WDT0]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(12) },
+	[RST_WDT1]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(13) },
+	[RST_WDT0_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(14) },
+	[RST_WDT1_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(15) },
+	[RST_TS_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(16) },
+	[RST_MAILBOX]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(17) },
+	[RST_STC]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(18) },
+	[RST_PMU]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(19) },
+	[RST_LS_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(0) },
+	[RST_UART0]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_UART1]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(2) },
+	[RST_UART2]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(3) },
+	[RST_UART3]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(4) },
+	[RST_UART4]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(5) },
+	[RST_I2C0]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(6) },
+	[RST_I2C1]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(7) },
+	[RST_I2C2]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(8) },
+	[RST_I2C3]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(9) },
+	[RST_I2C4]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(10) },
+	[RST_JAMLINK0_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(11) },
+	[RST_JAMLINK1_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(12) },
+	[RST_JAMLINK2_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(13) },
+	[RST_JAMLINK3_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(14) },
+	[RST_CODEC_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(17) },
+	[RST_GPIO_DB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(18) },
+	[RST_GPIO_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(19) },
+	[RST_ADC]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(20) },
+	[RST_ADC_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(21) },
+	[RST_PWM_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(22) },
+	[RST_SHRM_APB]		= { 0x64, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_CSI0]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(0) },
+	[RST_CSI1]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_CSI2]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(2) },
+	[RST_CSI_DPHY]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(3) },
+	[RST_ISP_AHB]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(4) },
+	[RST_M0]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(7) },
+	[RST_M1]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(8) },
+	[RST_M2]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(9) },
+	[RST_SPI2AXI]		= { 0xa8, RST_TYPE_SW_DONE, 0,       BIT(0) }
+};
+
+#define to_k230_rst(p) container_of((p), struct k230_rst, rcdev)
+
+static void k230_rst_clear_done(struct k230_rst *rstc, unsigned long id,
+				bool write_en)
+{
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&rstc->lock, flags);
+
+	reg = readl(rstc->base + rmap->offset);
+
+	/* write 1 to clear */
+	reg |= rmap->done;
+	if (write_en)
+		reg |= rmap->done << 16;
+
+	writel(reg, rstc->base + rmap->offset);
+
+	spin_unlock_irqrestore(&rstc->lock, flags);
+}
+
+static int k230_rst_wait_and_clear_done(struct k230_rst *rstc, unsigned long id,
+					bool write_en)
+{
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	u32 reg;
+	int ret;
+
+	ret = readl_poll_timeout(rstc->base + rmap->offset, reg,
+				 reg & rmap->done, 10, 1000);
+	if (ret) {
+		dev_err(rstc->dev, "Wait for reset done timeout\n");
+		return ret;
+	}
+
+	k230_rst_clear_done(rstc, id, write_en);
+
+	return 0;
+}
+
+static void k230_rst_update(struct k230_rst *rstc, unsigned long id,
+			    bool assert, bool write_en, bool active_low)
+{
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&rstc->lock, flags);
+
+	reg = readl(rstc->base + rmap->offset);
+
+	if (assert ^ active_low)
+		reg |= rmap->reset;
+	else
+		reg &= ~rmap->reset;
+
+	if (write_en)
+		reg |= rmap->reset << 16;
+
+	writel(reg, rstc->base + rmap->offset);
+
+	spin_unlock_irqrestore(&rstc->lock, flags);
+}
+
+static int k230_rst_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct k230_rst *rstc = to_k230_rst(rcdev);
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	int ret;
+
+	switch (rmap->type) {
+	case RST_TYPE_CPU0:
+		k230_rst_clear_done(rstc, id, true);
+		k230_rst_update(rstc, id, true, true, false);
+		ret = k230_rst_wait_and_clear_done(rstc, id, true);
+		break;
+	case RST_TYPE_CPU1:
+	case RST_TYPE_FLUSH:
+		k230_rst_update(rstc, id, true, true, false);
+		break;
+	case RST_TYPE_HW_DONE:
+		k230_rst_clear_done(rstc, id, false);
+		k230_rst_update(rstc, id, true, false, false);
+		ret = k230_rst_wait_and_clear_done(rstc, id, false);
+		break;
+	case RST_TYPE_SW_DONE:
+		k230_rst_update(rstc, id, true, false,
+				id == RST_SPI2AXI ? false : true);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int k230_rst_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct k230_rst *rstc = to_k230_rst(rcdev);
+	int ret;
+
+	switch (k230_resets[id].type) {
+	case RST_TYPE_CPU0:
+		break;
+	case RST_TYPE_CPU1:
+		k230_rst_update(rstc, id, false, true, false);
+		ret = k230_rst_wait_and_clear_done(rstc, id, true);
+		break;
+	case RST_TYPE_FLUSH:
+	case RST_TYPE_HW_DONE:
+		break;
+	case RST_TYPE_SW_DONE:
+		k230_rst_update(rstc, id, false, false,
+				id == RST_SPI2AXI ? false : true);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int k230_rst_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = k230_rst_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	return k230_rst_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops k230_rst_ops = {
+	.reset		= k230_rst_reset,
+	.assert		= k230_rst_assert,
+	.deassert	= k230_rst_deassert,
+};
+
+static int k230_rst_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct k230_rst *rstc;
+
+	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return -ENOMEM;
+
+	rstc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rstc->base))
+		return PTR_ERR(rstc->base);
+
+	spin_lock_init(&rstc->lock);
+
+	rstc->dev		= dev;
+	rstc->rcdev.owner	= THIS_MODULE;
+	rstc->rcdev.ops		= &k230_rst_ops;
+	rstc->rcdev.nr_resets	= ARRAY_SIZE(k230_resets);
+	rstc->rcdev.of_node	= dev->of_node;
+
+	return devm_reset_controller_register(dev, &rstc->rcdev);
+}
+
+static const struct of_device_id k230_rst_match[] = {
+	{ .compatible = "canaan,k230-rst", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, k230_rst_match);
+
+static struct platform_driver k230_rst_driver = {
+	.probe = k230_rst_probe,
+	.driver = {
+		.name = "k230-rst",
+		.of_match_table = k230_rst_match,
+	}
+};
+module_platform_driver(k230_rst_driver);
+
+MODULE_AUTHOR("Junhui Liu <liujh2818@outlook.com>");
+MODULE_DESCRIPTION("Canaan K230 reset driver");
+MODULE_LICENSE("GPL v2");

-- 
2.46.1


