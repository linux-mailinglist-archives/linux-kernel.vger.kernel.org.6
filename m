Return-Path: <linux-kernel+bounces-212242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E7905D38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5991C20BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50712C465;
	Wed, 12 Jun 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="XfaaoS/a"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500885C7D;
	Wed, 12 Jun 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225670; cv=none; b=e54QSMj5D4AJuUb6y/8zNw0su1EMLqIcYGERgXQa4R5NibWs2Z8mLDqvARgFVrwGjnuJSZYqmNW/ue6jftIl7YCew9Z1DTZoXeD/+L0an1S+37qFpnN+bd8TOYC4GfA3PSHAowZsQhCtDsEkGJS3NA+sdMgVnp72Yt71zTWJj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225670; c=relaxed/simple;
	bh=jUQqkFnD1pHKO30UuOJFQGN4n1IsfoEwchb+wGSVsIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGB/sgeNYGXlZ6szxbVz3Tb2/xG3EUfLM9Q4cXtquF6ywdhEk1kkktxx+QnS45hoYHGHn2UwSi3lWNh4xYwDPhaWOtfJG8N8UUPQTlfQPnA43BnpvNLiG65Qp6tQC5EGRWVNA1+H1dxc8WmWxy/3vdPWGrhNi3cXSr4FN7Z2cSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=XfaaoS/a; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout12.mail.de (Postfix) with ESMTPS id C2081241943;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id A73EB2405B9;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix02.mail.de (Postfix) with ESMTP id 880D0A00E2;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718225658;
	bh=jUQqkFnD1pHKO30UuOJFQGN4n1IsfoEwchb+wGSVsIU=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=XfaaoS/aRMPtISMkDQQdrF16lOeYkr7rrQKYvv4Zjf2O3536FwSoMeYxFkwcDEWCj
	 DXd7Doz1aKQsW7StCOS7ca29B7sljyRGa31reLk+M+rV8/fOT9cBV8kU/PMxP3Bt4W
	 s2EGmNQ+QiTwjDyfjUeXHGuBrvV2HrNEDsRh6mBG+ip0MPxX02fbV42D6rSIDWkUvb
	 urVmSkMdFddoIhB+JQ+hV8kyiY1/mqDkY5X0nj0E1+bbs0oNqxLrgKsTLAGdE0CS0V
	 wzGp29oXQvuEIFCFB+JzEt9wIDc6QKZ9FCXkhvGPdeEwooM5lvWFkFqPBpdU1TpKWJ
	 vQu7o9hd0kAIQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 1C0A32400C1;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: rockchip: Fix regulators, gmac and naming on NanoPi R6C/R6S
Date: Wed, 12 Jun 2024 22:48:11 +0200
Message-ID: <20240612205056.397204-3-seb-dev@mail.de>
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
X-purgate-size: 13773
X-purgate-ID: 154282::1718225658-FE5BF670-DCDCD406/0/0

Fix the alphabetical ordering in some nodes and rename some regulators
and pins to match the schematics [1][2] as well as to adhere to
preferred naming schemes.

In addition to that:
* vcc_3v3_sd_s0: Fix voltage to be 3.3V
* vcc3v3_pcie:
    - Move to NanoPi R6C, this power switch is not available on R6S
    - Fix vin-supply (is vcc_5v0 per schematics)
    - Add gpios/pincrtl to enable power
* vcc5v0_usb: Remove this regulator since according to the schematics,
  vcc5v0_host_20 and vcc5v0_usb_otg0 are directly powered by vcc_5v0
* gmac1: Add rx_delay of 0 (no delay since phy-mode = "rgmii-rxid")
* rgmii_phy1: Add phy-supply as seen in schematics
* pcie2*:
    - Add pinctrl reset pins
    - Update vpcie3v3-supply to match the schematics
* sdhci: Add vmmc-supply and vqmmc-supply

Links:
[1] https://wiki.friendlyelec.com/wiki/images/f/f7/NanoPi_R6C_2302_SCH.PDF
[2] https://wiki.friendlyelec.com/wiki/images/2/2f/NanoPi_R6S_2208_SCH.PDF

Fixes: f1b11f43b3e9 ("arm64: dts: rockchip: Add support for NanoPi R6S")
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---

I didn't want to spam many patches with small fixes/improvements, so
this one patch includes lots of small changes. Let me know if another
method is preferred :)

---
 .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  | 169 +++++++++---------
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |  28 +++
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  |   5 +
 3 files changed, 122 insertions(+), 80 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index e68d4071400e..8b90bae28302 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -21,7 +21,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
