Return-Path: <linux-kernel+bounces-573776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE6A6DC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D60F1890C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241425F782;
	Mon, 24 Mar 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O6OFBJXk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578A25DCE8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824460; cv=none; b=OO7WFercS07hbVnFWi9arPisMIZgAbsGTtrQoeyHVvHppU5tHkQ6prP1iU8/upN6bCa0vJPAxbQ9T0NP5XGa8e9WSkEuDE8bF1+Dxx4rx9Pu8dI6YLTAvlukGyVdm7+ZBZAhgCPth6HbIwnX733O4KzDJB+ROriY3/FdoqL1ECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824460; c=relaxed/simple;
	bh=tVdOnKU51B2x4WqhOEirUsHUGpi24fZC4xipg7NMb4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ahblUcykQJUbpCYc3tcQSjAT2C57917oODfXCaqtX987jxuqVREwHV6N1SBpRIMLUC5l21hy0eAgXug2VkLpqqOhm4pGSOsHIB35ANR/nXOufmdLIt5kSlQyPBzx02hal9jiDWKsssdL6BagSBJVN6f828IYvMS+zRaDiofY9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O6OFBJXk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so27268095e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742824456; x=1743429256; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JR3Vjat4//MGEukixFZKwpNgnByay/aE/Yu8JW2MD0s=;
        b=O6OFBJXkcJMNt9cGZxkIbk6Ke/EpOupnh93rTKePIipNAM8PzhnicE0ImzIpi6S1q5
         K1rvQLMnoJ1zRjFKwCaC10nR+oHdohxYOt4uFTluxQ63YxQhWj51blDOVRpOImbJu6wJ
         mHXwSC7PTnPm3DSKYDQUbM/Z4ALskZzTvcolzE25stJsGb6lE+yiapKUK+KA/xWJsmKk
         o/4iOsvet5njiYENA2I+w6j/s4cfoog8EC0GnNFX/1iJGc2+DGH7p/QoMaUKihjG7aMn
         lNe5l4iby/dvml30ZEKvwCDK2Bvz1Pc3DkWPR7H9lVhlgQzfZsi5b07WkMcmKPVNQ/38
         IyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824456; x=1743429256;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR3Vjat4//MGEukixFZKwpNgnByay/aE/Yu8JW2MD0s=;
        b=Yr7YldJUC0UUVfF2+T+Se13IpEuM8hDEtmf7WxdcK/RQ8q6L8Z+Lc3kRJaz3vRj2+y
         aXBhp+/ji9YkeZcGCAxqZf028IrteIswjcwS6UuFiIANyAH73799c2pEIQSk+HhgD/UK
         zYrsmvITHmNwuj+UX10HanifuFCbRPvcFtFR/7VZaK6zkvy9WEtJ1DD/WbyXni/1l36L
         HQHds7IHlMlGqLO/lTHRiaJBaozAkcAmmdmiBJWAqECr6hv/fcVWeJ2GIH6bNTW5fYYk
         NRjSV5tF6CojhLBN39otkwaDE9wYodt6lVnZtcqQYrPizusLJU1D3fqQi5AqeSrlIFlM
         ZPKw==
X-Forwarded-Encrypted: i=1; AJvYcCWOaQsUf8pKx+MpvbD6imcL2KEI2+CI9oOoQ2YSzc77sR+l9sd2jX4JJwxkt9JxrBpVPYCZUpo4ss/iArk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lE3j4/KQwIXphnfDVYP0+NCWY++uPxAhZPW99zQmBO3wVHrW
	x1pND8faTFqQVlRrSq5USpVnlfLEyD9rT9KPsKUNTn4EMaIxe+Q34UbdcRYd/xY=
