Return-Path: <linux-kernel+bounces-304737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C96962426
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55801F212E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0819416C44C;
	Wed, 28 Aug 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz66jj9m"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93A16B72D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839010; cv=none; b=MKhIpysujlzj858VRQGUTUz9cbWk8F2Leb4ejy1/mRnj8NLb76AIfvY6Tz2WqJQYHSYPzaDdvW4jzg3owySAzPXhinxkbCZjkfYQWyLufRhb/4lQWOJ52Lg4FQMxcCS1cnlCU9mhz0IKDjzLcVTd/h5ycD1pRDJVBpenA/t5Ayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839010; c=relaxed/simple;
	bh=4IMYrKTfIIBnluDt6DNfa5usHodP8v3hg4+zXa6ic+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/qITxLcvLqzIx18VMICYPOJij57kASIM/6oPPm0JfoTSkP0K3yF/P53Qj1n9ysIqvAjt8QUGVzZm1k7fd4YYXJuZbn1zV947YMaRBjPhnVITl7khrolXPtR+Vz48HnfBxLp7UdyyZ6aFMBmwmQ/xGSw1ZvIZvWkgjQwxAcz46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fz66jj9m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42808a69a93so9238465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724839006; x=1725443806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8OaldaUE0inX4SY2oD1BjCaoWFJvoM+Pyb4Oy9khmI=;
        b=Fz66jj9m1kAURhYuRT3DGiVrJW408JL6tZPZhwaqwnTN5Dqg9szcag2e2QVKDeMwpj
         aWW8bqIUvYb95AE/uU19hQ9Yg37fo50yQMVU0vd+nDd43RwKqGefxHjj+woyCFcmzuHs
         0r6JimNaNMqyiIrHX8QiqpH9pQQ+lwbx4SorGlThDrHWJfFr4SDDJfRJhxYLGCwBwhGG
         uLSUKVrnw7dHcM11jbLbXHwBtHzr7ai/MqERnI9yXXzhzKSwC/cog+zMC7K9GMlGWNjg
         d9aYUU2iN0NkxjjdE+RV0O9QtMSXmEcfp/zWupi33svOE4YgGwz5F0GWeSe46jZJTxm5
         rvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839006; x=1725443806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8OaldaUE0inX4SY2oD1BjCaoWFJvoM+Pyb4Oy9khmI=;
        b=MxkY2bNamQqceL1/rQaGDEAkxRNeCwlPeW1u40EC3ab8uRBkG3v4Tesb7vVQzUyGUp
         vcJzMjQfIiLaOFzc3MWPn0sy1XPipdlg1RnBh9yM8rZRYkyAQO6fiemOko77De5NgsVr
         bUWScm/DXNjR4PiemCkwYZQ567lCe0xVkTCSFMsd4fASEb+Eu7UspFDzszVKuJ8xLgva
         X55K1VKmE8RZAecmvVmiaP0Cex0b05yMs916ePAfB2L+HkvspRcKBOc58e3MT51nA5uJ
         TaHHScMMFgSOgh15aRouQ/IdNVxscNMdfMFozZkNJuYo8/ySB8r2XAeL6nh0XxJlJz9l
         QY9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOp+wTzX2WiKdicw49w3M7pI6EZWafjmtjNpQCPVxm7CialWIGIGKl3dtCuhJX3caZn/zlXzjRzcmoGIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/je+ispsb9rRQJt7PFgYmjXn9QN7lMyNEKjNYCh6tvxVf9Cc
	s5MqgfHby1IV2DQzhTcPfBMG4Ocu0x93HURDdMprl/eSXx4/BD2wfX5NS8xB+ZQ=
