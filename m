Return-Path: <linux-kernel+bounces-396795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46489BD23F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37A01C22963
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FE1D5158;
	Tue,  5 Nov 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="x8R29AaG"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478901D278B;
	Tue,  5 Nov 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823829; cv=none; b=LucTIb0pOemdeqp/DpK7jFMEW8lKEtFDqucCaDFHvZN7NEVTQkDu9Rigj9qyglMHbaufg9HZl9hGhBQql3fxfSfRORS4/hbZLhwuSJvZYlsl/j/AkYbndSf7fpsSyPoFuo9F1noxSRnyi5HUuRXdMIAIOZjUpNXijdkxGcuqYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823829; c=relaxed/simple;
	bh=yrD4Mpfvmqsx+YKmWeU3tvvOcvvoTqW9VuisW5Gr4Qc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ojUO4jEhXSEDZVz5gYOgdeJoERgLLWVqi1KUW7my38nlcO0g910USMQ/w61ajE6f6Bi/GDKdeK+n+qGIwMwyHrxoBomo1CISCa9lcxyGXfLZpYsa+0qi5b/5LfaaE4iQh4DW1Monfn8a4FjyqjMfjYyieeinedTjcZov/Vu8Ghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=x8R29AaG; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5B9tdI023031;
	Tue, 5 Nov 2024 17:23:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=aVMUkRdLkMCaG4A9wtB/vf
	WUp+xDSUG4XcTStCzpQHM=; b=x8R29AaGuHavJqJItWuwnwmCmqYRVtYRUh3RlD
	Gh3mrSvk9L3fagKy/uFabHvNeeQu680T3/0H/P+HcDmTEDr2Gz/bCTGS+noDPmuR
	qWWRCmjbfD0ByoIhStT+CyrEE8qyqLZyvQ1aTUnNG/C/m0+/Szt70GBZnAUEgUAt
	ammAUd7oMLQHp0Sua8LdImJIG/VERJzKXRe72OgIAyw3hTEl3NgUG+RsmeAYO4RQ
	gnn72DGWz+3kllTWTdQjnMj3YBHc4JTES2q7UAgHucaVJhm1O0WhcIbQydbqZeO0
	Szt4tgwuXhs9cLTts9OEmXbMGIscyq6LRB+byM0W3rzaJUJw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42nywnamjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 17:23:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 965C84002D;
	Tue,  5 Nov 2024 17:22:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25B3A267809;
	Tue,  5 Nov 2024 17:22:01 +0100 (CET)
Received: from localhost (10.252.16.126) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 5 Nov
 2024 17:22:00 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] arm64: dts: st: add spdifrx support on stm32mp251
Date: Tue, 5 Nov 2024 17:21:41 +0100
Message-ID: <20241105162141.712073-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add S/PDIFRX support to STM32MP25 SoC family.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 6fe12e3bd7dd..34970be2e0b3 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -267,6 +267,20 @@ spi3: spi@400c0000 {
 				status = "disabled";
 			};
 
+			spdifrx: audio-controller@400d0000 {
+				compatible = "st,stm32h7-spdifrx";
+				#sound-dai-cells = <0>;
+				reg = <0x400d0000 0x400>;
+				clocks = <&rcc CK_KER_SPDIFRX>;
+				clock-names = "kclk";
+				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&hpdma 71 0x43 0x212>,
+				       <&hpdma 72 0x43 0x212>;
+				dma-names = "rx", "rx-ctrl";
+				access-controllers = <&rifsc 30>;
+				status = "disabled";
+			};
+
 			usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
 				reg = <0x400e0000 0x400>;
-- 
2.25.1


