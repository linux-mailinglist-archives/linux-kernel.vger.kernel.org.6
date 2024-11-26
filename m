Return-Path: <linux-kernel+bounces-422191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6B9D95AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64892B242E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7501CEEB6;
	Tue, 26 Nov 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ky3HtSEk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB831CD21E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617402; cv=none; b=EWb1p11MmG/pdhDIdhpXWvDQasdcgFTQeEV6QZ4QbsG7fr7Csv9tsXC+3F9zcqP4B3qdo5qg8atB+3KoEq/Pa2N2qj66s+MAINxbRqfleg1KfOSBTf9kJmtH6ZlVmH4jGR1tRPKqZfBGFyfv67Jmo6nI+XQ/qg2ifFJFXV+hNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617402; c=relaxed/simple;
	bh=PjAWiEy+yDrTm5nsMMoz3erNjddX5sXFdWl9i+7WV54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3xQZiU1LVC/bFo5HVX+PKfD6U5fvAZnlSB6DC8lYTV0Yv2xFcZ0kU2J0kafsRSR3DaMtdJsWvyajzmuAXZGQwxUmE3qF/CNiJAiZ8TjD2Z6r0ifPpX4Vo4AEOkZ6p+N703WhDxJzgzM8LQFRFla7LRUOhENMS6XLam7nazEG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ky3HtSEk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa549f2fa32so324482166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732617398; x=1733222198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcVtO2/VAuiB/FCw3dtkLtB7r6omKIcIAIukLQtK/JE=;
        b=Ky3HtSEkYr5VtEEksCmqWHPMCg9zyP0BrmTuSN4EEaSaPeEra0/qlnZGQ9HXf43AuY
         58rv5r91tCdOBp+n+HJIwc75Jn/VO6WeB46oWWAyq4EypT+wc3nSEryTvNp3afdtL5c1
         7bT5oO6SvQY472IuaZNd1aNbfLk6kfy6HAR9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617398; x=1733222198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcVtO2/VAuiB/FCw3dtkLtB7r6omKIcIAIukLQtK/JE=;
        b=VobI0Vc2be/QYyae/nSgUsbySjfwCQQPytIKMrNomYJC/YYl1PF7AEWmJ04pDaXoP7
         9CYKMCQwHaDj7YUxF6OKFpKF5WxIzJIhdwI8Plyg82hJ2tdqTnnAw/BixKtHgUFeME2L
         51sVLuuILA4CsR8GJ34uKj8uCxLrZtmKScj2l/FvnVfORxfR1EIUOEcmUEJiOX/fjLXx
         BWALDKmb1Y5AKYEKja2k/6K4TY1/mtY//UGjsTgv2gGyBLzM4gMWoClVpYu0nwdLSbg8
         M8+gZwwWJpjQZd4TOzbzj692Z/AfUtK/ULTDX/aksOcuj5Zqk5zx02SNpUs1T7An98GA
         0JwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXn3f7Quem9bDMXMHF4NyVMnk0xqepdYlUH93w3xG9WFXAVawoYwUuWAip+l7X4N4zd8uTWMbQiXVr0EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYN5tgDOPx0PPa+NS2oFVlDYMliiJu9Ugqn216Zpqn62IC7QtC
	GW9rFY+PYHhMgHYXsWpl8dzOM+Tiu+qqE/VjKKmkfOSvZ4WOQWFcj3sBiMpQwQ==
X-Gm-Gg: ASbGncsMsrx/yQKLxj1MGiMl5ShdR3cLG4iVwNff9sKrFy8kYitkQQQD+xFf4MVjYdL
	ARPjHdZs0kfQZR7/inQ21w3OKD4BYAIcH0pNjc0c2ZaUHG23n6X0jrPywjI6shwlOvjZrHgR+zR
	trVdIIBEXIpXWihaeChHCI22Us7qgz7T4KLfky9SCGTzhiUXDx3Ew9ZQNT4pdbKV+7QC9/fbWuW
	G2gXMMaCTG8RZoKD4jNWArJTng6GMwemS8onIh9c9TSryn9P5+XlWIdc+aEIPmH2VDpyQ4LKX+N
	b65yUaBh
