Return-Path: <linux-kernel+bounces-185061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA368CB002
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611561F23363
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1A80035;
	Tue, 21 May 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qJ6Hwc2+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868C7F7C5
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300355; cv=none; b=L5uclttVGC9I5inDEs/fTJ7CD2nJcsgeD/XCxnU+DYZ3e/hPyNNfBjdarz70ZIB0/08un3ddh24R897GtI0coEflLV0LrNK00V+5Fb80nWhR4tyWOszz59iaoYd+fAqDoUnpEIJaKz6/AS+k8kM+t/U4cJFWPvT0/CV24odXNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300355; c=relaxed/simple;
	bh=D/CwYxUrwRDdDg8e5n5iJwa+Yitdxw7jjgv7JizLHlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIbh9ENk1Nv76VKqSWU3F1ytkaBh0VmjpzJ+S4pJPjviNekZMbj8LePS56rCr5rigZcoOLB9sbrPkZXu5b4q22dg7e+RA0iHB1RhJiVP+obLowsLs8sYP/3vkOsODdsLSFCEW/HIDZ3gQLOdUbnB2zft3Ngaehk29t99r20ahus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qJ6Hwc2+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202ca70318so29202595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716300352; x=1716905152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwXTa5ISuv1Kx02m8OOMsEkndfJD0rih1gKoinHaSN8=;
        b=qJ6Hwc2+JN5U2S+RR5CSCXCZwf5Bv3biiqn0ZfurmKJ6vOOfmhuKYzZm+dUtjUHctl
         oLkS1ljJyw3f+PsHmsHu4Km7hstfD+u5RG2/J7MdCL7cLeQR8vrFgcc2gXfe0upFJHPT
         hTT0P5zEol9B+XqL1qe9zS1/BfRZrBaL6dXKPxKYrSufWRdkjKrrhqZ49TGCiFqjKVzr
         Q4XB60iuqkaIjU3XU0QNHejyML9qJ1/miKlxMgDbZ3ZjBKKgtgjuaUdpyM7F9SBCg8WH
         VLfAmS4Q2VOKR/0y20vjJBXm0w4H1mLJR4ir6TFGTLMoStlucx2Q1lZgjlGD2wZsASES
         8sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300352; x=1716905152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwXTa5ISuv1Kx02m8OOMsEkndfJD0rih1gKoinHaSN8=;
        b=P+oGLkywvz4MUPLWT95OloL17OfsvU2bBWq3yKvyQCWXrYpCtQp6LzBKP4+5qCmEVJ
         Wav2SgE6mObWbNWtbbxUwSCPjGJ1ES4iHX46JWKDiRENKi+E5txpdNRc144WbxSi1IHX
         +r9qaBbCwzablL4PKcjbBUITOLYYLmFsNuFwGZe4kxmBecJQbofJEudSqrp11SSCXJUv
         Kal1JilNQa/Xa7uWuDWabctup4bSW55CKAiKlpQqHH7ndL5CyEMG4ZgvJNld6Momg+8p
         EdzB+rBrzf/+ABCQUi93U49QLm2OTE/qBxS7ElcGkS0xL6cmzs1bFAWrtnjE4gzGlNl9
         Lh2w==
X-Forwarded-Encrypted: i=1; AJvYcCWQHZ/6PU/IFw56r3q7Fsov/bRxpB+f5Bs6Qps8ZTC+3mGRv2+KDx9hoF+JBLVddUmm126RjI2DCjLOH1f8AWgwSnRVooidf4I/1knH
X-Gm-Message-State: AOJu0YxcMs+wigUK/0j2Z27K0pTRWvt2c+aD/pqEvhFjwgiTf8qBYIBw
	sdx8UkfRc3ccSiJE6vn5Oyh7QNUBUIQ1x/+Qz7hlJoAYHzgNc42ZilhDeI8sY+WiVL+B5HkyIDx
	Z
X-Google-Smtp-Source: AGHT+IGmcQ3zhXcwGKq9p4o4lUrXXiEQ7n47lXZBsIoCw5/9guA9QsF0d6CS+Kcs/jF8lR3BYU6Paw==
X-Received: by 2002:a05:600c:21d5:b0:420:ed93:bca0 with SMTP id 5b1f17b1804b1-420ed93be2amr48817025e9.20.1716300352002;
        Tue, 21 May 2024 07:05:52 -0700 (PDT)
Received: from [127.0.1.1] (abordeaux-651-1-78-161.w90-5.abo.wanadoo.fr. [90.5.97.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42015deac1asm342085945e9.17.2024.05.21.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:05:51 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 21 May 2024 16:05:37 +0200
Subject: [PATCH v4 3/4] arm64: dts: mediatek: mt8188: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mtk-thermal-mt818x-dtsi-v4-3-b91ee678411c@baylibre.com>
References: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
In-Reply-To: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716300346; l=2934;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=UpRqfVTfJj/4HAmfkOjlSQQqb0p0PX5zc+/lgsWNhqY=;
 b=QlwxxxZ+8IMEsZ1KOsNLteR7x+69FK/C7WOhQnM3tCwzAiPWf4eqocPeOLgGz5mYgXKfSnXrW
 ag145bsqnZ7BAnVx5kKVFz5biNQeMyaroUGbCeVtlwoY4LGAtDJ8dfV
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
index b4315c9214dc..a9f1b9db54a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
+#include <dt-bindings/reset/mt8188-resets.h>
 
 / {
 	compatible = "mediatek,mt8188";
@@ -357,6 +358,7 @@ infracfg_ao: syscon@10001000 {
 			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		pericfg: syscon@10003000 {
@@ -491,6 +493,17 @@ spi0: spi@1100a000 {
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
@@ -604,6 +617,17 @@ mmc1: mmc@11240000 {
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
@@ -827,6 +851,17 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
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
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt8188-mfgcfg";
 			reg = <0 0x13fbf000 0 0x1000>;

-- 
2.37.3


