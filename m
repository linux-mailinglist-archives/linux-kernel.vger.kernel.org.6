Return-Path: <linux-kernel+bounces-311233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C147E968664
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7929F2855C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC31D679A;
	Mon,  2 Sep 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DalC8QPb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6701D61B7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277256; cv=none; b=N7df23f1dmO6g6ex2pdz3ey/zKEseRnnGIireV1jmSYmrqrFfJrVP3gH2fTexk2XKYQcwpb0l0HrQ5QykUGVvKMmN2v0NlNfWqVUb+SCyMszOJrG/g3TWKczFIf7TwDJWt6B6T4/m+mS7CezWUVax5IYJRI86cDN5KidV+v9hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277256; c=relaxed/simple;
	bh=WZjSZn7Ix4VGFZsgcfGPjlq7g03Ao7iOfM6VPorhKDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0IUWh8wIMjdiOGl9bV2+Hf22/u8OTAqfSswCrQvdrFD7uUEmhjAAnTcE84cZGqrm3O1b4rkaHmWGmk204ovQKD8lhM57/nYVPLiunjs5Hv0jcLwvWerfGVbtHq/ISor5fqGo05EVqGkTLhNOzWzKglGwV2sASV0FpSGo5pBTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DalC8QPb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb8ba2814so5505295e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725277252; x=1725882052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qrNguPwevj9EiI4n7qYkX6uuTLxAsSgFhRYuVf6cA0=;
        b=DalC8QPb1PBmMi2VspfBcbnVvWFLMuFZdaA0plC/U+w0tcLHeR627zy0Z00Ha6ZNyL
         Vw1TBsdB0/8C7MTeESvIFkrAlfGQe1jSug2rQkvT6sjE/Rc88Le/HVNrRoFnWAgwkHl4
         AERSthfjWlxje9bpS20vTw+7DlcPnwhpNuXbCcICC7ztDFBweOviT2P4aNZ7nQrEbyQh
         25JVKu/nWL1xDWwt25CM2cwcR1FF/x4IJg0ZJrfLqegdHZkE2vgemUG/s9HpTEnIdfGg
         vMmccdFBcvTcPygn9qdjYpxzgY5I/Q4aBx3+8aRWfxytuN4m923cA3c3L/YycyinAv/K
         MKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277252; x=1725882052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qrNguPwevj9EiI4n7qYkX6uuTLxAsSgFhRYuVf6cA0=;
        b=pAWIgxPzgiXaRB7FuE6LfHeesJVi7UO31/hDhg2z2odhkLez3LYJYMmsiQUMtmdPuf
         B0RNwMrAlT30O2T8f9uV/UO6O7BSzjpzA6psqyspYu1pzthIzfw+Pl47HI0Q0knX+cWX
         2mMv/6q4iJDq55yezkridQKcemL8DCi2JxM5jcN2afbXp3yeWR9s5/O+g59KTL67JadC
         k1dB3lkOs3VRT57wz+A3EqAlA0hrahsQTbuflEq6/OtmpomSk1U7rKda3bbQ7vXbzEnm
         HxyyDCZ/XaumO+P5hmXyhrETOfJJOeJxQ5J0sqMWV+FLiTsvC39AQXGuN0ewMddR6cS+
         ofTw==
X-Forwarded-Encrypted: i=1; AJvYcCWjC2Es2mJRg4LMK03dZ1ekVxPdcm9u+etFBEh/Heb31j4Yr20UulwRFk0vadLl9Lg5mMxUeqS+PNmNyzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWESb3kBzZmLRkTV4jziqg1zhoUVXnDjF8GNFLcfqcOmBu+xs
	F3mojr89yfZJeE44tWDPkWrRoDJY3WfCru6yHAwzWtBkFEzSXBVNxFUiO45nTHY=
X-Google-Smtp-Source: AGHT+IGBffMA6pYQU9bEPgQ33LBFtBiP1/5sS4ff5HNgB454on1h+A71Ssk2g1MFH1ghDGk2lG1uhg==
X-Received: by 2002:a5d:45cc:0:b0:374:c4c9:d501 with SMTP id ffacd0b85a97d-374c4c9d923mr1235861f8f.10.1725277252168;
        Mon, 02 Sep 2024 04:40:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642594dsm171515245e9.47.2024.09.02.04.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:40:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 02 Sep 2024 13:40:38 +0200
