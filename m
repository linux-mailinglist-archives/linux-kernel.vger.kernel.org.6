Return-Path: <linux-kernel+bounces-389481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88A9B6D96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFFC1F21F39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADAC213ECD;
	Wed, 30 Oct 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaUkZAtI"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F31D2B23;
	Wed, 30 Oct 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319930; cv=none; b=UwL0gciQSMbsiPXsxdfJJcunZQ+2LYEgyIeDB/ZC5d7xkLJsHOsyvYVvSq+yvKEJF3ZYFetsYE1Q8vCugYrpzTTAwPXTkHIuuPsUTqkfQK+h9/pjShVrRRLXC9ALNW0ooWM84vm7TuOlU84Pz3kItZkKCamx3s4I928Femuthd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319930; c=relaxed/simple;
	bh=jRBv62MYQSdjHQJ4WSStd/PI+yo6mmxjUfp24zPwjn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3fuBxLoSWnHVNyE0lGqGEpSvceu5luvbS/IDYKLTF10GBIbtDMwrHjpWHUdVDXfR02lbWYjbUiZFOO/hWlNPpbwYV8tzegk4Jx3xWZVAsLDviW1MaD1V8OuE2HYk2BEtMukkOAdLqJ1Qo4DTYHjB2oggJTbKVIjWXIopc6hAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaUkZAtI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539d9fffea1so232837e87.2;
        Wed, 30 Oct 2024 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319926; x=1730924726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyEhEOgxThb7d7+N3ApRPh6+wTSlDIyGHam5i44pOZ0=;
        b=UaUkZAtIUb+KpRAGzDgEvk/udIlZm3k0t7U31C7HjDOiHOHpU/NCrQdsgTA35IP/bZ
         k3jfdOttROnGvMQ4GgBxUsCOPt+QB1qPdYw7Z5egBtK2uqp5N4EmwKLYRmINyPssY6sI
         hWTT1Q3C7znq3GThOTSIdcQCrViOyHRH5nlrG5dwhPYTtkRC1KJ0IvcskceUIOXaizsW
         DrqeBPJX7Vzvfw7XFFE69U9600PcUEZ0jfZZngyViujETu/h3zqP/0KCvIcBbOYKfKku
         hZdWfp32PvCdjbkPx1wZBrLQinPjoagvBnClsf8FGgxcZQUJ/Bot2/1tzvdqpEdWuGAn
         W9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319926; x=1730924726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyEhEOgxThb7d7+N3ApRPh6+wTSlDIyGHam5i44pOZ0=;
        b=ASfH4ktyeoFLqCSGU54qoq5zOo1Cl/qR5vevSiT5IUbAi3su+m2Lv5iQrOLaZpuwny
         RZInmhkTDMqRt2qht9yw0338qjLJY4w9onksORJOSf7T9rGMgdU7um2duFCDVEUsEdcy
         tMW+Jq2uoNg0RmGsnCOHQ7s2Hj9vTpf9vFeXMxLs4SHqwrrh+s7Vcfjxxe8pEMbiycBX
         V+U3ket2CIoiainA5U22WoG/aBmDfRT0TqIlzTg0NNDYKqwMEeEyQy6HhiA6OSagH6NJ
         s0fg0qC31LCXIFhSQwE+73iU85TnF1tlgVZxmPghdNHUVZJxj9xZTtfCqlALmCZFi7IC
         rNcA==
X-Forwarded-Encrypted: i=1; AJvYcCU4B9wTopbLfNgzUq7Jg9uMxf/3kNUfCS/KKyMMzoA0GqgS8RdKNL5h2HQ/AFDRZgaaXlzwvugbw5qXd4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzXywX7qz+8HztrXeDAfj+MGOs63D7YH6qn2KsT6eE30YQfSC
	KuvrMDV5oTkHymgEs2flhwc0LTQXueBu0y+rzxCks9LScn+1crY8
X-Google-Smtp-Source: AGHT+IH6uM7t2JTy0pUuTgiLogiMPS6a2rpUn8zTuzrYOehSN8Kg1Zh/Zyf0NBZ/XDN6UzlH6s/F/w==
X-Received: by 2002:a05:6512:1304:b0:53b:1f77:e95e with SMTP id 2adb3069b0e04-53b34c5f595mr8106413e87.44.1730319925638;
        Wed, 30 Oct 2024 13:25:25 -0700 (PDT)
