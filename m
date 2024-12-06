Return-Path: <linux-kernel+bounces-435092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423579E6F84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD916721D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED4207DFB;
	Fri,  6 Dec 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlt/H+R"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC691201016;
	Fri,  6 Dec 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493082; cv=none; b=lWsp1FhdXyJ3Y6Z+h5K6I1z7AJdXV5rCrt5MjETTiGysimUtePcHIwDMyzCU8T2/lXU3/t0Fqb4cyak5jD+uGzZ1O1gLZxRj1WucWz4BN8KovVU1NBHZmauN9k53xxoVnIOrrr+JquSPVu35GY5TvHYrF0suVU3QbN1Bmoc8Pfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493082; c=relaxed/simple;
	bh=8YS6+le+Ik1k2lhyF0x6d9YO1fXK4PmGmFdsI3oVi5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mn5pqlHgxpqcHBYmWKRRSTeoH+G1vfmPi8ptmQ3Qsj/lXwm2G4ae6iVNPTY5Sd0zlwle0G8ejvpF4hmOdG3RNm5tZao6f98CbvHep7rbL0cy8Kpk4CbarfDjqpLIVJbHRirjodolFxtzhmtp09ElrTzzy6eNpWLT2Bg35mr7FSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIlt/H+R; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so1760594a12.3;
        Fri, 06 Dec 2024 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733493079; x=1734097879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stFRl69Yy4ryPFAdd+IunUx2a5npo1o5aGWsoNJUZ7Q=;
        b=SIlt/H+RNodYP8ic1OuJxH3k8LCGWSBuwOm/GQhU3F5peVyPaFO9NIRDW8tXPHNvG+
         98yM1zV0NSsuskIKVBu22iD3OLCeHo6INEcG1unKhlivTyRM03y1fNFnWSWg08/DL+TU
         YyZSXQim8YxCSrxbVtCBYdkzuEQsstIiMarLupb3TET7BEPA5GOblfxNK0EQtniehrlY
         fwL8gpxOO6waOI0yAPgqHZa32Yq2izmvldk+hdriC8UhM49G9slM+8YyvJ0Ppw0D/k6C
         UdXwc0bEg9+O5MlNyXwUVUKm878MnfC4RvKdurziUzSoXD7zqRLQY9q/rHJDEb/bKcVy
         kSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493079; x=1734097879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stFRl69Yy4ryPFAdd+IunUx2a5npo1o5aGWsoNJUZ7Q=;
        b=HO6oeUkoyR9Spm4SyI3PXfw5CzsfFb8n0ZzAb3m3hhV2B5I8TydhMNIFLXiEDwKp9b
         0lmif65+R5V1ALqWXXU2cxUgB/NHhQRqjcUQ/o3yomG1MxkhLCsi4Udbher+jugLYmYn
         LsBR8DY8nsejLmTIB7zwchNytmIcxXzLcbsMiKdDH/w+ql3pRwv63NAHTouaivv4xacX
         2L8wS5djdZmZOCc3Cj9mGi3yiJ7SX/xhQbkX/lgivGQjTIEwDQF0qsQByvyDLqVOaWdk
         yPwi25mqAtL+0/AiyXyljuzlB2W2qmBzNQHQrOUvWc1jRftnuK++ZcZyzMFFUGXI2p3/
         xmgA==
X-Forwarded-Encrypted: i=1; AJvYcCVhrSptxZVePLLg1sgXe+AsdSpSdYAHaNCF4TTh30u6636dUD4tmNGdFz8Sx3kad4stJFJRNa2VEiJG@vger.kernel.org, AJvYcCW7n+s2OKzgoV0idrSsKH3lJfVsP/WuvnrVEXR1SwjTa3AHxQ5Cv4i1XVL2tYKHw9dV8kRvvvjFFnLOzcQk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zNfYi26p5gxXMan+dDmM6YwQZlg8IwE187GMbb03iUP0yh83
	o0kToub8dFLrRh21sT7UjqPEqf4b0GMVh14xUQ+O3w17edR+kDvT
X-Gm-Gg: ASbGncvaPEs1iLlviMGyBaJ+UVL8MdbrI44Uct2O82b+i3fo5L4RfRFrMGBs7i8lc3X
	OI4uw2gu6t8cq3tTiGTkm4RhBmqytFTsCxlLU1jpu0Wr7aq+tIkMQ/cNJC3pu2DOZePJCihXXgn
	F/WuD2Ur/rgAhJOuCcIjpPPYdpmf/L3ML1gyIezrU8gpBMf9cO1k2AN5XKsrUwp5EukCd3gLRkC
	ClpJq4FgxyFNLRk47kC7Q2soBcIOGCFHuU/clIKfVuvkl73Bf1Ii+3V5jjwwSrVOw==
