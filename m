Return-Path: <linux-kernel+bounces-220711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBD90E5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2185D1F22702
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE867E576;
	Wed, 19 Jun 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iyY9kohw"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB687CF25;
	Wed, 19 Jun 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786248; cv=none; b=RF0SdpVszohgs2G+SiDprZereHfflJMrnmD29w3SlB8NQzKLlHkDi3XUE9X3v69bClokQixA3055MAHCux9U6L7AFHKXC7tzuLubBOU/Uxl5zQkE25b5BaVXn/3vyr+lW8//d51iLZYdA6iVKz3Rxi0zY8JJgrTsplPmq5PZyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786248; c=relaxed/simple;
	bh=nFKs7XfUvvbg1x9MrRmHrc2hxXu3H/G1BGEZiOFAh5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv6eze8RHteFctzmLFrc1M4mzSGsglmOx0izraV2BdaptjzTDNdX4UqfLeCf+6pufwiwrl0Bl4F5JY4NBpo9dOOb233LodgTf9F8QxY7L6vmSpnOf0mf6xH5+TblIYNGOnIjuJUqANiLhFaiYUwV2nIc8QxzcOpDK/Sz4uKNXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=iyY9kohw; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7V3bG030750;
	Wed, 19 Jun 2024 10:37:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jSkBEJRoXh8EzDoRBrIacJqbFlqlu5She/THheywmOI=; b=iyY9kohwE/7ow2ta
	jkpPgR89iDefxuJWnRKHhwuEk+oyBjdelxbFGKNq66lQW0vs38OOk2F8PJnaTKoG
	6jRnoBXwoayGOBDZwahI4Wwr5aX8fZleOPcIg1RorntjhDbyjMPJr0PjzNdZ/Ak1
	YHFxkqHS1S6T5VmjmJ2Tl6ZUby/Zw2dPqtgGlvlwZ4uApNPBofWuPFRn3osYrqk2
	GPsmxVIBU6Z7bOzpish3q12z7GvQ1hneu6CsdBpWKuwB1VabSdB4VmFl872G0MX7
	OKNsL2CvAJVA1R/PHYogyvbjUPEQX7wwNE2AGVZECUMsOO1smDOZtvD8Q9sgSeKX
	kUT84g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuja1a356-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:37:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4128C40044;
	Wed, 19 Jun 2024 10:37:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0503210728;
	Wed, 19 Jun 2024 10:36:13 +0200 (CEST)
Received: from localhost (10.48.86.232) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 10:36:12 +0200
From: Pascal Paillet <p.paillet@foss.st.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: <p.paillet@foss.st.com>, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 4/4] arm64: stm32: enable scmi regulator for stm32
Date: Wed, 19 Jun 2024 10:36:02 +0200
Message-ID: <20240619083602.33007-5-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619083602.33007-1-p.paillet@foss.st.com>
References: <20240619083602.33007-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01

Add SCMI ARM REGULATOR configuration for stm32.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a52618073de2..dab964bc70ca 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -312,6 +312,7 @@ config ARCH_STM32
 	select STM32_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
+	select REGULATOR_ARM_SCMI
 	select COMMON_CLK_SCMI
 	select STM32_FIREWALL
 	help
-- 
2.34.1


