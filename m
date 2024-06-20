Return-Path: <linux-kernel+bounces-222395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3389100C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E81F26708
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E11A4F2B;
	Thu, 20 Jun 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFulNg/+"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1F1AAE0F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876882; cv=none; b=MNvYbqT2fn9JozwcOFQwOVb4Ea2sJrr/b2Xg2lv0jyIzdyKvgAyb1np5P148xmi8vfsZ47ePk/IOFiO/GRLDDADOj/V9aQy3mkHSnqG9Besec/WwDhBRP6Pv/BrO+OtpMLk+nPfvESFG7FA8h2XF1sjxKfJNB0zYa1oAWOPOqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876882; c=relaxed/simple;
	bh=V53f+L/QkY1jAclFS7LJzafURdYiVosaBDdWByKJ7y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n39+Rk5h11RT/rjw81BzYm6QwBykSvKJOcqV4dn6cY9Q60kdEgwCy4/TBJ8mQrdk9tXFkaTer6VmuRbxi4f1EI2C8pYEWas6Ifl1xh+DbZDN8nawIRU8m9wUVwmNFTA/bfqnRljaJKhPGSAoM2qjHLvAhvuDYyDX8AD9RXNl8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FFulNg/+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70623ec42c2so566818b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718876881; x=1719481681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3CqtMl8gkLPqmxGGSK7XhTY2wKYDh56L/Juo8O2EDM=;
        b=FFulNg/+IDZf9e3wV7AeT6KQtuZYXxw7CuoIytIC33LhFppCXBxAIt8F7ZIH/wf3tP
         N56RW474MUt8XdWvSxhkSsJACgzU1jUk8pd8+Zj0qZga6SSq0+i2ks7/wrWy4TILeUB/
         3p3ZxrueEyPJ6Bnu10xQuqRfTyejh2a/fdcHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876881; x=1719481681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3CqtMl8gkLPqmxGGSK7XhTY2wKYDh56L/Juo8O2EDM=;
        b=pY1NyXZTPWIvtw0v9dkDHIbhy3Zgfzckl4VxicHRexJf7FLw4TsArJDJIep2vRzgv5
         TxxnPlFwvZJ/HVHsF8l43dZGPDhvMOFiufUhgbZYrLEN82gdok1ROB7lz1dSeKWMVbnJ
         H78D/QovNeFKM6rU42hiOZsdc+GM5Eql8IhO+rhroIHP8aj25rYTgED4gOyO3lz+1RJI
         SWHjZeyMAiC63VD3kkpPAQIAw6Ku6I4rSZjQszX81/4f5In1JQMCdNyGfGPPYXubO59H
         V7/X++/OQZ2420wZmgjQHoJyv9Bjw4aQls2J0aKRweOo1LEYM84Xeh+EgAsldzNgEnbd
         MX7g==
X-Forwarded-Encrypted: i=1; AJvYcCUcYvvRinnp9dabYxIXuvw+MBpcvXPDL1DSxeuLyHr/ERRKfISyFJSH4sJSNr09F3wpiap+YdjzBIMwpwoOsJku9jZJOUXVWlhf2gSs
X-Gm-Message-State: AOJu0YzN+1/O1LUGWz/vo+bcQmFiKZc3W36VQ0tF4qGwrDIeo7vhreWP
	78mUPvkAIR66ygKqqf0o0jOXOTfioMv9/DnlBbeYs/l1tRHDlxVY7RsWS2AkUg==
X-Google-Smtp-Source: AGHT+IE/YKGh11hC25P1P7PsiOqyiQ1Sp4JfOu2bt/xS/JbX8LDN8ZBilCH/xsgMZ5XdiVA+PMWmbw==
X-Received: by 2002:a05:6a21:328d:b0:1bc:bdc9:75e8 with SMTP id adf61e73a8af0-1bcbdc97673mr6501372637.29.1718876880803;
        Thu, 20 Jun 2024 02:48:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70dbae52920sm4164469a12.42.2024.06.20.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:48:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks
Date: Thu, 20 Jun 2024 17:47:38 +0800
Message-ID: <20240620094746.2404753-4-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240620094746.2404753-1-wenst@chromium.org>
References: <20240620094746.2404753-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device trees for the MT8186 based Voltorb Chromebooks, also known
as the Acer Chromebook 311 (C723/C723T). The devices are clamshell
style laptops with an optional touchscreen.

The devices differ from the other existing MT8186 Chromebooks in that
it uses a higher speced / binned SoC which also requires a separate
PMIC for the big core cluster. Also, a different codec is used for
the internal speakers.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mt8186-corsola-voltorb-sku589824.dts      |  13 +++
 .../mt8186-corsola-voltorb-sku589825.dts      |  25 +++++
 .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 103 ++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a2d128b17c45..e0cb1b35acfd 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -64,6 +64,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262148.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589824.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589825.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
new file mode 100644
index 000000000000..d16834eec87a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-voltorb.dtsi"
+
+/ {
+	model = "Google Voltorb sku589824 board";
+	compatible = "google,voltorb-sku589824", "google,voltorb",
+		     "mediatek,mt8186";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts
new file mode 100644
index 000000000000..45e57f7706cc
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-voltorb.dtsi"
+
+/ {
+	model = "Google Voltorb sku589825 board";
+	compatible = "google,voltorb-sku589825", "google,voltorb",
+		     "mediatek,mt8186";
+};
+
+&i2c1 {
+	touchscreen@10 {
+		compatible = "elan,ekth6915";
+		reg = <0x10>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vcc33-supply = <&pp3300_s3>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
new file mode 100644
index 000000000000..52ec58128d56
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/spmi/spmi.h>
+
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	chassis-type = "laptop";
+
+	max98360a: max98360a {
+		compatible = "maxim,max98360a";
+		sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&cpu6 {
+	proc-supply = <&mt6319_buck1>;
+};
+
+&cpu7 {
+	proc-supply = <&mt6319_buck1>;
+};
+
+&gpio_keys {
+	status = "disabled";
+};
+
+&keyboard_controller {
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&mt6366_vproc11_reg {
+	status = "disabled";
+};
+
+&cluster1_opp_14 {
+	opp-hz = /bits/ 64 <2050000000>;
+	opp-microvolt = <1118750>;
+};
+
+&cluster1_opp_15 {
+	opp-hz = /bits/ 64 <2200000000>;
+};
+
+&rt1019p{
+	status = "disabled";
+};
+
+&sound {
+	compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
+	status = "okay";
+
+	spk-hdmi-playback-dai-link {
+		codec {
+			sound-dai = <&it6505dptx>, <&max98360a>;
+		};
+	};
+};
+
+&spmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spmi_pins>;
+	#address-cells = <2>;
+	#size-cells = <0>;
+	status = "okay";
+
+	pmic@6 {
+		compatible = "mediatek,mt6319-regulator", "mediatek,mt6315-regulator";
+		reg = <0x6 SPMI_USID>;
+
+		regulators {
+			mt6319_buck1: vbuck1 {
+					regulator-name = "ppvar_dvdd_proc_bc_mt6319";
+					regulator-min-microvolt = <600000>;
+					regulator-max-microvolt = <1193750>;
+					regulator-enable-ramp-delay = <256>;
+					regulator-allowed-modes = <0 1 2>;
+					regulator-always-on;
+			};
+		};
+	};
+};
+
+&touchscreen {
+	status = "disabled";
+};
-- 
2.45.2.741.gdbec12cfda-goog