X-Google-Smtp-Source: AGHT+IEj/QnthsYGVW789KDEhZbu1fGgIY4vzoB/p5f9swn6+ACDOTpJaa//HvGHVIM1GoVpXFsPMQ==
X-Received: by 2002:a05:6000:178a:b0:368:4c5:1b5a with SMTP id ffacd0b85a97d-373118e9be9mr6203079f8f.9.1724839006103;
        Wed, 28 Aug 2024 02:56:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb33sm15067077f8f.13.2024.08.28.02.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:56:45 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: imx7d-sdb: align pin config nodes with bindings
Date: Wed, 28 Aug 2024 11:56:38 +0200
Message-ID: <20240828095638.231569-4-krzysztof.kozlowski@linaro.org>
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
naming and not be part of another fake node:

  imx7d-sdb-sht11.dtb: pinctrl@30330000: 'imx7d-sdb' does not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Drop the "imx7d-sdb" wrapping node and adjust the names to have "grp"
prefix.  Diff looks big but this should have no functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts |  30 +-
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts      | 608 +++++++++----------
 2 files changed, 317 insertions(+), 321 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts
index cabdaa6dc518..40156cd9195f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts
@@ -21,23 +21,21 @@ &fec2 {
 };
 
 &iomuxc {
-	imx7d-sdb {
-		pinctrl_tsc2046_pendown: tsc2046_pendown {
-			fsl,pins = <
-				MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x59
-			>;
-		};
+	pinctrl_tsc2046_pendown: tsc2046-pendowngrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x59
+		>;
+	};
 
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
-			>;
-		};
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
+		>;
+	};
 
-		pinctrl_usb_otg2_vbus_reg_reva: usbotg2vbusregrevagrp {
-			fsl,pins = <
-				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
-			>;
-		};
+	pinctrl_usb_otg2_vbus_reg_reva: usbotg2vbusregrevagrp {
+		fsl,pins = <
+			MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
+		>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index 0462e43ec09b..f712537fca16 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -537,342 +537,340 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx7d-sdb {
-		pinctrl_brcm_reg: brcmreggrp {
-			fsl,pins = <
-				MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x14
-			>;
-		};
+	pinctrl_brcm_reg: brcmreggrp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x14
+		>;
+	};
 
-		pinctrl_ecspi3: ecspi3grp {
-			fsl,pins = <
-				MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO	0x2
-				MX7D_PAD_SAI2_TX_BCLK__ECSPI3_MOSI	0x2
-				MX7D_PAD_SAI2_RX_DATA__ECSPI3_SCLK	0x2
-				MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x59
-			>;
-		};
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO	0x2
+			MX7D_PAD_SAI2_TX_BCLK__ECSPI3_MOSI	0x2
+			MX7D_PAD_SAI2_RX_DATA__ECSPI3_SCLK	0x2
+			MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x59
+		>;
+	};
 
-		pinctrl_enet1: enet1grp {
-			fsl,pins = <
-				MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x3
-				MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x3
-				MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
-				MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
-				MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
-				MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
-				MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
-				MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
-				MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
-				MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
-				MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
-				MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
-				MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
-				MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
-			>;
-		};
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x3
+			MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x3
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+		>;
+	};
 
-		pinctrl_enet2: enet2grp {
-			fsl,pins = <
-				MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x1
-				MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x1
-				MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x1
-				MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x1
-				MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x1
-				MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x1
-				MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x1
-				MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x1
-				MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x1
-				MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x1
-				MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x1
-				MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x1
-			>;
-		};
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x1
+			MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x1
+			MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x1
+			MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x1
+			MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x1
+			MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x1
+			MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x1
+			MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x1
+			MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x1
+			MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x1
+			MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x1
+			MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x1
+		>;
+	};
 
-		pinctrl_enet2_reg: enet2reggrp {
-			fsl,pins = <
-				MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x14
-			>;
-		};
+	pinctrl_enet2_reg: enet2reggrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x14
+		>;
+	};
 
-		pinctrl_flexcan2: flexcan2grp {
-			fsl,pins = <
-				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
-				MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
-			>;
-		};
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
+			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
+		>;
+	};
 
