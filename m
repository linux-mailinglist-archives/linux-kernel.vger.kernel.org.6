Return-Path: <linux-kernel+bounces-198999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149E8D8050
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD228A01C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC33839FF;
	Mon,  3 Jun 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bNbNt+JF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A484A30
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411871; cv=none; b=K0HNFPkQUeXjzN3GtkOp8R97LLwrE3LZlXF/gu+bbVYbREKMh57iQ3Mom4CrbeWD91Lg3ffB4tSAOTGHruu6DLyoygDgphyfqESOGqxhN8SSTpCkR0NJU5Wu/OsUcB8yi5pE5BE1qeASb2fApqK7Qqow9ZUai1SMYmvtga7+8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411871; c=relaxed/simple;
	bh=RaphsPxL1vAZbHeeRLP1drK+MOl0iOgmrWjVA8BpwOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aefdmStxJQDZmF2MgBucR7YJD3T+6QWCDdEluJ7ZJGDw2iQF3tpLznS5oNJ3u0ek4zNTuvV+FRvgkJmgMT2GS49zrUR0mH9AuGQbuYoynmFuIB6t5OEYnKDvHL9UyhMZvz1O/D/l6Xxy+7N/ib+QiDN2E6tVorqomNc6IVpavPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bNbNt+JF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa80cb550so19282881fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717411868; x=1718016668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRW7Z+RxEALad/svOO1raRC4NcXEXhP3a8BeFtPc0+A=;
        b=bNbNt+JFXSwT0U5zVuqRAbfppM285KssyZ660ND/rQZ3aWIUyPwHs6ez6Kaop4Q3th
         Ko7Jae2CIBYAmfkpr53vcqHykK3WGOba5qj/rIj6FkcMDuQShAq1OlonOKfbQJccAxh7
         pD3QfAn5WZj4hvJEcPjo5pP+2rti7wbN7Rou08c38Yvg8zNe0WGSkWohYzo0+Noh6L8s
         t4qk8HQyzqRAqe0fgeWtWs8JGlGr+VHXkoHtDPO0KLzFSFGOathM2SlOHwKUNljHVMKA
         /M1DeiA8nbkqsvoT5icX73NoGvJoF1LMnwNnTO/f29L9ozEAGuuQhS3Ah4bawn/mDvhr
         7VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717411868; x=1718016668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRW7Z+RxEALad/svOO1raRC4NcXEXhP3a8BeFtPc0+A=;
        b=vnyAsxjJr0cSxhMV/Wa1Os6f091Z8AgjmIPmYf4NTsZOkg/9l66WjjEYH5LCilPnI0
         M8+kNnBRFatpnMlG6kNE69pVMEb7eVobLEXuShYKHoEpT+QZxxLg8g02pthaUUovBeEo
         hSdgKT+a44FOx3WxBNzzeKfxrJpgtF3hhqYdAgk6f66eV0kCbxqhNyQicaaRnzgcgrqn
         8dx8SMiXTcCwoaxR9gFEVnZuHC4QozGOnFqz5E+uBH0oinYSNOSlRqE+7HXrRDwpq2+l
         GG8GBvt+S4uPl5k2yZfxfVfG5KEUacnIhJFxPFxgUKF7LtzUbznxJUpmFYlYcUqt+r0u
         sqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXS3qhJE9+HXXzrlek0dGOx9cIl3TNa3CFJo7lveFcTA9nNojRx2dgejmFn209nLnkWSyr3v/6lumPSGj1vjqNwALcYjHxccHD2ZIGI
X-Gm-Message-State: AOJu0YwXUepG0en7MEML2EKO396Kfzm4/4QB6Pu/C/3jIBpR/IrxTpVH
	/w4Ui4wcoeXp1LsDnz5T1EandqU4mmxipwFzu1mwaq167BDxA2+xUlWqN86IcV4=
X-Google-Smtp-Source: AGHT+IEGQ/xC8cX47PtpinhY28EGaWP+Mr4APwZrrd6T4OFRq3QMU1+xhuIu0AkIriafaOGRhgkcGg==
X-Received: by 2002:a2e:b615:0:b0:2ea:7d47:82a3 with SMTP id 38308e7fff4ca-2ea9519b87emr58662711fa.37.1717411867679;
        Mon, 03 Jun 2024 03:51:07 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133227f8asm95372535e9.19.2024.06.03.03.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 03:51:07 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 03 Jun 2024 12:50:52 +0200
Subject: [PATCH v7 5/6] arm64: dts: mediatek: mt8188: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-mtk-thermal-mt818x-dtsi-v7-5-8c8e3c7a3643@baylibre.com>
References: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
In-Reply-To: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717411855; l=2943;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=a+N8mpao7+QeANDnMFXYaOS/6MVQmW9fHDWrXbASce8=;
 b=nPcjEmvEDQuDtpxAh7mvZz2ffsRr5fj3qPdL3X5DhgO6KVn3q8ZDpj1hjVdfG5wxvVClk3weC
 QqeeaNkkDhlBBnKbra1B7aOJADUxtXQsEYidq8Xne/9nTcyJKSxyLXL
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://lore.kernel.org/r/20240402032729.2736685-14-nico@fluxnic.net
[Angelo: Fixed wrong nvmem-cell-names]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 29d012d28edb..02786fe9891b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
+#include <dt-bindings/reset/mt8188-resets.h>
 
 / {
 	compatible = "mediatek,mt8188";
@@ -464,6 +465,7 @@ infracfg_ao: syscon@10001000 {
 			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		pericfg: syscon@10003000 {
@@ -937,6 +939,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8188-lvts-ap";
+			reg = <0 0x1100b000 0 0xc00>;
+			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8188_INFRA_RST1_THERMAL_CTRL_RST>;
+			nvmem-cells = <&lvts_efuse_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
 			#address-cells = <1>;
@@ -1050,6 +1063,17 @@ mmc1: mmc@11240000 {
 			status = "disabled";
 		};
 
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8188-lvts-mcu";
+			reg = <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8188_INFRA_RST1_THERMAL_MCU_RST>;
+			nvmem-cells = <&lvts_efuse_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		i2c0: i2c@11280000 {
 			compatible = "mediatek,mt8188-i2c";
 			reg = <0 0x11280000 0 0x1000>,
@@ -1273,6 +1297,17 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11f20000 {
+			compatible = "mediatek,mt8188-efuse", "mediatek,efuse";
+			reg = <0 0x11f20000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_efuse_data1: lvts1-calib@1ac {
+				reg = <0x1ac 0x40>;
+			};
+		};
+
 		gpu: gpu@13000000 {
 			compatible = "mediatek,mt8188-mali", "arm,mali-valhall-jm";
 			reg = <0 0x13000000 0 0x4000>;

-- 
2.37.3


