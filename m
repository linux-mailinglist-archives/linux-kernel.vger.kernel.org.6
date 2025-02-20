Return-Path: <linux-kernel+bounces-523489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D748A3D77E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3123AFF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F121F3FC3;
	Thu, 20 Feb 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cCHau766"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CD1F1517;
	Thu, 20 Feb 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048950; cv=none; b=CCmXWe8fjpKMs6eKiil3RegzVK4khdP67+7bUtT/Uml16aLbZr38gSsAAaHbbaxWt+/HqDpmL3Dyge0XVky58A5Px4GxHD15h8LtmuLHpa03jnDp99PDt3TLf+yM5nzB5yqb32JdnmAobWfI5vwtUyvAeGhySeqxT+EzapXhZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048950; c=relaxed/simple;
	bh=Z35cZXbC7YRfeFkNnzpPxiyQBC3KChpHkjPu5lnoNWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2s1O5olpOamlyuWTeP2F94XSw5ZEKAMKiV/vEZA8ZoiqJ/R9bEGq8QE4rR9ttKfO78RZYYbXSw1MDLVmg2NrZF4Ia4Jdn06IyHPEl74G/t/JgLEX3WhFA3u973YRvFpJNgir1Yko92SwI18SkBAwWVi5vWnN85znHYvGg/vRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cCHau766; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740048946;
	bh=Z35cZXbC7YRfeFkNnzpPxiyQBC3KChpHkjPu5lnoNWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCHau766hFtNy4LHmWAXPbzVkfOdjpeqNQujNy2JQcyn1DoQcholfDYTnctlZ3klk
	 aLSnGJgbxb56wcv8iNcbk/lqaUm3J+Cp+pUKhazMN4ND63ITine7KqhObfUJuA7K7C
	 MLIHPux2gCYMK59KBkV28Zo5ojJrlJVs2kNRp9O5DGwGhGgKoge507EEQ9jsZh5PKC
	 3U9LqWKVXCp3WpugVa6nmMMMxD9sykmyygsfnvir1RGRujApI0WJkV62rEtRcXrCEF
	 H0pJ3CNGzO3dosCKK8zDAra9o8vmqkMTVxPYAsFmHF0HAHR6SXlcoOrjFB7cQFkcLb
	 YDqVxBU1UeVgA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 764F317E1570;
	Thu, 20 Feb 2025 11:55:45 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v3 3/3] arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller, MUX
Date: Thu, 20 Feb 2025 11:55:14 +0100
Message-ID: <20250220105514.43107-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This board features multiple USB connectors:
 * One Type-C connector with Power Delivery and Alt. Modes;
 * One MicroUSB connector, also used for bootloader SW download;
 * One USB through the RaspberryPi-compatible pins header.

Add configuration for the MTU3 controllers providing OTG support
with role switching both on the MicroUSB port, RPi pins header,
and the Type-C port found on this board.

Moreover, add the Richtek RT1715 Type-C Power Delivery Controller
which manages current source/sink, linked to the iTE IT5205 Type-C
Alternate Mode Passive Mux, handling both mode switching between
USB (up to 3.1 Gen2 10Gbps) and DisplayPort (four lanes, DP1.4,
op to 8.1Gbps) and plug orientation switching.

All USB ports reside on different controller instances, and all of
them support host or gadget and can be configured as desired at
runtime.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8390-genio-common.dtsi     | 139 ++++++++++++++++--
 1 file changed, 130 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index fd977daa4185..83828baa887b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -260,6 +260,22 @@ &i2c1 {
 	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 	status = "okay";
+
+	typec-mux@48 {
+		compatible = "ite,it5205";
+		reg = <0x48>;
+
+		mode-switch;
+		orientation-switch;
+
+		vcc-supply = <&mt6359_vcn33_1_bt_ldo_reg>;
+
+		port {
+			it5205_sbu_mux: endpoint {
+				remote-endpoint = <&typec_sbu_out>;
+			};
+		};
+	};
 };
 
 &i2c2 {
@@ -281,6 +297,66 @@ &i2c4 {
 	pinctrl-0 = <&i2c4_pins>;
 	clock-frequency = <1000000>;
 	status = "okay";
+
+	rt1715@4e {
+		compatible = "richtek,rt1715";
+		reg = <0x4e>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tcpci_int_pins>;
+		vbus-supply = <&usb_p1_vbus>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			op-sink-microwatt = <10000000>;
+			power-role = "dual";
+			try-power-role  = "sink";
+			pd-revision = /bits/ 8 <0x03 0x00 0x01 0x08>;
+
+			sink-pdos = <PDO_FIXED(5000, 2000,
+					       PDO_FIXED_DUAL_ROLE |
+					       PDO_FIXED_DATA_SWAP)>;
+			source-pdos = <PDO_FIXED(5000, 2000,
+						 PDO_FIXED_DUAL_ROLE |
+						 PDO_FIXED_DATA_SWAP)>;
+
+			altmodes {
+				displayport {
+					svid = /bits/ 16 <0xff01>;
+					vdo = <0x001c1c47>;
+				};
+			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec_con_hs: endpoint {
+						remote-endpoint = <&mtu3_hs1_role_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&xhci_ss_ep>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					typec_sbu_out: endpoint {
+						remote-endpoint = <&it5205_sbu_mux>;
+					};
+
+				};
+			};
+		};
+	};
 };
 
 &i2c5 {
@@ -849,6 +925,14 @@ pins-reset {
 		};
 	};
 
+	tcpci_int_pins: tcpci-int-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
@@ -904,6 +988,14 @@ pins-usb-hub-3v3-en {
 		};
 	};
 
+	usb2_default_pins: usb2-default-pins {
+		pins-iddig {
+			pinmux = <PINMUX_GPIO89__FUNC_B_GPIO89>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	wifi_pwrseq_pins: wifi-pwrseq-pins {
 		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO127__FUNC_B_GPIO127>;
@@ -1012,9 +1104,21 @@ &u3phy2 {
 };
 
 &ssusb0 {
-	dr_mode = "host";
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	usb-role-switch;
+	wakeup-source;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	pinctrl-0 = <&usb_default_pins>;
+	pinctrl-names = "default";
 	status = "okay";
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		type = "micro";
+		id-gpios = <&pio 83 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb_p0_vbus>;
+	};
 };
 
 &xhci0 {
@@ -1022,14 +1126,23 @@ &xhci0 {
 };
 
 &ssusb1 {
-	dr_mode = "host";
+	dr_mode = "otg";
+	usb-role-switch;
+	wakeup-source;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	pinctrl-0 = <&usb1_default_pins>;
+	pinctrl-names = "default";
 	status = "okay";
+
+	port {
+		mtu3_hs1_role_sw: endpoint {
+			remote-endpoint = <&typec_con_hs>;
+		};
+	};
 };
 
 &xhci1 {
 	status = "okay";
-	vdd-supply = <&usb_hub_fixed_3v3>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -1058,17 +1171,25 @@ xhci_ss_ep: endpoint {
 };
 
 &ssusb2 {
-	interrupts-extended = <&gic GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>,
-			      <&pio 220 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "host", "wakeup";
-
-	dr_mode = "host";
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	usb-role-switch;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	wakeup-source;
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_default_pins>;
 	status = "okay";
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		type = "micro";
+		id-gpios = <&pio 89 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb_p2_vbus>;
+	};
 };
 
 &xhci2 {
-	status = "okay";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&sdio_fixed_3v3>; /* wifi_3v3 */
+	status = "okay";
 };
-- 
2.48.1


