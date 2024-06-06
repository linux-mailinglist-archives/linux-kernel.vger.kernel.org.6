Return-Path: <linux-kernel+bounces-204045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39A8FE371
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23984B2C894
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F9178CC1;
	Thu,  6 Jun 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGkf5k3H"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730E179641;
	Thu,  6 Jun 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667126; cv=none; b=PdydvD1e033a9a3wFRP1KHpYKHeZXxdnFl5H8pHfDRibZs2CM8A7Puvj/MLJvXH9uyzngGN3kTqOTU+ffMIUVu/T4hF1JDCWL6qVVLJYKc/TJy2n7Tcg2zNHxHiieFxvcSrI+zLVAGoGmQpEdbftLH8OgLg9mIy3dXdR5RX17Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667126; c=relaxed/simple;
	bh=9YWkUafNkD0rY89sJhO228R580JxW2dZEwNEksUJFyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaXTSJO/hcp7aQHXlQkhKXoTlJ0fQ6YSW6NCbgGKW4NZuyOVrmN7pIVncK9udS5ZsEySA93tRlJWa4zzd5SIese8z7W7hYYgDqvFTtjJVzUJ79QCPuLlheBmlLejhjOQXig4qHZso7LCOpiM1hoAYFlvqEg6eqNSMpzbtSi6Vd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGkf5k3H; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so357279f8f.0;
        Thu, 06 Jun 2024 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667123; x=1718271923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPZxqd+HK9QCwefzujyEZ7YJtOnYuNMu/PxrY/D/zOs=;
        b=UGkf5k3HqGGrGSrj36IfaEUdj/uEAMXfedqOVqvJORrlKJVfAJRIdhGZrFoeTFoaA4
         GvEydFLc+l/ClQmnqRf6xcMRgPjxTmkCRv4Vg+Wmyx6yo1173dI8MyGVE5fJ3C2sz9vU
         mgYcrgA/RIj8qiS+a44qO/IH/vNtwz6kvksH7RoUvPcBc1kdl/UWTy2PVKhpXJd5KAud
         g4gCVLnzHuk4aRolxqiW0DrY3czZ+htA2tJe8IlVbB7WI0i3jTGTfs9S09vW4gNor+BU
         M23A/LLD1f0RKv8lWE7teVGP0jh03Az9MOKK3ratZ6+EwpoM4Kjf15996WXn48fHgMtg
         euvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667123; x=1718271923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPZxqd+HK9QCwefzujyEZ7YJtOnYuNMu/PxrY/D/zOs=;
        b=DV9CpNK8uURJMFaLWf8+jz3yEE7VMLTJ30263aaZpG15rwdnLCLueC7CZ6b84XXKRW
         Hk+jGkQvwNd6nUktbkdvqMAGpasL0smDhYCC88hqaskEPYPo0MJKD8T1m8pERhufX2i2
         KEVvQ0TBeNp4aur81+j7Oa9bYkMpDUY6EkQAPfJozPIZ9vIyD35w4PTaVUXHKnLt3oO+
         4oU4E9mZKD66xLRCU/GAc0BsMExWbcqaS6TE7rYFd/D4dzj8hXcrohSzN54WTdWerk2S
         Z7ID8VsGi1HTodL0UmmOr0y3hlokljnQl7OiGCf4Tx8mRyoj3wKSPlS0hKYYTS4sWvaM
         jrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL9R7hYIQMg8SpoSGwZiAyTr0Jx3ebUbYstKN13X7JCspRWWPLXhjhyXs1wpEnE+azMTN0OLA0WYVmU20pdr6hTgpJTk63SvEk32F54EoH5MCoutxk5Qu7zELC9nupHvLZUsTNombhbA==
X-Gm-Message-State: AOJu0YyoUJa7/0AhGXsYtvEfJEXn4S0PocV3euSUgCbsiA1MEt0you9Q
	7EdA0ORV0yXC9jhi7DBECpsak6LfQf90oKr3jZgmfutpIWRvWr8C
X-Google-Smtp-Source: AGHT+IE2X+VpgV5lHOPi8IXiPFCpUTJ+8Znq4ocgTTnSSZ4q7QaQ6QMoF8m2FysALx1HYwvwnwWNuw==
X-Received: by 2002:a5d:6889:0:b0:356:4cd7:d3ac with SMTP id ffacd0b85a97d-35ef0d80463mr1759717f8f.12.1717667122636;
        Thu, 06 Jun 2024 02:45:22 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d47930sm1094817f8f.29.2024.06.06.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:45:22 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: meson: add initial support for Dreambox One/Two
Date: Thu,  6 Jun 2024 09:45:13 +0000
Message-Id: <20240606094513.3949323-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606094513.3949323-1-christianshewitt@gmail.com>
References: <20240606094513.3949323-1-christianshewitt@gmail.com>
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
---
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-g12b-dreambox-one.dts   |  17 ++
 .../dts/amlogic/meson-g12b-dreambox-two.dts   |  20 +++
 .../boot/dts/amlogic/meson-g12b-dreambox.dtsi | 159 ++++++++++++++++++
 4 files changed, 198 insertions(+)
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
index 000000000000..a302b127f32a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
@@ -0,0 +1,159 @@
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
+&clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
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


