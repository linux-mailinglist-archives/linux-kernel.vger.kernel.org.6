Return-Path: <linux-kernel+bounces-377487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB539ABF86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD21F233C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B415854F;
	Wed, 23 Oct 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xunfgByS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117F15853E;
	Wed, 23 Oct 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666691; cv=none; b=InzK2OX8lj+uZ1BedcVaSEn9DGNxlk6zwZSY5rDOGhnrNOxHlVsRnirKqTp4tpbctPfzPDApZcnGk9YBlkegOwFEVpaV5tmlHMhoJ+Go5DcA8LFqxDPH9d8hpoeEp6C4r0uUx5M4bjW87Qt0wYZuU5PnJEM+9QHwUuJN1HXCLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666691; c=relaxed/simple;
	bh=jfhR6o+OxuLC73jUZM+AI82eotkh8amZ1FwWcjhibEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pZWb//4nPZDDOEtHUdubgoNUOPeWdkEbgm6/c+TUFOhK7PYSCnH2EVFrolhfua3cFXvxwHzOfCTo2P3pomfb/f+byJUbQ3v8adSCazPpIYUmkGlY5diXLaInetmJvb1G06hn4sbuqzfyydsnKmjYRIhAMn3YAJsd6TgkDW8XXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xunfgByS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6w5Q7062340;
	Wed, 23 Oct 2024 01:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666685;
	bh=Inalt06sAy+j+KPFKvpl0FEGoIPLNAWiO9Gizptj6c4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xunfgBySBpQAek63Z7HG8FwsvEHhEBK2k4c4VvaLNyK9tezFFdOxzIc/Hd0lC9nEG
	 BKpco2xFXjb9Pe4RpU/cYFgpGYl3J67NEI4w7Qtx8ad+U350/BLRuMWIJ/Osg8F6hI
	 q4t4SveSk/zo4BI5fja4zXOH5zdoYgSEQV0IclhE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6w5sj055823
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:58:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:58:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:58:04 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUT129058;
	Wed, 23 Oct 2024 01:57:58 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:20 +0530
Subject: [PATCH v5 06/12] arm64: dts: ti: k3-j7200: Add bootph-* properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-6-a974d06370ab@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=3883;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jfhR6o+OxuLC73jUZM+AI82eotkh8amZ1FwWcjhibEw=;
 b=ckUfhJMXbfghdr2pMEpSCNk6t+A4aaODUFsz50VIZoYC9qcmeruOn0Dejg1jg/pamYagy1p+a
 n9gtPZli8CaBaZy4jVr9cwoFyA7lRYGOsdWaTJFIk0IVj5ZXRFzD8ZL
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
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f6..ac9c0a939461 100644
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
index 5097d192c2b2..7e9ad2301937 100644
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