X-Google-Smtp-Source: AGHT+IFp84/LvRLoYXG34ubT33fATowTlF56K2m/y6+FW07NezqF+NAbf7h9jEawMLoJmfmx+qHSuA==
X-Received: by 2002:a05:6a20:a104:b0:1e0:dc7b:4ef6 with SMTP id adf61e73a8af0-1e1870c8387mr5097610637.21.1733493078928;
        Fri, 06 Dec 2024 05:51:18 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7fd3274ca0esm101286a12.20.2024.12.06.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:51:18 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH] arm64: dts: apple: Split s8000/s8003 SoC DTS files
Date: Fri,  6 Dec 2024 21:49:18 +0800
Message-ID: <20241206135051.56049-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite what the code comments said, the DTS files were not split properly.
Since these two SoCs are now known to have minor differences like in
latencies for cpufreq state transistions, split the DTS files now.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---

Hi,

I am preparing multiple series for cpufreq and backlight, both of which
modifies the Apple A9 DTS files. I am sending this first to make it
easier to handle conflicts.

This patch depends on PMGR nodes for Apple A7-A11 SoCs[1] since it
also renames the pmgr bindings files.

[1]: https://lore.kernel.org/asahi/20241203050640.109378-1-towinchenmi@gmail.com/T

Nick Chan

 .../{s8000-pmgr.dtsi => s800-0-3-pmgr.dtsi}   |   0
 arch/arm64/boot/dts/apple/s800-0-3.dtsi       | 162 ++++++++++++++++++
 arch/arm64/boot/dts/apple/s8000.dtsi          | 155 +----------------
 arch/arm64/boot/dts/apple/s8003.dtsi          |  10 +-
 4 files changed, 168 insertions(+), 159 deletions(-)
 rename arch/arm64/boot/dts/apple/{s8000-pmgr.dtsi => s800-0-3-pmgr.dtsi} (100%)
 create mode 100644 arch/arm64/boot/dts/apple/s800-0-3.dtsi

