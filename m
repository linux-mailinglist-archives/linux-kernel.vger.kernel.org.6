Return-Path: <linux-kernel+bounces-371644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFA9A3DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B721F2302C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45A43156;
	Fri, 18 Oct 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QlR1Wae5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05A2032A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252995; cv=none; b=N/GAs6sPGbPj/LUumJuy7dqihg20xqXa7kMbSjkT42r3pmJG0AJziEwXgSMIFGUtYJ87NJjj+3s9BvFCxRTFj7ozdNVejMGdHK1tAFjJGfC7lm96TDyRc1oLzndgHA6mUVb5rkhpBHdOGrD1gNaHoiNqewg85XHfRm0+MiQk4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252995; c=relaxed/simple;
	bh=hNoTBErVoPI3sr4GvnFFK7rrLhzYBTpq+ocPOGBcaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nr9aKxjSItZWwWRg9c+eesaYRKlkp3d82Lwmnf03YmShmgGxwKwUpbu6UGhxrfYXATgUiDTe4atuWnuVPYhpotpZtGXDCbhw4B0iI1z6TVuAjTmgTG/jhb3f+D6UvAoF7fLJWntgVbWZ166JBKNaUbnhN1pK23ww0P4uRkj4W0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QlR1Wae5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2264867b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729252993; x=1729857793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYlu7kUyVVFvizFrzeSTtKVIpspDxNh9CaA9Lpt1VR8=;
        b=QlR1Wae5PZ0CNSvrSpd5w3rBqcCBbB4TPgM3hK9ymMtsTYT/IAsmwhZROaLQUC3VSA
         ZlbmcNszLyK+sONaXLbqFQ8Kttr4W4LHZnvjz99/ROLcLaYk9uVJdwttpxEfz30syJxg
         vp5hJ1flyCKIsll8VZGOmP0xJmoP0LfrCym8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252993; x=1729857793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYlu7kUyVVFvizFrzeSTtKVIpspDxNh9CaA9Lpt1VR8=;
        b=qc0ZWFkZRlsXt2SJMl/1lN/rRGZekSbO6GA+R7HYjW4SB4U3P1JTK5x+AiRsk8eeYp
         UnwAx7aB1syiVwi4TEpZlmPRUNVwxUPVmMkTbx8UE5jJjBl5GsXMNYx2Ir4E8Ugb2lm4
         A/q9G7SQf4c8HfOcqDXAG+vi4YolmXeqnhSjixK/KvOGyAwWI1axppFduC+7zmM1HzYc
         7Yi0crKqk0v8VbvCN23fiRnOpuwj+uDNlsA2DlF+PJl3r8wVuzL+Ed6DROPCWZPBlH5W
         Ml8nyJfip+ACQ1Z/nN69Kz8hEd/M60tZ1/iVX3XZAQpiSVtByh0rV2W8qk/VkH6n0HY8
         Q5NA==
X-Forwarded-Encrypted: i=1; AJvYcCW6dyH9oGOj3eIsZEE+Nwr4lWXEELynYVvEPmtUG/ssImjspFuCGTfDyQWnb4ImG6e74u4e+D/arNrHU1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubT7QNVw7jOuLtKar3pZyzP2gn65IYMhCTQ/QSb4pZKwsT2Mu
	Kzn9QNOCZFzmJna9gWck0EI6GsCq4Em2ELTUGl1e7iRj8VJ6jNQxbLvargQT+w==
X-Google-Smtp-Source: AGHT+IEGcDG3wlVNeyTnkESm9SQYHh/INABqC103bGWJJBZMyFepMcJaZpMON7AKaGrz5XrQO641SA==
X-Received: by 2002:a05:6a00:2c5:b0:71e:674b:474 with SMTP id d2e1a72fcca58-71e8fd72e7amr9523466b3a.8.1729252992874;
        Fri, 18 Oct 2024 05:03:12 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34ae672sm1274014b3a.204.2024.10.18.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:03:12 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 18 Oct 2024 12:03:04 +0000
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8183: Fix race condition of
 pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-post-reset-v1-1-5aadb7550037@chromium.org>
References: <20241018-post-reset-v1-0-5aadb7550037@chromium.org>
In-Reply-To: <20241018-post-reset-v1-0-5aadb7550037@chromium.org>
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


