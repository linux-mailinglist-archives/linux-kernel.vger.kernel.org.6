Return-Path: <linux-kernel+bounces-171349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE18BE32A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E0AB2301D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72415E216;
	Tue,  7 May 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QIrVVIpF"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4A15E1FD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087520; cv=none; b=D6dxYLyIObhGIK3WzHIJGcx9uIZ3zjBbexx8snZasqUrl9wo+dj001+W8PBjobKNkVsxaZcSrRydMCSnsEqeYO5lGO5wLXzBDZ8FW9hNz8ruoSTxk2TtPcWHsEIYGjIUJdN72J74ZvKl0tkIe5qWRQcoajRKlFCOo5dbiLz1UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087520; c=relaxed/simple;
	bh=zEBS6JMl3E73sfcFbF9mHYYHU8BUvelv4sHVebvCgno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teihkF96YF3IgYLGJyUsz+QNYvQywqkuO4WENWbpG1pXLHe632c685t7GfBG597Ku5BVip2Up5d9/i8Ea8o1gPACywNfy6nrcwBPQSjGHyJOMJJVCta/QxbIBkWipuyOnbvELvyEIRtP4s9hXE+6dWgKEXPXdAnHxHIDh0M0DqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QIrVVIpF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447BRcs2025853;
	Tue, 7 May 2024 15:11:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=yAN5IQlno3nIPY6Uvv6ZYKb/KRQn6JTGU5DkXSWQ1EU=; b=QI
	rVVIpF/Fsp1qrE0nBYyzHvp72LmJfPZ0SW8/2ocR9Xnq8YAitmEJiPRKvMZmr17Y
	epYwv1UBwORZSIFLOKxLYvNyi+YSciQo16ovWTvp7GiIh2kZ3tQo5okAR7U19030
	LwQSKD6NomQK/vZ9JZz9kNGirU+UAXSY6r3ayU4xaC/RBbbVC/F2YAM2IhNUIwal
	omomhfVCnRSrggbR3U4IMnSz7xKEZGzB2M85JyZRZH1qL3s4SwD7t2Y1jq9SVZUn
	b5o09Ka3YlLTfR2ujBSqQkb2TRY40kIhnLu9KsWyEUEmgfu7Dp8edC/X00Nk1X1B
	encA7+88Qp2hyP76T/DQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwa553xd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 15:11:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DCB524002D;
	Tue,  7 May 2024 15:11:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DDC321B53E;
	Tue,  7 May 2024 15:10:56 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 15:10:56 +0200
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
Subject: [PATCH v2 2/8] ARM: stm32: use different EXTI driver on ARMv7m and ARMv7a
Date: Tue, 7 May 2024 15:10:45 +0200
Message-ID: <20240507131051.980313-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507131051.980313-1-antonio.borneo@foss.st.com>
References: <20240507131051.980313-1-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

Build the proper driver by selecting the appropriate config flag.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/mach-stm32/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 98145031586f1..41bfcf31f8a76 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,8 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32_EXTI
+	select STM32MP_EXTI if ARCH_MULTI_V7
+	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	help
 	  Support for STMicroelectronics STM32 processors.
 
-- 
2.34.1


