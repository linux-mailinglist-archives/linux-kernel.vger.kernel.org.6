Return-Path: <linux-kernel+bounces-338222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC45985504
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53959B228E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9F215B0FC;
	Wed, 25 Sep 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3c9Ms15d"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C115ADBB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251460; cv=none; b=ikNC9WdTtZr0jiiwFxR86QhJnO+bWZZyFAuZVeToBWA+o8xVe5b05EVfbFsl94+RMuqT7r+lawMFfz/YqTbf+KYjI8CvO8474F8YptIo7kRUi3gT1r6KpsTFlxPIX4FAvjqWa0F20E3SgudoWttaDHXfhP5q2BV0w0q++l/iIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251460; c=relaxed/simple;
	bh=+6w3tvSzwwx/k1D+KLrJO5T+8xmi3bUHdDoZxMWZftc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFvz4KNZN3pY4r1K5lw36efi/2y1V3+i4DD/1996J9qxUEBm+R8XD0uEx7b00Q1Q3RJj8V9Gw4b2tL+AjHNxwVWXKXn7p/U2g8i/EmQ+HJpflLaVS7zcme222pIi9Cm3B3ZS0G3M8DhQFfhS9n+FBvtCxjF4gjGpU8wBBeyMSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3c9Ms15d; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a8a92ab4cdbso453027566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727251456; x=1727856256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAqzgSMA8rpoKVtECfcgOMf5fHf3R893Qz6RTyD6w6c=;
        b=3c9Ms15dir+bkCItdOaqnCN2iXJqJ0iWdCV0m9xHMD/5QUG5myvbCZU2XYyG/6Vf/P
         oS33eLWFe3WwmqC+J1u/GF/ChxlmYLfX+6DXI3DIDd7m7loov4lhmnxeIsbkl9ZfT4uM
         J/Fx3Gf6kA1IupmVVo1p4xuGYAokiOkxyVS7r1Q8aL7l6CS1A39N6aeYhRVZfnqNQDJm
         2O2QgWOvI57Ok6zmrxGz1UNCDrHL//zQxS9A0U+94+gjAqS1BzCv17GpOEyZ5AOahAjv
         pk+nXciroQyODD/aGjPTZfiiQfmGsYoxbOST8RnWnI1W7RgAxO7tt8o9NeGHI0cEM7+Z
         HIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251456; x=1727856256;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XAqzgSMA8rpoKVtECfcgOMf5fHf3R893Qz6RTyD6w6c=;
        b=mHXjnXHoFe/SlHqQ/XqrRba9FotwMP+0tGFX4Rxn5CCoY/eeC5XWc5qGOEmCTpM20x
         u+C0OOHPRCtwfZfj8DNYGDJPsKPoH4geZX98ONd+DSYV6U8BfWyQvoBgz3tYdB0gGh1N
         peoLBTadVUHAFSj8+ZwvvHFsY8GHXmZf9AN7vVTASJAav5UGRHUvG+e6IziWbIOcv+0e
         WtI9WUqDXGvvITfzPGFwidFbjGmfVds7fbXfgM0j+lIlmME7ea5feEyOXRN2BPI/5bU6
         ovxfoTudJ9Cn2kgwptl1W48BcrdHWw9kBAOEUvttyQWXR1Gwgp1U1Uf+Oaa81vZAImZ2
         p3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVos4Tn3UHztYKp6wJScNzJfwilyu+WrNPSpMc99wB6rb7sYfU0PYLAoABnA/2e77PBfNDbu3k6QRbV8d0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ShuJVvTGRRG88oKFDOL19+WSvwk8bhGBWqUAqnVjSqyjp2Ak
	LZO1pz861WPGD7A81LSLRY8CcWgaK82EdPKpLitw/FD7HFoLTfEQmKaVzZfqx2dQsk6oHkrKS9Q
	7kMu+5g==
