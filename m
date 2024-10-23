Return-Path: <linux-kernel+bounces-377486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC19ABF84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89858285E72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBD157E88;
	Wed, 23 Oct 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pws8I+LC"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273C157495;
	Wed, 23 Oct 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666685; cv=none; b=mch9Chq+8TgYTEp7NtJuJzczqjJyt8jynAdrHQ4W4DHoPYJyoYrQiF34qHwy4YN+4MZX4ob9jgm3hORwZ1NzUYcvxbyjSLI+CMhPJ8WVPGMjDKiheiDrnM7oP/3brx5t9z5Gt4wfHy/lewyiidIb32rYJaHViyerzhzFijk++pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666685; c=relaxed/simple;
	bh=321qdMBvKZl38Iov3lF4qlALZCMva5GifB0mZSEMoBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MXqWwUsu9fMX9A/S4HjsiIjB8f/w+TmTEcLgLerqGtpKh8yBtJ1JQnHuBZEJrbO9CPzsbjkGcKWbB1+Mv+zSZV78M8f/Kjf9ISdL0DEOjYEZm8OAWFcd4rWRnUI4CCw1WWZVd/HazxB+fmronepeMDv9jxS/RAITUj7GRhzM6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pws8I+LC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vw2w062322;
	Wed, 23 Oct 2024 01:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666678;
	bh=Cp5/vB4Ul1JNzt+qyhWhzAgo0FJPA1JSsJpZARFm/GA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=pws8I+LCGByJ2Lqzc94YmOPqViuPP+X4svtfOG1Rfgpw/2NeIsC/97smkRpTPCUs9
	 RkGSpD9gFUUDbJRglHWpxhbmXw4JmspIyQr3ddS8bRL90H1dQI1oN1FxJMVqUtuzoP
	 Is5KNsQ4Q3x3tVoNpugy9wcSg+Y8RIHgg4p37dzI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6vwAY068641
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:57:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:57:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:57:58 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUS129058;
	Wed, 23 Oct 2024 01:57:54 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:19 +0530
Subject: [PATCH v5 05/12] arm64: dts: ti: k3-j721e: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-5-a974d06370ab@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=3940;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=321qdMBvKZl38Iov3lF4qlALZCMva5GifB0mZSEMoBk=;
 b=TuRNyCzJftCOGZKV17jxQVEU2PUP95806mFPyh8SKMlKteXXRO791zZ7EtlUgj3lL96Hq8KPB
 /Auzj4qA/O+DJccbdpAcKPTk6/wGT/dFSC2nRQAk+qjrIOneXI/WNH2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Following adds bootph-* to
- System controller nodes that allow controlling power domain, clocks, etc.
- secure_proxy_sa3/secure_proxy_main mboxes for communication with
  System Controller
- mcu_ringacc/mcu_udmap for DMA to SMS
- chipid for detection soc information.
- mcu_timer0 for bootloader tick-timer.
- hbmc_mux for enabling Hyperflash support
- ESM nodes for enabling ESM support.
- wkup_vtm for enabling Adaptive voltage scaling(AVS) support

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0da785be80ff..af3d730154ac 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -226,6 +226,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		smmu0: iommu@36600000 {
@@ -2853,6 +2854,7 @@ main_spi7: spi@2170000 {
 	main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x700000 0x0 0x1000>;
+		bootph-pre-ram;
 		ti,esm-pins = <344>, <345>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 3731ffb4a5c9..cf5fb1160ada 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {
 		k3_pds: power-controller {
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
+			bootph-all;
 		};
 
 		k3_clks: clock-controller {
 			compatible = "ti,k2g-sci-clk";
 			#clock-cells = <2>;
+			bootph-all;
 		};
 
 		k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
+			bootph-all;
 		};
 	};
 
@@ -61,6 +64,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -112,6 +116,7 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 1>;
 		assigned-clock-parents = <&k3_clks 35 2>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
@@ -362,6 +367,7 @@ hbmc_mux: mux-controller@47000004 {
 			reg = <0x00 0x47000004 0x00 0x4>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x2>; /* HBMC select */
+			bootph-all;
 		};
 
 		hbmc: hyperbus@47034000 {
@@ -470,6 +476,7 @@ mcu_ringacc: ringacc@2b800000 {
 			      <0x0 0x2a500000 0x0 0x40000>,
 			      <0x0 0x28440000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			bootph-all;
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -489,6 +496,7 @@ mcu_udmap: dma-controller@285c0000 {
 				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
+			bootph-all;
 
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <236>;
@@ -509,6 +517,7 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x0 0x2a480000 0x0 0x80000>,
 		      <0x0 0x2a380000 0x0 0x80000>,
 		      <0x0 0x2a400000 0x0 0x80000>;
+		bootph-pre-ram;
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -687,6 +696,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x43000300 0x00 0x10>;
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	mcu_esm: esm@40800000 {

-- 
2.46.0


