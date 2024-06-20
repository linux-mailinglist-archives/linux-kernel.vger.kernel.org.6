Return-Path: <linux-kernel+bounces-222255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C958290FEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67576286A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711C19DF6D;
	Thu, 20 Jun 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Fvw4Iycj"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5FAEDB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872359; cv=none; b=IJnzZHXhfNaQ8kfrPC1YveWv1aED6xWVPCZ8xOI9ERgjPYLbwU9+vbAyieV4DKT9uX6wDH85+z8bV3oEHy/HK9BjvTl6geP4bLLSKTL/xi5BxaTZ9pHx1seHWTReJkdUkUaZIEzOnv03QPaTaNx36Lt7dxHVr+srmHyKR5qqIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872359; c=relaxed/simple;
	bh=gos6qpmpHXaQQGXd7W0zKRdaNG69m+g512psjC+8AX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l46h2a6LRrPrc78VpUgX8SMWeWJOTVmgLjN8fcYAtB0hDI9oGv5MCKxiyvXwPNuJ55ioqzSqWVKdNh8cwJLRaqUJAS2/5oqiXe/DeabfWkQqtg37PQj9UAyVd8gdmm9ER6/8WSZEvegUBWuMPfjFcUvHrH2v9Cplk2Bccmsb6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Fvw4Iycj; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K6H85o015603;
	Thu, 20 Jun 2024 10:32:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	03WjNHmN5m8JrSlmbQFInhJNzToscAZD0mS3WYagU4w=; b=Fvw4Iycj16pU1X5g
	Y3h7YODg12/GQuxBF0gnDCEZr7pIxyzgKOP0Ig9P8bilRem0+hbIQusDrKnHNq54
	sU8rD6ofFJAiDZzCH4X7qVWTQTwM4Xs/9LQv0Icm3QKw7cpWxfRdMSfb4p6s6ePZ
	Jh5QRbpds5pBhaFQFNflEdy0XwLKfsxNoL4IVD2Y4ZHIvmDzxpiGXuvLaYnw01MV
	a5Q76rPEj2r50StQtFSJEYzPNauFn8N7TLMFVCq3YnfGjS8b0gmwyVxjlWKtgBCM
	DnSjVjArxZq1UKDUZuCwpOYAX0rypUShzhluEEoO/zlP7zcRTl2gq7a2Uhbyrtek
	tM9Hig==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9s7573-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 10:32:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6EC0B4002D;
	Thu, 20 Jun 2024 10:31:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42037212FD8;
	Thu, 20 Jun 2024 10:31:21 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 20 Jun
 2024 10:31:21 +0200
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
Subject: [PATCH v3 2/8] ARM: stm32: use different EXTI driver on ARMv7m and ARMv7a
Date: Thu, 20 Jun 2024 10:31:09 +0200
Message-ID: <20240620083115.204362-3-antonio.borneo@foss.st.com>
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

Build the proper driver by selecting the appropriate config flag.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/mach-stm32/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index ae21a9f78f9c2..a401a991fe088 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,8 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32_EXTI
+	select STM32MP_EXTI if ARCH_MULTI_V7
+	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	select STM32_FIREWALL
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
2.34.1


