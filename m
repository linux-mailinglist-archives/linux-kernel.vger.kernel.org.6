Return-Path: <linux-kernel+bounces-212240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC3905D33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E10284D12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076386AE3;
	Wed, 12 Jun 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="fzouls5N"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D084E07;
	Wed, 12 Jun 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225667; cv=none; b=Hway52KiFLurNT46OwRgHRJjEMlu5Apao2l8ElD07BcB5pYNdTRRN6F3BjOqHoEvIZ024EzzAmkH3rlRbfDQ7ZyPt+8QwT078PANaxkdXY+vPKxIGSxgFyo2hkQJ52ScnoTfGSr9DhuUU3lyI+s0nziHbgB6a2nbdRcIuzoKTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225667; c=relaxed/simple;
	bh=WnwRfPyeueYcu4XenBGVY15x51OIrxxyLkE0gtbmO7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNQZ0+18/JmXRyRcgX1dI9l6M/MTqLbXvu6FnfBUrgxm3vN1XT5yVh5qObgbjXKf597uXlSPXXBqlZ+apCU/3mJtd3WlhSBQ6uoPMmCNTeX7QO9YkegnYlQDJcElX55Ad64gdfmHRwOY30DeGkTgnkP3xaPoZLTc9Tguqs85aH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=fzouls5N; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id 463FD24193F;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 324942409FE;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix02.mail.de (Postfix) with ESMTP id 12140A00E2;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718225658;
	bh=WnwRfPyeueYcu4XenBGVY15x51OIrxxyLkE0gtbmO7M=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=fzouls5NFBKJzOtKJjM7wSAFFMwafLqyK60wdIxjjs0Z1BCNPDQx8dDXqS6j3kJiW
	 +DDIEpeHsFUFAg/a3w90HFH+Ydmk17w9oZduYCsWNjKm5f8u6GM7mtrItepsyh6s2H
	 dD8GEHIOuHS+4yLPx1AQ8LdG/z6httIp1K6ERuH1jyNJ3d1lKn9an2mX4bZTAtmhuV
	 Va21VFvXAcLI/V3I2wG2c4cQfXnZLLMUt/MgBJxbTgrw0cI0fCyjHEAfI682vLv0xp
	 UYkr43TDQ30dES5L0CwDwxppkQmEYctC93cILnTiryNlAckm55V9BgZyGjhsXVKQ3z
	 +QnHozjV2uleQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 8BA9F240A39;
	Wed, 12 Jun 2024 22:54:17 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: rockchip: Add common definitions for NanoPi R6C and R6S
Date: Wed, 12 Jun 2024 22:48:10 +0200
Message-ID: <20240612205056.397204-2-seb-dev@mail.de>
In-Reply-To: <20240612205056.397204-1-seb-dev@mail.de>
References: <20240612205056.397204-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 20572
X-purgate-ID: 154282::1718225657-FE5BF670-177C9480/0/0

The FriendlyElec NanoPi R6C and R6S are quite similar boards,
although they differ in:
- M.2 M-Key connector vs second RTL8125BG Ethernet port
- One of the LEDs has a different function on each board
- 12-pin GPIO FPC vs 30-pin GPIO header
- R6S has a PWM-based IR receiver while the R6C has not
- R6S has a 5V fan connector while the R6C has not

Refactor their DT files by adding a common definitions file to
improve differentiation clarity between both boards and to make
hardware-specific DT changes easier in the long run.
Do not introduce any functional changes.

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 ...-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} |   7 +-
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |   2 +-
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 756 +-----------------
 3 files changed, 7 insertions(+), 758 deletions(-)
 copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} (99%)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
similarity index 99%
copy from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
copy to arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index 4fa644ae510c..e68d4071400e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common devicetree definitions for the NanoPi R6C and R6S
+ */
 
 /dts-v1/;
 
@@ -8,9 +11,6 @@
 #include "rk3588s.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R6S";
