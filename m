Return-Path: <linux-kernel+bounces-216975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9390A94B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E2228B4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479CD19413C;
	Mon, 17 Jun 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSgLRADI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863511922DB;
	Mon, 17 Jun 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615637; cv=none; b=dhKvAM9Mwa6mGpRvf9iWOa6KRokmHwaROErIFUE7psiXzDoLF+1RTWVZv6L3tYi4Id/hnlrmVvT167qwwT43Zus/RnW085rfaVgfPCZCJqyrCO52j0zr14SWkbOph1FPtEKJuhdwO5WrPckSf4I1sYZM0YVIHsrLfeqalCJKdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615637; c=relaxed/simple;
	bh=2Qw+7Rve50c6UoNrfytgIz8RzG/OQfuJ1xjLwlqspyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVZLX6ttKMB27+9C4E1DzaCusgL0hFSO3/GlDa5Lr5DJa1Hbsc+tOmAT4tVTbWU7Y6jk0oFbSdzkPhpQCN5F0lLtALwnRHzJXssBr7sERNXfdIXNEruOI2E6oP5QLIROYC1vja2RHpBiUbYKQQkFjAIRlBvZFZsejxIZVWBEEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSgLRADI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA09CC3277B;
	Mon, 17 Jun 2024 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615637;
	bh=2Qw+7Rve50c6UoNrfytgIz8RzG/OQfuJ1xjLwlqspyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSgLRADIKoOCmMyFRz+CnOHRTTUWVz36ssNelNd6IkjvMKrJEc9aQ82LdxSAMh9S8
	 peNxBrFbD3hFQEevslagbikhL4fvdMvvdB6/wLBjPI/WkDoVrhB/1jMlnUdzzm3snl
	 adk2dQjYfmBivIiWVk0cDHdvFYP06g2KV+jNo619u+aehEkLMnArTxxedkpbBgZmVu
	 1osLfnHwZ5GYDsfHcFaRTo8X8xAfJmeIThRDU0TeKxgvD5vY+3BT3qGWJlTUoTyc9A
	 hr0jzg5dzS+DgZK+1Tg9cMWLJyWU8kq2h6XqOu1FeqIuFi+qe8e3bBQG4ynzZbhJwK
	 5zeC/R0g4Kb6A==
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
Subject: [PATCH v3 02/13] ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
Date: Mon, 17 Jun 2024 11:13:30 +0200
Message-Id: <20240617091341.2375325-3-mwalle@kernel.org>
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

The PHY reset line is connected to both the SoC (GPIO1_25) and
the CPLD. We must not use the GPIO1_25 as it will drive against
the output buffer of the CPLD. Instead there is another GPIO
(GPIO2_01), an input to the CPLD, which will tell the CPLD to
assert the PHY reset line.

Fixes: 2a51f9dae13d ("ARM: dts: imx6qdl-kontron-samx6i: Add iMX6-based Kontron SMARC-sAMX6i module")
Fixes: 5694eed98cca ("ARM: dts: imx6qdl-kontron-samx6i: move phy reset into phy-node")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index d8c1dfb8c9ab..d6c049b9a9c6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -269,7 +269,7 @@ mdio {
 		ethphy: ethernet-phy@1 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
-			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <1000>;
 		};
 	};
@@ -516,7 +516,7 @@ MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
 			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
 			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b0b0 /* RST_GBE0_PHY# */
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x1b0b0 /* RST_GBE0_PHY# */
 		>;
 	};
 
-- 
2.39.2


