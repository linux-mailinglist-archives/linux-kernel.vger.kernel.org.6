Return-Path: <linux-kernel+bounces-403464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514129C3615
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B61B220B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E215B12A;
	Mon, 11 Nov 2024 01:31:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7742159209;
	Mon, 11 Nov 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288669; cv=none; b=QXlSdszFhxfH+9WCE8AxCCMLfEfA4Y46PT8IPxMoYS6bf/Zpc+5dNfoEbDeXeFn43v9q5mseWEERzQ3wzcJ+9NHSt7zTDK/Z55WlQ7ukMBwTOhRraDq9JgtzOaV7VZSjezk0AgyTIU6HCnDIPQPqQ6zAFe0pG7E6qHZp2qmYR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288669; c=relaxed/simple;
	bh=AFv/21u/edYdwtPEhjbjrB04V5L7d9fKMKeP9UI2V2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfY/sLCpawHrHrfXhwzgkX+J8xqV5yIr7PfUcjjuHE14WsQk3UwvD0KA2lNXjbVUiUNmkPWPuuezP3W6ofmgMkARssxHsbFnd088hLOsN+wT0II6lAjkacGzAVXC7awz82H3WwelZkfRhDgL3kOFcjCVkWXIRHc15ZQ6jz12vQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4705A13D5;
	Sun, 10 Nov 2024 17:31:37 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8D03F66E;
	Sun, 10 Nov 2024 17:31:05 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] arm64: dts: allwinner: Add Allwinner A523 .dtsi file
Date: Mon, 11 Nov 2024 01:30:30 +0000
Message-ID: <20241111013033.22793-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111013033.22793-1-andre.przywara@arm.com>
References: <20241111013033.22793-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523, and its siblings A527 and T527, which share the same
die, are a new family of SoCs introduced in 2023. They features eight
Arm Cortex-A55 cores, and, among the other usual peripherals, a PCIe and
USB 3.0 controller.

