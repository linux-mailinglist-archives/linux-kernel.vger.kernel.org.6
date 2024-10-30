Return-Path: <linux-kernel+bounces-388220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D09B5C35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1D1C210DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CB1DD53D;
	Wed, 30 Oct 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSDHncvM"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEB1E009D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271760; cv=none; b=oUgfqYd4XUzr2AESJu2wcshD908QGY6j5n9YJ4Jo5zfIeJ7zlgPMtTEaCRSPT1sQ1hM8dYiWrxiOg8vuxDgD7xqEWV7kjFLflhsNdWlRCSBC/7FuD7ezePSdNRct2QEqW8zEUCMEZXYbwtI1Z4R5DJqnj+O9ctlWyQVv9vZZTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271760; c=relaxed/simple;
	bh=rTCt2wTAlVnLiAKVA+zZLqsLFleae4+yewzhmiLwef8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etwrCUm9BLrgcunFR8jNrazPwWuzI3+ZXygGlVtIHJBhjT+isCInnEXN61nzELb8GUwf/WH7LIpWnSEp12pqPNwaxxFTSq6MJcsqM04tx/6HA4xwz7uLqDDFpdzxlOjWfRA6ep7m1SCRsEt1GP9vx116sWFV2dJXivMg9PQnvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jSDHncvM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso4294621a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730271757; x=1730876557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lij+PC1fLvJixrLcoV9Z1Urjyzf4HaJGb+O+EycfkvQ=;
        b=jSDHncvMUYkzvTDO1VfqEP2w3cHI86Ca7SUwWZF3+ylQqpizrgq9UksgzufQfiSg4p
         RBTMn3VKpMXWzZ03zcSheklrZkpNKBYBZxrnvunGkE0u54tZak4g+RSS+LKctOu7yocR
         3gLajpno3i/a+VC6gUxnSCZVv7nq+eRD/z9IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271757; x=1730876557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lij+PC1fLvJixrLcoV9Z1Urjyzf4HaJGb+O+EycfkvQ=;
        b=Jdlga/fh2PKAiKnOeI34jnuUKQNZynN+AtRUubn8I6BmPLRaMbyd3RoWQC7PkjPzdF
         fBnGtUxFvnSmX2QE/08SejfmzIwNhWuD0dlD5WdJw34LrxKwgh5VFMeZUm/S/NAWBjMu
         wzDklDzPe3OH5EaI2Dv5z5LEWlsvrrHIHcRfd6xdGWvZC+jLTvnx0yr/m0Blng/qvK3I
         2Lapa0r92Rbmy81MXZgB4E+hFYMvRC9/YRzMY7TqRiSboptSGFR8RDoPUFCxPtMoiXqC
         hPM27Owjd6M827C0V6rfA9aMucFeVxYn2l85qoZz8JcjRNWaWQ+b46oNVqd9t44CLEZc
         sDew==
X-Forwarded-Encrypted: i=1; AJvYcCU4uu7MVAkkRobx7tmGkSQ4/oRDZXvP5izIGOKJ6501Uv+a8+QD5XaiBDtkJBh2U5mUNP2MyO9Plp6NWeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQr63nbsvLcrqTP7JqXaLT60UQdzF+EuEXvMP7cZOV1F8TGauw
	jC3ej++AZMNPygRVluevhDfKEOP0CmbSNyvBf1K0M2fzTHi0rKuCx26X6rjh00/6uxXsCxEp0lU
	=
X-Google-Smtp-Source: AGHT+IEMIHQ8npyjfU/99fAX2NsP9PaKHpba5mfPSOR0IqSW7YKOpbx3Zp8jaGt7KFeqZbuG5u4Y4w==
X-Received: by 2002:a05:6a20:e605:b0:1d9:69cb:9f90 with SMTP id adf61e73a8af0-1d9a83d10bdmr20483336637.19.1730271756808;
        Wed, 30 Oct 2024 00:02:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1f3:aa64:657f:d8a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a94sm8635848b3a.68.2024.10.30.00.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:02:36 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: mediatek: mt8183-kukui: Drop bogus fixed regulators
Date: Wed, 30 Oct 2024 15:02:23 +0800
Message-ID: <20241030070224.1006331-5-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030070224.1006331-1-wenst@chromium.org>
References: <20241030070224.1006331-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of the fixed regulators in the Kukui dtsi do not actually
exist in the hardware design; they are simply power rails connected
together with 0 ohm bridges.

Drop them and assign their upstream supplies to their consumers instead.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts |  2 +-
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts |  2 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 25 ++-----------------
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
index 05361008e8ac..2b5a8d1f900e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
@@ -23,7 +23,7 @@ touchscreen1: touchscreen@5d {
 		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 
 		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
-		vdd-supply = <&lcd_pp3300>;
+		vdd-supply = <&pp3300_alw>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
index cf008ed82878..75fadf2c7059 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
@@ -23,7 +23,7 @@ touchscreen1: touchscreen@5d {
 		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
 
 		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
-		vdd-supply = <&lcd_pp3300>;
+		vdd-supply = <&pp3300_alw>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index e9e6253141c6..0cf50b1f59c8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -52,27 +52,6 @@ it6505_pp18_reg: regulator0 {
 		vin-supply = <&pp1800_alw>;
 	};
 
-	lcd_pp3300: regulator1 {
-		compatible = "regulator-fixed";
-		regulator-name = "lcd_pp3300";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	mmc1_fixed_power: regulator3 {
-		compatible = "regulator-fixed";
-		regulator-name = "mmc1_power";
-		vin-supply = <&pp3300_alw>;
-	};
-
-	mmc1_fixed_io: regulator4 {
-		compatible = "regulator-fixed";
-		regulator-name = "mmc1_io";
-		vin-supply = <&pp1800_alw>;
-	};
-
 	pp1800_alw: regulator5 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_alw";
@@ -373,8 +352,8 @@ &mmc1 {
 	pinctrl-names = "default", "state_uhs";
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_uhs>;
-	vmmc-supply = <&mmc1_fixed_power>;
-	vqmmc-supply = <&mmc1_fixed_io>;
+	vmmc-supply = <&pp3300_alw>;
+	vqmmc-supply = <&pp1800_alw>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	max-frequency = <200000000>;
-- 
2.47.0.163.g1226f6d8fa-goog