-	adc-keys {
+	adc-key-maskrom {
 		compatible = "adc-keys";
 		io-channels = <&saradc 0>;
 		io-channel-names = "buttons";
@@ -41,10 +41,10 @@ gpio-keys {
 		pinctrl-0 = <&key1_pin>;
 
 		button-user {
-			label = "User";
-			linux,code = <BTN_1>;
-			gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
 			debounce-interval = <50>;
+			gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
+			label = "User Button";
+			linux,code = <BTN_1>;
 		};
 	};
 
@@ -80,26 +80,27 @@ lan2_led: led-3 {
 		};
 	};
 
-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc_5v0: regulator-vcc-5v0 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0";
 	};
 
-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <1100000>;
 		regulator-max-microvolt = <1100000>;
-		vin-supply = <&vcc5v0_sys>;
+		regulator-name = "vcc_1v1_nldo_s3";
+		vin-supply = <&vcc_5v0>;
 	};
 
-	vcc_3v3_s0: vcc-3v3-s0-regulator {
+	/* SY6280AAC power switch (U3824 in schematics) */
+	vcc_3v3_s0: regulator-vcc-3v3-s0 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -109,61 +110,45 @@ vcc_3v3_s0: vcc-3v3-s0-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};
 
-	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
+	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd_s0_pwr>;
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
 		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc_3v3_sd_s0";
 		vin-supply = <&vcc_3v3_s3>;
 	};
 
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
+	/* SY6280AAC power switch (U9539 in schematics) */
+	/* For USB 2.0 Type-A port */
+	vcc_5v0_host_20: regulator-vcc-5v0-host-20 {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&typec5v_pwren>;
-		regulator-name = "vcc5v0_usb_otg0";
+		pinctrl-0 = <&usb_host_pwren_h>;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usb>;
+		regulator-name = "vcc_5v0_host_20";
+		vin-supply = <&vcc_5v0>;
 	};
 
-	vcc5v0_host_20: vcc5v0-host-20-regulator {
+	/* SY6280AAC power switch (U9538 in schematics) */
+	/* For USB 3.0 Type-A port */
+	vcc5v0_usb_otg0: regulator-vcc5v0-usb-otg0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host20_en>;
-		regulator-name = "vcc5v0_host_20";
+		pinctrl-0 = <&typec5v_pwren_h>;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usb>;
+		regulator-name = "vcc5v0_usb_otg0";
+		vin-supply = <&vcc_5v0>;
 	};
 };
 
@@ -211,12 +196,13 @@ &gmac1 {
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;
 	phy-mode = "rgmii-rxid";
+	pinctrl-names = "default";
 	pinctrl-0 = <&gmac1_miim
 		     &gmac1_tx_bus2
 		     &gmac1_rx_bus2
 		     &gmac1_rgmii_clk
 		     &gmac1_rgmii_bus>;
-	pinctrl-names = "default";
+	rx_delay = <0x00>;
 	tx_delay = <0x42>;
 	status = "okay";
 };
@@ -230,13 +216,13 @@ vdd_cpu_big0_s0: regulator@42 {
 		compatible = "rockchip,rk8602";
 		reg = <0x42>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_big0_s0";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <550000>;
 		regulator-max-microvolt = <1050000>;
+		regulator-name = "vdd_cpu_big0_s0";
 		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc_5v0>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -247,13 +233,13 @@ vdd_cpu_big1_s0: regulator@43 {
 		compatible = "rockchip,rk8603", "rockchip,rk8602";
 		reg = <0x43>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_big1_s0";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <550000>;
 		regulator-max-microvolt = <1050000>;
+		regulator-name = "vdd_cpu_big1_s0";
 		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc_5v0>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -268,13 +254,13 @@ vdd_npu_s0: regulator@42 {
 		compatible = "rockchip,rk8602";
 		reg = <0x42>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_npu_s0";
+		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt = <550000>;
 		regulator-max-microvolt = <950000>;
+		regulator-name = "vdd_npu_s0";
 		regulator-ramp-delay = <2300>;
-		regulator-boot-on;
-		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc_5v0>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -293,35 +279,43 @@ hym8563: rtc@51 {
 		reg = <0x51>;
 		#clock-cells = <0>;
 		clock-output-names = "hym8563";
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_int>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_int>;
 		wakeup-source;
 	};
 };
 
+/* RTL8211F-CG Ethernet */
 &mdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-id001c.c916";
 		reg = <0x1>;
+		phy-supply = <&vcc_3v3_s0>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&rtl8211f_rst>;
+		pinctrl-0 = <&gmac1_rstn_l>;
 		reset-assert-us = <20000>;
 		reset-deassert-us = <100000>;
 		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
 	};
 };
 
