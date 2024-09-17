Return-Path: <linux-kernel+bounces-331846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA697B1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90171F21591
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF91A7267;
	Tue, 17 Sep 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="RTiHy/cg"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499D1A4E97;
	Tue, 17 Sep 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585908; cv=none; b=B9dCk/91uCWE3WuNW8fOXsa8ja23aLGgqqhf2MoDjeUzMbP7oKfXPp2eirHlSi6alLaq8LEzLQQRj+JqA+kXUGXMwuWORNpNy4m5erPmBxqqpVXnp2TAO9aRElKMkxV7gx6v99pGmGzpThY03EL/AENFRmQoGvvp2zFAZNsC4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585908; c=relaxed/simple;
	bh=8+/F/LA//3GmNp7GS/whc94/nqtg59vlioqOSKVj2wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvXmOhgTBgPdUYa9mHryy2hIluwZzAnSKnEXeSFTCLxVOcJKm+jeUuftiRitjmaxGHvLKRfEpRRI4Fs+fUDymgLwX+gNyZNkNaz17QD7hg0/CUmoeTEUreMthJxJGM+g+ucPaeky1fZidkcfgvFdG8q5u6+ROu5mgSTOA3yDhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=RTiHy/cg; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726585904;
	bh=Q5o/w+Og7Zq+gJWW+L+++plpsvu1kWMuvJvgOLXM2v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTiHy/cg/ZtZ4yV/fl4CzCC/jj8WfCku1VoFH7TLTR3lbM4jjQ6+xBhwbxBr1mwtX
	 vv8NPJ7DRdWgFYoOwW8Z0hlTXwIUCOFFWofTWk+HG8m6UoimVG13dlkws8Y2caK4Lw
	 xdzJ4vs+Ygqg6+1OnWj69BKtJFpUA5agElLS21B8=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 16E18A25FB;
	Tue, 17 Sep 2024 17:11:44 +0200 (CEST)
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
Subject: [PATCH 4/4] arm64: dts: imx8mp-iota2: Enable the USB Type-C port
Date: Tue, 17 Sep 2024 17:10:01 +0200
Message-ID: <20240917151001.1289399-5-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917151001.1289399-1-michal.vokac@ysoft.com>
References: <20240917151001.1289399-1-michal.vokac@ysoft.com>
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
 .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
index 21d0899cabd5..b15d211e8667 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
@@ -38,6 +38,17 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0x80000000>;
 	};
 
+	reg_typec: regulator-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_vbus>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "typec";
+	};
+
 	reg_usb_host: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -218,6 +229,47 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	tcpc@d {
+		compatible = "diodes,pi5usb30213a";
+		reg = <0xd>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			vbus-supply = <&reg_typec>;
+			power-role = "source";
+			data-role = "dual";
+			typec-power-opmode = "default";
+			self-powered;
+			pd-disable;
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
@@ -237,6 +289,38 @@ &uart2 {
 	status = "okay";
 };
 
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
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
 &usb3_phy1 {
 	vbus-supply = <&reg_usb_host>;
 	status = "okay";
@@ -356,6 +440,12 @@ MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x102
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
@@ -363,6 +453,12 @@ MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x0
 		>;
 	};
 
+	pinctrl_usbc_vbus: usbcgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x0
+		>;
+	};
+
 	pinctrl_usb_host_vbus: usb1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x0
-- 
2.43.0


