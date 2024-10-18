Return-Path: <linux-kernel+bounces-371725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C829A3F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD76B21B06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADE1D7E30;
	Fri, 18 Oct 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e67Ot/DN"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8101CDA17
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257233; cv=none; b=ZG0eeRaPLSW7PoJoGwYhWID7fvllXpKuR6Toa0y8EEfGEt7HeHFOrOrXW6iENRHQN5lI5w/FPjuONuuK+RohbccqfO9Im8eim/uMcOcrrIk9bfvJeN+kgxZ7wFjNw0buI/XmXgx/21siuoGoNTkrb5AzP+R4kqWc/DmKGuXWchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257233; c=relaxed/simple;
	bh=hNoTBErVoPI3sr4GvnFFK7rrLhzYBTpq+ocPOGBcaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1c+ipS1u6P7FYjkNsslVBKyWCVksSDDtIAQ/hkoAQ2tvbjkQmAUzYe8/vQeAaf2eHMICUaaYlLX4lX+h75/n0Nr6I/7o+FNYTj8UrFDWEe4EdShgLcSJTRxs5RBmBTwAsmrciH16fuHIQ05+NA0rZtqRboEAo7y6t9gbsgl6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e67Ot/DN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso1425325a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729257231; x=1729862031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYlu7kUyVVFvizFrzeSTtKVIpspDxNh9CaA9Lpt1VR8=;
        b=e67Ot/DNvUHr/YoJrR7DmMYHbdbBX6l2BNGJLtEp5SbGm+s+aMIg+XTtW72PaI6VpY
         +/dfoq5ui7MUZW9IcN/lIBVgAUBnEZ+yJkxYajpZr6uBsL+CS5ecI6VUS4QDXJ5Q1uEz
         YgO9qH1eeuArd8PXf6TotHaD6V1nYalT3ns40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257231; x=1729862031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYlu7kUyVVFvizFrzeSTtKVIpspDxNh9CaA9Lpt1VR8=;
        b=HXzQxSvDPqf1Gs6NfWtsgf0jYXoNpGzXvWXz/gm6H3KSUDoAP1PFYnRBzvoW2M7odE
         +FACR/Zdb9IMvZECQO4UAruV5ksq/WnEYJUwftkTJIEi0a/Pzv4B7+ZKt1/yNjt74hLr
         Pj+AodfW0vpGIAqIWrSUrH86LbX8e749yOmBPXeYykm+6aQls+VLMIrUMfLMdmXNemvc
         5xyZdZ509SBxXofq2tX++SQh6Fp4AYWqwRscmsZh8bJGG6QdxojSzp5fTaVrvKVb5C0V
         QZ0WFN0WUUlSqVGN8aWr2d+ADl0BsJsZyw4rTgjj5skrT23qMUlK5qizcdclJzCE5bSi
         RmNg==
X-Forwarded-Encrypted: i=1; AJvYcCXc1GFSjDUpvpvqPLAlQuPkBph1UxivVqBFm1gepZYzNV8nI3I174rVyMSJtf5sel4EfpApOZWBa8DtEHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhRC8w05W8ilpihq2GC5ZEH2Yu+M7mXGZqZs7YqkNrvG6jCSa
	9GW3f760SUemSKG9Sx/T77abqwUdAF9g6ezbqf1cZiOZ1MnyY3Gys5TZlnOGGw==
X-Google-Smtp-Source: AGHT+IEDUPRn/bzbMJ8DyKrz1ReJDDUNeGqaDjl8NzOmbWtG9DdHYJFJg8JoLxVGWwxzk1sjUr6ruQ==
X-Received: by 2002:a05:6a21:458a:b0:1d9:19bc:9085 with SMTP id adf61e73a8af0-1d92ca5a160mr3934470637.14.1729257230773;
        Fri, 18 Oct 2024 06:13:50 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc256cc8sm1120222a12.56.2024.10.18.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:13:50 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 18 Oct 2024 13:13:41 +0000
Subject: [PATCH v2 1/4] arm64: dts: mediatek: mt8183: Fix race condition of
 pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-post-reset-v2-1-28d539d79e18@chromium.org>
References: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
In-Reply-To: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
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
2.47.0.rc1.288.g06298d1525-goog


