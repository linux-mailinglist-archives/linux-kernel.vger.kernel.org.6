Return-Path: <linux-kernel+bounces-395825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D5D9BC394
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F743282FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D084E18;
	Tue,  5 Nov 2024 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DurZWuGQ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662778C9D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776101; cv=none; b=ZYDTecuu78vF2n9Cl+z1+eX7/cGQIRmGuosgZkhJr/3k2iKYHRmzFXF2QCf4wiq0nq2oKogCVFYUG2s/VlCSNRj7xSzUs+6d2oC3vJe4lnRdxAc21/lYBOom6JUqZ/ysjjCQZF0AP5qk7PQJ7o+LURb5wS5qoQ8PbVjXhG9u17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776101; c=relaxed/simple;
	bh=GuEunY5sk5TaYNRBAQM9yqtRv9XIjL9786C9i6GT7Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/FkqgFSafuXdkAQozOwK/M4IjmBXMn5nWkJi90sGuSP2H0MayUOVL8OIPt9LhroxI+N5/KJjGtmULSpgvIo6RJeR3sOXoQsmszheUmTim3CNGCBh8rLG0FwVgFAGK4pX4zBolwHnu7Y9RUWgpUAZQ5dWMVowL8ccpWHMBlkRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DurZWuGQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cf3e36a76so52087785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730776099; x=1731380899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XrcJsxzwLs0eqtDhBbJMSI0x+sUY9A+M1XULM1hdCU=;
        b=DurZWuGQaDJAS+7w11m14nv38AQYqGqEVuw8W2Jvg9iKOXZzoiUS+/GgIRJH1HmkHV
         a8qFjNCUWLO+i98NQl1Dp8yRhmbsUnGRaqKwS+RnMpc/v4lpB41eglMLoxnIf4YwrF0z
         qWynhM/w2zIae85Kowjqky3ykoynAa2hu3FpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776099; x=1731380899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XrcJsxzwLs0eqtDhBbJMSI0x+sUY9A+M1XULM1hdCU=;
        b=dzcIgk3UjlgcuWLMNKsjPnRJVwCh1bznMfPN0A50XJkOkmES2o2eeVCIuPexws2Ekw
         M7pVfaPAgoNKxTTc2M3XEO80qS+q8o3lWmC2Szb3dRrOgUe17+PaHk/3//j8EPFIt8Py
         akSlx0CpPDzrrbgnNpJ01qBoRJqe0kH8J22ADBRaqG2P80glLf9OLBMrU02yJ18Z2T5G
         Np2w4smCdkIDI5okw2cknm1ooUl1DcYNnzq63rttshP9wyBrV9DhtoUSUYqcPqQ7ZfHh
         ue7a8an7fF9lHEkOB9aOxqSKdNOGwBnbtRg323LFCKhGMkKhkmjGUira7HrHKWIol4Ra
         usIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTXHf0s40M/zvT8zjwOyBirj21ac8kHJB9dacWd9uw3ODvDux8N9xz5U817yw+iSI6X0rZFDOOuMJMVOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpnRFgKgB5IHX2tjBVVXnMKUgVq5Ope8k7aUPOsQDyMiPuSlY
	8BgnR6FtLFU1Kzua+sTaukgIWUUqt6w5lh6jTgHUKYLcl6ZLMqUL4GDkED/n9ZL1FfAOz0Q4IL4
	=
X-Google-Smtp-Source: AGHT+IF7J/95pmLTum7neOrQQp+bL+1IHEgggYbOJ5OQlebdFirCfCn3Qv7bpzUFn4MmtlqEhrvs+w==
X-Received: by 2002:a17:902:ea04:b0:20c:f9ec:cd9e with SMTP id d9443c01a7336-21103c59c36mr253979645ad.41.1730776099132;
        Mon, 04 Nov 2024 19:08:19 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8d4dsm67497885ad.270.2024.11.04.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:08:18 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 05 Nov 2024 03:08:11 +0000
Subject: [PATCH RESEND v2 1/4] arm64: dts: mediatek: mt8183: Fix race
 condition of pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-post-reset-v2-1-c1dc94b65017@chromium.org>
References: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
In-Reply-To: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

Some mt8183 devices use second source touchscreen/trackpad and share the
same pinctrl property with the original touchscreen/trackpad. Currently,
multiple touchscreen/trackpad drivers might probe simultaneously,
causing a race condition of getting the same pin.

