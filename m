Return-Path: <linux-kernel+bounces-225721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A806913458
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB501C21940
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5B16FF33;
	Sat, 22 Jun 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAhD1EuI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CA16F90F;
	Sat, 22 Jun 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064885; cv=none; b=pPhHAOqxPE2a7lyFEF/jA1HrVAvkBpQ34WyYCWHUfZXEI9Q/rSMvC9zPKNXcoBQAyNrN731H9vuDYCWFsbKQrvK+gv+mpvBnhn0IMU43NNBIZFqjicHT1XlrLYQy0tBUM8LocVoTaLPkSk0JhUkCQTjfIWZCk8gMWAuZzJgYW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064885; c=relaxed/simple;
	bh=q/Zid0560pg4Km6CiMYNtkNW/Kw3jvH9xbM5mFzcmS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpdXfgbtyQCdgOfo2wxb+vN5QkoVBCR9pZO+OeuXmMPeEGQZyqKaaCtWCOHtAcCr0Co1A52F12PrEigHTuPpaUIV4JSJoajaB4b0a0EQDAR8KzxFaknaZ8p8EErfR5q+0nC7XhEH4gnt6JfKcZSa6D4MnJzGZH+a8YB2+V7KAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAhD1EuI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso316161566b.0;
        Sat, 22 Jun 2024 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719064882; x=1719669682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLvV2VTWAcjodNcp3MfviP3sDUHSwc6DqDjb10RCEHs=;
        b=AAhD1EuInFDzbD0ZnU80KAhpPDxwqcNyhwu6MaAOCv0yUp1En+QTOQc4ur2sFZz3ig
         eB4ekYI+vq9nu0LEWDMKqwV+dweSUV8ztlfzt1Qho02uU3X2amjCdCAF5T/vL1mr4xGy
         I7UyaeqTKl6jc190GaigRSUJ35Y2QCDdLCgYY45BWlgDW1+pk8uiLfdC4+BPZsP535KP
         JGsjKn9yE6ARMK6yUftEAdHOCIrs6DDL2RPBzm3XvgYB04mQ3GDa0Pp4j4THwNTThECT
         rm6Q3wRXlk5k+dcXMeS2ZHFs0k2yHNUQgtYv5lA7aHt2M/54ERY0LUoujFKipRgCgVbY
         mtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719064882; x=1719669682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLvV2VTWAcjodNcp3MfviP3sDUHSwc6DqDjb10RCEHs=;
        b=mFYgl1ina+1cJ1AhMbila0BDZW1+1/xrpCXPoeDXzGhzjUlwkmChymLYrVkXys6ZEZ
         GgFi3WqIM9NK30y/kPZ0sQQI9qv9W628H04LzRHnV3lCsK5zjiJoQOdBiJFmYJf7Vldc
         ZpWPfoCM1v8wAmczh4Uo9QDrgPZQrIDh9S/pZRjkMj1tkc3KyRBi3LwtGDvGJd67mWRq
         SOTxjkIW2vmQTxeYVJOTa1u7TnlBKKpYdMdVChb6wSZvTk6e+hqcGrTQB346xTKX4Csy
         PBZEiA/cjNfiCHLnWhFpDP7NWpk0uFijwp75raqOCdZ32dpE1/VkRQk/KCVm/wUeTrLc
         ScfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs40qo+aw6a25S8BWHDkrp+2mpEKUAh1ZpuwsHjqJ8VivGlr/yb7YMuOqXJevUY2rKDsx/Wg4rYxSqn9f2H29c+cSx+S/mu4DSN2EmC4KUiFJz0Ln1Af3OnqC18QwLEnLegChF+ap/EQ==
X-Gm-Message-State: AOJu0YwDNulQ4E66PJxtsTwUZ0ZH4A+WtT8Vxfn+UIGWH3rSCiQT1cq/
	XLNk0U2hoi0V8wkgT85c5DAi18nJkvKkmDbKOglWjrak24Zos7sH
X-Google-Smtp-Source: AGHT+IGv4yfPRuhrA0FwFK4MSf3NTDGOrmKmbLLSx3sSa73OntyRY6T1rGZN+QhVItLZ2NJhtvKvdw==
X-Received: by 2002:a17:907:c80d:b0:a6f:a756:2e8e with SMTP id a640c23a62f3a-a6fab604e66mr915231566b.14.1719064881876;
        Sat, 22 Jun 2024 07:01:21 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549166sm198715166b.132.2024.06.22.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 07:01:21 -0700 (PDT)
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
	Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: add initial support for Dreambox One/Two
Date: Sat, 22 Jun 2024 14:01:12 +0000
Message-Id: <20240622140112.2609534-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622140112.2609534-1-christianshewitt@gmail.com>
References: <20240622140112.2609534-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dreambox One and Dreambox Two are based on the Amlogic W400 reference
board with an S922X chip and the following specs:

- 2GB DDR3 RAM
- 16GB eMMC
- 10/100/1000 Base-T Ethernet
- AP6356 Wireless (802.11 b/g/n/ac, BT 5.0)
- HDMI 2.1 video
- S/PDIF optical output
- 2x DVB-S2/T2
- Smartcard Reader Slot
- 2x USB 2.0 port (1x micro-USB for service)
- 1x USB 3.0 port
- IR receiver
- 1x Power LED (blue)
- 1x Power button (top)
- 1x Update/Reset button (underside)
- 1x micro SD card slot

Dreambox Two differences:

- 3" Colour LCD display (MIPI-DSI)
- Common Interface Slot

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes since v1:
- Move assigned-clocks under sound node as requested by Neil

 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-g12b-dreambox-one.dts   |  17 ++
 .../dts/amlogic/meson-g12b-dreambox-two.dts   |  20 +++
 .../boot/dts/amlogic/meson-g12b-dreambox.dtsi | 154 ++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0746e01b5853..4addcae2c54e 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3-ts050.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-mnt-reform2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-dreambox-one.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-dreambox-two.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dts
new file mode 100644
index 000000000000..ecfa1c683dde
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-dreambox.dtsi"
+
+/ {
+	compatible = "dream,dreambox-one", "amlogic,s922x", "amlogic,g12b";
+	model = "Dreambox One";
+};
+
+&sd_emmc_a {
+	sd-uhs-sdr12;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dts
new file mode 100644
index 000000000000..df0d71983c3d
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-dreambox.dtsi"
+
+/ {
+	compatible = "dream,dreambox-two", "amlogic,s922x", "amlogic,g12b";
+	model = "Dreambox Two";
+};
+
+&sd_emmc_a {
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
new file mode 100644
index 000000000000..3a24c2411552
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+#include "meson-g12b-w400.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	cvbs-connector {
+		status = "disabled";
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOA_11 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	spdif_dit: audio-codec-1 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "DREAMBOX";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* spdif hdmi or toslink interface */
+		dai-link-4 {
+			sound-dai = <&spdifout_a>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
+			};
+		};
+
+		/* spdif hdmi interface */
+		dai-link-5 {
+			sound-dai = <&spdifout_b>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-6 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&ir {
+	linux,rc-map-name = "rc-dreambox";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddao_1v8>;
+};
+
+&spdifout_a {
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&spdifout_b {
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.34.1


