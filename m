Return-Path: <linux-kernel+bounces-423264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32019DA52D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FDC16521C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9C4195FD5;
	Wed, 27 Nov 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9Hc5rPq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BE193439;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701176; cv=none; b=EOO8kSHQCp50V+G1Kp5bY6Ep/X+bkJjM0ZwK7/3n5TKPz4Mrn8KsP1GXNhShDSUAmK7svt+R6bBlnfdWuXVRenDsPUO5cnr6PC9974a7cMGaSoxS++yZFpS1VpShy4VY3JGp5M2u8A2+b88kNCFbJL2xoE5x70RyU31jDiDeUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701176; c=relaxed/simple;
	bh=vANsmCOoD0TQdfXrOh5vdj/T2mUFG1OskmBRHSIuSFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkgFUvlOxmZpD6kCUwEEsZ7JFymSikXu30ZE7TZ+cT7yBwMe330QkkKub4gqs5/t8x9DEP9kNk/Jfqm77mUT8v4f9CqmuaukwTUaO55YNMsan9QjsXVZkpOEsVRRhUTAy2zICGNfya7GF77ZA9EtCjnvnX5IOClO5kcHcS0Ovew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9Hc5rPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16206C4CECC;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732701176;
	bh=vANsmCOoD0TQdfXrOh5vdj/T2mUFG1OskmBRHSIuSFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M9Hc5rPqeP/0WvDqIk7toy609JAmpI1ZHe6DTh695FGq+dB/7VpX/xqXikPSXsB4y
	 MR0RfIkm9KEd7VJ7KxtruK8cUp/NAo7/pSdwNHDrHlcWWtC2SKTBGQrfPRaVDI60qN
	 Ygx0AI4Xftw8sek0OiMnVXQP0JsWIw4WY+lB1o9pFNCqes03KP3Nrls4BwWKPWRanp
	 NDCtwpzQ5nxfSaFtaslTnwMvIDZsaHiVowr+sEj+bVtdpCnmi9t2Vnj+pWn+gJqDx5
	 kBRZgrGw8p0MpXp0MNUqOL5jzQ3/VeuP+Cd+JBnTbkp8NxXFwHo0LEc6LbLsS1HQaG
	 tHRAJqO3S69YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067CED609C1;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 27 Nov 2024 10:52:29 +0100
Subject: [PATCH RESEND 2/5] arm64: dts: apple: t8103: Add spi controller
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-asahi-spi-dt-v1-2-907c9447f623@jannau.net>
References: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
In-Reply-To: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=b1UDB+1sljglElFujEd7C6cEIDOAyC8En801j5/oUGU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS3119tX+Uacs/mOXwpqKM5bHcqw6rs+B/hWQcmpql+L
 nxcbbGoo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwETmSTL8z1//ftWNnQxygtu7
 f29ROvrRaHPpCjbrna3b5CfondAq3sDwz+BMr3HB8aiG38rtLiw8nvH9F+XW7lD4lNGWLr3mfHQ
 BLwA=
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

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9b0dad6b618444ac6b1c9735c50cccfc3965f947..9b2d32059c3542f12fedd7f4dca309baa66c1bd4 100644
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
@@ -441,6 +455,46 @@ fpwm1: pwm@235044000 {
 			status = "disabled";
 		};
 
+		spi0: spi@235100000 {
+			compatible = "apple,t8103-spi", "apple,spi";
+			reg = <0x2 0x35100000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 614 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_200m>;
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
@@ -597,6 +651,20 @@ i2c4_pins: i2c4-pins {
 					 <APPLE_PINMUX(134, 1)>;
 			};
 
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



