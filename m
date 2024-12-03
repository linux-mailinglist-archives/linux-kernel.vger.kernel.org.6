Return-Path: <linux-kernel+bounces-428907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBEB9E14DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51251282DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242AA1E04A4;
	Tue,  3 Dec 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPMQu7FJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE271D9A63;
	Tue,  3 Dec 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212685; cv=none; b=IbdlQnh1rixOCD6xjanodMNfXp9gKWBhYHEmtW/Z8C7zXvij2LOayBeQPf5Us+JwyY/JjUXv7C1fd7lhDFf3+3WPV6yRkyxxvNhblWJqTkRKbDRQOxwdsTeaSh/ZE1BIiNpUNv8UVfbEpBN+hiYO/esfhszjA5jBnz1RRG+Itb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212685; c=relaxed/simple;
	bh=VRjoTnc/r79MwWq6zWvYtYuLSBBDT+3foT1mFazvGpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fE61o3MSy2Xvk1FxHgeTsPji6lVaNBtDD0Qz6ARdcMXKE75WqDU5NG0kyoc6lcUrVwXL7dRluVb1cArGbSSvQ8QHTPpKQO3ynS0M/fGNs43ESU4RW8bBk7JBuUW724zR0xTco3SnslY7Me4O7g4lKXGSafongorbWkD4Kd5loyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPMQu7FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A0F9C4AF48;
	Tue,  3 Dec 2024 07:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733212684;
	bh=VRjoTnc/r79MwWq6zWvYtYuLSBBDT+3foT1mFazvGpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mPMQu7FJO6neH6T5UUiv7gBkEJX2ze/rf82mqFi5tkKdnRXSUSR9ZIIT9XuleOoBC
	 jZ/e2q/nfWrUSv4dBis02PRkEIc/oHGKBFBQR6At+9L4qCioOyxd3aqSu1X5PdHLgz
	 bXlFQzj5d2BhJRyxQWlErm/BzBMrPogSy/ZFpoAXrp6My+GtCjP86SAW1SY17z4X3X
	 1AKaWcCrrUQI0PwNrV1oXqFGZpgtnghglzZ/aaaVOmzO5s5bGCaXSTCJnKs0HEkurP
	 neYZrIcvhNbXQp2C/JxuTwbKDYukydZXPeJ3wU/YHOwcZt46Z3VNCPENgm4YqA8Xwb
	 A7bazHVATMyzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D4E6C616;
	Tue,  3 Dec 2024 07:58:04 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Tue, 03 Dec 2024 08:57:58 +0100
Subject: [PATCH v2 2/5] arm64: dts: apple: t8103: Add spi controller nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-asahi-spi-dt-v2-2-cd68bfaf0c84@jannau.net>
References: <20241203-asahi-spi-dt-v2-0-cd68bfaf0c84@jannau.net>
In-Reply-To: <20241203-asahi-spi-dt-v2-0-cd68bfaf0c84@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=9MFJ0ZiYLZ8Qk0zHZWVIFqmiPpB2dmJwF7SezS0P754=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS/XVyOh+tNdlx0U+S8GPvusdbXNZwXHgglMFxhD3q+/
 NTt2w/EO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExEPJfhf3nC44ld7R5hb698
 O5WTHdFteWlJLN8E85Ubr9k0f1fwvcTwi0lL3nRCJH+t4LNleYb/VI+pMat1qQvXrlkXdYOXXyq
 LHQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

Apple silicon devices have one or more SPI devices. Add device tree
nodes for all known controllers. The missing ones could be guessed and
tested with a little effort but since the devices expose no pins and
no new devices are expected there is no point in spending the effort.
SPI is used for spi-nor and input devices like keyboard, trackpad,
touchscreen and fingerprint reader. Only the spi-nor flash has upstream
drivers. Support for it will be added in a following commit.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9b0dad6b618444ac6b1c9735c50cccfc3965f947..c9b789a2ff7e1757930b3fc3682e734c1e4dbef9 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -326,6 +326,20 @@ clkref: clock-ref {
 		clock-output-names = "clkref";
 	};
 
+	clk_120m: clock-120m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "clk_120m";
+	};
+
+	clk_200m: clock-200m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		clock-output-names = "clk_200m";
+	};
+
 	/*
 	 * This is a fabulated representation of the input clock
 	 * to NCO since we don't know the true clock tree.
@@ -441,6 +455,48 @@ fpwm1: pwm@235044000 {
 			status = "disabled";
 		};
 
+		spi0: spi@235100000 {
+			compatible = "apple,t8103-spi", "apple,spi";
+			reg = <0x2 0x35100000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 614 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_200m>;
+			pinctrl-0 = <&spi0_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_spi0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi@235104000 {
+			compatible = "apple,t8103-spi", "apple,spi";
+			reg = <0x2 0x35104000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 615 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_200m>;
+			pinctrl-0 = <&spi1_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_spi1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi3: spi@23510c000 {
+			compatible = "apple,t8103-spi", "apple,spi";
+			reg = <0x2 0x3510c000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 617 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_120m>;
+			pinctrl-0 = <&spi3_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_spi3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		serial0: serial@235200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x35200000 0x0 0x1000>;
@@ -597,6 +653,26 @@ i2c4_pins: i2c4-pins {
 					 <APPLE_PINMUX(134, 1)>;
 			};
 
+			spi0_pins: spi0-pins {
+				pinmux = <APPLE_PINMUX(67, 1)>, /* CLK */
+					<APPLE_PINMUX(68, 1)>,  /* MOSI */
+					<APPLE_PINMUX(69, 1)>;  /* MISO */
+			};
+
+			spi1_pins: spi1-pins {
+				pinmux = <APPLE_PINMUX(42, 1)>,
+					<APPLE_PINMUX(43, 1)>,
+					<APPLE_PINMUX(44, 1)>,
+					<APPLE_PINMUX(45, 1)>;
+			};
+
+			spi3_pins: spi3-pins {
+				pinmux = <APPLE_PINMUX(46, 1)>,
+					<APPLE_PINMUX(47, 1)>,
+					<APPLE_PINMUX(48, 1)>,
+					<APPLE_PINMUX(49, 1)>;
+			};
+
 			pcie_pins: pcie-pins {
 				pinmux = <APPLE_PINMUX(150, 1)>,
 					 <APPLE_PINMUX(151, 1)>,

-- 
2.47.0



