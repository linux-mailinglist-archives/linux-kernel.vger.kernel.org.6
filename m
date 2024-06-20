Return-Path: <linux-kernel+bounces-222256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADED90FEED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F76DB254BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55041A4F0D;
	Thu, 20 Jun 2024 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0THh9/Fq"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458D199237
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872361; cv=none; b=cGEzyvgnM3mKl9D++q4TXRitEJpsHYOq9wkMoGM8XEV83/M0vPC/QT55G6I00SDwS4ovD1u+TkTkj3t268SpmsZNSMV3T92AqyaGnT24izE8pvymuOzkAWaNYecCU4VY5B0DohC92TuisKV180Q2R5+W1ShBSEW853JzXiNVUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872361; c=relaxed/simple;
	bh=MIhKHOlfVesvuOpt8uD6KcKIVhYfsPbHUreiE//uKUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkKRCK2U9rD1PjOePCTpFM1OQcZEIZ7h720cLBrjMtGx9hfIh1zeeSIoXuZ43extjKpYP0RL0YL7/G9yuaNBTWXFEmCYmDW0eyV6f8GBnPdG6/SVhZrwkUvsY1RysZwxy8gTJdg8DHAZkLChZlPnv3MTrNFWEDoYQq/FVX08DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0THh9/Fq; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K2UV9k026894;
	Thu, 20 Jun 2024 10:32:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	k4r6YkE+LgOs3Kkk9q1sWx+/l/0R6Pb6nAkwrBplXc4=; b=0THh9/FqcEdCsl76
	d3Ufe0NHd3Bo5sDZ1LHyrrkmbowDTmB8uU7/bzSlF2VkZppFsiINp+3KBKcag63S
	3IEDyOqA07T29bCTQmAtNCX6GclEqMsL60bgdvC0Z9lIeJQqzLq9xu3UjxxhHwjH
	vxDbR4vdau44yWMR+DDV2MgFhOvqo7VWa4cP2oGpBDlbHZIOm0lE43MpsJyUd4Hj
	o9kYx9MDHlRhsKWI/ukan9il/43xGyQDA+YLZcqwQiOh340yr1LCEkeHoPBq1vla
	YY4Va22P3IDRbE1OqiM/aWTIkvbkrS9aWGN8/UdW4w9BGYqNrfvxp7VOpUkCkGCw
	lYvhvg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yvbq0s7g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 10:32:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9DE8040047;
	Thu, 20 Jun 2024 10:31:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81FC2210743;
	Thu, 20 Jun 2024 10:31:22 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 20 Jun
 2024 10:31:22 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/8] irqchip/stm32-exti: split MCU and MPU code
Date: Thu, 20 Jun 2024 10:31:11 +0200
Message-ID: <20240620083115.204362-5-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620083115.204362-1-antonio.borneo@foss.st.com>
References: <20240620083115.204362-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01

Keep in stm32-exti only the code for ARMv7m STM32 MCUs and split
out in stm32mp-exti the code for ARMv7a & ARMv8a STM32MPxxx MPUs.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/Kconfig                       |   3 +-
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-stm32-exti.c              | 670 +-----------------
 .../{irq-stm32-exti.c => irq-stm32mp-exti.c}  | 345 +--------
 4 files changed, 10 insertions(+), 1009 deletions(-)
 copy drivers/irqchip/{irq-stm32-exti.c => irq-stm32mp-exti.c} (67%)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 798bd50f8ab23..486022fb7806e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -394,7 +394,8 @@ config PARTITION_PERCPU
 
 config STM32MP_EXTI
 	bool
-	select STM32_EXTI
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
 
 config STM32_EXTI
 	bool
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa86..8dffb6efbc070 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
+obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 2cc9f3b7d6690..7c6a0080c3303 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -1,45 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
- * Copyright (C) STMicroelectronics 2017
+ * Copyright (C) STMicroelectronics 2017-2024
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  */
 
 #include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
