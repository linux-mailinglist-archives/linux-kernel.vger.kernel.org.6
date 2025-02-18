Return-Path: <linux-kernel+bounces-520495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA61A3AA87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67CB3A2E80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619517A305;
	Tue, 18 Feb 2025 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZKRRgMem"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0C2862A2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913068; cv=none; b=GchUALcZ7yz3nGtUOcv060M1+uf+qUTEylfl4bwU5kiM3uLdR0WVmkx/l8H3eUombhDF3rXCaqr2I6GrycHp8sV8VDuRkEQb8owP1FtaKvePVg6VyEjZAVesxG4kdamywnhqBS5VX+w7bTXtGBwHNYJAE+z9Z+pL0vezJgGre90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913068; c=relaxed/simple;
	bh=LCzvPb6f3tfXE3m9BfTS4vlKysALj7dvcSUCSMFDUhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IM9/+n7EmSTDaDhTiWjRPqxPvS0rgLOJbDy2MMnM3hkKG8rHsJmO03cmOX6lrkanlSYMqAjuPHykVEUIPAVSotKnk8UKn1aSgkDRg6zG/5IgRJJqGTeCR8fSVNTfOOL8ece9gZcuoaS5WOOKRgxslmq7qfiMevTYvgvyc4Wnp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZKRRgMem; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pEdgciic315UTvcm4aT/T3J9lnLLylsC2gTDXlnlvMM=; b=ZKRRgMemACf/zqGQYcxXE9Gf1A
	gce0KI4uPKRoEgi8zHaNIzhZQrT//FULyTCjurxOY/bwWi310sLWvTW2SpKiRLPr5PoebzfhrH+PR
	xr9X1kv5spJFphSQJVQ3f4vjF2WitVQ+1PZHv0qJh2X1MaTnXhXMu2df7/4JR6P/t5NqRISRc2bMS
	lYLQqqn0AzTWCf4274gd6dpqxeA2FxTels6K2RD+JzMsXNWm61rqNjxg6kNhx/TI/D2BNJBnWs2Ns
	C9qbXTp0Rr7zBspPVM9+1hb/H0ak1JQ30DhZ5AixbEXN+DBIfRdsO888WbcyfXRIE2JEBkYa1Wc+9
	2gliG+Pw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkUru-0000jU-Oh; Tue, 18 Feb 2025 22:11:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2] arm64: dts: rockchip: add usb typec host support to rk3588-jaguar
Date: Tue, 18 Feb 2025 22:10:44 +0100
Message-ID: <20250218211044.2256762-1-heiko@sntech.de>
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
changes in v2:
- address review comments from Quentin
  (comments, pinctrl, sbu-gpios and much more)

 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index ef56380530f9..48059d9b3ad6 100644
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
@@ -483,6 +583,16 @@ pcie30x4_waken_m0: pcie30x4-waken-m0 {
 			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
 		};
 	};
+
+	usb3 {
+		cc_int1: cc-int1 {
+			rockchip,pins = <4 RK_PA3 0 &pcfg_pull_up>;
+		};
+
+		cc_int2: cc-int2 {
+			rockchip,pins = <4 RK_PA4 0 &pcfg_pull_up>;
+		};
+	};
 };
 
 &saradc {
@@ -851,6 +961,24 @@ &tsadc {
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
@@ -893,6 +1021,50 @@ &uart7 {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	orientation-switch;
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
+&usbdp_phy1 {
+	orientation-switch;
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
@@ -903,6 +1075,38 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+/* host0 on P11 USB-C */
+&usb_host0_xhci {
+	/* The port-hw supports DRD, but needs more work */
+	dr_mode = "host";
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
+	/* The port-hw supports DRD, but needs more work */
+	dr_mode = "host";
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


