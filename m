Return-Path: <linux-kernel+bounces-388218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8C9B5C30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CA1F22519
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A41DFDBF;
	Wed, 30 Oct 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R6nLEz8L"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC41DDC38
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271755; cv=none; b=rexIAmXaRdGPuxps0rB+clRkAUpXIsrL3bhOinseVEaiH+fU89KRp9wE5k4rWazlvG6alUTOEmLddmhWkyQAxxq7byYsxjFXm4ioEuAYF20OTUlfvdmjKlO/CZwtMTR1SP2TWbjklWBQh3QrFRy8d5dIUj9U0TYiazM27SBFf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271755; c=relaxed/simple;
	bh=3X6IiId4qHxC14H05Tmc7YGDu5r5RtlkVil2KHK3+tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uewxinPIjMfM4t3wRNTiBgFhNo+zEOaY0+JBIdGZDd+CRlAVFlsHSv9Qt396pWlPUiT8djNCkLYXV5ZOOnGM+XaQVXas+AmwXTm3yYcdIzQb9s/f+JOxSs3u4vWs2QXCJEmKehw53GOQ9Ajb/gvGeGTbuzcuuy68//MsUvn8U30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R6nLEz8L; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e6cec7227so5167859b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730271753; x=1730876553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF1qEJly3xEvubxa1plhNMCfVxpYmwCDO14UJEUO81M=;
        b=R6nLEz8L3amelRWZAZz7TJGDcf4Tui4QMlZn7NgHl8tHSqX3WrPzRAUg1O0RMV8s+D
         FenWK1iTuqOgA87NqciycgVsfOpvb2FnfD73gXd9+qM6Zyxb5xnpMq/ZGS+/K6pReE1E
         9RRAr1fK950mUPTd8QaqZeIoenlEb9zvumheA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271753; x=1730876553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lF1qEJly3xEvubxa1plhNMCfVxpYmwCDO14UJEUO81M=;
        b=tT90vyR4GGmArEEUxOal1rF3FmGJjx8u/YIq2pEutv6196ZnSIr2XFERuBGA1eXazi
         LFrsP6z9+mLQ2o7Q+Cto7kcWdd2ECmHEM0MewiOkHVfP9Fk7Cijdvyd2UssHdIlGY1ez
         +rOqEEop9K1I+/fs548jMbL/55Ngpv1mZGjaTtGHs9ATHTU78QP4dMzX53DOFmq/MOjv
         b2pajmTDBFSkTSAmwlkSycH9wUVNDjk5pSoZW/v/bKwi7BLsLjfAU7e7lwDOkfDuBufB
         zrK83URbagdNztD9DISGl4/gckHYz1pTY8rOBXCvnEXFq2H4W1DZekE5EC202Y5MFKtF
         8G5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8KFHEQgdOuHfarRGqSMmLgU8c0elQ/OraEmJPjvuohjheONFHZJvB29FprypUY3CAOJEM90+Iens0lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjh4TWnds/sOCBFfiVj42kL/PZwKn/E6i92YiGYIaMN1GgpU2m
	h/3CYVtkShEqJ0nGlt2z7defluTH2oPxVhs4qjUQh1fyqtHBJHluiwUwz0Nf/A==
X-Google-Smtp-Source: AGHT+IFLPfQ/A5eko0pgXITap2wpEZJrJtsvHymtQmufWyNzTU2B5jU7ujsLfLpOT0HBExHRm0TYeA==
X-Received: by 2002:a05:6a00:8cf:b0:71e:587d:f276 with SMTP id d2e1a72fcca58-72063093364mr18860624b3a.25.1730271752832;
        Wed, 30 Oct 2024 00:02:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1f3:aa64:657f:d8a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a94sm8635848b3a.68.2024.10.30.00.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:02:32 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply names
Date: Wed, 30 Oct 2024 15:02:21 +0800
Message-ID: <20241030070224.1006331-3-wenst@chromium.org>
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

Some of the regulator supplies for the MIPI-DPI-to-DP bridge and their
associated nodes are incorrectly named. In particular, the 1.0V supply
was modeled as a 1.2V supply.

Fix all the incorrect names, and also fix the voltage of the 1.0V
regulator.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 7bbafe926558..f540dcac74ea 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -8,11 +8,13 @@
 #include <arm/cros-ec-keyboard.dtsi>
 
 / {
-	pp1200_mipibrdg: pp1200-mipibrdg {
+	pp1000_mipibrdg: pp1000-mipibrdg {
 		compatible = "regulator-fixed";
-		regulator-name = "pp1200_mipibrdg";
+		regulator-name = "pp1000_mipibrdg";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pp1200_mipibrdg_en>;
+		pinctrl-0 = <&pp1000_mipibrdg_en>;
 
 		enable-active-high;
 		regulator-boot-on;
@@ -24,7 +26,7 @@ pp1800_mipibrdg: pp1800-mipibrdg {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_mipibrdg";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pp1800_lcd_en>;
+		pinctrl-0 = <&pp1800_mipibrdg_en>;
 
 		enable-active-high;
 		regulator-boot-on;
@@ -44,11 +46,11 @@ pp3300_panel: pp3300-panel {
 		gpio = <&pio 35 GPIO_ACTIVE_HIGH>;
 	};
 
-	vddio_mipibrdg: vddio-mipibrdg {
+	pp3300_mipibrdg: pp3300-mipibrdg {
 		compatible = "regulator-fixed";
-		regulator-name = "vddio_mipibrdg";
+		regulator-name = "pp3300_mipibrdg";
 		pinctrl-names = "default";
-		pinctrl-0 = <&vddio_mipibrdg_en>;
+		pinctrl-0 = <&pp3300_mipibrdg_en>;
 
 		enable-active-high;
 		regulator-boot-on;
@@ -144,9 +146,9 @@ anx_bridge: anx7625@58 {
 		pinctrl-0 = <&anx7625_pins>;
 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
-		vdd10-supply = <&pp1200_mipibrdg>;
+		vdd10-supply = <&pp1000_mipibrdg>;
 		vdd18-supply = <&pp1800_mipibrdg>;
-		vdd33-supply = <&vddio_mipibrdg>;
+		vdd33-supply = <&pp3300_mipibrdg>;
 
 		ports {
 			#address-cells = <1>;
@@ -389,14 +391,14 @@ &pio {
 		"",
 		"";
 
-	pp1200_mipibrdg_en: pp1200-mipibrdg-en {
+	pp1000_mipibrdg_en: pp1000-mipibrdg-en {
 		pins1 {
 			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
 			output-low;
 		};
 	};
 
-	pp1800_lcd_en: pp1800-lcd-en {
+	pp1800_mipibrdg_en: pp1800-mipibrdg-en {
 		pins1 {
 			pinmux = <PINMUX_GPIO36__FUNC_GPIO36>;
 			output-low;
@@ -458,7 +460,7 @@ trackpad-int {
 		};
 	};
 
-	vddio_mipibrdg_en: vddio-mipibrdg-en {
+	pp3300_mipibrdg_en: pp3300-mipibrdg-en {
 		pins1 {
 			pinmux = <PINMUX_GPIO37__FUNC_GPIO37>;
 			output-low;
-- 
2.47.0.163.g1226f6d8fa-goog