-
-#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
-#define EXTI_HWCFGR1			0x3f0
-
-/* Register: EXTI_EnCIDCFGR(n) */
-#define EXTI_CIDCFGR_CFEN_MASK		BIT(0)
-#define EXTI_CIDCFGR_CID_MASK		GENMASK(6, 4)
-#define EXTI_CIDCFGR_CID_SHIFT		4
-
-/* Register: EXTI_HWCFGR1 */
-#define EXTI_HWCFGR1_CIDWIDTH_MASK	GENMASK(27, 24)
-
-#define EXTI_CID1			1
-
 struct stm32_exti_bank {
 	u32 imr_ofst;
 	u32 emr_ofst;
@@ -47,13 +24,8 @@ struct stm32_exti_bank {
 	u32 ftsr_ofst;
 	u32 swier_ofst;
 	u32 rpr_ofst;
-	u32 fpr_ofst;
-	u32 trg_ofst;
-	u32 seccfgr_ofst;
 };
 
-#define UNDEF_REG ~0
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
 	const u8 *desc_irqs;
@@ -63,7 +35,6 @@ struct stm32_exti_drv_data {
 struct stm32_exti_chip_data {
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
-	struct raw_spinlock rlock;
 	u32 wake_active;
 	u32 mask_cache;
 	u32 rtsr_cache;
@@ -76,8 +47,6 @@ struct stm32_exti_host_data {
 	struct device *dev;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct hwspinlock *hwlock;
-	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
 };
 
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
@@ -87,9 +56,6 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.ftsr_ofst	= 0x0C,
 	.swier_ofst	= 0x10,
 	.rpr_ofst	= 0x14,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -108,9 +74,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x88,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -120,9 +83,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x98,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -132,9 +92,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0xA8,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -148,183 +105,12 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
 };
 
-static const struct stm32_exti_bank stm32mp1_exti_b1 = {
-	.imr_ofst	= 0x80,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x00,
-	.ftsr_ofst	= 0x04,
-	.swier_ofst	= 0x08,
-	.rpr_ofst	= 0x0C,
-	.fpr_ofst	= 0x10,
-	.trg_ofst	= 0x3EC,
-	.seccfgr_ofst	= 0x14,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b2 = {
-	.imr_ofst	= 0x90,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x20,
-	.ftsr_ofst	= 0x24,
-	.swier_ofst	= 0x28,
-	.rpr_ofst	= 0x2C,
-	.fpr_ofst	= 0x30,
-	.trg_ofst	= 0x3E8,
-	.seccfgr_ofst	= 0x34,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b3 = {
-	.imr_ofst	= 0xA0,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x40,
-	.ftsr_ofst	= 0x44,
-	.swier_ofst	= 0x48,
-	.rpr_ofst	= 0x4C,
-	.fpr_ofst	= 0x50,
-	.trg_ofst	= 0x3E4,
-	.seccfgr_ofst	= 0x54,
-};
-
-static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
-	&stm32mp1_exti_b1,
-	&stm32mp1_exti_b2,
-	&stm32mp1_exti_b3,
-};
-
-static struct irq_chip stm32_exti_h_chip;
-static struct irq_chip stm32_exti_h_chip_direct;
-
-#define EXTI_INVALID_IRQ       U8_MAX
-#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
-
-/*
- * Use some intentionally tricky logic here to initialize the whole array to
- * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
- * that we "know" that there are overrides in this structure, and we'll need to
- * disable that warning from W=1 builds.
- */
-__diag_push();
-__diag_ignore_all("-Woverride-init",
-		  "logic to initialize all and then override some is OK");
-
-static const u8 stm32mp1_desc_irq[] = {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
-
-	[0] = 6,
-	[1] = 7,
-	[2] = 8,
-	[3] = 9,
-	[4] = 10,
-	[5] = 23,
-	[6] = 64,
-	[7] = 65,
-	[8] = 66,
-	[9] = 67,
-	[10] = 40,
-	[11] = 42,
-	[12] = 76,
-	[13] = 77,
-	[14] = 121,
-	[15] = 127,
-	[16] = 1,
-	[19] = 3,
-	[21] = 31,
-	[22] = 33,
-	[23] = 72,
-	[24] = 95,
-	[25] = 107,
-	[26] = 37,
-	[27] = 38,
-	[28] = 39,
-	[29] = 71,
-	[30] = 52,
-	[31] = 53,
-	[32] = 82,
-	[33] = 83,
-	[46] = 151,
-	[47] = 93,
-	[48] = 138,
-	[50] = 139,
-	[52] = 140,
-	[53] = 141,
-	[54] = 135,
-	[61] = 100,
-	[65] = 144,
-	[68] = 143,
-	[70] = 62,
-	[73] = 129,
-};
-
-static const u8 stm32mp13_desc_irq[] = {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
-
-	[0] = 6,
-	[1] = 7,
-	[2] = 8,
-	[3] = 9,
-	[4] = 10,
-	[5] = 24,
-	[6] = 65,
-	[7] = 66,
-	[8] = 67,
-	[9] = 68,
-	[10] = 41,
-	[11] = 43,
-	[12] = 77,
-	[13] = 78,
-	[14] = 106,
-	[15] = 109,
-	[16] = 1,
-	[19] = 3,
-	[21] = 32,
-	[22] = 34,
-	[23] = 73,
-	[24] = 93,
-	[25] = 114,
-	[26] = 38,
-	[27] = 39,
-	[28] = 40,
-	[29] = 72,
-	[30] = 53,
-	[31] = 54,
-	[32] = 83,
-	[33] = 84,
-	[44] = 96,
-	[47] = 92,
-	[48] = 116,
-	[50] = 117,
-	[52] = 118,
-	[53] = 119,
-	[68] = 63,
-	[70] = 98,
-};
-
-__diag_pop();
-
-static const struct stm32_exti_drv_data stm32mp1_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs = stm32mp1_desc_irq,
-};
-
-static const struct stm32_exti_drv_data stm32mp13_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs = stm32mp13_desc_irq,
-};
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	unsigned long pending;
 
-	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		pending |= irq_reg_readl(gc, stm32_bank->fpr_ofst);
-
-	return pending;
+	return irq_reg_readl(gc, stm32_bank->rpr_ofst);
 }
 
 static void stm32_irq_handler(struct irq_desc *desc)
