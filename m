Return-Path: <linux-kernel+bounces-373801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92939A5CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC88282E82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3014F1DE3AF;
	Mon, 21 Oct 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Nf/Al9bF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5841DDC17
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495658; cv=none; b=X0ozLvqvQmaifIv7fWVocC/d/l0gp18aB+xxQQ8hbeSpgzWIL92Ujb0EqbkboHbg/zetZh8tZhTi/5yBefM8w8SCetHQGLD3Zw255falKnnu+2CJ1PXVIe3knsXRSzr7K2XHn4OCoBBmKaKxV6mV1hy2vTK86tJ991W/37o4fxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495658; c=relaxed/simple;
	bh=jlVPW9urZrR98gmlwfaDkm+8c6S64ZaJbSdI9NthFlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XwtLwmmq3Rljrdb3DIgCG4NrM3RBUot9068nCbOXH+dY77H1dEye+ZEdrKH1mlX/kxGwWFlJsnluI1FD7umLBHdb3YjmoEjBrdq+kp+j1Olbt8nGSTZAYdWjWCYJVcMqn/4hBB4UOJmB2erTsCAZhR8I8f/EPOFhtyYUihTBf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Nf/Al9bF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c83c2e967so2259535ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729495656; x=1730100456; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Js96B82vpvasO7dH54aWNj4yi7wPO0A7/Og4/faXgF0=;
        b=Nf/Al9bFcZBM+8ZCCKHkjxF+pexWGXm2T7aFBfN+RnX8UrOZt8cIxxea5YoxmDGueN
         oR9sJIUjJ+8PPqdNM+3Ggr3H0mRR7ETdLbizrA5vIRD4MUtIATwUNMQ+HFSHrhEsIa+7
         e7njqqpTxMjX3MWT44TVNR1KdlIwRwtdROg+4OWD56b5dTLBEkd3gQvhunNLrt83eQm7
         7YOrLtoratmmw/bUNBndS/kbcHGEXxkOFqTp+UGzXb8ZrtiiXTvLnSLmSG1VbkViFv8f
         7Q1CKikXR4HSjSuf0kYEscAwHhY6VN3kXbBbbcomFlIhc4S65actsx7BNLUGFKt3/vuM
         uaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495656; x=1730100456;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js96B82vpvasO7dH54aWNj4yi7wPO0A7/Og4/faXgF0=;
        b=RLcgm0OQkL03CGZvnsOUusIUzUoId1TR8g4mJu1LnLWGG3vcFreZ1IzsrxUrLyEbiD
         xs4vIrbRqMrK8cQXubfMP7FURoqRfS/Wqrfi2vKnpBNxBd6vtSvwVCnyyZNORK68emzh
         PsmV9XWjrBIu6QUBBVf7WZmifoR+TftNIwFVJk6QM2BRhW5RpdO14tGH1q5+GmNIFEJG
         scDnVAE3Tb6kYFnbNvUqAFoLm7L14V7yi4cmZC9uSul5FnBncqr6M+cRG6iaWaQd8oUA
         12UvXfcjSSjSKnXinEVCvKjA/G1jV7ZQUl+XLhR3d/cOmxKrzied8WPadpwtQY/IPPMO
         Mg/w==
X-Forwarded-Encrypted: i=1; AJvYcCUoC/0Vws8SvWBWbz08Yh+60DabyJqwss6rB5V9Q20i8blBkXnYk9hLHGGbE26/eS3EWd6jiDJP1rxDQBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUX7t6cdZ07sk6H2+wPzqfxf5tMnYLwF0XNfaEXV/NMC66Kpkb
	4jcPV58CJIrDNf+KxWoQtf8X+cBQU9TwF2bDgK0Lj9OLxiFpxfv09xDi960yEkc=
X-Google-Smtp-Source: AGHT+IHjxv29kLHZ8Fo/dsNBkftvA7EEKBCKkpaOY6CKVDCBvDvdsxOkGm7rtczS+9yz4TSx0Tg94Q==
X-Received: by 2002:a17:902:da8f:b0:20c:e0ed:218 with SMTP id d9443c01a7336-20e5a8bd5demr61477435ad.9.1729495655608;
        Mon, 21 Oct 2024 00:27:35 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db2desm19749595ad.203.2024.10.21.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:27:35 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 RESEND 2/4] arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
