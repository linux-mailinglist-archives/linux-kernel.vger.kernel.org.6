Return-Path: <linux-kernel+bounces-222263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D41090FEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1911F2591B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C51A8C23;
	Thu, 20 Jun 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KJzLUBTY"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C91A8C13
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872411; cv=none; b=WyrVfE7RNn1lNbiK2A6nCj419z+YzjL0Bb2lV/YMpeXoaK5L0OVreH3vG06ItDAr6YdRQbwiKD2w4+2jUxKTVI7wutSmwmW9d1SWW2UYvHcokv2eRZtfd57SuajkCLTxJLQA3ckhrYv4U/QzMwb2HdjK1zGsH9VSeKkfJ5O9vGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872411; c=relaxed/simple;
	bh=+AGwc3YwsYOqBDcKVMuIwi5BX8tMCJnUpGHAOzKzoMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6ke619FR0TcXnApzTUz0zDe8CoT+57xjQYTIq5/la1twyzZAfzUlY/s8L2FqjuynyNUgv23edW6opAq9Af+XqCWPPgPBclmyiApAJozZkCLmFk/KW//oYXWaF4OsqZliOKotfCwxXBi4J7bYawuRRf7bzyhWCbKaXM7Q3DX0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KJzLUBTY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K68KFh015585;
	Thu, 20 Jun 2024 10:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	STRAWaduCOHElcknAncBNyhYTModBowLL+oEP/LL/H0=; b=KJzLUBTYRZpHv91B
	vTElfZkST37oK9rY8RkPjz6O2dlhH2plNvdGOSH3Y003T1FohLmbqOzGfyIJClns
	BvHQz1+343tY9s7YKSYQern7WL0RjYnmtx+tyZfEeSTe+XQKU1gNNPaLMNRtAYHj
	DSFCkjDvlbc/zaD5nU6RzVtaRfMUf6256ZP4PtehkZ6ghaKJjAHcErEPuI9bkRt3
	2XAiJLAcs6vkBy/8c/jv2fcKzn64gmYSpoi6JDqqb0bYwD0xBvkm3oR2cKAbodhL
	JoWHAQmI6nbdnreZdLJr8AY33nSjw2I5A9ZkgJb0tsO3/NF6jvoJnX3vTTIuaxgz
	rgQWzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9s75c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 10:33:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0F6A840048;
	Thu, 20 Jun 2024 10:33:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABCCA215BFA;
	Thu, 20 Jun 2024 10:32:26 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 20 Jun
 2024 10:32:26 +0200
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
Subject: [PATCH v3 8/8] arm64: Kconfig: allow build irq-stm32mp-exti driver as module
Date: Thu, 20 Jun 2024 10:31:15 +0200
Message-ID: <20240620083115.204362-9-antonio.borneo@foss.st.com>
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

Drop auto-selecting the driver, so it can be built either as a
module or built-in.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index be8629858d747..a028ea3123789 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -309,7 +309,6 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
-	select STM32MP_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI
-- 
2.34.1


