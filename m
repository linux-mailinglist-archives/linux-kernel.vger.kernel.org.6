Return-Path: <linux-kernel+bounces-521478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99734A3BDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186603B086D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1F1E0DCD;
	Wed, 19 Feb 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i5+Mfzr4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5401DE89D;
	Wed, 19 Feb 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967734; cv=none; b=gtDxHicwwzkTdbk+SR1uXfmQvDhWkmvquut5PqfWpxRSGLvSbAiov5/9+Rf9nXNEPEYKFlnWe8rCh9aVfsZvxUAxhPfnaHAmanTrJF/o0jpHKecbpOGS/ey55XYXSiRKRUkUs9G7vgo9INJVazVkYmW45OKFsrjb8CdqVD2V9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967734; c=relaxed/simple;
	bh=VZcpZOExLYYrTPAdbIs9tmOF3woEkgLeHqKPUO4W0Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3B9f0THXpd70fAsma11zuPn/1Xce2+bYy2/D/BRI33Ih9weFEoaD4bpDjj586x4ta3/bnav9EKQuFWR8ZKz5K+I0/UKKX1zBo3XGvWvY+SlEOiviD6hdsSRu0ayHuyvAdaBxGfy4LnZEGGBqUEcUpDL4nRzJfvIN3DSH4i3Zok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i5+Mfzr4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739967730;
	bh=VZcpZOExLYYrTPAdbIs9tmOF3woEkgLeHqKPUO4W0Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5+Mfzr453y2ACTWtOOE3D9tvfohKg6v2r5LJ+ZZy4C1WggCdoAW+GS7+IzSsDErR
	 m50g+np3/kfR27FqqB/j6nGlqgn83bIzrU0OJO4ZDmfIZKrRzvyWLs+/qtA/RTALiM
	 2eT/503JPf1Una3P37gu7+wR2plLa8XMBZ5Wr57Z+bZjYHrJbtQN/fkRXN4quTGTpG
	 5yG0D5HIKhrXFDCzSiGjixZoEQf46pnHDDIMZnf4mLdzw6XQrqK6qEi28ahyKf1NAd
	 zm/PQHh44uyw0X+AyclAtch+FFRhEvaD+nPf+3vP/RH1JwZTapsKjcbEwlFfT90HCQ
	 12EEQ7U5ajSPQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 440CF17E14D5;
	Wed, 19 Feb 2025 13:22:10 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	andre.draszik@linaro.org,
	angelogioacchino.delregno@collabora.com,
	linux@roeck-us.net,
	shufan_lee@richtek.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe USB
Date: Wed, 19 Feb 2025 13:22:05 +0100
Message-ID: <20250219122206.46695-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219122206.46695-1-angelogioacchino.delregno@collabora.com>
References: <20250219122206.46695-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8188 SoC has three USB controllers, and all of them are behind
the MTU3 DRD controller.

Add the missing MTU3 nodes, default disabled, for all USB controllers
and move the related XHCI nodes to be children of their MTU3 DRD to
correctly describe the SoC.

In order to retain USB functionality on all of the MT8188 and MT8390
boards, also move the vusb33 supply and enable the relevant MTU3 nodes
with special attention to the MT8188 Geralt Chromebooks, where it was
necessary to set the dr_mode of all MTU3 controllers to host to avoid
interfering with the EC performing DRD on its own.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 +++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 ++++++++++++------
 .../dts/mediatek/mt8390-genio-common.dtsi     |  28 ++++
 3 files changed, 125 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index b6abecbcfa81..faed5c8bc721 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -1103,6 +1103,12 @@ &u3phy2 {
 };
 
 /* USB detachable base */
