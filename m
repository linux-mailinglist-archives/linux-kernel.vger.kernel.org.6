Return-Path: <linux-kernel+bounces-202835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D208FD1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8193FB22160
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD5F48CFC;
	Wed,  5 Jun 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ist5IpDL"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5D35280
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601430; cv=none; b=d7JIJG0G6lA2xlYDWxyjvZ1r6UWix4zl7OmaYgEK4vm2flfOFqB+3Z3bwvx2YKfzkTPK/lgkpkrLAUZQIgy+NOugFYUSjuFAEY42uRHEjyWHd5Z8w0Zma+vDJUvZll+aH6byXfrTwzMQUxLe+hg1A2E+qwNdBe4rDqsbm+DadzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601430; c=relaxed/simple;
	bh=RVGLVrXtZWSr7eszIRlXdwfocDl4iCLntNSUj3aOpyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhnZ0ER6OrUHnBQ6Y+1cu2OwhD9G9mKueRSH6hmIkydNS4CyC+ot61bKvuZ+xVIkwluSBH2eL/NclEPhd2FWRrqXilYjw/4VvAPcSstKqFIZQiDHtV1JyttVxG68SHlHyLOJXNbzo9XfMtccR9ZVv04j0ldyLo90f3IgBAKxxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ist5IpDL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4214fe0067fso18032065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717601424; x=1718206224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1I0hapVoV1MxluxTaAAju8HQuVcl3G3Et8TC2Nwvj4g=;
        b=ist5IpDLk9fdCmPCalqzEDeT+zhkB0BrhoJjnUHggUlvqIE/oIA9RhkvRdkccNnplc
         5Xggr9vEVED+PXzcyCaERoJkMSI4VSB1FSf1MrSyBq8/rDbS5pp6GBv+V+jknNXukl2x
         PLt0EstI10QHPY/kC6aZXqqIh2dGqpjT1XDkhIptsQp9OO39Krb/E/9ksZKbsVQefly8
         xIldVMgXI0ymCTGhxKd8P0EQBfCZqE1TbLthOuHUEa1O8cxYng71vM2LavAgENBZ1Tqu
         7bfhoFnP3zdWkD5hz1RITZN89OzoWz2l44HB8TyNWPlUe/H8Uhirfnq1gOXw7u3yq8Um
         FPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601424; x=1718206224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I0hapVoV1MxluxTaAAju8HQuVcl3G3Et8TC2Nwvj4g=;
        b=esGt0iCAcSH0aIfNol23XxV+ViWXSZx8qM+QimaW5s0WaN1iT1umclzs8Axvi1L79z
         xXILQA9fTtl1NDDV5+KeeSbOrc/2MpPt0NHxSQHnnzW6LQLRbDkWTZ1mAI5l/GdfRA1L
         kP4/t/Fiy9fp6ES9NFjSdX6VsO7Dfzh+vm/79djBuXfuywJXYHobhcBaOyclBUw0dRox
         saAwrwAJq3uaQw6FR9wjlmJMivSwppyHeltWM601I3917G7M2d11c31LtWYek00AbFON
         nD219379DUUv8mxPofnWrcVLib/muiJhd+aQgEU88qbnCTjwuFsJjlKPpIroWRJDTjH5
         miVw==
X-Forwarded-Encrypted: i=1; AJvYcCUiLT5I/vO48fBcsW4jlfTMFIFBMVYfkGq06smekXeDKHhRPNQJAym4iSCo6P51CDTBscXtsM5Ych/9DlpVdpdrZ5NJfdaRznNtcrDm
X-Gm-Message-State: AOJu0YxF5jqCvez9KMaENqW0ohTUjUBFriPMe+FqdMcYfJYB2QIpX24T
	G84eg8z5XsaBKdBbgezpXhd63XuHUX6kFPRK1f2BtNuX7/4y12iwqY77ZBrvG6w=
X-Google-Smtp-Source: AGHT+IGNtUgrSW3Vu2c9dYqqzda9qRrhDO/msz+SpOqPgXFYAs/d2GoswGv9/oF+IHpBOo9V+3ZZSA==
X-Received: by 2002:a05:600c:3583:b0:41a:1d3a:3fc1 with SMTP id 5b1f17b1804b1-421562c8066mr21644745e9.3.1717601424007;
        Wed, 05 Jun 2024 08:30:24 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e7cbsm26222295e9.39.2024.06.05.08.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:30:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: freescale: use defines for interrupts
