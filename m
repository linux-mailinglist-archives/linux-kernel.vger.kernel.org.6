Return-Path: <linux-kernel+bounces-236490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC091E2F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FCB1C21833
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B016CD07;
	Mon,  1 Jul 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2Rm3vpq"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63416C6B6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845809; cv=none; b=rzPlqMPy3r7ZpxHXZA1NcQSkcRpKPbBRGA664r0UEtJAhh7IPMlNHXll50gfm4X7LK4cPjwzPpue9TffSMfrX2VlNIMBZEg+fOdfjbDyNU/dRRc+Z5AMzh/pdr3t9CZpK939W1ExqKWOJgUG8X/Q4SUUNdEuWXYLCmT32ew4Dyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845809; c=relaxed/simple;
	bh=79NJk/kks064XT4lzuhqDllc7V+WZUytw1GlsOlds7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgCB/TzFr/y/NF8SkyO+qdBp+pqR/JDC8BG9cFq8yc750voEDHbzieJMsjWE97K109HIK5WznOiM+XaDTTXypQeL07ihV/MVpC5LK/qtb61yEbOAoyh5j998JOcQj/1rGJaClmJpCGfOW8EB4zMoisN7pd9iWpUjz1tHOH9Via4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2Rm3vpq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so41981601fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719845804; x=1720450604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JATPX/JRe6q4Z3TotQ5wEOtjsde3mkXmcqQGJxoMG3g=;
        b=f2Rm3vpqmp0KnqYvBQaJaF4c09gh62YKh5BVvr0I4uxT7lujm7FpxDlAz64bZpqtsg
         WMtj2eN1NX/IfZee5FuLB8/uIW/z59fhjoevZrBfDaWFo35SG5l5KRHhaSXlRk+Bql5p
         WynnPVnquATbhrk9j0teVoGFwq8onBAZ0QyXxpqtTjC7stQ/4eDRYpqFJFOrJ39E+y4c
         lfvpkyeOWYsMCUaRohfyLZf8dcQ0IIFvmgGmdtWHbftoUR5QXUieFYEFBEdqpP/vEALY
         +HcROcayt10QisQulSbwsdIpI3A4IvNXPwEyJhivFbPjA28h84gtidxm/3zZQyFynrZo
         Xkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845804; x=1720450604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JATPX/JRe6q4Z3TotQ5wEOtjsde3mkXmcqQGJxoMG3g=;
        b=NnX7sFzUQf+kc9wbwRPAK8WWRFVgcld7qDtI+zzBirKwzOx2NObZynrjLuvT8AP8wU
         kWl2AwwYDP1PzdwEMmNiq3q/EBYsSD3CNzk2lPY93s3eMs66oV/4K6qUi0nVExKiOlgh
         NvhwQfr8toSb/3HYkQb05PnmP+B5sKkOOzBXPcmqw7YObpIBnejtAq8Xv04zGBqVQFXV
         Ng4wuQe/UkxNkGm//un6a+Ma6ff+/uvd8oS1SwalvAI2q1LhczS5VGHKR+5Bds6mAeFs
         XTrKD6hDr9e3bQBHVxxApnC11jgDQ3ASje6t5Q73Xe5fwZIm9GjRIlp1u0dq2N83/ZCI
         i7ew==
X-Forwarded-Encrypted: i=1; AJvYcCVB9Fd7Df1AoGniEQUaNQOATKXbGTFYgLCzb0ij9cl94IsFxW/D2olUGF2bHvJdRlxMpLWDOSqi2cTFhfS0dgfNSUhD0rx6NnJvpKEt
X-Gm-Message-State: AOJu0Yz6sfoq28WFVbyuQmOYeNW/miVxIK+XqKpzdVKWkmOehN10wcb0
	fwPID9+n+VoYngUb63GY8txTzqoeno+bt3/PC2RMjSz6wjZblxVPET4ViZOZzLmgLgMzvcIJqvG
	Z
X-Google-Smtp-Source: AGHT+IE22RIOChFZZa4znuI1O9mOLun25MwFCbFMZiEdl8Iwww43ZJGWH2ZmYlbDClkh5/Wy0lb1+g==
X-Received: by 2002:a2e:a889:0:b0:2ec:558d:4e0a with SMTP id 38308e7fff4ca-2ee5e393e16mr52979781fa.19.1719845804485;
        Mon, 01 Jul 2024 07:56:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm160062915e9.41.2024.07.01.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:56:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 16:56:34 +0200
Subject: [PATCH 1/7] ARM: dts: marvell: kirkwood: align GPIO keys node name
 with bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-dts-marvell-cleanup-v1-1-4773bd20691a@linaro.org>