+/* RTL8125BG Ethernet */
 &pcie2x1l1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20x1_1_perstn_m2>;
 	reset-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc_3v3_pcie20>;
+	vpcie3v3-supply = <&vcc_3v3_s3>;
 	status = "okay";
 };
 
+/* R6C: M.2 M-Key socket */
+/* R6S: RTL8125BG Ethernet */
 &pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20x1_2_perstn_m0>;
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc_3v3_pcie20>;
 	status = "okay";
 };
 
@@ -360,24 +354,34 @@ rtc_int: rtc-int {
 		};
 	};
 
+	pcie {
+		pcie20x1_1_perstn_m2: pcie2x1-1-rst {
+			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie20x1_2_perstn_m0: pcie2x1-2-rst {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
-		sd_s0_pwr: sd-s0-pwr {
+		sd_s0_pwr: sd-pwr {
 			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	usb {
-		typec5v_pwren: typec5v-pwren {
+		typec5v_pwren_h: usb3-pwren {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		vcc5v0_host20_en: vcc5v0-host20-en {
+		usb_host_pwren_h: usb2-pwren {
 			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
 	rtl8211f {
-		rtl8211f_rst: rtl8211f-rst {
+		gmac1_rstn_l: rtl8211f-rst {
 			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
@@ -388,15 +392,19 @@ &saradc {
 	status = "okay";
 };
 
+/* eMMC */
 &sdhci {
 	bus-width = <8>;
-	no-sdio;
+	mmc-hs200-1_8v;
 	no-sd;
+	no-sdio;
 	non-removable;
-	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
 };
 
+/* microSD card */
 &sdmmc {
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -411,16 +419,15 @@ &sdmmc {
 };
 
 &spi2 {
-	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
 	assigned-clock-rates = <200000000>;
+	num-cs = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
-	num-cs = <1>;
+	status = "okay";
 
-	pmic@0 {
+	rk806_single: pmic@0 {
 		compatible = "rockchip,rk806";
-		spi-max-frequency = <1000000>;
 		reg = <0x0>;
 
 		interrupt-parent = <&gpio0>;
@@ -430,23 +437,24 @@ pmic@0 {
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 
+		spi-max-frequency = <1000000>;
 		system-power-controller;
 
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
+		vcc1-supply = <&vcc_5v0>;
+		vcc2-supply = <&vcc_5v0>;
+		vcc3-supply = <&vcc_5v0>;
+		vcc4-supply = <&vcc_5v0>;
+		vcc5-supply = <&vcc_5v0>;
+		vcc6-supply = <&vcc_5v0>;
+		vcc7-supply = <&vcc_5v0>;
+		vcc8-supply = <&vcc_5v0>;
+		vcc9-supply = <&vcc_5v0>;
+		vcc10-supply = <&vcc_5v0>;
 		vcc11-supply = <&vcc_2v0_pldo_s3>;
-		vcc12-supply = <&vcc5v0_sys>;
+		vcc12-supply = <&vcc_5v0>;
 		vcc13-supply = <&vcc_1v1_nldo_s3>;
 		vcc14-supply = <&vcc_1v1_nldo_s3>;
-		vcca-supply = <&vcc5v0_sys>;
+		vcca-supply = <&vcc_5v0>;
 
 		gpio-controller;
 		#gpio-cells = <2>;
@@ -745,10 +753,11 @@ &u2phy2 {
 };
 
 &u2phy2_host {
-	phy-supply = <&vcc5v0_host_20>;
+	phy-supply = <&vcc_5v0_host_20>;
 	status = "okay";
 };
 
+/* Debug UART */
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
index ccc5e4627517..24dcd3e07ea7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
@@ -7,8 +7,36 @@
 / {
 	model = "FriendlyElec NanoPi R6C";
 	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
+
+	/* MP2143DJ power switch (U9536 in schematics) */
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie20x1_2_con_pwren>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie";
+		vin-supply = <&vcc_5v0>;
+	};
 };
 
 &lan2_led {
 	label = "user_led";
 };
+
+/* M.2 M-Key socket */
+&pcie2x1l2 {
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+};
+
+&pinctrl {
+	pcie {
+		pcie20x1_2_con_pwren: pcie20x1-2-con-pwren {
+			rockchip,pins = <3 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
index 9c3e0b0daaac..d24110b6cf5d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -12,3 +12,8 @@ / {
 &lan2_led {
 	label = "lan2_led";
 };
+
+/* RTL8125BG Ethernet */
+&pcie2x1l2 {
+	vpcie3v3-supply = <&vcc_3v3_s3>;
+};
-- 
2.43.0


