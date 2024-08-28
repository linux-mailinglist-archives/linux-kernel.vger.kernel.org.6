Return-Path: <linux-kernel+bounces-304736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C389D962424
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4451F1F2195A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779D16BE1F;
	Wed, 28 Aug 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdTaWISy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44F16B384
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839008; cv=none; b=R1sTY5rK8a4WGoAnqlaisDZZGI3OtSssd3II0L6HpmAYn3wvtUwTQttC3klIn1N9rzYPvy1YhRq7i5Tc2RoraVCoDztitxCTh1J8JFfGNGkAR9Ilho6rbapGtKkyDNFHZR682c+ujF32TzrysMysWS0Y54WOc5fhKdzuAkgzisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839008; c=relaxed/simple;
	bh=1iMd1q7rX6vsSXbhj3ohXTZxeKdF4WYLhtuXkH6hUqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ8wTwLydrdxluyI0sSIYbgbIaScUn6HjJTf4FXkFLNH4P1g6g+DX4d5shI5oXOfFmt1hMJQg02L6pGBctkdJFnHA3yb80B4coQxb+SgAA/29PjfMq1nG+7ta45ApL9F8xgxVNM67ab526nIY/C5Ssb6ov4PHCP13VV7TwandsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdTaWISy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4290075c7e1so8195405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724839004; x=1725443804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5svEi1xLQ8wE+GfQEbQrZ0tIUKTdgCq1EM5fOzmkKVA=;
        b=OdTaWISyhdj0mrBsyQFeoTM37BAkS8sJD69LgMPlN0RS0OcxBxPImvA2ltBBaWK4lU
         JKcAbhQhbQrSB5pe0Gq2dIrKgbuQMvsZNpYV3dXlbgKGqxHmlSsc7LBLVeZxVaTF92Wr
         j1jivyoBQDqxfxxTygCTGPTGisFDi8cCSDUa2uGWwddn676yMcNQKGRb5qTTOJiOtBna
         Whni+vwkeaPk6Nr7jP3qh7cQ+CQTHZutBppDd6eiXeBpzEc/HCd+vo1PUNgrp7kHvwit
         d6Zryz/RymGZa6/QWtuYDyo58cMgENBRyiABHd7SPbDHWU0qpJN43AmhAz+U00tbKGrz
         3RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839004; x=1725443804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5svEi1xLQ8wE+GfQEbQrZ0tIUKTdgCq1EM5fOzmkKVA=;
        b=rw5sP+LwwS6U1XujDM58+GYC9qUEtUBJDZ48gHNT4QjeQnpkJt+d0Uvz3SZcsialtX
         xyMTlD6UUdNbqS4L37cuXrncb++GRDrulGDezFq2gq4yv66vqgKdxDhdU5WrwnzYFqIp
         II5mQDMArxIjvyyfbssETVguBozCBiSppufOB+B44e+jwkj9WHZxlpzjnXZu+C5voxTJ
         0Z3B32y+BaODV+ty3u9zZBmN7DEkAUH062D4FqE1nzflKMtzeWxyLLoxFOfvNrflAojm
         UFVrWC2vYZdiPmXy1aJFSzUO2Nrraf20OZa4g3yZTCdMhQeRXd4u1+7BPcweT8qvXCmP
         ae6w==
X-Forwarded-Encrypted: i=1; AJvYcCW5eJEZbQKliQ96XH369NefkwR3fWdYLY+krjZKgT3JeTurESoCGSQOJoDEjvVLNW2izDcwSxuSxOr7F3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5H0AiLK45JQ5mjoVqAnw7m/n5epFMVr/rCKuw9upTuRYooy/
	TxhQHbEEMB9RY190vsUafYHQjLVJ39CdZTQ2dKeF3dMQSmYFBgKklfFyi0ISdfo=
X-Google-Smtp-Source: AGHT+IFn2UqZNMBnO7/rGTPmAwR15v5XtKMxrhTo+jLaSB2mrMfJC92+R+D9ZMAI1bvVzUBHw2ThpA==
X-Received: by 2002:a5d:6c6f:0:b0:367:90a8:4d3b with SMTP id ffacd0b85a97d-3731185b259mr6637991f8f.3.1724839004510;
        Wed, 28 Aug 2024 02:56:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb33sm15067077f8f.13.2024.08.28.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:56:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: imx7: align pin config nodes with bindings
