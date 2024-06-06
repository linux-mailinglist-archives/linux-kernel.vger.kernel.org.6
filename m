Return-Path: <linux-kernel+bounces-203934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690ED8FE21E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DBC28BEA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAA1553A1;
	Thu,  6 Jun 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZEUeeJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF9155385;
	Thu,  6 Jun 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664557; cv=none; b=a96cIQVnWa8Dy4OQIS8BJkDnQdO9r55H5EQMafBdc/mNBHmbH8urE3vNCSObEDNxUtM4CRuQxzfpSLoroGM/gd9LFfP7kCNRQJt9X9UaCQI9xjWvobP10t1bc9dOYRa85dTVAzcUFoeC51cO4vIclaan0SuLYXk3FzqgOQTv4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664557; c=relaxed/simple;
	bh=pE0vsrGZNwEDC2VKKmVgmDKbUEz9TgECCZmW3XAqSV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgmMAWNvik1ATiMRv1pUvNzuiZibD/GuCywR9VXxX0ThCnI9vo21ie/RpBnhj4exs63DUBKvrZKdrgJ8p4aKf9LE0fBuaS2U3IrmZcZzVRiCiZ203O4yowRwHlJ5y8GGGSTZFGYGp4SsGMurtwG5smE/mJYBFRgPgsBGzFRWbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZEUeeJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6189C4AF0F;
	Thu,  6 Jun 2024 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664556;
	bh=pE0vsrGZNwEDC2VKKmVgmDKbUEz9TgECCZmW3XAqSV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZEUeeJMEbUNU8wARrNbuyW7ZsNzPQJRQfKG2DMHcsaViHQngDoW1FHXMDN6dNapJ
	 mpHcGXXrjXyCdm61vquGV18LKLqiAUeOErpIa1G+A2dLtsBhgQMAeflOrLnERfy46N
	 30YIbVkaihtmhFPMWA/FcCuaXUrQs1bOI+66tjFeZSEoAyIGDG+cqkt8uQdwEzAcHt
	 U7aUCVSJdn3aJhk8KNW6jBZ5MkYpgtOc7iiqqNrZKY/2hSjPAALzuPPE03yOhTSjsx
	 it6vrWiYMH7m9Nutp/ZljIsv4ZQKdNj8ZqKXGx1QxqGnyXqZW1ddTdxBuQwiLHJXD0
	 Kn8P6MEqXCuVA==
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
Subject: [PATCH v2 05/13] ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
Date: Thu,  6 Jun 2024 11:01:58 +0200
Message-Id: <20240606090206.2021237-6-mwalle@kernel.org>
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

There is a comment in the imx6q variant dtsi claiming that these
modules will have one more chip select than the imx6dl variant.
This is wrong. Ordinary GPIOs are used for chip selects and both
variants of the module share the very same PCB and both have this
GPIO routed to the SPI0_CS1# pin of the SMARC connector.

Fix it by moving the third chip select description to the common dtsi.

Fixes: 2125212785c9 ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../dts/nxp/imx/imx6q-kontron-samx6i.dtsi     | 23 -------------------
 .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   |  5 +++-
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
index 4d6a0c3e8455..ff062f4fd726 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
@@ -5,31 +5,8 @@
 
 #include "imx6q.dtsi"
 #include "imx6qdl-kontron-samx6i.dtsi"
-#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Kontron SMARC sAMX6i Quad/Dual";
 	compatible = "kontron,imx6q-samx6i", "fsl,imx6q";
 };
-
-/* Quad/Dual SoMs have 3 chip-select signals */
-&ecspi4 {
-	cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
-		   <&gpio3 29 GPIO_ACTIVE_LOW>,
-		   <&gpio3 25 GPIO_ACTIVE_LOW>;
-};
-
-&pinctrl_ecspi4 {
-	fsl,pins = <
-		MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
-		MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
-		MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
-
-		/* SPI4_IMX_CS2# - connected to internal flash */
-		MX6QDL_PAD_EIM_D24__GPIO3_IO24 0x1b0b0
-		/* SPI4_IMX_CS0# - connected to SMARC SPI0_CS0# */
-		MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
-		/* SPI4_CS3# - connected to  SMARC SPI0_CS1# */
-		MX6QDL_PAD_EIM_D25__GPIO3_IO25 0x1b0b0
-	>;
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 8c7f21f986e1..4a6ab7e7908a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -244,7 +244,8 @@ &ecspi4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi4>;
 	cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
-		   <&gpio3 29 GPIO_ACTIVE_LOW>;
+		   <&gpio3 29 GPIO_ACTIVE_LOW>,
+		   <&gpio3 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	/* default boot source: workaround #1 for errata ERR006282 */
@@ -459,6 +460,8 @@ MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
 			MX6QDL_PAD_EIM_D24__GPIO3_IO24 0x1b0b0
 			/* SPI_IMX_CS0# - connected to SMARC SPI0_CS0# */
 			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
+			/* SPI4_CS3# - connected to SMARC SPI0_CS1# */
+			MX6QDL_PAD_EIM_D25__GPIO3_IO25 0x1b0b0
 		>;
 	};
 
-- 
2.39.2


