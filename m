Return-Path: <linux-kernel+bounces-259103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB7939139
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B6DB21A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822DC16DC32;
	Mon, 22 Jul 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk5kg51K"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E716DECF;
	Mon, 22 Jul 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660479; cv=none; b=cijz388MFhc1F9j+8MVG9/DDkLmxnMklxvtRkZKhXV5S4B4vnXb7kak48Hnkbr5nn1TlVeJ3BqWH/UiJqM9SGyK5R8JYHtjqZUpxsV9RUERESdZb4lzLKAlmO12xkPeoWtZD9Eaoy4Xm9Zt7Kq3ZavaAdSd5kBCAkOIeaV2wkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660479; c=relaxed/simple;
	bh=dl2NP7Oeuk+ATqw0tBhjVw27AkYibqLYqVmuVNkN4zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ulc2pqF0kPwqLus7nPPHIUZSSJJiH15vHzCGEi/0SD3z/iEExFn+g8u68LQt+v2zWnG7APiRxGo5S19cWgPMEhZ/LkixGc/sjKxiFMDBEVxvICZgZbcJLfS3cqkjKyDNKM/5sgq6Ocu7Ed/AE1myuvt1OiLCZyjEZuP0nZxMTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk5kg51K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so639967a12.1;
        Mon, 22 Jul 2024 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721660476; x=1722265276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgzW+ZtexMR8qL1fX/6ouJFkE25ZmXNYFiWj0B/d80I=;
        b=Mk5kg51Kb2lvkydiU0D3FExOQxwM6u7VNt/fiWU/CtjTC8QGJMfWNZhjdnMeoeplHf
         +LqZYOR2DPCGjtZXEbZXWH4dQBj0TtPgF7sao3bFha8kvmOIA+pDIPP+OGaF4S75XtFd
         pDlhLiL1I38ggngXx6B21un7oyLJIVkU8YJRA/b66XLTApZSFpCP4B5v1aHOGLwXN1eW
         f8akBxad9nYTILm+kmZviQW0SI2LlB2q8IMUpQSutRj2SWX+yorkLsf8mAOE8/YTxozP
         b0eQZAsxutbkvFIG4pm23z+WPG//tmLdPSs8TShyoV1LOn1+cSrv8YaGz4s6S+IefOIm
         xUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660476; x=1722265276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgzW+ZtexMR8qL1fX/6ouJFkE25ZmXNYFiWj0B/d80I=;
        b=XFyBTBti0qaLGPDNFfzgITfUGGUP5j1xJUFjgpZCQxaXh7Kf34ZSLamAwi8mCWzI1Z
         mbtbjiIoTPFPonJxkEKaCpZJtLaaJ+fuOeTmLHHXoLhRfEB1imNo7HaOny32JQW7q79O
         WaRCp5jLdCvpKGq1Q9kR2QQK4lQv2yFDfU+9f6ODNEJBelzvlM6gqQyJB3Ca3JELof+H
         7upZ24y5V9a0qFGLRrNMktcyZHsEogx3V/rcze2BZH6k/hG3C8+uiBbYKfDijceuFJr2
         52Q+V2ANR4R7x0PImri0SmRpTfFGIevdXyiDsn8qtYLebb/kgrjXClOC4MpzaPXkW7Pm
         WuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwiBiGAA6YhWIYqnYPmD20pkRuaCy32/xoK8GfkDdd+dDyVZCuJ3RCPHtn9tLcSmh4N9E8YnD2nbj2F2h/0Gc+/fSZMaVDIMyJxfl4XtgiLpphcMMP7uvD7EfVTCbRPemtcOe54zLG/g==
X-Gm-Message-State: AOJu0YyPQ8b+wXsYMm+LduerezcFCICR1UDV9053r9oOEwpkdZgsdg1l
	vFiCSe5sdVFMwjZMWo/m3U12Vr1HCJiGiBp2HnkGKMf+V4VVq78E
