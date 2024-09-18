Return-Path: <linux-kernel+bounces-332824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE097BF46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328201C21BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DA1C9ECC;
	Wed, 18 Sep 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGwPHm1x"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C061C9DD2;
	Wed, 18 Sep 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678237; cv=none; b=Frq9TCjmAvM8a5Yvtc8+FwtabfYKbLJ19VdjwT+0EbUxH8lZomuC2xTgZJxGehzpyb2RGZZvM3OVCgh/4HdsNVn3pWcvatvrxJuNgwMvkCjOiEqC2mtFm9eykv+TlhLYE1zsxjE5/q6xxtvaxoFEbLqyOw4EUbSX2SGozFzidkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678237; c=relaxed/simple;
	bh=L194GVPqlhEKTAjInwLGnwQ9t2gUkt6Las6bQjzBuic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZ6zdRo+NzOPjs+YuUohOOccXiMBR7GgrUiwpfKObjKgBfUt1nSsDvQdc7qkn7oBS+gLY/XiDOb9Q7w8iLXnybWVsukflatNELTeiQ20uzGJ+EgYPs1ZcRu3fdHl79thKVvc7HPTSQdd36RhEtdOF60z0uJy2xkfskyf0xBTY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGwPHm1x; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db1f10201eso439528a12.1;
        Wed, 18 Sep 2024 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726678234; x=1727283034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EubABu1X3rzMfuanqy73fHp4ADsy8qEmKdS8meBggks=;
        b=BGwPHm1xgthfasFl4IIxJJzyswe0/7ac/z/zd1FZhqpsmj5Xay5s+fHoiyWMbf9O5+
         tAMuCTQNOXz6bj/6hVCT/wp/AQWlQA2jJOj2Hfe6igAvNUQn4yUiB2cYhMlKp+2z0tZj
         oY0oK2ZBEZfGnSpY7H4fcBNL1wFiH56bZ4OPf/GjToCm+l6I98kN4nhsyOgpcW/p1krV
         dHdxcjqEgKPXEvMvYr6HTXP1tM0gEs58CkAtSsRSUZq1P5hLPV0HJKOiokjxncydWPPO
         GKFsd5OZFfXG5Y7wmg3uvECIlTI2aPkbob2xYPAPh3jL2VJqj/s+nebfUUk0DjtWWLR3
         Whsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726678234; x=1727283034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EubABu1X3rzMfuanqy73fHp4ADsy8qEmKdS8meBggks=;
        b=BS/YFjpr+gjSaxcjQ/P11llC+tFs+Z9ZVY/IxUAn30auOMlF8l9fSrdM45Bp5eHI1O
         u0tesBVRUIQXSL9nNKBB3q+xcdh5b7cJEZCFCvHT9sWQbc936w3A/91/jJsaskxONYiL
         ZOc7hpPgALkxp343oyNQnaxipjiwmB0OfGp3x/2bUgux2Xf71UNdZvfU08uQUnpjsa3g
         pc0+h0GB/dnpqezGCPoiI/fKeoZZcQVJ44IFucZF3+7D1z9lhNbiynMG3u+Wxqk2BLBC
         I3pPbSwfAu3LnB1bgM4Qxto+brImJMkDCl7BMUDeurtSWuv28AknvAYYdNFyxojE9BO8
         TGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVLrhqKguFq+/gDUl9xyLx7Gtu+aQl9EPvtw4SpTkHZBer8/AuK0Hjs9A3OeiKLiwRSl5hAFOKWJ3bzG5xk@vger.kernel.org, AJvYcCVsknNoCtPXaaFFvGkOUQv43xGTKDrbHVTXNjADqC0lvhLHzaPzTKA4umZ4JWId+e+O5huGWGfbhSng@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/Os2TBL4mblhHANo998ZupHiAQMLfwSDc56S4YZTeURlxDQm
	zLh0kvVWIFcEjmMm/Y3VOwwPfDWxo63eiYYf8W3ZGr6VGRlfncOP
