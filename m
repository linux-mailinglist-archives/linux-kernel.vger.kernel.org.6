Return-Path: <linux-kernel+bounces-203943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBAC8FE244
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160BFB2AD18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9815B112;
	Thu,  6 Jun 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVfoqeZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667F158D97;
	Thu,  6 Jun 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664585; cv=none; b=HO0GG+T243u1APCstdlmMLPhpGzs2VvO9SAUYheAzeD6axCTYNMn6/hvB44mVHxgZOwZwUjnJUqnIAP9ZBRFrOfL+EvGCVncm49kjfPQEK3vlpQ431EkH45UW+v8A4DX4cjkyQdLMufqNuiVUpE41QD6fhXCW9OVH5WMM5h+feE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664585; c=relaxed/simple;
	bh=5+BkHA78fCbCQTiNzIg43RTLJ7E3srGkuferiHfXMDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXcHNImpXPje8iK26Ul/DNiJlFV3gBvGtsvHKaFFGRPYwG8Oh6XqfThTvec5KMw6CXkvF1OVHI30sVd+t80G7v7s7Vsv0ByuYEzuH0dVXQdu4o+oip6i/rPW1wO3FOF+63ozt3YYcwIuov6pk8kpVifUZtYtqiRaaZnp3SmzcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVfoqeZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01122C4AF17;
	Thu,  6 Jun 2024 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664585;
	bh=5+BkHA78fCbCQTiNzIg43RTLJ7E3srGkuferiHfXMDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVfoqeZmmPu/kKKKz+jF3vDB94xG7189a7LpX2GEpnlVbhAZQO9vcjyrL668LkleR
	 widWe9vyIsE7iq4vwDt2SQL4sdQvWSXxtBE0u0D2B2n3wg6RlF5BTFffsklygri+ZR
	 ASYUdC3NLjbx2xFQxROB319aM8/JGta9Wyg9L4PeCExHOX8x0FPlcdgMR1OU9ajk3k
	 16l/50w68ywlyFi1ISAStkropey2Ip8Y0quIAHgr+J0NF5eKcKFt4rOYFps3pNzqAM
	 gei+GO5wje2Ig8WW4cBRhd3H+M8p2M4ecoXQROee/Wgkb5exRuLtRjSEE3/AJBNJ7w
	 3bbBfz58ew6/g==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 13/13] ARM: dts: imx6qdl-kontron-samx6i: add actual device trees
Date: Thu,  6 Jun 2024 11:02:06 +0200
Message-Id: <20240606090206.2021237-14-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, there wasn't any in-tree users of the dtsi files for the
Kontron SMARC-sAMX6i board. Let's add device trees, for this board on a
Kontron SMARC Eval 2.0 Carrier.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
 .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
 .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 148 ++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 231c0d73a53e..92e291603ea1 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -99,6 +99,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-icore.dtb \
 	imx6dl-icore-mipi.dtb \
 	imx6dl-icore-rqs.dtb \
+	imx6dl-kontron-samx6i-ads2.dtb \
 	imx6dl-lanmcu.dtb \
 	imx6dl-mamoj.dtb \
 	imx6dl-mba6a.dtb \
@@ -207,6 +208,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-ofcap12.dtb \
 	imx6q-icore-rqs.dtb \
+	imx6q-kontron-samx6i-ads2.dtb \
 	imx6q-kp-tpc.dtb \
 	imx6q-logicpd.dtb \
 	imx6q-marsboard.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
new file mode 100644
index 000000000000..6a0c53f23a15
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-kontron-samx6i.dtsi"
+#include "imx6qdl-kontron-samx6i-ads2.dtsi"
+
+/ {
+	model = "Kontron SMARC-sAMX6i Dual-Lite/Solo on SMARC Eval 2.0 carrier";
+	compatible = "kontron,imx6dl-samx6i-ads2", "kontron,imx6dl-samx6i", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
new file mode 100644
index 000000000000..94c395cc020e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-kontron-samx6i.dtsi"
+#include "imx6qdl-kontron-samx6i-ads2.dtsi"
+
+/ {
+	model = "Kontron SMARC-sAMX6i Quad/Dual on SMARC Eval 2.0 carrier";
+	compatible = "kontron,imx6q-samx6i-ads2", "kontron,imx6q-samx6i", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
new file mode 100644
index 000000000000..15a87ee4159d
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree include for the Kontron SMARC-sAMX6i board on a SMARC Eval
+ * 2.0 carrier (ADS2).
+ *
+ */
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	sound {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Out Jack",
+			"Microphone", "Microphone Jack",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"Line Out Jack", "LINEOUTR",
+			"Line Out Jack", "LINEOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"IN1L", "Line In Jack",
+			"IN1R", "Line In Jack",
+			"Microphone Jack", "MICBIAS",
+			"IN2L", "Microphone Jack",
+			"IN2R", "Microphone Jack";
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&wm8904>;
+		};
+	};
+
+	reg_codec_mic: regulator-codec-mic {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3_MIC";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_codec_1p8v: regulator-codec-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V8_S0_CODEC";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&ecspi4 {
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		m25p,fast-read;
+		spi-max-frequency = <100000000>;
+		reg = <1>;
+	};
+};
+
+&fec {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	wm8904: audio-codec@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_codec_1p8v>;
+		CPVDD-supply = <&reg_codec_1p8v>;
+		DBVDD-supply = <&reg_codec_1p8v>;
+		DCVDD-supply = <&reg_codec_1p8v>;
+		MICVDD-supply = <&reg_codec_mic>;
+	};
+};
+
+&i2c3 {
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+&usdhc3 {
+	status = "okay";
+};
-- 
2.39.2


