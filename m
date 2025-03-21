Return-Path: <linux-kernel+bounces-571252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E9A6BAE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE02483805
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5F22B5A8;
	Fri, 21 Mar 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1ezrPSb"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E5229B16;
	Fri, 21 Mar 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560889; cv=none; b=H10X7qhj7dw0UJqFWiCItPTRTJPVbzWEWngqcjufLi1SM7LPBivEVoeUQi/n1pCDabYMtxsyeLCUnHEvGqLac/MeemDG6NC3KAORLBFrfqexGS+TM/vtGNqGceAveIXog9I2UF0YQ/KEkTfsu/314k7bliMPKZBZRdln1vY/jJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560889; c=relaxed/simple;
	bh=0VjnDibpvcIzaGTvd6APDtlB3fBuMRtKgrN9Ps2VbNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHsBDrAkGMlAjVgHKGx9jjpprrfLyD+bgyBpbsEtVKxYw+bZBKwGh9bWOF0WwR8kwSCA4MWdiix6UnGTmQbuNrWXAq7xDGJMthMpixPN4l79R5ZdXoZsSU8+Wcfw2A51TrsrcPdlJL7ILebEk/LOIKmLXAmrlafvNq8Y4WjYC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1ezrPSb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2243803b776so10305015ad.0;
        Fri, 21 Mar 2025 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560886; x=1743165686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgvKZxS/iL7Gs5WdLGCzE1UvdDXISrHu/KLza48BVsw=;
        b=E1ezrPSb+PCQfhqHPKaEyD/z63VwSR/NClakaeJLiOhV6qA8/mUJl4OggTWmTunV95
         qlP6pF2EeEdsokki3glDOYKvRnZlo+GLDKz7eiee+Z05xlxAtl5wAZO454fXDGpzoTrv
         3Aa1wC72pZJTeMhtQYLuHeqO1Eh+Sx9vjZX80zpFAZe0ysYE1xL+yGp5a/ZRMkaWYfzM
         0ZDR+buGkwGTc1nWiS3Yk61Ks3g75OqoTkSsbRIYkupnE6TZBxK8Qg4OEDD6hIAKrL68
         d32LBM5l1drPjfXs14CY9EFLPwwWEqOlPF8+e3t3V5GYr8qrc8YLGW6K7laLLqP6zmdo
         FTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560886; x=1743165686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgvKZxS/iL7Gs5WdLGCzE1UvdDXISrHu/KLza48BVsw=;
        b=fnFzTiMyITBhxa6CtxzrDDGexW1Hcb5Kxzj9GqohU+v0SU5Wh24ZpVA4CaEXzPHf+m
         9kzoL/K3DSjQ4sObi7uLYM3roTpKkETK05WiQH8MJ1QuLHOiZstzdWGkgxBVBpHyhavZ
         ZFv+w//Yq2eZ10C70MKPZ8I7SZ8X9JkYkBH4p86OAYKDWCQp9AY4ctP/GMSJyr+6qZMR
         u+I5pFEn2as66G5fEvCwUu808bBTdEBWtyiNaQC8You9TOZ/A4sbpQCnJusKg6myoyMM
         NBZeDF08xssx2DcAhNEtZfeTFDu3AZousrJbEY/7u0ZVnI1tuD7v1gBXeCcCbE5iFm1+
         qtHg==
X-Forwarded-Encrypted: i=1; AJvYcCUYGCSMarY0EB26ZkRlYmR6Vn0wrCbjB9v7TzXnmt3Cyk42vYqHQoq0877r+PlQ8DIeWNaWtdu1Kbhq@vger.kernel.org, AJvYcCXfA/dufebppPjfSPDas/zuZGALhsATT5lXdYTxyTvT4a5D0riAGQfQ7vFu7Ou7O4q0CxsoFk7oJZEj7sez@vger.kernel.org
X-Gm-Message-State: AOJu0YzlY//G/QN0hwKS5jVYh0Mlbkx5+PYWyFmKNQvGZwO8yyuYVn0T
	oe2Fbhw+ni94Zb3RMqBEm0yjL1c5uFOMpdofwl2GHUNxYPDgUsAE
