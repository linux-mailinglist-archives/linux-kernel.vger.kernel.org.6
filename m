Return-Path: <linux-kernel+bounces-428906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D69E14DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE88B2AC6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3791DFE37;
	Tue,  3 Dec 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiav4+Ij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50D1D86DC;
	Tue,  3 Dec 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212685; cv=none; b=Pskny83zqQOKbtebuVNsKfCanSvZW1v1LephuSH1LZ/21o4+RMPLjmlXd5T5ORDgNLqzwvMuZb4DKhbOIdnGoWiQODud/5iS26YzoJYHSuqfymLz/s2WWZ4OjXmzl2Q/k25lzgw/nPyNkm1RkZ+KvjRNOxJmlk3fc77KbqlNtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212685; c=relaxed/simple;
	bh=2F5Ap5T1lB8u5tqM6pAXUZmDBikyRGGz4fFHNUYaWKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V12DqfE2m2k5bYSTpEM3OTpct3N8y/dU21hQ9JFm0jnrt9qpVWTMTtvot9+hb0noC/Lc+PeOt0OzRN0xmZ3QHJ0/6oJJNYBad9rMSmiy5B6jnawlHtVmo7rT/vL08nFx/vk5WcWUgjxYQDtmbSoYz40JE9LIiG1xMe6MOCB3SVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiav4+Ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FFF7C4CEE2;
	Tue,  3 Dec 2024 07:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733212684;
	bh=2F5Ap5T1lB8u5tqM6pAXUZmDBikyRGGz4fFHNUYaWKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kiav4+IjjJJMxmeDjtda1IXOK++k4ehpuUE601mm87dp1q/QV6ZodFPpvuYvKnj3G
	 Bx2tDwFmtv7P1XBv6iHOSrYGbeKjcWY2RQInnFZ9KzacwpCkBf1eMZ1N8NjGUL5F9s
	 /jWV+ty0YtZlOqXet+45RoVRfOh8lRzCmPhSGiGtRLXg+6kqbh+W/Wp13eHOdsY6J7
	 KzO8SmNAy4ZldSK5AmqCpQEEAz4+qLZD/FTeZsy/I7BJ+45bfqMr11xbu4oSc2Wxlh
	 Vn8U241Upz1sWVz6EDC/sWLctjMAd1kFz5q5GU/OM5ez3PhEIxPEqiheCM3mWGp7MI
	 YDSRjLhuDlQiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EBCE6C617;
	Tue,  3 Dec 2024 07:58:04 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Tue, 03 Dec 2024 08:57:59 +0100
Subject: [PATCH v2 3/5] arm64: dts: apple: t8112: Add spi controller nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-asahi-spi-dt-v2-3-cd68bfaf0c84@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=AHySIPwyOhxDcF5B5Lzvbynlqb4i9BPBB11Y3mPxE4A=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS/XVzn3NQCKjdNN0yfwnZ7UpHptNoJ1xvCUvKub33Zt
 /OxhseSjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABPZq8TIMOlxywQ/nzt9UUt1
 KzvkjjJs7La63MK/THbP2Ts7OmboLGFk6Pp7i82f/V/RHxujqVy+yqYP97Cl719WMKvR9FvbcXd
 nfgA=
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
 arch/arm64/boot/dts/apple/t8112.dtsi | 44 +++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..58d88f1ef92a32061765bd3b569fdae0255dcd7e 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -349,6 +349,13 @@ clkref: clock-ref {
 		clock-output-names = "clkref";
 	};
 
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
@@ -467,6 +474,34 @@ fpwm1: pwm@235044000 {
 			status = "disabled";
 		};
 
+		spi1: spi@235104000 {
+			compatible = "apple,t8112-spi", "apple,spi";
+			reg = <0x2 0x35104000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 749 IRQ_TYPE_LEVEL_HIGH>;
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
+			compatible = "apple,t8112-spi", "apple,spi";
+			reg = <0x2 0x3510c000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 751 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkref>;
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
@@ -626,13 +661,20 @@ i2c4_pins: i2c4-pins {
 					 <APPLE_PINMUX(130, 1)>;
 			};
 
-			spi3_pins: spi3-pins {
+			spi1_pins: spi1-pins {
 				pinmux = <APPLE_PINMUX(46, 1)>,
 					<APPLE_PINMUX(47, 1)>,
 					<APPLE_PINMUX(48, 1)>,
 					<APPLE_PINMUX(49, 1)>;
 			};
 
+			spi3_pins: spi3-pins {
+				pinmux = <APPLE_PINMUX(93, 1)>,
+					<APPLE_PINMUX(94, 1)>,
+					<APPLE_PINMUX(95, 1)>,
+					<APPLE_PINMUX(96, 1)>;
+			};
+
 			pcie_pins: pcie-pins {
 				pinmux = <APPLE_PINMUX(162, 1)>,
 					 <APPLE_PINMUX(163, 1)>,

-- 
2.47.0