@@ -380,33 +166,21 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
 	u32 rtsr, ftsr;
 	int err;
 
 	irq_gc_lock(gc);
 
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
 	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
 
 	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
 	if (err)
-		goto unspinlock;
+		goto unlock;
 
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	irq_gc_unlock(gc);
 
@@ -494,287 +268,10 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_lock(gc);
 
 	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
 
 	irq_gc_unlock(gc);
 }
 
-/* directly set the target bit without reading first. */
-static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(val, base + reg);
-}
-
-static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val;
-
-	val = readl_relaxed(base + reg);
-	val |= BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val;
-
-	val = readl_relaxed(base + reg);
-	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static void stm32_exti_h_eoi(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_eoi_parent(d);
-}
-
-static void stm32_exti_h_mask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_mask_parent(d);
-}
-
-static void stm32_exti_h_unmask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_unmask_parent(d);
-}
-
-static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
-	void __iomem *base = chip_data->host_data->base;
-	u32 rtsr, ftsr;
-	int err;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
-	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
-	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
-
-	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err)
-		goto unspinlock;
-
-	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
-
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
-unlock:
-	raw_spin_unlock(&chip_data->rlock);
-
-	return err;
-}
-
-static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (on)
-		chip_data->wake_active |= mask;
-	else
-		chip_data->wake_active &= ~mask;
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	return 0;
-}
-
-static int stm32_exti_h_set_affinity(struct irq_data *d,
-				     const struct cpumask *dest, bool force)
-{
-	if (d->parent_data->chip)
-		return irq_chip_set_affinity_parent(d, dest, force);
-
-	return IRQ_SET_MASK_OK_DONE;
-}
-
-static int stm32_exti_h_suspend(struct device *dev)
-{
-	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
-		chip_data = &host_data->chips_data[i];
-		stm32_chip_suspend(chip_data, chip_data->wake_active);
-	}
-
-	return 0;
-}
-
-static int stm32_exti_h_resume(struct device *dev)
-{
-	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
-		chip_data = &host_data->chips_data[i];
-		stm32_chip_resume(chip_data, chip_data->mask_cache);
-	}
-
-	return 0;
-}
-
-static int stm32_exti_h_retrigger(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	void __iomem *base = chip_data->host_data->base;
-	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(mask, base + stm32_bank->swier_ofst);
-
-	return 0;
-}
-
-static struct irq_chip stm32_exti_h_chip = {
-	.name			= "stm32-exti-h",
-	.irq_eoi		= stm32_exti_h_eoi,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= stm32_exti_h_retrigger,
-	.irq_set_type		= stm32_exti_h_set_type,
-	.irq_set_wake		= stm32_exti_h_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
-};
-
-static struct irq_chip stm32_exti_h_chip_direct = {
-	.name			= "stm32-exti-h-direct",
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_wake		= stm32_exti_h_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
-};
-
-static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
-				     unsigned int virq,
-				     unsigned int nr_irqs, void *data)
-{
-	struct stm32_exti_host_data *host_data = dm->host_data;
-	struct stm32_exti_chip_data *chip_data;
-	u8 desc_irq;
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec p_fwspec;
-	irq_hw_number_t hwirq;
-	int bank;
-	u32 event_trg;
-	struct irq_chip *chip;
-
-	hwirq = fwspec->param[0];
-	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
-		return -EINVAL;
-
-	bank  = hwirq / IRQS_PER_BANK;
-	chip_data = &host_data->chips_data[bank];
-
-	/* Check if event is reserved (Secure) */
-	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
-		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
-		return -EPERM;
-	}
-
-	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
-	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
-	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
-
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
-
-	if (host_data->dt_has_irqs_desc) {
-		struct of_phandle_args out_irq;
-		int ret;
-
-		ret = of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
-		if (ret)
-			return ret;
-		/* we only support one parent, so far */
-		if (of_node_to_fwnode(out_irq.np) != dm->parent->fwnode)
-			return -EINVAL;
-
-		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
-					  out_irq.args_count, &p_fwspec);
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	if (!host_data->drv_data->desc_irqs)
-		return -EINVAL;
-
-	desc_irq = host_data->drv_data->desc_irqs[hwirq];
-	if (desc_irq != EXTI_INVALID_IRQ) {
-		p_fwspec.fwnode = dm->parent->fwnode;
-		p_fwspec.param_count = 3;
-		p_fwspec.param[0] = GIC_SPI;
-		p_fwspec.param[1] = desc_irq;
-		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	return 0;
-}
-
 static struct
 stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					   struct device_node *node)
