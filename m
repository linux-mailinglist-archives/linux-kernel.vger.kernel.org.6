Return-Path: <linux-kernel+bounces-204065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012798FE38C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FA6285F62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8F17F4F6;
	Thu,  6 Jun 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abVrr9x/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B017E917;
	Thu,  6 Jun 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667671; cv=none; b=YDpwyqxwVQxpOHx1/QlrBUwzsIOxSSobk0KpmHVsZprpHxW6dGr1L+kB3i/xm9ELuxRYnlRqwlWcZuvM4N3OX3uKmFThVp7dYgCjUTap3V/nB42KkshGvNZdbn5jpeIclSkwe9YYkTAc49Hq3WErkjLvrwBXgoJL2PYteOUMjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667671; c=relaxed/simple;
	bh=l/3/72E49ZUwrIhqeKCY3nzQfHvWIssOCNgujYr8PKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgALr4F4cX/7kmDgTXJYjl4vhEBBD18IBA4CRX90V1484j4Kp2X3zHEZQ0d5CCF8pV7l2TW0udF3zSOjAczihvyrfcRFA8U0/r0Sf4BJKxsZ2dpbfaAEEDCtggmmY04P2y/LAF8+PlFBXumd3in8f8K/sLnIqTYRonO46QqUTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abVrr9x/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52baa9026dcso893876e87.3;
        Thu, 06 Jun 2024 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667667; x=1718272467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whn2w+VTi4qPZ5FGXEXha21o8nVB5Tk2U6db+I1W52s=;
        b=abVrr9x/sRQTjE3mg0l8SXlb2KqmZ1Q6Fin+C+Q9aeDNrNmq0ey+RuD325xBO5XTqn
         4cxyEgCcRh/49R2rynkyMnzPYOHVkgOU4Humb9Dk9CHKDMTss0b/6VJPpqc8Ng9O8/8a
         8RtrdoExE8CuGgIooiygOgPk6Vm3z12F5XH8Vh4laMj0xV6/iiHXPYwPQfvoxOFxgELg
         BzOKiVxoHDOYL0jO5GHBeZE9xOqgOKJ0VpyHpp98u8SLKsbSl5zpruy2/rUCfqVMPD74
         VlIMeD2Bn6HTC3nhgatCazuumQcHje/TUdZzUaQOcuR10RYLpiESMhfyYFaFGqjIoUHw
         RZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667667; x=1718272467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Whn2w+VTi4qPZ5FGXEXha21o8nVB5Tk2U6db+I1W52s=;
        b=bSf2eAV197z+AAfjIg95WLMLv61aRYln/s3hQ07auNi6EBmGte0W2Li7D7Dez53ItH
         VaKX5xa6gCirEbEQXYcUVtvjYts8aSVh2vRBHXpLf1pB1ID+PkdjCT3BB8QaFJ7QpZRb
         1l7lYHD5JlI2Cxw/f2biYbenkIvbhejghcaijNZqzPzcGlkXNnQYGOUSqUaj02zVguoj
         tNF8rW1aoSOBF4p+ITz7vOP95+a7lUuXY/HtgH4PNFD7b9eA0S5G8Nr4JiqgUQlgD/zl
         mKM24dNryLiSGyM6ZLk1Ug623TMkQ/OPz/cnyFbXEhkEyfiutwVZput4aP2hKT8BDYw6
         PuPg==
X-Forwarded-Encrypted: i=1; AJvYcCV6P45q55gmm4o1PSLy3bwbw+lwTeQ8u1ok0It4411t/4KB3uGn6BPnP6aS7JZM2zhgbNEh4JX0ntzFChG0nPJrn0zZ+dMFgGXF6z+UnbaIfocYW1mn18wDPS1Q50jFm6tjtz5U5D40rw==
X-Gm-Message-State: AOJu0YyFYNzOnN68K8biClPn8pInEGBlOoYPFyplTWxKaqUlPpt/fdHJ
	eXErp6/OOCk4KZw7rYScKYvQOfE+IQTlj4/u4xdvcAeUgPN4YwZB
X-Google-Smtp-Source: AGHT+IFZhf67e4fW0zgYeBIiAIwklUJsAE33gFJ9wJ7BeLDDaR/lfu9ABqO+rTIRLE9sjC8E8IyQuA==
X-Received: by 2002:ac2:499d:0:b0:51c:bd90:e60b with SMTP id 2adb3069b0e04-52bab4c854dmr3056595e87.25.1717667667390;
        Thu, 06 Jun 2024 02:54:27 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148ffasm51454325e9.38.2024.06.06.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:54:26 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: add support for OSMC Vero 4K
Date: Thu,  6 Jun 2024 09:54:19 +0000
Message-Id: <20240606095419.3950015-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606095419.3950015-1-christianshewitt@gmail.com>
References: <20240606095419.3950015-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OSMC Vero 4K device is based on the Amlogic S905X (P212)
reference design with the following specifications:

- 2GB DDR4 RAM
- 16GB eMMC
- HDMI 2.1 video
- S/PDIF optical output
- AV output
- 10/100 Ethernet
- AP6255 Wireless (802.11 a/b/g/n/ac, BT 4.2)
- 2x USB 2.0 ports (1x OTG)
- IR receiver (internal)
- IR extender port (external)
- 1x micro SD card slot
- 1x Power LED (red)
- 1x Reset button (in AV jack)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   7 +
 .../dts/amlogic/meson-gxl-s905x-vero4k.dts    | 202 ++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 4addcae2c54e..78941ddd3136 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -55,6 +55,13 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-vero4k-plus.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-vero4k.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
new file mode 100644
index 000000000000..b325cd75a792
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-aiu.h>
+
+/ {
+	compatible = "osmc,vero4k", "amlogic,s905x", "amlogic,meson-gxl";
+	model = "OSMC Vero 4K";
+
+	reserved-memory {
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <20>;
+
+		button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-standby {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+			panic-indicator;
+		};
+	};
+
+	dio2133: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AU2";
+		VCC-supply = <&hdmi_5v>;
+		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+	};
+
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		sound-name-prefix = "DIT";
+	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
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
+		compatible = "amlogic,gx-sound-card";
+		model = "VERO4K";
+		audio-aux-devs = <&dio2133>;
+		audio-widgets = "Line", "Lineout";
+		audio-routing = "AU2 INL", "ACODEC LOLP",
+				"AU2 INR", "ACODEC LORP",
+				"AU2 INL", "ACODEC LOLN",
+				"AU2 INR", "ACODEC LORN",
+				"Lineout", "AU2 OUTL",
+				"Lineout", "AU2 OUTR";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+
+			codec-1 {
+				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+
+		dai-link-5 {
+			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&acodec>;
+			};
+		};
+	};
+};
+
+&acodec {
+	AVDD-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
+};
+
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&ethmac {
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&internal_phy {
+	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names = "default";
+};
+
+/* This UART is brought out to the DB9 connector */
+&uart_AO {
+	status = "okay";
+};
-- 
2.34.1


