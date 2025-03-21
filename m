Return-Path: <linux-kernel+bounces-570984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5BA6B78E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EB9189C0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B21F76B9;
	Fri, 21 Mar 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2ZkPEjCX"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760C1F30A4;
	Fri, 21 Mar 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549690; cv=none; b=Epsxdt+JN1lpuS4/lvJnsyLnapNte0XrMDVTg6djMOhc3Gq8MQ2pQf5Yo62B3FqOMR0pQ6cld6vHlg5FyZSG1jCMfj6MPUYQlQcZUu1aQpIzZDXahSmkmyRweDoJUjzPiafBD2O6Bw+k3x459U5wwdEjiziqPwZFlXIWBOSYspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549690; c=relaxed/simple;
	bh=ebhkuwHDCbTCk517Yf3EWwLb58tnhgWDmZbagE4cwuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LV+2q8fZmZCMkKrOTy8V8mCX/J1bLP3L4Z2jpLahD2OGxx9Y69btxIXvMxQFf3VTBiXqucSfw1KwBQkToGUgvqWAgj/jtIW5rHzdPVOf3+Ow7O7tgambKSbVQLy/T2Q1izVVDd5uxuu0XdpyWf0iGlZWVtYnUH7h9+tF99mxHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2ZkPEjCX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7Y3vL019542;
	Fri, 21 Mar 2025 10:34:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	lzEPcnxH/rfQJo9TIMnt/3k/3cz9+pbA+HSHM757SuM=; b=2ZkPEjCX7c9h66Hy
	roo3U1NFlsFW6T92Nl+YLIi7exwOomsfXSk3Lgkrked7trBo2vOuA9PdNraGQsAA
	1X5n6/JF95GR4N5VkCEA3rPGh40bMDvrv4iAhR+BRGY0gisimqBox9SDcn0onR2p
	ZiXeLAOUDyI5NHZEcA+SfHbBjYlGTHszgnO/d3Ugg1s2XR9MVM4IEoFrcR6cLESQ
	VFbkFzW4sP9C4h+P6USC9ejt+9TyCcYaAoddjeeNETYFA0UfimH6prwuyatQqqEt
	J/jBmiSXSVbfPKJY4k5+0ooF7uzOdyetQeqJeixrRE7mPnsQMvFqA2Rty/6PBWtk
	ME6F0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45h3ua0m8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:34:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6AF9B40060;
	Fri, 21 Mar 2025 10:33:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A262C7BD1E1;
	Fri, 21 Mar 2025 10:32:30 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:32:30 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 21 Mar 2025 10:32:26 +0100
Subject: [PATCH v6 6/7] arm64: dts: st: Add SPI NOR flash support on
 stm32mp257f-ev1 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-upstream_ospi_v6-v6-6-37bbcab43439@foss.st.com>
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

Add SPI NOR flash nor support on stm32mp257f-ev1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 1b88485a62a1f837770654eee6c970208fef6edc..76970c15e04387383097874a814f42e867fc94b6 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -80,6 +80,11 @@ fw@80000000 {
 			reg = <0x0 0x80000000 0x0 0x4000000>;
 			no-map;
 		};
+
+		mm_ospi1: mm-ospi@60000000 {
+			reg = <0x0 0x60000000 0x0 0x10000000>;
+			no-map;
+		};
 	};
 };
 
@@ -190,6 +195,33 @@ &i2c8 {
 	status = "disabled";
 };
 
+&ommanager {
+	memory-region = <&mm_ospi1>;
+	pinctrl-0 = <&ospi_port1_clk_pins_a
+		     &ospi_port1_io03_pins_a
+		     &ospi_port1_cs0_pins_a>;
+	pinctrl-1 = <&ospi_port1_clk_sleep_pins_a
+		     &ospi_port1_io03_sleep_pins_a
+		     &ospi_port1_cs0_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	spi@40430000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		memory-region = <&mm_ospi1>;
+		status = "okay";
+
+		flash0: flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-rx-bus-width = <4>;
+			spi-tx-bus-width = <4>;
+			spi-max-frequency = <50000000>;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };

-- 
2.25.1


