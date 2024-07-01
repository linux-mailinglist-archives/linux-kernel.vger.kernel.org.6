Return-Path: <linux-kernel+bounces-236491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6F91E2F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673DD2870CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8516C873;
	Mon,  1 Jul 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NL3Q02t0"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7F16C6B8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845810; cv=none; b=rFaU3RBd5gGWH+amhid1rpQ146BkqjE+kCNrdUi18NG1dQAXX+sk9pXQTYTSackJgl6MMyWqNzfWoP07q6ZZFKzh6RHFdkunrCxdz8vU2gNfRgEeOZYX0BbgQ5ReSilk2wXuXIdc8McJNvkqFcf76RWwF4m3feOpsriWW81OlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845810; c=relaxed/simple;
	bh=NEPSfOxaqM8gOXmgm7ZxD/8mLRI8BGKty4k6NfrPTow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgyX0BPYr4JTonGEH0yaQufCuU5CoyOted4uW6PzUQPr9UIZGJlvFWLoFsTYwfe/EKo6osBHozdmRryq6Ccmas0GjT5glf10kMBjwa8o2V9BUwZ27HjToxWU0mr67fF45lappwpyd07/rQapYDmvw31RQKMYAGGXHc4tvpYOVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NL3Q02t0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so43109021fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719845806; x=1720450606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXFEZx0udsk0lxzY2jdV+4pcISLPkDF6XpicWae74LU=;
        b=NL3Q02t0zxvKFXiNsCyXsh/nDiHtfI/BuN1vqUmRwa+sALA5FBQbfo9EoCJWVRdSPP
         67OkHJZOC9qRzsqOWacjH/pGCKTL6xpObPCaUnwHytyFqKrTqmJ/zh8cuJL05reMTGUB
         QL4i7YlfP3QBrXkD9rWI1kAiB9RCNEbbwH64zVAdvw6Y9o3jK1gam5Gva0+JOveobrIV
         qUgVvWfn2UalxG06GgJGKZj5vpOCWGV8R4iRUmOiyBjrfMc2PBE+JjRNy9w4IBFL9Hnc
         xbSSQ9gkyz91cQhWV6q2UssNXHEL53UdNQ5NAduKHNeIJ87e1A+22hC6SuV8LMvNRArn
         qvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845806; x=1720450606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXFEZx0udsk0lxzY2jdV+4pcISLPkDF6XpicWae74LU=;
        b=eYvf+kI3WzvnK4cmP/lxFniIghC+fNnG4kQtbSmbQpFUOzLUj+LjIKaUUsgL5BoMQj
         j9KMXFhu4vSuxdpiN7xdNyCTfOkC6WNRmUE8CM0YRgwJtdaqR2Zc+nrt2khq/fpzqiyw
         0hXmM/6fFI1WtuMhWGGfpPenWh6OEzGWlI+KomEKOzyOm2UPDuJsLHqj3m4jmqTwo3L8
         Mgn+Ac4FqIEcVPNa1oz2EUeLQDhpnRRUnJh+oOxhpQ24WgbX+KFW9kFaYxe5IyrGa6+h
         k9MeDLOvQSwrXghXs8hsvC9Nbj86BAt/6kZAkmYk5KVrISyy8EyJoQfcgRO68xokIShT
         4oEg==
X-Forwarded-Encrypted: i=1; AJvYcCXO3xj7C/+LPXwL1QtmdyMLu5fOPgKbptDI8SyROfNf2JxUU65pLaFaOeelVuVp9frKo3VqmWXg21HjeEgtObNX1fFOrWhKLl8xEuru
X-Gm-Message-State: AOJu0YzIb4VHtx7zJICGFZxgk5bN0AE9nimtguXcvPV/7t0yG8UcMlMP
	8J6cWacENnk8Q4SJyH+AOBpOvO5JmgUCwNcJ3yaot3MU2bqFKY8dZX9oA/JsQmkYf0zH7v7dXt0
	I
X-Google-Smtp-Source: AGHT+IGUuYy2SeiLbKShnwuk0VB0f/oTMLlaglBaLfapZR2FTp7i7OuuISmeZFTge5g5+GjjgV+adA==
X-Received: by 2002:a2e:9a13:0:b0:2ee:64cf:f8f3 with SMTP id 38308e7fff4ca-2ee64cffe44mr44493271fa.33.1719845805812;
        Mon, 01 Jul 2024 07:56:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm160062915e9.41.2024.07.01.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:56:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 16:56:35 +0200
Subject: [PATCH 2/7] ARM: dts: marvell: kirkwood: drop incorrect
 address/size-cells in GPIO keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-dts-marvell-cleanup-v1-2-4773bd20691a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12028;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NEPSfOxaqM8gOXmgm7ZxD/8mLRI8BGKty4k6NfrPTow=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgsOk6ud2OwR0U4BFEE8tFivP5+DYlM03AaQwi
 dz/E48OzC2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoLDpAAKCRDBN2bmhouD
 1ywhD/4ycQwgCU7+gy/WuQM/uuU/l3Nildt45XTPANM4XHK4OY5J7RPJTr32U5DwF0OgwgQX1fH
 P2pdOU/CKzFYlNF1VPWAq+n9rDOjiHeh+hEsAxg/mYuaAdbpjEy31FO9Qg92arKlu2EMvR9+wYh
 R8/qjql7ORKMiLiLGMZjTM7GksqA/p4iHIKcLK3IJm4E2NCUx5kgu6Fz1dFzHTsnM1RHLESAtHl
 MqT0HsxVcDaGrcwXOJnJoAOUU/8q69U+oUkt9C5jaMmqTh6OojtCZMyHf3Q0STwzHO8oFm+5X5T
 YRB9iNYWLnY64+uZR4Apj+TFGg/Gba5B/0y7sSgH8hqUrG6BtgMXUvpa5iHaJkseAQOzA75rupx
 wN/FnKP2FnKlOFfLDsrWWm+GbIu8FIpuAz60dP1pWLlgz2BO49KXM/k09MEfBYuGaJIE5oK19pq
 Njy2hfnVrZy0KWXcQPgZcTxOQ2XFn8uLlTzWP+0JrskIF0E+uzuqVzfFBOgmVsS5iO1vE1PzzWd
 G3ztrAFfsdR0hAx5z2pDf2jH2H2UJEE5tEk3toeC4WIyaB+NJ4dq6U1r6Jg9WHY8ZLc3NUtN1Js
 xxkTYOlhLoH9uAtQ2wPkjCMFWxz+pntTUbbLrLUwqM4bTlJu9hyWNwqhS1slPm7IaYqSsS+J4aA
 pOg6eGn9yn0p49g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings do not allow address/size-cells in GPIO keys and the GPIO keys