-		pinctrl_flexcan2_reg: flexcan2reggrp {
-			fsl,pins = <
-				MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x59	/* CAN_STBY */
-			>;
-		};
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x59	/* CAN_STBY */
+		>;
+	};
 
-		pinctrl_gpio_keys: gpio_keysgrp {
-			fsl,pins = <
-				MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
-				MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
-			>;
-		};
+	pinctrl_gpio_keys: gpio-keysgrp {
+		fsl,pins = <
+			MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
+			MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
+		>;
+	};
 
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
-				MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59  /* headphone detect */
-			>;
-		};
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
+			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59  /* headphone detect */
+		>;
+	};
 
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
-				MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
-			>;
-		};
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
+			MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
+		>;
+	};
 
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <
-				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-				MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
-			>;
-		};
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+		>;
+	};
 
-		pinctrl_i2c3: i2c3grp {
-			fsl,pins = <
-				MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
-				MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
-			>;
-		};
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+		>;
+	};
 
-		pinctrl_i2c4: i2c4grp {
-			fsl,pins = <
-				MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
-				MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f
-			>;
-		};
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
+			MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f
+		>;
+	};
 
-		pinctrl_lcdif: lcdifgrp {
-			fsl,pins = <
-				MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
-				MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
-				MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
-				MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
-				MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
-				MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
-				MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
-				MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
-				MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
-				MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
-				MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
-				MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
-				MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
-				MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
-				MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
-				MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
-				MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
-				MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
-				MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
-				MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
-				MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
-				MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
-				MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
-				MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
-				MX7D_PAD_LCD_CLK__LCD_CLK		0x79
-				MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
-				MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
-				MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
-				MX7D_PAD_LCD_RESET__LCD_RESET		0x79
-			>;
-		};
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
 
-		pinctrl_sai1: sai1grp {
-			fsl,pins = <
-				MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
-				MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
-				MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
-				MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
-				MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
-			>;
-		};
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
+			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
+			MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
+			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+		>;
+	};
 
-		pinctrl_sai2: sai2grp {
-			fsl,pins = <
-				MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK     0x1f
-				MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC     0x1f
-				MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0    0x30
-				MX7D_PAD_SAI2_RX_DATA__SAI2_RX_DATA0    0x1f
-			>;
-		};
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK     0x1f
+			MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC     0x1f
+			MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0    0x30
+			MX7D_PAD_SAI2_RX_DATA__SAI2_RX_DATA0    0x1f
+		>;
+	};
 
-		pinctrl_sai3: sai3grp {
-			fsl,pins = <
-				MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK   0x1f
-				MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC     0x1f
-				MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0    0x30
-			>;
-		};
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK   0x1f
+			MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC     0x1f
+			MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0    0x30
+		>;
+	};
 
-		pinctrl_spi4: spi4grp {
-			fsl,pins = <
-				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
-				MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
-				MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
-			>;
-		};
+	pinctrl_spi4: spi4grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
+			MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
+			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
+		>;
+	};
 
-		pinctrl_tsc2046_pendown: tsc2046_pendown {
-			fsl,pins = <
-				MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
-			>;
-		};
+	pinctrl_tsc2046_pendown: tsc2046-pendowngrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
+		>;
+	};
 
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
-			>;
-		};
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
+			MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
+		>;
+	};
 
-		pinctrl_uart5: uart5grp {
-			fsl,pins = <
-				MX7D_PAD_SAI1_TX_BCLK__UART5_DCE_TX	0x79
-				MX7D_PAD_SAI1_RX_DATA__UART5_DCE_RX	0x79
-				MX7D_PAD_SAI1_TX_SYNC__UART5_DCE_CTS	0x79
-				MX7D_PAD_SAI1_TX_DATA__UART5_DCE_RTS	0x79
-			>;
-		};
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_TX_BCLK__UART5_DCE_TX	0x79
+			MX7D_PAD_SAI1_RX_DATA__UART5_DCE_RX	0x79
+			MX7D_PAD_SAI1_TX_SYNC__UART5_DCE_CTS	0x79
+			MX7D_PAD_SAI1_TX_DATA__UART5_DCE_RTS	0x79
+		>;
+	};
 