-	compatible = "friendlyarm,nanopi-r6s", "rockchip,rk3588s";
-
 	aliases {
 		ethernet0 = &gmac1;
 		mmc0 = &sdmmc;
@@ -74,7 +74,6 @@ lan1_led: led-2 {
 		};
 
 		lan2_led: led-3 {
-			label = "lan2_led";
 			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&lan2_led_pin>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
index 497bbb57071f..ccc5e4627517 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "rk3588s-nanopi-r6s.dts"
+#include "rk3588s-nanopi-r6.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi R6C";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
index 4fa644ae510c..9c3e0b0daaac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -2,763 +2,13 @@
 
 /dts-v1/;
 
-#include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include "rk3588s.dtsi"
+#include "rk3588s-nanopi-r6.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi R6S";
 	compatible = "friendlyarm,nanopi-r6s", "rockchip,rk3588s";
-
-	aliases {
-		ethernet0 = &gmac1;
-		mmc0 = &sdmmc;
-		mmc1 = &sdhci;
-	};
-
-	chosen {
-		stdout-path = "serial2:1500000n8";
-	};
-
-	adc-keys {
-		compatible = "adc-keys";
-		io-channels = <&saradc 0>;
-		io-channel-names = "buttons";
-		keyup-threshold-microvolt = <1800000>;
-		poll-interval = <100>;
-
-		button-maskrom {
-			label = "Maskrom";
-			linux,code = <KEY_VENDOR>;
-			press-threshold-microvolt = <1800>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&key1_pin>;
-
-		button-user {
-			label = "User";
-			linux,code = <BTN_1>;
-			gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
-			debounce-interval = <50>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		sys_led: led-0 {
-			label = "sys_led";
-			gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			pinctrl-names = "default";
-			pinctrl-0 = <&sys_led_pin>;
-		};
-
-		wan_led: led-1 {
-			label = "wan_led";
-			gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&wan_led_pin>;
-		};
-
-		lan1_led: led-2 {
-			label = "lan1_led";
-			gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&lan1_led_pin>;
-		};
-
-		lan2_led: led-3 {
-			label = "lan2_led";
-			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&lan2_led_pin>;
-		};
-	};
-
-	vcc5v0_sys: vcc5v0-sys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v1_nldo_s3";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc_3v3_s0: vcc-3v3-s0-regulator {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "vcc_3v3_s0";
-		vin-supply = <&vcc_3v3_s3>;
-	};
-
-	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd_s0_pwr>;
-		regulator-name = "vcc_3v3_sd_s0";
-		regulator-boot-on;
-		regulator-max-microvolt = <3000000>;
-		regulator-min-microvolt = <3000000>;
-		vin-supply = <&vcc_3v3_s3>;
-	};
-
-	vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_pcie20";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_3v3_s3>;
-	};
-
-	vcc5v0_usb: vcc5v0-usb-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_usb_otg0: vcc5v0-usb-otg0-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&typec5v_pwren>;
-		regulator-name = "vcc5v0_usb_otg0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usb>;
-	};
-
-	vcc5v0_host_20: vcc5v0-host-20-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host20_en>;
-		regulator-name = "vcc5v0_host_20";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usb>;
-	};
-};
-
-&combphy0_ps {
-	status = "okay";
-};
-
-&combphy2_psu {
-	status = "okay";
-};
-
-&cpu_b0 {
-	cpu-supply = <&vdd_cpu_big0_s0>;
-};
-
-&cpu_b1 {
-	cpu-supply = <&vdd_cpu_big0_s0>;
-};
-
-&cpu_b2 {
-	cpu-supply = <&vdd_cpu_big1_s0>;
-};
-
-&cpu_b3 {
-	cpu-supply = <&vdd_cpu_big1_s0>;
-};
-
-&cpu_l0 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&cpu_l1 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&cpu_l2 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&cpu_l3 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&gmac1 {
-	clock_in_out = "output";
-	phy-handle = <&rgmii_phy1>;
-	phy-mode = "rgmii-rxid";
-	pinctrl-0 = <&gmac1_miim
-		     &gmac1_tx_bus2
-		     &gmac1_rx_bus2
-		     &gmac1_rgmii_clk
-		     &gmac1_rgmii_bus>;
-	pinctrl-names = "default";
-	tx_delay = <0x42>;
-	status = "okay";
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0m2_xfer>;
-	status = "okay";
-
-	vdd_cpu_big0_s0: regulator@42 {
-		compatible = "rockchip,rk8602";
-		reg = <0x42>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_big0_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <550000>;
-		regulator-max-microvolt = <1050000>;
-		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-
-	vdd_cpu_big1_s0: regulator@43 {
-		compatible = "rockchip,rk8603", "rockchip,rk8602";
-		reg = <0x43>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_big1_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <550000>;
-		regulator-max-microvolt = <1050000>;
-		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	vdd_npu_s0: regulator@42 {
-		compatible = "rockchip,rk8602";
-		reg = <0x42>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_npu_s0";
-		regulator-min-microvolt = <550000>;
-		regulator-max-microvolt = <950000>;
-		regulator-ramp-delay = <2300>;
-		regulator-boot-on;
-		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-};
-
-&i2c6 {
-	clock-frequency = <200000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6m0_xfer>;
-	status = "okay";
-
-	hym8563: rtc@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-output-names = "hym8563";
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_int>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
-		wakeup-source;
-	};
-};
-
-&mdio1 {
-	rgmii_phy1: ethernet-phy@1 {
-		compatible = "ethernet-phy-id001c.c916";
-		reg = <0x1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtl8211f_rst>;
-		reset-assert-us = <20000>;
-		reset-deassert-us = <100000>;
-		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&pcie2x1l1 {
-	reset-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc_3v3_pcie20>;
-	status = "okay";
-};
-
-&pcie2x1l2 {
-	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc_3v3_pcie20>;
-	status = "okay";
-};
-
-&pinctrl {
-	gpio-key {
-		key1_pin: key1-pin {
-			rockchip,pins = <1 RK_PC0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	gpio-leds {
-		sys_led_pin: sys-led-pin {
-			rockchip,pins =
-				<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		wan_led_pin: wan-led-pin {
-			rockchip,pins =
-				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		lan1_led_pin: lan1-led-pin {
-			rockchip,pins =
-				<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		lan2_led_pin: lan2-led-pin {
-			rockchip,pins =
-				<1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	hym8563 {
-		rtc_int: rtc-int {
-			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	sdmmc {
-		sd_s0_pwr: sd-s0-pwr {
-			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usb {
-		typec5v_pwren: typec5v-pwren {
-			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		vcc5v0_host20_en: vcc5v0-host20-en {
-			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	rtl8211f {
-		rtl8211f_rst: rtl8211f-rst {
-			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&saradc {
-	vref-supply = <&avcc_1v8_s0>;
-	status = "okay";
-};
-
-&sdhci {
-	bus-width = <8>;
-	no-sdio;
-	no-sd;
-	non-removable;
-	mmc-hs200-1_8v;
-	status = "okay";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-sd-highspeed;
-	disable-wp;
-	max-frequency = <150000000>;
-	no-mmc;
-	no-sdio;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_3v3_sd_s0>;
-	vqmmc-supply = <&vccio_sd_s0>;
-	status = "okay";
-};
-
-&spi2 {
-	status = "okay";
-	assigned-clocks = <&cru CLK_SPI2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
-	num-cs = <1>;
-
-	pmic@0 {
-		compatible = "rockchip,rk806";
-		spi-max-frequency = <1000000>;
-		reg = <0x0>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
-			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
-
-		system-power-controller;
-
-		vcc1-supply = <&vcc5v0_sys>;
-		vcc2-supply = <&vcc5v0_sys>;
-		vcc3-supply = <&vcc5v0_sys>;
-		vcc4-supply = <&vcc5v0_sys>;
-		vcc5-supply = <&vcc5v0_sys>;
-		vcc6-supply = <&vcc5v0_sys>;
-		vcc7-supply = <&vcc5v0_sys>;
-		vcc8-supply = <&vcc5v0_sys>;
-		vcc9-supply = <&vcc5v0_sys>;
-		vcc10-supply = <&vcc5v0_sys>;
-		vcc11-supply = <&vcc_2v0_pldo_s3>;
-		vcc12-supply = <&vcc5v0_sys>;
-		vcc13-supply = <&vcc_1v1_nldo_s3>;
-		vcc14-supply = <&vcc_1v1_nldo_s3>;
-		vcca-supply = <&vcc5v0_sys>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl1";
-			function = "pin_fun0";
-		};
-
-		rk806_dvs2_null: dvs2-null-pins {
-			pins = "gpio_pwrctrl2";
-			function = "pin_fun0";
-		};
-
-		rk806_dvs3_null: dvs3-null-pins {
-			pins = "gpio_pwrctrl3";
-			function = "pin_fun0";
-		};
-
-		regulators {
-			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
-				regulator-boot-on;
-				regulator-min-microvolt = <550000>;
-				regulator-max-microvolt = <950000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_gpu_s0";
-				regulator-enable-ramp-delay = <400>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <550000>;
-				regulator-max-microvolt = <950000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_cpu_lit_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_log_s0: dcdc-reg3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <675000>;
-				regulator-max-microvolt = <750000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_log_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <750000>;
-				};
-			};
-
-			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <550000>;
-				regulator-max-microvolt = <950000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_vdenc_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_ddr_s0: dcdc-reg5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <675000>;
-				regulator-max-microvolt = <900000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_ddr_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <850000>;
-				};
-			};
-
-			vdd2_ddr_s3: dcdc-reg6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vdd2_ddr_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_2v0_pldo_s3: dcdc-reg7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <2000000>;
-				regulator-max-microvolt = <2000000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_2v0_pldo_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <2000000>;
-				};
-			};
-
-			vcc_3v3_s3: dcdc-reg8 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_3v3_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vddq_ddr_s0: dcdc-reg9 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vddq_ddr_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_1v8_s3: dcdc-reg10 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_1v8_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			avcc_1v8_s0: pldo-reg1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "avcc_1v8_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc_1v8_s0: pldo-reg2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_1v8_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			avdd_1v2_s0: pldo-reg3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-name = "avdd_1v2_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			avcc_3v3_s0: pldo-reg4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "avcc_3v3_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vccio_sd_s0: pldo-reg5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vccio_sd_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			pldo6_s3: pldo-reg6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "pldo6_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vdd_0v75_s3: nldo-reg1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-name = "vdd_0v75_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <750000>;
-				};
-			};
-
-			avdd_ddr_pll_s0: nldo-reg2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-name = "avdd_ddr_pll_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <850000>;
-				};
-			};
-
-			avdd_0v75_s0: nldo-reg3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-name = "avdd_0v75_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			avdd_0v85_s0: nldo-reg4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-name = "avdd_0v85_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_0v75_s0: nldo-reg5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-name = "vdd_0v75_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-		};
-	};
-};
-
-&tsadc {
-	status = "okay";
-};
-
-&u2phy2 {
-	status = "okay";
-};
-
-&u2phy2_host {
-	phy-supply = <&vcc5v0_host_20>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-0 = <&uart2m0_xfer>;
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
 };
 
-&usb_host0_ohci {
-	status = "okay";
+&lan2_led {
+	label = "lan2_led";
 };
-- 
2.43.0


