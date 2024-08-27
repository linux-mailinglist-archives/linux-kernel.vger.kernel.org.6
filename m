Return-Path: <linux-kernel+bounces-303499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF2960D10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31E31F22500
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C071C4EE0;
	Tue, 27 Aug 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JGK4P1r+"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671E1BFDEC;
	Tue, 27 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767565; cv=none; b=cYxN33aPsvpsipqffVMiMcgVscgqvv7/5HW73vZvnuGf06BKf7uU/LPjs5KBx03dOvr7/FvcO2U1IiwlYIMzYjEfCPnLQ7nFn4pnPMuhnfrqN8puRjLaDELY14+jyIKl0T6NonAB+xI+c+xzXqSMzoFI9JFHJbEVB2/ySMZavkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767565; c=relaxed/simple;
	bh=wa4v/gifRTnHNth7+e9UNt0e/z9VrA5uaDZkfGSYVSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyXa94CGTmBVs/mKtoK+BrNwhIJEjNO/mE/6On1pVcrwfyUomiZpXxJNpMmTED/MgCrFJwinc48suc3LMXUr565UvfijaDbv3rtJHFthVp0yff9x/0I/0seVLtLx6hjiiOOnJhbN9AacVCaeBQE7MCDSLFbFP4Rp5yAf3y0IlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JGK4P1r+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RDMedB029054;
	Tue, 27 Aug 2024 16:05:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2rAPjNB+sb5NrXdg340Hwji5//uDGrMk166lc04CQr4=; b=JGK4P1r+1oUeYbzF
	Ct7/Sdv7Lv8WKenRtCo7B2fsqHikkLXhj6CgjjP8kwBI9/UlqcP5ozO8Ypof0tOT
	vJJF4B8Z+C2qpIm9iSzdlD6otEojF7NPNDA3c+YWXK/JVk9jpX1wO66thiSHRiJ6
	Bl1FAzpnZiefGV8gebVkzyyfdvM26LBg3+lLNKuR8fApbVkYH/SpQ0MzMJKeeLmV
	D7dt0nD29BwnAS99aj4bidivBJ73utoZrB2pNjqdpwQYelCf7CUCXZTXh/B7ggas
	BP/Q9U4FrDyyBEfyZvgF7LlC0fyyuTm0XMbCMmXm4o2BXPsPXp7Uxw8UlSCOBtAy
	gisU6A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419fmp862y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD2EB40048;
	Tue, 27 Aug 2024 16:05:45 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3ECFB26C462;
	Tue, 27 Aug 2024 16:05:16 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:17 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:15 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH 7/9] arm64: dts: st: add RTC on stm32mp25x
Date: Tue, 27 Aug 2024 16:04:53 +0200
Message-ID: <20240827140455.345086-8-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827140455.345086-1-valentin.caron@foss.st.com>
References: <20240827140455.345086-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01

Add compatible, clock, and interrupt properties of STM32 RTC on
stm32mp25x SOCs.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 1167cf63d7e87..81f59a5b4f61a 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -916,6 +916,16 @@ gpiok: gpio@442e0000 {
 			};
 		};
 
+		rtc: rtc@46000000 {
+			compatible = "st,stm32mp25-rtc";
+			reg = <0x46000000 0x400>;
+			clocks = <&scmi_clk CK_SCMI_RTC>,
+				 <&scmi_clk CK_SCMI_RTCCK>;
+			clock-names = "pclk", "rtc_ck";
+			interrupts-extended = <&exti2 17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		pinctrl_z: pinctrl@46200000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1


