Return-Path: <linux-kernel+bounces-325839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD16975EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8641C217FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2477D07E;
	Thu, 12 Sep 2024 02:21:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB82BD1D;
	Thu, 12 Sep 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107695; cv=none; b=GUyDEaT4aToNNRxkUnYTsL9Eb/RqWTJUtPcHZzyWdnqunnNBmnTO8+YTEk8NdBu1kK2fCCSQUwHo5Moj5LH/3tlf5ccslzqWCelVsTCQ/cWVd6jd/rqImef4j2oj/PWgvA2Nt/5SaQZy3ZSskkwO+GRycIKLmY1DgbM4Hc6KnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107695; c=relaxed/simple;
	bh=HCDVzZH+XzIK21Rrbzx/43Sg7jedfgk1vPj6W7s74mM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=FrqusbWgJvdjyP+xJHnWuYIRkyhobrlmPWld39omMTIc6D9vLZqzVkfEy2TBxqyKHmxlVV/y3vZwb/r73jR9BkP22KeI4lqH6jfcrw8kXF47ffHNztINUrFE7swluz7FCoegrK1HQVJvooEQvx7A0CB0tIIVQoxQxILpFYNSXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E4761A0A6D;
	Thu, 12 Sep 2024 04:21:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 640311A01C1;
	Thu, 12 Sep 2024 04:21:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2969C1840306;
	Thu, 12 Sep 2024 10:21:26 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 1/3] arm64: dts: imx93-9x9-qsb: Enable sound-wm8962 sound card
Date: Thu, 12 Sep 2024 09:59:39 +0800
Message-Id: <1726106381-1138-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add wm8962 sound card which connects to sai3. The connection
of SAI3 and wm8962 is controlled by PCAL6524HEAZ module, add
gpio-hog for it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index f8a73612fa05..10f3366b8253 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -68,6 +68,15 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_rpi_3v3: regulator-rpi {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_RPI_3V3";
@@ -88,6 +97,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 		off-on-delay-us = <12000>;
 	};
+
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8962>;
+		hp-det-gpio = <&pcal6524 4 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC",
+			"IN1R", "AMIC";
+	};
 };
 
 &adc1 {
@@ -136,6 +161,28 @@ &lpi2c1 {
 	pinctrl-0 = <&pinctrl_lpi2c1>;
 	status = "okay";
 
+	wm8962: codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;
@@ -194,6 +241,12 @@ pcal6524: gpio@22 {
 		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pcal6524>;
+
+		exp-sel-hog {
+			gpio-hog;
+			gpios = <22 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
 	};
 
 	pmic@25 {
@@ -286,6 +339,17 @@ &mu2 {
 	status = "okay";
 };
 
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX93_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	fsl,sai-synchronous-rx;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -443,6 +507,16 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO12__SAI3_RX_SYNC		0x31e
+			MX93_PAD_GPIO_IO18__SAI3_RX_BCLK		0x31e
+			MX93_PAD_GPIO_IO17__SAI3_MCLK			0x31e
+			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00		0x31e
+			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-- 
2.34.1


