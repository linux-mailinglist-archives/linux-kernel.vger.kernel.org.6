Return-Path: <linux-kernel+bounces-377485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95FF9ABF82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D14FB2575F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403B14B94B;
	Wed, 23 Oct 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rPoMZhb+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEE156644;
	Wed, 23 Oct 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666681; cv=none; b=deHkSyiRTl21ZlvEV9L99LGzr/RPRVgh0PiCmQFfvNeymSXyaDbJv+OnIivOTF1QqTTB/b3a7ORSnZvzgEoPxnWzLR4wU2kEJBlgw9fNyZQ6nqkJY0f6nPFK1lB1xAUM/WqWTgdNsOgWKhInviBETJuEatqq8PJbSbrF4C8pVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666681; c=relaxed/simple;
	bh=SD0t/sB4jMcLlaeRbo582FoNZeHhndtyvenkgionDlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kxFtGpBTYBI/EMXh+zQIDj2/vyVs06b16qzU25sMld2jx7z48Mv/cvZ05/kHqdMhlmm5YJfVW+Iy1rQmfNTaOtDYAbWA2/t1F6OACM0uBqBnD5XoXeEyHzl8TfSHeeY301zfYIGku85BDsdh32m/xBHYgD8CwLZ+VCQOT45q3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rPoMZhb+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vscv062306;
	Wed, 23 Oct 2024 01:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666674;
	bh=a1eOmqTrAoin3Q1UNDx+Rj2xu2btZLXbar6kaPL5koY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=rPoMZhb+2/7A0wJlrWKMh8LG/DU8HoazKOuw2iau+tFuolCM2gdmpDfrNA68W1us0
	 PmtVvaDzpPCuWXlZy4FrLSZb/l427C2xFLCNhJvtj7YYx/F/+uqQ0l0PvlU+Y0JkBj
	 C+FRY0YqeuyMC9QiDFvewPUqc4X9kcZ1fcQ+PrSI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vse7026642;
	Wed, 23 Oct 2024 01:57:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:57:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:57:53 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUR129058;
	Wed, 23 Oct 2024 01:57:50 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:18 +0530
Subject: [PATCH v5 04/12] arm64: dts: ti: k3-j721s2: Add bootph-*
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-4-a974d06370ab@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=4018;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=SD0t/sB4jMcLlaeRbo582FoNZeHhndtyvenkgionDlM=;
 b=CwFi3pQ98wLrQyFXukPwk5HZ9zt0+bKKLDVOo+oWjl0gyvSIlQuFbIo15meX/URo/h12xgAD8
 hxOGsCoQZ0PAJhztft7yFwIGYDVGfiUp3B14aFLXNmpeDhbGYzYbZyA
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
- wkup_vtm for enabling Adaptive voltage scaling(AVS) support

Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    R-by picked up in v3 ( Andrew )

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9..9889144d665a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -816,6 +816,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: spinlock@30e00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 9d96b19d0e7c..c36888c45531 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -21,16 +21,19 @@ sms: system-controller@44083000 {
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
 
@@ -43,6 +46,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -53,6 +57,8 @@ secure_proxy_sa3: mailbox@43600000 {
 		reg = <0x00 0x43600000 0x00 0x10000>,
 		      <0x00 0x44880000 0x00 0x20000>,
 		      <0x00 0x44860000 0x00 0x20000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -167,6 +173,7 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 1>;
 		assigned-clock-parents = <&k3_clks 35 2>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
@@ -361,6 +368,7 @@ wkup_i2c0: i2c@42120000 {
 		clocks = <&k3_clks 223 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+		bootph-all;
 		status = "disabled";
 	};
 
@@ -469,6 +477,7 @@ mcu_ringacc: ringacc@2b800000 {
 			      <0x0 0x2a500000 0x0 0x40000>,
 			      <0x0 0x28440000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			bootph-all;
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
@@ -488,6 +497,7 @@ mcu_udmap: dma-controller@285c0000 {
 				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
+			bootph-all;
 
 			ti,sci = <&sms>;
 			ti,sci-dev-id = <273>;
@@ -507,6 +517,8 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x00 0x2a480000 0x00 0x80000>,
 		      <0x00 0x2a380000 0x00 0x80000>,
 		      <0x00 0x2a400000 0x00 0x80000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -667,6 +679,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x0 0x350>;
 		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	mcu_r5fss0: r5fss@41000000 {

-- 
2.46.0