Move the pinctrl property to the i2c node to workaround this issue.

Fixes: dd6e3b06214f ("arm64: dts: mt8183: Add kukui-jacuzzi-burnet board")
Fixes: 52e84f233459 ("arm64: dts: mt8183: Add kukui-jacuzzi-cozmo board")
Fixes: 6cd7fdc8c530 ("arm64: dts: mt8183: Add kukui-jacuzzi-fennel board")
Fixes: 124d64392de2 ("arm64: dts: mt8183: Add kukui-jacuzzi-juniper board")
Fixes: f006bcf1c972 ("arm64: dts: mt8183: Add kukui-jacuzzi-willow board")
Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts   |  2 --
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts    |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts     |  2 --
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts     |  2 --
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts     |  2 --
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts     |  2 --
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi  |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts     |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts    |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi  |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi         | 10 +++-------
 12 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
index 19c1e2bee494c98c0db87308494713a26e304cd2..32ec6fd30fdb7449e9e606f69d16556bcdecc369 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
@@ -21,8 +21,6 @@ &i2c0 {
 	touchscreen@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&touchscreen_pins>;
 		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
index f34964afe39b5353de7b17e82d14d1fba88551ab..b75ab2d33550808196f2d1d4bf0d34ccb713a07a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
@@ -23,9 +23,6 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 0b45aee2e29953b6117b462034a00dff2596b9ff..ebe6e161354c414d91859494ec9295db75a3baf9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -19,8 +19,6 @@ &touchscreen {
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
 	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&touchscreen_pins>;
 
 	post-power-on-delay-ms = <10>;
 	hid-descr-addr = <0x0001>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index 72852b7600383972d98d9b0edd40b6e99e34a85b..2dc64cc539f815b9848b8243e5b487f22d605a6d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -32,8 +32,6 @@ &touchscreen {
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
 	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&touchscreen_pins>;
 
 	post-power-on-delay-ms = <10>;
 	hid-descr-addr = <0x0001>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
index 757d0afd14fb064fc1de4608e65eb1a561c4dfa6..53e996f9c605dc36df03d4b0051a91e19fefb38d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
@@ -19,8 +19,6 @@ &touchscreen {
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
 	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&touchscreen_pins>;
 
 	post-power-on-delay-ms = <10>;
 	hid-descr-addr = <0x0001>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
index 6641b087e7c5f3a957e43ac985137dfd84ac7878..d7db621383c6b823af08ca07e0794758d062e211 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
@@ -19,8 +19,6 @@ &touchscreen {
 	compatible = "hid-over-i2c";
 	reg = <0x10>;
 	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&touchscreen_pins>;
 
 	post-power-on-delay-ms = <10>;
 	hid-descr-addr = <0x0001>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
index bbe6c338f465ee7c11bfbfc30767bdb142706480..e5b51b27980ae90a8f1099f71a891bb0562a375a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
@@ -16,9 +16,6 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
index 078bc765646f57fd8c55e97325893ab50e4dac51..a96c64a9251044b2c1ba4289467b411e6c744abe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
@@ -12,9 +12,6 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
index 8ce9568fee95a6faba0c238f6c43f43948c26d9b..2c740b3e5d3d91980ed89e07a6be70ff51906145 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
@@ -25,9 +25,6 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
index cce326aec1aa594deb6f5b14340d3552d110b160..bce368fcc884008086c091a29e3f69e541215ee5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
@@ -38,9 +38,6 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
index 76d33540166f900c99c419c4f97ca0a56cf658f5..9b1600d5c4c1247c97fd59aa7603eaa835420117 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
@@ -12,9 +12,6 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 783c333107bcbf7368398feae0a29e5f0ee50c19..65f70627f2dcc4af832b8a08f7cdce354c800fae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -100,14 +100,13 @@ &dsi_out {
 
 &i2c0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&touchscreen_pins>;
 
 	touchscreen: touchscreen@10 {
 		compatible = "elan,ekth3500";
 		reg = <0x10>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&touchscreen_pins>;
-
 		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 
 		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
@@ -116,7 +115,7 @@ touchscreen: touchscreen@10 {
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-0 = <&i2c2_pins>, <&trackpad_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
 
@@ -124,9 +123,6 @@ trackpad@15 {
 		compatible = "elan,ekth3000";
 		reg = <0x15>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_pins>;
-
 		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
 
 		wakeup-source;

-- 
2.47.0.199.ga7371fff76-goog


