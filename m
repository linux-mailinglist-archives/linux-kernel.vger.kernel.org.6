Return-Path: <linux-kernel+bounces-574096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C523A6E087
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F1118933AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25E264A88;
	Mon, 24 Mar 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AJsXmJg7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C66264618;
	Mon, 24 Mar 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835870; cv=none; b=QD69oQe1jaqMHNEciDFbQ5OTDkUfbEQTDD/Vb5X9z6h7tL1u65U6HMy6z1/l/vCN0vGmk0A22LKIH4sycrwAURBSdv7+oV3Ecj676tuIYddVfnZA2r/BYzzWRxKgRSArmm4RC+SmhYTTTvU2gVw0zZQpooaQYcVT52evH3HZ97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835870; c=relaxed/simple;
	bh=YoQAz5gy7VoClsPSkqwMktmtJTGxobd9i9vU73JymF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJJWhVALNDkMM6NiVcVJ4Fn6XyEDY8zN+boptMULm3CZ791rqsCzaiBNrYGDXfafzH4L2BmWbS4M9e8/9HZDps7YR52dSFbecr251h+N1+O3c7zXPD0VJlhs2bnYir19ARbVyXgbuCUSopFkxDZusYXPjYUwMf41DPzvVGmfR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AJsXmJg7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742835863;
	bh=YoQAz5gy7VoClsPSkqwMktmtJTGxobd9i9vU73JymF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AJsXmJg7AJZhin7aRMcQRR/B4F9Ec4CHcNlCp6/SVk2A9cHaMRWA6Rf0Fpobw5V0q
	 cJFiAHn52ew3yF9KOI4xkwv05O0XDAHEsHjun/xvJBQnQcZuo4Ms2uXuEARnxc56mI
	 3Gz21l86bJErYZyY/Sq9dqwv6/QIl2AzyYce2nhQMFB6BdAgDSyxbuhssdbM74XCFy
	 Xyy7ZgJCzghPTeZaIVlPYQiQuQ7cxPb/wfibYhPt7FB3e/CarWh1lK1KIsqxnuWKUT
	 OZv3QtxrhVeY0IzisSJH4lX7KjYPsOnqTjzl3KlZ1R/VZMtutdfLS7AxRrbSewFcbk
	 u0gH1nJM0Fv8g==
