Return-Path: <linux-kernel+bounces-233639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384391BA98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D26D283BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0B1514C0;
	Fri, 28 Jun 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BOeLudkI"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8114F9C9;
	Fri, 28 Jun 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565172; cv=none; b=aGCcRqexyDqGIJJukCzHZ/VvPRVGFvaecPJ1jsonUp0MV8fetn2xfAfWQgCPyyollJGcQVWtvKjZv1N0hneRDJdXaFVutjmCnyX5yR381MEu5rH4HAZKjmryoyUxV9uiyeTVjF0xk/CbQZKwcCOqbtJpMwhuLOhmjUwf4+dLOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565172; c=relaxed/simple;
	bh=UXtR4RS42xrG/bQ0m5u44ggsOqsWDIra3jHzkT/B7sQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnbpqtALVyFV/hIp8CkP+Q8AMEUf5/jGZqxI6RRqAIUBVGibjCNzxPYm2/LhzY77KQNGOkzU3+qdSu+RlJP7Rpvasa2RTDzReCDD7zStnbmMwEFMDCOXGOC0oOoLQEFRIRFEoyAI3sc1owxa3jwux+4N3U2z88CrDWGfSdYtKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BOeLudkI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8wi4K005043;
	Fri, 28 Jun 2024 10:59:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HSEeHUr0hh897plAMVxrPawkWTVmj0QotMkNEu3ecZk=; b=BOeLudkIy3GAV1Jx
	4fDQqmxx1bdJ9+pvpIrVAVa2J/56iOmy3mWa3oqBNIxtv2zgULX+deYsgiLIGmbx
	qIhGACwVApvzCfOfntJ/G3zm6xa2u02d6LENx7v6BWUBt+1+nSOhwyaLUCWKFM88
	VVNlmQ3Bz7irQ+pByLFqvsgMZM0MLey1W/5m50W3RMTl9vECOiIalK5faeT959Ez
	5ioYtrB3ZbRDejeuPiBo8pPwfpk2QMHsEI1b2nFAKs5/jhZxdA5g5GqdmrI3F+5H
	0xtFiWpiWb3XUODIDKGzxkBBCs1k+ltoWuUJBqkldhXJd11iiSqn0xjLKt8ZkhtW
	JnSSbg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1gsjpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:59:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 78DCD40044;
	Fri, 28 Jun 2024 10:59:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABF9B21ADAD;
	Fri, 28 Jun 2024 10:58:23 +0200 (CEST)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 10:58:20 +0200
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
Subject: [PATCH v2 2/4] arm64: dts: st: add scmi regulators on stm32mp25
Date: Fri, 28 Jun 2024 10:58:12 +0200
Message-ID: <20240628085814.1586186-3-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628085814.1586186-1-p.paillet@foss.st.com>
References: <20240628085814.1586186-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01

Add SCMI regulators description on STM32MP25.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 96d6de29c14c..18094dadc9c4 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/st,stm32mp25-rcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+#include <dt-bindings/regulator/st,stm32mp25-regulator.h>
 
 / {
 	#address-cells = <2>;
@@ -75,6 +76,40 @@ scmi_reset: protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
 			};
+
+			scmi_voltd: protocol@17 {
+				reg = <0x17>;
+
+				scmi_regu: regulators {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					scmi_vddio1: regulator@0 {
+						reg = <VOLTD_SCMI_VDDIO1>;
+						regulator-name = "vddio1";
+					};
+					scmi_vddio2: regulator@1 {
+						reg = <VOLTD_SCMI_VDDIO2>;
+						regulator-name = "vddio2";
+					};
+					scmi_vddio3: regulator@2 {
+						reg = <VOLTD_SCMI_VDDIO3>;
+						regulator-name = "vddio3";
+					};
+					scmi_vddio4: regulator@3 {
+						reg = <VOLTD_SCMI_VDDIO4>;
+						regulator-name = "vddio4";
+					};
+					scmi_vdd33ucpd: regulator@5 {
+						reg = <VOLTD_SCMI_UCPD>;
+						regulator-name = "vdd33ucpd";
+					};
+					scmi_vdda18adc: regulator@7 {
+						reg = <VOLTD_SCMI_ADC>;
+						regulator-name = "vdda18adc";
+					};
+				};
+			};
 		};
 	};
 
-- 
2.34.1


