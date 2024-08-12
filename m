Return-Path: <linux-kernel+bounces-283050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFC194EC58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B8F1F22D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38411178CC3;
	Mon, 12 Aug 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vTEqNrP0"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9916DC20;
	Mon, 12 Aug 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464455; cv=none; b=fbRW3A/7UMMiI7fo7+yMKi+HCkGQt6pX8fzisY+h0mSFtgLzG90hZaGCUQ1DngTXv9yRZYLUqgKO5f2SYsO/z2pe8TKdXKsMTy6yGPmhxgyxKnNY2Habja8Ng/ZdjJy2WYXVbiIFGBioRMeJTgT9AH2tG1X4eDC6PL2/k3Rpxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464455; c=relaxed/simple;
	bh=fKsUe9A7kBqEMQ6nt5hcdz/gwPVBF9m43Qz7I9Glhs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/GKe/0OsWe7Z+uSMkdXZbC5UJZWMJ1mI//NYWn/El9UX4UfRG1pmtgtS9Q5d2jK6QcUlybCV6OGtXvgXx1jBYT2/DpSio5xQj1ibA7b7jFtxW49z2f9gtwLlSU0U6FBE8rafhtfQAaTUIh6pZ1MKvrvW4JLL7C8oZVa0LTzwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vTEqNrP0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C8FgK5013752;
	Mon, 12 Aug 2024 14:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pTeACQH8vrLikG5sj1qKxusUbNQeLUfJGs6z7rZ2oF8=; b=vTEqNrP0pyN69X4I
	zu3CrnAcPbrsB4fPVmTvIJtp9+gGFsrX71mAk7wf/wBlvmjakdBnV6/7z1sjTYlW
	nh6ROQeQ9o+Z52yRt+WkFSzlIaLUqBCZdwBAy2Md/B8AxjyW1+tpkLpruR4wgilp
	LSz9ZsTiR+sUrdwL/VFZn7LfD3P+k3sXSV558PsyG/wlgQk2vaQ2lAYz4Eqb1Pdm
	rksuJ06Xo6abVHrqQkfAQkWZeR0qJNU+aSEhfEo2cdcMCquO3972CEZiEkd4/QXz
	O+XDhz7TdcJxLvmub/2/MPU82fbo0tCtSer2QkzFU9+2jyjlBlgtnTCazqdrul9E
	9lGOKQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40x170x9qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 14:07:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C654240047;
	Mon, 12 Aug 2024 14:07:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 218AF25AF10;
	Mon, 12 Aug 2024 14:06:19 +0200 (CEST)
Received: from localhost (10.129.178.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 12 Aug
 2024 14:06:18 +0200
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
Subject: [PATCH 4/5] arm64: dts: st: Add combophy node on stm32mp251
Date: Mon, 12 Aug 2024 14:05:28 +0200
Message-ID: <20240812120529.3564390-5-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812120529.3564390-1-christian.bruel@foss.st.com>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_02,2024-08-12_01,2024-05-17_01

Add support for COMBOPHY which is used either by the USB3 and PCIe
controller.
USB3 or PCIe mode is done with phy_set_mode().
PCIe internal reference clock can be generated from the internal clock
source or optionnaly from an external 100Mhz pad.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 1167cf63d7e87..4b99fa7e8e7a9 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/st,stm32mp25-rcc.h>
 #include <dt-bindings/regulator/st,stm32mp25-regulator.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	#address-cells = <2>;
@@ -518,6 +519,22 @@ i2c8: i2c@46040000 {
 				status = "disabled";
 			};
 
+			combophy: phy@480c0000 {
+				compatible = "st,stm32mp25-combophy";
+				reg = <0x480c0000 0x1000>;
+				#phy-cells = <1>;
+				clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
+				clock-names = "apb-clk", "ker-clk";
+				resets = <&rcc USB3PCIEPHY_R>;
+				reset-names = "phy-rst";
+				st,syscfg = <&syscfg>;
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


