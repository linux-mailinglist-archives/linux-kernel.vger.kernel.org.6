Return-Path: <linux-kernel+bounces-249056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A392E584
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B00FB23221
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978416B753;
	Thu, 11 Jul 2024 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiWWq9+S"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4F16B3B5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696066; cv=none; b=WkltDb6uV4+Kv5X9tBucjbaWIz9Hw53HGC3pZ4eMLLfVy+uzKTmcNWZUP7W4G4uPsgM8bkXm+u2ndUgFTh1Uv9lwbOs9lJngiCJYlXUIgKfUe7JIYFbxVCQOfolvzatacARxXa16p1pMvvjT00+eDtSWmTyTaEF9xlU0mzBvb3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696066; c=relaxed/simple;
	bh=vRkPSZqqP2Ub9QQ0bedvniV/QeQePhUuQpL6De/PvEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3FymaR1gxhk4kiAXK3b37p38422XIDCa6SVAnEcEIeoGXp6cfIthIhyanO8cONP/hU4ROmgvMcP6kwS+RmvEcG7PvayK1GkQDeHHR+VqjpYF43XiOHvF5mVkZHq/COSCy9xSP2STSI0ug5/VxofM3/y0070RDdtO91bcFjleLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiWWq9+S; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea952ce70so836972e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720696063; x=1721300863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z18fpVFr58tys4XrUSwectRYwpEzklmwvrd9y9cFb6g=;
        b=XiWWq9+SNBBRV0KgmFE3VmhM34yRZKgo55QAYvzo0XIwRXulDIvRamQ0pY8R0SIA4m
         k0+H4mT52wqFqCHWdmRC3QNcnlzavsoboupGpUXMRL9cE3EXfmF/+EEttw/3PbFjwH3d
         AgL98I8+a1y5pZ/iTctEWNKSOAVrB6iMEEupSaKN0MxIP9xhi2PmAjohIrjctTM/Hyyq
         GoGUAsCMzZmvAGDqt7LBsashtddyL+sr//GMoVSsBbfMhy2bF7ZSqhw2OkmWjxWwJKw6
         n3py245BBA6ptEhp8q60SiihqeSrLHaJLckkyqfKkUwDjz5gN/nYzDc2nog/8SLcuwZh
         9f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696063; x=1721300863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z18fpVFr58tys4XrUSwectRYwpEzklmwvrd9y9cFb6g=;
        b=OUoQQ3V04Fk7ToSBq2/L+/HX/4jfc87Y11U/HE24dDY+8AXiK6Q+daPy9wGxo+NJ/G
         c7Sv5d/3bi7hlA56IIOSjC790I402ZnQu9y9+pZ7sHE+qOxShzpLQ7ugNRkCvcgzZstU
         E3GtqDU2ifMY8Pyu9cCozW3uwDfjc5jTjWFJVUWH0eTx6doDGCxsH2A77pS/6jUeoSWJ
         spRwkQIzeffUlWHyKQs/iHo29CAw+a3Jm42Fkt+kogRQLtP3blBP1/K8M39rjOTXp/61
         sQScIS/om/i0cuQtGxNcCT52LaNy/57l5C8pOkEsgncMMaNXXsS6Y65Jh1ZaaVsXqb90
         wHaA==
X-Forwarded-Encrypted: i=1; AJvYcCVs8z4hEstcSAlDezQaHOIfaR5Pebm2029s/11oiuy92HTSGgN7kOhAFEjywdzueP8Thfy36S9M1spSLrjgab5WO9/xtMVKaIZWftx5
X-Gm-Message-State: AOJu0Yz0MzjUdiZXG5tujNy7AzD5w9OMiwfle4QKhqnu1xu5rWRUTw3u
	HIb+FkQd2M6GojiF73M5OtlufvouSq9AFm/LisnrhDrgz47Ll3X/aqQC1EHQxwo=
X-Google-Smtp-Source: AGHT+IGG1bHPmUMBD8uC04E8dWEfKEbOdB3naDFsmpKcSAuaMxqacCHsYpotPgLWsa7hJ5WeFS135w==
X-Received: by 2002:a05:6512:224f:b0:52e:be0d:56dd with SMTP id 2adb3069b0e04-52ebe0d579emr4971267e87.40.1720696063095;
        Thu, 11 Jul 2024 04:07:43 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e097bsm115686685e9.6.2024.07.11.04.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:07:42 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 5/5] ARM: dts: qcom: ipq4019: adhere to pinctrl dtschema
