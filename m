Return-Path: <linux-kernel+bounces-379207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2C9ADB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9758F283978
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D291189BBC;
	Thu, 24 Oct 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yXjwPmTW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48751189BBA;
	Thu, 24 Oct 2024 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747303; cv=none; b=Erw/bw4mKyxsOGUK8coXlJ1OOfxznRgxn2FJA6wvWKZjkaDpZB4WRDWEz737qHennmNIss+hU04jz3kU6/h9ZV10BG1n2COrBfzsahFfwo5/TdJqnRiVIvuQzPqpC1l7ahchHokVcebMs2fWRaNbPd1hGAK9hHxMG7J1slgqLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747303; c=relaxed/simple;
	bh=+e7DyULu+zbi2MBflQ3mc5Pd1WsVYCh5tUg19KV3FrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E1iO/a8HqcsOLATb474dpfcSbFQkEd8RT6KEsFuozA14kk20g33bPhGBXTh18Fe0PmvRJQtdMPz9gaS/PwgB3r3F8afDvV0PtaRt6sDyeP6nOn/FzkZ8eET1kRLjMlFGQDlux5V4BPccj2gZt/u+924YL9y7QNTtXGBhG5FbtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yXjwPmTW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LZdv015379;
	Thu, 24 Oct 2024 00:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729747295;
	bh=25LTiQaKuWRxa6bEharIeerIXYAec2K2f1peaJTyKVY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=yXjwPmTWwnvevsar8MY+MRln6je9jFQ4yhL3dr776pn/5HgQ6B2P/gm5cUK/6qVP1
	 k4ib1jUei0jXsSlM/UaEBhFGQm064fpxVFXTl7+EmD5MeQ+xRl/dLQB0U4ATkZFEpC
	 pcSwI2YGTgxDl7mx3cV7szuaKNzUXNH/qJoZ5JeY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LZ66025069;
	Thu, 24 Oct 2024 00:21:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 00:21:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 00:21:35 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L4lE090467;
	Thu, 24 Oct 2024 00:21:31 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 24 Oct 2024 10:51:03 +0530
Subject: [PATCH v6 06/12] arm64: dts: ti: k3-j7200: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-b4-upstream-bootph-all-v6-6-2af90e3a4fe7@ti.com>
References: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
In-Reply-To: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729747264; l=4090;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=+e7DyULu+zbi2MBflQ3mc5Pd1WsVYCh5tUg19KV3FrQ=;
 b=EBw0rfALTAjO0gZwcC5ErMIgdJvyeBfKV6OzqRterPb18KyzEkS97GovvEDi1BrKxzdWQfXc2
 NQnM9Knfq7FBDy5uL1g181qcV343DCzYaCXtKQXTurKT+x3AiZ8WRWU
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

Reviewed-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    R-by picked up in v5 ( Aniket )

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f684474c817e22f0bbf657185b192d..ac9c0a9394615c23ca153c8ae9996e009ec2cf38 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -136,6 +136,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: spinlock@30e00000 {
@@ -1527,6 +1528,7 @@ main_r5fss0_core1: r5f@5d00000 {
 	main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x700000 0x0 0x1000>;
+		bootph-pre-ram;
 		ti,esm-pins = <656>, <657>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5097d192c2b208ffa702a38631d096995b4b53d5..7e9ad230193771e051ec0902cd826440280546b0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
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
 
@@ -44,6 +47,7 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 1>;
 		assigned-clock-parents = <&k3_clks 35 2>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
 		ti,timer-pwm;
 	};
 
@@ -191,6 +195,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -344,6 +349,7 @@ mcu_ringacc: ringacc@2b800000 {
 			      <0x00 0x28440000 0x00 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg",
 				    "proxy_target", "cfg";
+			bootph-all;
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -363,6 +369,7 @@ mcu_udmap: dma-controller@285c0000 {
 				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
+			bootph-all;
 
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <236>;
@@ -383,6 +390,8 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x0 0x2a480000 0x0 0x80000>,
 		      <0x0 0x2a380000 0x0 0x80000>,
 		      <0x0 0x2a400000 0x0 0x80000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -534,6 +543,7 @@ hbmc_mux: mux-controller@47000004 {
 			reg = <0x00 0x47000004 0x00 0x4>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x2>; /* HBMC select */
+			bootph-all;
 		};
 
 		hbmc: hyperbus@47034000 {
@@ -652,6 +662,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	mcu_esm: esm@40800000 {

-- 
2.46.0