Date: Wed, 28 Aug 2024 11:56:37 +0200
Message-ID: <20240828095638.231569-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
References: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect pin configuration nodes in pinctrl to match certain
naming:

  imx7s-colibri-eval-v3.dtb: pinctrl@30330000: 'lvdstx' does not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
  imx7s-warp.dtb: pinctrl@30330000: 'usdhc3grp_100mhz', 'usdhc3grp_200mhz' do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi     | 20 +++++++++----------
 .../boot/dts/nxp/imx/imx7d-remarkable2.dts    |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts      |  4 ++--
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
index 9fe51884af79..62e41edcaf1d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
@@ -903,7 +903,7 @@ MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79 /* SODIMM 82 */
 		>;
 	};
 
-	pinctrl_lvds_transceiver: lvdstx {
+	pinctrl_lvds_transceiver: lvdstxgrp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2     0x14 /* SODIMM 63 */
 			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3     0x74 /* SODIMM 55 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
index 9c6476bda4a0..7ee66be8bccb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
@@ -419,7 +419,7 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog_1 &pinctrl_j2>;
 
-	pinctrl_hog_1: hoggrp-1 {
+	pinctrl_hog_1: hoggrp {
 		fsl,pins = <
 			MX7D_PAD_SD3_RESET_B__GPIO6_IO11	0x5d
 			MX7D_PAD_GPIO1_IO13__GPIO1_IO13		0x7d
@@ -665,7 +665,7 @@ &iomuxc_lpsr {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog_2>;
 
-	pinctrl_hog_2: hoggrp-2 {
+	pinctrl_hog_2: hoggrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x7d
 			MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2	0x7d
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
index 8d5037ac03c7..a1574ccec89c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
@@ -444,14 +444,14 @@ MX7D_PAD_SD3_RESET_B__GPIO6_IO11		0x1  /* Ethernet reset */
 		>;
 	};
 
-	pinctrl_can1: can1frp {
+	pinctrl_can1: can1frpgrp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_RX_DATA__FLEXCAN1_RX	0x59
 			MX7D_PAD_SAI1_TX_BCLK__FLEXCAN1_TX	0x59
 		>;
 	};
 
-	pinctrl_can2: can2frp {
+	pinctrl_can2: can2frpgrp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_TX_SYNC__FLEXCAN2_RX	0x59
 			MX7D_PAD_SAI1_TX_DATA__FLEXCAN2_TX	0x59
@@ -499,19 +499,19 @@ MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14
 		>;
 	};
 
-	pinctrl_pwm1: pwm1 {
+	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO08__PWM1_OUT	0x7f
 		>;
 	};
 
-	pinctrl_pwm2: pwm2 {
+	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO09__PWM2_OUT	0x7f
 		>;
 	};
 
-	pinctrl_pwm3: pwm3 {
+	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO10__PWM3_OUT	0x7f
 		>;
@@ -563,7 +563,7 @@ MX7D_PAD_ECSPI2_MISO__UART7_DCE_RTS	0x79
 		>;
 	};
 
-	pinctrl_usbotg1_pwr: usbotg_pwr {
+	pinctrl_usbotg1_pwr: usbotgpwrgrp {
 		fsl,pins = <
 			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
 		>;
@@ -581,7 +581,7 @@ MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
 			MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
@@ -593,7 +593,7 @@ MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
 			MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
@@ -631,7 +631,7 @@ MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
@@ -646,7 +646,7 @@ MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-remarkable2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-remarkable2.dts
index 92cb45dacda6..eec526a96311 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-remarkable2.dts
@@ -508,7 +508,7 @@ MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
 			MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
@@ -519,7 +519,7 @@ MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5a
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
 			MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
@@ -546,7 +546,7 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
@@ -562,7 +562,7 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1a
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
index 7bab113ca6da..af4acc311572 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
@@ -459,7 +459,7 @@ MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x19
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
@@ -475,7 +475,7 @@ MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x1a
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
-- 
2.43.0