Add the basic SoC devicetree .dtsi for the chip, describing the
fundamental peripherals: the cores, GIC, timer, RTC, CCU and pinctrl.
Also some other peripherals are fully compatible with previous IP, so
add the USB and MMC nodes as well.
The other peripherals will be added in the future, once we understand
their compatibility and DT requirements.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 386 ++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
new file mode 100644
index 0000000000000..96072cea10da4
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+// Copyright (C) 2023-2024 Arm Ltd.
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun55i-a523-ccu.h>
+#include <dt-bindings/clock/sun55i-a523-r-ccu.h>
+#include <dt-bindings/reset/sun55i-a523-ccu.h>
+#include <dt-bindings/reset/sun55i-a523-r-ccu.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x000>;
+		};
+	};
+
+	ext_osc32k: ext-osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext_osc32k";
+	};
+
+	osc24M: osc24M-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+	};
+
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		arm,no-tick-in-suspend;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x40000000>;
+
+		pio: pinctrl@2000000 {
+			compatible = "allwinner,sun55i-a523-pinctrl";
+			reg = <0x2000000 0x800>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			mmc0_pins: mmc0-pins {
+				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
+				allwinner,pinmux = <2>;
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PG0" ,"PG1", "PG2", "PG3", "PG4", "PG5";
+				allwinner,pinmux = <2>;
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC1" ,"PC5", "PC6", "PC8", "PC9",
+				       "PC10", "PC11", "PC13", "PC14", "PC15",
+				       "PC16";
+				allwinner,pinmux = <3>;
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			uart0_pb_pins: uart0-pb-pins {
+				pins = "PB9", "PB10";
+				allwinner,pinmux = <2>;
+				function = "uart0";
+			};
+		};
+
+		ccu: clock@2001000 {
+			compatible = "allwinner,sun55i-a523-ccu";
+			reg = <0x02001000 0x1000>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun55i-a523-mmc",
+				     "allwinner,sun20i-d1-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+			status = "disabled";
+
+			max-frequency = <150000000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			cap-sdio-irq;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun55i-a523-mmc",
+				     "allwinner,sun20i-d1-mmc";
+			reg = <0x04022000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc2_pins>;
+			status = "disabled";
+
+			max-frequency = <150000000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			cap-sdio-irq;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		wdt: watchdog@2050000 {
+			compatible = "allwinner,sun55i-a523-wdt";
+			reg = <0x2050000 0x20>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			status = "okay";
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500000 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@2502000 {
+			compatible = "allwinner,sun55i-a523-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502000 0x400>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gic: interrupt-controller@3400000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <1>;
+			#interrupt-cells = <3>;
+			#size-cells = <1>;
+			ranges;
+			interrupt-controller;
+			reg = <0x3400000 0x10000>,
+			      <0x3460000 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			dma-noncoherent;
+
+			its: msi-controller@3440000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x3440000 0x20000>;
+				msi-controller;
+				#msi-cells = <1>;
+				dma-noncoherent;
+			};
+		};
+
+		usb_otg: usb@4100000 {
+			compatible = "allwinner,sun55i-a523-musb",
+				     "allwinner,sun8i-a33-musb";
+			reg = <0x4100000 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			extcon = <&usbphy 0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usbphy: phy@4100400 {
+			compatible = "allwinner,sun55i-a523-usb-phy",
+				     "allwinner,sun20i-d1-usb-phy";
+			reg = <0x4100400 0x100>,
+			      <0x4101800 0x100>,
+			      <0x4200800 0x100>;
+			reg-names = "phy_ctrl",
+				    "pmu0",
+				    "pmu1";
+			clocks = <&osc24M>,
+				 <&osc24M>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb@4101000 {
+			compatible = "allwinner,sun55i-a523-ehci",
+				     "generic-ehci";
+			reg = <0x4101000 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@4101400 {
+			compatible = "allwinner,sun55i-a523-ohci",
+				     "generic-ohci";
+			reg = <0x4101400 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb@4200000 {
+			compatible = "allwinner,sun55i-a523-ehci",
+				     "generic-ehci";
+			reg = <0x4200000 0x100>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_BUS_EHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>,
+				 <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb@4200400 {
+			compatible = "allwinner,sun55i-a523-ohci",
+				     "generic-ohci";
+			reg = <0x4200400 0x100>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		r_ccu: clock-controller@7010000 {
+			compatible = "allwinner,sun55i-a523-r-ccu";
+			reg = <0x7010000 0x250>;
+			clocks = <&osc24M>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>,
+				 <&ccu CLK_PLL_PERIPH0_200M>,
+				 <&ccu CLK_PLL_AUDIO0_4X>;
+			clock-names = "hosc",
+				      "losc",
+				      "iosc",
+				      "pll-periph",
+				      "pll-audio";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		nmi_intc: interrupt-controller@7010320 {
+			compatible = "allwinner,sun55i-a523-nmi",
+				     "allwinner,sun9i-a80-nmi";
+			reg = <0x07010320 0xc>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		r_pio: pinctrl@7022000 {
+			compatible = "allwinner,sun55i-a523-r-pinctrl";
+			reg = <0x7022000 0x800>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB0>,
+				 <&osc24M>,
+				 <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			r_i2c_pins: r-i2c-pins {
+				pins = "PL0" ,"PL1";
+				allwinner,pinmux = <2>;
+				function = "r_i2c0";
+			};
+		};
+
+		r_i2c0: i2c@7081400 {
+			compatible = "allwinner,sun55i-a523-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x07081400 0x400>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_BUS_R_I2C0>;
+			resets = <&r_ccu RST_BUS_R_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		rtc: rtc@7090000 {
+			compatible = "allwinner,sun55i-a523-rtc",
+				     "allwinner,sun50i-r329-rtc";
+			reg = <0x7090000 0x400>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_BUS_R_RTC>,
+				 <&osc24M>,
+				 <&r_ccu CLK_R_AHB>;
+			clock-names = "bus", "hosc", "ahb";
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
2.46.2


