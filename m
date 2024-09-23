Return-Path: <linux-kernel+bounces-336003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0597EDEE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8CF1C2133E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0C19F12A;
	Mon, 23 Sep 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jqFqoHD9"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9EF1FC8;
	Mon, 23 Sep 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104465; cv=none; b=o72c/pGscVfKOllWJ0MAfcNcz8GmwqCoc4a7Qn4e/T5TncwKtwamOymSFIW+/tSURlcyuH89jmiMeiUYXBPMbdHSCdVHqxP5wxhZjEn6yXw9PsuD/1VyNTv3QZqnq4CfUOttVDj+QlaI90kEjlsAek/fCP8VDu91wWGlUlxlAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104465; c=relaxed/simple;
	bh=g/0Hdg8Un2CXL8LH60icGy740pZE1jnp1uFF0pCD7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+4Ybwqs7uN0fCtNJmGBNRQ7nw2XuKxNYe2RUDdS1KE6S0VLH6xb6zhLjEsZsYp2I9NVAWpa+efeX41FLWuktxgliYaRaG/xMfOqGJQYj127s22E0xrGlVK5GkAG9ke0/vKdzD8cIDf+k47I3tbgGf6DjNbQiFRnQjYLwShEPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=jqFqoHD9; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727104462;
	bh=YQdTsrkK3A3RwP/xvM3nu45doQX8paQActYi2VSP4Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqFqoHD9s51BZaXQsoYyxT42Ru3GcdQn0INqUKLAqf9VNJbEufuxN2eNUXeP8UQ2l
	 8+FQc3LO3MPyYJj2xjCCBTKo685YNPl2rsNA2gmiikhjPlGC5aVu55aXtFsTzb9mw/
	 gf6fUmjS11rMd6Df/x1pUHX8WbyO8MAt42cwwrxI=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id B2D33A0640;
	Mon, 23 Sep 2024 17:14:21 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Petr Benes <petr.benes@ysoft.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v3 4/4] arm64: dts: imx8mp-iota2: Enable the USB Type-C port
Date: Mon, 23 Sep 2024 17:14:17 +0200
Message-ID: <20240923151417.1665431-5-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923151417.1665431-1-michal.vokac@ysoft.com>
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Petr Benes <petr.benes@ysoft.com>

Enable the USB Type-C port with the Diodes PI5USB30213A port controller.
The port supports dual role data but can operate only in source power role
and PD is not supported.

Signed-off-by: Petr Benes <petr.benes@ysoft.com>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v3:
- none
v2:
- Use typec instead of tcpc.
- Drop unneeded status.

 .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
index 120e6b87a000..bfed410339a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
@@ -32,6 +32,17 @@ button-reset {
 		};
 	};
 
+	reg_typec: regulator-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_usbc_vbus>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "typec";
+	};
+
 	reg_usb_host: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -218,6 +229,46 @@ &i2c2 {
 	pinctrl-names = "default";
 	status = "okay";
 
+	typec@d {
+		compatible = "diodes,pi5usb30213a";
+		reg = <0xd>;
+		interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_typec>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			pd-disable;
+			power-role = "source";
+			self-powered;
+			typec-power-opmode = "default";
+			vbus-supply = <&reg_typec>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_con_hs: endpoint {
+						remote-endpoint = <&typec_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_con_ss: endpoint {
+						remote-endpoint = <&typec_ss>;
+					};
+				};
+			};
+		};
+	};
+
 	rtc: rtc@68 {
 		compatible = "dallas,ds1341";
 		reg = <0x68>;
@@ -309,6 +360,12 @@ MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x102
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05	0x1c0
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x0
@@ -322,6 +379,11 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x0
 		>;
 	};
 
+	pinctrl_usbc_vbus: usbcgrp {
+		fsl,pins = <MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x0
+		>;
+	};
+
 	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
@@ -389,15 +451,47 @@ &uart2 {
 	status = "okay";
 };
 
+&usb3_0 {
+	status = "okay";
+};
+
 &usb3_1 {
 	status = "okay";
 };
 
+&usb3_phy0 {
+	status = "okay";
+};
+
 &usb3_phy1 {
 	vbus-supply = <&reg_usb_host>;
 	status = "okay";
 };
 
+&usb_dwc3_0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port@0 {
+		reg = <0>;
+
+		typec_hs: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+
+		typec_ss: endpoint {
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
+
 &usb_dwc3_1 {
 	dr_mode = "host";
 	status = "okay";
-- 
2.43.0