X-Gm-Gg: ASbGncuBwcKdzPOZjO7ffdXQMQ3IeKhHw0IzgcWpVD09VR7vx7DJK7aFhV89spv5/pK
	S36G6MaStK5F/0DBQJ/tKNfz7N3EvMgx2GrplHrwDf78mDX26JMGjRbikNgqtkkf3Zwaz4cMDKG
	CbAYbSC6c+8npDqhvPajZGSyg2w1ZFY2ae3/F3/JbVd69JVdBb+AKlgER1JZo8DKb+9gjdSsNCN
	LzLZM2k2N51rqiq2pQfpB2GGLT4fxrI+c7cMW/sdl/AToN84uVNa68736GdWmSsRtnEWUkpVOXD
	jlUA3DzT1+9eP/3MWHtkK+/n+d0gf6OGjhcQ9ciHb72jhfC+ApnrS3t3ET9ybcuzypp1wN5npUD
	J6sKzST3ANgqIHwmRjz4qWQKiElpgYk4759dq0+QEWT9tS+vMsDTqrEWRG2k=
X-Google-Smtp-Source: AGHT+IFORU3hqDyThQmQ0DwrKZzMmdcxGkxh2ICCTjuwMDcC+120tA09FRNWESnhKXDklY+eEIxqcA==
X-Received: by 2002:a17:903:19e6:b0:224:910:23f0 with SMTP id d9443c01a7336-22780e1a84amr55510565ad.49.1742560885641;
        Fri, 21 Mar 2025 05:41:25 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c90sm1815432b3a.51.2025.03.21.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:25 -0700 (PDT)
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
Subject: [PATCH v6 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Date: Fri, 21 Mar 2025 20:37:31 +0800
Message-Id: <20250321123731.1373596-3-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321123731.1373596-1-jason-hsu@quantatw.com>
References: <20250321123731.1373596-1-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree related to Meta(Facebook) Ventura specific devices connected to BMC(AST2600) SoC.
Add subject prefix for the patch.

Signed-off-by: Jason Hsu <jason-hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1399 +++++++++++++++++
 2 files changed, 1400 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 2e5f4833a073..e07666d902fb 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-ventura.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
 	aspeed-bmc-facebook-wedge400.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
new file mode 100644
index 000000000000..9882a7d154cc
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
@@ -0,0 +1,1399 @@
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
+
+		led-4 {
+			label = "compute1_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g5_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			label = "compute1_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-6 {
+			label = "compute1_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-7 {
+			label = "compute2_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-8 {
+			label = "compute2_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-9 {
+			label = "compute2_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-10 {
+			label = "compute3_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-11 {
+			label = "compute3_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-12 {
+			label = "compute3_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-13 {
+			label = "compute4_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-14 {
+			label = "compute4_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-15 {
+			label = "compute4_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-16 {
+			label = "compute5_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-17 {
+			label = "compute5_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-18 {
+			label = "compute5_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-19 {
+			label = "compute6_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-20 {
+			label = "compute6_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-21 {
+			label = "compute6_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-22 {
+			label = "compute7_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-23 {
+			label = "compute7_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-24 {
+			label = "compute7_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-25 {
+			label = "compute8_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-26 {
+			label = "compute8_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-27 {
+			label = "compute8_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-28 {
+			label = "nvs1_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-29 {
+			label = "nvs1_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-30 {
+			label = "nvs1_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-31 {
+			label = "nvs2_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-32 {
+			label = "nvs2_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-33 {
+			label = "nvs2_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-34 {
+			label = "nvs3_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-35 {
+			label = "nvs3_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-36 {
+			label = "nvs3_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-37 {
+			label = "nvs4_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-38 {
+			label = "nvs4_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-39 {
+			label = "nvs4_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-40 {
+			label = "nvs5_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-41 {
+			label = "nvs5_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-42 {
+			label = "nvs5_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-43 {
+			label = "nvs6_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-44 {
+			label = "nvs6_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-45 {
+			label = "nvs6_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-46 {
+			label = "nvs7_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-47 {
+			label = "nvs7_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-48 {
+			label = "nvs7_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-49 {
+			label = "nvs8_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-50 {
+			label = "nvs8_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-51 {
+			label = "nvs8_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-52 {
+			label = "nvs9_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-53 {
+			label = "nvs9_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-54 {
+			label = "nvs9_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-55 {
+			label = "compute9_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-56 {
+			label = "compute9_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-57 {
+			label = "compute9_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-58 {
+			label = "compute10_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-59 {
+			label = "compute10_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-60 {
+			label = "compute10_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-61 {
+			label = "compute11_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-62 {
+			label = "compute11_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-63 {
+			label = "compute11_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-64 {
+			label = "compute12_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-65 {
+			label = "compute12_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-66 {
+			label = "compute12_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-67 {
+			label = "compute13_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-68 {
+			label = "compute13_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-69 {
+			label = "compute13_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-70 {
+			label = "compute14_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-71 {
+			label = "compute14_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-72 {
+			label = "compute14_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-73 {
+			label = "compute15_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-74 {
+			label = "compute15_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-75 {
+			label = "compute15_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-76 {
+			label = "compute16_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-77 {
+			label = "compute16_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-78 {
+			label = "compute16_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-79 {
+			label = "compute17_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-80 {
+			label = "compute17_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-81 {
+			label = "compute17_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-82 {
+			label = "compute18_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-83 {
+			label = "compute18_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-84 {
+			label = "compute18_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 0 GPIO_ACTIVE_LOW>;
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
+			// Fan Board 0 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			fan_leds_g1_gpio: gpio@21 {
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
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+
+		i2c3mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			// Fan Board 1 FRU
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
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+
+		i2c3mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			hwmon: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				//fan 0 IL
+				fan-0 {
+					pwms = <&hwmon 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				//fan 0 OL
+				fan-1 {
+					pwms = <&hwmon 0 20000>;
+					tach-ch = /bits/ 8 <0x0B>;
+				};
+
+				//fan 1 IL
+				fan-2 {
+					pwms = <&hwmon 4 20000>;
+					tach-ch = /bits/ 8 <0x0A>;
+				};
+
+				//fan 1 OL
+				fan-3 {
+					pwms = <&hwmon 4 20000>;
+					tach-ch = /bits/ 8 <0x0D>;
+				};
+
+				//fan 2 IL
+				fan-4 {
+					pwms = <&hwmon 6 20000>;
+					tach-ch = /bits/ 8 <0x0F>;
+				};
+
+				//fan 2 OL
+				fan-5 {
+					pwms = <&hwmon 6 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				//fan 3 IL
+				fan-6 {
+					pwms = <&hwmon 10 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				//fan 3 OL
+				fan-7 {
+					pwms = <&hwmon 10 20000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+		};
+
+		i2c3mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			// REAR-IO Board FRU
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
+    // VR TEMP U399
+	temperature-sensor@4c {
+		compatible = "ti,tmp75";
+		reg = <0x4c>;
+	};
+    // VR TEMP U397
+	temperature-sensor@4d {
+		compatible = "ti,tmp75";
+		reg = <0x4d>;
+	};
+    // BRICK TEMP U398
+	temperature-sensor@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
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
+	power-monitor@14 {
+		compatible = "infineon,xdp710";
+		reg = <0x14>;
+	};
+
+	power-monitor@44 {
+		compatible = "lltc,ltc4286";
+		reg = <0x44>;
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
+	tray_leds_g1_gpio: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g2_gpio: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g3_gpio: gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g4_gpio: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g5_gpio: gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g6_gpio: gpio@26 {
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
+	/*G0 - G7*/
+	"SMALL_LEAK_COMPUTE_TRAY2_N","",
+	"SMALL_LEAK_COMPUTE_TRAY3_N","",
+	"SMALL_LEAK_COMPUTE_TRAY4_N","",
+	"SMALL_LEAK_COMPUTE_TRAY5_N","",
+	"SMALL_LEAK_COMPUTE_TRAY6_N","",
+	"SMALL_LEAK_COMPUTE_TRAY7_N","",
+	"SMALL_LEAK_COMPUTE_TRAY8_N","",
+	"SMALL_LEAK_NVS_TRAY1_N","",
+	/*H0 - H7*/
+	"SMALL_LEAK_NVS_TRAY2_N","",
+	"SMALL_LEAK_COMPUTE_TRAY11_N","",
+	"SMALL_LEAK_COMPUTE_TRAY12_N","",
+	"SMALL_LEAK_COMPUTE_TRAY13_N","",
+	"SMALL_LEAK_COMPUTE_TRAY14_N","",
+	"SMALL_LEAK_COMPUTE_TRAY15_N","",
+	"SMALL_LEAK_COMPUTE_TRAY16_N","",
+	"SMALL_LEAK_COMPUTE_TRAY17_N","",
+	/*I0 - I7*/
+	"SMALL_LEAK_COMPUTE_TRAY18_N","",
+	"SMALL_LEAK_NVS_TRAY3_N","",
+	"SMALL_LEAK_NVS_TRAY4_N","",
+	"SMALL_LEAK_NVS_TRAY5_N","",
+	"SMALL_LEAK_NVS_TRAY6_N","",
+	"SMALL_LEAK_NVS_TRAY7_N","",
+	"SMALL_LEAK_NVS_TRAY8_N","",
+	"SMALL_LEAK_NVS_TRAY9_N","",
+	/*J0 - J7*/
+	"SMALL_LEAK_COMPUTE_TRAY9_N","",
+	"SMALL_LEAK_COMPUTE_TRAY10_N","",
+	"PWRGD_COMPUTE_TRAY1_N","",
+	"PWRGD_COMPUTE_TRAY2_N","",
+	"PWRGD_COMPUTE_TRAY3_N","",
+	"PWRGD_COMPUTE_TRAY4_N","",
+	"PWRGD_COMPUTE_TRAY5_N","",
+	"PWRGD_COMPUTE_TRAY6_N","",
+	/*K0 - K7*/
+	"PWRGD_COMPUTE_TRAY7_N","",
+	"PWRGD_COMPUTE_TRAY8_N","",
+	"PWRGD_NVS_TRAY1_PWROK_N","",
+	"PWRGD_NVS_TRAY2_PWROK_N","",
+	"PWRGD_COMPUTE_TRAY11_N","",
+	"PWRGD_COMPUTE_TRAY12_N","",
+	"PWRGD_COMPUTE_TRAY13_N","",
+	"PWRGD_COMPUTE_TRAY14_N","",
+	/*L0 - L7*/
+	"PWRGD_COMPUTE_TRAY15_N","",
+	"PWRGD_COMPUTE_TRAY16_N","",
+	"PWRGD_COMPUTE_TRAY17_N","",
+	"PWRGD_COMPUTE_TRAY18_N","",
+	"PWRGD_NVS_TRAY3_PWROK_N","",
+	"PWRGD_NVS_TRAY4_PWROK_N","",
+	"PWRGD_NVS_TRAY5_PWROK_N","",
+	"PWRGD_NVS_TRAY6_PWROK_N","",
+	/*M0 - M7*/
+	"PWRGD_NVS_TRAY7_PWROK_N","",
+	"PWRGD_NVS_TRAY8_PWROK_N","",
+	"PWRGD_NVS_TRAY9_PWROK_N","",
+	"PWRGD_COMPUTE_TRAY9_N","",
+	"PWRGD_COMPUTE_TRAY10_N","",
+	"LEAK_DETECT_COMPUTE_TRAY1_N","",
+	"LEAK_DETECT_COMPUTE_TRAY2_N","",
+	"LEAK_DETECT_COMPUTE_TRAY3_N","",
+	/*N0 - N7*/
+	"LEAK_DETECT_COMPUTE_TRAY4_N","",
+	"LEAK_DETECT_COMPUTE_TRAY5_N","",
+	"LEAK_DETECT_COMPUTE_TRAY6_N","",
+	"LEAK_DETECT_COMPUTE_TRAY7_N","",
+	"LEAK_DETECT_COMPUTE_TRAY8_N","",
+	"LEAK_DETECT_NVS_TRAY1_N","",
+	"LEAK_DETECT_NVS_TRAY2_N","",
+	"LEAK_DETECT_COMPUTE_TRAY11_N","",
+	/*O0 - O7*/
+	"LEAK_DETECT_COMPUTE_TRAY12_N","",
+	"LEAK_DETECT_COMPUTE_TRAY13_N","",
+	"LEAK_DETECT_COMPUTE_TRAY14_N","",
+	"LEAK_DETECT_COMPUTE_TRAY15_N","",
+	"LEAK_DETECT_COMPUTE_TRAY16_N","",
+	"LEAK_DETECT_COMPUTE_TRAY17_N","",
+	"LEAK_DETECT_COMPUTE_TRAY18_N","",
+	"LEAK_DETECT_NVS_TRAY3_N","",
+	/*P0 - P7*/
+	"LEAK_DETECT_NVS_TRAY4_N","",
+	"LEAK_DETECT_NVS_TRAY5_N","",
+	"LEAK_DETECT_NVS_TRAY6_N","",
+	"LEAK_DETECT_NVS_TRAY7_N","",
+	"LEAK_DETECT_NVS_TRAY8_N","",
+	"LEAK_DETECT_NVS_TRAY9_N","",
+	"LEAK_DETECT_COMPUTE_TRAY9_N","",
+	"LEAK_DETECT_COMPUTE_TRAY10_N","";
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


