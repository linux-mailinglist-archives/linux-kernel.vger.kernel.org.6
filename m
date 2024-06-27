Return-Path: <linux-kernel+bounces-232161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35991A443
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D4C1F226E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061B13EFF3;
	Thu, 27 Jun 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXxmDOWo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F113BC31;
	Thu, 27 Jun 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485329; cv=none; b=AqSFIFKTRNFb76VnbOylpanDvE1NVVaG/edKP8nQ3xn5vDroE6vsicY/Bronw38e72KzDl1n8Zp3lb8sCMuAGi6dqO7jKdijcs/yN4vk9PLG0JBsx5ygM8dQa1152LJBpmBUpc/4IxhNdEhp+exxQIPj6vlcATZzrppMuLIbDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485329; c=relaxed/simple;
	bh=E3tkZi5Re0xZBXiTJIkaP/WSpbFH1vO+uf3euVwYTiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhxj5VynEtAFMwFZLZ0dyn45ZKrK6mMpX3mFFHDbpVCeWykCngFvv/h1DJDE+fGZG8pRiWT4UOByEVgf49Npu6Lk/uAOvSIyQlmJ73JkegCRT9VLHTlu7RiTxjiz+/xUUHTLNKyv6ufF7uZoaVVqTV+ma8sotkoqxwBMqk8mDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXxmDOWo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so7715106e87.1;
        Thu, 27 Jun 2024 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485324; x=1720090124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UB49lb/IgQI+QFjiW4RxbsxUbcomLADrjUg4RQdZZT4=;
        b=ZXxmDOWowq+hMegvtszf9cGwFTCoA7ezCP0mSO75rwKbiAIoGkfLWsqivFc0cGj1i2
         iKww927ffma5nOTYrXAm3lCIqVi8H1RDLwgUZFPAlFvZfRoNeZacrmWnbE8y9rQuTVXD
         TxToe/evDWM8ePfun6LxLqoVlU7kbwrLPoCmgBTnnNLFAKcHPVIOmPqcLc7mR2SWDw94
         OV3g+73iqaFhC1LlkYZQtnd8pwCOOQJRvdK1B7f6+sHt85GdwI8SGBjy57QkVNVeBT9L
         u8Yw3WvBGZJzK6eG4XWcW66RoDs6FeVvj1fNbgIuLoY3s8pzKLO53NwBshWIY9G4UPHy
         ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485324; x=1720090124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UB49lb/IgQI+QFjiW4RxbsxUbcomLADrjUg4RQdZZT4=;
        b=kzp6+rQ1jA6DyJf+Azeom8wOnlKaozbPIct+SJLHQdTx6OuFErZuR9WgX+PRBSsida
         ciXOpUZeGhk1yLdMoIvUHXo7Om09TCQ0QATymNXmuhSxtNJnD0P9bPGQQGpajlZiG9zH
         a/1mop3HqgJo0Tfj/SJzVpV/PnHH+DRmaC9UTFWkToPLeKyInJBmW12MrGNHe11kKFVG
         BG4wqjPiPZlKf1cecXCozhOyCnHJMG3BvIZYy2qatomDKe7YDAJu904HwgJE9IE6d1jS
         Cel4lsbdmAi8gWbMLxqk0ZFw2AwPNcXY3puKJkXUuwiiUzhqQhjJ59vdYM69Kmb20nBB
         XWQg==
X-Forwarded-Encrypted: i=1; AJvYcCXVdpN/M5uW3wwnwuTuMUrv2cz6gbCcVNgUzQPwvZ0v4oQTG+NC0r7l2nmKzK3JM1+sQZYJb8fjGZT/RIMrzqJ4zOKXmZ3HzOD5hDsMMj9sIOChnxJgJxuPPYN+ykR6W29C1RwFkFlfeA==
X-Gm-Message-State: AOJu0Yyd27BoELtAwL6UTkWc3USwZevgP1pYJi7NbA1ZrNWmddocIqSG
	UMACHsiQRjt4qM7ZUH6v5+jgsvDeyEZtwB0dJPUOEI2uKdVYNd9D
X-Google-Smtp-Source: AGHT+IGDdHq5IeXT9AYX+DdXqyQF6IqrQBJnbIU5m4qB7+mYAXJmAApCaCOoT/18L4Yg21S95fHvaQ==
X-Received: by 2002:ac2:5618:0:b0:52c:dea0:dd55 with SMTP id 2adb3069b0e04-52cdf7f10d2mr8461836e87.24.1719485323871;
        Thu, 27 Jun 2024 03:48:43 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:9537:8d85:b9f7:78bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c826a2e7sm58503995e9.21.2024.06.27.03.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:48:43 -0700 (PDT)
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
Subject: [PATCH v2] arm64: dts: imx8mm-verdin: add TPM device
Date: Thu, 27 Jun 2024 11:48:39 +0100
Message-Id: <20240627104839.645778-1-ivitro@gmail.com>
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

While adding the node, rename `pinctrl_pmic_tpm_ena` to
`pinctrl_tpm_spi_cs`.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
v1->v2
  - rename `pinctrl_pmic_tpm_ena` to `pinctrl_tpm_spi_cs`.

 .../boot/dts/freescale/imx8mm-verdin.dtsi      | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 98544741ce17..6e066bd5d982 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -228,15 +228,16 @@ &ecspi2 {
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
+	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_tpm_spi_cs>;
 	status = "okay";
 
+	/* Verdin CAN_1 */
 	can1: can@0 {
 		compatible = "microchip,mcp251xfd";
 		clocks = <&clk40m>;
@@ -246,6 +247,12 @@ can1: can@0 {
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
@@ -808,8 +815,7 @@ &iomuxc {
 	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
 		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
 		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
-		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
-		    <&pinctrl_pmic_tpm_ena>;
+		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>;
 
 	pinctrl_can1_int: can1intgrp {
 		fsl,pins =
@@ -1111,7 +1117,7 @@ pinctrl_sai5: sai5grp {
 	};
 
 	/* control signal for optional ATTPM20P or SE050 */
-	pinctrl_pmic_tpm_ena: pmictpmenagrp {
+	pinctrl_tpm_spi_cs: pmictpmenagrp {
 		fsl,pins =
 			<MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x106>;	/* PMIC_TPM_ENA */
 	};
-- 
2.34.1


