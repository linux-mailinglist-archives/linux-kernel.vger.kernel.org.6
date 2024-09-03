Return-Path: <linux-kernel+bounces-312893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B0969D39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94265284B43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAD1D86CE;
	Tue,  3 Sep 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="I1MUxmz3"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEA1D096F;
	Tue,  3 Sep 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365691; cv=none; b=QjEH70Oayg7wCpKnRQ35lLRZp/8KwMs2+LDGjR8pDa5xfDuaEkRhk06EqJQoxQ+F545+K32dhdFMnWVsz+2TKttZxVGykqVeQ2rHYBqtmhKR1FxZIjuNhVxcLlbFCW2CzRjawLO57YeBawDlgQouUbGoOK7JJjMHFukvdpSFM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365691; c=relaxed/simple;
	bh=I20UKD7TQvAFU5EVSACkB6b8Z2rW1py26Q1UcKXaY+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnaOmBP4J3+62THR7JwJEl7mYk2PYzFEmBpupFcBXRm4N7Kiinlj3G6EI16rQSuBAvj5AOJbojNN1oASZYHNRASstZEHI19Cbby4MGar7GWzLvFMF76oOU8WhGeg/aQmGUCBG7YqvtiMIXwZiFwd8phuWRpnfrt9lzti+iAYAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=I1MUxmz3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BjWrK029157;
	Tue, 3 Sep 2024 14:14:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4fv1sQ8oNVXZbR6VQwj242LUMa622njNgXPkguclEbo=; b=I1MUxmz3cOGkiLP7
	p6lAVo2Rbxi5onojVpACO2ItCYvkNRF1CCEbaq8tAtnJ1xzs3GGi9pIhZOKNLGrt
	ZuMSGJ6kKA99pF5bb6YoJnFnIKnkbdT008Wr8VtoaaViXpUVEr4lGNZE00JzGRWi
	Wcm6HpBouEqAEBsVSv3gYeVaZUscWwtWGjMzY5Lk+VYzuJWQViUBVqHFnz4NQqIT
	PdZirqVrCRkMo5PLbKI2tkoTEG7u1ka9GojERIxzVZOhM40YYhDYn+Rkz65Uipi2
	i+fAizePpuCtRQrOwsJFtBMCWp4gSoniK4CYFEOg2EvC73/LCyRP6f6y+DPNjs0j
	UvEzXQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41brkg4pme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 14:14:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0A43940044;
	Tue,  3 Sep 2024 14:14:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A2C924E9C3;
	Tue,  3 Sep 2024 14:13:30 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Sep
 2024 14:13:30 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v5 4/5] arm64: dts: st: Add combophy node on stm32mp251
Date: Tue, 3 Sep 2024 14:13:02 +0200
Message-ID: <20240903121303.2953150-5-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903121303.2953150-1-christian.bruel@foss.st.com>
References: <20240903121303.2953150-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

Add support for COMBOPHY which is used either by the USB3 and PCIe
controller.
USB3 or PCIe mode is done with phy_set_mode().
PCIe internal reference clock can be generated from the internal clock
source or optionnaly from an external 100Mhz pad.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 1167cf63d7e8..b596afec1b6e 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/st,stm32mp25-rcc.h>
 #include <dt-bindings/regulator/st,stm32mp25-regulator.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	#address-cells = <2>;
@@ -518,6 +519,21 @@ i2c8: i2c@46040000 {
 				status = "disabled";
 			};
 
+			combophy: phy@480c0000 {
+				compatible = "st,stm32mp25-combophy";
+				reg = <0x480c0000 0x1000>;
+				#phy-cells = <1>;
+				clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
+				clock-names = "apb", "ker";
+				resets = <&rcc USB3PCIEPHY_R>;
+				reset-names = "phy";
+				access-controllers = <&rifsc 67>;
+				power-domains = <&CLUSTER_PD>;
+				wakeup-source;
+				interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
+				status = "disabled";
+			};
+
 			sdmmc1: mmc@48220000 {
 				compatible = "st,stm32mp25-sdmmc2", "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00353180>;
-- 
2.34.1


