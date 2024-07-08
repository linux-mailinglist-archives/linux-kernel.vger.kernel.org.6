Return-Path: <linux-kernel+bounces-243884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0D929C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA1D1F21B00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F014287;
	Mon,  8 Jul 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmL6wzRn"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A571171A1;
	Mon,  8 Jul 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419804; cv=none; b=jysX31H7mMUuVpjACg5JLYYOGR16jLj61ZHLNVRfwHLSyv6CmgL6cpWWyDxrP2aPKL+f8D2wqWkGdJOQr7/TNBQPJN2MLO7G22Uq7HvwxD0fhnugGuYDb4ktqBFMJSRfJKb67hTH9lAnwDpb8EZLGcnzYIlNzI24WcllNSLPNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419804; c=relaxed/simple;
	bh=WVxZillCQ6jr8BYBHqBhU3ypVzXe69HxRSWQ6LKEQGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQblB8h4cr0ew7S6THZTnRbwO7jv/FDHaxCy8jupffvI5nYmUuDtyWLghyBSroZGsRarwFBvGwqFCGbL8Bmz1JGGLyIRXBCpFX6iGiZMXJe5bZKpbfhsiyK48hXlM++bacna6KGBAsamsIaj/m9V5O5bV2sXMIiH1sbaMOHfXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmL6wzRn; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so1469439b3a.0;
        Sun, 07 Jul 2024 23:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720419802; x=1721024602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YO0zfrPvSL57wO7aTnoDlCEfeF4bRbKSvkqnlB1je+4=;
        b=PmL6wzRnFi45xH7T+3Gf2tCJaZPbLUSCJXZU7iBkCPUYRjuINSE9gVFcZOr9XDQmij
         34+RUAkpoO+XNu02RG2E2U+ouUlKl/1eNgTliCgMQx+yC/pXXW3Ig9S4Vxo2LnJ8MXPh
         +ioKXtf9UKzK3L/+wUpabp5iLMEO/nPCd3ZgREbojuN56y/Z+mIObFKQD1OJPivcOamZ
         b7jeUKXGf+x/Yt62VYOYzFht7llQ3xmExwTQtVxj3oBPK7U8kEh4pasaZWXt1Urv4B71
         EED5igM14HB2V05Q20kE40TQA/0IqjXW1HRS2yrkVPCZUldfDKcGMmFNAyET9VVRacIM
         B+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419802; x=1721024602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YO0zfrPvSL57wO7aTnoDlCEfeF4bRbKSvkqnlB1je+4=;
        b=FDMBKbmKBWhqXGjMox40eM2wXhqayoIKAn3o1PdPfUU8E3fTc7vJW3FAsLkVXzHNgy
         ckHiJUyhGX2IrmTC0FCHJITOlBtfpNuwaJfjctwSolTURi5kQcHf60u1RVZ0rNLkBnxm
         DQ1FnKi2hDCcoF9dVq4LsT/HbpDMz6S6CIjfJxc4hd3UEnfzJiRNTjjW5AwGu4H05oIB
         EwZvnEcLj+4ojT4Aye1YzEOvF6TNkdF0Un1/ASmzopBFkmEK15/V3qShXn5MMjAOLi9c
         HlX6eS8haeSwWNvmIgk6aWLRk8sJW73Lbp0hwT9GAl3ZPGsWiL4NRpvzHuknkofM38ht
         D4PA==
X-Forwarded-Encrypted: i=1; AJvYcCV8i2X8bw8yMWpLGvuXQ0O8tcn9KGtLgtf//SnWvqkYi8KOfRT2FY/pu2+CuZme4IzfF/tfF9mpwZNMbaY8bFFjd2jiznf0Uro0CsJO
X-Gm-Message-State: AOJu0YwWelCaqIGYAq4SJX5RiaKlyv4Xn+5a70t+dQVlSPMTdfSntJ2u
	902S5rfqiuLNANKtm4rZVSt95whtk1izjU/lrlGlIvlSYVfdeglY
