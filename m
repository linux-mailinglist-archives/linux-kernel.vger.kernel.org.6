Return-Path: <linux-kernel+bounces-171355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC228BE33B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A491C21DED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE915E813;
	Tue,  7 May 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="McdDfK3J"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37A15E21B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087574; cv=none; b=F3vuUlBS3lPgg3rixMhXcbOOKcZ+85Ny+Pd77dnahrWQQVODi9KFfFvsrhSGTUxATn56G7R9vGiRYtPBBrFG866Do8E0OjmMZhWMqTLbpp1U3eTPWf/cASIWjq5ikVMVghwQqY8Y+ZZBvqjYbr/RvBpMyF+zV5POC0ZLPGvxMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087574; c=relaxed/simple;
	bh=6iZyu6h2471MLh5Wb1cORQD9zmmQ2O6P79Od0ztmw3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht11eAZywUOA99DobAElJuNmFdbCRcrnEfiZ90FZDhcSlu20RThBuAAnNq0gVHlKwh3+OTnda4Vq+Z6s7SWe5wf56xkzODqZPKLjjfcC41u9xYOLsektifVwNwzHkCZTLSoH605+tzf36uHjTiZ0BMthrDx0F5u/zsQKPsWq0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=McdDfK3J; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447C7A5A014051;
	Tue, 7 May 2024 15:12:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=POWZoUc0X8Boorq4SPNqj49r2vjDIbLIFmBbp8SfjUo=; b=Mc
	dDfK3JbCJ1pIDp3cuwA0BtzbFdWSvzYDt4OECLxaoHNb9IMBpXwgrq1SPxSSetgW
	jXXAPgyY5GH9ptmNKmOqSR95TygxnsZfMseMo1gIb1ex8W+wTLNHqFGfx5crzYbi
	lhTR0T2zegAigv7baU9bQzgN75BvlKxpF13S2qy4+e0DLf6tvHjLmERo8TcziKkb
	ksv3uI9v8uBXhtBEa42HVX3BIVErG9eL1soh3wzg35+ki94p5KQOngwlyMO4CXm+
	E6Dz5KnbnjvVEnLKMr1vGySlX+btU43WT74LM9YuCjePKwz3QeTAC5qxM3R8Po29
	dSYUNmEUM4fzbPLVE1mg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwa553xh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 15:12:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9FF3E40045;
	Tue,  7 May 2024 15:12:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C67EC21B53D;
	Tue,  7 May 2024 15:12:01 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 15:12:01 +0200
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
Subject: [PATCH v2 7/8] ARM: stm32: allow build irq-stm32mp-exti driver as module
Date: Tue, 7 May 2024 15:10:50 +0200
Message-ID: <20240507131051.980313-8-antonio.borneo@foss.st.com>
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


