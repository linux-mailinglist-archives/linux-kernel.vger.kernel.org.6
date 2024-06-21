Return-Path: <linux-kernel+bounces-224785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBFD9126D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157A61F26EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670DDDC4;
	Fri, 21 Jun 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyAJJCwK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3B8820;
	Fri, 21 Jun 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977250; cv=none; b=YHwcfAhHxtWQcPPSrOLs7hdZczPVEcKW5acKnQiCo8RBva2B6Otqp1xTXnMkN2+x8xw6HGt2Mz8D2eTHTLC0bNLyfOztHUg/fe/7dImuoLzbpWpvSi3lGlrnMlhYT1iEnUw4wDAb8x1FqsbaTXGuOOXYrnE/p0EawLGq5dtapIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977250; c=relaxed/simple;
	bh=h+1mAybP/n827/RcjkuNChuTQdFHGDRpvCsfKxhEI3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWtKLgsWUE1xkm03Jf+BMlMfaJQOaqW1YWP8SF7ThWkQkk7p4IrUR+wfXqSsPSmMXenptgO20u34AAkXbNVORPdZtGQECCbBjTtxKTHJ5lJK41Pn30y/vDF+rtFX64JqWR6VfDoVofEuX9FNH+WGEs+kue3qc7zhYHmbexwz2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyAJJCwK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so6372211fa.0;
        Fri, 21 Jun 2024 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718977246; x=1719582046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45m2k/Td35A4EcDtWafXF2gULerKmaqVWvstZyDWUeY=;
        b=JyAJJCwKIjh+Qn+LvOnwmHOr8eduxxq9WAjGu663Bgwysxr/xaENUgeJp6sitk0s8J
         ZaD3+z29Umwha+FQdUuvIp27ysVQ+spAkfqWFSUhXyx30JLc1TzlgnwO303uNIzvKTvC
         pR+7LLJLJWU35wN4l98DlVFvBrxFMXKhAM9S0yNVFeDpWlc+grQdhWPKSs4ri2PlPavc
         d+si0IE02y0aMVfleXyxGL4WGAJhvUlVT5NBSSpo4eQedd0SI/JRTMbwiAbR+oJxW9eM
         AhVwWYxHt0o4RFoYLT9x94MMiO4jI/izryRG/yrmx4tGARKuGkifU8vg0psB1QG29LPY
         P5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977246; x=1719582046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45m2k/Td35A4EcDtWafXF2gULerKmaqVWvstZyDWUeY=;
        b=tGGcdYLNZrFDp24Imm7qdvjAW3W/JbWgEQR3TlKckef5iFymb/zuXWj7rA1Fp+4LBL
         BHdTIcJbYRL/DX9AWmN4b/pCcVuDu88tME56tO7u1XsNkcex6+TtaQhLcPsP5tbvDSlZ
         0CURg1aW/SwdoHd6V8KYYDzG2Ct5mceZd6S6lQ9BPXNPSRTvaCduEbgvI9wzZK+eZAFw
         I83c1Ydbj08pxNsddukZI/KnBEWcs4h0ESZQhctx7ZBDhhdn3ssXQ0cWDcetNWfBKV1f
         VdUeUodS7QYUVciBnbq2ifF1EnHl9qkaXpTCGNeHMVva5YXp6xgfKnWZ5XH8SwVWeQiF
         GVGg==
X-Forwarded-Encrypted: i=1; AJvYcCXKHH+E8/SEMYyBQVyUuTL6eTb3f0Kb45jbaW2hArN9TlvIeb5ng/HEh6d1IMb5AJYrVUFFbcscMLSh78aDgSr+8k2ofVa0mrZwILq/
X-Gm-Message-State: AOJu0Yzc53q6xoxLVH/j5vyqe61qlnW4TPJ6hw3T9Bp7hP6e8pGiQpOn
	0iydZ/a/N+SvWF6MuamktgWdekNAHQN1gt01ma95/GDSYk1GwV4zQv+J