X-Google-Smtp-Source: AGHT+IEO1EOLJdunVALcFZ0S9FLycG3KG7igE5+tglDI+gxl+nW8v3mBzsPgqp8PmdsFdQasb7Lbo4nn8a4Q
X-Received: from malysz.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:a1e])
 (user=jakiela job=sendgmr) by 2002:a17:906:1c90:b0:a86:6a0b:3f88 with SMTP id
 a640c23a62f3a-a93a05ba9b4mr81966b.8.1727251456241; Wed, 25 Sep 2024 01:04:16
 -0700 (PDT)
Date: Wed, 25 Sep 2024 08:03:53 +0000
In-Reply-To: <20240925080353.2362879-1-jakiela@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925080353.2362879-1-jakiela@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925080353.2362879-2-jakiela@google.com>
Subject: [PATCH 2/2] arm64: dts: mediate: Introduce MT8186 Chinchou/Chinchou360
 Chromebooks
From: "=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	wenst@chromium.org, rafal@milecki.pl, hsinyi@chromium.org, 
	nfraprado@collabora.com, macpaul.lin@mediatek.com, sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	"=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The MT8186 Chinchou/Chinchou360, also known as the Asus Chromebook
CZ12/CZ11 Flip, is a clamshell or convertible device with touchscreen,
stylus and extra buttons.

Signed-off-by: Albert Jakie=C5=82a <jakiela@google.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
 .../mediatek/mt8186-corsola-chinchou-sku1.dts |  34 ++
 .../mt8186-corsola-chinchou-sku16.dts         |  28 ++
 .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 445 ++++++++++++++++++
 5 files changed, 528 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sk=
