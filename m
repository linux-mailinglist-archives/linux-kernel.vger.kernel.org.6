Return-Path: <linux-kernel+bounces-533527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54702A45BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF961899C13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732F23816F;
	Wed, 26 Feb 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FImBJ3bm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A72226D03
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565523; cv=none; b=Vs5jINWMz3JFOJbEREnN6ii4kOhp+P7vnBw5UqAtrXzXsoYNhKIydKhy7DmCXvhoYfVsRw8hRFadwOF3xGve1NTlMpzJgXXWw1z0weIzbRCRKv78TYQcmRPKOjlSUTvt900rjWuX7V6aM3hx3H3iIooy09dyRfmnK9q1k1OySy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565523; c=relaxed/simple;
	bh=+h++cLSineGel2oThcDp5bZpYh/LUhniSQMK++ibchY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l21+vMjBIM3R89tN92gI1hy4f4zST3XUkAOKozdyjvCVdj2I5J0P0dhgtYqGqHg8MAFezN5GWzeNmDVqSPEEQt9QN2+6oTZ61aejV0MyjP6tifMTLxqofoBjB1j8FyfBTRIk/HyG4mdVXG4CCNn3i9Z6kF4ZcIdjX5snGATwQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FImBJ3bm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iwgg7Sa/hYFUPfapeDs/PKCErbJNAXvFMQwYU2jvLh8=; b=FImBJ3bmcH/yFRK7MwpJuYKlci
	uQTgM2zmZUSGc2WqHVlNUBp8dYwD5Mic3VXFWnu/o3Z6FmxYDr2+yuZLf+r0KRvlyAOz4PTZdcbaY
	m9Xd5kV4RawJmneQ93qIxokesaK0m6n0j6+Q67MJwV58nD/mWrf29iFuakHmDCAVvMBX+AXvEh9Ez
	UrKf9HPkqbFKAg8stEuSXyWqDFNMi/ARhIFhi9oblr5zdlhXCzduAtu9aB5IJGONFqcjZksdWtAUI
	8yzqfZQTIxKNOrmN0DQKCAMAsqTLchrVrY/lp5TZQv7N2koCFzpw4h1hOkC87TKq9PoOHBaM5DXYT
	YwFxVhzQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnEbO-0006Ro-8f; Wed, 26 Feb 2025 11:25:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lukasz.czechowski@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3] arm64: dts: rockchip: add usb typec host support to rk3588-jaguar
Date: Wed, 26 Feb 2025 11:25:07 +0100
Message-ID: <20250226102507.3743437-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Jaguar has two type-c ports connected to fusb302 controllers that can
work both in host and device mode and can also run in display-port
altmode.

While these ports can work in dual-role data mode, they do not support
powering the device itself as power-sink. This causes issues because
the current infrastructure does not cope well with dual-role data
without dual-role power.

So add the necessary nodes for the type-c controllers as well
as enable the relevant core usb nodes, but limit the mode to host-mode
for now until we figure out device mode.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
changes in v3:
- more review comments from Quentin
  (sbu-pin pinctrl, comments)
changes in v2:
- address review comments from Quentin
  (comments, pinctrl, sbu-gpios and much more)

 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 218 ++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 20b566d4168f..5dbcdf67f0a5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -333,6 +333,56 @@ rtc_twi: rtc@6f {
 		};
 	};
 
+	typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cc_int1>;
+		vbus-supply = <&vcc_5v0_usb_c1>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USBC-1 P11";
+			power-role = "source";
+			self-powered;
+			source-pdos =
+				<PDO_FIXED(5000, 1500, PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)>;
+			vbus-supply = <&vcc_5v0_usb_c1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usbc0_hs: endpoint {
+						remote-endpoint = <&usb_host0_xhci_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usbc0_ss: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usbc0_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_sbu>;
+					};
+				};
+			};
+		};
+	};
+
 	vdd_npu_s0: regulator@42 {
 		compatible = "rockchip,rk8602";
 		reg = <0x42>;
@@ -394,6 +444,56 @@ &i2c8 {
 	pinctrl-0 = <&i2c8m2_xfer>;
 	status = "okay";
 
+	typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cc_int2>;
+		vbus-supply = <&vcc_5v0_usb_c2>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USBC-2 P12";
+			power-role = "source";
+			self-powered;
+			source-pdos =
+				<PDO_FIXED(5000, 1500, PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)>;
+			vbus-supply = <&vcc_5v0_usb_c2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usbc1_hs: endpoint {
+						remote-endpoint = <&usb_host1_xhci_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usbc1_ss: endpoint {
+						remote-endpoint = <&usbdp_phy1_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usbc1_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy1_typec_sbu>;
+					};
+				};
+			};
+		};
+	};
+
 	vdd_cpu_big0_s0: regulator@42 {
 		compatible = "rockchip,rk8602";
 		reg = <0x42>;
@@ -483,6 +583,26 @@ pcie30x4_waken_m0: pcie30x4-waken-m0 {
 			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
 		};
 	};
+
+	usb3 {
+		cc_int1: cc-int1 {
+			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		cc_int2: cc-int2 {
+			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		typec0_sbu_pins: typec0-sbu-pins {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		typec1_sbu_pins: typec1-sbu-pins {
+			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>,
+					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &saradc {
@@ -850,6 +970,24 @@ &tsadc {
 	status = "okay";
 };
 
+/* USB-C P11 connector */
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+/* USB-C P12 connector */
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -892,6 +1030,56 @@ &uart7 {
 	status = "okay";
 };
 
+/* Type-C on P11 */
+&usbdp_phy0 {
+	orientation-switch;
+	pinctrl-names = "default";
+	pinctrl-0 = <&typec0_sbu_pins>;
+	sbu1-dc-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>; /* Q7_USB_C0_SBU1_DC */
+	sbu2-dc-gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>; /* Q7_USB_C0_SBU2_DC */
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_typec_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_ss>;
+		};
+
+		usbdp_phy0_typec_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc0_sbu>;
+		};
+	};
+};
+
+/* Type-C on P12 */
+&usbdp_phy1 {
+	orientation-switch;
+	pinctrl-names = "default";
+	pinctrl-0 = <&typec1_sbu_pins>;
+	sbu1-dc-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>; /* Q7_USB_C1_SBU1_DC */
+	sbu2-dc-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>; /* Q7_USB_C1_SBU2_DC */
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy1_typec_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc1_ss>;
+		};
+
+		usbdp_phy1_typec_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc1_sbu>;
+		};
+	};
+};
+
 /* host0 on P10 USB-A */
 &usb_host0_ehci {
 	status = "okay";
@@ -902,6 +1090,36 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+/* host0 on P11 USB-C */
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_host0_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc0_hs>;
+		};
+	};
+};
+
+/* host1 on P12 USB-C */
+&usb_host1_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_host1_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc1_hs>;
+		};
+	};
+};
+
 /* host1 on M.2 E-key */
 &usb_host1_ehci {
 	status = "okay";
-- 
2.47.2


