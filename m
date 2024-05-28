Return-Path: <linux-kernel+bounces-192925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288B8D246F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA883B26CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3278173342;
	Tue, 28 May 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdHImEoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D44172BC4;
	Tue, 28 May 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923752; cv=none; b=PBKJ7ONhnbcV9SbW6oWPjqV8nielGx0pcZTP/HC+RQtA2LHm5NIc4VQ48fSAjwCEuxkN7vL83lZADORCXF/hXjGiozeaIk3EnF+ssV1eYeyTnGpRQtaAOjqJTRuZ3FLarZVNw44zlBK5NnC8QB9jUDgnUmbUHKxzzT5XdNVUKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923752; c=relaxed/simple;
	bh=Q0bFS+PmyzJgxliWxPAPFXDorSBt+YEmmDpGo1QIipc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv6m8bD/u+GcbcPvtp1tT/OztBgYVYB1vdawHeTfn47s3gmqVqqB0wQozC44w/PYeyqS5yHphK8STYcjy81RdT1S+Hk7BwVM0cdV42h5qQweWBZl/Oe70N2gTGR78TO8wpVtwLiBjeBRBjwCMck5QhIOOMT9W+tGxIAKX5qaW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdHImEoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26669C3277B;
	Tue, 28 May 2024 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716923752;
	bh=Q0bFS+PmyzJgxliWxPAPFXDorSBt+YEmmDpGo1QIipc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdHImEoLx1Wy2hI4s8p9vuLDaTqFixu5NrLvXGQtzZAHJXJ2YAEuvtmlNHkr+emRu
	 ZJd5D6CbZeBJND65vdy7GgB8j3hSxf+n4Og6/SKx/gfbFljYnrUalIUl54aTBV0Coi
	 cyoSQzv+h7Lg3XFLMPNlf8j3Ui5kab/c+hGRA86GvEHZaw23YF80kCU/s/tyLHtu9M
	 gRyvafqaEhkMlTpp8FYmKtBLzLeJbHbuuN5VLpO4Q1eVXQ6/mc2g9X28K3JfxLNMXx
	 QOGWba6QkY59y4WmxY0lH+oaVwzjdsgyYKej9AJbkuspExtvJICNdKGJvC96+zIIKF
	 WkNsh5DLPL8HQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm/arm64: dts: arm: Use generic clock and regulator nodenames
Date: Tue, 28 May 2024 14:15:32 -0500
Message-ID: <20240528191536.1444649-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528191536.1444649-1-robh@kernel.org>
References: <20240528191536.1444649-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the recent defining of preferred naming for fixed clock and
regulator nodes, convert the Arm Ltd. boards to use the preferred
names. In the cases which had a unit-address, warnings about missing
"reg" property are fixed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../boot/dts/arm/arm-realview-eb-bbrevd.dtsi  |  2 +-
 arch/arm/boot/dts/arm/arm-realview-eb.dtsi    |  6 ++---
 arch/arm/boot/dts/arm/arm-realview-pb1176.dts |  4 ++--
 arch/arm/boot/dts/arm/arm-realview-pb11mp.dts |  6 ++---
 arch/arm/boot/dts/arm/arm-realview-pbx.dtsi   |  6 ++---
 arch/arm/boot/dts/arm/integratorap-im-pd1.dts |  4 ++--
 arch/arm/boot/dts/arm/integratorap.dts        |  4 ++--
 arch/arm/boot/dts/arm/integratorcp.dts        | 14 ++++++------
 arch/arm/boot/dts/arm/mps2.dtsi               | 14 ++++++------
 arch/arm/boot/dts/arm/versatile-ab.dts        |  8 +++----
 arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi   |  8 +++----
 arch/arm/boot/dts/arm/vexpress-v2m.dtsi       | 16 +++++++-------
 .../boot/dts/arm/vexpress-v2p-ca15-tc1.dts    | 14 ++++++------
 .../arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts | 22 +++++++++----------
 arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts   | 12 +++++-----
 arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts    | 18 +++++++--------
 arch/arm64/boot/dts/arm/corstone1000-fvp.dts  |  2 +-
 arch/arm64/boot/dts/arm/corstone1000.dtsi     |  6 ++---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi    |  6 ++---
 arch/arm64/boot/dts/arm/juno-clocks.dtsi      | 10 ++++-----
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 10 ++++-----
 .../boot/dts/arm/rtsm_ve-motherboard.dtsi     | 10 ++++-----
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts |  6 ++---
 23 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dtsi