Subject: [PATCH v2 2/4] ARM: dts: imx6ul: align pin config nodes with
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-dts-nxp-imx6-pinctrl-v2-2-ab8196baa07a@linaro.org>
References: <20240902-dts-nxp-imx6-pinctrl-v2-0-ab8196baa07a@linaro.org>
In-Reply-To: <20240902-dts-nxp-imx6-pinctrl-v2-0-ab8196baa07a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=18935;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WZjSZn7Ix4VGFZsgcfGPjlq7g03Ao7iOfM6VPorhKDc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm1aQ8GuTEOb3xLFI+6sp5vBHNoGPfycrDfcoHn
 vxJxk+piYCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZtWkPAAKCRDBN2bmhouD
 1xwgD/4xEQKiQAepYLzWlDB7fbcZvV8AOEyLqXWVyhHLSnoUvUdaYL1QXWcDvNM8zuefh11lqA2
 rk6EvrtE5SFuqR1XJD0hu7UESSGGR08ugiM0ViMDvRBwyO5pGQRnJtlMDfdmjrm1kM8cxoms5rS
 4D3XYb3vadEHTWqikw884LubGAgDUOwRZe5VC66eq6iMP48Cv+Mqsce2ommLBTzv9rv94/9COTz
 z94NeK8Up+7GC28s5A3+lTlZIKdMsuQ2rVmoGF/ZAcRrOA929z8/+ocPP+M+l/DQ/Wl4NA/Fgpf
 6z98K196kl3JXEKEqrYfQ6aD+JJ11X/5hTUtgBZHDSq+rAHbUcAoZJnl7CGMNzkgTeKdekgW1cT
 S0iFnjDDgFbeVV17tXXMui8BQENhvMqMeWONLQwrFTIwTbsb8Wb2fwBFoZ0XJUsPVbSynudOIEX
 6CifTSMTNPfSV0UZjri3ENP8kDW8AmmEBcp+9qWSr0Ztozl3CGD1h0eJFYZmoYuy8/8i3oWX8cd
 lIiWJPkh0htbgMYrEZx8f+6q29aa1x706dhYWgTd4MGR+ejFMpjXjdZHsY9dAvxefmYIh3GW53u
 FbzUua4AUouodG5ZvNbuuVfJDUGMcHBxTCn3p9xBGp2poUrV96gMTmtgW5XL8VlXU1WivHTg3AA
 DsGnrm2RylTLBEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings expect pin configuration nodes in pinctrl to match certain
naming:

  imx6ul-kontron-bl.dtb: pinctrl@20e0000: 'usbotg1' does not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts    |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts        | 14 +++++++-------
 arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi          |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                  |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi                |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts             |  2 +-
 .../boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi  |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi         |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi                | 12 ++++++------
 arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi       |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi           |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts           |  2 +-
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi                     |  6 +++---
 18 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 9cfb99ac9e9d..b74ee8948a78 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -608,7 +608,7 @@ MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x17059 /* SD1 RESET */
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170b9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100b9
@@ -620,7 +620,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170f9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
index ad7f63ca521a..0d3b1ab82eab 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
@@ -112,7 +112,7 @@ MX6UL_PAD_GPIO1_IO04__GPIO1_IO04        0xb0
 		>;
 	};
 
-	pinctrl_ecspi3_master: ecspi3grp1 {
+	pinctrl_ecspi3_master: ecspi3-1-grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
 			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
@@ -121,7 +121,7 @@ MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20	0x10b0 /* Chip Select */
 		>;
 	};
 
-	pinctrl_ecspi3_slave: ecspi3grp2 {
+	pinctrl_ecspi3_slave: ecspi3-2-grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
 			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
index ed61ae8524fa..8aea8c99e2af 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
@@ -248,7 +248,7 @@ MX6UL_PAD_GPIO1_IO03__GPIO1_IO03        0xb0
 		>;
 	};
 
-	pinctrl_ecspi1_master: ecspi1grp1 {
+	pinctrl_ecspi1_master: ecspi1-1-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA20__ECSPI1_SCLK	0x10b0
 			MX6UL_PAD_LCD_DATA22__ECSPI1_MOSI	0x10b0
@@ -309,7 +309,7 @@ MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1020
 		>;
 	};
 