X-Google-Smtp-Source: AGHT+IGf3qk6BvuAkf7lyhjZAVe7Zja3ghzTyt5TdJrA2Otxz+jmX2lxn/y2GOew5453pakceSDaeg==
X-Received: by 2002:a05:6a20:728f:b0:1cf:37d4:c4f6 with SMTP id adf61e73a8af0-1cf75ec64dcmr18077613637.4.1726678234516;
        Wed, 18 Sep 2024 09:50:34 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498f9eb2sm6696123a12.23.2024.09.18.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 09:50:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add ArmSoM W3 board
Date: Thu, 19 Sep 2024 00:50:08 +0800
Message-Id: <20240918165008.169917-4-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918165008.169917-1-liujianfeng1994@gmail.com>
References: <20240918165008.169917-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W3 is the carrier board for LM7 System on Module.

W3 features:
- 1x 2.5GbE Realtek RTL8125 Ethernet
- 2x HDMI Type A out
- 1x HDMI Type A in
- 1x USB 3.1 Type C
- 2x USB 2.0 Type A
- 2x USB 3.0 Type A
- 1x PCIE 2.0 M.2 E Key (1 lane)
- 1x PCIE 3.0 PCIe (4 lanes)
- 1x TF scard slot
- 1x MIPI CSI
- 1x MIPI DSI
- 1x ES8316 audio jack
- 1x FAN connector
- 1x RTC
- 40-pin expansion header

Add support for ArmSoM LM7 board.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-armsom-w3.dts    | 408 ++++++++++++++++++
 2 files changed, 409 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 09423070c99..b0ed12f41f0 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -125,6 +125,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-w3.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-genbook.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
new file mode 100644
index 00000000000..321a44f081c
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "rk3588-armsom-lm7.dtsi"
+
+/ {
+	model = "ArmSoM W3";
+	compatible = "armsom,w3", "armsom,lm7", "rockchip,rk3588";
+
+	aliases {
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	analog-sound {
+		compatible = "audio-graph-card";
+		label = "rk3588-es8316";
+
+		widgets = "Microphone", "Mic Jack",
+			  "Headphone", "Headphones";
+
+		routing = "MIC2", "Mic Jack",
+			  "Headphones", "HPOL",
+			  "Headphones", "HPOR";
+
+		dais = <&i2s0_8ch_p0>;
+		hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_rgb_b>;
+
+		led_rgb_b {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led_rgb_r {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 120 150 180 210 240 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm1 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-pcie-wlan";
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	};
+
+	rfkill-bt {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-bt";
+		radio-type = "bluetooth";
+		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie2_0_vcc3v3_en>;
+		regulator-name = "vcc3v3_pcie2x1l0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie2x1l2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie3_vcc3v3_en>;
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy1_ps {
+	status = "okay";
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	es8316: audio-codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
+		clock-names = "mclk";
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_8ch_p0_0>;
+			};
+		};
+	};
+};
+
+&i2s0_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0_lrck
+		     &i2s0_mclk
+		     &i2s0_sclk
+		     &i2s0_sdi0
+		     &i2s0_sdo0>;
+	status = "okay";
+
+	i2s0_8ch_p0: port {
+		i2s0_8ch_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
+};
+
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map2 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&pcie2x1l0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_0_rst>;
+	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
+	status = "okay";
+};
+
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_2_rst>;
+	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_rst>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led_rgb_b: led-rgb-b {
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sound {
+		hp_detect: hp-detect {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie2 {
+		pcie2_0_rst: pcie2-0-rst {
+			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
+			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3_rst: pcie3-rst {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&sdmmc {
+	max-frequency = <200000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
+&sdio {
+	max-frequency = <200000000>;
+	no-sd;
+	no-mmc;
+	non-removable;
+	bus-width = <4>;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	wakeup-source;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_pcie2x1l0>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdiom0_pins>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	/* connected to USB hub, which is powered by vcc5v0_sys */
+	phy-supply = <&vcc5v0_sys>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_host2_xhci {
+	status = "okay";
+};
-- 
2.34.1


