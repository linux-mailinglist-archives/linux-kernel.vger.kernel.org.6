Return-Path: <linux-kernel+bounces-216988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FCB90A960
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F334C28B1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6A190074;
	Mon, 17 Jun 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="z2u0DRU9"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F521862A4;
	Mon, 17 Jun 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615742; cv=none; b=NSytmE5Ko+SyWTNNG8inl5cekMXayV6vFRCI56ThiFBtolwnuM/7HWIAVvqBi3G88CdmyEWc4lW8gbu78j3Jc2podth8rfVQ7oa5PTVpF3woN0En2OTVlzJUAOwwxJLL+IxgYR38eHvrK6NDAiU3n5yCZtUM00gdHab49IkN7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615742; c=relaxed/simple;
	bh=EQWalUMofBd6SSv/OrjoR1SwfyoNsF0LUtApc0kjLR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQIhOq/5Si2h+LLAisCMPhfONBiWzqLibKDXGOBM2nRndyFc8EP6ZY38kpK8WRCF1H5+1kB0Tka+fqssCa9ZqVZxFnR6dBuIczCQ0XE8uWC2+xs2JZhxrJYdhwe1sa8Z4hFQpBRal1IvCC1Z9LPEoXe5MyrVdATdsVPvpEMrY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=z2u0DRU9; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H89GsN019515;
	Mon, 17 Jun 2024 11:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=JLZNH/a/eRZb9WCTFRGCBR
	v/iJv/oPGQFOGXRp2/VCg=; b=z2u0DRU9HQmuiuWyqdfbGEB8Xnse3uxfsaYDNs
	xtyMikRXZrngqMK1w4ugFCFLR71TUMhG4N+5u9DPgb0j/6YWbC5565HrD2vh4PAR
	/HFuD0nDAaKUy3N9bOrPmv8HTZTK9ztkLAN3kOJScjTLaAGNR56jJZz8jThzmawW
	enjm8Ax4GJO5ffOhBWkLlnfHCeg8E3Xls5T4YfWWe8iQ8IVpIKAkeRPLRKja/MDP
	tGUCKGpssHy6CZZgK0lj8XpLD/7EgSKyvZrlSP+CYRVF3kguxDf3OmzGMjTxKR0o
	OPdLmJQRg24r5+OQNQoH8MlM5oWPGsyDHGlsiowI4POA3Bug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ysnwj3ksc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 11:15:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2792F40050;
	Mon, 17 Jun 2024 11:14:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36191211613;
	Mon, 17 Jun 2024 11:14:21 +0200 (CEST)
Received: from localhost (10.48.86.128) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 17 Jun
 2024 11:14:20 +0200
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <linux-kernel@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Etienne Carriere
	<etienne.carriere@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: OP-TEE async notif interrupt for ST STM32MP15x boards
Date: Mon, 17 Jun 2024 11:14:18 +0200
Message-ID: <20240617091418.2956380-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-14_03,2024-05-17_01

Define the GIC interrupt (PPI 15) to be used on ST STM32MP15x boards
for OP-TEE async notif.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 5 +++++
 arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts | 5 +++++
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 5 +++++
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
index 306e1bc2a514..847b360f02fc 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
@@ -62,6 +62,11 @@ &m4_rproc {
 	reset-names = "mcu_rst", "hold_boot";
 };
 
+&optee {
+	interrupt-parent = <&intc>;
+	interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+};
+
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
index 956da5f26c1c..43280289759d 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
@@ -68,6 +68,11 @@ &m4_rproc {
 	reset-names = "mcu_rst", "hold_boot";
 };
 
+&optee {
+	interrupt-parent = <&intc>;
+	interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+};
+
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
index 8e4b0db198c2..6f27d794d270 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
@@ -67,6 +67,11 @@ &m4_rproc {
 	reset-names = "mcu_rst", "hold_boot";
 };
 
+&optee {
+	interrupt-parent = <&intc>;
+	interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+};
+
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
index 72b9cab2d990..6ae391bffee5 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
@@ -72,6 +72,11 @@ &m4_rproc {
 	reset-names = "mcu_rst", "hold_boot";
 };
 
+&optee {
+	interrupt-parent = <&intc>;
+	interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+};
+
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
-- 
2.25.1