X-Google-Smtp-Source: AGHT+IG+Bwpg5YQdrUifnm5y/7oVFvEAzv1TzZ5e7XZabJNnV02YUJjVm4wJlN6IfObOMwCt5FITGg==
X-Received: by 2002:a05:6a00:1146:b0:706:936f:469a with SMTP id d2e1a72fcca58-70b00955009mr9599251b3a.16.1720419801896;
        Sun, 07 Jul 2024 23:23:21 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b1b6382c5sm3864126b3a.34.2024.07.07.23.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:23:21 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Subject: [PATCH v2] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC machine
Date: Mon,  8 Jul 2024 14:23:16 +0800
Message-Id: <20240708062316.208383-1-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IEISystems NF5280M7 is an x86 platform server with an
AST2600-based BMC.
This dts file provides a basic configuration for its OpenBMC
development.

Signed-off-by: George Liu <liuxiwei@ieisystem.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-ieisystems-nf5280m7.dts | 697 ++++++++++++++++++
 2 files changed, 698 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 5e3392621697..51531d494415 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
 	aspeed-bmc-ibm-system1.dtb \
+	aspeed-bmc-ieisystems-nf5280m7.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
new file mode 100644
index 000000000000..d706b4f64f6c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
@@ -0,0 +1,697 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2023 IEISystems Corporation
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "NF5280M7 BMC";
+	compatible = "ieisystems,nf5280m7-bmc", "aspeed,ast2600";
+	aliases {
+		i2c200 = &bus2_mux70_0;
+		i2c500 = &bus5_mux00;
+		i2c501 = &bus5_mux01;
+		i2c600 = &i2c6s0ch0;
+		i2c601 = &i2c6s0ch1;
+		i2c602 = &i2c6s0ch2;
+		i2c603 = &i2c6s0ch3;
+		i2c604 = &i2c6s0ch4;
+		i2c605 = &i2c6s0ch5;
+		i2c606 = &i2c6s0ch6;
+		i2c607 = &i2c6s0ch7;
+		i2c610 = &i2c6s1ch0;
+		i2c611 = &i2c6s1ch1;
+		i2c612 = &i2c6s1ch2;
+		i2c613 = &i2c6s1ch3;
+		i2c614 = &i2c6s1ch4;
+		i2c615 = &i2c6s1ch5;
+		i2c616 = &i2c6s1ch6;
+		i2c617 = &i2c6s1ch7;
+		i2c620 = &i2c6s2ch0;
+		i2c621 = &i2c6s2ch1;
+		i2c622 = &i2c6s2ch2;
+		i2c623 = &i2c6s2ch3;
+		i2c624 = &i2c6s2ch4;
+		i2c625 = &i2c6s2ch5;
+		i2c626 = &i2c6s2ch6;
+		i2c627 = &i2c6s2ch7;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		vga_memory: frammebuffer {
+			no-map;
+			reg = <0x9ff00000 0x01000000>; /* 16M */
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+                      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+                      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+                      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		cpld {
+			label = "cpld";
+			gpios = <&gpio0 ASPEED_GPIO(N, 2) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(N, 2)>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fan-fault {
+			label = "fan-fault";
+			gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		system-hot {
+			label = "system-hot";
+			gpios = <&gpio0 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		psu-fault {
+			label = "psu-fault";
+			gpios = <&gpio0 ASPEED_GPIO(B, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		heartbeat {
+			label = "heartbeat";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+		};
+
+		memory-fault {
+			label = "memory-fault";
+			gpios = <&gpio0 ASPEED_GPIO(Y, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		system-fault {
+			label = "system-fault";
+			gpios = <&gpio0 ASPEED_GPIO(Y, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64-alt.dtsi"
+	};
+};
+
+
+&spi1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&peci0 {
+	status = "okay";
+
+	gpios = <&gpio0 ASPEED_GPIO(F, 6) 0>;
+
+	peci-client@30 {
+		compatible = "intel,peci-client";
+		reg = <0x30>;
+	};
+
+	peci-client@31 {
+		compatible = "intel,peci-client";
+		reg = <0x31>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","POWER_OUT","RESET_OUT","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"RESET_BUTTON","","","NMI_BUTTON","NMI_OUT","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","SIO_ONCONTROL","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","SIO_S5","POWER_BUTTON","","PS_PWROK","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","POST_COMPLETE","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xCA2>;
+	status = "okay";
+};
+
+&kcs4 {
+	aspeed,lpc-io-reg = <0xCA4>;
+	status = "okay";
+};
+
+&lpc_snoop {
+	snoop-ports = <0x80>;
+	status = "okay";
+};
+
+&mdio1 {
+	status = "okay";
+
+	ethphy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac2 {
+	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii3_default>;
+};
+
+&mac3 {
+	status = "okay";
+
+	phy-mode = "rmii";
+	use-ncsi;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+};
+
+&adc0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c1 {
+	multi-master;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		bus2_mux70_0:i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp112";
+				reg = <0x49>;
+				label = "Inlet_Temp";
+			};
+
+			temperature-sensor@4c {
+				compatible = "microchip,emc1413";
+				reg = <0x4c>;
+				label = "Outlet_Temp";
+			};
+		};
+	};
+};
+
+&i2c4 {
+	multi-master;
+	status = "okay";
+
+	ipmb0@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c5 {
+	bus-frequency = <1000000>;
+	multi-master;
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		bus5_mux00:i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+		};
+
+		bus5_mux01:i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+		};
+
+		bus5_mux02:i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+		};
+
+		bus5_mux03:i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+		};
+	};
+};
+
+&i2c6 {
+	multi-master;
+	status = "okay";
+
+	i2c-switch@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c6s0ch0:i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+
+			i2c-mux@71 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x71>;
+				i2c-mux-idle-disconnect;
+
+				i2c6s1ch0:i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+				};
+
+				i2c6s1ch1:i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x1>;
+				};
+
+				i2c6s1ch2:i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x2>;
+				};
+
+				i2c6s1ch3:i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x3>;
+				};
+
+				i2c6s1ch4:i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x4>;
+				};
+
+				i2c6s1ch5:i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x5>;
+				};
+
+				i2c6s1ch6:i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x6>;
+				};
+
+				i2c6s1ch7:i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x7>;
+				};
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+
+				i2c6s2ch0:i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+				};
+
+				i2c6s2ch1:i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x1>;
+				};
+
+				i2c6s2ch2:i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x2>;
+				};
+
+				i2c6s2ch3:i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x3>;
+				};
+
+				i2c6s2ch4:i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x4>;
+				};
+
+				i2c6s2ch5:i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x5>;
+				};
+
+				i2c6s2ch6:i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x6>;
+				};
+
+				i2c6s2ch7:i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x7>;
+				};
+			};
+		};
+
+		i2c6s0ch1:i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6s0ch2:i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6s0ch3:i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6s0ch4:i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6s0ch5:i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6s0ch6:i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6s0ch7:i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x7>;
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+&i2c7 {
+	multi-master;
+	#retries = <3>;
+	status = "okay";
+
+	adc@1d {
+		compatible = "ti,adc128d818";
+		reg = <0x1d>;
+		ti,mode = /bits/ 8 <0x01>;
+	};
+
+	adc@1e {
+		compatible = "ti,adc128d818";
+		reg = <0x1e>;
+		ti,mode = /bits/ 8 <0x01>;
+	};
+
+	adc@2d {
+		compatible = "ti,adc128d818";
+		reg = <0x2d>;
+		ti,mode = /bits/ 8 <0x01>;
+	};
+
+	power-monitor@45 {
+		compatible = "ti,ina226";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
+};
+
+&i2c8 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c9 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+
+	pca0:pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"", "", "", "",
+			"", "",
+			"FAN_PRSNT8_D_N", "FAN_PRSNT9_D_N",
+			"", "",	"", "",
+			"", "",	"", "";
+	};
+
+	pca1:pca9555@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "FAN_PRSNT0_D_N", "FAN_PRSNT1_D_N",
+			"FAN_PRSNT2_D_N", "FAN_PRSNT3_D_N",
+			"FAN_PRSNT4_D_N", "FAN_PRSNT5_D_N",
+			"FAN_PRSNT6_D_N", "FAN_PRSNT7_D_N",
+			"", "",	"", "",
+			"", "",	"", "";
+	};
+
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c13 {
+	multi-master;
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vhub {
+	status = "okay";
+};
-- 
2.34.1


