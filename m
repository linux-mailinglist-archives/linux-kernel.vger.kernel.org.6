Return-Path: <linux-kernel+bounces-545709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A08A4F07B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402183AD6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872B280CD6;
	Tue,  4 Mar 2025 22:26:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF828041B;
	Tue,  4 Mar 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127166; cv=none; b=uLvdfsjCB1YC90YKHIXcS5SISAplfyhVH6oZlgkfOtVjuTn8m9AD2bBAnSaOBKdbvT9idvoCf306v+IVhw2p01wQgeVkBwithlUCr0m8cU5Kij3qAi1WviH9/2f/FkXEXI5tj3fmvLcOa/W1X5RUe9RbAdq9KV6XFbP86Rc+UKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127166; c=relaxed/simple;
	bh=oT6D0HC/S82asu6FWxbre705yR398JQqAKAmhjTGrGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU0t2g1KD2A4jLQG8nVfP8Hkv4FqSK5+Ug3nFOLzmNnq4QAKWOv091T5xZge7LIN0XadpxDfhk7gSYu5clJY+zWDr+hQfie68VGUb968hmjgaDw9NnM+LmlOs0C2g7JpiKambSyiJkJP9dSDJnWZnfNGRTESspkgAut9a2hN7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54FF8497;
	Tue,  4 Mar 2025 14:26:16 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF9D3F5A1;
	Tue,  4 Mar 2025 14:26:01 -0800 (PST)
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
Subject: [PATCH v2 13/15] arm64: dts: allwinner: a523: add Radxa A5E support
Date: Tue,  4 Mar 2025 22:23:07 +0000
Message-ID: <20250304222309.29385-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304222309.29385-1-andre.przywara@arm.com>
References: <20250304222309.29385-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa A5E is a development board using the Allwinner A527 SoC, which
is using the same die as the A523 SoC, just exposing the pins of more
peripherals (like HDMI or the 2nd MAC). The board features:

  - Allwinner A527/T527 SoC: 8 ARM Cortex-A55 cores, Mali-G57 MC1 GPU
  - 1GiB/2GiB/4GiB LPDDR4 DRAM
  - AXP717 + AXP323 PMICs
  - Raspberry-Pi-2 compatible 40pin GPIO header
  - 1 USB 2.0 type C port (OTG), also power supply
  - 1 USB 3.0 type A host port (multiplexed with M.2 slot)
  - 1 M.2 M-key 2230 slot, with 1 PCIe2.1 lane connected (multiplexed
    with USB 3.0 port)
  - MicroSD slot
  - optional eMMC, 8, 16 or 32GB available
  - optional on-board 16MiB bootable SPI NOR flash
  - two 1Gbps Ethernet ports (via MAXIO MAE0621A PHYs)
  - PoE header for optional supply circuit on one Ethernet port
  - WiFi 802.11 a/b/g/n/ac/ax (LB-Link BL-M8800DS2 module using AIC8800)
  - HDMI port
  - camera and LCD connectors
  - power supply via USB-C connector (but no PD) or GPIO header pins