References: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
In-Reply-To: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17045;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=79NJk/kks064XT4lzuhqDllc7V+WZUytw1GlsOlds7Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgsOjPa79i2wAY3BT1qCSZzyYEo45o+HlfiOBX
 DDT8xAZS8aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoLDowAKCRDBN2bmhouD
 1z66EACSRfVcHB/qDzhjBWmIncYpKirAvYh9JjoXYCUikttoWxnFj62tNR3/Uz7eEf2dzOZLy1e
 OxfGmkQhKL05rOl8WVvzIp5d9328lTDV6H3ok82YqDchLYrkjFZnfTT6F5v+9TpJXPXK0iN2QXd
 sNJsQLSqL6ZUMoqHqLjAvuESYaRDXnCQcuPyzegjLi6wGY+cpt/C2aO+PGxmww4Timf+LTIwVhn
 2ayBiXVeh0MT0CPAhM47k3A3u7J/ZnboA6K97qyhUA7knDkE0PO6HTMJ0OsF7maMOF9lfgWHpie
 7FSxVynlnt3CJo9OGTbBznGsMcPVcaTD7xADyeABGIChDBEQ0c/N9uG+jZpuU98uf5O55rrWYQK
 QnElBLVqAsGHGIFdW8g4iRFTI8ITjWOa12uPqRc51Gl1gSlkyKKNaHEQbWXcLaxa8Gfii2QRpxE
 aB1EBNPyRNhfcRo2G9iwvQZCGzi5eAufY3nbRO01/IbLkGFa2d/4t19kX5NJnNGjpF8ZWy52P4p
 UTB9Z5PRuPwFYUzPFbCzB9DV9dw44BVLBcFs5GndmygjF9cXivGSEOOIywXJB+HI5EUXuvU52FH
 waiRVuafwvcyjuuj5euIhHx0dljW9OQDcdIe1BdAyTFVXkG0rB+v0p9LefkvwMioUcc/RDImOXC
 BwpsZw4SrDqGvLQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings expect the GPIO key node names to follow certain pattern, see
dtbs_check warnings:

  kirkwood-laplug.dtb: gpio_keys: 'power' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts           | 8 ++++----
 arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts          | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-dir665.dts            | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi            | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts            | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-iconnect.dts          | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts    | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts              | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-laplug.dts            | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts     | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi             | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts   | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi          | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi       | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts           | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi    | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts     | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-t5325.dts             | 2 +-
 arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts        | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts        | 4 ++--
 arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi            | 4 ++--
 23 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts b/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
