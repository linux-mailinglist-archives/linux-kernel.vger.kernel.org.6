Return-Path: <linux-kernel+bounces-304551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1F9621B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9AB1F25AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2215B561;
	Wed, 28 Aug 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="sVsiJCEa"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F415B0E8;
	Wed, 28 Aug 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831324; cv=none; b=bnE3p4lPLv8wLwN5SdxmA0OW4OozViZ+lkke/m555+oYrvFrIfM996ciVEggj/38ivyOaYhoSRS8eCdG9f+la1wKVgfgaZBpANqHn5HUsUjgmB14siCEwJzZsRo89ZQtTK9v58CLTKauW/LD5n5cB5/iyzn3HBUyfrnKEdWr6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831324; c=relaxed/simple;
	bh=jNelMrHCDDZMs1bHNSD+cEXcK4Z2DGO8E155VlkTqlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jletTo6Eim1+f3BXkbtH8sl3JyHGT8IBxWU6LIliXd6FpahvnB4wBCuLGG9GUkgzt7eIeH9uqYJlBMvR24iDsTxR41goeqmRDMcb0GdrGhPwhel0vzjBD2+eMlaR72uisOLZkbDQI97G9hEr9uCzy5mD6pebyLZPLnwTlixl4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=sVsiJCEa; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0FE7BFC3E;
	Wed, 28 Aug 2024 09:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1724831320; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VQt/batcpFloLaSlP/SLejsHW2CI3ek5H7Melbe5ps8=;
	b=sVsiJCEaIb0RKuTuum+khRW1WFlLdXfVHSn9x5+/S97AdTb1UuAhRD3YHx3snCLIYqRKPZ
	rleekOxIM5j2k85wHY2NepsRQu/0jBUiuLaht0oDPXFV/Gv0mIHP4lIG7ytoR7vNTrjKNr
	OoM+vxC+zjqtqc2OMhv2PLA72+lyim2VndyNJxrgSUifnjwgdcYcnzZ2brPSZjNQSSMESQ
	K0b6ArhksWo9+tIdo67c95M6j8Es7NXOW5ubXTn2/d9QPH43xsmQb7hzharzkGaCA9Tocj
	bJhVUkYeLSaK5VFj3oPuF/E85lNX/QZ29VCp7J14xPSnYQLachppqXonkxbwJQ==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 3/4] arm64: dts: imx8mm-kontron: Add support for display bridges on BL i.MX8MM
Date: Wed, 28 Aug 2024 09:46:55 +0200
Message-ID: <20240828074753.25401-4-frieder@fris.de>
In-Reply-To: <20240828074753.25401-1-frieder@fris.de>
References: <20240828074753.25401-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Kontron Electronics BL i.MX8MM has oboard disply bridges for
DSI->HDMI and DSI->LVDS conversion. The DSI interface is muxed by
a GPIO-controlled switch to one of these two bridges.

By default the HDMI bridge is enabled. The LVDS bridge can be
selected by loading an additional (panel-specific) overlay.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* Remove blank lines from hdmi node
* Fix order of lvds and hdmi nodes within i2c
* Remove the unneeded deletion of samsung,pll-clock-frequency
* Use the existing MIPI DSI output port from imx8mm.dtsi
---
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index aab8e24216501..a8ef4fba16a9e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -25,6 +25,17 @@ osc_can: clock-osc-can {
 		clock-output-names = "osc-can";
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_in_conn: endpoint {
+				remote-endpoint = <&bridge_out_conn>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -132,6 +143,86 @@ ethphy: ethernet-phy@0 {
 	};
 };
 
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+
+	dsi_mux_sel_hdmi: dsi-mux-sel-hdmi-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "dsi-mux-sel";
+	};
+
+	dsi_mux_sel_lvds: dsi-mux-sel-lvds-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "dsi-mux-sel";
+		status = "disabled";
+	};
+
+	dsi-mux-oe-hog {
+		gpio-hog;
+		gpios = <15 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "dsi-mux-oe";
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	lvds: bridge@2c {
+		compatible = "ti,sn65dsi84";
+		reg = <0x2c>;
+		enable-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sn65dsi84>;
+		status = "disabled";
+	};
+
+	hdmi: hdmi@39 {
+		compatible = "adi,adv7535";
+		reg = <0x39>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_adv7535>;
+		adi,dsi-lanes = <4>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		a2vdd-supply = <&reg_vdd_1v8>;
+		avdd-supply = <&reg_vdd_1v8>;
+		dvdd-supply = <&reg_vdd_1v8>;
+		pvdd-supply = <&reg_vdd_1v8>;
+		v1p2-supply = <&reg_vdd_1v8>;
+		v3p3-supply = <&reg_vdd_3v3>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_in_dsi_hdmi: endpoint {
+					remote-endpoint = <&mipi_dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				bridge_out_conn: endpoint {
+					remote-endpoint = <&hdmi_in_conn>;
+				};
+			};
+		};
+	};
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -144,6 +235,19 @@ rx8900: rtc@32 {
 	};
 };
 
+&lcdif {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <54000000>;
+	status = "okay";
+};
+
+&mipi_dsi_out {
+	remote-endpoint = <&bridge_in_dsi_hdmi>;
+};
+
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
@@ -207,6 +311,12 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio>;
 
+	pinctrl_adv7535: adv7535grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x19
+		>;
+	};
+
 	pinctrl_can: cangrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
@@ -277,6 +387,20 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 		>;
 	};
 
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x19
+			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x19
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
@@ -290,6 +414,13 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
 		>;
 	};
 
+	pinctrl_sn65dsi84: sn65dsi84grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19
+			MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x19
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0
-- 
2.46.0