u0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sk=
u1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sk=
u16.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dt=
si

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/me=
diatek/Makefile
index 8fd7b2bb7a15..0db7770e8907 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -55,6 +55,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-sku3=
2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-chinchou-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-chinchou-sku1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-chinchou-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-magneton-sku393217.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-magneton-sku393218.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts =
b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
new file mode 100644
index 000000000000..29dd92318da1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-chinchou.dtsi"
+
+/ {
+	model =3D "Google chinchou sku0 board";
+	compatible =3D "google,chinchou-sku0", "google,chinchou-sku2",
+			"google,chinchou-sku4", "google,chinchou-sku5",
+			"google,chinchou", "mediatek,mt8186";
+};
+
+&gpio_keys {
+	status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts =
b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
new file mode 100644
index 000000000000..8ba31f81d9ad
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-chinchou.dtsi"
+
+/ {
+	model =3D "Google chinchou sku1/sku17 board";
+	compatible =3D "google,chinchou-sku1", "google,chinchou-sku17",
+			"google,chinchou-sku3", "google,chinchou-sku6",
+			"google,chinchou-sku7", "google,chinchou-sku20",
+			"google,chinchou-sku22", "google,chinchou-sku23",
+			"mediatek,mt8186";
+};
+
+&i2c1 {
+	i2c-scl-internal-delay-ns =3D <10000>;
+
+	touchscreen: touchscreen@41 {
+		compatible =3D "ilitek,ili2901";
+		reg =3D <0x41>;
+		interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&touchscreen_pins>;
+		reset-gpios =3D <&pio 60 GPIO_ACTIVE_LOW>;
+		vccio-supply =3D <&pp1800_tchscr_report_disable>;
+	};
+};
+
+&gpio_keys {
+	status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts=
 b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
new file mode 100644
index 000000000000..d3378d7ad096
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-chinchou.dtsi"
+
+/ {
+	model =3D "Google chinchou sku16/sku2147483647 board";
+	compatible =3D "google,chinchou-sku16", "google,chinchou-sku18",
+			"google,chinchou-sku19", "google,chinchou-sku21",
+			"google,chinchou-sku2147483647", "mediatek,mt8186";
+};
+
+&i2c1 {
+	i2c-scl-internal-delay-ns =3D <10000>;
+
+	touchscreen: touchscreen@41 {
+		compatible =3D "ilitek,ili2901";
+		reg =3D <0x41>;
+		interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&touchscreen_pins>;
+		reset-gpios =3D <&pio 60 GPIO_ACTIVE_LOW>;
+		vccio-supply =3D <&pp1800_tchscr_report_disable>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi b/ar=
ch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
new file mode 100644
index 000000000000..c77cc43f8442
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola.dtsi"
+
+/ {
+	tboard_thermistor1: thermal-sensor1 {
+		compatible =3D "generic-adc-thermal";
+		#thermal-sensor-cells =3D <0>;
+		io-channels =3D <&auxadc 0>;
+		io-channel-names =3D "sensor-channel";
+		temperature-lookup-table =3D <    (-5000) 1491
+						0 1413
+						5000 1324
+						10000 1225
+						15000 1120
+						20000 1012
+						25000 900
+						30000 797
+						35000 698
+						40000 607
+						45000 525
+						50000 451
+						55000 386
+						60000 330
+						65000 282
+						70000 241
+						75000 206
+						80000 176
+						85000 151
+						90000 129
+						95000 111
+						100000 96
+						105000 83
+						110000 72
+						115000 62
+						120000 54
+						125000 47>;
+	};
+
+	tboard_thermistor2: thermal-sensor2 {
+		compatible =3D "generic-adc-thermal";
+		#thermal-sensor-cells =3D <0>;
+		io-channels =3D <&auxadc 1>;
+		io-channel-names =3D "sensor-channel";
+		temperature-lookup-table =3D <    (-5000) 1491
+						0 1413
+						5000 1324
+						10000 1225
+						15000 1120
+						20000 1012
+						25000 900
+						30000 797
+						35000 698
+						40000 607
+						45000 525
+						50000 451
+						55000 386
+						60000 330
+						65000 282
+						70000 241
+						75000 206
+						80000 176
+						85000 151
+						90000 129
+						95000 111
+						100000 96
+						105000 83
+						110000 72
+						115000 62
+						120000 54
+						125000 47>;
+	};
+
+	pp1800_tchscr_report_disable: regulator-pp1800-tchscr-report-disable {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "pp1800_tchscr_report_disable";
+		pinctrl-names =3D "default";
+		enable-active-low;
+		regulator-boot-on;
+		pinctrl-0 =3D <&touch_pin_report>;
+		gpio =3D <&pio 37 GPIO_ACTIVE_LOW>;
+	};
+
+	pp1000_edpbrdg: regulator-pp1000-edpbrdg {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "pp1000_edpbrdg";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&en_pp1000_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio =3D <&pio 29 GPIO_ACTIVE_HIGH>;
+		vin-supply =3D <&pp3300_z2>;
+	};
+
+	pp1800_edpbrdg_dx: regulator-pp1800-edpbrdg-dx {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "pp1800_edpbrdg_dx";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&en_pp1800_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio =3D <&pio 30 GPIO_ACTIVE_HIGH>;
+		vin-supply =3D <&mt6366_vio18_reg>;
+	};
+
+	pp3300_edp_dx: regulator-pp3300-edp-dx {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "pp3300_edp_dx";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&en_pp3300_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio =3D <&pio 31 GPIO_ACTIVE_HIGH>;
+		vin-supply =3D <&pp3300_z2>;
+	};
+};
+
+&rt5682s {
+	status =3D "disabled";
+};
+
+&rt1019p {
+	status =3D "disabled";
+};
+
+&dsi_out {
+	remote-endpoint =3D <&anx7625_in>;
+};
+
+&i2c0 {
+	clock-frequency =3D <400000>;
+
+	anx_bridge: anx7625@58 {
+		compatible =3D "analogix,anx7625";
+		reg =3D <0x58>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&anx7625_pins>;
+		panel_flags =3D <1>;
+		enable-gpios =3D <&pio 96 GPIO_ACTIVE_HIGH>;
+		reset-gpios =3D <&pio 98 GPIO_ACTIVE_HIGH>;
+		vdd10-supply =3D <&pp1000_edpbrdg>;
+		vdd18-supply =3D <&pp1800_edpbrdg_dx>;
+		vdd33-supply =3D <&pp3300_edp_dx>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		analogix,lane0-swing =3D /bits/ 8 <0x70 0x30>;
+		analogix,lane1-swing =3D /bits/ 8 <0x70 0x30>;
+
+		port@0 {
+			reg =3D <0>;
+
+			anx7625_in: endpoint {
+				remote-endpoint =3D <&dsi_out>;
+				data-lanes =3D <0 1 2 3>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+
+			anx7625_out: endpoint {
+				remote-endpoint =3D <&panel_in>;
+			};
+		};
+
+		aux-bus {
+			panel: panel {
+				compatible =3D "edp-panel";
+				power-supply =3D <&pp3300_disp_x>;
+				backlight =3D <&backlight_lcd0>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint =3D <&anx7625_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c2 {
+	trackpad@15 {
+		compatible =3D "hid-over-i2c";
+		post-power-on-delay-ms =3D <10>;
+		hid-descr-addr =3D <0x0001>;
+		vdd-supply =3D <&pp3300_s3>;
+	};
+};
+
+&i2c5 {
+	clock-frequency =3D <400000>;
+
+	rt5650: rt5650@1a {
+		compatible =3D "realtek,rt5650";
+		reg =3D <0x1a>;
+		avdd-supply =3D <&mt6366_vio18_reg>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&rt1019p_pins_default>;
+		cbj-sleeve-gpio =3D <&pio 150 GPIO_ACTIVE_HIGH>;
+		interrupt-parent =3D <&pio>;
+		interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
+		#sound-dai-cells =3D <0>;
+		realtek,dmic1-data-pin =3D <2>;
+		realtek,jd-mode =3D <2>;
+	};
+};
+
+&mmc1_pins_default {
+	pins-clk {
+		drive-strength =3D <MTK_DRIVE_8mA>;
+	};
+
+	pins-cmd-dat {
+		drive-strength =3D <MTK_DRIVE_8mA>;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength =3D <MTK_DRIVE_8mA>;
+	};
+
+	pins-cmd-dat {
+		drive-strength =3D <MTK_DRIVE_8mA>;
+	};
+};
+
+&sound {
+	status =3D "okay";
+
+	compatible =3D "mediatek,mt8186-mt6366-rt5650-sound";
+	mediatek,adsp =3D <&adsp>;
+
+	audio-routing =3D
+		"Headphone", "HPOL",
+		"Headphone", "HPOR",
+		"HDMI1", "TX";
+
+	hs-playback-dai-link {
+		codec {
+			sound-dai =3D <&rt5650>;
+		};
+	};
+
+	hs-capture-dai-link {
+		codec {
+			sound-dai =3D <&rt5650>;
+		};
+	};
+
+	spk-share-dai-link {
+	};
+
+	spk-hdmi-playback-dai-link {
+		codec {
+			sound-dai =3D <&it6505dptx>;
+		};
+	};
+};
+
+&wifi_enable_pin {
+	pins-wifi-enable {
+		pinmux =3D <PINMUX_GPIO51__FUNC_GPIO51>;
+	};
+};
+
+&wifi_pwrseq {
+	reset-gpios =3D <&pio 51 GPIO_ACTIVE_LOW>;
+};
+
+&keyboard_controller {
+	keypad,num-columns =3D <15>;
+
+	function-row-physmap =3D <
+		MATRIX_KEY(0x00, 0x02, 0)        /* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)        /* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)        /* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)        /* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)        /* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)        /* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)        /* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)        /* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)        /* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)        /* T10 */
+		MATRIX_KEY(0x00, 0x01, 0)        /* T11 */
+		MATRIX_KEY(0x01, 0x05, 0)        /* T12 */
+	>;
+
+	linux,keymap =3D <
+		CROS_STD_MAIN_KEYMAP
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)           /* T1 */
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)        /* T2 */
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)           /* T3 */
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)          /* T4 */
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)          /* T5 */
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN) /* T6 */
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)   /* T7 */
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)           /* T8 */
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)	   /* T9 */
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)	   /* T10 */
+		MATRIX_KEY(0x00, 0x01, KEY_MICMUTE)        /* T11 */
+		MATRIX_KEY(0x01, 0x05, KEY_CONTROLPANEL)   /* T12 */
+		MATRIX_KEY(0x03, 0x05, KEY_PREVIOUSSONG)   /* T13 */
+		MATRIX_KEY(0x00, 0x09, KEY_PLAYPAUSE)	   /* T14 */
+		MATRIX_KEY(0x00, 0x0b, KEY_NEXTSONG)	   /* T15 */
+		MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)	   /* Search*/
+		MATRIX_KEY(0x01, 0x0e, KEY_LEFTCTRL)	   /* Left Control*/
+		MATRIX_KEY(0x06, 0x0d, KEY_LEFTALT)        /* Left ALT*/
+		MATRIX_KEY(0x03, 0x0e, KEY_RIGHTCTRL)      /* Right Control*/
+		MATRIX_KEY(0x06, 0x0a, KEY_BACKSLASH)      /* BACKSLASH*/
+	>;
+};
+
+&thermal_zones {
+	cpu-ntc {
+		polling-delay =3D <1000>; /* milliseconds */
+		polling-delay-passive =3D <0>; /* milliseconds */
+		thermal-sensors =3D <&tboard_thermistor1>;
+	};
+
+	pmic-ntc {
+		polling-delay =3D <1000>; /* milliseconds */
+		polling-delay-passive =3D <50>; /* milliseconds */
+		thermal-sensors =3D <&tboard_thermistor2>;
+		sustainable-power =3D <1500>;
+
+		trips {
+			pmic_temp_alert0: trip-point@0 {
+				temperature =3D <50000>;
+				hysteresis =3D <2000>;
+				type =3D "passive";
+			};
+
+			pmic_temp_alert1: target@1 {
+				temperature =3D <60000>;
+				hysteresis =3D <2000>;
+				type =3D "passive";
+			};
+
+			pmic_ntc_crit: pmic-ntc-crit@0 {
+				temperature =3D <80000>;
+				hysteresis =3D <2000>;
+				type =3D "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip =3D <&pmic_temp_alert1>;
+				cooling-device =3D <&cpu0
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>,
+						<&cpu1
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>,
+						<&cpu2
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>,
+						<&cpu3
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>,
+						<&cpu4
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>,
+						<&cpu5
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>;
+				contribution =3D <4096>;
+			};
+
+			map1 {
+				trip =3D <&pmic_temp_alert1>;
+				cooling-device =3D <&cpu6
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>,
+						<&cpu7
+					THERMAL_NO_LIMIT
+					THERMAL_NO_LIMIT>;
+				contribution =3D <1024>;
+			};
+		};
+	};
+};
+
+&pio {
+	touch_pin_report: pin-report {
+		pinmux =3D <PINMUX_GPIO37__FUNC_GPIO37>;
+		output-low;
+	};
+
+	anx7625_pins: anx7625-pins {
+		pins1 {
+			pinmux =3D <PINMUX_GPIO96__FUNC_GPIO96>,
+			<PINMUX_GPIO98__FUNC_GPIO98>;
+			output-low;
+		};
+
+		pins2 {
+			pinmux =3D <PINMUX_GPIO9__FUNC_GPIO9>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
+	en_pp1000_edpbrdg: pp1000-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux =3D <PINMUX_GPIO29__FUNC_GPIO29>;
+			output-low;
+		};
+	};
+
+	en_pp1800_edpbrdg: pp1800-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux =3D <PINMUX_GPIO30__FUNC_GPIO30>;
+			output-low;
+		};
+	};
+
+	en_pp3300_edpbrdg: pp3300-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux =3D <PINMUX_GPIO31__FUNC_GPIO31>;
+			output-low;
+		};
+	};
+};
+
+&i2c_tunnel {
+	/delete-node/ sbs-battery@b;
+
+	battery: sbs-battery@f {
+		compatible =3D "sbs,sbs-battery";
+		reg =3D <0xf>;
+		sbs,i2c-retry-count =3D <2>;
+		sbs,poll-retry-count =3D <1>;
+	};
+};
+
+&pen_insert {
+	wakeup-event-action =3D <EV_ACT_ANY>;
+};
--=20
2.46.0.792.g87dc391469-goog


