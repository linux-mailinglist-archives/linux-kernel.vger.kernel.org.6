Return-Path: <linux-kernel+bounces-540594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E44A4B2A2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBFE16D4AD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112FF1E3DCF;
	Sun,  2 Mar 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jl0i48Gg"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7221E98E8;
	Sun,  2 Mar 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740929721; cv=none; b=ehG9K1xFhuhMG+SJO61P62xKJjbzTGYcLUcHNFM+B579E6zQXZfV5gyffvv9P45dEgW+2rfvxCz/uHYnwXiXYJuTGM9qiWSgg0y4BhMVNWGpDCJfFI+/y9oQogMkXe8JeUH8t6FFxMeC9IeIrrMnQ5plDhLfhJU3CIQ1bIAxSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740929721; c=relaxed/simple;
	bh=LKXB0Th2rgRfn6PmY/CvDPaZkFPUtT1qSCfrciSKGy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKX5nyMBhc1P2KQaZH0ckKFxIU9ZI2mSUE3ISAUhp0Lf0RcyX8RZnffidiYJ6zXYdDUBFXcpLMoPKrleX3Z+HPCLy8jpbKcx/NN9qKVMMJIyovd5q3Qy+fJG24bdq2GYfkK8n2iJjYy21a2h1ST7ZcyVXmWwSalS1hMx9e0o0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jl0i48Gg; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522FZ7C43048149
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 09:35:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740929707;
	bh=TrAEZZx34Y9eC/6let8EhmRjRQtxTE+1PPdJ5roz6mE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Jl0i48Ggy8Wa95EXVU1jY1FT+eJH6xrH4Ig1rSM0wTNwXt9t8Ul+UHsuIS8bBqsxr
	 LGhQmEWOCUTzkUeYU5WdsZg7SsvgBRDsh24CbPtjKe741BYIk52xcpATtafXFjJrTK
	 2fBjlngtzZwc5kIEKfvNvtov3PXxLLO3Ls+m0Pic=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522FZ7G8027406
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 09:35:07 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 09:35:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 09:35:06 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522FZ6Ox071853;
	Sun, 2 Mar 2025 09:35:06 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>
CC: <s-vadapalli@ti.com>, <c-vankar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62p5*/k3-j722s: Add bootph-all property to enable Ethernet boot
Date: Sun, 2 Mar 2025 21:05:02 +0530
Message-ID: <20250302153502.181832-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250302153502.181832-1-c-vankar@ti.com>
References: <20250302153502.181832-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Ethernet boot requires CPSW nodes to be present starting from R5 SPL
stage. Add bootph-all property to required nodes to enable Ethernet boot
for AM62p-SK and J722s.

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20250106123122.3531845-3-c-vankar@ti.com/

Changes from v1 to v2:
- Updated order of "bootph-all" property for cpsw_port1 node in
  "k3-am62p-j722s-common-main.dtsi".

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                | 2 ++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 6e3beb5c2e01..b88b8fa5f28a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -50,6 +50,7 @@ phy_gmii_sel: phy@4044 {
 			compatible = "ti,am654-phy-gmii-sel";
 			reg = <0x4044 0x8>;
 			#phy-cells = <1>;
+			bootph-all;
 		};
 
 		epwm_tbclk: clock-controller@4130 {
@@ -721,6 +722,7 @@ cpsw_port1: port@1 {
 				mac-address = [00 00 00 00 00 00];
 				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
 				status = "disabled";
+				bootph-all;
 			};
 
 			cpsw_port2: port@2 {
@@ -742,6 +744,7 @@ cpsw3g_mdio: mdio@f00 {
 			clock-names = "fck";
 			bus_freq = <1000000>;
 			status = "disabled";
+			bootph-all;
 		};
 
 		cpts@3d000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index ad71d2f27f53..28b08eb79da3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -226,6 +226,7 @@ main_mdio1_pins_default: main-mdio1-default-pins {
 			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
 			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -495,6 +496,7 @@ &cpsw3g_mdio {
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index d184e9c1a0a5..054425afd764 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -303,6 +303,7 @@ mdio_pins_default: mdio-default-pins {
 			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
 			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	ospi0_pins_default: ospi0-default-pins {
@@ -337,6 +338,7 @@ J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
 			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
 			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
 		>;
+		bootph-all;
 	};
 
 	main_usb1_pins_default: main-usb1-default-pins {
@@ -381,6 +383,7 @@ &cpsw3g_mdio {
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
-- 
2.34.1