Date: Wed,  5 Jun 2024 17:30:18 +0200
Message-ID: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hard-coded interrupt parts (GIC, flags) with standard defines
for readability.  No changes in resulting DTBs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  54 +++----
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 108 +++++++-------
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  48 +++----
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 136 +++++++++---------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   4 +-
 9 files changed, 181 insertions(+), 181 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index a0f7bbd691a0..cfb77a76a240 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -74,15 +74,15 @@ coreclk: coreclk {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
-			     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
-			     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
-			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
 	};
 
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
-		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	gic: interrupt-controller@1400000 {
@@ -93,7 +93,7 @@ gic: interrupt-controller@1400000 {
 		      <0x0 0x1402000 0 0x2000>, /* GICC */
 		      <0x0 0x1404000 0 0x2000>, /* GICH */
 		      <0x0 0x1406000 0 0x2000>; /* GICV */
-		interrupts = <1 9 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	reboot {
@@ -159,7 +159,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 		esdhc0: esdhc@1560000 {
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
-			interrupts = <0 62 0x4>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
@@ -178,7 +178,7 @@ scfg: scfg@1570000 {
 		esdhc1: esdhc@1580000 {
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1580000 0x0 0x10000>;
-			interrupts = <0 65 0x4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
@@ -305,7 +305,7 @@ clockgen: clocking@1ee1000 {
 		tmu: tmu@1f00000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
-			interrupts = <0 33 0x4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x60062>;
 			fsl,tmu-calibration =
 					<0x00000000 0x00000025>,
@@ -355,7 +355,7 @@ i2c0: i2c@2180000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
-			interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			scl-gpios = <&gpio0 2 0>;
@@ -367,7 +367,7 @@ i2c1: i2c@2190000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
-			interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			scl-gpios = <&gpio0 13 0>;
@@ -379,7 +379,7 @@ dspi: spi@2100000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
-			interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
@@ -391,7 +391,7 @@ dspi: spi@2100000 {
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
-			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
@@ -400,7 +400,7 @@ duart0: serial@21c0500 {
 		duart1: serial@21c0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
-			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
@@ -409,7 +409,7 @@ duart1: serial@21c0600 {
 		gpio0: gpio@2300000 {
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-			interrupts = <0 66 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -419,7 +419,7 @@ gpio0: gpio@2300000 {
 		gpio1: gpio@2310000 {
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
-			interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -430,7 +430,7 @@ wdog0: watchdog@2ad0000 {
 			compatible = "fsl,ls1012a-wdt",
 				     "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-			interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>;
 			big-endian;
 		};
@@ -439,7 +439,7 @@ sai1: sai@2b50000 {
 			#sound-dai-cells = <0>;
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0x2b50000 0x0 0x10000>;
-			interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -459,7 +459,7 @@ sai2: sai@2b60000 {
 			#sound-dai-cells = <0>;
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0x2b60000 0x0 0x10000>;
-			interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -481,8 +481,8 @@ edma0: dma-controller@2c00000 {
 			reg = <0x0 0x2c00000 0x0 0x10000>,
 			      <0x0 0x2c10000 0x0 0x10000>,
 			      <0x0 0x2c20000 0x0 0x10000>;
-			interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 103 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "edma-tx", "edma-err";
 			dma-channels = <32>;
 			big-endian;
@@ -496,7 +496,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		usb0: usb@2f00000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
-			interrupts = <0 60 0x4>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
@@ -509,7 +509,7 @@ sata: sata@3200000 {
 			reg = <0x0 0x3200000 0x0 0x10000>,
 				<0x0 0x20140520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
-			interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			dma-coherent;
@@ -519,7 +519,7 @@ sata: sata@3200000 {
 		usb1: usb@8600000 {
 			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			reg = <0x0 0x8600000 0x0 0x1000>;
-			interrupts = <0 139 0x4>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			phy_type = "ulpi";
 		};
@@ -528,7 +528,7 @@ msi: msi-controller1@1572000 {
 			compatible = "fsl,ls1012a-msi";
 			reg = <0x0 0x1572000 0x0 0x8>;
 			msi-controller;
-			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pcie1: pcie@3400000 {
@@ -536,8 +536,8 @@ pcie1: pcie@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>, /* controller interrupt */
-				     <0 117 0x4>; /* PME interrupt */
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
 			interrupt-names = "aer", "pme";
 			#address-cells = <3>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 70b8731029c4..18aa02a0ebff 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -859,8 +859,8 @@ QORIQ_CLK_PLL_DIV(16)>,
 		malidp0: display@f080000 {
 			compatible = "arm,mali-dp500";
 			reg = <0x0 0xf080000 0x0 0x10000>;
-			interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "DE", "SE";
 			clocks = <&dpclk>,
 				 <&clockgen QORIQ_CLK_HWACCEL 2>,
@@ -1024,7 +1024,7 @@ dpclk: clock-controller@f1f0000 {
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
-			interrupts = <0 23 0x4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
 			fsl,tmu-calibration =
 					<0x00000000 0x00000024>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 8ee6d8c0ef61..1f5ae061e7e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -268,19 +268,19 @@ sec-crit {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xf08>, /* Physical Secure PPI */
-			     <1 14 0xf08>, /* Physical Non-Secure PPI */
-			     <1 11 0xf08>, /* Virtual PPI */
-			     <1 10 0xf08>; /* Hypervisor PPI */
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		fsl,erratum-a008585;
 	};
 
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
-		interrupts = <0 106 0x4>,
-			     <0 107 0x4>,
-			     <0 95 0x4>,
-			     <0 97 0x4>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>,
 				     <&cpu1>,
 				     <&cpu2>,
@@ -295,7 +295,7 @@ gic: interrupt-controller@1400000 {
 		      <0x0 0x1402000 0 0x2000>, /* GICC */
 		      <0x0 0x1404000 0 0x2000>, /* GICH */
 		      <0x0 0x1406000 0 0x2000>; /* GICV */
-		interrupts = <1 9 0xf08>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	soc: soc {
@@ -352,7 +352,7 @@ crypto: crypto@1700000 {
 			#size-cells = <1>;
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
-			interrupts = <0 75 0x4>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 
 			sec_jr0: jr@10000 {
@@ -360,7 +360,7 @@ sec_jr0: jr@10000 {
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
 				reg = <0x10000 0x10000>;
-				interrupts = <0 71 0x4>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr1: jr@20000 {
@@ -368,7 +368,7 @@ sec_jr1: jr@20000 {
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
 				reg = <0x20000 0x10000>;
-				interrupts = <0 72 0x4>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr2: jr@30000 {
@@ -376,7 +376,7 @@ sec_jr2: jr@30000 {
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
 				reg = <0x30000 0x10000>;
-				interrupts = <0 73 0x4>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr3: jr@40000 {
@@ -384,7 +384,7 @@ sec_jr3: jr@40000 {
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
 				reg = <0x40000 0x10000>;
-				interrupts = <0 74 0x4>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -405,7 +405,7 @@ dcfg: dcfg@1ee0000 {
 		ifc: memory-controller@1530000 {
 			compatible = "fsl,ifc";
 			reg = <0x0 0x1530000 0x0 0x10000>;
-			interrupts = <0 43 0x4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		qspi: spi@1550000 {
@@ -415,7 +415,7 @@ qspi: spi@1550000 {
 			reg = <0x0 0x1550000 0x0 0x10000>,
 				<0x0 0x40000000 0x0 0x4000000>;
 			reg-names = "QuadSPI", "QuadSPI-memory";
-			interrupts = <0 99 0x4>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "qspi_en", "qspi";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>,
@@ -427,7 +427,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 		esdhc: esdhc@1560000 {
 			compatible = "fsl,ls1043a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
-			interrupts = <0 62 0x4>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
@@ -438,14 +438,14 @@ esdhc: esdhc@1560000 {
 		ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
-			interrupts = <0 144 0x4>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			big-endian;
 		};
 
 		tmu: tmu@1f00000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
-			interrupts = <0 33 0x4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 					<0x00000000 0x00000023>,
@@ -518,7 +518,7 @@ dspi0: spi@2100000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
-			interrupts = <0 64 0x4>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
@@ -532,7 +532,7 @@ i2c0: i2c@2180000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
-			interrupts = <0 56 0x4>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
@@ -547,7 +547,7 @@ i2c1: i2c@2190000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
-			interrupts = <0 57 0x4>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
@@ -560,7 +560,7 @@ i2c2: i2c@21a0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21a0000 0x0 0x10000>;
-			interrupts = <0 58 0x4>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
@@ -573,7 +573,7 @@ i2c3: i2c@21b0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21b0000 0x0 0x10000>;
-			interrupts = <0 59 0x4>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
@@ -584,7 +584,7 @@ i2c3: i2c@21b0000 {
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
-			interrupts = <0 54 0x4>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
@@ -592,7 +592,7 @@ duart0: serial@21c0500 {
 		duart1: serial@21c0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
-			interrupts = <0 54 0x4>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
@@ -600,7 +600,7 @@ duart1: serial@21c0600 {
 		duart2: serial@21d0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0500 0x0 0x100>;
-			interrupts = <0 55 0x4>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
@@ -608,7 +608,7 @@ duart2: serial@21d0500 {
 		duart3: serial@21d0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0600 0x0 0x100>;
-			interrupts = <0 55 0x4>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
@@ -616,7 +616,7 @@ duart3: serial@21d0600 {
 		gpio1: gpio@2300000 {
 			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-			interrupts = <0 66 0x4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -626,7 +626,7 @@ gpio1: gpio@2300000 {
 		gpio2: gpio@2310000 {
 			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
-			interrupts = <0 67 0x4>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -636,7 +636,7 @@ gpio2: gpio@2310000 {
 		gpio3: gpio@2320000 {
 			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
-			interrupts = <0 68 0x4>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -646,7 +646,7 @@ gpio3: gpio@2320000 {
 		gpio4: gpio@2330000 {
 			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
-			interrupts = <0 134 0x4>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -721,7 +721,7 @@ data-only@0 {
 		lpuart0: serial@2950000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
-			interrupts = <0 48 0x4>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_SYSCLK 0>;
 			clock-names = "ipg";
 			status = "disabled";
@@ -730,7 +730,7 @@ lpuart0: serial@2950000 {
 		lpuart1: serial@2960000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2960000 0x0 0x1000>;
-			interrupts = <0 49 0x4>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
@@ -740,7 +740,7 @@ lpuart1: serial@2960000 {
 		lpuart2: serial@2970000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2970000 0x0 0x1000>;
-			interrupts = <0 50 0x4>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
@@ -750,7 +750,7 @@ lpuart2: serial@2970000 {
 		lpuart3: serial@2980000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2980000 0x0 0x1000>;
-			interrupts = <0 51 0x4>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
@@ -760,7 +760,7 @@ lpuart3: serial@2980000 {
 		lpuart4: serial@2990000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2990000 0x0 0x1000>;
-			interrupts = <0 52 0x4>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
@@ -770,7 +770,7 @@ lpuart4: serial@2990000 {
 		lpuart5: serial@29a0000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x29a0000 0x0 0x1000>;
-			interrupts = <0 53 0x4>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
@@ -780,7 +780,7 @@ lpuart5: serial@29a0000 {
 		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,ls1043a-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-			interrupts = <0 83 0x4>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "wdog";
@@ -793,8 +793,8 @@ edma0: dma-controller@2c00000 {
 			reg = <0x0 0x2c00000 0x0 0x10000>,
 			      <0x0 0x2c10000 0x0 0x10000>,
 			      <0x0 0x2c20000 0x0 0x10000>;
-			interrupts = <0 103 0x4>,
-				     <0 103 0x4>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "edma-tx", "edma-err";
 			dma-channels = <32>;
 			big-endian;
@@ -815,7 +815,7 @@ aux_bus: aux_bus {
 			usb0: usb@2f00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
-				interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
@@ -827,7 +827,7 @@ usb0: usb@2f00000 {
 			usb1: usb@3000000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
-				interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
@@ -839,7 +839,7 @@ usb1: usb@3000000 {
 			usb2: usb@3100000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
-				interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
@@ -853,7 +853,7 @@ sata: sata@3200000 {
 				reg = <0x0 0x3200000 0x0 0x10000>,
 					<0x0 0x20140520 0x0 0x4>;
 				reg-names = "ahci", "sata-ecc";
-				interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 						    QORIQ_CLK_PLL_DIV(1)>;
 				dma-coherent;
@@ -864,21 +864,21 @@ msi1: msi-controller1@1571000 {
 			compatible = "fsl,ls1043a-msi";
 			reg = <0x0 0x1571000 0x0 0x8>;
 			msi-controller;
-			interrupts = <0 116 0x4>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		msi2: msi-controller2@1572000 {
 			compatible = "fsl,ls1043a-msi";
 			reg = <0x0 0x1572000 0x0 0x8>;
 			msi-controller;
-			interrupts = <0 126 0x4>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		msi3: msi-controller3@1573000 {
 			compatible = "fsl,ls1043a-msi";
 			reg = <0x0 0x1573000 0x0 0x8>;
 			msi-controller;
-			interrupts = <0 160 0x4>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pcie1: pcie@3400000 {
@@ -886,8 +886,8 @@ pcie1: pcie@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 118 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -913,8 +913,8 @@ pcie2: pcie@3500000 {
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
 			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 127 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 128 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -940,8 +940,8 @@ pcie3: pcie@3600000 {
 			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
 			      <0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 161 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 162 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 754a64be739c..e5fcfc690ffc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -441,7 +441,7 @@ clockgen: clocking@1ee1000 {
 		tmu: tmu@1f00000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
-			interrupts = <0 33 0x4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 604bf88d70b3..91589b907ec8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -118,7 +118,7 @@ gic: interrupt-controller@6000000 {
 		      <0x0 0x0c0c0000 0 0x2000>, /* GICC */
 		      <0x0 0x0c0d0000 0 0x1000>, /* GICH */
 		      <0x0 0x0c0e0000 0 0x20000>; /* GICV */
-		interrupts = <1 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -183,10 +183,10 @@ soc-crit {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
-			     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
-			     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
-			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
 	};
 
 	pmu {
@@ -280,7 +280,7 @@ sfp: efuse@1e80000 {
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
-			interrupts = <0 23 0x4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
@@ -347,7 +347,7 @@ duart0: serial@21c0500 {
 			reg = <0x0 0x21c0500 0x0 0x100>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
-			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -356,14 +356,14 @@ duart1: serial@21c0600 {
 			reg = <0x0 0x21c0600 0x0 0x100>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
-			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -374,7 +374,7 @@ gpio0: gpio@2300000 {
 		gpio1: gpio@2310000 {
 			compatible = "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
-			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -385,7 +385,7 @@ gpio1: gpio@2310000 {
 		gpio2: gpio@2320000 {
 			compatible = "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
-			interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -396,7 +396,7 @@ gpio2: gpio@2320000 {
 		gpio3: gpio@2330000 {
 			compatible = "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
-			interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -407,7 +407,7 @@ gpio3: gpio@2330000 {
 		ifc: memory-controller@2240000 {
 			compatible = "fsl,ifc";
 			reg = <0x0 0x2240000 0x0 0x20000>;
-			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
 			#address-cells = <2>;
 			#size-cells = <1>;
@@ -419,7 +419,7 @@ i2c0: i2c@2000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
-			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
@@ -430,7 +430,7 @@ i2c1: i2c@2010000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
-			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
@@ -441,7 +441,7 @@ i2c2: i2c@2020000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
-			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
@@ -452,7 +452,7 @@ i2c3: i2c@2030000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
-			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
@@ -477,7 +477,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		esdhc: esdhc@2140000 {
 			compatible = "fsl,ls1088a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
-			interrupts = <0 28 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;
 			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
@@ -490,7 +490,7 @@ esdhc: esdhc@2140000 {
 		usb0: usb@3100000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
@@ -501,7 +501,7 @@ usb0: usb@3100000 {
 		usb1: usb@3110000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
-			interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
@@ -514,7 +514,7 @@ sata: sata@3200000 {
 			reg = <0x0 0x3200000 0x0 0x10000>,
 				<0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
-			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
@@ -565,7 +565,7 @@ pcie1: pcie@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
 			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -604,7 +604,7 @@ pcie2: pcie@3500000 {
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
 			      <0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
 			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -642,7 +642,7 @@ pcie3: pcie@3600000 {
 			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
 			      <0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
 			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 8352197cea6f..e9bc1f4fa13c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -15,7 +15,7 @@
 / {
 	pmu {
 		compatible = "arm,cortex-a57-pmu";
-		interrupts = <1 7 0x8>; /* PMU PPI, Level low type */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index 245bbd615c81..60c422560e33 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -15,7 +15,7 @@
 / {
 	pmu {
 		compatible = "arm,cortex-a72-pmu";
-		interrupts = <1 7 0x8>; /* PMU PPI, Level low type */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index ccba0a135b24..cc305e629bdc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -58,7 +58,7 @@ gic: interrupt-controller@6000000 {
 		#size-cells = <2>;
 		ranges;
 		interrupt-controller;
-		interrupts = <1 9 0x4>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
@@ -314,7 +314,7 @@ extirq: interrupt-controller@14 {
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
-			interrupts = <0 23 0x4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
 			fsl,tmu-calibration =
 					<0x00000000 0x00000026>,
@@ -362,7 +362,7 @@ serial0: serial@21c0500 {
 			reg = <0x0 0x21c0500 0x0 0x100>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
-			interrupts = <0 32 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial1: serial@21c0600 {
@@ -370,7 +370,7 @@ serial1: serial@21c0600 {
 			reg = <0x0 0x21c0600 0x0 0x100>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
-			interrupts = <0 32 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial2: serial@21d0500 {
@@ -378,7 +378,7 @@ serial2: serial@21d0500 {
 			reg = <0x0 0x21d0500 0x0 0x100>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
-			interrupts = <0 33 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial3: serial@21d0600 {
@@ -386,7 +386,7 @@ serial3: serial@21d0600 {
 			reg = <0x0 0x21d0600 0x0 0x100>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
-			interrupts = <0 33 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		cluster1_core0_watchdog: wdt@c000000 {
@@ -883,48 +883,48 @@ smmu: iommu@5000000 {
 			#iommu-cells = <1>;
 			stream-match-mask = <0x7C00>;
 			dma-coherent;
-			interrupts = <0 13 4>, /* global secure fault */
-				     <0 14 4>, /* combined secure interrupt */
-				     <0 15 4>, /* global non-secure fault */
-				     <0 16 4>, /* combined non-secure interrupt */
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* global secure fault */
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* combined secure interrupt */
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>, /* global non-secure fault */
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>, /* combined non-secure interrupt */
 				/* performance counter interrupts 0-7 */
-				     <0 211 4>, <0 212 4>,
-				     <0 213 4>, <0 214 4>,
-				     <0 215 4>, <0 216 4>,
-				     <0 217 4>, <0 218 4>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
 				/* per context interrupt, 64 interrupts */
-				     <0 146 4>, <0 147 4>,
-				     <0 148 4>, <0 149 4>,
-				     <0 150 4>, <0 151 4>,
-				     <0 152 4>, <0 153 4>,
-				     <0 154 4>, <0 155 4>,
-				     <0 156 4>, <0 157 4>,
-				     <0 158 4>, <0 159 4>,
-				     <0 160 4>, <0 161 4>,
-				     <0 162 4>, <0 163 4>,
-				     <0 164 4>, <0 165 4>,
-				     <0 166 4>, <0 167 4>,
-				     <0 168 4>, <0 169 4>,
-				     <0 170 4>, <0 171 4>,
-				     <0 172 4>, <0 173 4>,
-				     <0 174 4>, <0 175 4>,
-				     <0 176 4>, <0 177 4>,
-				     <0 178 4>, <0 179 4>,
-				     <0 180 4>, <0 181 4>,
-				     <0 182 4>, <0 183 4>,
-				     <0 184 4>, <0 185 4>,
-				     <0 186 4>, <0 187 4>,
-				     <0 188 4>, <0 189 4>,
-				     <0 190 4>, <0 191 4>,
-				     <0 192 4>, <0 193 4>,
-				     <0 194 4>, <0 195 4>,
-				     <0 196 4>, <0 197 4>,
-				     <0 198 4>, <0 199 4>,
-				     <0 200 4>, <0 201 4>,
-				     <0 202 4>, <0 203 4>,
-				     <0 204 4>, <0 205 4>,
-				     <0 206 4>, <0 207 4>,
-				     <0 208 4>, <0 209 4>;
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		dspi: spi@2100000 {
@@ -933,7 +933,7 @@ dspi: spi@2100000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
-			interrupts = <0 26 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "dspi";
@@ -944,7 +944,7 @@ esdhc: esdhc@2140000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
-			interrupts = <0 28 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			voltage-ranges = <1800 1800 3300 3300>;
@@ -956,7 +956,7 @@ esdhc: esdhc@2140000 {
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-			interrupts = <0 36 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			little-endian;
 			#gpio-cells = <2>;
@@ -967,7 +967,7 @@ gpio0: gpio@2300000 {
 		gpio1: gpio@2310000 {
 			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
-			interrupts = <0 36 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			little-endian;
 			#gpio-cells = <2>;
@@ -978,7 +978,7 @@ gpio1: gpio@2310000 {
 		gpio2: gpio@2320000 {
 			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
-			interrupts = <0 37 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			little-endian;
 			#gpio-cells = <2>;
@@ -989,7 +989,7 @@ gpio2: gpio@2320000 {
 		gpio3: gpio@2330000 {
 			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
-			interrupts = <0 37 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			little-endian;
 			#gpio-cells = <2>;
@@ -1003,7 +1003,7 @@ i2c0: i2c@2000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
-			interrupts = <0 34 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
@@ -1015,7 +1015,7 @@ i2c1: i2c@2010000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
-			interrupts = <0 34 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
@@ -1027,7 +1027,7 @@ i2c2: i2c@2020000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
-			interrupts = <0 35 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
@@ -1039,7 +1039,7 @@ i2c3: i2c@2030000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
-			interrupts = <0 35 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
@@ -1048,7 +1048,7 @@ i2c3: i2c@2030000 {
 		ifc: memory-controller@2240000 {
 			compatible = "fsl,ifc";
 			reg = <0x0 0x2240000 0x0 0x20000>;
-			interrupts = <0 21 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
 			#address-cells = <2>;
 			#size-cells = <1>;
@@ -1077,7 +1077,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		pcie1: pcie@3400000 {
 			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
-			interrupts = <0 108 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -1099,7 +1099,7 @@ pcie1: pcie@3400000 {
 		pcie2: pcie@3500000 {
 			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
-			interrupts = <0 113 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -1121,7 +1121,7 @@ pcie2: pcie@3500000 {
 		pcie3: pcie@3600000 {
 			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -1143,7 +1143,7 @@ pcie3: pcie@3600000 {
 		pcie4: pcie@3700000 {
 			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
-			interrupts = <0 123 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -1166,7 +1166,7 @@ sata0: sata@3200000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>;
-			interrupts = <0 133 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
@@ -1176,7 +1176,7 @@ sata1: sata@3210000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-ahci";
 			reg = <0x0 0x3210000 0x0 0x10000>;
-			interrupts = <0 136 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
@@ -1192,7 +1192,7 @@ bus: bus {
 			usb0: usb@3100000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
-				interrupts = <0 80 0x4>; /* Level high type */
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
@@ -1203,7 +1203,7 @@ usb0: usb@3100000 {
 			usb1: usb@3110000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x3110000 0x0 0x10000>;
-				interrupts = <0 81 0x4>; /* Level high type */
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
@@ -1215,7 +1215,7 @@ usb1: usb@3110000 {
 		ccn@4000000 {
 			compatible = "arm,ccn-504";
 			reg = <0x0 0x04000000 0x0 0x01000000>;
-			interrupts = <0 12 4>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		rcpm: power-controller@1e34040 {
@@ -1236,14 +1236,14 @@ ftm_alarm0: timer@2800000 {
 	ddr1: memory-controller@1080000 {
 		compatible = "fsl,qoriq-memory-controller";
 		reg = <0x0 0x1080000 0x0 0x1000>;
-		interrupts = <0 17 0x4>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		little-endian;
 	};
 
 	ddr2: memory-controller@1090000 {
 		compatible = "fsl,qoriq-memory-controller";
 		reg = <0x0 0x1090000 0x0 0x1000>;
-		interrupts = <0 18 0x4>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 		little-endian;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 96055593204a..eaa7d8c70964 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -928,7 +928,7 @@ dspi2: spi@2120000 {
 		esdhc0: esdhc@2140000 {
 			compatible = "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
-			interrupts = <0 28 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			dma-coherent;
@@ -942,7 +942,7 @@ esdhc0: esdhc@2140000 {
 		esdhc1: esdhc@2150000 {
 			compatible = "fsl,esdhc";
 			reg = <0x0 0x2150000 0x0 0x10000>;
-			interrupts = <0 63 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			dma-coherent;
-- 
2.43.0


