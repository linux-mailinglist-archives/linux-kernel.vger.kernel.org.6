Return-Path: <linux-kernel+bounces-375455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D19A962B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2311F21DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A9136330;
	Tue, 22 Oct 2024 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrSp+U9C"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A585C5E;
	Tue, 22 Oct 2024 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563572; cv=none; b=JG7W0WOgvOPJ3DhZrI1Omiwa0sNCs1Bv1wQM93zgO5Jtjju2KHWZFYFXIxwOcAE8YeBwuQbbnWv6TqudD/QoP6nlUUsWAvdTBNIf7o100hqNPUOBTXIPjTnwVh016gU/5MAbJsQt5HvyOHB3jjM59KywMyer+P/lf9Myix6xIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563572; c=relaxed/simple;
	bh=/FK8VWVUSBaNKXV7/r7Vo2eZwEwHXaxHiNXhon2JzQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JT1UYbB8lHrkPZxXZlPNSrL7dGqhclL2gCOmJZDtk0oyyy14rl5se1BDvUqwARYSYoF2n/kDdLqWDWbvjwxdjBMfDOLOaxjryAfBMxXRHoTPS/T0I+3obbnfzDTEkAUpapzf4oYYfSLhVMPC9Aj++oGBA6YfgeZx6YM7hsBijQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrSp+U9C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e5130832aso3544457b3a.0;
        Mon, 21 Oct 2024 19:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729563570; x=1730168370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4s9p0kyIDzKeex4RBoSuFAMtZz5FWzRSpakW/k2NZ8=;
        b=lrSp+U9CjW1AgkPR8cSuTBttc7VJ5/+8RPKr+i3IUIQI3QbUyvnHqv1So73fAYdF5g
         lqQ4PR6Ratsap+jtatzhqROxAff2RSOXnYK4Ht9I0f+0pFJ6BNx+faS1dn8K8kBRWM90
         KrG45BmYhnjZD4z7u+jeiQcWqPSjIIem7/lMWZWWNNaY1IuWBUe1vxP8rj6mGewp+6Wl
         AOxkJ223z741yBDvSNoZN0JaobQYelrNDiVqHocCtqMzOimTa2+45sKbuZ4kCxNwiiSP
         xGrqQ7UBcSOKJlwUidjHC+tgvZhUWLwCNjbK4OnAdv2atjhnDq0RnOYg9518W+w5N7p0
         seEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563570; x=1730168370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4s9p0kyIDzKeex4RBoSuFAMtZz5FWzRSpakW/k2NZ8=;
        b=C6Fj4srgMgTgtmBJtR1cSCJUL+bVL0Z6XYPcMEfPYnVsH9/fZNrwHOonG7zRvigOum
         xSEhYLPFA9C0JfkA0Ls2W2qJKkzFuU/3kPM8zZJQPFnzYVdwK4xxArnIKiRn99ei1smF
         g/cQlwSEEIu5GqUL6Kt6ONcTR4lcCWor2Toce16zFQr9ZiOqs7Wav5pTpGv24aG50BSg
         YELl6/cmTPVsTg2/Bsm+HPlfwqCGR6uVSs+7Qeg/pxFWlVffFAdDnap0/8HkRMu6iHLc
         fvxIo5dTSNOpcOZs/sb34HmhOJLO1SDcoW4FjLxdSy9/wc7VywkXmWe+S+BfOoqhPLDt
         BFlA==
X-Forwarded-Encrypted: i=1; AJvYcCUPlTfTQFcrLT6a0/HD46qMRtkQZSYsmoqKePWISZGULhFTL0lZ8XgXRpl2cZueodW3umHhEamLGRMbMehr@vger.kernel.org, AJvYcCUvdarL7/dnUHIpxjUnUQqlEZnisq3FLo5MDuADGg9nyR4OSZIBI3Jv7TRuZBNYI34NWpzM+i5ywfu4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7N2mm49LPzBjpfrQwWM33df6boCcOwkXjFPrYSKg3FbXQA51
	hcvMlq1A5ILLjXlzdZTgMZFOg6eZGMyIAkZEQT8jZrrb+FkUQrKc
X-Google-Smtp-Source: AGHT+IFIp3EwTWhKUSyi+rllTgwANBJESrmMFoLlxiL0wG1OaPJVqV0fSIdxm1NozJZm2zSXATaasA==
X-Received: by 2002:a05:6a20:4b30:b0:1d9:3957:8c24 with SMTP id adf61e73a8af0-1d939578c79mr11946499637.21.1729563569807;
        Mon, 21 Oct 2024 19:19:29 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eab57sm3721461b3a.176.2024.10.21.19.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 19:19:29 -0700 (PDT)
