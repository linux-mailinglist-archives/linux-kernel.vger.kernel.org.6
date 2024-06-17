Return-Path: <linux-kernel+bounces-216981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F890A954
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F901F23A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277A195809;
	Mon, 17 Jun 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJD+U2jN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFD191487;
	Mon, 17 Jun 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615660; cv=none; b=SAmrgzG1LRIlJUMoUS8GbrUeaLhRvcHfffrPH1VPiOIXqNDjvGV9KLJ3PddI1KAcpDAa6pXCohwe38bsiO0s2L7hYwSFEAEyzWorwLqGiLhp2nFt9oi7Hp++G82Sr9FPxK2XS9HL7e2SgE1svwc/cXoLbvHAOC30wJfV/zg2b9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615660; c=relaxed/simple;
	bh=gTIOno+uQobG2s2zwgq6QAs/t1j8ChDipZAsKji3qro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGmkR7eZemAOuDUliUc5viuqiuMRcdjXfVQLBwCk71FYwSDP+dTZY6Z+WD+7dfJsirCyfC3RReFRSCuEu28czPQ9NsrRBnaXKkZULjldjDebi6WzN2OURz+WF7S+MeBdqYUClyvUyod4yYgGUb98QYK6Ry40UQwvGtbwsoKSpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJD+U2jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF6DC2BD10;
	Mon, 17 Jun 2024 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615660;
	bh=gTIOno+uQobG2s2zwgq6QAs/t1j8ChDipZAsKji3qro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJD+U2jNWutuMWLEV8fCL8lqSjVomSN89ADr8oeQx/j4TyLE50LiMOISbSViOaf62
	 88+mHrLjw6wEhUW6zMTbBVJAVamYzto3SmOsN3pxqRn6B3tUOKciSNevfQ63ualAfI
	 H/ujSesrvsCJv+0pv5lgzZLnRIDqx6TBLcXFGjFnOn5GQuKQLqvwQyUhaCFyCJ3U6t
	 EABoXFoGBJbX2zQ3WUJ1EAasNOzE6E5/Q6zUu3zgoq3zXSl1Z8Mwnn82fnA6WyXDk8
	 izLVcGmpi6NqdUSQ3weTqtmj/9RYA5/q55A3AKrL9yKkGK47L8NBzU+F2CBH7+K9jq
	 k0kUkKIAnvlmA==
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
Subject: [PATCH v3 08/13] ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
Date: Mon, 17 Jun 2024 11:13:36 +0200
Message-Id: <20240617091341.2375325-9-mwalle@kernel.org>
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

The module can enable/disable the SD card power supply and has
it's dedicated pin SDIO_PWR_EN for that reason. This is esp.
useful to be able to reset the SD card if it was in an UHS mode.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 4d3cd338a707..b0fa07ade76d 100644
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
+		enable-active-high;
+		off-on-delay-us = <20000>;
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