+&ssusb0 {
+	dr_mode = "host";
+	vusb33-supply = <&pp3300_s3>;
+	status = "okay";
+};
+
 &xhci0 {
 	/* controlled by EC */
 	vbus-supply = <&pp3300_z1>;
@@ -1110,6 +1116,12 @@ &xhci0 {
 };
 
 /* USB3 hub */
+&ssusb1 {
+	dr_mode = "host";
+	vusb33-supply = <&pp3300_s3>;
+	status = "okay";
+};
+
 &xhci1 {
 	vusb33-supply = <&pp3300_s3>;
 	vbus-supply = <&pp5000_usb_vbus>;
@@ -1117,6 +1129,12 @@ &xhci1 {
 };
 
 /* USB BT */
+&ssusb2 {
+	dr_mode = "host";
+	vusb33-supply = <&pp3300_s3>;
+	status = "okay";
+};
+
 &xhci2 {
 	/* no power supply since MT7921's power is controlled by PCIe */
 	/* MT7921's USB BT has issues with USB2 LPM */
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index d2e1ff7236b1..2b797f160556 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1649,6 +1649,38 @@ spi5: spi@11019000 {
 			status = "disabled";
 		};
 
+		ssusb1: usb@11201000 {
+			compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2dff>, <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			ranges = <0 0 0 0x11200000 0 0x3f00>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupts-extended = <&gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_BUS>,
+				 <&topckgen CLK_TOP_SSUSB_TOP_REF>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x468 2>;
+			status = "disabled";
+
+			xhci1: usb@0 {
+				compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
+				reg = <0 0 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
+				clock-names = "sys_ck";
+				status = "disabled";
+			};
+		};
+
 		eth: ethernet@11021000 {
 			compatible = "mediatek,mt8188-gmac", "mediatek,mt8195-gmac",
 				     "snps,dwmac-5.10a";
@@ -1746,27 +1778,6 @@ queue3 {
 			};
 		};
 
-		xhci1: usb@11200000 {
-			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
-			reg = <0 0x11200000 0 0x1000>,
-			      <0 0x11203e00 0 0x0100>;
-			reg-names = "mac", "ippc";
-			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
-			phys = <&u2port1 PHY_TYPE_USB2>,
-			       <&u3port1 PHY_TYPE_USB3>;
-			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
-					  <&topckgen CLK_TOP_SSUSB_XHCI>;
-			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
-						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
-			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_BUS>,
-				 <&topckgen CLK_TOP_SSUSB_TOP_REF>,
-				 <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck";
-			mediatek,syscon-wakeup = <&pericfg 0x468 2>;
-			wakeup-source;
-			status = "disabled";
-		};
-
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8188-mmc", "mediatek,mt8183-mmc";
 			reg = <0 0x11230000 0 0x10000>,
@@ -1867,42 +1878,68 @@ imp_iic_wrap_c: clock-controller@11283000 {
 			#clock-cells = <1>;
 		};
 
-		xhci2: usb@112a0000 {
-			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
-			reg = <0 0x112a0000 0 0x1000>,
-			      <0 0x112a3e00 0 0x0100>;
+		ssusb2: usb@112a1000 {
+			compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";
+			reg = <0 0x112a1000 0 0x2dff>, <0 0x112a3e00 0 0x0100>;
 			reg-names = "mac", "ippc";
-			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
-			phys = <&u2port2 PHY_TYPE_USB2>;
-			assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_3P>,
-					  <&topckgen CLK_TOP_USB_TOP_3P>;
-			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
-						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			ranges = <0 0 0 0x112a0000 0 0x3f00>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupts-extended = <&gic GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
 				 <&topckgen CLK_TOP_SSUSB_TOP_P3_REF>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x470 2>;
 			status = "disabled";
+
+			xhci2: usb@0 {
+				compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
+				reg = <0 0 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
+				clock-names = "sys_ck";
+				status = "disabled";
+			};
 		};
 
-		xhci0: usb@112b0000 {
-			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
-			reg = <0 0x112b0000 0 0x1000>,
-			      <0 0x112b3e00 0 0x0100>;
+		ssusb0: usb@112b1000 {
+			compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";
+			reg = <0 0x112b1000 0 0x2dff>, <0 0x112b3e00 0 0x0100>;
 			reg-names = "mac", "ippc";
-			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
-			phys = <&u2port0 PHY_TYPE_USB2>;
-			assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_2P>,
-					  <&topckgen CLK_TOP_USB_TOP_2P>;
-			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
-						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			ranges = <0 0 0 0x112b0000 0 0x3f00>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupts-extended = <&gic GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+			assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
 				 <&topckgen CLK_TOP_SSUSB_TOP_P2_REF>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck";
-			mediatek,syscon-wakeup = <&pericfg 0x460 2>;
+			phys = <&u2port0 PHY_TYPE_USB2>;
 			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x460 2>;
 			status = "disabled";
+
+			xhci0: usb@0 {
+				compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
+				reg = <0 0 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
+				clock-names = "sys_ck";
+				status = "disabled";
+			};
 		};
 
 		pcie: pcie@112f0000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index a37cf102a6e9..fd977daa4185 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -1011,13 +1011,25 @@ &u3phy2 {
 	status = "okay";
 };
 
+&ssusb0 {
+	dr_mode = "host";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
 &xhci0 {
 	status = "okay";
+};
+
+&ssusb1 {
+	dr_mode = "host";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
 };
 
 &xhci1 {
 	status = "okay";
+	vdd-supply = <&usb_hub_fixed_3v3>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -1037,6 +1049,22 @@ hub_3_0: hub@2 {
 		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
 		vdd-supply = <&usb_hub_fixed_3v3>;
 	};
+
+	port {
+		xhci_ss_ep: endpoint {
+			remote-endpoint = <&typec_con_ss>;
+		};
+	};
+};
+
+&ssusb2 {
+	interrupts-extended = <&gic GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&pio 220 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "host", "wakeup";
+
+	dr_mode = "host";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
 };
 
 &xhci2 {
-- 
2.48.1