From: Jason-Hsu <jasonhell19@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Date: Tue, 22 Oct 2024 10:17:24 +0800
Message-Id: <20241022021724.2322506-1-jasonhell19@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree related to Meta(Facebook) Ventura specific devices connected to BMC(AST2600) SoC.
Add subject prefix for the patch.

Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 884 ++++++++++++++++++
 2 files changed, 885 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index c4f064e4b073..5ed6042eea97 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-ventura.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
 	aspeed-bmc-facebook-wedge400.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
new file mode 100644
index 000000000000..678b9bbf9e63
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
@@ -0,0 +1,884 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2023 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook ventura RMC";
+	compatible = "facebook,ventura-rmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		i2c16 = &i2c3mux0ch3;
+		i2c17 = &i2c3mux0ch4;
+		i2c18 = &i2c3mux0ch5;
+		i2c19 = &i2c3mux0ch6;
+		i2c20 = &i2c3mux0ch0;
+		i2c21 = &i2c3mux0ch1;
+		i2c22 = &i2c3mux0ch2;
+		i2c23 = &i2c3mux0ch7;
+		i2c24 = &i2c0mux0ch0;
+		i2c25 = &i2c0mux0ch1;
+		i2c26 = &i2c0mux0ch2;
+		i2c27 = &i2c0mux0ch3;
+		i2c28 = &i2c0mux0ch4;
+		i2c29 = &i2c0mux0ch5;
+		i2c30 = &i2c0mux0ch6;
+		i2c31 = &i2c0mux0ch7;
+		i2c32 = &i2c1mux0ch0;
+		i2c33 = &i2c1mux0ch1;
+		i2c34 = &i2c1mux0ch2;
+		i2c35 = &i2c1mux0ch3;
+		i2c36 = &i2c1mux0ch4;
+		i2c37 = &i2c1mux0ch5;
+		i2c38 = &i2c1mux0ch6;
+		i2c39 = &i2c1mux0ch7;
+		i2c40 = &i2c2mux0ch0;
+		i2c41 = &i2c2mux0ch1;
+		i2c42 = &i2c2mux0ch2;
+		i2c43 = &i2c2mux0ch3;
+		i2c44 = &i2c2mux0ch4;
+		i2c45 = &i2c2mux0ch5;
+		i2c46 = &i2c2mux0ch6;
+		i2c47 = &i2c2mux0ch7;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 2>;
+	};
+
+    spi1_gpio: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "bmc_ready_noled";
+			default-state = "on";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+
+		led-3 {
+			label = "power_blue";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+    p1v8_bmc_aux: regulator-p1v8-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8_bmc_aux";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	p2v5_bmc_aux: regulator-p2v5-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p2v5_bmc_aux";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mdio0 {
+	status = "okay";
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c0mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c0mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c0mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c0mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c0mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c0mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c0mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c0mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c1mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c1mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c1mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c1mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c1mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c1mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c1mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c1mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c2mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c2mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c2mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c2mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c2mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c2mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c2mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c2mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c3mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c3mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c3mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c3mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+            // Fan Borad 0 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+		};
+
+		i2c3mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+            // Fan Borad 1 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+		};
+
+		i2c3mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pwm@20 {
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@2 {
+					    reg = <2>;
+						sensor-type = "TACH";
+				};
+				channel@5 {
+					    reg = <5>;
+						sensor-type = "TACH";
+				};
+			};
+		};
+
+		i2c3mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+            // REAR-IO Board FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+    // RMC FRU
+	eeprom@54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+    
+    // 88E6393X CONFIG FRU
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+
+    // SCM TEMP SENSOR
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+    // SCM FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+    // BSM FRU EEPROM
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	adc@35 {
+		compatible = "maxim,max11617";
+		reg = <0x35>;
+	};
+
+	power-monitor@40 {
+		compatible = "ti,ina230";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <20000>;	/* 0.02 R */
+	};
+
+	power-sensor@43 {
+		compatible = "ti,ina238";
+		reg = <0x43>;
+		shunt-resistor = <20000>;	/* 0.02 R */
+	};
+
+	power-monitor@44 {
+		compatible = "lltc,ltc4286";
+		reg = <0x44>;
+	};
+
+	power-monitor@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
+
+	power-monitor@69 {
+		compatible = "pmbus";
+		reg = <0x69>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+    // LED Board FRU
+	eeprom@56 {
+		compatible = "atmel,24c128";
+		reg = <0x56>;
+	};
+};
+
+&adc0 {
+	vref-supply = <&p1v8_bmc_aux>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+
+};
+
+&adc1 {
+	vref-supply = <&p2v5_bmc_aux>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
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
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","BMC_READY","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","USBDBG_IPMI_EN_L",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","FM_MDIO_SW_SEL","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+};
+
+&sgpiom0 {
+	gpio-line-names =
+    /*"input pin","output pin"*/
+	/*A0 - A7*/
+	"power-chassis-good","power-chassis-control",
+	"host0-ready","WATER_VALVE_CLOSED_N",
+	"","FM_MDIO_SW_SEL_PLD",
+	"","FM_88E6393X_BIN_UPDATE_EN_N",
+	"","",
+	"","",
+	"","",
+	"","",
+    /*B0 - B7*/
+	"IT_STOP_PUMP_SPARE_2","",
+	"IT_STOP_PUMP_2","",
+	"IT_STOP_PUMP_SPARE","",
+	"IT_STOP_PUMP","",
+	"RPU_2_READY_SPARE_PLD_R","",
+	"RPU_2_READY_PLD_R","",
+	"RPU_READY_SPARE_PLD_R","",
+	"RPU_READY_PLD_R","",
+    /*C0 - C7*/
+	"wAALC_RPU_READY","",
+	"LEAK0_DETECT","",
+	"LEAK1_DETECT","",
+	"LEAK2_DETECT","",
+	"PRSNT_COMPUTE_TRAY1_N","",
+	"PRSNT_COMPUTE_TRAY2_N","",
+	"PRSNT_COMPUTE_TRAY3_N","",
+	"PRSNT_COMPUTE_TRAY4_N","",
+	/*D0 - D7*/
+	"PRSNT_COMPUTE_TRAY5_N","",
+	"PRSNT_COMPUTE_TRAY6_N","",
+	"PRSNT_COMPUTE_TRAY7_N","",
+	"PRSNT_COMPUTE_TRAY8_N","",
+	"PRSNT_NVS_TRAY1_N","",
+	"PRSNT_NVS_TRAY2_N","",
+	"PRSNT_COMPUTE_TRAY11_N","",
+	"PRSNT_COMPUTE_TRAY12_N","",
+	/*E0 - E7*/
+	"PRSNT_COMPUTE_TRAY13_N","",
+	"PRSNT_COMPUTE_TRAY14_N","",
+	"PRSNT_COMPUTE_TRAY15_N","",
+	"PRSNT_COMPUTE_TRAY16_N","",
+	"PRSNT_COMPUTE_TRAY17_N","",
+	"PRSNT_COMPUTE_TRAY18_N","",
+	"PRSNT_NVS_TRAY3_N","",
+	"PRSNT_NVS_TRAY4_N","",
+	/*F0 - F7*/
+	"PRSNT_NVS_TRAY5_N","",
+	"PRSNT_NVS_TRAY6_N","",
+	"PRSNT_NVS_TRAY7_N","",
+	"PRSNT_NVS_TRAY8_N","",
+	"PRSNT_NVS_TRAY9_N","",
+	"PRSNT_COMPUTE_TRAY9_N","",
+	"PRSNT_COMPUTE_TRAY10_N","",
+	"SMALL_LEAK_COMPUTE_TRAY1_N","",
+    /*G0 - G7*/
+    "SMALL_LEAK_COMPUTE_TRAY2_N","",
+    "SMALL_LEAK_COMPUTE_TRAY3_N","",
+    "SMALL_LEAK_COMPUTE_TRAY4_N","",
+    "SMALL_LEAK_COMPUTE_TRAY5_N","",
+    "SMALL_LEAK_COMPUTE_TRAY6_N","",
+    "SMALL_LEAK_COMPUTE_TRAY7_N","",
+    "SMALL_LEAK_COMPUTE_TRAY8_N","",
+    "SMALL_LEAK_NVS_TRAY1_N","",
+    /*H0 - H7*/
+    "SMALL_LEAK_NVS_TRAY2_N","",
+    "SMALL_LEAK_COMPUTE_TRAY11_N","",
+    "SMALL_LEAK_COMPUTE_TRAY12_N","",
+    "SMALL_LEAK_COMPUTE_TRAY13_N","",
+    "SMALL_LEAK_COMPUTE_TRAY14_N","",
+    "SMALL_LEAK_COMPUTE_TRAY15_N","",
+    "SMALL_LEAK_COMPUTE_TRAY16_N","",
+    "SMALL_LEAK_COMPUTE_TRAY17_N","",
+    /*I0 - I7*/
+    "SMALL_LEAK_COMPUTE_TRAY18_N","",
+    "SMALL_LEAK_NVS_TRAY3_N","",
+    "SMALL_LEAK_NVS_TRAY4_N","",
+    "SMALL_LEAK_NVS_TRAY5_N","",
+    "SMALL_LEAK_NVS_TRAY6_N","",
+    "SMALL_LEAK_NVS_TRAY7_N","",
+    "SMALL_LEAK_NVS_TRAY8_N","",
+    "SMALL_LEAK_NVS_TRAY9_N","",
+    /*J0 - J7*/
+    "SMALL_LEAK_COMPUTE_TRAY9_N","",
+    "SMALL_LEAK_COMPUTE_TRAY10_N","",
+    "PWRGD_COMPUTE_TRAY1_N","",
+    "PWRGD_COMPUTE_TRAY2_N","",
+    "PWRGD_COMPUTE_TRAY3_N","",
+    "PWRGD_COMPUTE_TRAY4_N","",
+    "PWRGD_COMPUTE_TRAY5_N","",
+    "PWRGD_COMPUTE_TRAY6_N","",
+    /*K0 - K7*/
+    "PWRGD_COMPUTE_TRAY7_N","",
+    "PWRGD_COMPUTE_TRAY8_N","",
+    "PWRGD_NVS_TRAY1_PWROK_N","",
+    "PWRGD_NVS_TRAY2_PWROK_N","",
+    "PWRGD_COMPUTE_TRAY11_N","",
+    "PWRGD_COMPUTE_TRAY12_N","",
+    "PWRGD_COMPUTE_TRAY13_N","",
+    "PWRGD_COMPUTE_TRAY14_N","",
+    /*L0 - L7*/
+    "PWRGD_COMPUTE_TRAY15_N","",
+    "PWRGD_COMPUTE_TRAY16_N","",
+    "PWRGD_COMPUTE_TRAY17_N","",
+    "PWRGD_COMPUTE_TRAY18_N","",
+    "PWRGD_NVS_TRAY3_PWROK_N","",
+    "PWRGD_NVS_TRAY4_PWROK_N","",
+    "PWRGD_NVS_TRAY5_PWROK_N","",
+    "PWRGD_NVS_TRAY6_PWROK_N","",
+    /*M0 - M7*/
+    "PWRGD_NVS_TRAY7_PWROK_N","",
+    "PWRGD_NVS_TRAY8_PWROK_N","",
+    "PWRGD_NVS_TRAY9_PWROK_N","",
+    "PWRGD_COMPUTE_TRAY9_N","",
+    "PWRGD_COMPUTE_TRAY10_N","",
+    "LEAK_DETECT_COMPUTE_TRAY1_N","",
+    "LEAK_DETECT_COMPUTE_TRAY2_N","",
+    "LEAK_DETECT_COMPUTE_TRAY3_N","",
+    /*N0 - N7*/
+    "LEAK_DETECT_COMPUTE_TRAY4_N","",
+    "LEAK_DETECT_COMPUTE_TRAY5_N","",
+    "LEAK_DETECT_COMPUTE_TRAY6_N","",
+    "LEAK_DETECT_COMPUTE_TRAY7_N","",
+    "LEAK_DETECT_COMPUTE_TRAY8_N","",
+    "LEAK_DETECT_NVS_TRAY1_N","",
+    "LEAK_DETECT_NVS_TRAY2_N","",
+    "LEAK_DETECT_COMPUTE_TRAY11_N","",
+    /*O0 - O7*/
+    "LEAK_DETECT_COMPUTE_TRAY12_N","",
+    "LEAK_DETECT_COMPUTE_TRAY13_N","",
+    "LEAK_DETECT_COMPUTE_TRAY14_N","",
+    "LEAK_DETECT_COMPUTE_TRAY15_N","",
+    "LEAK_DETECT_COMPUTE_TRAY16_N","",
+    "LEAK_DETECT_COMPUTE_TRAY17_N","",
+    "LEAK_DETECT_COMPUTE_TRAY18_N","",
+    "LEAK_DETECT_NVS_TRAY3_N","",
+    /*P0 - P7*/
+    "LEAK_DETECT_NVS_TRAY4_N","",
+    "LEAK_DETECT_NVS_TRAY5_N","",
+    "LEAK_DETECT_NVS_TRAY6_N","",
+    "LEAK_DETECT_NVS_TRAY7_N","",
+    "LEAK_DETECT_NVS_TRAY8_N","",
+    "LEAK_DETECT_NVS_TRAY9_N","",
+    "LEAK_DETECT_COMPUTE_TRAY9_N","",
+    "LEAK_DETECT_COMPUTE_TRAY10_N","";
+};
+
-- 
2.34.1


