Return-Path: <linux-kernel+bounces-570987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED251A6B799
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762C13B6B69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086708BEE;
	Fri, 21 Mar 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rkcrwHz/"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23861F152F;
	Fri, 21 Mar 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549703; cv=none; b=qaoHu+ZhSFYlWWcQ/h1FxDyGfbWB342zdAPcG0nCH3xqocC0BvoX0Ewa/zyr8RtT6Hvi23ggoVsbklSmm3YrspjwE10bO0r7FVtBfqEIycJUHPwtb/lHp0PYWL5ywOYLTkhOfQ6WnaPX7SwgZRmd0uknAT5C1VnHfFA0g73k9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549703; c=relaxed/simple;
	bh=lzKRj1Qb5vjVpjNne0/J9zvSoMOYMN2jZampkJFVKcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kT5mwSCarnpcFnyCGBh+uGR2u+rtFXnK9m6u3tUrw6AyNGJtCUmlH5+OXmLf6wHvuD9+KJw8TKJob5a2Ys0e2qtOGtG6I/Yz10obHsm91jzp4fzJvQA8pc3ImszvVAECG6Ux4tqGhCaO8AWlgjc09KQFc+SxmDB9oYYqRMWw7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rkcrwHz/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7WrfA022737;
	Fri, 21 Mar 2025 10:34:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	V1lMKEFGv2/QjaQVW/hG+Gv406xIyxp5uxicASuOK5A=; b=rkcrwHz/N1HNUvvx
	1Lrb2GALfyXGlrgLsb/2XsG5eGh6x+NAAjVfO1r6b2hcRBGHjAr/RMd/0eGZvbeE
	05Ekcb57PJnH/uBXeTDDYLEwQ/C0Npepenyw2EjrqPPDGLvieAeGRmgPhXREcXJh
	jLZEX015VaaF+e8FbjaUJDuI4kBIPjVCznWiVMD80ud21CP6fnazC+izFUgPj2Q3
	2m0Mx7lSbL64RF4uV2mMTCT2aN2wrQ/A+6EIP5nt0CSnQh6MJXkv2/6HBKnjVHB2
	YhKgcVI1Nd8LSma7E0KEKBJFUs/zT8HfvUL/I+IDYXW38sufGfoZJTqyy8jjdQNi
	pcfUlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45h3tqrn88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:34:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B9F274005F;
	Fri, 21 Mar 2025 10:33:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 060347BD046;
	Fri, 21 Mar 2025 10:32:29 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:32:28 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 21 Mar 2025 10:32:24 +0100
Subject: [PATCH v6 4/7] arm64: dts: st: Add OMM node on stm32mp251
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-upstream_ospi_v6-v6-4-37bbcab43439@foss.st.com>
References: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
In-Reply-To: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01

Add Octo Memory Manager (OMM) entry on stm32mp251 and its two
OSPI instance.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index f3c6cdfd7008c5b736ba75f5210d0eddb5b43489..d1f30c76b41d68f5d7da7998b0edbceb93ce4a12 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -768,6 +768,60 @@ rng: rng@42020000 {
 				status = "disabled";
 			};
 
+			ommanager: ommanager@40500000 {
+				compatible = "st,stm32mp25-omm";
+				reg = <0x40500000 0x400>, <0x60000000 0x10000000>;
+				reg-names = "regs", "memory_map";
+				ranges = <0 0 0x40430000 0x400>,
+					 <1 0 0x40440000 0x400>;
+				clocks = <&rcc CK_BUS_OSPIIOM>,
+					 <&scmi_clk CK_SCMI_OSPI1>,
+					 <&scmi_clk CK_SCMI_OSPI2>;
+				clock-names = "omm", "ospi1", "ospi2";
+				resets = <&rcc OSPIIOM_R>,
+					 <&scmi_reset RST_SCMI_OSPI1>,
+					 <&scmi_reset RST_SCMI_OSPI2>;
+				reset-names = "omm", "ospi1", "ospi2";
+				access-controllers = <&rifsc 111>;
+				power-domains = <&CLUSTER_PD>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
+				status = "disabled";
+
+				ospi1: spi@40430000 {
+					compatible = "st,stm32mp25-ospi";
+					reg = <0 0 0x400>;
+					interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&hpdma 2 0x62 0x00003121>,
+					       <&hpdma 2 0x42 0x00003112>;
+					dma-names = "tx", "rx";
+					clocks = <&scmi_clk CK_SCMI_OSPI1>;
+					resets = <&scmi_reset RST_SCMI_OSPI1>,
+						 <&scmi_reset RST_SCMI_OSPI1DLL>;
+					access-controllers = <&rifsc 74>;
+					power-domains = <&CLUSTER_PD>;
+					st,syscfg-dlyb = <&syscfg 0x1000>;
+					status = "disabled";
+				};
+
+				ospi2: spi@40440000 {
+					compatible = "st,stm32mp25-ospi";
+					reg = <1 0 0x400>;
+					interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&hpdma 3 0x62 0x00003121>,
+					       <&hpdma 3 0x42 0x00003112>;
+					dma-names = "tx", "rx";
+					clocks = <&scmi_clk CK_SCMI_OSPI2>;
+					resets = <&scmi_reset RST_SCMI_OSPI2>,
+						 <&scmi_reset RST_SCMI_OSPI2DLL>;
+					access-controllers = <&rifsc 75>;
+					power-domains = <&CLUSTER_PD>;
+					st,syscfg-dlyb = <&syscfg 0x1400>;
+					status = "disabled";
+				};
+			};
+
 			spi8: spi@46020000 {
 				#address-cells = <1>;
 				#size-cells = <0>;

-- 
2.25.1