index 07fbfca444d5..f34c3897ff48 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
@@ -35,13 +35,13 @@ gpio_poweroff {
 	gpio_keys {
 		compatible = "gpio-keys";
 
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
 
-		button {
+		button-power {
 			label = "Power";
 			linux,code = <KEY_SLEEP>;
 			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts b/arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts
index f59ff7578dfc..7e3ee64d4bdf 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts
@@ -29,25 +29,25 @@ keys {
 		pinctrl-0 = <&pmx_buttons>;
 		pinctrl-names = "default";
 
-		power {
+		button-power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 		};
 
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
 
-		usb1 {
+		button-usb1 {
 			label = "USB1 Button";
 			linux,code = <BTN_0>;
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		button-usb2 {
 			label = "USB2 Button";
 			linux,code = <BTN_1>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
index 448b0cd23b5f..2582b84d8415 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
@@ -61,7 +61,7 @@ gpio_keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power {
+		key-power {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dir665.dts b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
index 0c0851cd9bec..e8eff0ba1c99 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
@@ -179,12 +179,12 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reset {
+		button-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
-		wps {
+		button-wps {
 			label = "wps";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
index 0738eb679fcd..baea14c68520 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
@@ -14,17 +14,17 @@ gpio_keys {
 			     &pmx_button_reset>;
 		pinctrl-names = "default";
 
-		power {
+		button-power {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
-		eject {
+		button-eject {
 			label = "USB unmount button";
 			linux,code = <KEY_EJECTCD>;
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		reset {
+		button-reset {
 			label = "Reset button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
index 962a910a6f5c..d76dbbce16f1 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
@@ -63,12 +63,12 @@ gpio_keys {
 		pinctrl-0 = <&pmx_button_reset &pmx_button_usb_copy>;
 		pinctrl-names = "default";
 
-		copy {
+		button-copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
index aed20185fd7a..ea98ff13700e 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
@@ -127,13 +127,13 @@ gpio_keys {
 		pinctrl-0 = < &pmx_button_reset &pmx_button_otb >;
 		pinctrl-names = "default";
 
-		otb {
+		button-otb {
 			label = "OTB Button";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
index 2338f495d517..fa7ace071de8 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
@@ -154,17 +154,17 @@ gpio-keys {
 		pinctrl-names = "default";
 
 
-		Power {
+		button-power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 		};
-		Reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
 		};
-		OTB {
+		button-otb {
 			label = "OTB Button";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-l-50.dts b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
index c841eb8e7fb1..094854743dde 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
@@ -193,7 +193,7 @@ express_card_pwr {
 	keys {
 		compatible = "gpio-keys";
 
-		factory_defaults {
+		button-factory-defaults {
 			label = "factory_defaults";
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RESTART>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-laplug.dts b/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
index 8c2b540eaf4f..8296486a5931 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
@@ -51,7 +51,7 @@ pmx_usb_power_enable: pmx-usb-power-enable {
 	gpio_keys {
 		compatible = "gpio-keys";
 
-		power {
+		button-power {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
index 27fd6e2337d5..3f97240fda74 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
@@ -38,13 +38,13 @@ gpio_keys {
 		pinctrl-0 = < &pmx_btn_wps &pmx_btn_reset >;
 		pinctrl-names = "default";
 
-		wps {
+		button-wps {
 			label = "WPS Button";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
index f80af24b9e90..a86dbc490600 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
@@ -113,18 +113,18 @@ gpio_keys {
 			     &pmx_power_auto_switch>;
 		pinctrl-names = "default";
 
-		option {
+		button-option {
 			label = "Function Button";
 			linux,code = <KEY_OPTION>;
 			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
-		reserved {
+		button-reserved {
 			label = "Power-on Switch";
 			linux,code = <KEY_RESERVED>;
 			linux,input-type = <5>;
 			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
-		power {
+		button-power {
 			label = "Power-auto Switch";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
index 5a77286136c7..0d5d85c873b5 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
@@ -96,12 +96,12 @@ gpio_keys {
 		pinctrl-0 = <&pmx_keys>;
 		pinctrl-names = "default";
 
-		restart {
+		button-restart {
 			label = "SWR Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		wps {
+		button-wps {
 			label = "WPS Button";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
index b5737026e244..d0f85893aeca 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
@@ -60,19 +60,19 @@ gpio-keys {
 		 * esc and power represent a three position rocker
 		 * switch. Thus the conventional KEY_POWER does not fit
 		 */
-		exc {
+		button-exc {
 			label = "Back power switch (on|auto)";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
 			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		};
-		power {
+		button-power {
 			label = "Back power switch (auto|off)";
 			linux,code = <KEY_1>;
 			linux,input-type = <5>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
 		};
-		option {
+		button-option {
 			label = "Function button";
 			linux,code = <KEY_OPTION>;
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
index 51530ea86622..6cc068a05673 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
@@ -58,7 +58,7 @@ gpio_keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power {
+		button-power {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
index 49da633a1bc0..767f34ab434e 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
@@ -40,19 +40,19 @@ keys {
 		pinctrl-0 = <&pmx_buttons>;
 		pinctrl-names = "default";
 
-		power {
+		button-power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
 		};
 
-		copy {
+		button-copy {
 			label = "Copy Button";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 		};
 
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
index ea3d36512e9f..bdce8a86ce51 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
@@ -68,17 +68,17 @@ gpio_keys {
 		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
 		pinctrl-names = "default";
 
-		power {
+		button-power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
-		copy {
+		button-copy {
 			label = "Copy Button";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
index 8ea430168ea5..ef6d6d7a4008 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
@@ -118,7 +118,7 @@ gpio_keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power {
+		button-power {
 			label = "Init Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
index 5aa4669ae254..601760041c99 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
@@ -34,7 +34,7 @@ gpio_keys {
 		pinctrl-0 = <&pmx_button_eject>;
 		pinctrl-names = "default";
 
-		eject {
+		button-eject {
 			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_EJECTCD>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-t5325.dts b/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
index ad093324e075..6703e412c8e2 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
@@ -161,7 +161,7 @@ gpio_keys {
 		pinctrl-0 = <&pmx_button_power>;
 		pinctrl-names = "default";
 
-		power {
+		button-power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
index 30892c19aceb..859521b5b84e 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
@@ -40,12 +40,12 @@ gpio_keys {
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
-		copy {
+		button-copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
 		};
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
index aba1205981f1..3b0a4ed588e8 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
@@ -40,12 +40,12 @@ gpio_keys {
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
-		copy {
+		button-copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
index 717236853e45..126db753c8fe 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
@@ -41,12 +41,12 @@ gpio_keys {
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
-		copy {
+		button-copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;

-- 
2.43.0