X-Google-Smtp-Source: AGHT+IH6SoiBQNs1PH1vTbrMYUsHKkqHsvUt/WAb3Jw2stmLAuy5xH4GcliFnWQk/mAGB+AbBQaXgA==
X-Received: by 2002:a17:906:23ea:b0:aa5:4731:1eaa with SMTP id a640c23a62f3a-aa547311fb0mr639351666b.50.1732617398459;
        Tue, 26 Nov 2024 02:36:38 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa53028b512sm455981766b.117.2024.11.26.02.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:36:38 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v3 2/2] arm64: dts: mediatek: mt8186: Add Starmie device
Date: Tue, 26 Nov 2024 10:36:32 +0000
Message-ID: <20241126103632.419469-3-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241126103632.419469-1-wmacek@chromium.org>
References: <20241126103632.419469-1-wmacek@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Starmie Chromebooks.

Signed-off-by: Wojciech Macek <wmacek@chromium.org>
---
Changelog v3-v2:
 - Cleaned up DTS
   - Re-using dsi_out node
   - Removed unnecessary delete-nodes
   - Moved touchpads to per-board dts
   - Modified 3.3/6V power regulator node
Changelog v2-v1:
 - No changes
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8186-corsola-starmie-sku0.dts  |  31 ++
 .../mediatek/mt8186-corsola-starmie-sku1.dts  |  31 ++
 .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 465 ++++++++++++++++++
 4 files changed, 529 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..2ee6266ddf43 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -59,6 +59,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-starmie-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-starmie-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
