Return-Path: <linux-kernel+bounces-192924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9258D246D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B91F29B74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E138384;
	Tue, 28 May 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNwvASTH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A00170822;
	Tue, 28 May 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923746; cv=none; b=AcRbjLzKtlpdZDTXz9v2uj3qU9pfasgHkDYoKM8OECJV62syCAzLanvmN/wk8HOJC0X34sSzFX+IHBXra2EvHAwB5E/QAfsXJHYgsNzqWatUofFENkeBNpVtvZbBMAhq6xAbb9JwsCgajo3h4edKRQUSQXIJ1dHK8qwiz+4NMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923746; c=relaxed/simple;
	bh=W9Hk0yMrwr4jkcQ6ZWTGhlT7vkcX3TSsoa2ozME1iXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qn+rcZEXm9ytGk5W3TZU0jq30YJjf982MppjYRdBvFEKgXYmOauWtcINEPWuh25EQhUYSDVM5rfML42VmupP83oahSS59j6CftB3fiHj7dquJSmyfAWbVu8FOPpqdins2MsonQNQvpbqmsNln/Jp7pTU8rAOby0zUH74M9sGMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNwvASTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B66C3277B;
	Tue, 28 May 2024 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716923745;
	bh=W9Hk0yMrwr4jkcQ6ZWTGhlT7vkcX3TSsoa2ozME1iXA=;
	h=From:To:Cc:Subject:Date:From;
	b=RNwvASTHid1n6p5dlreSdAPoeBvV0HNsD4lUozXBi23oisy8ZgvIdbLv4SqeNz0Eq
	 3egcvYMoMQZxrFRKgLHHISqFpe9aj7zU5x7veuvoqwsOUzVTnZxOXgm0j4UkiDpe/3
	 sGqAANffsMXJTqejuGCIi5PlZdE7nGOIZ1zu62dHYfwaX6ldCkJ9cMEgEV5McVk46D
	 zEmmZ7s9JTWdiXtA3wFf/wVnRZtLuuBu6lMttvWdFIyHXynhO4H4f6JwUsODZ2Umig
	 CeNWNcTe3Rp3GfJjPUI043OWs+cD2OomtGfFsREexdKuPrHRHrHRhMeJ58XwTRDfuV
	 4iACjWLatr5xQ==
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
Subject: [PATCH 1/2] arm: dts: arm: Drop redundant fixed-factor clocks
Date: Tue, 28 May 2024 14:15:31 -0500
Message-ID: <20240528191536.1444649-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's not much reason to have multiple fixed-factor-clock instances
which are all the same factor and clock input. Drop the nodes, but keep
the labels to minimize the changes and keep some distinction of the
different clocks.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/arm/arm-realview-eb.dtsi    | 42 +------------------
 arch/arm/boot/dts/arm/arm-realview-pb1176.dts | 34 +--------------
 arch/arm/boot/dts/arm/arm-realview-pb11mp.dts | 42 +------------------
 arch/arm/boot/dts/arm/arm-realview-pbx.dtsi   | 42 +------------------
 arch/arm/boot/dts/arm/integratorap.dts        | 10 +----
 arch/arm/boot/dts/arm/mps2.dtsi               | 34 +--------------
 6 files changed, 6 insertions(+), 198 deletions(-)

diff --git a/arch/arm/boot/dts/arm/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
index 96f813f44cb3..b3ced3380b7d 100644
--- a/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
@@ -53,7 +53,7 @@ vmmc: fixedregulator@0 {
 		regulator-boot-on;
         };
 