@@ -822,19 +319,12 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	chip_data->host_data = h_data;
 	chip_data->reg_bank = stm32_bank;
 
-	raw_spin_lock_init(&chip_data->rlock);
-
 	/*
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	if (stm32_bank->emr_ofst != UNDEF_REG)
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
-
-	/* reserve Secure events */
-	if (stm32_bank->seccfgr_ofst != UNDEF_REG)
-		chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+	writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
@@ -914,158 +404,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	return ret;
 }
 
-static const struct irq_domain_ops stm32_exti_h_domain_ops = {
-	.alloc	= stm32_exti_h_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
-	.xlate = irq_domain_xlate_twocell,
-};
-
-static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
-{
-	unsigned int bank, i, event;
-	u32 cid, cidcfgr, hwcfgr1;
-
-	/* quit on CID not supported */
-	hwcfgr1 = readl_relaxed(host_data->base + EXTI_HWCFGR1);
-	if ((hwcfgr1 & EXTI_HWCFGR1_CIDWIDTH_MASK) == 0)
-		return;
-
-	for (bank = 0; bank < host_data->drv_data->bank_nr; bank++) {
-		for (i = 0; i < IRQS_PER_BANK; i++) {
-			event = bank * IRQS_PER_BANK + i;
-			cidcfgr = readl_relaxed(host_data->base + EXTI_EnCIDCFGR(event));
-			cid = (cidcfgr & EXTI_CIDCFGR_CID_MASK) >> EXTI_CIDCFGR_CID_SHIFT;
-			if ((cidcfgr & EXTI_CIDCFGR_CFEN_MASK) && cid != EXTI_CID1)
-				host_data->chips_data[bank].event_reserved |= BIT(i);
-		}
-	}
-}
-
-static void stm32_exti_remove_irq(void *data)
-{
-	struct irq_domain *domain = data;
-
-	irq_domain_remove(domain);
-}
-
-static int stm32_exti_probe(struct platform_device *pdev)
-{
-	int ret, i;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct irq_domain *parent_domain, *domain;
-	struct stm32_exti_host_data *host_data;
-	const struct stm32_exti_drv_data *drv_data;
-
-	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
-	if (!host_data)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, host_data);
-	host_data->dev = dev;
-
-	/* check for optional hwspinlock which may be not available yet */
-	ret = of_hwspin_lock_get_id(np, 0);
-	if (ret == -EPROBE_DEFER)
-		/* hwspinlock framework not yet ready */
-		return ret;
-
-	if (ret >= 0) {
-		host_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
-		if (!host_data->hwlock) {
-			dev_err(dev, "Failed to request hwspinlock\n");
-			return -EINVAL;
-		}
-	} else if (ret != -ENOENT) {
-		/* note: ENOENT is a valid case (means 'no hwspinlock') */
-		dev_err(dev, "Failed to get hwspinlock\n");
-		return ret;
-	}
-
-	/* initialize host_data */
-	drv_data = of_device_get_match_data(dev);
-	if (!drv_data) {
-		dev_err(dev, "no of match data\n");
-		return -ENODEV;
-	}
-	host_data->drv_data = drv_data;
-
-	host_data->chips_data = devm_kcalloc(dev, drv_data->bank_nr,
-					     sizeof(*host_data->chips_data),
-					     GFP_KERNEL);
-	if (!host_data->chips_data)
-		return -ENOMEM;
-
-	host_data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host_data->base))
-		return PTR_ERR(host_data->base);
-
-	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i, np);
-
-	stm32_exti_check_rif(host_data);
-
-	parent_domain = irq_find_host(of_irq_find_parent(np));
-	if (!parent_domain) {
-		dev_err(dev, "GIC interrupt-parent not found\n");
-		return -EINVAL;
-	}
-
-	domain = irq_domain_add_hierarchy(parent_domain, 0,
-					  drv_data->bank_nr * IRQS_PER_BANK,
-					  np, &stm32_exti_h_domain_ops,
-					  host_data);
-
-	if (!domain) {
-		dev_err(dev, "Could not register exti domain\n");
-		return -ENOMEM;
-	}
-
-	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
-	if (ret)
-		return ret;
-
-	if (of_property_read_bool(np, "interrupts-extended"))
-		host_data->dt_has_irqs_desc = true;
-
-	return 0;
-}
-
-/* platform driver only for MP1 */
-static const struct of_device_id stm32_exti_ids[] = {
-	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
-	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
-	{},
-};
-MODULE_DEVICE_TABLE(of, stm32_exti_ids);
-
-static const struct dev_pm_ops stm32_exti_dev_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
-};
-
-static struct platform_driver stm32_exti_driver = {
-	.probe		= stm32_exti_probe,
-	.driver		= {
-		.name		= "stm32_exti",
-		.of_match_table	= stm32_exti_ids,
-		.pm		= &stm32_exti_dev_pm_ops,
-	},
-};
-
-static int __init stm32_exti_arch_init(void)
-{
-	return platform_driver_register(&stm32_exti_driver);
-}
-
-static void __exit stm32_exti_arch_exit(void)
-{
-	return platform_driver_unregister(&stm32_exti_driver);
-}
-
-arch_initcall(stm32_exti_arch_init);
-module_exit(stm32_exti_arch_exit);
-
-/* no platform driver for F4 and H7 */
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
similarity index 67%
copy from drivers/irqchip/irq-stm32-exti.c
copy to drivers/irqchip/irq-stm32mp-exti.c
index 2cc9f3b7d6690..8a45ece2e198f 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -1,18 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
- * Copyright (C) STMicroelectronics 2017
+ * Copyright (C) STMicroelectronics 2017-2024
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  */
 
 #include <linux/bitops.h>
