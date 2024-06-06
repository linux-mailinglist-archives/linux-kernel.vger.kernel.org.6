Return-Path: <linux-kernel+bounces-203938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B68FE223
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B4128BF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7E13DDA0;
	Thu,  6 Jun 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvxZVdrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502215664D;
	Thu,  6 Jun 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664567; cv=none; b=ijqoeyKQ+s0/FubdS/5KZZgIOcyvjaEavEGwat2Cr3lWMq+ssLRkGQjTRar6h5ZKKmtXqvI9+6ZbO90d9PGhHfFCPn8MZLEvy9a5I2iUeUEQRp50xFHGfd4/0rLHo4vS3Dt43PRREacKxBJU4wz+qVVhI2NdsF2ZwdwAf5Ln0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664567; c=relaxed/simple;
	bh=rFDucDznyAp9KdW6DmpqQ16mThJdgkTuPLsOXBQR5oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+sEg/t5EOEHRHtnXX5ZXv9Z5bWjjbtPSyBUMxZMpXD98Aon/WU+2DJCpRy2ZDp3aA/4DjJ7vsHU3jb6ii+ggOk9hUtwcYYV6cmTidU5tyG7ouzlDp5FjBDZifonC+IO/0Z968jXvL1ZvVSulhLd1clFTIiKY+KZTqjva90X+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvxZVdrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB04C4DE02;
	Thu,  6 Jun 2024 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664567;
	bh=rFDucDznyAp9KdW6DmpqQ16mThJdgkTuPLsOXBQR5oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvxZVdrLcPwc1YPGrc4gtpEO3pgWroda9mAdJrQEZZcKl7ApfOKJLanOAqi9UEeOl
	 ZB3sY5DEY/ozQTqT7eD1L1IJzIv+XeI8r5fMTU5ayd5ELgpY0VItwUqiHVTYx+a3qL
	 2YurrrzY1dDqwPoqa2soUCCfkuxTRxppGc5rHl0S176TnYDvluX0A6gev6LDvzyK2W
	 YbL/0WZtON5zEQKvVeD2PBm2/IpQhGP7LKBgqasfGEedfcJhjUyD9ecDYHAO2srblP
	 0vxGu1Bkjzg7H2sdf6tCMZHglirpOg2CfSJs8SLCGsrytlNLt3Du5ZNJLITFBbvi/G
	 rqkT7B3Vw6eUA==
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
Subject: [PATCH v2 08/13] ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
Date: Thu,  6 Jun 2024 11:02:01 +0200
Message-Id: <20240606090206.2021237-9-mwalle@kernel.org>
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


