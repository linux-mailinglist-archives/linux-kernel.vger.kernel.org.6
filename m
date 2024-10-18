Return-Path: <linux-kernel+bounces-372133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A59A44CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74811F21BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC372204023;
	Fri, 18 Oct 2024 17:36:18 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1620262E;
	Fri, 18 Oct 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272978; cv=none; b=PZj2tm0hGqNU7wRCr9w5JeZchY3NaHDhtQs/4f1qOjDFcmFW6CXEpo6NM8QEP4rE+BZ8QfKI7NAdWbpo9EyZR7uYCmQPbCySpBLHy5UhqU7i9FOCQvfcyg6ivUtgnIqW1rcaNePFIu8CGo6Vq/gzcUwLoYjXEo3fX0QPOiD6RN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272978; c=relaxed/simple;
	bh=cpjtLhNwKyFaaIwtnbQjoebKf3gL8XG9kk/gIxRT7y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPqXTdWWzGdE4JwfPG8E2ffVY8Pd0SMhQMQ5s06GqRNJjdks3yUwDRRBhZNMeoR4pwnWJBqdy6yV9wC6JLyRJBGw6R8MjF2LvjTSfTR9fAfmNp2kZ/Ul3pDCEu7Jrmo8uZSMy3ef/t+Ouy9u7D/PtaivbSdGRLRq26PbqKNx3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1t1qtW-0013O1-L2;
	Fri, 18 Oct 2024 17:36:10 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3] arm64: dts: imx8m*-venice-gw75xx: add Accelerometer device
Date: Fri, 18 Oct 2024 10:36:08 -0700
Message-Id: <20241018173608.810073-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GW75xx has a LIS2DE12TR 3-axis accelerometer on the I2C bus with an
interrupt pin. Add it to the device-tree.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
----
v3: move reg directly after compatible and before pinctrl
v2: make sure compatible is on top and vendor specific props are at the
    end per:
    https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
---
 .../boot/dts/freescale/imx8mm-venice-gw75xx.dtsi | 16 ++++++++++++++++
 .../boot/dts/freescale/imx8mp-venice-gw75xx.dtsi | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
index 5eb92005195c..53004c4a13aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
@@ -116,6 +116,16 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	accelerometer@19 {
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		st,drdy-int-pin = <1>;
+	};
+
 	eeprom@52 {
 		compatible = "atmel,24c32";
 		reg = <0x52>;
@@ -198,6 +208,12 @@ MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x40000040 /* GPIOC */
 		>;
 	};
 
+	pinctrl_accel: accelgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_MISO_GPIO5_IO8	0x159
+		>;
+	};
+
 	pinctrl_gpio_leds: gpioledgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0	0x6	/* LEDG */
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
index 0d40cb0f05f6..f90b293c85fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
@@ -104,6 +104,16 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	accelerometer@19 {
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		st,drdy-int-pin = <1>;
+	};
+
 	eeprom@52 {
 		compatible = "atmel,24c32";
 		reg = <0x52>;
@@ -204,6 +214,12 @@ MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x40000106 /* PCI_WDIS# */
 		>;
 	};
 
+	pinctrl_accel: accelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08	0x159
+		>;
+	};
+
 	pinctrl_gpio_leds: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x6	/* LEDG */
-- 
2.25.1


