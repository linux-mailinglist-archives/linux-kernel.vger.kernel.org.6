Return-Path: <linux-kernel+bounces-200770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCE8FB4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585BB1C219F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD0143C59;
	Tue,  4 Jun 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aphoHj1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F9143C6D;
	Tue,  4 Jun 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509616; cv=none; b=uYBV1ti7gJJOfbqSoaX5GfhKjv9P3CfaKqsWda/vwTUuyULW8tpdauJvTV2aao4lrwjdwLNEMNvHijddlwdWTZu7vM0JDHJg7XxatEp21rDVqBQrxLf+bJUY5LIWnJOaEMcvgzlkEFr9DajlsWI3WFjzUIdtafFOg8kbzsmlwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509616; c=relaxed/simple;
	bh=rFDucDznyAp9KdW6DmpqQ16mThJdgkTuPLsOXBQR5oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9s4CZsSs3sy1b9eIY9ohOF3q7mElfFtjLlHPJtroW+z/cIJlzi0m6SA5/3Xk9uFv3yO3uWmE9eh4z5pe3RZPAfvzmVOqEVE0PPgz6uvFIp6HnHeINC9w0s/5rtGZ2+0XYKWg3UkAV/RoipbjTGHI7dx14jSrTIBwQxkJp0gQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aphoHj1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D78C4AF09;
	Tue,  4 Jun 2024 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509616;
	bh=rFDucDznyAp9KdW6DmpqQ16mThJdgkTuPLsOXBQR5oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aphoHj1iBTcKQXKi3MxhatfTqitW3ZHgLOzyXkL3OgeTdWQNWhyfMdxW0Ozdhiy9C
	 YwpUG9zWnVCBUllJExAftLctkpA7S4RfNL2B0yS38axBmxvOHl+EjIlHApG/Q/XoWF
	 mhB4lDj22qWlJFtgjydgQvhIVZ/XDVa3ruenQPDberDElA8J+iNPJf1LXnI4S3h6ss
	 tMqqif91QcvwQrzjeAvyTf3bOqyT5VypHgfAHvbu5V6MuxZBeuE+7aq33ehZVW9Ul1
	 ifm0plRpKbhDlSxzQ+9Q+vqbOphN2+DnK249Je9eIRlWo0uS5EYp81r73wRAHcsTUb
	 XRvWKXiJzRXIQ==
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 08/10] ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
Date: Tue,  4 Jun 2024 15:59:32 +0200
Message-Id: <20240604135934.1951189-9-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604135934.1951189-1-mwalle@kernel.org>
References: <20240604135934.1951189-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module can enable/disable the SD card power supply and has
it's dedicated pin SDIO_PWR_EN for that reason. This is esp.
useful to be able to reset the SD card if it was in an UHS mode.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 4d3cd338a707..d36743e47552 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -61,6 +61,18 @@ reg_3p3v_s5: regulator-3p3v-s5 {
 		vin-supply = <&reg_smarc_suppy>;
 	};
 
+	reg_sdio: regulator-sdio {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_sdio>;
+		regulator-name = "V_3V3_SD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
+		enable-active-high;
+	};
+
 	reg_smarc_lcdbklt: regulator-smarc-lcdbklt {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -640,6 +652,12 @@ MX6QDL_PAD_SD1_CMD__PWM4_OUT 0x1b0b1
 		>;
 	};
 
+	pinctrl_reg_sdio: reg-sdiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0 /* SDIO_PWR_EN */
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
@@ -692,7 +710,6 @@ MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
 
 			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x1b0b0 /* CD */
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x1b0b0 /* WP */
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0 /* PWR_EN */
 		>;
 	};
 
@@ -795,6 +812,7 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_sdio>;
 	no-1-8-v;
 };
 
-- 
2.39.2