Date: Thu, 11 Jul 2024 12:01:42 +0100
Message-ID: <20240711110545.31641-7-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711110545.31641-2-rayyan.ansari@linaro.org>
References: <20240711110545.31641-2-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass dtbs_check for qcom,ipq4019-pinctrl.yaml.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1 -> v2: corrected commit message, added r-b tag

 .../boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi | 34 ++++++++-----------
 .../boot/dts/qcom/qcom-ipq4018-jalapeno.dts   | 27 ++++++---------
 .../boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 26 +++++---------
 .../boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi | 14 ++++----
 .../dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts    |  8 ++---
 .../dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts    |  2 +-
 .../boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi |  6 ++--
 7 files changed, 50 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
index da67d55fa557..0d23c03fae33 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
@@ -28,46 +28,42 @@ key-reset {
 };
 
 &tlmm {
-	i2c0_pins: i2c0_pinmux {
-		mux_i2c {
-			function = "blsp_i2c0";
-			pins = "gpio58", "gpio59";
-			drive-strength = <16>;
-			bias-disable;
-		};
+	i2c0_pins: i2c0-state {
+		function = "blsp_i2c0";
+		pins = "gpio58", "gpio59";
+		drive-strength = <16>;
+		bias-disable;
 	};
 
-	mdio_pins: mdio_pinmux {
-		mux_mdio {
+	mdio_pins: mdio-state {
+		mdio-pins {
 			pins = "gpio53";
 			function = "mdio";
 			bias-pull-up;
 		};
 
-		mux_mdc {
+		mdc-pins {
 			pins = "gpio52";
 			function = "mdc";
 			bias-pull-up;
 		};
 	};
 
-	serial0_pins: serial0_pinmux {
-		mux_uart {
-			pins = "gpio60", "gpio61";
-			function = "blsp_uart0";
-			bias-disable;
-		};
+	serial0_pins: serial0-state {
+		pins = "gpio60", "gpio61";
+		function = "blsp_uart0";
+		bias-disable;
 	};
 
-	spi0_pins: spi0_pinmux {
-		mux_spi {
+	spi0_pins: spi0-state {
+		spi0-pins {
 			function = "blsp_spi0";
 			pins = "gpio55", "gpio56", "gpio57";
 			drive-strength = <12>;
 			bias-disable;
 		};
 
-		mux_cs {
+		spi0-cs-pins {
 			function = "gpio";
 			pins = "gpio54", "gpio4";
 			drive-strength = <2>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts b/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
index 365fbac417fd..ac3b30072a22 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
@@ -11,40 +11,35 @@ / {
 };
 
 &tlmm {
-	mdio_pins: mdio_pinmux {
-		pinmux_1 {
+	mdio_pins: mdio-state {
+		mdio-pins {
 			pins = "gpio53";
 			function = "mdio";
+			bias-pull-up;
 		};
 
-		pinmux_2 {
+		mdc-pins {
 			pins = "gpio52";
 			function = "mdc";
-		};
-
-		pinconf {
-			pins = "gpio52", "gpio53";
 			bias-pull-up;
 		};
 	};
 
-	serial_pins: serial_pinmux {
-		mux {
-			pins = "gpio60", "gpio61";
-			function = "blsp_uart0";
-			bias-disable;
-		};
+	serial_pins: serial-state{
+		pins = "gpio60", "gpio61";
+		function = "blsp_uart0";
+		bias-disable;
 	};
 
-	spi_0_pins: spi_0_pinmux {
-		pin {
+	spi_0_pins: spi-0-state {
+		spi0-pins {
 			function = "blsp_spi0";
 			pins = "gpio55", "gpio56", "gpio57";
 			drive-strength = <2>;
 			bias-disable;
 		};
 
-		pin_cs {
+		spi0-cs-pins {
 			function = "gpio";
 			pins = "gpio54", "gpio59";
 			drive-strength = <2>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
index f7ac8f9d0b6f..efbe89dd4793 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
@@ -34,30 +34,22 @@ &prng {
 };
 
 &tlmm {
-	serial_pins: serial_pinmux {
-		mux {
-			pins = "gpio60", "gpio61";
-			function = "blsp_uart0";
-			bias-disable;
-		};
+	serial_pins: serial-state {
+		pins = "gpio60", "gpio61";
+		function = "blsp_uart0";
+		bias-disable;
 	};
 
-	spi_0_pins: spi_0_pinmux {
-		pinmux {
-			function = "blsp_spi0";
-			pins = "gpio55", "gpio56", "gpio57";
-		};
-		pinmux_cs {
-			function = "gpio";
-			pins = "gpio54";
-		};
-		pinconf {
+	spi_0_pins: spi-0-state {
+		spi0-pins {
 			pins = "gpio55", "gpio56", "gpio57";
+			function = "blsp_spi0";
 			drive-strength = <12>;
 			bias-disable;
 		};
-		pinconf_cs {
+		spi0-cs-pins {
 			pins = "gpio54";
+			function = "gpio";
 			drive-strength = <2>;
 			bias-disable;
 			output-high;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
index 374af6dd360a..91e296d2ea82 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
@@ -24,26 +24,26 @@ memory {
 
 	soc {
 		pinctrl@1000000 {
-			serial_0_pins: serial0-pinmux {
+			serial_0_pins: serial0-state {
 				pins = "gpio16", "gpio17";
 				function = "blsp_uart0";
 				bias-disable;
 			};
 
-			serial_1_pins: serial1-pinmux {
+			serial_1_pins: serial1-state {
 				pins = "gpio8", "gpio9",
 					"gpio10", "gpio11";
 				function = "blsp_uart1";
 				bias-disable;
 			};
 
-			spi_0_pins: spi-0-pinmux {
-				pinmux {
+			spi_0_pins: spi-0-state {
+				spi0-pins {
 					function = "blsp_spi0";
 					pins = "gpio13", "gpio14", "gpio15";
 					bias-disable;
 				};
-				pinmux_cs {
+				spi0-cs-pins {
 					function = "gpio";
 					pins = "gpio12";
 					bias-disable;
@@ -51,13 +51,13 @@ pinmux_cs {
 				};
 			};
 
-			i2c_0_pins: i2c-0-pinmux {
+			i2c_0_pins: i2c-0-state {
 				pins = "gpio20", "gpio21";
 				function = "blsp_i2c0";
 				bias-disable;
 			};
 
-			nand_pins: nand-pins {
+			nand_pins: nand-state {
 				pins = "gpio53", "gpio55", "gpio56",
 					"gpio57", "gpio58", "gpio59",
 					"gpio60", "gpio62", "gpio63",
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts
index ea2987fcbff8..41c5874f6f97 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts
@@ -19,20 +19,20 @@ spi@78b6000 {
 		};
 
 		pinctrl@1000000 {
-			serial_1_pins: serial1-pinmux {
+			serial_1_pins: serial1-state {
 				pins = "gpio8", "gpio9",
 					"gpio10", "gpio11";
 				function = "blsp_uart1";
 				bias-disable;
 			};
 
-			spi_0_pins: spi-0-pinmux {
-				pinmux {
+			spi_0_pins: spi-0-state {
+				spi0-pins {
 					function = "blsp_spi0";
 					pins = "gpio13", "gpio14", "gpio15";
 					bias-disable;
 				};
-				pinmux_cs {
+				spio-cs-pins {
 					function = "gpio";
 					pins = "gpio12";
 					bias-disable;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts
index bd3553dd2070..67ee99d69757 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts
@@ -9,7 +9,7 @@ / {
 
 	soc {
 		pinctrl@1000000 {
-			serial_1_pins: serial1-pinmux {
+			serial_1_pins: serial1-state {
 				pins = "gpio8", "gpio9";
 				function = "blsp_uart1";
 				bias-disable;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi
index 7ef635997efa..cc88cf5f0d9b 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi
@@ -24,19 +24,19 @@ chosen {
 
 	soc {
 		pinctrl@1000000 {
-			serial_0_pins: serial0-pinmux {
+			serial_0_pins: serial0-state {
 				pins = "gpio16", "gpio17";
 				function = "blsp_uart0";
 				bias-disable;
 			};
 
-			i2c_0_pins: i2c-0-pinmux {
+			i2c_0_pins: i2c-0-state {
 				pins = "gpio20", "gpio21";
 				function = "blsp_i2c0";
 				bias-disable;
 			};
 
-			nand_pins: nand-pins {
+			nand_pins: nand-state {
 				pins = "gpio53", "gpio55", "gpio56",
 				       "gpio57", "gpio58", "gpio59",
 				       "gpio60", "gpio62", "gpio63",
-- 
2.45.2