-	pinctrl_lcdif_dat0_17: lcdifdatgrp0-17 {
+	pinctrl_lcdif_dat0_17: lcdifdat0-17-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
 			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01	0x79
@@ -332,14 +332,14 @@ MX6UL_PAD_LCD_DATA17__LCDIF_DATA17	0x79
 		>;
 	};
 
-	pinctrl_lcdif_clken: lcdifctrlgrp1 {
+	pinctrl_lcdif_clken: lcdifctrl-1-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x17050
 			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
 		>;
 	};
 
-	pinctrl_lcdif_hvsync: lcdifctrlgrp2 {
+	pinctrl_lcdif_hvsync: lcdifctrl-2-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x79
 			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x79
@@ -370,7 +370,7 @@ MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x10b0
 		>;
 	};
 
-	pinctrl_sai2_sleep: sai2grp-sleep {
+	pinctrl_sai2_sleep: sai2-sleep-grp {
 		fsl,pins = <
 			MX6UL_PAD_JTAG_TRST_B__GPIO1_IO15	0x3000
 			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x3000
@@ -381,7 +381,7 @@ MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x3000
 		>;
 	};
 
-	pinctrl_uart2_4wires: uart2grp-4wires {
+	pinctrl_uart2_4wires: uart2-4wires-grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
@@ -390,7 +390,7 @@ MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
 		>;
 	};
 
-	pinctrl_uart3_2wires: uart3grp-2wires {
+	pinctrl_uart3_2wires: uart3-2wires-grp {
 		fsl,pins = <
 			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi
index 4a03ea6d24dc..9cc3eebb6b05 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi
@@ -232,7 +232,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3       0x17059
 		>;
 	};
 
-	pinctrl_usdhc1_sleep: usdhc1grp-sleep {
+	pinctrl_usdhc1_sleep: usdhc1-sleep-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__GPIO2_IO16           0x3000
 			MX6UL_PAD_SD1_CLK__GPIO2_IO17           0x3000
@@ -250,7 +250,7 @@ MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x08a0
 		>;
 	};
 
-	pinctrl_wifibt_ctrl_sleep: wifibt-ctrl-grp-sleep {
+	pinctrl_wifibt_ctrl_sleep: wifibt-ctrl-sleep-grp {
 		fsl,pins = <
 			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x3000
 			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x3000
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index 601d89b904cd..2a6bb5ff808a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -410,7 +410,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x17059
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170b9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100b9
@@ -421,7 +421,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170f9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
index ee86c36205f9..118df2a457c9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
@@ -346,7 +346,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x17059
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170b9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100b9
@@ -357,7 +357,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170f9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
index d8f7877349c9..29d2f86d5e34 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
@@ -351,7 +351,7 @@ MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
 		>;
 	};
 
-	pinctrl_usbotg1: usbotg1 {
+	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x1b0b0
 		>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
index 1d863a16bcf0..5e62272acfba 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
@@ -100,7 +100,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
 		>;
 	};
 
-	pinctrl_usb_otg1_vbus: usb-otg1-vbus {
+	pinctrl_usb_otg1_vbus: usb-otg1-vbus-grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x79
 		>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi
index 04477fd4b9a9..4a45fb784ff7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi
@@ -31,7 +31,7 @@ MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x3031	/* DEV WAKEUP */
 		>;
 	};
 
-	pinctrl_uart2_bt: uart2grp-bt {
+	pinctrl_uart2_bt: uart2-bt-grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX   0x17059
 			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX   0x17059
@@ -40,7 +40,7 @@ MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS    0x17059
 		>;
 	};
 
-	pinctrl_usdhc2_wl: usdhc2grp-wl {
+	pinctrl_usdhc2_wl: usdhc2-wl-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA18__USDHC2_CMD    0x10051
 			MX6UL_PAD_LCD_DATA19__USDHC2_CLK    0x10061
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi
index 38ea4dcfa228..bef5eb38a90d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi
@@ -219,7 +219,7 @@ MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b010
 		>;
 	};
 
-	pinctrl_flexcan1: flexcan1 {
+	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x0b0b0
 			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x0b0b0
@@ -275,7 +275,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
@@ -286,7 +286,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index 57e647fc3237..c9c0794f01a2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -202,7 +202,7 @@ MX6UL_PAD_UART2_RX_DATA__GPIO1_IO21	0x4001b8b0
 		>;
 	};
 
-	pinctrl_pmic: pmic {
+	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			/* PMIC irq */
 			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x1b099
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
index ef76ece21010..20c810a81403 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
@@ -198,7 +198,7 @@ MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x0b0b0 /* WLAN_RESET */
 		>;
 	};
 
-	pinctrl_disp0_3: disp0grp-3 {
+	pinctrl_disp0_3: disp0-3-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x10 /* LSCLK */
 			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x10 /* OE_ACD */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index 2567fa52f29b..278120404d31 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -584,7 +584,7 @@ MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x0b0b0 /* LED */
 		>;
 	};
 
-	pinctrl_disp0_1: disp0grp-1 {
+	pinctrl_disp0_1: disp0-1-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x10 /* LSCLK */
 			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x10 /* OE_ACD */
@@ -617,7 +617,7 @@ MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x10
 		>;
 	};
 
-	pinctrl_disp0_2: disp0grp-2 {
+	pinctrl_disp0_2: disp0-2-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x10 /* LSCLK */
 			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x10 /* OE_ACD */
@@ -707,25 +707,25 @@ MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x0b0b0 /* ETN PHY POWER */
 		>;
 	};
 
-	pinctrl_etnphy0_int: etnphy-intgrp-0 {
+	pinctrl_etnphy0_int: etnphy-int-0-grp {
 		fsl,pins = <
 			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x0b0b0 /* ETN PHY INT */
 		>;
 	};
 
-	pinctrl_etnphy0_rst: etnphy-rstgrp-0 {
+	pinctrl_etnphy0_rst: etnphy-rst-0-grp {
 		fsl,pins = <
 			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x0b0b0 /* ETN PHY RESET */
 		>;
 	};
 
-	pinctrl_etnphy1_int: etnphy-intgrp-1 {
+	pinctrl_etnphy1_int: etnphy-int-1-grp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_DATA06__GPIO4_IO27	0x0b0b0 /* ETN PHY INT */
 		>;
 	};
 
-	pinctrl_etnphy1_rst: etnphy-rstgrp-1 {
+	pinctrl_etnphy1_rst: etnphy-rst-1-grp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x0b0b0 /* ETN PHY RESET */
 		>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
index d03694feaf5c..83b9de17cee2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
@@ -169,7 +169,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
@@ -180,7 +180,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
@@ -206,7 +206,7 @@ MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
 			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
@@ -221,7 +221,7 @@ MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
 			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
index 50654dbf62e0..28fddbcdc55e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
@@ -323,7 +323,7 @@ MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x79
 		>;
 	};
 
-	pinctrl_reg_vmmc: usdhc1regvmmc {
+	pinctrl_reg_vmmc: usdhc1regvmmc-grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x17059
 		>;
@@ -394,7 +394,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
@@ -405,7 +405,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
@@ -416,7 +416,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
 		>;
 	};
 
-	pinctrl_usdhc1_cd: usdhc1cd {
+	pinctrl_usdhc1_cd: usdhc1cd-grp {
 		fsl,pins = <
 			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
 		>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
index f5ad6b5c1ad0..278152875f8e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
@@ -102,7 +102,7 @@ MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x0b0b1
 		>;
 	};
 
-	pinctrl_reg_vqmmc: usdhc1regvqmmc {
+	pinctrl_reg_vqmmc: usdhc1regvqmmcgrp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05	0x17059
 		>;
@@ -123,7 +123,7 @@ MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
 			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
@@ -138,7 +138,7 @@ MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
 			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
index c92e4e2f6ab9..6159ed70d966 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
@@ -94,7 +94,7 @@ &wdog1 {
 };
 
 &iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
 			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
index e78d0a7d8cd2..941d9860218e 100644
--- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
@@ -505,7 +505,7 @@ MX6UL_PAD_CSI_HSYNC__UART6_DCE_CTS	0x1b0b1
 		>;
 	};
 
-	pinctrl_uart6dte: uart6dte {
+	pinctrl_uart6dte: uart6dtegrp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_PIXCLK__UART6_DTE_TX	0x1b0b1
 			MX6UL_PAD_CSI_MCLK__UART6_DTE_RX	0x1b0b1
@@ -537,7 +537,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170b9
@@ -552,7 +552,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170f9

-- 
2.43.0


