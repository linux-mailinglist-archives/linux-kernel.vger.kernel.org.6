Return-Path: <linux-kernel+bounces-203939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAA8FE226
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E0828BF6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0747B156F27;
	Thu,  6 Jun 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zoq7Y7zO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B813DDAD;
	Thu,  6 Jun 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664571; cv=none; b=Dnhf+RchQdbfnj7JIr04j30TPbsCs8bizlkKiayisQhzGdKHcQqFcU6Nix1Chp52lFmsycRMWn7SODVikonF6GOd2hBSVbKgY/zUHYW14XKx2xWYjLXjc+uzs4mX6xb1ZUZ/p/Va+id9jp4PbBUH4LI9ROpY6GDmNAdhrWOukoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664571; c=relaxed/simple;
	bh=wc3eFNG3Ttq/rANHKbXTFJqSlTdXmLGuxvp1I8yiTCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocqTOdftcvEuyeNlIp07nkHvv8mZbX2/9KyHUfMQdNNOsEYwokb7iFjtTc8MahRyb6vzWpPcNKzFivooQ0LfTJGcjKkG0wnZFaYT8u/xuIeIVfy2sMnpYF4/cwelMpcbl1vCyVHZ35WBMO0/jhmJior3lvt6OgJZJqJvzZAtOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zoq7Y7zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1836C4AF5F;
	Thu,  6 Jun 2024 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664570;
	bh=wc3eFNG3Ttq/rANHKbXTFJqSlTdXmLGuxvp1I8yiTCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zoq7Y7zOcPk655wEHR6DC6/IF2llMY5psLVgEL5csvjDBBLJdc7e21Q6J21qVcZSA
	 24Bd2M7voJAlb1CbWFnNLVZ18fHZMfF8JM/YbCSoSecVDGHFGVTZRK/+gmllbyeSL8
	 40KtjapVxQ5WK6rBhTaDnqWW9hkVY0I00BOdiL7YB43LXcquoOnYEefA8++wFMmekT
	 H+osSnx7cmJ8XDu9iFrZQU1Re+VVBK16HhObIhj64kjYqrpLN7+XWnlvXrCtOYzjxk
	 r6E42pWKJ2QgypWUeZuzFtsLUzuoxpV4orgRrYR3YRIfb5JV7ocW9tlgQzoa7SWd6h
	 UqSEUyAKGZG+w==
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
Subject: [PATCH v2 09/13] ARM: dts: imx6qdl-kontron-samx6i: fix node names
Date: Thu,  6 Jun 2024 11:02:02 +0200
Message-Id: <20240606090206.2021237-10-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the nodes according to the schema. In particular, renamae the bit
bang I2C controller to "i2c-N" and the mux nodes of the audmux to
"mux-*". While at it, fix the typo "adu", which should have been "aud".

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index d36743e47552..85e5adac6ee9 100644
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


