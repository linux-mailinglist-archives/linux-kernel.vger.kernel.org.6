Return-Path: <linux-kernel+bounces-310272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F594967749
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C68BB21287
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A342185B63;
	Sun,  1 Sep 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Ku/ueXl3"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649BF18452A;
	Sun,  1 Sep 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206271; cv=none; b=ubSHBRsXPoiZe4la1Q8EP6DE+BFIkmB6BRhRcsQTXm59qZJD/8/nBYchZtFsP+QmY5ReGw0t+VE3r52oB8Qw3903F2SAyGHBr6QD0DrZ99H54xH61GSWl/2iFVq0d735rfmr/x8pf2ZPQwSE0JkIxJVBkKvewVT6bnQrhCAGXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206271; c=relaxed/simple;
	bh=xHP0NbKoV0Ji0zvC7pgE6gphNWj+p2wKSFl1Epq87ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fu94xTzfmdpe9YxZCGbL1sGKGF9F2MPqBpSSLH9M/wVCTSmGrKdIV8fxjoXsK4MKSHhVwOkMnCbc56MyAmBZ6A+yAkjUMEeRxnmo09dNWaVS/78Li9PJAgp6AhLgGAKmctUc1Kdv88Pis5TrkDOhXLpow3p+2028c36ZMqVSKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Ku/ueXl3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 200161FA90;
	Sun,  1 Sep 2024 17:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206259;
	bh=xLI6E86Pd+rLiDpAMzs0yyOFhgf2TdCupbACQnH+AxY=; h=From:To:Subject;
	b=Ku/ueXl3vVHOI9m0MudUaWOSKSSHGZkq2QjUqirBC/ebWD/ki1bzga30EtCxuUvro
	 rOzbHolF6a1+W1EBY+e1NDxfO8xLbQitQIqoNLs3mrHeADg3T46xG1e58bWFqNKGRn
	 9SOZNEUNDZn8/kZCkufqW8/zDL5u8j05v/5WWaq3p5dIN3I4xhz5w8lzenNqQzORsi
	 Z2aotMXi6qUxHfBIIvz/bwxdVBLE3GNbyKZOk/oIv+B6x0Pkyi/6Jy+yTIPET3n3XV
	 atVgdLZE7ItgAi2YQomAxvV7/2qGHQ7TEtRO3YWUpFU6m67Vwg9IDKTmF8nx0uJ1wU
	 Nu3hcU1jzAA7g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] arm64: dts: colibri-imx8x: Add USB3803 HUB
Date: Sun,  1 Sep 2024 17:57:17 +0200
Message-Id: <20240901155721.7912-7-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add USB3803 HUB, this is required for Bluetooth and USB
functionalities.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index bc1577b5f1ea..f929c5f07e64 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -113,6 +113,26 @@ &i2c0 {
 	pinctrl-0 = <&pinctrl_i2c0>, <&pinctrl_sgtl5000_usb_clk>;
 	status = "okay";
 
+	/* USB HUB USB3803 */
+	usb-hub@8 {
+		compatible = "smsc,usb3803";
+		reg = <0x8>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12000000>, <12000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb3503a>;
+		bypass-gpios = <&gpio_expander_43 5 GPIO_ACTIVE_LOW>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "refclk";
+		disabled-ports = <2>;
+		initial-mode = <1>;
+		intn-gpios = <&lsio_gpio3 4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio_expander_43 4 GPIO_ACTIVE_LOW>;
+	};
+
 	sgtl5000_a: audio-codec@a {
 		compatible = "fsl,sgtl5000";
 		reg = <0xa>;
-- 
2.39.2


