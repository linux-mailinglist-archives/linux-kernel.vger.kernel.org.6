Return-Path: <linux-kernel+bounces-169888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C48BCF07
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE62B2509E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7157A158;
	Mon,  6 May 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5MpjtPPr"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36F79B8E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002474; cv=none; b=jaX0CX03x8AqquJqeV8MxWOLAXRTbBHikxdFGN0WXE1SqfAeTvA5Vs4pxfRakjfRCEUOqT1Nz+4YC5enBNQBvXj/gJq1D8TfgOYNJN+nhugs5gG0jjRxd8jnNqzi2dufJhiOsFofNiqRf12kKymAfZFylaIDJ1kQJ+I9EQPSvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002474; c=relaxed/simple;
	bh=zEBS6JMl3E73sfcFbF9mHYYHU8BUvelv4sHVebvCgno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R69LgcSJMsxz/UsNrw0ud4jcjAcT7e/T19s8KIBSCHXBTR/mujpHTMa7rN4a2cwqttGX1FBJZQDWS5znA5I1EZeVEnBoqNBelKbcMcIFcrDgeTobrGW1iMQiZhcaY1PyDIiFVesjDxyup7WqfL3IQqhoXKQhfm9o96oueWpllI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5MpjtPPr; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446Ahw1l029202;
	Mon, 6 May 2024 15:33:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=yAN5IQlno3nIPY6Uvv6ZYKb/KRQn6JTGU5DkXSWQ1EU=; b=5M
	pjtPPrL2qzMMyFahcUay3H7yT6VnFDOwj4+ohRl0uVo1RQu0lwnZmwEZbx5EkDgm
	k/LmFthiZXAlFkKtq2mqsRdPlU089H0LlEh+qik3U971haR0A6roHBWxOck0lni+
	85Nupbpwu6Z7+28bnonUAMkqboo4ic9TeMFjKQhhSMhcYLyNUkrxrDY0V6Yl7UiX
	wXxcweuSz1CIzqhpvkDUkeRkuqzUhvR/Iqi5YyDbmBUYsGkzGRphvALgPOioQKn3
	/Zi4lcoIz4ZXJFy43j327oyQsRjDbeDkzqq+s50aNMZtpuYzYtBmwGOdumJXTAvM
	8yZdzNK5ccJufhQ0E9ag==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwyyk5cb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:33:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 365A34004D;
	Mon,  6 May 2024 15:33:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E49C2207A2;
	Mon,  6 May 2024 15:33:08 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 15:33:07 +0200
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
Subject: [PATCH 2/8] ARM: stm32: use different EXTI driver on ARMv7m and ARMv7a
Date: Mon, 6 May 2024 15:32:50 +0200
Message-ID: <20240506133256.948712-3-antonio.borneo@foss.st.com>
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