-#include <linux/delay.h>
 #include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -42,7 +40,6 @@
 
 struct stm32_exti_bank {
 	u32 imr_ofst;
-	u32 emr_ofst;
 	u32 rtsr_ofst;
 	u32 ftsr_ofst;
 	u32 swier_ofst;
@@ -52,8 +49,6 @@ struct stm32_exti_bank {
 	u32 seccfgr_ofst;
 };
 
-#define UNDEF_REG ~0
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
 	const u8 *desc_irqs;
@@ -80,77 +75,8 @@ struct stm32_exti_host_data {
 	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
 };
 
-static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
-	.imr_ofst	= 0x00,
-	.emr_ofst	= 0x04,
-	.rtsr_ofst	= 0x08,
-	.ftsr_ofst	= 0x0C,
-	.swier_ofst	= 0x10,
-	.rpr_ofst	= 0x14,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
-};
-
-static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
-	&stm32f4xx_exti_b1,
-};
-
-static const struct stm32_exti_drv_data stm32f4xx_drv_data = {
-	.exti_banks = stm32f4xx_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32f4xx_exti_banks),
-};
-
-static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
-	.imr_ofst	= 0x80,
-	.emr_ofst	= 0x84,
-	.rtsr_ofst	= 0x00,
-	.ftsr_ofst	= 0x04,
-	.swier_ofst	= 0x08,
-	.rpr_ofst	= 0x88,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
-};
-
-static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
-	.imr_ofst	= 0x90,
-	.emr_ofst	= 0x94,
-	.rtsr_ofst	= 0x20,
-	.ftsr_ofst	= 0x24,
-	.swier_ofst	= 0x28,
-	.rpr_ofst	= 0x98,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
-};
-
-static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
-	.imr_ofst	= 0xA0,
-	.emr_ofst	= 0xA4,
-	.rtsr_ofst	= 0x40,
-	.ftsr_ofst	= 0x44,
-	.swier_ofst	= 0x48,
-	.rpr_ofst	= 0xA8,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
-};
-
-static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
-	&stm32h7xx_exti_b1,
-	&stm32h7xx_exti_b2,
-	&stm32h7xx_exti_b3,
-};
-
-static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
-	.exti_banks = stm32h7xx_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
-};
-
 static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.imr_ofst	= 0x80,