index a79e1d1d30a7..7f62aef9ca8a 100644
--- a/arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dtsi
+++ b/arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dtsi
@@ -22,7 +22,7 @@
 
 / {
 	/* Introduce a fixed regulator for the new ethernet controller */
-	veth: fixedregulator@0 {
+	veth: regulator-veth {
 		compatible = "regulator-fixed";
 		regulator-name = "veth";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
index b3ced3380b7d..c2e6c47b2555 100644
--- a/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
@@ -45,7 +45,7 @@ memory@0 {
 	};
 
 	/* The voltage to the MMC card is hardwired at 3.3V */
-	vmmc: fixedregulator@0 {
+	vmmc: regulator-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
@@ -59,7 +59,7 @@ xtal24mhz: mclk: kmiclk: sspclk: uartclk: wdogclk: clock-24000000 {
 		clock-frequency = <24000000>;
 	};
 
-	timclk: timclk@1M {
+	timclk: clock-1000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clock-div = <24>;
@@ -68,7 +68,7 @@ timclk: timclk@1M {
 	};
 
 	/* FIXME: this actually hangs off the PLL clocks */
-	pclk: pclk@0 {
+	pclk: clock-pclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
index cd86986175d4..8cd0cde2e946 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
@@ -69,7 +69,7 @@ xtal24mhz: mclk: kmiclk: sspclk: uartclk: clock-24000000 {
 		clock-frequency = <24000000>;
 	};
 
-	timclk: timclk@1M {
+	timclk: clock-1000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clock-div = <24>;
@@ -78,7 +78,7 @@ timclk: timclk@1M {
 	};
 
 	/* FIXME: this actually hangs off the PLL clocks */
-	pclk: pclk@0 {
+	pclk: clock-pclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
index 0988c2bd436b..647dd5cdb2ed 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
@@ -169,13 +169,13 @@ xtal24mhz: mclk: kmiclk: sspclk: uartclk: wdogclk: clock-24000000 {
 		clock-frequency = <24000000>;
 	};
 
-	refclk32khz: refclk32khz {
+	refclk32khz: clock-32768 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 	};
 
-	timclk: timclk@1M {
+	timclk: clock-1000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clock-div = <24>;
@@ -184,7 +184,7 @@ timclk: timclk@1M {
 	};
 
 	/* FIXME: this actually hangs off the PLL clocks */
-	pclk: pclk@0 {
+	pclk: clock-pclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
index 6a0e67998061..4966cf408ea9 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
@@ -68,13 +68,13 @@ xtal24mhz: mclk: kmiclk: sspclk: uartclk: wdogclk: clock-24000000 {
 		clock-frequency = <24000000>;
 	};
 
-	refclk32khz: refclk32khz {
+	refclk32khz: clock-32768 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 	};
 
-	timclk: timclk@1M {
+	timclk: clock-1000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clock-div = <24>;
@@ -83,7 +83,7 @@ timclk: timclk@1M {
 	};
 
 	/* FIXME: this actually hangs off the PLL clocks */
-	pclk: pclk@0 {
+	pclk: clock-pclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
diff --git a/arch/arm/boot/dts/arm/integratorap-im-pd1.dts b/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
index 367850ea0912..db13e09f2fab 100644
--- a/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
+++ b/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
@@ -54,7 +54,7 @@ vco2: clock-controller@4 {
 	};
 
 	/* Also used for the Smart Card Interface SCI */
-	impd1_uartclk: clock@1_4 {
+	impd1_uartclk: clock-uart {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
 		clock-div = <4>;
@@ -64,7 +64,7 @@ impd1_uartclk: clock@1_4 {
 	};
 
 	/* For the SSP the clock is divided by 64 */
-	impd1_sspclk: clock@1_64 {
+	impd1_sspclk: clock-ssp {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
 		clock-div = <64>;
diff --git a/arch/arm/boot/dts/arm/integratorap.dts b/arch/arm/boot/dts/arm/integratorap.dts
index 27498e0f93f6..9b6a1dbaf265 100644
--- a/arch/arm/boot/dts/arm/integratorap.dts
+++ b/arch/arm/boot/dts/arm/integratorap.dts
@@ -64,7 +64,7 @@ xtal24mhz: pclk: clock-24000000 {
 	};
 
 	/* The UART clock is 14.74 MHz divided by an ICS525 */
-	uartclk: uartclk@14.74M {
+	uartclk: clock-14745600 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <14745600>;
@@ -73,7 +73,7 @@ uartclk: uartclk@14.74M {
 
 	core-module@10000000 {
 		/* 24 MHz chrystal on the core module */
-		cm24mhz: cm24mhz@24M {
+		cm24mhz: clock-24000000 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
diff --git a/arch/arm/boot/dts/arm/integratorcp.dts b/arch/arm/boot/dts/arm/integratorcp.dts
index c011333eb165..8ad1a8957ace 100644
--- a/arch/arm/boot/dts/arm/integratorcp.dts
+++ b/arch/arm/boot/dts/arm/integratorcp.dts
@@ -47,14 +47,14 @@ cpu@0 {
 	 */
 
 	/* The codec chrystal operates at 24.576 MHz */
-	xtal_codec: xtal24.576@24.576M {
+	xtal_codec: clock-24576000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24576000>;
 	};
 
 	/* The chrystal is divided by 2 by the codec for the AACI bit clock */
-	aaci_bitclk: aaci_bitclk@12.288M {
+	aaci_bitclk: clock-12288000 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clock-div = <2>;
@@ -63,21 +63,21 @@ aaci_bitclk: aaci_bitclk@12.288M {
 	};
 
 	/* This is a 25MHz chrystal on the base board */
-	xtal25mhz: xtal25mhz@25M {
+	xtal25mhz: clock-25000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <25000000>;
 	};
 
 	/* The UART clock is 14.74 MHz divided from 25MHz by an ICS525 */
-	uartclk: uartclk@14.74M {
+	uartclk: clock-14745600 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <14745600>;
 	};
 
 	/* Actually sysclk I think */
-	pclk: pclk@0 {
+	pclk: clock-pclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
@@ -85,7 +85,7 @@ pclk: pclk@0 {
 
 	core-module@10000000 {
 		/* 24 MHz chrystal on the core module */
-		cm24mhz: cm24mhz@24M {
+		cm24mhz: clock-24000000 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -131,7 +131,7 @@ kmiclk: kmiclk@1M {
 		};
 
 		/* The timer clock is the 24 MHz oscillator divided to 1MHz */
-		timclk: timclk@1M {
+		timclk: clock-1000000 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <24>;
diff --git a/arch/arm/boot/dts/arm/mps2.dtsi b/arch/arm/boot/dts/arm/mps2.dtsi
index d930168fbd91..e240bc8aa605 100644
--- a/arch/arm/boot/dts/arm/mps2.dtsi
+++ b/arch/arm/boot/dts/arm/mps2.dtsi
@@ -48,31 +48,31 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	oscclk0: clk-osc0 {
+	oscclk0: clock-50000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <50000000>;
 	};
 
-	oscclk1: clk-osc1 {
+	oscclk1: clock-24576000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24576000>;
 	};
 
-	oscclk2: clk-osc2 {
+	oscclk2: clock-25000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	cfgclk: clk-cfg {
+	cfgclk: clock-5000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <5000000>;
 	};
 
-	spicfgclk: clk-spicfg {
+	spicfgclk: clock-75000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <75000000>;
@@ -86,7 +86,7 @@ sysclk: spiclcd: spicon: i2cclcd: i2caud: clock-sys {
 		clock-mult = <1>;
 	};
 
-	audmclk: clk-audm {
+	audmclk: clk-12388000 {
 		compatible = "fixed-factor-clock";
 		clocks = <&oscclk1>;
 		#clock-cells = <0>;
@@ -94,7 +94,7 @@ audmclk: clk-audm {
 		clock-mult = <1>;
 	};
 
-	audsclk: clk-auds {
+	audsclk: clk-3072000 {
 		compatible = "fixed-factor-clock";
 		clocks = <&oscclk1>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/arm/versatile-ab.dts b/arch/arm/boot/dts/arm/versatile-ab.dts
index ff5ca3e9afba..7057813137b6 100644
--- a/arch/arm/boot/dts/arm/versatile-ab.dts
+++ b/arch/arm/boot/dts/arm/versatile-ab.dts
@@ -24,7 +24,7 @@ memory@0 {
 		reg = <0x0 0x08000000>;
 	};
 
-	xtal24mhz: xtal24mhz@24M {
+	xtal24mhz: clock-24000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -142,14 +142,14 @@ led@8,7 {
 		};
 
 		/* OSC1 on AB, OSC4 on PB */
-		osc1: cm_aux_osc@24M {
+		osc1: clock-osc {
 			#clock-cells = <0>;
 			compatible = "arm,versatile-cm-auxosc";
 			clocks = <&xtal24mhz>;
 		};
 
 		/* The timer clock is the 24 MHz oscillator divided to 1MHz */
-		timclk: timclk@1M {
+		timclk: clock-1000000 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <24>;
@@ -157,7 +157,7 @@ timclk: timclk@1M {
 			clocks = <&xtal24mhz>;
 		};
 
-		pclk: pclk@24M {
+		pclk: clock-24000000 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <1>;
diff --git a/arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
index 8af4b77fe655..158b3923eae3 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
@@ -20,7 +20,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
-	v2m_fixed_3v3: fixed-regulator-0 {
+	v2m_fixed_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
@@ -28,21 +28,21 @@ v2m_fixed_3v3: fixed-regulator-0 {
 		regulator-always-on;
 	};
 
-	v2m_clk24mhz: clk24mhz {
+	v2m_clk24mhz: clock-24000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 		clock-output-names = "v2m:clk24mhz";
 	};
 
-	v2m_refclk1mhz: refclk1mhz {
+	v2m_refclk1mhz: clock-1000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <1000000>;
 		clock-output-names = "v2m:refclk1mhz";
 	};
 
-	v2m_refclk32khz: refclk32khz {
+	v2m_refclk32khz: clock-32768 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
diff --git a/arch/arm/boot/dts/arm/vexpress-v2m.dtsi b/arch/arm/boot/dts/arm/vexpress-v2m.dtsi
index c5e92f6d2fcd..be03f2a8a57a 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/arm/vexpress-v2m.dtsi
@@ -351,7 +351,7 @@ clcd_pads_mb: endpoint {
 				};
 			};
 
-			v2m_fixed_3v3: fixed-regulator-0 {
+			v2m_fixed_3v3: regulator-3v3 {
 				compatible = "regulator-fixed";
 				regulator-name = "3V3";
 				regulator-min-microvolt = <3300000>;
@@ -359,21 +359,21 @@ v2m_fixed_3v3: fixed-regulator-0 {
 				regulator-always-on;
 			};
 
-			v2m_clk24mhz: clk24mhz {
+			v2m_clk24mhz: clock-24000000 {
 				compatible = "fixed-clock";
 				#clock-cells = <0>;
 				clock-frequency = <24000000>;
 				clock-output-names = "v2m:clk24mhz";
 			};
 
-			v2m_refclk1mhz: refclk1mhz {
+			v2m_refclk1mhz: clock-1000000 {
 				compatible = "fixed-clock";
 				#clock-cells = <0>;
 				clock-frequency = <1000000>;
 				clock-output-names = "v2m:refclk1mhz";
 			};
 
-			v2m_refclk32khz: refclk32khz {
+			v2m_refclk32khz: clock-32768 {
 				compatible = "fixed-clock";
 				#clock-cells = <0>;
 				clock-frequency = <32768>;
@@ -436,7 +436,7 @@ mcc {
 				compatible = "arm,vexpress,config-bus";
 				arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-				oscclk0 {
+				clock-controller-0 {
 					/* MCC static memory clock */
 					compatible = "arm,vexpress-osc";
 					arm,vexpress-sysreg,func = <1 0>;
@@ -445,7 +445,7 @@ oscclk0 {
 					clock-output-names = "v2m:oscclk0";
 				};
 
-				v2m_oscclk1: oscclk1 {
+				v2m_oscclk1: clock-controller-1 {
 					/* CLCD clock */
 					compatible = "arm,vexpress-osc";
 					arm,vexpress-sysreg,func = <1 1>;
@@ -454,7 +454,7 @@ v2m_oscclk1: oscclk1 {
 					clock-output-names = "v2m:oscclk1";
 				};
 
-				v2m_oscclk2: oscclk2 {
+				v2m_oscclk2: clock-controller-2 {
 					/* IO FPGA peripheral clock */
 					compatible = "arm,vexpress-osc";
 					arm,vexpress-sysreg,func = <1 2>;
@@ -463,7 +463,7 @@ v2m_oscclk2: oscclk2 {
 					clock-output-names = "v2m:oscclk2";
 				};
 
-				volt-vio {
+				regulator-vio {
 					/* Logic level voltage */
 					compatible = "arm,vexpress-volt";
 					arm,vexpress-sysreg,func = <2 0>;
diff --git a/arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dts
index 679537e17ff5..5a91e936edef 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dts
@@ -142,7 +142,7 @@ dcc {
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		oscclk0 {
+		clock-controller-0 {
 			/* CPU PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -151,7 +151,7 @@ oscclk0 {
 			clock-output-names = "oscclk0";
 		};
 
-		oscclk4 {
+		clock-controller-4 {
 			/* Multiplexed AXI master clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -160,7 +160,7 @@ oscclk4 {
 			clock-output-names = "oscclk4";
 		};
 
-		hdlcd_clk: oscclk5 {
+		hdlcd_clk: clock-controller-5 {
 			/* HDLCD PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 5>;
@@ -169,7 +169,7 @@ hdlcd_clk: oscclk5 {
 			clock-output-names = "oscclk5";
 		};
 
-		smbclk: oscclk6 {
+		smbclk: clock-controller-6 {
 			/* SMB clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 6>;
@@ -178,7 +178,7 @@ smbclk: oscclk6 {
 			clock-output-names = "oscclk6";
 		};
 
-		sys_pll: oscclk7 {
+		sys_pll: clock-controller-7 {
 			/* SYS PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 7>;
@@ -187,7 +187,7 @@ sys_pll: oscclk7 {
 			clock-output-names = "oscclk7";
 		};
 
-		oscclk8 {
+		clock-controller-8 {
 			/* DDR2 PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 8>;
@@ -196,7 +196,7 @@ oscclk8 {
 			clock-output-names = "oscclk8";
 		};
 
-		volt-cores {
+		regulator-cores {
 			/* CPU core voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
diff --git a/arch/arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts
index 511e87cc2bc5..6ef23c53d2d8 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts
@@ -253,7 +253,7 @@ dcc {
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		oscclk0 {
+		clock-controller-0 {
 			/* A15 PLL 0 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -262,7 +262,7 @@ oscclk0 {
 			clock-output-names = "oscclk0";
 		};
 
-		oscclk1 {
+		clock-controller-1 {
 			/* A15 PLL 1 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
@@ -271,7 +271,7 @@ oscclk1 {
 			clock-output-names = "oscclk1";
 		};
 
-		oscclk2 {
+		clock-controller-2 {
 			/* A7 PLL 0 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 2>;
@@ -280,7 +280,7 @@ oscclk2 {
 			clock-output-names = "oscclk2";
 		};
 
-		oscclk3 {
+		clock-controller-3 {
 			/* A7 PLL 1 reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 3>;
@@ -289,7 +289,7 @@ oscclk3 {
 			clock-output-names = "oscclk3";
 		};
 
-		oscclk4 {
+		clock-controller-4 {
 			/* External AXI master clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -298,7 +298,7 @@ oscclk4 {
 			clock-output-names = "oscclk4";
 		};
 
-		hdlcd_clk: oscclk5 {
+		hdlcd_clk: clock-controller-5 {
 			/* HDLCD PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 5>;
@@ -307,7 +307,7 @@ hdlcd_clk: oscclk5 {
 			clock-output-names = "oscclk5";
 		};
 
-		smbclk: oscclk6 {
+		smbclk: clock-controller-6 {
 			/* Static memory controller clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 6>;
@@ -316,7 +316,7 @@ smbclk: oscclk6 {
 			clock-output-names = "oscclk6";
 		};
 
-		oscclk7 {
+		clock-controller-7 {
 			/* SYS PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 7>;
@@ -325,7 +325,7 @@ oscclk7 {
 			clock-output-names = "oscclk7";
 		};
 
-		oscclk8 {
+		clock-controller-8 {
 			/* DDR2 PLL reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 8>;
@@ -334,7 +334,7 @@ oscclk8 {
 			clock-output-names = "oscclk8";
 		};
 
-		volt-a15 {
+		regulator-a15 {
 			/* A15 CPU core voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -345,7 +345,7 @@ volt-a15 {
 			label = "A15 Vcore";
 		};
 
-		volt-a7 {
+		regulator-a7 {
 			/* A7 CPU core voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 1>;
diff --git a/arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts
index ff1f9a1bcfcf..e3896253f33e 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts
@@ -145,7 +145,7 @@ dcc {
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		cpu_clk: oscclk0 {
+		cpu_clk: clock-controller-0 {
 			/* CPU and internal AXI reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -154,7 +154,7 @@ cpu_clk: oscclk0 {
 			clock-output-names = "oscclk0";
 		};
 
-		axi_clk: oscclk1 {
+		axi_clk: clock-controller-1 {
 			/* Multiplexed AXI master clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
@@ -163,7 +163,7 @@ axi_clk: oscclk1 {
 			clock-output-names = "oscclk1";
 		};
 
-		oscclk2 {
+		clock-controller-2 {
 			/* DDR2 */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 2>;
@@ -172,7 +172,7 @@ oscclk2 {
 			clock-output-names = "oscclk2";
 		};
 
-		hdlcd_clk: oscclk3 {
+		hdlcd_clk: clock-controller-3 {
 			/* HDLCD */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 3>;
@@ -181,7 +181,7 @@ hdlcd_clk: oscclk3 {
 			clock-output-names = "oscclk3";
 		};
 
-		oscclk4 {
+		clock-controller-4 {
 			/* Test chip gate configuration */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -190,7 +190,7 @@ oscclk4 {
 			clock-output-names = "oscclk4";
 		};
 
-		smbclk: oscclk5 {
+		smbclk: clock-controller-5 {
 			/* SMB clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 5>;
diff --git a/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
index 8bf35666412b..43a5a4ab6ff0 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
@@ -187,7 +187,7 @@ dcc {
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		oscclk0: extsaxiclk {
+		oscclk0: clock-controller-0 {
 			/* ACLK clock to the AXI master port on the test chip */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
@@ -196,7 +196,7 @@ oscclk0: extsaxiclk {
 			clock-output-names = "extsaxiclk";
 		};
 
-		oscclk1: clcdclk {
+		oscclk1: clock-controller-1 {
 			/* Reference clock for the CLCD */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
@@ -205,7 +205,7 @@ oscclk1: clcdclk {
 			clock-output-names = "clcdclk";
 		};
 
-		smbclk: oscclk2: tcrefclk {
+		smbclk: oscclk2: clock-controller-2 {
 			/* Reference clock for the test chip internal PLLs */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 2>;
@@ -214,7 +214,7 @@ smbclk: oscclk2: tcrefclk {
 			clock-output-names = "tcrefclk";
 		};
 
-		volt-vd10 {
+		regulator-vd10 {
 			/* Test Chip internal logic voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -223,7 +223,7 @@ volt-vd10 {
 			label = "VD10";
 		};
 
-		volt-vd10-s2 {
+		regulator-vd10-s2 {
 			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 1>;
@@ -232,7 +232,7 @@ volt-vd10-s2 {
 			label = "VD10_S2";
 		};
 
-		volt-vd10-s3 {
+		regulator-vd10-s3 {
 			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 2>;
@@ -241,7 +241,7 @@ volt-vd10-s3 {
 			label = "VD10_S3";
 		};
 
-		volt-vcc1v8 {
+		regulator-vcc1v8 {
 			/* DDR2 SDRAM and Test Chip DDR2 I/O supply */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 3>;
@@ -250,7 +250,7 @@ volt-vcc1v8 {
 			label = "VCC1V8";
 		};
 
-		volt-ddr2vtt {
+		regulator-ddr2vtt {
 			/* DDR2 SDRAM VTT termination voltage */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 4>;
@@ -259,7 +259,7 @@ volt-ddr2vtt {
 			label = "DDR2VTT";
 		};
 
-		volt-vcc3v3 {
+		regulator-vcc3v3 {
 			/* Local board supply for miscellaneous logic external to the Test Chip */
 			arm,vexpress-sysreg,func = <2 5>;
 			compatible = "arm,vexpress-volt";
diff --git a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
index 901a7fc83307..abd013562995 100644
--- a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
+++ b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
@@ -21,7 +21,7 @@ smsc: ethernet@4010000 {
 		reg-io-width = <2>;
 	};
 
-	vmmc_v3_3d: fixed_v3_3d {
+	vmmc_v3_3d: regulator-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc_supply";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/arm/corstone1000.dtsi b/arch/arm64/boot/dts/arm/corstone1000.dtsi
index 6ad7829f9e28..bb9b96fb5314 100644
--- a/arch/arm64/boot/dts/arm/corstone1000.dtsi
+++ b/arch/arm64/boot/dts/arm/corstone1000.dtsi
@@ -60,14 +60,14 @@ L2_0: l2-cache0 {
 		cache-sets = <1024>;
 	};
 
-	refclk100mhz: refclk100mhz {
+	refclk100mhz: clock-100000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
 		clock-output-names = "apb_pclk";
 	};
 
-	smbclk: refclk24mhzx2 {
+	smbclk: clock-48000000 {
 		/* Reference 24MHz clock x 2 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -83,7 +83,7 @@ timer {
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	uartclk: uartclk {
+	uartclk: clock-50000000 {
 		/* UART clock - 50MHz */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 7b41537731a6..93f1e7c026b8 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -99,21 +99,21 @@ watchdog@2a440000 {
 		timeout-sec = <30>;
 	};
 
-	v2m_clk24mhz: clk24mhz {
+	v2m_clk24mhz: clock-24000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 		clock-output-names = "v2m:clk24mhz";
 	};
 
-	v2m_refclk1mhz: refclk1mhz {
+	v2m_refclk1mhz: clock-1000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <1000000>;
 		clock-output-names = "v2m:refclk1mhz";
 	};
 
-	v2m_refclk32khz: refclk32khz {
+	v2m_refclk32khz: clock-32768 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
index 2870b5eeb198..6d7d88e9591a 100644
--- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
@@ -8,35 +8,35 @@
  */
 / {
 	/* SoC fixed clocks */
-	soc_uartclk: refclk7372800hz {
+	soc_uartclk: clock-7372800 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <7372800>;
 		clock-output-names = "juno:uartclk";
 	};
 
-	soc_usb48mhz: clk48mhz {
+	soc_usb48mhz: clock-48000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 		clock-output-names = "clk48mhz";
 	};
 
-	soc_smc50mhz: clk50mhz {
+	soc_smc50mhz: clock-50000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <50000000>;
 		clock-output-names = "smc_clk";
 	};
 
-	soc_refclk100mhz: refclk100mhz {
+	soc_refclk100mhz: clock-100000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
 		clock-output-names = "apb_pclk";
 	};
 
-	soc_faxiclk: refclk400mhz {
+	soc_faxiclk: clock-400000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <400000000>;
diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index be42932f7e21..b689546ce360 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -8,35 +8,35 @@
  */
 
 / {
-	mb_clk24mhz: clk24mhz {
+	mb_clk24mhz: clock-24000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 		clock-output-names = "juno_mb:clk24mhz";
 	};
 
-	mb_clk25mhz: clk25mhz {
+	mb_clk25mhz: clock-25000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 		clock-output-names = "juno_mb:clk25mhz";
 	};
 
-	v2m_refclk1mhz: refclk1mhz {
+	v2m_refclk1mhz: clock-1000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <1000000>;
 		clock-output-names = "juno_mb:refclk1mhz";
 	};
 
-	v2m_refclk32khz: refclk32khz {
+	v2m_refclk32khz: clock-32768 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 		clock-output-names = "juno_mb:refclk32khz";
 	};
 
-	mb_fixed_3v3: mcc-sb-3v3 {
+	mb_fixed_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "MCC_SB_3V3";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index ba8beef3fe99..66b1b74d27dc 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -8,28 +8,28 @@
  * VEMotherBoard.lisa
  */
 / {
-	v2m_clk24mhz: clk24mhz {
+	v2m_clk24mhz: clock-24000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 		clock-output-names = "v2m:clk24mhz";
 	};
 
-	v2m_refclk1mhz: refclk1mhz {
+	v2m_refclk1mhz: clock-1000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <1000000>;
 		clock-output-names = "v2m:refclk1mhz";
 	};
 
-	v2m_refclk32khz: refclk32khz {
+	v2m_refclk32khz: clock-32768 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 		clock-output-names = "v2m:refclk32khz";
 	};
 
-	v2m_fixed_3v3: v2m-3v3 {
+	v2m_fixed_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
@@ -41,7 +41,7 @@ mcc {
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		v2m_oscclk1: oscclk1 {
+		v2m_oscclk1: clock-controller {
 			/* CLCD clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 1>;
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 9115c99d0dc0..a0e1fa83eafa 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -111,7 +111,7 @@ dcc {
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		smbclk: smclk {
+		smbclk: clock-controller {
 			/* SMC clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 4>;
@@ -120,7 +120,7 @@ smbclk: smclk {
 			clock-output-names = "smclk";
 		};
 
-		volt-vio {
+		regulator-vio {
 			/* VIO to expansion board above */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 0>;
@@ -130,7 +130,7 @@ volt-vio {
 			regulator-always-on;
 		};
 
-		volt-12v {
+		regulator-12v {
 			/* 12V from power connector J6 */
 			compatible = "arm,vexpress-volt";
 			arm,vexpress-sysreg,func = <2 1>;
-- 
2.43.0