-	xtal24mhz: xtal24mhz@24M {
+	xtal24mhz: mclk: kmiclk: sspclk: uartclk: wdogclk: clock-24000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -67,46 +67,6 @@ timclk: timclk@1M {
 		clocks = <&xtal24mhz>;
 	};
 
-	mclk: mclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	kmiclk: kmiclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	sspclk: sspclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	uartclk: uartclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	wdogclk: wdogclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
 	/* FIXME: this actually hangs off the PLL clocks */
 	pclk: pclk@0 {
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
index e819e58e4b62..cd86986175d4 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
@@ -63,7 +63,7 @@ veth: regulator-veth {
 		regulator-boot-on;
 	};
 
-	xtal24mhz: xtal24mhz@24M {
+	xtal24mhz: mclk: kmiclk: sspclk: uartclk: clock-24000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -77,38 +77,6 @@ timclk: timclk@1M {
 		clocks = <&xtal24mhz>;
 	};
 
-	mclk: mclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	kmiclk: kmiclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	sspclk: sspclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	uartclk: uartclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
 	/* FIXME: this actually hangs off the PLL clocks */
 	pclk: pclk@0 {
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
index 29afc5c05759..0988c2bd436b 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
@@ -163,7 +163,7 @@ veth: regulator-veth {
 		regulator-boot-on;
 	};
 
-	xtal24mhz: xtal24mhz@24M {
+	xtal24mhz: mclk: kmiclk: sspclk: uartclk: wdogclk: clock-24000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -183,46 +183,6 @@ timclk: timclk@1M {
 		clocks = <&xtal24mhz>;
 	};
 
-	mclk: mclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	kmiclk: kmiclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	sspclk: sspclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	uartclk: uartclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	wdogclk: wdogclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
 	/* FIXME: this actually hangs off the PLL clocks */
 	pclk: pclk@0 {
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
index e715626db567..6a0e67998061 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
@@ -62,7 +62,7 @@ veth: regulator-veth {
 		regulator-boot-on;
 	};
 
-	xtal24mhz: xtal24mhz@24M {
+	xtal24mhz: mclk: kmiclk: sspclk: uartclk: wdogclk: clock-24000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -82,46 +82,6 @@ timclk: timclk@1M {
 		clocks = <&xtal24mhz>;
 	};
 
-	mclk: mclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	kmiclk: kmiclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	sspclk: sspclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	uartclk: uartclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
-	wdogclk: wdogclk@24M {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
 	/* FIXME: this actually hangs off the PLL clocks */
 	pclk: pclk@0 {
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/arm/integratorap.dts b/arch/arm/boot/dts/arm/integratorap.dts
index d9927d3181dc..27498e0f93f6 100644
--- a/arch/arm/boot/dts/arm/integratorap.dts
+++ b/arch/arm/boot/dts/arm/integratorap.dts
@@ -57,20 +57,12 @@ chosen {
 	};
 
 	/* 24 MHz chrystal on the Integrator/AP development board */
-	xtal24mhz: xtal24mhz@24M {
+	xtal24mhz: pclk: clock-24000000 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
 	};
 
-	pclk: pclk@0 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&xtal24mhz>;
-	};
-
 	/* The UART clock is 14.74 MHz divided by an ICS525 */
 	uartclk: uartclk@14.74M {
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/arm/mps2.dtsi b/arch/arm/boot/dts/arm/mps2.dtsi
index ce308820765b..d930168fbd91 100644
--- a/arch/arm/boot/dts/arm/mps2.dtsi
+++ b/arch/arm/boot/dts/arm/mps2.dtsi
@@ -78,7 +78,7 @@ spicfgclk: clk-spicfg {
 		clock-frequency = <75000000>;
 	};
 
-	sysclk: clk-sys {
+	sysclk: spiclcd: spicon: i2cclcd: i2caud: clock-sys {
 		compatible = "fixed-factor-clock";
 		clocks = <&oscclk0>;
 		#clock-cells = <0>;
@@ -102,38 +102,6 @@ audsclk: clk-auds {
 		clock-mult = <1>;
 	};
 
-	spiclcd: clk-cpiclcd {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk0>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
-
-	spicon: clk-spicon {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk0>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
-
-	i2cclcd: clk-i2cclcd {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk0>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
-
-	i2caud: clk-i2caud {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk0>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.43.0


