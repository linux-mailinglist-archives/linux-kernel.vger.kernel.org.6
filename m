Return-Path: <linux-kernel+bounces-435379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248FB9E76E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D999718823D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5131FFC4F;
	Fri,  6 Dec 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="caFJ6Lyt"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7D206296;
	Fri,  6 Dec 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505672; cv=none; b=WcuAFAWHdmvk9GdpxT15maJ/CfkksDNin9LSM9ptLB/+9AmFjkvhQ79aXxzKEYFPfjhq224uriyLJisWpvN+KFciNYLZE82f5VwL+CUA+aDQJWjRHS2zjIMaAHtbB+HaDBYYUU3bI5zkGD/nuLtUutfX2mkRL3K9LuK3NqjX1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505672; c=relaxed/simple;
	bh=b5yfHRQ3WQZ7GoJks6OnGjxOc2bo5/DzkArzBCY+QgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7kYhxKv8nzs/MW4JNRkUcOoC8pBq1M/G+Zp0OldQ7mbQSMsU2Mn5AGThpbSpTyqqNvZTTM2ecnU33yqfvm2Egv4h6lba1OWdoDbEpsCXa/e2e6sF9zC43nzJLqDE7onA/zYVPDOFKiGUdrxfa/bzD9FVO+VmUj4zS5vX3bJcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=caFJ6Lyt; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6CiBsX017977;
	Fri, 6 Dec 2024 18:20:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=jnlcCs3H5ImZ7T8Lmudwer
	0XmkeISsLyy/yE335F2HU=; b=caFJ6LytSjeVQpvsrAyiNnmOzCtcssl7+z/tar
	2vqONMoKgX9UeoCr1vbKTNcHofsIT9AIMJGOTi3laHROiRNrImLqLSuc5gJK2mOG
	1M9fU1lY+aa9Wnu5JC4cmXZV+6cDLcltCaS3bYbhAhg7n2Z0OI6IdBM3gq3/rwFW
	80Ggnjvq1nt4nvfLzenBfYWEcD618JInIv7x6nuhkNsMY3LFetr12gVL7fy9VxAi
	dyduLPyBg47ZHlaDQRtluOBRBOjkMOlucYTKvSfHbrygQw1eIq5uK+tWtHrnPIRd
	xBsI6MEugPYXCka4G3OFo2IfHFVbVGspPKXZotALNWapo6Qg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43bwj6jan4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 18:20:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1A32D40044;
	Fri,  6 Dec 2024 18:19:27 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 034F029F32D;
	Fri,  6 Dec 2024 18:18:22 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 6 Dec
 2024 18:18:21 +0100
Received: from localhost (10.48.86.121) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 6 Dec
 2024 18:18:21 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: stm32: Fix IPCC EXTI declaration on stm32mp151
Date: Fri, 6 Dec 2024 18:17:59 +0100
Message-ID: <20241206171759.135342-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

The GIC IRQ type used for IPCC RX should be IRQ_TYPE_LEVEL_HIGH.
Replacing the interrupt with the EXTI event changes the type to
the numeric value 1, meaning IRQ_TYPE_EDGE_RISING.

The issue is that EXTI event 61 is a direct event.The IRQ type of
direct events is not used by EXTI and is propagated to the parent
IRQ controller of EXTI, the GIC.

Align the IRQ type to the value expected by the GIC by replacing
the second parameter "1" with IRQ_TYPE_LEVEL_HIGH.

Fixes: 7d9802bb0e34 ("ARM: dts: stm32: remove the IPCC "wakeup" IRQ on stm32mp151")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index b28dc90926bd..e7e3ce8066ec 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -129,7 +129,7 @@ ipcc: mailbox@4c001000 {
 			reg = <0x4c001000 0x400>;
 			st,proc-id = <0>;
 			interrupts-extended =
-				<&exti 61 1>,
+				<&exti 61 IRQ_TYPE_LEVEL_HIGH>,
 				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "rx", "tx";
 			clocks = <&rcc IPCC>;
-- 
2.25.1


