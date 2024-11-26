Return-Path: <linux-kernel+bounces-422227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3DD9D9621
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD4B2970A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2C1CEAC9;
	Tue, 26 Nov 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCkOvzM3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091A1CEAC7;
	Tue, 26 Nov 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620039; cv=none; b=WwKSHi3xzBKVblQGpTWOGT09XXk+NrqgZydwtw38b46WK7vU8beWnM4yPGvpWoo1oZsksYdlcBxNmLmf6bBguEW9RJIvaQQKWDMqz+E3kD6DaGC6LheMKM7CXAWT7SMHr6f+mHK1JabYQL8o3m5n2Sc8L9jbNXMJni2A+LMqLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620039; c=relaxed/simple;
	bh=qc3h0NZAgfLsmwZXHLeaLN0ZEGZgh5z8OcNgKcZ3cE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/Oh56/NY1fXSeM0E2cVLL7TJ59r1xt7Vk6Nf53ZfPWM393cv9KyJ93f6LDBsh26XpsBMZzD48accanZLQzv9mAwNRfF7qbkx7H87iFPTbysD9gJF6rEoewH1MKUr0X6OHP7/cGEwgHVxDzfeH9vfK6VyeaucYt7mjnXNcY/SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCkOvzM3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21290973bcbso52459715ad.3;
        Tue, 26 Nov 2024 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732620036; x=1733224836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8KebjQzXN0pHIHcYjpSIZ/4xQKFPyB0Q8Ar3bJiuQA=;
        b=NCkOvzM3XzvJT7QLKE1Uo0xPtLOiSOvr+xGbprt0hUzQ/K8eBsyz+OvFgi2sUliuuO
         fHvFQ5HkHPvoiTfpX4D96Zt99aBZlnQd5zAMxp13sHYGzHMQlKegqLOcma0I28ODcnoG
         YesWVn36WNVmr/ud6Ta+dHcK9j9LVIIexJLxJBU26Vq6+oFg7ZN+d3qC7ntsJ2j9CPGq
         dmwjO4WDAfkahAUKSOKksTjwMysh9ya4+QHtrX0BHYU28z9cua2Dd1E9FpS91B/UcknJ
         PBObgcARZbpbg4R6sTXuZ2sgyVDhOoloAvw9lzDqpR1lkga5xS+jw8GKvTaaHDCmyLaU
         0o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732620036; x=1733224836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8KebjQzXN0pHIHcYjpSIZ/4xQKFPyB0Q8Ar3bJiuQA=;
        b=iGg7igzksnNvyh0KaNHkvn3sY1IV/3cF6xN8+yJ+A58E3buMejGo3m1zwUkOa8qXDF
         8vphQBi8qZaKL1qKRcrTcwyyzkSZbP2MYckp6n2XpnyIUWcDxpxmt2vROE6QuPpXfU5R
         bAO3RZRDRktgPSQ8a8H8aOPVbeIKQKaGk7r+DhGsFKMme2iBjXYTXXEJ7ovikoJ4GcQr
         SCEDsdz+K5BObBa15z854I873w5IjR71+kBa2ILoJZvUQAj06yMehoCLI8o4x0yW2NS/
         51scJQFU0iVDwWTCLSsgqOj6SxbpooytTxOh256AQy740EozBDTEZu7fqS0Gb96c80Ya
         1bow==
X-Forwarded-Encrypted: i=1; AJvYcCX6q7fo10gUDM1WRz0vIVfkJAICVaPdS+8bYi/hnCudHLVGfs72IKSeifcedwPJGtavbc6LvLqQr8fVFJi4@vger.kernel.org, AJvYcCXIN4FISSo/gy/3rbQdVveLCpaISFRSHi02hfqCAjY66QG2h2j5L99XXbYBwCWT8oy/ho1GJlJOIrq6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+36DPKMxtmw2A1o98IeT8aRXIJCSdWTrG8ZezQeOhbO33c/sv
	YZKfJey4n8xFtlBR9DIs0RbctZy7IFK/xd/DfNHpMgHTdazxD7kO
X-Gm-Gg: ASbGncsuj4kg6bqpflCGUpKYzIfjtxR/jw413v8cSe5jXYzYNyh0aIqSIO+2KRkSZHE
	EXfWi2B6URlmo9HMUiKMCG1RlcuCeZgWsKMkdZjxZxt2JjFahYP5D47D3+0giN0gmzwENoGkWgt
	3O2xtqETxhNM1eQ09Scsf4icUY2fy4VP4iqOlVVtcVO8Zo0SYzwP6RYag7mZFGGlVw9fNdqfuKm
	4njDwb4PB+lyphqVeUx3T0ilED2toXbqs4a71ANcVjlvAV1QwLRZoYY7Aspe3ToolRE+P0vXIsj
	YKWB/G7s79Na1gmyU4igFFZhfHgZYARh7it63IJ+k1go6q/1xlLdBlNmQyjno+e1
X-Google-Smtp-Source: AGHT+IHZfi0v5VN5jc+BrL3o5zGYtsYoYp3UZSvBAR251vMjzE2yXphNIsEc/kWPoO30t3RIcAnZvg==
X-Received: by 2002:a17:902:d50f:b0:212:4ac2:4919 with SMTP id d9443c01a7336-2129f532a71mr202278515ad.17.1732620035852;
        Tue, 26 Nov 2024 03:20:35 -0800 (PST)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5d4bsm82210885ad.80.2024.11.26.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:20:35 -0800 (PST)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
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
	Jason Hsu <jason-hsu@quantatw.com>
Subject: [PATCH v4 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Date: Tue, 26 Nov 2024 19:18:17 +0800
Message-Id: <20241126111817.2331577-3-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126111817.2331577-1-jason-hsu@quantatw.com>
References: <20241126111817.2331577-1-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree related to Meta(Facebook) Ventura specific devices connected to BMC(AST2600) SoC.
Add subject prefix for the patch.
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 883 ++++++++++++++++++
 2 files changed, 884 insertions(+)
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
index 000000000000..683995d10dc1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
@@ -0,0 +1,883 @@
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
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 2>;
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
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
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"BATTERY_DETECT","","","BMC_READY","","","","",
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
-- 
2.34.1


