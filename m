Return-Path: <linux-kernel+bounces-169892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B968BCF12
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DB21C2280B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6F78C90;
	Mon,  6 May 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Dxtc3Iua"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750978C83
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002502; cv=none; b=HBggob7bzLsSoOjD2QCaHB8Y/JxRWzc6BE409f1d7OnI5SQbwvA/r+UfIYL706OOHDlNr7UYjwAys+pgO0QP9Ep3kfstKdln2QopfgrtaSIYaejP7TOumfIBUaD9WnPu71iAJ+at0A9bqBHwU1nKBgTJu21VeVvdgsOm/AFhIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002502; c=relaxed/simple;
	bh=QH50Imua83pGsyl2QgedDICwvqnyemDunG+FR3ORpjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrslqC/x9wFxxPzRY61wAytPWH+rPI4KoEvuWpp5ISX0+ppXosVAERa+G/LTfehjwSk60I5I8a9lsC+pyisF/7FJt/Xzm29x6FxxYMDclzrfAeNPux9dbSRDKpqA3qiBfCEgXITxMsG8ic08G5rEZxAjuOgEkEurSjpmFxMf6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Dxtc3Iua; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446BJ1F0003880;
	Mon, 6 May 2024 15:34:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=e0iJNwbkjqx7aPApDiTXKG/i88K6O8VACabscAgkWYE=; b=Dx
	tc3Iuak1QrRVHerDv/Rx1mXzRRji1UXd5mJTR59p71PONsNDULWW7xoNwOiyQF+V
	Kdk4LehMHol81uUf3u/PxHIRGlWxvbZx17Ly0IUnWjDBZUAmQICPxEUTVn6dTOP4
	/Ru1jBNGpSfobk4dWt0ozgVCZJoKZFprYmBCYKoeMzYzqi9U8MgNoZG82w75rjmk
	mQrQcet8y5A+QsiWJy/FHqv6dXqEAg6f+SAMMe5TjwbEPN6ADA9eMsWgY6aGkLs0
	mIRWpmtghcVZuao2UD0VdZ/z8yTYA9kaCfe5kQV8hRtN3xFFiKXlg/U8IrLLlGOn
	zJqMnF1rQwwwxISrLvdw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwcbx785t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:34:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D8A8540048;
	Mon,  6 May 2024 15:34:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F1852207A7;
	Mon,  6 May 2024 15:34:14 +0200 (CEST)
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
Subject: [PATCH 8/8] arm64: Kconfig: allow build irq-stm32mp-exti driver as module
Date: Mon, 6 May 2024 15:32:56 +0200
Message-ID: <20240506133256.948712-9-antonio.borneo@foss.st.com>
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
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index da85e0d49686f..24335565bad56 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -302,7 +302,6 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
-	select STM32MP_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI
-- 
2.34.1