X-Google-Smtp-Source: AGHT+IHsfLNQr3CZZtbF53cwfyQNZFtR18A9G+QwDmiXrk0WhctQEfS2CiXf5FAQDcQkci90ON4tdA==
X-Received: by 2002:a17:90a:66c8:b0:2c2:dee2:ed41 with SMTP id 98e67ed59e1d1-2cd16058619mr4184494a91.19.1721660476154;
        Mon, 22 Jul 2024 08:01:16 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77304a15sm8224207a91.19.2024.07.22.08.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:01:15 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>
Cc: Potin Lai <potin.lai@quantatw.com>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: add Meta Catalina BMC
Date: Mon, 22 Jul 2024 22:58:57 +0800
Message-Id: <20240722145857.2131100-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
References: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Potin Lai <potin.lai@quantatw.com>

Add linux device tree entry for Meta(Facebook) Catalina compute-tray
BMC using AT2600 SoC.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-catalina.dts   | 1032 +++++++++++++++++
 2 files changed, 1033 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 78cbe9504b67e..75559ea6024ab 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
+	aspeed-bmc-facebook-catalina.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fblite-r1.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
new file mode 100644
index 0000000000000..46f751ccdfdaa
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -0,0 +1,1032 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Catalina BMC";
+	compatible = "facebook,catalina-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
+		i2c38 = &imux38;
+		i2c39 = &imux39;
+		i2c40 = &imux40;
+		i2c41 = &imux41;
+		i2c42 = &imux42;
+		i2c43 = &imux43;
+		i2c44 = &imux44;
+		i2c45 = &imux45;
+		i2c46 = &imux46;
+		i2c47 = &imux47;
+		i2c48 = &imux48;
+		i2c49 = &imux49;
+		i2c50 = &imux50;
+		i2c51 = &imux51;
+		i2c52 = &imux52;
+		i2c53 = &imux53;
+		i2c54 = &imux54;
+		i2c55 = &imux55;
+	};
+
+	chosen {
+		bootargs = "console=ttyS4,57600n8";
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
+	spi1_gpio: spi1-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
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
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+
+		led-3 {
+			label = "bmc_ready_cpld_noled";
+			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+	};
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
+&mdio0 {
+	status = "okay";
+};
+
+//&mac0 {
+//	status = "okay";
+//	phy-mode = "rmii";
+//	pinctrl-names = "default";
+//	pinctrl-0 = <&pinctrl_rgmii1_default>;
+//	fixed-link {
+//		speed = <1000>;
+//		full-duplex;
+//	};
+//};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	//pinctrl-0 = <&pinctrl_rmii4_default>;
+	pinctrl-0 = <&pinctrl_ncsi4_default>;
+	use-ncsi;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-package = <1>;
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
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9546";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			// IO Mezz 0 IOEXP
+			pca9535_30_20: pca9535@20 {
+				compatible = "nxp,pca9535";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// IO Mezz 0 FRU EEPROM
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+		imux30: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux31: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9546";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			i2c-mux@70 {
+				compatible = "nxp,pca9548";
+				reg = <0x70>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				imux48: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+				imux49: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+				imux50: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+				imux51: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+				imux52: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+				imux53: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+				imux54: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+				imux55: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+
+					ina230@40 {
+						compatible = "ti,ina230";
+						reg = <0x40>;
+						shunt-resistor = <2000>;
+					};
+					ina230@41 {
+						compatible = "ti,ina230";
+						reg = <0x41>;
+						shunt-resistor = <2000>;
+					};
+					ina230@44 {
+						compatible = "ti,ina230";
+						reg = <0x44>;
+						shunt-resistor = <2000>;
+					};
+					ina230@45 {
+						compatible = "ti,ina230";
+						reg = <0x45>;
+						shunt-resistor = <2000>;
+					};
+				};
+			};
+		};
+		imux34: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux35: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9546";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux36: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux37: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		imux38: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux39: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@76 {
+		compatible = "nxp,pca9546";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux40: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux41: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			// IO Mezz 1 IOEXP
+			pca9535_41_21: pca9535@21 {
+				compatible = "nxp,pca9535";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// IO Mezz 1 FRU EEPROM
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+		imux42: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux43: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux44: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux45: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		imux46: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux47: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <500>;
+			};
+			power-sensor@42 {
+				compatible = "ti,ina238";
+				reg = <0x42>;
+				shunt-resistor = <500>;
+			};
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <500>;
+			};
+		};
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+			};
+			power-sensor@43 {
+				compatible = "ti,ina238";
+				reg = <0x43>;
+			};
+		};
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			pwm@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@2 {
+					reg = <2>;
+					sensor-type = "TACH";
+				};
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
+			};
+			pwm@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@2 {
+					reg = <2>;
+					sensor-type = "TACH";
+				};
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
+			};
+		};
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			vrm@60 {
+				compatible = "isil,raa228004";
+				reg = <0x60>;
+			};
+			vrm@61 {
+				compatible = "isil,raa228004";
+				reg = <0x61>;
+			};
+			vrm@62 {
+				compatible = "isil,raa228004";
+				reg = <0x62>;
+			};
+		};
+		imux20: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+
+			power-monitor@42 {
+				compatible = "lltc,ltc4287";
+				reg = <0x42>;
+				shunt-resistor-micro-ohms = <200>;
+			};
+			power-monitor@43 {
+				compatible = "lltc,ltc4287";
+				reg = <0x43>;
+				shunt-resistor-micro-ohms = <200>;
+			};
+		};
+		imux21: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+
+			// PDB FRU EEPROM
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			// PDB TEMP SENSOR
+			tmp75@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
+		};
+		imux22: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+
+			// PDB IOEXP
+			pca9554_22_27: pca9554@27 {
+				compatible = "nxp,pca9554";
+				reg = <0x27>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// OSFP IOEXP
+			pca9555_22_20: pca9555@25 {
+				compatible = "nxp,pca9555";
+				reg = <0x25>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// OSFP FRU EEPROM
+			eeprom@51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+		imux23: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x7>;
+
+			// FIO FRU EEPROM
+			eeprom@53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+
+			// FIO TEMP SENSOR
+			tmp75@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	// Module 0 IOEXP
+	pca9555_2_20: pca9555@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	// Module 1 IOEXP
+	pca9555_2_21: pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	// HMC IOEXP
+	pca9555_2_27: pca9555@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	// Module 0 EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	// Module 1 EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+
+	// BMC IOEXP on Module 0
+	pca9555_6_21: pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <100000>;
+	multi-master;
+	aspeed,hw-timeout-ms = <1000>;
+
+	//USB Debug Connector
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+
+	// SCM CPLD IOEXP
+	pca9555_9_4f: pca9555@4f {
+		compatible = "nxp,pca9555";
+		reg = <0x4f>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// SCM TEMP SENSOR
+	tmp75@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+	// SCM FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	// BSM FRU EEPROM
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	// OCP NIC0 TEMP
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+
+	// OCP NIC0 FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+		arm-sbmr,skip-bootprogress-response;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	// Module 1 FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+
+	// Module 0 FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	// Left CBC FRU EEPROM
+	eeprom@54 {
+		compatible = "atmel,24c02";
+		reg = <0x54>;
+	};
+
+	// Right CBC FRU EEPROM
+	eeprom@55 {
+		compatible = "atmel,24c02";
+		reg = <0x55>;
+	};
+
+	// HMC FRU EEPROM
+	eeprom@57 {
+		compatible = "atmel,24c02";
+		reg = <0x57>;
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
+	// OCP NIC1 TEMP
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+
+	// OCP NIC1 FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&adc0 {
+	vref = <1800>;
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
+	vref = <2500>;
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
+&pinctrl {
+	pinctrl_ncsi3_default: ncsi3_default {
+		function = "RMII3";
+		groups = "NCSI3";
+	};
+
+	pinctrl_ncsi4_default: ncsi4_default {
+		function = "RMII4";
+		groups = "NCSI4";
+	};
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"BATTERY_DETECT","PRSNT1_HPM_SCM_N",
+			"BMC_I2C1_FPGA_ALERT_L","BMC_READY",
+			"IOEXP_INT_L","FM_ID_LED",
+			"","",
+	/*C0-C7*/	"","","","",
+			"PMBUS_REQ_N","PSU_FW_UPDATE_REQ_N",
+			"","BMC_I2C_SSIF_ALERT_L",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","",
+			"FM_DEBUG_PORT_PRSNT_N","FM_BMC_DBP_PRESENT_N",
+	/*H0-H7*/	"PWR_BRAKE_L","RUN_POWER_EN",
+			"SHDN_FORCE_L","SHDN_REQ_L",
+			"","","","",
+	/*I0-I7*/	"","","","",
+			"","FLASH_WP_STATUS",
+			"FM_PDB_HEALTH_N","RUN_POWER_PG",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"PCIE_EP_RST_EN","BMC_FRU_WP",
+			"SCM_HPM_STBY_RST_N","SCM_HPM_STBY_EN",
+			"STBY_POWER_PG_3V3","TH500_SHDN_OK_L","","",
+	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
+			"LED_POSTCODE_2","LED_POSTCODE_3",
+			"LED_POSTCODE_4","LED_POSTCODE_5",
+			"LED_POSTCODE_6","LED_POSTCODE_7",
+	/*O0-O7*/	"HMC_I2C3_FPGA_ALERT_L","FPGA_READY_HMC",
+			"CHASSIS_AC_LOSS_L","BSM_PRSNT_R_N",
+			"PSU_SMB_ALERT_L","FM_TPM_PRSNT_0_N",
+			"","USBDBG_IPMI_EN_L",
+	/*P0-P7*/	"PWR_BTN_BMC_N","IPEX_CABLE_PRSNT_L",
+			"ID_RST_BTN_BMC_N","RST_BMC_RSTBTN_OUT_N",
+			"host0-ready","BMC_READY_CPLD","","BMC_HEARTBEAT_N",
+	/*Q0-Q7*/	"IRQ_PCH_TPM_SPI_N","USB_OC0_REAR_R_N",
+			"UART_MUX_SEL","I2C_MUX_RESET_L",
+			"RSVD_NV_PLT_DETECT","SPI_TPM_INT_L",
+			"CPU_JTAG_MUX_SELECT","THERM_BB_OVERT_L",
+	/*R0-R7*/	"THERM_BB_WARN_L","SPI_BMC_FPGA_INT_L",
+			"CPU_BOOT_DONE","PMBUS_GNT_L",
+			"CHASSIS_PWR_BRK_L","PCIE_WAKE_L",
+			"PDB_THERM_OVERT_L","HMC_I2C2_FPGA_ALERT_L",
+	/*S0-S7*/	"","","SYS_BMC_PWRBTN_R_N","FM_TPM_PRSNT_1_N",
+			"FM_BMC_DEBUG_SW_N","UID_LED_N",
+			"SYS_FAULT_LED_N","RUN_POWER_FAULT_L",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"L2_RST_REQ_OUT_L","L0L1_RST_REQ_OUT_L",
+			"BMC_ID_BEEP_SEL","BMC_I2C0_FPGA_ALERT_L",
+			"SMB_BMC_TMP_ALERT","PWR_LED_N",
+			"SYS_RST_OUT_L","IRQ_TPM_SPI_N",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","RST_BMC_SELF_HW",
+			"FM_FLASH_LATCH_N","BMC_EMMC_RST_N",
+			"","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&pca9555_2_20 {
+	gpio-line-names =
+		"FPGA_THERM_OVERT_L","FPGA_READY_BMC",
+		"HMC_BMC_DETECT","HMC_PGOOD",
+		"","BMC_SELF_PWR_CYCLE",
+		"FPGA_EROT_FATAL_ERROR_L","WP_HW_EXT_CTRL_L",
+		"EROT_FPGA_RST_L","FPGA_EROT_RECOVERY_L",
+		"BMC_EROT_FPGA_SPI_MUX_SEL","USB2_HUB_RESET_L",
+		"NCSI_CS1_SEL","SGPIO_EN_L",
+		"B2B_IOEXP_INT_L","I2C_BUS_MUX_RESET_L";
+};
+
+&pca9555_2_21 {
+	gpio-line-names =
+		"SEC_FPGA_THERM_OVERT_L","SEC_FPGA_READY_BMC",
+		"","",
+		"","",
+		"SEC_FPGA_EROT_FATAL_ERROR_L","SEC_WP_HW_EXT_CTRL_L",
+		"SEC_EROT_FPGA_RST_L","SEC_FPGA_EROT_RECOVERY_L",
+		"SEC_BMC_EROT_FPGA_SPI_MUX_SEL","",
+		"","",
+		"","SEC_I2C_BUS_MUX_RESET_L";
+};
+
+&pca9555_2_27 {
+	gpio-line-names =
+		"HMC_PRSNT_L","HMC_READY",
+		"HMC_EROT_FATAL_ERROR_L","I2C_MUX_SEL",
+		"HMC_EROT_SPI_MUX_SEL","HMC_EROT_RECOVERY_L",
+		"HMC_EROT_RST_L","GLOBAL_WP_HMC",
+		"FPGA_RST_L","USB2_HUB_RST",
+		"CPU_UART_MUX_SEL","",
+		"","","","";
+};
+
+&pca9555_6_21 {
+	gpio-line-names =
+		"RTC_MUX_SEL","PCI_MUX_SEL","TPM_MUX_SEL","FAN_MUX-SEL",
+		"SGMII_MUX_SEL","DP_MUX_SEL","UPHY3_USB_SEL","NCSI_MUX_SEL",
+		"BMC_PHY_RST","RTC_CLR_L","BMC_12V_CTRL","PS_RUN_IO0_PG",
+		"","","","";
+};
+
+&pca9555_9_4f {
+	gpio-line-names =
+		"stby_power_en_cpld","stby_power_gd_cpld","","",
+		"","","","",
+		"","","","",
+		"","","","";
+};
+
+&pca9554_22_27 {
+	gpio-line-names =
+		"JTAG_MUX_SEL","IOX_BMC_RESET","","",
+		"","","","";
+};
+
+&pca9555_22_20 {
+	gpio-line-names =
+		"OSFP_PHASE_ID0","OSFP_PHASE_ID1",
+		"OSFP_PHASE_ID2","OSFP_PHASE_ID3",
+		"","","","",
+		"OSFP_BOARD_ID0","OSFP_BOARD_ID0",
+		"OSFP_BOARD_ID0","PWRGD_P3V3_N1",
+		"PWRGD_P3V3_N2","","","";
+};
+
+&pca9535_30_20 {
+	gpio-line-names =
+		"RST_CX7_0","RST_CX7_1",
+		"CX0_SSD0_PRSNT_L","CX1_SSD1_PRSNT_L",
+		"CX_BOOT_CMPLT_CX0","CX_BOOT_CMPLT_CX1",
+		"CX_TWARN_CX0_L","CX_TWARN_CX1_L",
+		"CX_OVT_SHDN_CX0","CX_OVT_SHDN_CX1",
+		"FNP_L_CX0","FNP_L_CX1",
+		"","","","";
+};
+
+&pca9535_41_21 {
+	gpio-line-names =
+		"SEC_RST_CX7_0","SEC_RST_CX7_1",
+		"SEC_CX0_SSD0_PRSNT_L","SEC_CX1_SSD1_PRSNT_L",
+		"SEC_CX_BOOT_CMPLT_CX0","SEC_CX_BOOT_CMPLT_CX1",
+		"SEC_CX_TWARN_CX0_L","SEC_CX_TWARN_CX1_L",
+		"SEC_CX_OVT_SHDN_CX0","SEC_CX_OVT_SHDN_CX1",
+		"SEC_FNP_L_CX0","SEC_FNP_L_CX1",
+		"","","","";
+};
-- 
2.31.1


