Return-Path: <linux-kernel+bounces-442610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED589EDF58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DF7188AB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FD1E231C;
	Thu, 12 Dec 2024 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="b7YFj2c0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAD1DE89B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984465; cv=none; b=aBt9VigAPaf69gUvNuCQ89D9QQST/F9bk/hqBlBcCaHmq65qxN/lL3dy1litU2NfJQjLtT6N+YbJM1IXh/b/WWJmJdPhMPHM/q2ytvCyfF6MG8FFae8+Y/y86lqoOHYa0tlAT7x5lvt6W89v8wSOyEcuwig/tsscLWFTvh/BHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984465; c=relaxed/simple;
	bh=Eb4Ar0R6TaNkkUYA1uRjoADykY9VeYsROV/ovgOChpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rTaOQqxWUX43tlRe6PIUKr+ByDmqAJvdZ9pwICFbyBkUF99hlGYEOFrH+yzjGE/07ZOXX2tBTiO4tBU8ycWrXfP1C+6+I+zQzpwW0ZKzbZjCTXZ2aTQVJATKjcaKbuJRDwCaJm2IBmzdJrSLR5plDgS5k0P/JvepceNVFmpryJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=b7YFj2c0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161d4b820bso418075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733984463; x=1734589263; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJZcXb8dkpO22VJupd+sTy1vZg0+CYZcmocwvBHdirY=;
        b=b7YFj2c0V0MnfovJ1uU3LCOHjAOPSBxJ5ZyG29XmBmdtSp+ysch0CdusBJqm5+E3TG
         QFJXP4iWq8q5X/nkCfeOVWST1Q+Q0WoRRFl/lJ/Ah8+qeaAqD4FBYXim5GNjWJOrTeS6
         KCOiq8JyFpNFOJHYj2qaMNQEChHUkxSb+Wn6nKEA580airjsq9ywTtUqVizq0zXf13aF
         QjI2mgu3kzzN91sY6K/L1ADY63ZvEbVDwUar9e8Nt6MlWhAhzE5Z2wct0NqRb/WdO5bh
         ZdaeCCahs6raDPAYByQXGcFyxGd0aIPvGicogzjTwHWoySltLcKYgOx3DONbAHJSj7kb
         wn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733984463; x=1734589263;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJZcXb8dkpO22VJupd+sTy1vZg0+CYZcmocwvBHdirY=;
        b=qLrpXccPIPScv1/2hwZTGiTrTLUOi6QtdFKigTRdwt5pe5YYxEYJvdH5m86+ctcbfi
         ygrhAjFakB2acvHYS6juJ3nbmxtWIaV1v/NegFy0SQJg9M0pQXQ8Bibo9Bb+Pvr57h2c
         pEBEsgLVICWTgarSxjYGKJ9w+5XqEy/+OPChy00v26EFHZIqZAcD8JwE4zwQa45JhZ7b
         LdSb3gOcLwhAX0ORjt4+++G9RHvo/NfNb6yjvfOygmoLSpP/qTDypfhdMOoYpXXEghdp
         yLfh40UGJcMca/L53bKfWkngtOtx03Hf3IWwYmDy9pMjKfXiA6+OBuednY3N8vOKi+qs
         orFg==
X-Forwarded-Encrypted: i=1; AJvYcCVqpSnFon3X3ZIsU3Az3X5U1xV+gc7DMMjkpKsdioXLZpZTd9PcDKh+JBxUiGAX5kOQJKxblsWOJn1QwR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lcvXAKa+Cp1sLF35GEJgM4YjGJOczE1oJH3y1aG7+EsZQgy1
	rxXSstLwlgHb73b8/+wvIq2YwqwsVsBIwZ9R5NIr60oOmLY1lBhtfwFwJzUA0nw=
X-Gm-Gg: ASbGncunSxkw1zFA22XwngKj2O+tP8bNXlPoonKEEuyC8x/Qb7xmjDC88nf/E5o7v4c
	sycauOPC3WV8dU824C9hNbjM1Aw3Pt5C7SOQHMqkC1tOZt6UFhErlOMdXOq1Vb69P2LTk2+qRBB
	sb5s3LWxtW1Y43Pu1Ogj1Kd6tgW87o5fkDqL5aQoYIlwDBt1e3uZqZrhn/x7vkheMML+R1iSRWz
	brT6QyTGztFK007hblgs2E1UO0s5KamAX+kAuh44PpXwBbHS19i3ub/b5d/1asR8qm1W3UT19zR
	cBL+N6RmS16gOqJTHrIU
X-Google-Smtp-Source: AGHT+IH2zBdCACf7+aG/i1DP70tweBGTWltkOjk7VBfkMCsvI6QVGRGO+Hyy0JesdskAGcrlpV/xJA==
X-Received: by 2002:a17:902:e543:b0:215:9a73:6c4f with SMTP id d9443c01a7336-21778520088mr35332925ad.6.1733984462835;
        Wed, 11 Dec 2024 22:21:02 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c278668sm83579165ad.81.2024.12.11.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:21:02 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	dianders@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v5 2/4] arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
Date: Thu, 12 Dec 2024 14:20:44 +0800
Message-Id: <20241212062046.22509-3-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
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
index 000000000000..9d6e62af6944
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
+	compatible = "google,chinchou-sku1", "google,chinchou-sku3",
+			"google,chinchou-sku6", "google,chinchou-sku7",
+			"google,chinchou-sku17", "google,chinchou-sku20",
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
index 000000000000..800792157021
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
+		pinctrl-0 = <&speaker_codec_pins_default>;
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
+		drive-strength = <8>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <8>;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <8>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <8>;
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