new file mode 100644
index 000000000000..23e194579bf2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-starmie.dtsi"
+
+/ {
+	model = "Google Starmie sku0 board";
+	compatible = "google,starmie-sku0", "google,starmie-sku2",
+		     "google,starmie-sku3", "google,starmie",
+		     "mediatek,mt8186";
+};
+
+&panel {
+	compatible = "starry,ili9882t";
+};
+
+&i2c1 {
+	touchscreen: touchscreen@41 {
+		compatible = "ilitek,ili9882t";
+		reg = <0x41>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		panel = <&panel>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vccio-supply = <&mt6366_vio18_reg>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
new file mode 100644
index 000000000000..77922d77859a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-starmie.dtsi"
+
+/ {
+	model = "Google Starmie sku1 board";
+	compatible = "google,starmie-sku1", "google,starmie-sku4",
+		     "google,starmie", "mediatek,mt8186";
+};
+
+&panel {
+	compatible = "starry,himax83102-j02";
+};
+
+&i2c1 {
+	touchscreen_himax: touchscreen@4f {
+		compatible = "hid-over-i2c";
+		reg = <0x4f>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		vdd-supply = <&mt6366_vio18_reg>;
+		panel = <&panel>;
+		post-power-on-delay-ms = <450>;
+		hid-descr-addr = <0x0001>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
new file mode 100644
index 000000000000..211748437baf
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola.dtsi"
+
+/ {
+	en_pp6000_mipi_disp_150ma: en-pp6000-mipi-disp-150ma {
+		compatible = "regulator-fixed";
+		regulator-name = "en_pp6000_mipi_disp_150ma";
+		gpio = <&pio 154 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp6000_mipi_disp_150ma_fixed_pins>;
+	};
+
+	/*
+	 * Starmie does not have 3.3V display regulator. It is replaced
+	 * with 6V module for enabling panel, re-using eDP GPIOs.
+	 */
+	/delete-node/ pp3300_disp_x;
+	en_pp6000_mipi_disp: en-regulator-pp6000-mipi-disp {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_fixed_pins>;
+		gpios = <&pio 153 GPIO_ACTIVE_HIGH>;
+		regulator-name = "en_pp6000_mipi_disp";
+		enable-active-high;
+		regulator-enable-ramp-delay = <3000>;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	tboard_thermistor1: thermal-sensor1 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 0>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <    (-5000) 1492
+						0 1413
+						5000 1324
+						10000 1227
+						15000 1121
+						20000 1017
+						25000 900
+						30000 797
+						35000 698
+						40000 606
+						45000 522
+						50000 449
+						55000 383
+						60000 327
+						65000 278
+						70000 236
+						75000 201
+						80000 171
+						85000 145
+						90000 163
+						95000 124
+						100000 91
+						105000 78
+						110000 67
+						115000 58
+						120000 50
+						125000 44>;
+	};
+
+	tboard_thermistor2: thermal-sensor2 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 1>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <    (-5000) 1492
+						0 1413
+						5000 1324
+						10000 1227
+						15000 1121
+						20000 1017
+						25000 900
+						30000 797
+						35000 698
+						40000 606
+						45000 522
+						50000 449
+						55000 383
+						60000 327
+						65000 278
+						70000 236
+						75000 201
+						80000 171
+						85000 145
+						90000 163
+						95000 124
+						100000 91
+						105000 78
+						110000 67
+						115000 58
+						120000 50
+						125000 44>;
+	};
+};
+
+/*
+ * Starmie does not have EC keyboard. Remove default keyboard controller
+ * and replace it with the driver for side switches.
+ */
+/delete-node/ &keyboard_controller;
+
+&cros_ec {
+	cbas: cbas {
+		compatible = "google,cros-cbas";
+	};
+
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	panel: panel@0 {
+		/* compatible will be set in board dts */
+		reg = <0>;
+		enable-gpios = <&pio 98 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_pins_default>;
+		avdd-supply = <&en_pp6000_mipi_disp>;
+		avee-supply = <&en_pp6000_mipi_disp_150ma>;
+		pp1800-supply = <&mt6366_vio18_reg>;
+		backlight = <&backlight_lcd0>;
+		rotation = <270>;
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
+&dsi_out {
+	remote-endpoint = <&panel_in>;
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c4 {
+	status = "disabled";
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+};
+
+&mmc1_pins_default {
+	pins-clk {
+		drive-strength = <8>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <8>;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <8>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <8>;
+	};
+};
+
+&pen_insert {
+	wakeup-event-action = <EV_ACT_ANY>;
+};
+
+&pio {
+	/* 185 lines */
+	gpio-line-names = "TP",
+			  "TP",
+			  "TP",
+			  "I2S0_HP_DI",
+			  "I2S3_DP_SPKR_DO",
+			  "SAR_INT_ODL",
+			  "BT_WAKE_AP_ODL",
+			  "WIFI_INT_ODL",
+			  "DPBRDG_INT_ODL",
+			  "NC",
+			  "EC_AP_HPD_OD",
+			  "NC",
+			  "TCHSCR_INT_1V8_ODL",
+			  "EC_AP_INT_ODL",
+			  "EC_IN_RW_ODL",
+			  "GSC_AP_INT_ODL",
+			  /*
+			   * AP_FLASH_WP_L is crossystem ABI. Rev1 schematics
+			   * call it AP_WP_ODL.
+			   */
+			  "AP_FLASH_WP_L",
+			  "HP_INT_ODL",
+			  "PEN_EJECT_OD",
+			  "NC",
+			  "NC",
+			  "UCAM_SEN_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "I2S2_DP_SPK_MCK",
+			  "I2S2_DP_SPKR_BCK",
+			  "I2S2_DP_SPKR_LRCK",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "UART_GSC_TX_AP_RX",
+			  "UART_AP_TX_GSC_RX",
+			  "UART_DBGCON_TX_ADSP_RX",
+			  "UART_ADSP_TX_DBGCON_RX",
+			  "NC",
+			  "TCHSCR_REPORT_DISABLE",
+			  "NC",
+			  "EN_PP1800_DPBRDG",
+			  "SPI_AP_CLK_EC",
+			  "SPI_AP_CS_EC_L",
+			  "SPI_AP_DO_EC_DI",
+			  "SPI_AP_DI_EC_DO",
+			  "SPI_AP_CLK_GSC",
+			  "SPI_AP_CS_GSC_L",
+			  "SPI_AP_DO_GSC_DI",
+			  "SPI_AP_DI_GSC_DO",
+			  "UART_DBGCON_TX_SCP_RX",
+			  "UART_SCP_TX_DBGCON_RX",
+			  "EN_PP1200_CAM_X",
+			  "WLAN_MODULE_RST_L",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "I2S1_HP_DO",
+			  "I2S1_HP_BCK",
+			  "I2S1_HP_LRCK",
+			  "I2S1_HP_MCK",
+			  "TCHSCR_RST_1V8_L",
+			  "SPI_AP_CLK_ROM",
+			  "SPI_AP_CS_ROM_L",
+			  "SPI_AP_DO_ROM_DI",
+			  "SPI_AP_DI_ROM_DO",
+			  "NC",
+			  "NC",
+			  "EMMC_STRB",
+			  "EMMC_CLK",
+			  "EMMC_CMD",
+			  "EMMC_RST_L",
+			  "EMMC_DATA0",
+			  "EMMC_DATA1",
+			  "EMMC_DATA2",
+			  "EMMC_DATA3",
+			  "EMMC_DATA4",
+			  "EMMC_DATA5",
+			  "EMMC_DATA6",
+			  "EMMC_DATA7",
+			  "AP_KPCOL0",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "TP",
+			  "SDIO_CLK",
+			  "SDIO_CMD",
+			  "SDIO_DATA0",
+			  "SDIO_DATA1",
+			  "SDIO_DATA2",
+			  "SDIO_DATA3",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "MIPI_BL_PWM_1V8",
+			  "DISP_RST_1V8_L",
+			  "MIPI_DPI_CLK",
+			  "MIPI_DPI_VSYNC",
+			  "MIPI_DPI_HSYNC",
+			  "MIPI_DPI_DE",
+			  "MIPI_DPI_D0",
+			  "MIPI_DPI_D1",
+			  "MIPI_DPI_D2",
+			  "MIPI_DPI_D3",
+			  "MIPI_DPI_D4",
+			  "MIPI_DPI_D5",
+			  "MIPI_DPI_D6",
+			  "MIPI_DPI_DA7",
+			  "MIPI_DPI_D8",
+			  "MIPI_DPI_D9",
+			  "MIPI_DPI_D10",
+			  "MIPI_DPI_D11",
+			  "PCM_BT_CLK",
+			  "PCM_BT_SYNC",
+			  "PCM_BT_DI",
+			  "PCM_BT_DO",
+			  "JTAG_TMS_TP",
+			  "JTAG_TCK_TP",
+			  "JTAG_TDI_TP",
+			  "JTAG_TDO_TP",
+			  "JTAG_TRSTN_TP",
+			  "NC",
+			  "NC",
+			  "UCAM_DET_ODL",
+			  "NC",
+			  "NC",
+			  "AP_I2C_TCHSCR_SCL_1V8",
+			  "AP_I2C_TCHSCR_SDA_1V8",
+			  "NC",
+			  "NC",
+			  "AP_I2C_DPBRDG_SCL_1V8",
+			  "AP_I2C_DPBRDG_SDA_1V8",
+			  "NC",
+			  "NC",
+			  "AP_I2C_AUD_SCL_1V8",
+			  "AP_I2C_AUD_SDA_1V8",
+			  "AP_I2C_DISP_SCL_1V8",
+			  "AP_I2C_DISP_SDA_1V8",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SCP_I2C_SENSOR_SCL_1V8",
+			  "SCP_I2C_SENSOR_SDA_1V8",
+			  "AP_EC_WARM_RST_REQ",
+			  "AP_XHCI_INIT_DONE",
+			  "USB3_HUB_RST_L",
+			  "EN_SPKR",
+			  "BEEP_ON",
+			  "AP_DISP_BKLTEN",
+			  "EN_PP6000_MIPI_DISP",
+			  "EN_PP6000_MIPI_DISP_150MA",
+			  "BT_KILL_1V8_L",
+			  "WIFI_KILL_1V8_L",
+			  "PWRAP_SPI0_CSN",
+			  "PWRAP_SPI0_CK",
+			  "PWRAP_SPI0_MO",
+			  "PWRAP_SPI0_MI",
+			  "SRCLKENA0",
+			  "SRCLKENA1",
+			  "SCP_VREQ_VAO",
+			  "AP_RTC_CLK32K",
+			  "AP_PMIC_WDTRST_L",
+			  "AUD_CLK_MOSI",
+			  "AUD_SYNC_MOSI",
+			  "AUD_DAT_MOSI0",
+			  "AUD_DAT_MOSI1",
+			  "AUD_CLK_MISO",
+			  "AUD_SYNC_MISO",
+			  "AUD_DAT_MISO0",
+			  "AUD_DAT_MISO1",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DPBRDG_RST_L",
+			  "LTE_W_DISABLE_L",
+			  "LTE_SAR_DETECT_L",
+			  "EN_PP3300_LTE_X",
+			  "LTE_PWR_OFF_L",
+			  "LTE_RESET_L",
+			  "TP",
+			  "TP";
+
+	dpi_pin_default: dpi-pin-default {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO103__FUNC_GPIO103>,
+				 <PINMUX_GPIO104__FUNC_GPIO104>,
+				 <PINMUX_GPIO105__FUNC_GPIO105>,
+				 <PINMUX_GPIO106__FUNC_GPIO106>,
+				 <PINMUX_GPIO107__FUNC_GPIO107>,
+				 <PINMUX_GPIO108__FUNC_GPIO108>,
+				 <PINMUX_GPIO109__FUNC_GPIO109>,
+				 <PINMUX_GPIO110__FUNC_GPIO110>,
+				 <PINMUX_GPIO111__FUNC_GPIO111>,
+				 <PINMUX_GPIO112__FUNC_GPIO112>,
+				 <PINMUX_GPIO113__FUNC_GPIO113>,
+				 <PINMUX_GPIO114__FUNC_GPIO114>,
+				 <PINMUX_GPIO101__FUNC_GPIO101>,
+				 <PINMUX_GPIO100__FUNC_GPIO100>,
+				 <PINMUX_GPIO102__FUNC_GPIO102>,
+				 <PINMUX_GPIO99__FUNC_GPIO99>;
+			drive-strength = <10>;
+			output-low;
+		};
+	};
+
+	dpi_pin_func: dpi-pin-func {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO103__FUNC_DPI_DATA0>,
+				 <PINMUX_GPIO104__FUNC_DPI_DATA1>,
+				 <PINMUX_GPIO105__FUNC_DPI_DATA2>,
+				 <PINMUX_GPIO106__FUNC_DPI_DATA3>,
+				 <PINMUX_GPIO107__FUNC_DPI_DATA4>,
+				 <PINMUX_GPIO108__FUNC_DPI_DATA5>,
+				 <PINMUX_GPIO109__FUNC_DPI_DATA6>,
+				 <PINMUX_GPIO110__FUNC_DPI_DATA7>,
+				 <PINMUX_GPIO111__FUNC_DPI_DATA8>,
+				 <PINMUX_GPIO112__FUNC_DPI_DATA9>,
+				 <PINMUX_GPIO113__FUNC_DPI_DATA10>,
+				 <PINMUX_GPIO114__FUNC_DPI_DATA11>,
+				 <PINMUX_GPIO101__FUNC_DPI_HSYNC>,
+				 <PINMUX_GPIO100__FUNC_DPI_VSYNC>,
+				 <PINMUX_GPIO102__FUNC_DPI_DE>,
+				 <PINMUX_GPIO99__FUNC_DPI_PCLK>;
+			drive-strength = <10>;
+		};
+	};
+
+	en_pp6000_mipi_disp_150ma_fixed_pins: en_pp6000-mipi-disp-150ma-fixed-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO154__FUNC_GPIO154>;
+			output-low;
+		};
+	};
+
+	panel_pins_default: panel-pins-default {
+		pins-en {
+			pinmux = <PINMUX_GPIO98__FUNC_GPIO98>;
+			output-low;
+		};
+	};
+};
+
+&usb_c1 {
+	status = "disabled";
+};
+
+&thermal_zones {
+	tboard1 {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&tboard_thermistor1>;
+	};
+
+	tboard2 {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&tboard_thermistor2>;
+	};
+};
+
+&wifi_pwrseq {
+	reset-gpios = <&pio 51 1>;
+};
+
+/*
+ * Battery on Starmie is using a different address than default.
+ */
+&battery {
+	reg = <0xf>;
+};
-- 
2.47.0.338.g60cca15819-goog