X-Google-Smtp-Source: AGHT+IHPK2UFguMpGh6GwDqI5N9xz0iGPDzfl1kMqBI73mx3lJ7TUM/256TOrKNUuL+FAunRKzy/1A==
X-Received: by 2002:a2e:7019:0:b0:2ec:5128:1850 with SMTP id 38308e7fff4ca-2ec512818b1mr7156451fa.13.1718977235352;
        Fri, 21 Jun 2024 06:40:35 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1b6a:5399:9a4f:7217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562cb6sm962059a12.83.2024.06.21.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:40:35 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 4/4] arm64: dts: rockchip: Add Neardi LBA3368 board
Date: Fri, 21 Jun 2024 15:40:30 +0200
Message-ID: <20240621134030.243646-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621134030.243646-1-knaerzche@gmail.com>
References: <20240621134030.243646-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LBA3368 is a RK3368 based industrial board from Neardi.

Specs:
 - 1 GB DDR3 DRAM
 - 8/16 GB eMMC
 - µSD slot
 - 100 mbit ethernet (optional 12V PoE)
 - Ampak AP6255 Wifi/BT combo
 - ADC button
 - 4 x USB 2.0 via onboard GL852G HUB connected to SoC's ehci host
   - 2 exposed as USB-A
   - 2 via 2-mm-4-pin connectors
 - micro USB OTG connector
 - 2 x UART TTL (2-mm-4-pin connectors)
 - CSI connector
 - DSI connector
 - eDP connector
 - HDMI 2.0a output (type A)
 - touchpad connector (I2C, 3.3V)
 - ALC5640 audio codec
   - combined headphone/microphone jack
   - speaker connector pads

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3368-lba3368.dts      | 666 ++++++++++++++++++
 2 files changed, 667 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 85d949f2c909..90f5172f37e6 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lba3368.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lion-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts b/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
