Return-Path: <linux-kernel+bounces-225717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE97913448
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678561F2337C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533DE16F8F7;
	Sat, 22 Jun 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Caxt9VCv"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43316F29B;
	Sat, 22 Jun 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064288; cv=none; b=cIoJ46CPss6azNgTo5FMUR1X3U3PkMDcyL5yr+r2B0Ml5/QTQAbgtmkeQa8U0o/q0hmUYGlb+QJCsMr/vkx2WLbFl6O885T9fTSFTTYuQAksbnZ5Qo4kh7gPqO1p+Q1lhfGXLG7Yjr2vqPM3OtlOQSoNc0E6bj8B/a8LrQlvwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064288; c=relaxed/simple;
	bh=DeOaZ71UcJNNPeL9Y3wXGVu8Nm3jEi8TGwgWrXCRpgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhqCoeDWByfJjiGUsSqdERi+I4AGYI0akJaaVpmwygLFUWFVVY85qMOujZh1I0/4SUPMM0ahAIyMzpbj3WNNy0S7X3R098MUYewDU1EyPCuOaMQ0QU/e+Pqf0gJ9FnBkk6R8lqDJ1HL5h3JR0LlK7FHSeK6ipzpOyqmueWJUH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Caxt9VCv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fd4d1c173so181028466b.2;
        Sat, 22 Jun 2024 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719064285; x=1719669085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHzl4MwuFngdikQtVMYaHto5rBiRITgYfZqHrowGR9I=;
        b=Caxt9VCvfNcT5lkcLPVdEUOIeIrdK5eDBVmKleO41ndPEl2DMOKmN90Z4/jWMZLFTT
         E2sClfbaM1PYwWA4KZ1K75FpFVju61uXrIGtv7bPa5lsocvcX5C8z+yvmPZT1UZKx9Mj
         DnqIRvHMfXQKprTjXi5yW3KK6zu7JzbtYErupxfrXmRlD9JXc7UG+TND6cw1iCEPgAQt
         4oavydTLAE7YZMudUkB776aqpx42CeS0/glQppVQ32pqRWvqefvnTQ2BMlWolk0K9izi
         2u6zRNjos4e2Djpfew3zti0Yuh4bQd3hsKh/0/v64lYUPb2ft4odyjByBQwbN8GE0b/T
         hz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719064285; x=1719669085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHzl4MwuFngdikQtVMYaHto5rBiRITgYfZqHrowGR9I=;
        b=TgGnElBVoVXat8lVdAeCYhN+zJgEhKrP7TLMCtXLS/lXAcoQnZoSt6CfOdQWwbxW2O
         YkRGHM3ocJlXYwkBYTVBmM2OQxGnDWCK+nSHOoyP/EjYKSyaGtMG2ZwuhvOMe6p1mFaQ
         vT/KhBWQv6wexPOORfbz3XYRmV2JJtEzlWro+fOToEZVZWUyGkP6sZSG8QXxUz0Kn8Tz
         +GfJUWQI/sHupBmjFXUm7zi9iMxY+vjiL7XsWAPixPQjzTlJkyYbxlCnNDRhTd/CSOTJ
         AByooDUbkcohneEeU7TcTLKPw/g6NS6ulrEuGPxfshFgGxKbLW0PX2IIXHiWCQbWC36x
         HWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ67IWT3ZhbTYAw8B8zx6iXHwk0AZfxMZllvDyv/rH6PPya6akWGkSk8I/GXvA3TVRIZVZjlqucGP4tuz3PM5Tm/R6YKmv3+yOaFvtB4OqLkf4qZ5MazGcrngRQRVtsTz5dkDG3o/DmQ==
X-Gm-Message-State: AOJu0YxnMv4NCDMlQHwGg2Qu12z11uevmGrZQoGK9u+dSd+M0tQXwreW
	XUwNW4W5p0NMB9+2Y0yWrC7DeqMccZTfY5ePRgx1FPMwdik5ZR+h
X-Google-Smtp-Source: AGHT+IE+Zxw78stR9QStsQNFVET5Qx3HUyik4804xY/OS9p8eyU8Pg2jp976lY4k7Yxk+SK8FvuIGQ==
X-Received: by 2002:a17:907:c206:b0:a71:ddb0:5206 with SMTP id a640c23a62f3a-a71ddb0527cmr54659066b.60.1719064284789;
        Sat, 22 Jun 2024 06:51:24 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428bc0sm199398866b.8.2024.06.22.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:51:24 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Sam Nazarko <email@samnazarko.co.uk>
Subject: [PATCH v2 2/2] arm64: dts: meson: add support for OSMC Vero 4K
Date: Sat, 22 Jun 2024 13:51:17 +0000
Message-Id: <20240622135117.2608890-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622135117.2608890-1-christianshewitt@gmail.com>
References: <20240622135117.2608890-1-christianshewitt@gmail.com>
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes since v1:
- Move audio clocks under sound node as requested by Neil
- Fix makefile changes
- Rebase against for-next

 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-gxl-s905x-vero4k.dts    | 199 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0746e01b5853..9fe3d6bba9b1 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-vero4k.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxlx-s905l-p271.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-gt1-ultimate.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
new file mode 100644
index 000000000000..de996e930b82
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
@@ -0,0 +1,199 @@
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
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
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


