Return-Path: <linux-kernel+bounces-193483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04F8D2CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A5F1F24DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4471667DE;
	Wed, 29 May 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rYFHf9FC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4E161906
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962295; cv=none; b=b3/ocweu+lRrR7GgjvD0FLzFnFBfim9efjB+9mAF6cElW+BiWg4CjKJno3stpjbmyLXDLbt7FbkBi9zQc1hQs+rCuuDtjpvSKD/2evUxacfmYBTPxy/infmy9m5hVdll02cz53eOiLQS8s6n2iZ9UuhrtA1uKYVEjE/BxF8ReHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962295; c=relaxed/simple;
	bh=RaphsPxL1vAZbHeeRLP1drK+MOl0iOgmrWjVA8BpwOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKZox41n2E7F8o3jEqgIFJ7gSW7Q1+2u8/BdouQKWBouxrkS2FPdDc/0t+N4Zgl7ceLYKKDXNhPiBjJ2l/gWAVc72fNC8ih3s9A1WNKqQO3f9NmVOQg9JtCsW8xqPucLPflTmxYZ59JHI3CVOzSnOFLfL5Ieg1tr0wio3b1WIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rYFHf9FC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421205e8cdeso16699345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716962292; x=1717567092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRW7Z+RxEALad/svOO1raRC4NcXEXhP3a8BeFtPc0+A=;
        b=rYFHf9FC/Z3iTZ4LwbpgffRUzBu2AlhL6QmynOXzMV2Lh4YkKRjtIsPKt2AubGoUrM
         Oxcp4jSkU16zZQwdLbbXjjTVd/ZhJ9WvZywsfookj1qiYWVric1oJAxuUZ1uSvviLHf4
         ymG1EJgIyeX+7mcWlZrerSeKSY6c0HJqDazwQsZf73EAVyoyOglnp9+gGOC2XgZpR21g
         dv/F9qyDMeDTCG3SUn9S6VQevKbK0r97OrnWQWzfVc/fZnN9hgWnUWC1yzccxnlMNCuP
         x1NkVZCFn2wRrb+waD4ZqlW6JXCt1GnVJhxTANVM4ozYyH5aae9ktlnCb6GTLb2bSnym
         /y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962292; x=1717567092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRW7Z+RxEALad/svOO1raRC4NcXEXhP3a8BeFtPc0+A=;
        b=E+BmsHWKsDRKYf6kg0pFVnjMKcw+AiP7b4rPwV3Te8GvxR1vEAWwVeftjr/DvlP3Z6
         4AQtEyvOa+3irVFMhpph54m3tlpIqMOb141AInnrRDpjNnz3KBmC4Fih3yVvxznzDgdU
         QKZW1zrMlYGMf7vacxsqrTsm+5f3G1npltK5P2QAE1mTwQ7PlcSyuYs1+RAOl5cF+pIm
         7keG3pK/be7F1vcWzCJnfIW2b8PT6piTcXf2Yf7h2be69j7PrNswu+qt30S4h9KrBMJN
         /wHx6X48srzT+JSzIjyERjZgeLXq8paE3XMoe5HDIa+TfLRgSOdDHHIWADIJRh6xSu39
         QcBA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Vz3Kp6B5iI7vtZR6dDgiLo3SF9udvSgFg2cpplXfchNx2Qv93jitjE9UC6ZFvR5xKtijne486Nzbfu8OVeCkrumTIuAp2jR15IfG
X-Gm-Message-State: AOJu0YwSsYI8nP29hGILkyovlH2xu5n2hmYSgjL+ES39fUgwNGbkCN13
	ZE90BenyrRM/ueQ1ic4WyI8B1bSicm3XRjwjr+1rc05thA57ZhcTVEDGB2V/Fis=
X-Google-Smtp-Source: AGHT+IGzPi3uV8Qolda3R0jgiKag6ByLgs3ixXBc3FAS908o3cyTyPcfAJb4H+/YejtSLMggLnj/pg==
X-Received: by 2002:a05:600c:296:b0:41f:f32d:d6c with SMTP id 5b1f17b1804b1-42108a53016mr142767015e9.23.1716962292052;
        Tue, 28 May 2024 22:58:12 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm169075435e9.4.2024.05.28.22.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:58:11 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Wed, 29 May 2024 07:58:00 +0200
Subject: [PATCH v6 5/6] arm64: dts: mediatek: mt8188: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-mtk-thermal-mt818x-dtsi-v6-5-0c71478a9c37@baylibre.com>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716962279; l=2943;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=a+N8mpao7+QeANDnMFXYaOS/6MVQmW9fHDWrXbASce8=;
 b=oJuNvvc75KFtnVqOakvIcFJySZhl3GRFOsEwG9SQWUSfhhwM7G3A13Oj4W8Uz/ymTnQFDxFC8
 K6AHaPrYivcClMPXvWfgkF74RG5wHhY1u6HVxiF4XekFmUGkdgZUUKv
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


