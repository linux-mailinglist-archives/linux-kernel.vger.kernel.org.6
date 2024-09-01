Return-Path: <linux-kernel+bounces-310271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD70967745
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FB31F218CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A55185938;
	Sun,  1 Sep 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="DNlMVPKz"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35C17E918;
	Sun,  1 Sep 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206269; cv=none; b=Q47JQEIEqDoglkahOtCWqI/5ohkIa2eeMrWJNOmuIAbFZU1YDYHSoTVpjbZQJqrxqm+PeMD7ljg5oVLUviO3ef26/cL2L/vMyro0pAa1G7vPaMUkG6cLeyvm73p+4lxq67/jwD+PjCPhCWWNaND+wNouWia4lblh4Xhcfp3VOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206269; c=relaxed/simple;
	bh=1I/4nwVczaL23HkLU0YUoRp4A+6sI5QCbtY3AzONnK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhj6bgUmyjf2QnjBRRetFecg0DK1ORP/051gdV44UsHtiJzcfK6E518yD92AmhmjpSluP+iH0ftF3HBq+3i+zECnZMBh6cAvKihkf4f+OAL0Kv4aG/j2/z70zV7f3WbjWKDffGwpqeF3CjoukMQ6/cvRg6uNgyjn5IUMoF030b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=DNlMVPKz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A47EA1FA18;
	Sun,  1 Sep 2024 17:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206257;
	bh=8K6JD5FK2M93e8eYmr95cJOrSvI5mOVv6u4803sZynU=; h=From:To:Subject;
	b=DNlMVPKzo0AU6Pw6nLWxr0N1nQnijJIoQlBS5a9MLupMWKsIrFz+AvYa01kfixQPi
	 h7/dzR2NRJVlj71deeRJ9ZY7WpxZAAR5jckpVHRegx9ZWsDH5xkqAtyAB6q40iDp8x
	 vE0ZXzcbFrlGFT/KsZTome3ltza3JFOpXRzptn73tjI7VXarL8yfx6gJmthbDZGXR6
	 2Eq53sEzA+Oy9q+raTcIRRUIfhu3ZqR2ly1EZusC5FI2bEiWSaZCQRs6Qywkq4EaGz
	 uHBuy/NuAieC0WrCaKlnrAt0854piWTQIviONPT3Osw7tqcJC+L7+IftsFCsanuqDT
	 rP3QzHXQ1Qerw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 02/10] arm64: dts: colibri-imx8x: Add analog inputs
Date: Sun,  1 Sep 2024 17:57:13 +0200
Message-Id: <20240901155721.7912-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add adc nodes for analog inputs support for all Colibri-iMX8X carrier
boards.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 .../boot/dts/freescale/imx8x-colibri-aster.dtsi    |  5 +++++
 .../boot/dts/freescale/imx8x-colibri-eval-v3.dtsi  |  5 +++++
 .../boot/dts/freescale/imx8x-colibri-iris.dtsi     |  5 +++++
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   | 14 +++++++++++++-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
index c02dfdd75b60..503aa5a90503 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
@@ -3,6 +3,11 @@
  * Copyright 2018-2021 Toradex
  */
 
+/* Colibri Analogue Inputs */
+&adc0 {
+	status = "okay";
+};
+
 &colibri_gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 91de84772e1c..a2b2a0865666 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -19,6 +19,11 @@ clk16m: clock-16mhz {
 	};
 };
 
+/* Colibri Analogue Inputs */
+&adc0 {
+	status = "okay";
+};
+
 &colibri_gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
index a6b013cc6929..6d9d54d4e549 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -17,6 +17,11 @@ reg_3v3: regulator-3v3 {
 	};
 };
 
+/* Colibri Analogue Inputs */
+&adc0 {
+	status = "okay";
+};
+
 &colibri_gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 56de45fb05e7..d88f2dd20afa 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -38,6 +38,13 @@ reg_module_3v3: regulator-module-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reg_module_vref_1v8: regulator-module-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vref-1v8";
+	};
+
 	reg_usbh_vbus: regulator-usbh-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -50,7 +57,12 @@ reg_usbh_vbus: regulator-usbh-vbus {
 	};
 };
 
-/* TODO Analogue Inputs */
+/* Colibri Analogue Inputs */
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0>;
+	vref-supply = <&reg_module_vref_1v8>;
+};
 
 /* TODO Cooling maps for DX */
 
-- 
2.39.2