new file mode 100644
index 000000000000..ec7d6e7b2cf5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
@@ -0,0 +1,666 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/clock/rockchip,rk808.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/rt5640.h>
+#include "rk3368.dtsi"
+
+/ {
+	model = "Neardi LBA3368";
+	compatible = "neardi,lba3368", "rockchip,rk3368";
+
+	aliases {
+		ethernet0 = &gmac;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio0;
+		rtc0 = &hym8563;
+		rtc1 = &rk808;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	adc-key {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		poll-interval = <100>;
+		keyup-threshold-microvolt = <1800000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	analog-sound {
+		compatible = "audio-graph-card";
+		dais = <&i2s_8ch_p0>;
+		hp-det-gpio = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
+		label = "alc5640";
+		routing = "Mic Jack", "MICBIAS1",
+			  "IN1P", "Mic Jack",
+			  "Headphone Jack", "HPOL",
+			  "Headphone Jack", "HPOR",
+			  "Speakers", "SPORP",
+			  "Speakers", "SPORN",
+			  "Speakers", "SPOLP",
+			  "Speakers", "SPOLN";
+		widgets = "Microphone", "Mic Jack",
+			  "Headphone", "Headphone Jack",
+			  "Speaker", "Speakers";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_det>;
+	};
+
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	ext_gmac: gmac-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <50000000>;
+		clock-output-names = "ext_gmac";
+		#clock-cells = <0>;
+	};
+
+	hub_avdd: hub-avdd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "hub_avdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+		regulator-always-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power-led {
+			pinctrl-0 = <&power_led>;
+			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "on";
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 RK808_CLKOUT1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_reg_on>;
+	};
+
+	vcc_host: vcc-host-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	vcc_lan: vcc-lan-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_lan";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+		regulator-always-on;
+	};
+
+	vcc_otg: vcc-otg-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd10_usb: vdd10-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd10_usb";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		vin-supply = <&vdd_10>;
+		regulator-always-on;
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&emmc {
+	bus-width = <8>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc_18>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	cap-mmc-highspeed;
+	non-removable;
+	no-sd;
+	no-sdio;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&gmac {
+	clock_in_out = "input";
+	phy-handle = <&phy>;
+	phy-mode = "rmii";
+	phy-supply = <&vcc_lan>;
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rmii_pins>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		phy: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			max-speed = <100>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <1000000>;
+			reset-gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&phy_rst>;
+		};
+	};
+};
+
+&io_domains {
+	audio-supply = <&vcca1v8_codec>;
+	dvp-supply = <&vcc_18>;
+	flash0-supply = <&vcc_18>;
+	gpio30-supply = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vdd1v8_wl>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk808: pmic@1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		interrupts-extended = <&gpio0 RK_PA5 IRQ_TYPE_LEVEL_LOW>;
+		clock-output-names = "rk808-clkout1", "xin32k_wifi_bt";
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
+		vcc8-supply = <&vcc_io>;
+		vcc9-supply = <&vcc_sys>;
+		vcc10-supply = <&vcc_sys>;
+		vcc11-supply = <&vcc_sys>;
+		vcc12-supply = <&vcc_io>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int &pmic_sleep>;
+		system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+
+		regulators {
+			vdd_cpu: DCDC_REG1 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_cpu";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_log: DCDC_REG2 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-ramp-delay = <6001>;
+				regulator-name = "vdd_log";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-suspend-microvolt = <1000000>;
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_io";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-suspend-microvolt = <3300000>;
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcca1v8_codec: LDO_REG1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_codec";
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca3v0_codec: LDO_REG2 {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcca3v0_codec";
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_10: LDO_REG3 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd_10";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-suspend-microvolt = <1000000>;
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd1v8_wl: LDO_REG4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vdd1v8_wl";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vdd10_lcd: LDO_REG6 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd10_lcd";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_18: LDO_REG7 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_18";
+
+				regulator-state-mem {
+					regulator-suspend-microvolt = <1800000>;
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc18_lcd: LDO_REG8 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18_lcd";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_tp: SWITCH_REG1 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_tp";
+
+				regulator-state-mem {
+					regulator-suspend-microvolt = <3300000>;
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_sd: SWITCH_REG2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_sd";
+
+				regulator-state-mem {
+					regulator-suspend-microvolt = <3300000>;
+					regulator-on-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	codec@1c {
+		compatible = "realtek,rt5640";
+		reg = <0x1c>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		realtek,dmic1-data-pin = <RT5640_DMIC1_DATA_PIN_IN1P>;
+		realtek,dmic2-data-pin = <RT5640_DMIC2_DATA_PIN_IN1N>;
+		realtek,in1-differential;
+		#sound-dai-cells = <0>;
+
+		port {
+			rt5640_p0_0: endpoint {
+				remote-endpoint = <&i2s_8ch_p0_0>;
+			};
+		};
+	};
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
+};
+
+&i2s_8ch {
+	status = "okay";
+
+	i2s_8ch_p0: port {
+		i2s_8ch_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&rt5640_p0_0>;
+		};
+	};
+};
+
+&pinctrl {
+
+	bt {
+		bt_host_wake: bt-host-wake {
+			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_reg_on: bt-reg-on {
+			rockchip,pins = <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		bt_wake: bt-wake {
+			rockchip,pins = <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		power_led: power-led {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	phy {
+		phy_rst: phy-rst {
+			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pmic_sleep: pmic-sleep {
+			rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_reg_on: wifi-reg-on {
+			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sound {
+		hp_det: hp-det {
+			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_host_wake: wifi-host-wake {
+			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmu-supply = <&vcc_io>;
+	vop-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_18>;
+	status = "okay";
+};
+
+&sdio0 {
+	bus-width = <4>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	vqmmc-supply = <&vdd1v8_wl>;
+	vmmc-supply = <&vcc_io>;
+	assigned-clocks = <&cru SCLK_SDIO0>;
+	assigned-clock-parents = <&cru PLL_CPLL>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	no-sd;
+	no-mmc;
+	non-removable;
+	sd-uhs-sdr104;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupts-extended = <&gpio3 RK_PA6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake>;
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4 &sdmmc_cd>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <0>;
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&rk808 RK808_CLKOUT1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio3 RK_PA2 GPIO_ACTIVE_HIGH>;
+		max-speed = <1500000>;
+		vbat-supply = <&vcc_io>;
+		vddio-supply = <&vdd1v8_wl>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake &bt_wake &bt_reg_on>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_xfer>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_xfer>;
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub@1 {
+		compatible = "usb5e3,610";
+		reg = <1>;
+		vdd-supply = <&hub_avdd>;
+	};
+};
+
+&usb_otg {
+	vbus-supply = <&vcc_otg>;
+	vusb_a-supply = <&vcc_io>;
+	vusb_d-supply = <&vdd10_usb>;
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.45.2