-		pinctrl_uart6: uart6grp {
-			fsl,pins = <
-				MX7D_PAD_ECSPI1_MOSI__UART6_DCE_TX	0x79
-				MX7D_PAD_ECSPI1_SCLK__UART6_DCE_RX	0x79
-				MX7D_PAD_ECSPI1_SS0__UART6_DCE_CTS	0x79
-				MX7D_PAD_ECSPI1_MISO__UART6_DCE_RTS	0x79
-			>;
-		};
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI1_MOSI__UART6_DCE_TX	0x79
+			MX7D_PAD_ECSPI1_SCLK__UART6_DCE_RX	0x79
+			MX7D_PAD_ECSPI1_SS0__UART6_DCE_CTS	0x79
+			MX7D_PAD_ECSPI1_MISO__UART6_DCE_RTS	0x79
+		>;
+	};
 
-		pinctrl_usdhc1_gpio: usdhc1_gpiogrp {
-			fsl,pins = <
-				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
-				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
-				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
-				MX7D_PAD_GPIO1_IO08__SD1_VSELECT	0x59 /* VSELECT */
-			>;
-		};
+	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
+			MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
+			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
+			MX7D_PAD_GPIO1_IO08__SD1_VSELECT	0x59 /* VSELECT */
+		>;
+	};
 
-		pinctrl_usdhc1: usdhc1grp {
-			fsl,pins = <
-				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
-				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
-				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
-				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
-				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
-				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
-			>;
-		};
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+		>;
+	};
 
-		pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
-			fsl,pins = <
-				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
-				MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
-				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
-				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
-				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
-				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
-			>;
-		};
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
+		>;
+	};
 
-		pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
-			fsl,pins = <
-				MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
-				MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
-				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
-				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
-				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
-				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
-			>;
-		};
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
+		>;
+	};
 
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				MX7D_PAD_SD2_CMD__SD2_CMD		0x59
-				MX7D_PAD_SD2_CLK__SD2_CLK		0x19
-				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
-				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
-				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
-				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
-			>;
-		};
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x19
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
+		>;
+	};
 
-		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
-			fsl,pins = <
-				MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
-				MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
-				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
-				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
-				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
-				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5a
-			>;
-		};
+	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5a
+		>;
+	};
 
-		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
-			fsl,pins = <
-				MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
-				MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
-				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
-				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
-				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
-				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5b
-			>;
-		};
+	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5b
+		>;
+	};
 
 
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-				MX7D_PAD_SD3_CLK__SD3_CLK		0x19
-				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
-				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
-				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
-				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
-				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
-				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
-				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
-				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
-				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
-			>;
-		};
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
+			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
+		>;
+	};
 
-		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
-			fsl,pins = <
-				MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
-				MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
-				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
-				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
-				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
-				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5a
-				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5a
-				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5a
-				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5a
-				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
-				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1a
-			>;
-		};
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5a
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5a
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5a
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5a
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
+			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1a
+		>;
+	};
 
-		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
-			fsl,pins = <
-				MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
-				MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
-				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
-				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
-				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
-				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5b
-				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5b
-				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5b
-				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5b
-				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5b
-				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1b
-			>;
-		};
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5b
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5b
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5b
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5b
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5b
+			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1b
+		>;
 	};
 };
 
@@ -901,7 +899,7 @@ MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	  0x14
 		>;
 	};
 
-	pinctrl_sai3_mclk: sai3grp_mclk {
+	pinctrl_sai3_mclk: sai3-mclk-grp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO03__SAI3_MCLK	0x1f
 		>;
-- 
2.43.0


