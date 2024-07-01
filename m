Return-Path: <linux-kernel+bounces-236687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40091E5C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BD8B21A11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235316C6B4;
	Mon,  1 Jul 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2eRoktf"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60616F0CB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852598; cv=none; b=dn5k82d/7HRMG3t4iJxSBxgis5r8Kt/MsH3M8X+yjNjJBMn0gZXksuBKnw41luPeS/eSMBq8Bu1g7/SpFqBArhzjEz07TecVBVsJYbX6SRv7ovCWc5jbOgav/cxzOLXgnd/fHph/VNB/u8Iy+jN9Tv7Mw2K6DJCsjfsZmxQw1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852598; c=relaxed/simple;
	bh=VesubFE7/W1D628CGgtqIlWWy46LN2JINfLGPyaq7Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrzBRNY+cl1ZLLvVaqcgzsdtnQP6fuCSSvdQ7bx/xfDNkd41TGJChyuqlNri2mtfcHPl5HNFv6jm3TGtANezZBTU2TuP2I4hsv1JPAYn8+Dcoy0R6pKnOX61cDcnveUyJwb9IZF+TsgkSt78YN/mNq8h2WvwrpedvIzPUrEBf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2eRoktf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3658197cdbbso1804643f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719852595; x=1720457395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WYsTFcHc1U6T4hl6euHdIy2ChhnfJYSvBlY2eCJ30o=;
        b=T2eRoktfhh9F3n1zcWFrVfT0kYYIVaFQC3Zw5TkkSjOSGiY8bl6A7jYYFwfxCvGqI3
         0F6aKMCNeLOBKE9tD5spCTNms+7kEvMVS1O4zO//LO48Z/gZeVqq2l4Is0Du5t/5umpE
         9uDV20PNANRb5Vl8qbo6XtBlzM0g/XoNVBerKwM+lFxxB8wSZ4rn/TPZMrsibt29iByn
         7O9JQX0s62vVwQY2cbuQ8YzLldSlbVv6M32UvXhmcOtw8cAoLQXliWwsTw7gDOKpefgu
         6dgbyzgdbyIiFoiEXqgtlXE378rguh1gqYuromkclcf2p3rdRzmB6Q2h/cq6IGTkzir+
         Qy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719852595; x=1720457395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WYsTFcHc1U6T4hl6euHdIy2ChhnfJYSvBlY2eCJ30o=;
        b=bYFlelvgEr4na8QG3N308hzSsusYDO1rq2u4xCVI475MLCGfpb+VbHUZrhk3IxqKeZ
         oT4UTebvhtgC4803V+J8jCdl957RmCLByap6owsEd3MVM6QwB2BjUUQ1w7xpVpg9Cf9e
         CPY26pf3QeDlBijMUzyCvk7oDIST5/4Xpody7Zgmck2ZDF4WRRmNHhkDETmpa32trDin
         NKdrXdtXDBCzJkfu0i1tMwzDrKjA+K5ir6oFrQ9Q5WGf55N8WNBkuJ0v537Hp+7xrRMn
         vyL13mWJ6ZurWDg7yl2WNB+sjwah0QDvN+525ub4O7Ikh400toKVxkNRG3zt5/OGYDRw
         S34g==
X-Forwarded-Encrypted: i=1; AJvYcCVEja75gKma3BmxkZXcsXBrgHNOwhu234pzwpuY/APci55GAT9LYuCN7z05nNbNvLc5OrCPbfYkgr9YY/rlRuNi4mMcLVI+tafe7JAh
X-Gm-Message-State: AOJu0Yxi83ONS854UYp8ljwTn2nAFyGOVmZoRYcoWB9v/E1kKB7ULkg4
	JO3EnFKqHcqQ1PezD08w+EySP+T9aVPQH85NtHBytn4ZvfWYEuCCwsOSUBmFnJA=
X-Google-Smtp-Source: AGHT+IGpvak2bY7pflYuNHWyul4+lpbEDkugsotfcFTVhB4nkxQ+OR3E6SnvILUjQvg31iUOjT89qg==
X-Received: by 2002:a05:6000:1449:b0:35f:2a02:6038 with SMTP id ffacd0b85a97d-36775725989mr5314902f8f.47.1719852595216;
        Mon, 01 Jul 2024 09:49:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba2dsm10559667f8f.73.2024.07.01.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:49:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: microchip: at91: align LED node name with bindings
Date: Mon,  1 Jul 2024 18:49:52 +0200
Message-ID: <20240701164952.577277-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect the LED node names to follow certain pattern, see
dtbs_check warnings:

  at91sam9g15ek.dtb: leds: 'pb18', 'pd21' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/microchip/at91sam9g20ek_2mmc.dts |  4 ++--
 .../at91sam9g25-gardena-smart-gateway.dts     | 24 +++++++++----------
 arch/arm/boot/dts/microchip/at91sam9n12ek.dts |  6 ++---
 arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
index 172af6ff4b18..3e5eab57d1a5 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
@@ -40,13 +40,13 @@ pinctrl_board_mmc0_slot0: mmc0_slot0-board {
 	leds {
 		compatible = "gpio-leds";
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioB 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds5 {
+		led-ds5 {
 			label = "ds5";
 			gpios = <&pioB 8 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
index af70eb8a3a02..e0c1e8df81b1 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
@@ -37,71 +37,71 @@ button {
 	leds {
 		compatible = "gpio-leds";
 
-		power_blue {
+		led-power-blue {
 			label = "smartgw:power:blue";
 			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		power_green {
+		led-power-green {
 			label = "smartgw:power:green";
 			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		power_red {
+		led-power-red {
 			label = "smartgw:power:red";
 			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		radio_blue {
+		led-radio-blue {
 			label = "smartgw:radio:blue";
 			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		radio_green {
+		led-radio-green {
 			label = "smartgw:radio:green";
 			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		radio_red {
+		led-radio-red {
 			label = "smartgw:radio:red";
 			gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		internet_blue {
+		led-internet-blue {
 			label = "smartgw:internet:blue";
 			gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		internet_green {
+		led-internet-green {
 			label = "smartgw:internet:green";
 			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		internet_red {
+		led-internet-red {
 			label = "smartgw:internet:red";
 			gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		heartbeat {
+		led-heartbeat {
 			label = "smartgw:heartbeat";
 			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		pb18 {
+		led-pb18 {
 			status = "disabled";
 		};
 
-		pd21 {
+		led-pd21 {
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/microchip/at91sam9n12ek.dts b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
index 4c644d4c6be7..643c3b2ab97e 100644
--- a/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
@@ -207,19 +207,19 @@ bl_reg: backlight_regulator {
 	leds {
 		compatible = "gpio-leds";
 
-		d8 {
+		led-d8 {
 			label = "d8";
 			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 		};
 
-		d9 {
+		led-d9 {
 			label = "d9";
 			gpios = <&pioB 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 
-		d10 {
+		led-d10 {
 			label = "d10";
 			gpios = <&pioB 6 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
index cdd37f67280b..fb3c19bdfcb6 100644
--- a/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
@@ -120,13 +120,13 @@ rootfs@800000 {
 	leds {
 		compatible = "gpio-leds";
 
-		pb18 {
+		led-pb18 {
 			label = "pb18";
 			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		pd21 {
+		led-pd21 {
 			label = "pd21";
 			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.43.0