-	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
@@ -162,7 +88,6 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.imr_ofst	= 0x90,
-	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
@@ -174,7 +99,6 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.imr_ofst	= 0xA0,
-	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
@@ -314,42 +238,6 @@ static const struct stm32_exti_drv_data stm32mp13_drv_data = {
 	.desc_irqs = stm32mp13_desc_irq,
 };
 
-static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
-{
-	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	unsigned long pending;
-
-	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		pending |= irq_reg_readl(gc, stm32_bank->fpr_ofst);
-
-	return pending;
-}
-
-static void stm32_irq_handler(struct irq_desc *desc)
-{
-	struct irq_domain *domain = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int nbanks = domain->gc->num_chips;
-	struct irq_chip_generic *gc;
-	unsigned long pending;
-	int n, i, irq_base = 0;
-
-	chained_irq_enter(chip, desc);
-
-	for (i = 0; i < nbanks; i++, irq_base += IRQS_PER_BANK) {
-		gc = irq_get_domain_generic_chip(domain, irq_base);
-
-		while ((pending = stm32_exti_pending(gc))) {
-			for_each_set_bit(n, &pending, IRQS_PER_BANK)
-				generic_handle_domain_irq(domain, irq_base + n);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
 static int stm32_exti_set_type(struct irq_data *d,
 			       unsigned int type, u32 *rtsr, u32 *ftsr)
 {
@@ -375,44 +263,6 @@ static int stm32_exti_set_type(struct irq_data *d,
 	return 0;
 }
 
-static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
-	u32 rtsr, ftsr;
-	int err;
-
-	irq_gc_lock(gc);
-
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
-	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
-	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
-
-	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err)
-		goto unspinlock;
-
-	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
-	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
-
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
-unlock:
-	irq_gc_unlock(gc);
-
-	return err;
-}
-
 static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
 			       u32 wake_active)
 {
@@ -439,67 +289,6 @@ static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
 	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
 }
 
-static void stm32_irq_suspend(struct irq_chip_generic *gc)
-{
-	struct stm32_exti_chip_data *chip_data = gc->private;
-
-	irq_gc_lock(gc);
-	stm32_chip_suspend(chip_data, gc->wake_active);
-	irq_gc_unlock(gc);
-}
-
-static void stm32_irq_resume(struct irq_chip_generic *gc)
-{
-	struct stm32_exti_chip_data *chip_data = gc->private;
-
-	irq_gc_lock(gc);
-	stm32_chip_resume(chip_data, gc->mask_cache);
-	irq_gc_unlock(gc);
-}
-
-static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
-			    unsigned int nr_irqs, void *data)
-{
-	struct irq_fwspec *fwspec = data;
-	irq_hw_number_t hwirq;
-
-	hwirq = fwspec->param[0];
-
-	irq_map_generic_chip(d, virq, hwirq);
-
-	return 0;
-}
-
-static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
-			    unsigned int nr_irqs)
-{
-	struct irq_data *data = irq_domain_get_irq_data(d, virq);
-
-	irq_domain_reset_irq_data(data);
-}
-
-static const struct irq_domain_ops irq_exti_domain_ops = {
-	.map	= irq_map_generic_chip,
-	.alloc  = stm32_exti_alloc,
-	.free	= stm32_exti_free,
-	.xlate	= irq_domain_xlate_twocell,
-};
-
-static void stm32_irq_ack(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	irq_gc_lock(gc);
-
-	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
-
-	irq_gc_unlock(gc);
-}
-
 /* directly set the target bit without reading first. */
 static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
 {
@@ -544,8 +333,7 @@ static void stm32_exti_h_eoi(struct irq_data *d)
 	raw_spin_lock(&chip_data->rlock);
 
 	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
 
 	raw_spin_unlock(&chip_data->rlock);
 
@@ -775,39 +563,6 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	return 0;
 }
 