This .dts describes the devices as far as we support them at the moment.
The PMIC rails have been assigned as per the schematics.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun55i-a527-radxa-a5e.dts   | 299 ++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 983be49ea6ef8..9d5e14695af0b 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -52,5 +52,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-2024.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-h.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-sp.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun55i-a527-radxa-a5e.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun55i-h728-x96qpro+.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun55i-t527-avaota-a1.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
new file mode 100644
index 0000000000000..912e1bda974ce
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+// Copyright (C) 2025 Arm Ltd.
+
+/dts-v1/;
+
+#include "sun55i-a523.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Radxa A5E";
+	compatible = "radxa,cubie-a5e", "allwinner,sun55i-a527";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ext_osc32k: ext-osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext_osc32k";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply from the USB-C connector */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb_vbus: vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_vcc5v>;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */
+		enable-active-high;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_cldo3>;
+	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_DOWN)>; /* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_cldo3>;	/* via VCC-IO */
+	vcc-pc-supply = <&reg_cldo1>;
+	vcc-pd-supply = <&reg_cldo3>;
+	vcc-pe-supply = <&reg_aldo2>;
+	vcc-pf-supply = <&reg_cldo3>;	/* actually switchable */
+	vcc-pg-supply = <&reg_bldo1>;
+	vcc-ph-supply = <&reg_cldo3>;	/* via VCC-IO */
+	vcc-pi-supply = <&reg_cldo3>;
+	vcc-pj-supply = <&reg_cldo4>;
+	vcc-pk-supply = <&reg_cldo1>;
+};
+
+&r_i2c0 {
+	status = "okay";
+
+	axp717: pmic@34 {
+		compatible = "x-powers,axp717";
+		reg = <0x34>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+		vin4-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies the "little" cluster (1.4 GHz cores) */
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-name = "vdd-cpul";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <920000>;
+				regulator-max-microvolt = <920000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-dram";
+			};
+
+			reg_aldo1: aldo1 {
+				/* not connected */
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pe";
+			};
+
+			reg_aldo3: aldo3 {
+				/* supplies the I2C pins for this PMIC */
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl-usb";
+			};
+
+			reg_aldo4: aldo4 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pll-dxco-avcc";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pg-iowifi";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pm-lpddr4";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-mipi-cam";
+			};
+
+			reg_bldo4: bldo4 {
+				/* not connected */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pc-and-their-dog";
+			};
+
+			reg_cldo2: cldo2 {
+				/* not connected */
+			};
+
+			reg_cldo3: cldo3 {
+				/* IO, USB-2, 3V3, card, NAND, sensor, PI */
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-io-mmc-spi-ana";
+			};
+
+			reg_cldo4: cldo4 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pj-phy";
+			};
+
+			reg_cpusldo: cpusldo {
+				/* supplies the management core */
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdd-cpus";
+			};
+		};
+	};
+
+	axp323: pmic@36 {
+		compatible = "x-powers,axp323";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			aldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-mipi-dsi";
+			};
+
+			dldo1 {
+				/* not connected */
+			};
+
+			/* Supplies the "big" cluster (1.8 GHz cores) */
+			reg_dcdc1_323: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-name = "vdd-cpub";
+			};
+
+			/* DCDC2 is polyphased with DCDC1 */
+
+			/* RISC-V management core supply */
+			reg_dcdc3_323: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdd-dnr";
+			};
+		};
+	};
+};
+
+&r_pio {
+/*
+ * Specifying the supply would create a circular dependency.
+ *
+ *	vcc-pl-supply = <&reg_aldo3>;
+ */
+	vcc-pm-supply = <&reg_aldo3>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	/*
+	 * The USB-C port is the primary power supply, so in this configuration
+	 * relies on the other end of the USB cable to supply the VBUS power.
+	 * So use this port in peripheral mode.
+	 * It is possible to supply the board with the 5V pins on the GPIO
+	 * header, and since the DCIN_5V line is hardwired to the USB-C VBUS
+	 * pins, the port turns into a host port, unconditionally supplying
+	 * power. The dr_mode property should be changed to "host" here, if
+	 * users choose this setup.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+/*
+ * The schematic describes USB0_ID (PL10), measuring VBUS_5V, which looks to
+ * be always on. Also there is USB-VBUSDET (PL2), which is measuring the same
+ * VBUS_5V. There is also DCIN_DET, which measures DCIN_5V, so the power
+ * input rail.
+ * None of them seem to make any sense in relation to detecting USB devices
+ * or whether there is power provided via any USB pins: they would always
+ * report high, otherwise the system wouldn't be running.
+ * The AXP717C provides proper USB-C CC pin functionality, but the PMIC is
+ * not connected to those pins of the USB-C connector.
+ */
+&usbphy {
+	usb0_vbus-supply = <&reg_vcc5v>;
+	usb1_vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
-- 
2.46.3


