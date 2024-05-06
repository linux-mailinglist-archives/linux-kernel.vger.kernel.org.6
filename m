Return-Path: <linux-kernel+bounces-169893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099D8BCF14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260A31F22F87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2379B9C;
	Mon,  6 May 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BSUoJIEv"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE478C75
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002503; cv=none; b=tz7hkXJjO1yD7n2GinJ+I7p+7SC8PGynNfwbJxiBmoQYi6swI541lqRAPsxvvMoyCHPQZ3M9Iu841LlYGgEqu81uOXY18kfBVL3wcuPpAnbDrKbPpwBxxWs+sWoT7LOFdzfHVEvCh7Ji1uoHCds/hzTBW4KLOWH1vduMrL9XEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002503; c=relaxed/simple;
	bh=6iZyu6h2471MLh5Wb1cORQD9zmmQ2O6P79Od0ztmw3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoRe5sVn6eFsJUTSea+KzkkBV5AE+45GACMsMXpB2jvO+ZTkK9jtyYPiW8oGWTuflzYy1Ar4nT8ocDtcEGSy6s5T4fSUHG7FFZvGmVHmYinl2vsWQbNooufBPkeb3n5q4LVoWzyN50kIeNELGeK8mG2g2borEkX69X5FiPE2zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BSUoJIEv; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446DYJbw021791;
	Mon, 6 May 2024 15:34:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=POWZoUc0X8Boorq4SPNqj49r2vjDIbLIFmBbp8SfjUo=; b=BS
	UoJIEv78xSTkl+k4XfurkjtkimJOSKKwn/5FxGIf8z7BMfIbeYQwsqFJaqWNbT9E
	IOYwtBTXi1bt9UaAZqOZ9WObg8U9xdoibJFP5aZTzdOzCpoFt71z9zBysVCdQU5X
	pU+5wtGUWYGNk/r5CjKEt7NyiFQYRGEeVhFLi3NBcazYVijDdvB4sWpvg1MLpZBA
	+zUKOd+Iiw+BOykzXnmnnexzBKOrSM3j2gfESR+dCEApwLa3ihdcYZZvRTbrDuJp
	g8dl2fX/mNqyo/M6Hpb9otuAq6bZLntzlEHaHxf6UC0tYekWwrDjm2aBC8AonhXp
	Ed72alOVSYsF+9ElnRZw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwaeg7kqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:34:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 54C7040046;
	Mon,  6 May 2024 15:34:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F60C2207A5;
	Mon,  6 May 2024 15:34:13 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 15:34:13 +0200
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
Subject: [PATCH 7/8] ARM: stm32: allow build irq-stm32mp-exti driver as module
Date: Mon, 6 May 2024 15:32:55 +0200
Message-ID: <20240506133256.948712-8-antonio.borneo@foss.st.com>
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

Drop auto-selecting the driver, so it can be built either as a
module or built-in.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/mach-stm32/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 41bfcf31f8a76..8c8d5fc1217f6 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,6 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32MP_EXTI if ARCH_MULTI_V7
 	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
2.34.1