-static struct
-stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
-					   struct device_node *node)
-{
-	struct stm32_exti_host_data *host_data;
-
-	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
-	if (!host_data)
-		return NULL;
-
-	host_data->drv_data = dd;
-	host_data->chips_data = kcalloc(dd->bank_nr,
-					sizeof(struct stm32_exti_chip_data),
-					GFP_KERNEL);
-	if (!host_data->chips_data)
-		goto free_host_data;
-
-	host_data->base = of_iomap(node, 0);
-	if (!host_data->base) {
-		pr_err("%pOF: Unable to map registers\n", node);
-		goto free_chips_data;
-	}
-
-	return host_data;
-
-free_chips_data:
-	kfree(host_data->chips_data);
-free_host_data:
-	kfree(host_data);
-
-	return NULL;
-}
-
 static struct
 stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 					   u32 bank_idx,
@@ -829,91 +584,15 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	if (stm32_bank->emr_ofst != UNDEF_REG)
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	/* reserve Secure events */
-	if (stm32_bank->seccfgr_ofst != UNDEF_REG)
-		chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+	chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
 	return chip_data;
 }
 
-static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
-				  struct device_node *node)
-{
-	struct stm32_exti_host_data *host_data;
-	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	int nr_irqs, ret, i;
-	struct irq_chip_generic *gc;
-	struct irq_domain *domain;
-
-	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data)
-		return -ENOMEM;
-
-	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
-				       &irq_exti_domain_ops, NULL);
-	if (!domain) {
-		pr_err("%pOFn: Could not register interrupt domain.\n",
-		       node);
-		ret = -ENOMEM;
-		goto out_unmap;
-	}
-
-	ret = irq_alloc_domain_generic_chips(domain, IRQS_PER_BANK, 1, "exti",
-					     handle_edge_irq, clr, 0, 0);
-	if (ret) {
-		pr_err("%pOF: Could not allocate generic interrupt chip.\n",
-		       node);
-		goto out_free_domain;
-	}
-
-	for (i = 0; i < drv_data->bank_nr; i++) {
-		const struct stm32_exti_bank *stm32_bank;
-		struct stm32_exti_chip_data *chip_data;
-
-		stm32_bank = drv_data->exti_banks[i];
-		chip_data = stm32_exti_chip_init(host_data, i, node);
-
-		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
-
-		gc->reg_base = host_data->base;
-		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
-		gc->chip_types->chip.irq_ack = stm32_irq_ack;
-		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
-		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
-		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
-		gc->chip_types->chip.irq_set_wake = irq_gc_set_wake;
-		gc->suspend = stm32_irq_suspend;
-		gc->resume = stm32_irq_resume;
-		gc->wake_enabled = IRQ_MSK(IRQS_PER_BANK);
-
-		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
-		gc->private = (void *)chip_data;
-	}
-
-	nr_irqs = of_irq_count(node);
-	for (i = 0; i < nr_irqs; i++) {
-		unsigned int irq = irq_of_parse_and_map(node, i);
-
-		irq_set_handler_data(irq, domain);
-		irq_set_chained_handler(irq, stm32_irq_handler);
-	}
-
-	return 0;
-
-out_free_domain:
-	irq_domain_remove(domain);
-out_unmap:
-	iounmap(host_data->base);
-	kfree(host_data->chips_data);
-	kfree(host_data);
-	return ret;
-}
-
 static const struct irq_domain_ops stm32_exti_h_domain_ops = {
 	.alloc	= stm32_exti_h_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
@@ -1031,7 +710,6 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/* platform driver only for MP1 */
 static const struct of_device_id stm32_exti_ids[] = {
 	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
 	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
@@ -1064,20 +742,3 @@ static void __exit stm32_exti_arch_exit(void)
 
 arch_initcall(stm32_exti_arch_init);
 module_exit(stm32_exti_arch_exit);
-
-/* no platform driver for F4 and H7 */
-static int __init stm32f4_exti_of_init(struct device_node *np,
-				       struct device_node *parent)
-{
-	return stm32_exti_init(&stm32f4xx_drv_data, np);
-}
-
-IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
-
-static int __init stm32h7_exti_of_init(struct device_node *np,
-				       struct device_node *parent)
-{
-	return stm32_exti_init(&stm32h7xx_drv_data, np);
-}
-
-IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
-- 
2.34.1


