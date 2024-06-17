Return-Path: <linux-kernel+bounces-216982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1C90A957
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8EE288862
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCB19596B;
	Mon, 17 Jun 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/Hz+fJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B238191487;
	Mon, 17 Jun 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615664; cv=none; b=ugw/dWChVu1XGC3yYCOEpmIK1A61Wir3DtXCN8iDc50PDvxk+lxWu3fkrzAttdhJP3V6Hsihv9jqhq9aACDRPVHRDlYwYo6o1MaIFi7OZ7lsNcSGr5Iobp5T+r4Uf4SulkJaIe4lBv5nxbw519gH7OAFBWuyMlab5JG4z96i4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615664; c=relaxed/simple;
	bh=wvPQCYhRVZsmJmMA1m/0GLBRX74K7bIkQJCEyPrWUjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYS/fgKHqjTCJQZ09ZidbOfsW9GQy64Jbfng0j+wWdqp7R4eFV4fR0sdlh03DDJeuvtrGbfcBoj8OprJSYZHecdhYF0DRxuDR/0cr5M/wji6pqpgG+QUka8ayMU+j0W4gq2nA4HIoR41tRMlVpLmFrHKrtKQeUtwQBcYmpQpwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/Hz+fJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED78C4AF48;
	Mon, 17 Jun 2024 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615663;
	bh=wvPQCYhRVZsmJmMA1m/0GLBRX74K7bIkQJCEyPrWUjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/Hz+fJSL/DgYt/1UdmanoJnvOOp6OJ7XhXT6kyCOEWAumDM7NPtgp3mJRcB/usv7
	 MOWYkD4nv4QPRN9INsA2mYe7QjEBbVvjzplXMVU4SzU7PtmkBQ7gsN7x2/2U6YXcAQ
	 AopP2TFg3luyPjXVk+yAtjJIhLYBMMrWB3EynB89dctFnE/8IXF4JbK3feA3m9q9LQ
	 EiZAB0kPnIhr19gTAACUKzesw4930o9TxxPujNMFT1zOC26TBjAyxOvKMdvSSK7gqh
	 xbPueXoc7o/9jdhx13yEOMU+wn9kT6c3f3+ok9c85um2C4gMUgPm3Iv59ogtYk6bJS
	 /JRJuHed42hfw==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v3 09/13] ARM: dts: imx6qdl-kontron-samx6i: fix node names
Date: Mon, 17 Jun 2024 11:13:37 +0200
Message-Id: <20240617091341.2375325-10-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617091341.2375325-1-mwalle@kernel.org>
References: <20240617091341.2375325-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the nodes according to the schema. In particular, rename the bit
bang I2C controller to "i2c-N" and the mux nodes of the audmux to
"mux-*". While at it, fix the typo "adu", which should have been "aud".

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index b0fa07ade76d..7eeffd6eb476 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -149,7 +149,7 @@ lcd_backlight: lcd-backlight {
 		status = "disabled";
 	};
 
-	i2c_intern: i2c-gpio-intern {
+	i2c_intern: i2c-0 {
 		compatible = "i2c-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c_gpio_intern>;
@@ -160,7 +160,7 @@ i2c_intern: i2c-gpio-intern {
 		#size-cells = <0>;
 	};
 
-	i2c_lcd: i2c-gpio-lcd {
+	i2c_lcd: i2c-1 {
 		compatible = "i2c-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c_gpio_lcd>;
@@ -172,7 +172,7 @@ i2c_lcd: i2c-gpio-lcd {
 		status = "disabled";
 	};
 
-	i2c_cam: i2c-gpio-cam {
+	i2c_cam: i2c-2 {
 		compatible = "i2c-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c_gpio_cam>;
@@ -190,7 +190,7 @@ &audmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
 
-	audmux_ssi1 {
+	mux-ssi1 {
 		fsl,audmux-port = <MX51_AUDMUX_PORT1_SSI0>;
 		fsl,port-config = <
 			(IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT3) |
@@ -202,7 +202,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT3)
 		>;
 	};
 
-	audmux_adu3 {
+	mux-aud3 {
 		fsl,audmux-port = <MX51_AUDMUX_PORT3>;
 		fsl,port-config = <
 			IMX_AUDMUX_V2_PTCR_SYN
@@ -210,7 +210,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT1_SSI0)
 		>;
 	};
 
-	audmux_ssi2 {
+	mux-ssi2 {
 		fsl,audmux-port = <MX51_AUDMUX_PORT2_SSI1>;
 		fsl,port-config = <
 			(IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT4) |
@@ -222,7 +222,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT4)
 		>;
 	};
 
-	audmux_adu4 {
+	mux-aud4 {
 		fsl,audmux-port = <MX51_AUDMUX_PORT4>;
 		fsl,port-config = <
 			IMX_AUDMUX_V2_PTCR_SYN
-- 
2.39.2