Received: from localhost.localdomain ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d6ff10sm334644e87.269.2024.10.30.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:25:25 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add Banana Pi P2 Pro board
Date: Thu, 31 Oct 2024 01:21:44 +0500
Message-ID: <20241030202144.629956-3-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030202144.629956-1-dmt.yashin@gmail.com>
References: <20241030202144.629956-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Banana Pi P2 Pro is the SBC made by Shenzhen SINOVOIP based on
Rockchip RK3308.

Banana Pi P2 Pro features:
- Rockchip RK3308B-S
- DDR3 512 MB
- eMMC 8 GB
- 100M lan + onboard PoE
- 40 pin and 12 pin headers
- AP6256 BT + WIFI
- TF card slot
- 2x USB 2.0 (Type-C OTG and Type-A)
- Headphone jack

Add support for Banana Pi P2 Pro.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-bpi-p2-pro.dts   | 362 ++++++++++++++++++
 2 files changed, 363 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 2e485553ce8b..4c1fd113bdef 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4-core-mb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-bpi-p2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts
new file mode 100644
index 000000000000..2f7b09b7f43f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "rk3308.dtsi"
+
+/ {
+	model = "Banana Pi P2 Pro (RK3308) Board";
+	compatible = "sinovoip,rk3308-bpi-p2pro", "rockchip,rk3308";
+
+	aliases {
+		ethernet0 = &gmac;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	analog-sound {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3308";
+
+		dais = <&i2s_8ch_2_p0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&phone_ctl>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_en0>, <&led_en1>;
+
+		blue-led {
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "on";
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+			label = "blue:power";
+			linux,default-trigger = "default-on";
+		};
+
+		green-led {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+			label = "green:heartbeat";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vdd_log: regulator-1v04-vdd-log {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1040000>;
+		regulator-max-microvolt = <1040000>;
+		vin-supply = <&vcc_in>;
+	};
+
+	vcc_ddr: regulator-1v5-vcc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_ddr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		vin-supply = <&vcc_in>;
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_io: regulator-3v3-vcc-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_in>;
+	};
+
+	vcc_in: regulator-5v0-vcc-in {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_in";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vdd_core: regulator-vdd-core {
+		compatible = "pwm-regulator";
+		pwms = <&pwm0 0 5000 1>;
+		pwm-supply = <&vcc_in>;
+		regulator-name = "vdd_core";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <827000>;
+		regulator-max-microvolt = <1340000>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-0 = <&wifi_reg_on>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&codec {
+	status = "okay";
+
+	port {
+		codec_p0_0: endpoint {
+			remote-endpoint = <&i2s_8ch_2_p0_0>;
+		};
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_core>;
+};
+
+&emmc {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_pwren>;
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&mac_clkin>;
+	clock_in_out = "input";
+	phy-handle = <&rtl8201f>;
+	phy-supply = <&vcc_io>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		rtl8201f: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac_rst>;
+			reset-assert-us = <50000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&i2s_8ch_2 {
+	#sound-dai-cells = <0>;
+	status = "okay";
+
+	i2s_8ch_2_p0: port {
+		i2s_8ch_2_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&codec_p0_0>;
+		};
+	};
+};
+
+&io_domains {
+	vccio0-supply = <&vcc_io>;
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc_io>;
+	vccio3-supply = <&vcc_io>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rtc_32k>;
+
+	bt {
+		bt_reg_on: bt-reg-on {
+			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		host_wake_bt: host-wake-bt {
+			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	gmac {
+		mac_rst: mac-rst {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led_en0: led-en0 {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		led_en1: led-en1 {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sound {
+		phone_ctl: phone-ctl {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_reg_on: wifi-reg-on {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wifi_wake_host: wifi-wake-host {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pin_pull_down>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+/* WIFI part of the AP6256 connected with SDIO */
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	sd-uhs-sdr104;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_wake_host>;
+	};
+};
+
+&sdmmc {
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+/* BT part of the AP6256 connected with UART */
+&uart4 {
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&cru SCLK_RTC32K>;
+		clock-names = "lpo";
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wakeup";
+		device-wakeup-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reg_on &bt_wake_host &host_wake_bt>;
+		vbat-supply = <&vcc_io>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};
+
+&usb20_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.39.5


