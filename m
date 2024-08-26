Return-Path: <linux-kernel+bounces-302293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDDF95FC37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802421C2270B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91119CCE8;
	Mon, 26 Aug 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WrTuoD5L"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAC19342A;
	Mon, 26 Aug 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709582; cv=none; b=o86Jrci2mT3kBuzc42gB3dnoUhKOTsUM1+0njQXaH1LIqZZV+4lTdZ7mXnEQD3wdzJHQR/iCdRD0BvgUrZeQ93EvhP4nrQosQn4dwokN5v0/F1A7Xte2nQfnRK84Q4PbWVQ2R6jyYV7qMuQiamiP36YJHiGt1HKLNQ2wQqbPn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709582; c=relaxed/simple;
	bh=bq9KVThxKqHGOBuaKcQ0Cgb93X/S/IAwRwAB8DDuSro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHDXKn5mYLUwHK1cZigfdeO2XwpJlO7xRY1pmHdfaduMsdxclSRzkhYEEo3IqnQC8zdEDhEGmiMOFDBS5urRS0e7c1urtBhuNMdJATl2GHkz57wB22mxtEn06L0p1DgjChBFyaL6s8YFVScyWsrrQJ8acEJWubdg++GZWV+DrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WrTuoD5L; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7518E25062;
	Mon, 26 Aug 2024 23:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709577;
	bh=3nXxX6+gvRVf+zAc6fUvb5njG3ZQWFMWH1kakJJtpEk=; h=From:To:Subject;
	b=WrTuoD5LvdBi20dB/av00NgYgQ2xjqmMrMsN9A6F6l6VSHwevObQgFhGv3u9fSFyB
	 wh1AjYSaGbKss9rkCA3e77mXFEG6Wc9abTf3E0czFQ/YeFeYJGFZjv1vLSqSi7Zr3V
	 6Xps7LGUw1rrzK8vFSp8dHgUgrs2TR/bj6q7SJDfH/IWPspok2hF0eqs81xEcXRlzN
	 P2JNLWXDASbB9P5DBOD0GYaUQWWfgNJATuQ1QtiLmZC3ImG7uJx4BjOy8rd7Ml17Jy
	 Py+ZRfCusrmFzK2UQiNRc2ZvgRI6o/00VYxLlSVayck1MemTQ1Vu24oroEjgpPw5x4
	 wPlUmlsTkLvnQ==
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
Subject: [PATCH v1 02/10] arm64: dts: colibri-imx8x: Add analog inputs
Date: Mon, 26 Aug 2024 23:59:14 +0200
Message-Id: <20240826215922.13225-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826215922.13225-1-francesco@dolcini.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
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
index 1199e311d6f9..c7f0dfe7b162 100644
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


