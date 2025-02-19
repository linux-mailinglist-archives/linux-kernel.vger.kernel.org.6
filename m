Return-Path: <linux-kernel+bounces-521479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420BBA3BDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E04188D68B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BEE1E0E08;
	Wed, 19 Feb 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yk2wDoVx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089F1DE8BE;
	Wed, 19 Feb 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967735; cv=none; b=JtTiTvgAItUyOzrCzZ9XMV2AsnIJMqSnt88G9mhcV20t4pKE7ee2SWLYllCyTq6xiiwLoKh/SJhnVb0ZRaRal7ZO5yFYCjsx/+pv55O/1v5kAtXapxcVhEf0fWp6pkXODtQgstp+GKSgvt8HRSLYGcaFUeqnBeMVn0r00lFfnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967735; c=relaxed/simple;
	bh=B7yMogAYJNxLn7fYb3PggxlyL8doB57WH2k5L7pR6qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otBzyEwP4B2o1/5+ojQkVnNaHgrvkthYgITxszODk88vSUo72NOWwO8IEHhQMzPoyYzBnMExkI4zQTSvN29xoYrD82UHeb62J/tHMmqMJ8w+uJkuJuv1HiQJ6+y/IzcjPtrhSKVUlneFoGFcU0FcGSPapJ/9QbMC5ZzQEYLXwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yk2wDoVx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739967731;
	bh=B7yMogAYJNxLn7fYb3PggxlyL8doB57WH2k5L7pR6qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yk2wDoVxGDit/enUVx/kChc6yIHjf3EnUhy5QU1OJUi5u0cUkmQBcvOt+QTpkYs+h
	 6XIj0BVMuC85EuWa/MZfNUAkjqn5DjNHEC/a87M+fFHu8Si6Tag0v4lma7dqwp7bEa
	 VGYQRieRGq1JeFtxZygjDqViwbv2Dt53lOO1nBOX5LnwEH4HhogqtT3SwBd6F2h866
	 OY2iqamC+sfOiqKpkZ7IIudZV2uE9q2oS8D3KQg2GfVe2wqVS0LlkR52/P/OA0X5PC
	 Y6OY1Pv3pvZVFOR9BHNhWZXO/omNAqm+Bq7G1mMzGWgynzebJ/7sRvt+nEd5GQXx9j
	 ZKvv3gm1W/H8w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0574717E1566;
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
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio: Add USB, TypeC Controller, MUX
Date: Wed, 19 Feb 2025 13:22:06 +0100
Message-ID: <20250219122206.46695-3-angelogioacchino.delregno@collabora.com>
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
 .../dts/mediatek/mt8390-genio-common.dtsi     | 141 +++++++++++++++++-
 1 file changed, 133 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index fd977daa4185..a6c8abf371aa 100644
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
@@ -1022,9 +1126,19 @@ &xhci0 {
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
@@ -1058,17 +1172,28 @@ xhci_ss_ep: endpoint {
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
+	interrupts-extended = <&gic GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&pio 220 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "host", "wakeup";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&sdio_fixed_3v3>; /* wifi_3v3 */
+	status = "okay";
 };
-- 
2.48.1


