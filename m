Return-Path: <linux-kernel+bounces-213348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB96907412
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA751C22D33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DD1448FA;
	Thu, 13 Jun 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7FWSrgI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEE1448E8;
	Thu, 13 Jun 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286131; cv=none; b=uEVbYxFCRV1J7OUFpmwO+M5k171Rwu1giMcqzjjQzXMTtmGQK/8k3Eg9ShRD/3cjZhFbr6ZpdeYjXe4EkmBv0HwQOvoS0dnTndRtkTSaL0Rz6vQB5FkpwlAuYHreB0oDiOV2BQEHsoswEpirowHpQ8dlv2/enX6Fk3+pE2vr1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286131; c=relaxed/simple;
	bh=+z1xN1OTCuBZhemyLLfzhdSbywBRDNkNMUnB3Ii0GhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sHw6cXYIlrKXFugNx18ZdcplJkTC7GMEEdHwTNY+kmfxdtyheFpXjzE/jc/0BP+Od0LYhAajWfPWwcy2KDyGqCfjYHfazSx1qevaOPtoZNcJNZFJtpuMtSx2xY7vAdk0OU2Id1pEpNkE2wr/OZCck5cEoI+sqNDrMdtREOU5/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7FWSrgI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42172ed3597so6816805e9.0;
        Thu, 13 Jun 2024 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286128; x=1718890928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lubbqAl7HTS/g4vv056FMCQ1RskN3TIsl6kZl33uIes=;
        b=h7FWSrgIy3fJLTt9aVCU/IXjSNaF8051yHKUXrjDg3Gqz5da+bGsmGSnbCG6M1a3aZ
         pCsvyqu1FucByrpSSjHECTuZvdiY85jwuJmdfSTe+Eq0lrLiZdgERbmvDqiJv11jbZj4
         pSRO9WSCz5u+Dp0cmVtc/XRV+mwDkA3iwCzk+ssJSl6p57yak98YeSIP/X/nBMtS4W4i
         wc7K7Kr6R+LFC3qWhDXHB8/3lFVwcFnSpEMUNCDU10ofLwfd4sqcOpocVJjeiiIH/bkb
         oMBX+EoQVCWGY/Eqb4mRrMUXW2TaNtGxhCiDZf4jk3TZcK8XGGxapQC0zu3UzZ3/k+1/
         7tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286128; x=1718890928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lubbqAl7HTS/g4vv056FMCQ1RskN3TIsl6kZl33uIes=;
        b=U0+TOjEBvTRCssXz906lDIgJigqnqath3BsbYVi+E8vFMvNO9SYrFrF0RWRhHZHzHF
         sOJ6KvNnc+0bK/yAfRQu95zPOIlc6/oH6kcrGfAOftek9u1e6DJuJd7sa883oUyy/rOe
         yc8A4bVEKk1NG6BL8ZgAFt3aSwjcC4dheFy3pDtGbvLTFxA5GSexibGeBzXRH9Oa2KKr
         BVcRrhPPO17hq5XEwKi6glrmcFD/vbTjBMBD3Sps0d1fnRulXG/AnJYQRUYtqHhiaAPC
         ePnGLzabevEb4KcFqT7bH9iZn/LW2qh0/uaIxuCM/jIs9KdTcs/vddxJx/YxXUhOYHff
         uSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSOqfl2xre0nz0AACO7stYnjxN+wxBGTGpWGbrQIQJYKwRo81C9LhFfrQHvg3PrHToY5IZACf8j+fxwoV1H8Cxr+8L1mSvHjZb4F4XOHE1mTNLpmFsdkXNlsyYx7pOIQPxyKWUKJ7UXA==
X-Gm-Message-State: AOJu0Yxjw8LliIirKqfIGWN5Xqi+V9UHUTXQO+VEZSXFGvzvp1PJBAue
	xiqfC1ajaZCNfz0PeyvIy5gzCQnTWBN8WzhdIn5GMhtdi93DAEjj
X-Google-Smtp-Source: AGHT+IGIY6ndnCADtxtse3SR/xy0iRVIQrBFXYYemePOyTtkI45JeF87lLvJm1bcyxDFEq0ydLiMKw==
X-Received: by 2002:a05:600c:4f81:b0:422:1446:378 with SMTP id 5b1f17b1804b1-422b6dc80cdmr28634765e9.2.1718286127564;
        Thu, 13 Jun 2024 06:42:07 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:d16e:d9b2:b631:537a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73b1sm63852415e9.45.2024.06.13.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:42:07 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com
Subject: [PATCH v1] arm64: dts: imx8mm-verdin: add TPM device
Date: Thu, 13 Jun 2024 14:41:50 +0100
Message-Id: <20240613134150.318755-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 4768b05fd765..c9ae5f0bb526 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -227,15 +227,16 @@ &ecspi2 {
 	pinctrl-0 = <&pinctrl_ecspi2>;
 };
 
-/* Verdin CAN_1 (On-module) */
+/* On-module SPI */
 &ecspi3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>, <&gpio4 19 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
+	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_pmic_tpm_ena>;
 	status = "okay";
 
+	/* Verdin CAN_1 */
 	can1: can@0 {
 		compatible = "microchip,mcp251xfd";
 		clocks = <&clk40m>;
@@ -245,6 +246,12 @@ can1: can@0 {
 		reg = <0>;
 		spi-max-frequency = <8500000>;
 	};
+
+	verdin_som_tpm: tpm@1 {
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		spi-max-frequency = <36000000>;
+	};
 };
 
 /* Verdin ETH_1 (On-module PHY) */
@@ -807,8 +814,7 @@ &iomuxc {
 	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
 		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
 		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
-		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
-		    <&pinctrl_pmic_tpm_ena>;
+		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>;
 
 	pinctrl_can1_int: can1intgrp {
 		fsl,pins =
-- 
2.34.1