Received: from jupiter.universe (dyndsl-091-248-188-184.ewe-ip-backbone.de [91.248.188.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 740E717E0CA7;
	Mon, 24 Mar 2025 18:04:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DB1B548003D; Mon, 24 Mar 2025 18:04:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 24 Mar 2025 18:04:26 +0100
Subject: [PATCH 5/5] arm64: dts: rockchip: add USB-C support for ROCK 5B
 and 5B+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-rock5bp-for-upstream-v1-5-6217edf15b19@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
In-Reply-To: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6611; i=sre@kernel.org;
 h=from:subject:message-id; bh=YoQAz5gy7VoClsPSkqwMktmtJTGxobd9i9vU73JymF8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGfhkJa4nVZH5iVIc41MF9PcWcJSSCFZG+XGs
 EkysRqVS2ii04kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJn4ZCWAAoJENju1/PI
 O/qa7aoP/RzLBqxZBfmAZNUe4mKUi1QIFpWIKLBRss7o/SW4rnU0aIVZB8rKZnhoWjEFcXeutm+
 ftxyeYWXgIwFtBgseOI43Eox+OboHCQCMk9dwSyk2RQJ6ad1nbDKRzr1anp+44CC6MQrSCrozRP
 WMDBX6bV/c+NBXNZY0qcY2GR1cl+jr/rWx4Mzf7eULK4QxIT+cny/E8cCIkbO0UsoxshMW9kFEj
 IHVbKMOIFunFDpbcRm3MWzA026iPUjftd+ysffTAI4qGREUwHpF2JUTzzHYQD6l+i+7u18LMZtt
 F3llZcbVhhcwf4xf3zQzm76h78ra4l+OSupdD8dUkEe1oFQzJ+pySkhIUXs6DoKqCh+6+Lm+2gi
 ZZshSeaWXuqdiE1vpZrUDbWi6SOlGmHQVLb41xl0Gw5/X0VUGyAQ6b6WfPqw57L7eFRXmedTrP6
 5JudlUB/YD/L96AQHnmJRPwIK9lNn8VA66+U8iNbA65YwdUDlc0l5aN2So33ZuzUcOzYUJ25uza
 G/moe0hvAD/VxlXaTsh68iNVLcf2tKwi/+nMVBRwnEWeU5gRD6ckJRMN0szbApQZU3kXpB3sCYq
 xtBrdD2ExO4aeQb0V5LEad/4YsZotXzXeW4W7ANfrCDIiE21khH7HiCtPM4X3MfuzsZA9rEvSL4
 PdDnz841urI9rKpqIt3koDQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add hardware description for the USB-C port in the Radxa ROCK 5 Model
B and B+. This describes the OHCI, EHCI and XHCI USB parts, but not yet
the DisplayPort AltMode, since the bindings for that are not yet upstream.

The fusb302 node is marked with status "fail" on ROCK 5B, since the board
is usually powered through the USB-C port. Handling of errors can result
in hard resets, which removed the bus power for some time resulting in
a board reset.

The main problem right now is that devices are supposed to interact with
the power-supply within 5 seconds after the plug event according to the
USB PD specification. This is more or less impossible to achieve when
the kernel is the first software communicating with the power-supply.

Upstream U-Boot with fusb302 support overrides the status for the
fusb302 node to "okay". That way booting a kernel with the updated DT
on an old U-Boot avoids a reset loop.

This workaround is not needed for the ROCK 5B+, since fusb302 support
landed in U-Boot before the board support gets upstreamed. Apart from
that it also has a dedicated USB-C port with a standalone chip to supply
the board power.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi   | 137 +++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
index 74c7b6502e4dda4b774f43c704ebaee350703c0d..70339920fd4951dff993a5799ae5db243f07bd6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
@@ -105,6 +105,10 @@ vcc5v0_host_en: vcc5v0-host-en {
 	};
 };
 
+&usbc0 {
+	status = "okay";
+};
+
 &vcc5v0_host {
 	enable-active-high;
 	gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
index dccb8492f9f0632abd96c3dafc723e01491abad5..5e119f167cd8ccbd08ff2a2d4955489730ab85fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
+#include <dt-bindings/usb/pd.h>
 #include "rk3588.dtsi"
 
 / {
@@ -92,6 +93,15 @@ rfkill-bt {
 		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 	};
 
+	vcc12v_dcin: regulator-vcc12v-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -146,6 +156,19 @@ vcc5v0_sys: regulator-vcc5v0-sys {
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vbus5v0_typec: vbus5v0-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus5v0_typec_en>;
+		regulator-name = "vbus5v0_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
@@ -309,6 +332,67 @@ regulator-state-mem {
 	};
 };
 
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m1_xfer>;
+	status = "okay";
+
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus5v0_typec>;
+		/*
+		 * When the board is starting to send power-delivery messages
+		 * too late (5 seconds according to the specification), the
+		 * power-supply reacts with a hard-reset. That removes the
+		 * power from VBUS for some time, which resets te whole board.
+		 */
+		status = "fail";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "sink";
+			try-power-role = "sink";
+			op-sink-microwatt = <1000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
+				<PDO_VAR(5000, 20000, 5000)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usbc0_role_sw: endpoint {
+						remote-endpoint = <&dwc3_0_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc0_orien_sw: endpoint {
+						remote-endpoint = <&usbdp_phy0_orientation_switch>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					dp_altmode_mux: endpoint {
+						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &i2c6 {
 	status = "okay";
 
@@ -486,6 +570,14 @@ usb {
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		usbc0_int: usbc0-int {
+			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vbus5v0_typec_en: vbus5v0-typec-en {
+			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 };
 
@@ -871,6 +963,14 @@ &uart2 {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy1 {
 	status = "okay";
 };
@@ -898,6 +998,29 @@ &u2phy3_host {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	mode-switch;
+	orientation-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_orientation_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+
+		usbdp_phy0_dp_altmode_mux: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&dp_altmode_mux>;
+		};
+	};
+};
+
 &usbdp_phy1 {
 	status = "okay";
 };
@@ -910,6 +1033,20 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dwc3_0_role_switch: endpoint {
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };

-- 
2.47.2