X-Gm-Gg: ASbGnctWjH9YpQZX7KdZS62q4SMZRbMiDrHQjHvOtYA4psSsTJH2v/43UtZihuFj5n3
	hgGcv87ro7ZKipWWclQY0o3W15NktPCiFZzdKpGuAdMSYNtOXuOlUmqDBeq68Qmx7jyagX2eCW2
	w3F6akDMpTkpo7qv2ljMjeDpY9B46Pxl1tk6W1aIyfOGWD1WMfrDNTTqVQoGhaAhnu4CCrvY4bF
	/3iN73manFK51UsRBNQco2RRGXUaVeM+0sv2BOK7xZU62aRMMzXdUIo3yHbJHZlHUCyNTQCVvUa
	UYXoMi59PsubfYQKvOHAyC19Ab0jLcdBJkBfhfS2AchwzVA=
X-Google-Smtp-Source: AGHT+IFH33RxIKZKH2JbP0YaKUVRu316Wyz1RxNXnEWmCEW34UaKhoXJkjdKNuiOfa4Hg3Dd/jontA==
X-Received: by 2002:a05:600c:3b29:b0:43d:683:8ca3 with SMTP id 5b1f17b1804b1-43d509e2df8mr89756545e9.5.1742824455740;
        Mon, 24 Mar 2025 06:54:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:5ee:79d0:c587:ed44:4dac:278])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43f43ecbsm170929235e9.10.2025.03.24.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:54:15 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 24 Mar 2025 14:54:08 +0100
Subject: [PATCH RESEND v2] arm64: dts: mediatek: add mmc2 support for
 mt8365-evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-mmc2-support-v2-1-5f660c809610@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 macpaul.Lin@mediatek.com
Cc: vsatoes@baylibre.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6037; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=tVdOnKU51B2x4WqhOEirUsHUGpi24fZC4xipg7NMb4A=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBn4WQGonmqWbjvvOOnuWnTu4FnwVU7xp4VVEVlV95m
 3/HxwSaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZ+FkBgAKCRArRkmdfjHURVzyD/
 0eP8LRNlYpVHgwi3HS2/xN1N9cM+aemGFjdADD0BCVXrDM2npRTrHYB5/aDfwdRamAZO2VUIHR1t/c
 yFAGWCqxYLL2dzIYtW05ZfcbVpB3L0mHZ8Wl/29w4p9omGN3mJdNnpvZaMhz2gdPmRskgUmLUkMQy0
 3VJ7/+01qrMZZuM5Jk9QF2tdwCwBTQGUh2LKgIUMWtxsnrIpBah8zPR6WbGqxmPSp6q/L+XLTpgMMn
 9QurzShlkRBcrixPdTYmxcaocHLT1S4kfeC2obRaAp6C2ynmjkjDXJHS6lGYgU6JA6mNCeN+8Psl7v
 KMNaSioC/i3uCUKJ9/535rHdc34LrluE6LxYxH53L8BPMR9zL7YQd4oMlntERr7d/YW4IkPtrcR8CX
 cVYVWNqjUmcAa/ee0/Wwf2yaw8s5x+DZuN6X9DfLzLCoXH780bz0AMzY8yikO2ZC5yzGKOnCya4i5Y
 aJJ5Kn3brO92pEMhdNjBUkfm+9kspBKlR2swOnfxSauVu+3cuF/yRiPhEqKx7Xy32/ItQGsEhRA/DA
 DxnS6qKAWihMmpGQ3WbuASdGvqq79aRaVit2BPKjgC3fd/q4nj3qRR5zkJLLaqci4/OKup371gdwPp
 Fgbto/RHc7A9hy3sOEi6VA6fzLuo0TBjijhcxtpqsfe+9Gsry/XhdgUMcDzg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Adds support for the MMC2 interface on the MT8365 EVK board.
It introduces a fixed regulator for the MMC2 VDD33 supply and configures
the MMC2 node with a 4-bit bus width, high-speed capabilities, UHS
modes, and appropriate power supplies. Enabled SDIO IRQ, wakeup source,
and kept power during suspend (to save firmware module) for wireless
chip functionality.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- Apply alphabetical order to pinctrl property items.
- Improve commit message
- Link to v1: https://lore.kernel.org/r/20250109-mmc2-support-v1-1-9b9d1b1ae35d@baylibre.com
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 103 +++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 7d90112a7e274..a87f1b3ed6500 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -53,6 +53,15 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0xc0000000>;
 	};
 
