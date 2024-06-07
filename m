Return-Path: <linux-kernel+bounces-206314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5849A9007B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FAF1F262E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8EE19AA65;
	Fri,  7 Jun 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="N8kmv8Jt"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDC199EA2;
	Fri,  7 Jun 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771948; cv=none; b=tiA2Lwi0kyLI4toqBiWJK2MxzaP/OSjQC9qO/MdXN++tW7VqN6Ft8rV4rz1ImCmibSB96tb3cOSQQXJaCBAsGQjbBPt2aX1269xeEQTaNTqLOnuTSIoj4fTHdx9yBru0gpFiVtHNbhlsFSvcY9eFOcx1FMcp1AaMJ5OlHqtVx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771948; c=relaxed/simple;
	bh=Wv/FSavn4HVy/GmOqreepbAS8afrNXfYrnL4aujOGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj1E7okPIzaAkYdetM6j+bTLjBp8MpLXTmFcFwcw/q2wCyIrF5RSWBK5mAwaZkVKvB5d+hU1UjghPrmQyookVEuMBOefSmKER9iM7UqZaQHVUDzwFB/RzUTrq4DgphKmzgik0+9AJD0cyAG/z8ooPrTa7B+1SsIIH+XgOL/zN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=N8kmv8Jt; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0231105CC8;
	Fri,  7 Jun 2024 17:52:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1717771942; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WoJ2u2sQQTGBjv0QfHI0WaIyW+EzyfWA149Uae4d4Ho=;
	b=N8kmv8JttDBGipGqRNUbHdOin47soTp2f4oOGhEcQFPy6k6ssvQ5patBOY8v5vbkLM5mYg
	n1hu+aB3BgnROdHHEgpQ1d2oNhmtgEiN7sAusFfevKcO27+NV8e+Nzs1K1shzn4PwZFY2F
	CjDghmVpeLqyqZXhphqc+N7neINerJWaApb5dI83bIQ2RzswD2byWl4jf8qqmBpMH0Xx4W
	bb8iLp8QjLyDWlCFqIuAkEZaOl19gaifq6XSX+Ovu6FEfUShWbQlyOMXeLx8sppxC30r2f
	qUZveqMiNSLDc1gaRSOtWO3yJsv+U69xn/rCVAturpVQ+T/PRKO0UFBEmIEP1w==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: meson-axg: add support for JetHome JetHub D2 (j200)
Date: Fri,  7 Jun 2024 17:50:04 +0300
Message-ID: <20240607145148.2246990-3-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607145148.2246990-1-adeep@lexina.in>
References: <20240607145148.2246990-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

JetHome Jethub D2 is a home automation controller with the following
features:
  - DIN Rail Mounting
  - Amlogic S905X3 (ARM Cortex-A55) quad-core
  - micro-HDMI video out
  - 4GB LPDDR4
  - 32GB eMMC flash
  - 1 x USB 2.0
  - 1 x 10/100/1000Mbps ethernet
  - two module slots for radio/wire interface cards
  - 2 x gpio LEDS
  - 1 x 1-Wire
  - 1 x RS-485
  - 3 x dry contact digital GPIO inputs
  - 2 x relay GPIO outputs
  - DC 9-36V power source with battery UPS on board option

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-sm1-jethome-jethub-j200.dts | 614 ++++++++++++++++++
 2 files changed, 615 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0f29517da5ec..d007b59497d4 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-jethome-jethub-j200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l-ts050.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-s905d3-libretech-cc.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts
new file mode 100644
index 000000000000..1391c921fb8f
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 JetHome
+ * Author: Viacheslav Bocharov <adeep@lexina.in>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1.dtsi"
+
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+
+/ {
+
+	compatible = "jethome,jethub-j200", "amlogic,sm1";
+	model = "JetHome JetHub D2";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		rtc0 = &rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	tflash_vdd: regulator-tflash_vdd {
+		compatible = "regulator-fixed";
+
+		regulator-name = "TFLASH_VDD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	tf_io: gpio-regulator-tf_io {
+		compatible = "regulator-gpio";
+
+		regulator-name = "TF_IO";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v>;
+
+		enable-gpios = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+		regulator-always-on;
+
+		gpios = <&gpio_ao GPIOAO_6 GPIO_OPEN_SOURCE>;
+		gpios-states = <0>;
+
+		states = <3300000 0>,
+			 <1800000 1>;
+	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&main_12v>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddcpu: regulator-vddcpu {
+		/*
+		 * MP8756GD Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU";
+		regulator-min-microvolt = <721000>;
+		regulator-max-microvolt = <1022000>;
+
+		pwm-supply = <&main_12v>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	usb_pwr_en: regulator-usb_pwr_en {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR_EN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		/* Connected to the microUSB port power enable */
+		gpio = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		/* 8ch hdmi interface */
+		dai-link-0 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-1 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			panic-indicator;
+		};
+
+		led-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+	};
+
+	sound {
+		model = "JETHUB-D2";
+	};
+
+	usb-hub {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* USB 2.0 hub with reset gpio */
+		hub_2_0: hub@1 {
+			compatible = "usb5e3,610";
+			reg = <1>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
+	};
+
+};
+
+&arb {
+	status = "okay";
+};
+
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU1_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu2 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU2_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu3 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU3_CLK>;
+	clock-latency = <50000>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+};
+
+&gpio {
+	gpio-line-names =
+		/* GPIOZ */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOH */
+		"", "", "", "", "",
+		"LED_RED", /* GPIOH_5 */
+		"I2C_SDA_MODULES", /* GPIOH_6 */
+		"I2C_SCL_MODULES", /* GPIOH_7 */
+		"",
+		/* BOOT */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOC */
+		"", "", "", "", "", "", "", "",
+		/* GPIOA */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "",
+		"I2C_SDA_SYSBUS", /* GPIOA_14 */
+		"I2C_SCL_SYSBUS", /* GPIOA_15 */
+		/* GPIOX */
+		"", /* GPIOX_0 */
+		"", /* GPIOX_1 */
+		"", /* GPIOX_2 */
+		"", /* GPIOX_3 */
+		"", /* GPIOX_4 */
+		"",  /* GPIOX_5 */
+		"RS485_TX", /* GPIOX_6 */
+		"RS485_RX", /* GPIOX_7 */
+		"", /* GPIOX_8 */
+		"", /* GPIOX_9 */
+		"", /* GPIOX_10 */
+		"", /* GPIOX_11 */
+		"",  /* GPIOX_12 */
+		"", /* GPIOX_13 */
+		"", /* GPIOX_14 */
+		"", /* GPIOX_15 */
+		"", /* GPIOX_16 */
+		"I2C_SDA_LCDBUS",  /* GPIOX_17 */
+		"I2C_SCL_LCDBUS",  /* GPIOX_18 */
+		""; /* GPIOX_19 */
+};
+
+&gpio_ao {
+	gpio-line-names =
+		/* GPIOAO */
+		"", "", "", "",
+		"MCU_RESET", /* GPIOAO_4 */
+		"POWER_GOOD", /* GPIOAO_5 */
+		"",
+		"MCU_BOOT", /* GPIOAO_7 */
+		"MCU_UART_TX", /* GPIOAO_8 */
+		"MCU_UART_RX", /* GPIOAO_9 */
+		"BUTTON_USR", /* GPIOAO_10 */
+		"LED_GREEN", /* GPIOAO_11 */
+		/* GPIOE */
+		"", "", "";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>; // GPIOE_1
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
+
+&saradc {
+	status = "okay";
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <200000000>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&tflash_vdd>;
+	vqmmc-supply = <&tf_io>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
+
+&spifc {
+	status = "disabled";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+	};
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&uart_AO_B {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_b_8_9_pins>;
+	pinctrl-names = "default";
+};
+
+&uart_B {
+	status = "okay";
+	pinctrl-0 = <&uart_b_pins>;
+	pinctrl-names = "default";
+};
+
+
+&usb {
+	status = "okay";
+	vbus-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy0 {
+	phy-supply = <&vcc_5v>;
+};
+
+
+/* I2C for modules */
+&i2c1 {
+	status = "okay";
+	pinctrl-0 = <&i2c1_sda_h6_pins>, <&i2c1_sck_h7_pins>;
+	pinctrl-names = "default";
+
+	/* GPIO expander */
+	u9: gpio@22 {
+		compatible = "nxp,pca9535";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"RELAY_1", "RELAY_2",
+			"", "",
+			"UXM1_RESET", "UXM1_BOOT",
+			"UXM2_RESET", "UXM2_BOOT",
+			"DIN_1", "DIN_2", "DIN_3",
+			"","","","","";
+	};
+
+	/* 1-wire */
+	w1: onewire@18 {
+		compatible = "maxim,ds2482";
+		reg = <0x18>;
+	};
+
+};
+
+
+/* I2C for lcd/etc */
+&i2c2 {
+	status = "okay";
+	pinctrl-0 = <&i2c2_sda_x_pins>, <&i2c2_sck_x_pins>;
+	pinctrl-names = "default";
+};
+
+/* I2C_EE_M3: I2C for CPU board */
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	/* I2C for rtc */
+	rtc: rtc@51 {
+		status = "okay";
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		wakeup-source;
+	};
+
+	/* FRAM on base board */
+	fram: eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+		pagesize = <0x20>;
+		label = "fram";
+		address-width = <0x10>;
+		vcc-supply = <&vddao_3v3>;
+	};
+
+	/* EEPROM on CPU board */
+	eepromc: eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+		pagesize = <0x20>;
+		label = "eepromc";
+		address-width = <0x10>;
+		vcc-supply = <&vddao_3v3>;
+	};
+
+	/* EEPROM on base board */
+	eeprompd: eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+		pagesize = <0x20>;
+		label = "eeprompd";
+		address-width = <0x10>;
+		vcc-supply = <&vddao_3v3>;
+	};
+
+	/* EEPROM on power module */
+	eeprompm: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <0x20>;
+		label = "eeprompm";
+		address-width = <0x10>;
+		vcc-supply = <&vddao_3v3>;
+	};
+
+	/* temperature sensors */
+	temp1: tmp102@48 {
+		compatible = "ti,tmp102";
+		reg = <0x48>;
+	};
+
+	temp2: tmp102@49 {
+		compatible = "ti,tmp102";
+		reg = <0x49>;
+	};
+
+};
-- 
2.45.2