diff --git a/arch/arm64/boot/dts/apple/s8000-pmgr.dtsi b/arch/arm64/boot/dts/apple/s800-0-3-pmgr.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
rename to arch/arm64/boot/dts/apple/s800-0-3-pmgr.dtsi
diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
new file mode 100644
index 000000000000..1e0b8f631ac0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple S8000/S8003 "A9" SoC
+ *
+ * This file contains parts common to both variants of A9
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+/ {
+	interrupt-parent = <&aic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "apple,twister";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,twister";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		nonposted-mmio;
+		ranges;
+
+		serial0: serial@20a0c0000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x0a0c0000 0x0 0x4000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 192 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
+			status = "disabled";
+		};
+
+		pmgr: power-management@20e000000 {
+			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0xe000000 0 0x8c000>;
+		};
+
+		aic: interrupt-controller@20e100000 {
+			compatible = "apple,s8000-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			power-domains = <&ps_aic>;
+		};
+
+		pinctrl_ap: pinctrl@20f100000 {
+			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x0f100000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 208>;
+			apple,npins = <208>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 48 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@2100f0000 {
+			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x100f0000 0x0 0x100000>;
+			power-domains = <&ps_aop_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 42>;
+			apple,npins = <42>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 119 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pmgr_mini: power-management@210200000 {
+			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x10200000 0 0x84000>;
+		};
+
+		wdt: watchdog@2102b0000 {
+			compatible = "apple,s8000-wdt", "apple,wdt";
+			reg = <0x2 0x102b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A9 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+#include "s800-0-3-pmgr.dtsi"
+
+/*
+ * The A9 was made by two separate fabs on two different process
+ * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
+ * the S8003 (APL1022) on 16nm. There are some minor differences
+ * such as timing in cpufreq state transistions.
+ */
diff --git a/arch/arm64/boot/dts/apple/s8000.dtsi b/arch/arm64/boot/dts/apple/s8000.dtsi
index 84d6b4939ac4..c7e39abda7e1 100644
--- a/arch/arm64/boot/dts/apple/s8000.dtsi
+++ b/arch/arm64/boot/dts/apple/s8000.dtsi
@@ -7,160 +7,11 @@
  * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
  */
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/apple-aic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/apple.h>
-
-/ {
-	interrupt-parent = <&aic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	clkref: clock-ref {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "clkref";
-	};
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			compatible = "apple,twister";
-			reg = <0x0 0x0>;
-			cpu-release-addr = <0 0>; /* To be filled in by loader */
-			enable-method = "spin-table";
-			device_type = "cpu";
-		};
-
-		cpu1: cpu@1 {
-			compatible = "apple,twister";
-			reg = <0x0 0x1>;
-			cpu-release-addr = <0 0>; /* To be filled in by loader */
-			enable-method = "spin-table";
-			device_type = "cpu";
-		};
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		nonposted-mmio;
-		ranges;
-
-		serial0: serial@20a0c0000 {
-			compatible = "apple,s5l-uart";
-			reg = <0x2 0x0a0c0000 0x0 0x4000>;
-			reg-io-width = <4>;
-			interrupt-parent = <&aic>;
-			interrupts = <AIC_IRQ 192 IRQ_TYPE_LEVEL_HIGH>;
-			/* Use the bootloader-enabled clocks for now. */
-			clocks = <&clkref>, <&clkref>;
-			clock-names = "uart", "clk_uart_baud0";
-			power-domains = <&ps_uart0>;
-			status = "disabled";
-		};
-
-		pmgr: power-management@20e000000 {
-			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			reg = <0x2 0xe000000 0 0x8c000>;
-		};
-
-		aic: interrupt-controller@20e100000 {
-			compatible = "apple,s8000-aic", "apple,aic";
-			reg = <0x2 0x0e100000 0x0 0x100000>;
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			power-domains = <&ps_aic>;
-		};
-
-		pinctrl_ap: pinctrl@20f100000 {
-			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
-			reg = <0x2 0x0f100000 0x0 0x100000>;
-			power-domains = <&ps_gpio>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_ap 0 0 208>;
-			apple,npins = <208>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupt-parent = <&aic>;
-			interrupts = <AIC_IRQ 42 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 43 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 44 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 45 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 46 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 47 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 48 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		pinctrl_aop: pinctrl@2100f0000 {
-			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
-			reg = <0x2 0x100f0000 0x0 0x100000>;
-			power-domains = <&ps_aop_gpio>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_aop 0 0 42>;
-			apple,npins = <42>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupt-parent = <&aic>;
-			interrupts = <AIC_IRQ 113 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 114 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 115 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 116 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 117 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 118 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 119 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		pmgr_mini: power-management@210200000 {
-			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			reg = <0x2 0x10200000 0 0x84000>;
-		};
-
-		wdt: watchdog@2102b0000 {
-			compatible = "apple,s8000-wdt", "apple,wdt";
-			reg = <0x2 0x102b0000 0x0 0x4000>;
-			clocks = <&clkref>;
-			interrupt-parent = <&aic>;
-			interrupts = <AIC_IRQ 4 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupt-parent = <&aic>;
-		interrupt-names = "phys", "virt";
-		/* Note that A9 doesn't actually have a hypervisor (EL2 is not implemented). */
-		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
-			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
-
-#include "s8000-pmgr.dtsi"
+#include "s800-0-3.dtsi"
 
 /*
  * The A9 was made by two separate fabs on two different process
  * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
- * the S8003 (APL1022) on 16nm. While they are seemingly the same,
- * they do have distinct part numbers and devices using them have
- * distinct model names. There are currently no known differences
- * between these as far as Linux is concerned, but let's keep things
- * structured properly to make it easier to alter the behaviour of
- * one of the chips if need be.
+ * the S8003 (APL1022) on 16nm. There are some minor differences
+ * such as timing in cpufreq state transistions.
  */
diff --git a/arch/arm64/boot/dts/apple/s8003.dtsi b/arch/arm64/boot/dts/apple/s8003.dtsi
index 7e4ad4f7e499..807e3452f8a7 100644
--- a/arch/arm64/boot/dts/apple/s8003.dtsi
+++ b/arch/arm64/boot/dts/apple/s8003.dtsi
@@ -7,15 +7,11 @@
  * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
  */
 
-#include "s8000.dtsi"
+#include "s800-0-3.dtsi"
 
 /*
  * The A9 was made by two separate fabs on two different process
  * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
- * the S8003 (APL1022) on 16nm. While they are seemingly the same,
- * they do have distinct part numbers and devices using them have
- * distinct model names. There are currently no known differences
- * between these as far as Linux is concerned, but let's keep things
- * structured properly to make it easier to alter the behaviour of
- * one of the chips if need be.
+ * the S8003 (APL1022) on 16nm. There are some minor differences
+ * such as timing in cpufreq state transistions.
  */

base-commit: d47006c7111b57dd2377d072681935aebb9dde25
-- 
2.47.1