+	mmc2_vdd33: mmc2_vdd33-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc2_vdd33";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 121 0>;
+		enable-active-high;
+	};
+
 	usb_otg_vbus: regulator-0 {
 		compatible = "regulator-fixed";
 		regulator-name = "otg_vbus";
@@ -197,6 +206,28 @@ &mmc1 {
 	status = "okay";
 };
 
+&mmc2 {
+	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC50_2_SEL>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	hs400-ds-delay = <0x12012>;
+	keep-power-in-suspend;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-0 = <&mmc2_default_pins>;
+	pinctrl-1 = <&mmc2_uhs_pins>;
+	pinctrl-names = "default", "state_uhs";
+	sd-uhs-sdr104;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	vmmc-supply = <&mmc2_vdd33>;
+	vqmmc-supply = <&mt6357_vcn18_reg>;
+	wakeup-source;
+	status = "okay";
+};
+
 &mt6357_pmic {
 	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-controller;
@@ -324,8 +355,8 @@ cmd-dat-pins {
 				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
 				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
 				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
-			input-enable;
 			bias-pull-up;
+			input-enable;
 		};
 
 		rst-pins {
@@ -337,8 +368,8 @@ rst-pins {
 	mmc0_uhs_pins: mmc0-uhs-pins {
 		clk-pins {
 			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_10mA>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <MTK_DRIVE_10mA>;
 		};
 
 		cmd-dat-pins {
@@ -351,21 +382,21 @@ cmd-dat-pins {
 				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
 				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
 				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_10mA>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <MTK_DRIVE_10mA>;
+			input-enable;
 		};
 
 		ds-pins {
 			pinmux = <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
-			drive-strength = <MTK_DRIVE_10mA>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <MTK_DRIVE_10mA>;
 		};
 
 		rst-pins {
 			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_10mA>;
 			bias-pull-up;
+			drive-strength = <MTK_DRIVE_10mA>;
 		};
 	};
 
@@ -386,16 +417,16 @@ cmd-dat-pins {
 				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
 				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
 				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
-			input-enable;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			input-enable;
 		};
 	};
 
 	mmc1_uhs_pins: mmc1-uhs-pins {
 		clk-pins {
 			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
-			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
 		};
 
 		cmd-dat-pins {
@@ -404,9 +435,63 @@ cmd-dat-pins {
 				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
 				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
 				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
-			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 			drive-strength = <6>;
+			input-enable;
+		};
+	};
+
+	mmc2_default_pins: mmc2-default-pins {
+		clk-pins {
+			pinmux = <MT8365_PIN_81_MSDC2_CLK__FUNC_MSDC2_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <4>;
+		};
+
+		cmd-dat-pins {
+			pinmux = <MT8365_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+				 <MT8365_PIN_83_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+				 <MT8365_PIN_84_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+				 <MT8365_PIN_85_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
+				 <MT8365_PIN_80_MSDC2_CMD__FUNC_MSDC2_CMD>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <4>;
+			input-enable;
+		};
+
+		sys-en-pins {
+			pinmux = <MT8365_PIN_120_DMIC1_CLK__FUNC_GPIO120>;
+			output-low;
+		};
+	};
+
+	mmc2_uhs_pins: mmc2-uhs-pins {
+		clk-pins {
+			pinmux = <MT8365_PIN_81_MSDC2_CLK__FUNC_MSDC2_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
+		};
+
+		cmd-dat-pins {
+			pinmux = <MT8365_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+				 <MT8365_PIN_83_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+				 <MT8365_PIN_84_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+				 <MT8365_PIN_85_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
+				 <MT8365_PIN_80_MSDC2_CMD__FUNC_MSDC2_CMD>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <8>;
+			input-enable;
+		};
+
+		ds-pins {
+			pinmux = <MT8365_PIN_86_MSDC2_DSL__FUNC_MSDC2_DSL>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
+		};
+
+		sys-en-pins {
+			pinmux = <MT8365_PIN_120_DMIC1_CLK__FUNC_GPIO120>;
+			output-high;
 		};
 	};
 

---
base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
change-id: 20250109-mmc2-support-96b3ea516186

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


