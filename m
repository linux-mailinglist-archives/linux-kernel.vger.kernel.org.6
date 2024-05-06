Return-Path: <linux-kernel+bounces-169891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCD8BCF10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C01F23855
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E178C89;
	Mon,  6 May 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LDvoD8Ed"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81324642B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002502; cv=none; b=YFtAE+WLZzczp8zYOgKsBbPtHKG4zg7Zdg4DpKLjH9WGxmMe+O92ReyioS//XFBEMEvykqqnGQGKq2RVLtyRHloxiw+jR8GcCFS5odjD5/lc9zWo0OwMN3fjM7RIuuU3S2sCdCs+bl4Q8yB2fDqETuHWMLW0RkB6/aj0JYAtHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002502; c=relaxed/simple;
	bh=qA7nhV1zd9BS1+1ooyiHJ/JBT95Ksgc6rwSHx7cptbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+b3HPJ8Uz4Img/Md4fAUdRy4qlz+ro7M9KhBiJ9dAaRsrygP9lPRiWbgVE3eXib67KWOyeMumuu5S3lqueCBcUsK8NmJLbQ9MS3GSbxRPQehwbksvp9G2n4n3EWaEGc2+yTV5PFXAb4D3Vg+xgUdUpyi0zKO+H3jwjc5N9zAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LDvoD8Ed; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446DA4Ik016848;
	Mon, 6 May 2024 15:34:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=vtOrJKt2M1GPNMF8eyCcBhxzywX0GXoX9qfsg8V6D8U=; b=LD
	voD8EdlJFKQdBtA3G6ImvQnBJk5Vefz58ZC//Qprfpai2DndNZyqbAYGkzR8aq1/
	OaHx2naJJOzyA3tCPiGEhithKeQ2BBvnGL0A2qZyqxoCStoFk59XrmRCWTgWjcag
	xFrcM6uJbEpws9HmR19jO4xwN+i4BFy/ZbhZS5t6BvWjF7AHw5qjM7yyRxbnyiU4
	mHkE4SxwOnpAaP956m1FV9jBW2lmoP5aLoiq9dnB5Gk5oLVVIMu+0XvMc+DfZ68U
	1IQuskxnrfZfplARL2F5c91tTPZg+DT8m9iQYKebVohQCZwSGg2R79vSV6xgwzdP
	SuNFbP9G+RfgZWg6MT8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwaeg7kqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:34:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AAD504002D;
	Mon,  6 May 2024 15:34:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5A6621ADBC;
	Mon,  6 May 2024 15:34:12 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 15:34:12 +0200
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
Subject: [PATCH 6/8] irqchip/stm32mp-exti: allow build as module
Date: Mon, 6 May 2024 15:32:54 +0200
Message-ID: <20240506133256.948712-7-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506133256.948712-1-antonio.borneo@foss.st.com>
References: <20240506133256.948712-1-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02

Allow build the driver as a module by adding the necessarily hooks
in Kconfig and in the driver's code.

Since all the probe dependencies linked to this driver has already
been fixed, ignore the no more relevant 'arch_initcall'.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/Kconfig            |  6 +++++-
 drivers/irqchip/irq-stm32mp-exti.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 486022fb7806e..c26d28dc0d45e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -393,9 +393,13 @@ config PARTITION_PERCPU
 	bool
 
 config STM32MP_EXTI
-	bool
+	tristate "STM32MP extended interrupts and event controller"
+	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
+	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
+	help
+	  Support STM32MP EXTI (extended interrupts and event) controller.
 
 config STM32_EXTI
 	bool
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 3ceff6d25b702..2958fbcfbda12 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -730,15 +730,8 @@ static struct platform_driver stm32mp_exti_driver = {
 	},
 };
 
-static int __init stm32mp_exti_arch_init(void)
-{
-	return platform_driver_register(&stm32mp_exti_driver);
-}
-
-static void __exit stm32mp_exti_arch_exit(void)
-{
-	return platform_driver_unregister(&stm32mp_exti_driver);
-}
+module_platform_driver(stm32mp_exti_driver);
 
-arch_initcall(stm32mp_exti_arch_init);
-module_exit(stm32mp_exti_arch_exit);
+MODULE_AUTHOR("Maxime Coquelin <mcoquelin.stm32@gmail.com>");
+MODULE_DESCRIPTION("STM32MP EXTI driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