is not a bus, see dtbs_check warnings:

  kirkwood-openblocks_a7.dtb: gpio_keys: '#address-cells', '#size-cells' do not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts          | 2 --
 arch/arm/boot/dts/marvell/kirkwood-dir665.dts            | 2 --
 arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi            | 2 --
 arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts            | 2 --
 arch/arm/boot/dts/marvell/kirkwood-iconnect.dts          | 2 --
 arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts    | 2 --
 arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi      | 2 --
 arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts     | 2 --
 arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi             | 2 --
 arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts   | 2 --
 arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi          | 2 --
 arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi       | 2 --
 arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts           | 2 --
 arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi    | 2 --
 arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts     | 2 --
 arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts     | 2 --
 arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts | 2 --
 arch/arm/boot/dts/marvell/kirkwood-t5325.dts             | 2 --
 arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts        | 2 --
 arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts        | 2 --
 arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi            | 2 --
 21 files changed, 42 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
index 2582b84d8415..92897f8b637b 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
@@ -58,8 +58,6 @@ partition@0 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		key-power {
 			label = "Power push button";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dir665.dts b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
index e8eff0ba1c99..1d1f4cdedab2 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
@@ -176,8 +176,6 @@ blue-24g {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-reset {
 			label = "reset";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
index baea14c68520..20bcd031f3f5 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
@@ -8,8 +8,6 @@ / {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_power &pmx_button_unmount
 			     &pmx_button_reset>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
index d76dbbce16f1..0f50eb2d5931 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
@@ -58,8 +58,6 @@ sata@80000 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_reset &pmx_button_usb_copy>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
index ea98ff13700e..a2782fe3d379 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
@@ -122,8 +122,6 @@ otb {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = < &pmx_button_reset &pmx_button_otb >;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
index fa7ace071de8..91409ae949c4 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
@@ -147,8 +147,6 @@ backup_led {
 	};
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_reset &pmx_button_power
 			     &pmx_button_otb>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi b/arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi
index b54c9980f636..8a11d2b9d449 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi
@@ -88,8 +88,6 @@ partition@70000 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_function &pmx_power_switch
 			     &pmx_power_auto_switch>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
index 3f97240fda74..ddefaf628501 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
@@ -33,8 +33,6 @@ chosen {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = < &pmx_btn_wps &pmx_btn_reset >;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
index a86dbc490600..c0f80146706d 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
@@ -107,8 +107,6 @@ partition@70000 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_function &pmx_power_switch
 			     &pmx_power_auto_switch>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
index 0d5d85c873b5..fd3813ace0c1 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
@@ -91,8 +91,6 @@ green-usb {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_keys>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
index d0f85893aeca..d4edf2727388 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
@@ -53,8 +53,6 @@ sata@80000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		/*
 		 * esc and power represent a three position rocker
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
index 6cc068a05673..28f09f71b24d 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
@@ -55,8 +55,6 @@ eeprom@50 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-power {
 			label = "Power push button";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
index 767f34ab434e..47deb93c90a5 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
@@ -35,8 +35,6 @@ gpio_poweroff {
 
 	keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_buttons>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
index bdce8a86ce51..e9bd9c551af5 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
@@ -63,8 +63,6 @@ gpio_poweroff {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
index ef6d6d7a4008..20c6290d2037 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
@@ -115,8 +115,6 @@ gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-0 = <&pmx_gpio_init>;
 		pinctrl-names = "default";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-power {
 			label = "Init Button";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
index 946f0f453dd1..9c438f10f737 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
@@ -136,8 +136,6 @@ gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-0 = <&pmx_gpio_init>;
 		pinctrl-names = "default";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button {
 			label = "Init Button";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
index 601760041c99..b66fc4d57410 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
@@ -29,8 +29,6 @@ chosen {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_eject>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-t5325.dts b/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
index 6703e412c8e2..a6e77a487d00 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
@@ -156,8 +156,6 @@ usb_power: regulator@1 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_power>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
index 859521b5b84e..a2e0ad4b84d8 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
@@ -35,8 +35,6 @@ pmx_board_id: pmx-board-id {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
index 3b0a4ed588e8..35be6bce1dba 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
@@ -35,8 +35,6 @@ pmx_board_id: pmx-board-id {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
index 126db753c8fe..f136059607b7 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
@@ -36,8 +36,6 @@ pmx_jumper_jp1: pmx-jumper_jp1 {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 

-- 
2.43.0