Date: Mon, 21 Oct 2024 15:26:24 +0800
Message-Id: <20241021072626.15102-3-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

MT8186 chinchou, known as ASUS Chromebook CZ12 Flip (CZ1204F)
and CZ12(CZ1204C), is a MT8186 based laptop.
It is based on the "corsola" design.It includes chinchou and chinchou360,
including LTE, stylus, touchscreen combinations.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
 .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
 .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
 .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
 5 files changed, 406 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..0db7770e8907 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -55,6 +55,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
new file mode 100644
index 000000000000..5d012bc4ff0d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-chinchou.dtsi"
+
+/ {
+	model = "Google chinchou CZ1104CM2A/CZ1204CM2A";
+	compatible = "google,chinchou-sku0", "google,chinchou-sku2",
+			"google,chinchou-sku4", "google,chinchou-sku5",
+			"google,chinchou", "mediatek,mt8186";
+};
+
+&gpio_keys {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
new file mode 100644
index 000000000000..c18f473f6a0f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-chinchou.dtsi"
+
+/ {
+	model = "Google chinchou CZ1104FM2A/CZ1204FM2A/CZ1104CM2A/CZ1204CM2A";
+	compatible = "google,chinchou-sku1", "google,chinchou-sku17",
+			"google,chinchou-sku3", "google,chinchou-sku6",
+			"google,chinchou-sku7", "google,chinchou-sku20",
+			"google,chinchou-sku22", "google,chinchou-sku23",
+			"google,chinchou", "mediatek,mt8186";
+};
+
+&gpio_keys {
+	status = "disabled";
+};
+
+&i2c1 {
+	i2c-scl-internal-delay-ns = <10000>;
+
+	touchscreen: touchscreen@41 {
+		compatible = "ilitek,ili2901";
+		reg = <0x41>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vccio-supply = <&pp1800_tchscr_report_disable>;
+		vcc33-supply = <&pp3300_z2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
new file mode 100644
index 000000000000..eb377de1fcde
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-chinchou.dtsi"
+
+/ {
+	model = "Google chinchou CZ1104FM2A/CZ1204FM2A";
+	compatible = "google,chinchou-sku16", "google,chinchou-sku18",
+			"google,chinchou-sku19", "google,chinchou-sku21",
+			"google,chinchou", "mediatek,mt8186";
+};
+
+&i2c1 {
+	i2c-scl-internal-delay-ns = <10000>;
+
+	touchscreen: touchscreen@41 {
+		compatible = "ilitek,ili2901";
+		reg = <0x41>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vccio-supply = <&pp1800_tchscr_report_disable>;
+		vcc33-supply = <&pp3300_z2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
new file mode 100644
index 000000000000..389f8b66e968
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola.dtsi"
+
+/ {
+	/delete-node/ speaker-codec;
+
+	pp1000_edpbrdg: regulator-pp1000-edpbrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1000_edpbrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp1000_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 29 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	pp1800_edpbrdg_dx: regulator-pp1800-edpbrdg-dx {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_edpbrdg_dx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp1800_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 30 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6366_vio18_reg>;
+	};
+
+	pp3300_edp_dx: regulator-pp3300-edp-dx {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_edp_dx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp3300_edpbrdg>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 31 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	pp1800_tchscr_report_disable: regulator-pp1800-tchscr-report-disable {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_tchscr_report_disable";
+		pinctrl-names = "default";
+		regulator-boot-on;
+		pinctrl-0 = <&touch_pin_report>;
+		gpio = <&pio 37 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&dsi_out {
+	remote-endpoint = <&anx7625_in>;
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+
+	anx_bridge: anx7625@58 {
+		compatible = "analogix,anx7625";
+		reg = <0x58>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&anx7625_pins>;
+		enable-gpios = <&pio 96 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 98 GPIO_ACTIVE_HIGH>;
+		vdd10-supply = <&pp1000_edpbrdg>;
+		vdd18-supply = <&pp1800_edpbrdg_dx>;
+		vdd33-supply = <&pp3300_edp_dx>;
+		analogix,lane0-swing = /bits/ 8 <0x70 0x30>;
+		analogix,lane1-swing = /bits/ 8 <0x70 0x30>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				anx7625_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+					data-lanes = <0 1 2 3>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				anx7625_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+
+		aux-bus {
+			panel: panel {
+				compatible = "edp-panel";
+				power-supply = <&pp3300_disp_x>;
+				backlight = <&backlight_lcd0>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&anx7625_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c2 {
+	/delete-node/ trackpad@15;
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		post-power-on-delay-ms = <10>;
+		hid-descr-addr = <0x0001>;
+		vdd-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+	/delete-node/ codec@1a;
+
+	rt5650: rt5650@1a {
+		compatible = "realtek,rt5650";
+		reg = <0x1a>;
+		avdd-supply = <&mt6366_vio18_reg>;
+		cpvdd-supply = <&mt6366_vio18_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rt1019p_pins_default>;
+		cbj-sleeve-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&pio>;
+		interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+		#sound-dai-cells = <0>;
+		realtek,dmic1-data-pin = <2>;
+		realtek,jd-mode = <2>;
+	};
+};
+
+&i2c_tunnel {
+	/delete-node/ sbs-battery@b;
+
+	battery: sbs-battery@f {
+		compatible = "sbs,sbs-battery";
+		reg = <0xf>;
+		sbs,i2c-retry-count = <2>;
+		sbs,poll-retry-count = <1>;
+	};
+};
+
+&keyboard_controller {
+	keypad,num-columns = <15>;
+
+	function-row-physmap = <
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
+	linux,keymap = <
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
+&mmc1_pins_default {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_8mA>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <MTK_DRIVE_8mA>;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_8mA>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <MTK_DRIVE_8mA>;
+	};
+};
+
+&pen_insert {
+	wakeup-event-action = <EV_ACT_ANY>;
+};
+
+&pio {
+	anx7625_pins: anx7625-pins {
+		pins-int {
+			pinmux = <PINMUX_GPIO9__FUNC_GPIO9>;
+			input-enable;
+			bias-disable;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO98__FUNC_GPIO98>;
+			output-low;
+		};
+
+		pins-power-en {
+			pinmux = <PINMUX_GPIO96__FUNC_GPIO96>;
+			output-low;
+		};
+	};
+
+	en_pp1000_edpbrdg: pp1000-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO29__FUNC_GPIO29>;
+			output-low;
+		};
+	};
+
+	en_pp1800_edpbrdg: pp1800-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO30__FUNC_GPIO30>;
+			output-low;
+		};
+	};
+
+	en_pp3300_edpbrdg: pp3300-edpbrdg-en-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO31__FUNC_GPIO31>;
+			output-low;
+		};
+	};
+
+	touch_pin_report: pin-report-pins {
+		pins-touch-en {
+			pinmux = <PINMUX_GPIO37__FUNC_GPIO37>;
+			output-low;
+		};
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8186-mt6366-rt5650-sound";
+	model = "mt8186_rt5650";
+	mediatek,adsp = <&adsp>;
+
+	audio-routing =
+		"Headphone", "HPOL",
+		"Headphone", "HPOR",
+		"IN1P", "Headset Mic",
+		"IN1N", "Headset Mic",
+		"Speakers", "SPOL",
+		"Speakers", "SPOR",
+		"HDMI1", "TX";
+
+	hs-playback-dai-link {
+		codec {
+			sound-dai = <&rt5650>;
+		};
+	};
+
+	hs-capture-dai-link {
+		codec {
+			sound-dai = <&rt5650>;
+		};
+	};
+
+	spk-share-dai-link {
+	};
+
+	spk-hdmi-playback-dai-link {
+		codec {
+			sound-dai = <&it6505dptx>;
+		};
+	};
+};
+
+&touchscreen_pins {
+	/delete-node/ pins-report-sw;
+};
+
+&wifi_enable_pin {
+	pins-wifi-enable {
+		pinmux = <PINMUX_GPIO51__FUNC_GPIO51>;
+	};
+};
+
+&wifi_pwrseq {
+	reset-gpios = <&pio 51 GPIO_ACTIVE_LOW>;
+};
-- 
2.17.1


