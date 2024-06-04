Return-Path: <linux-kernel+bounces-200764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F28FB4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BC41C2184F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A612B143;
	Tue,  4 Jun 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeRH4UBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C974297;
	Tue,  4 Jun 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509596; cv=none; b=RcYKONxCUB1VNVttyz9Fv6+6rY4ZnRJX7y17fWG+qJOayNBja/8Bo8QyTeeaw6kfPx+V5KLt/fvlR6iXuemJQhrbpsmqTFgDwBXyxrM9J1pZHfivWfDKkKxFMkg4+RUv22bi97YVVEBzk5HpXRhxgEc1Kuv+ltfVtbiGuB8KrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509596; c=relaxed/simple;
	bh=2Qw+7Rve50c6UoNrfytgIz8RzG/OQfuJ1xjLwlqspyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6cqGN29AGYKVvoeVJEiLD9uXbV8geDU6NmcdLWX3Lwlf/bWMkg1mqb6WI2Mil9M5S4qiEpnjfg3zdPoo2vgjqomA9u0yGa9GJBG7f0oohw6BvZumk00xEDCuJ/rDBbDanK61IYtcggvLDf0NkTQLwCw2vKTqtaJ5P7POZbPFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeRH4UBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02AAC2BBFC;
	Tue,  4 Jun 2024 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509595;
	bh=2Qw+7Rve50c6UoNrfytgIz8RzG/OQfuJ1xjLwlqspyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeRH4UBAp34KH9bLuOJCjmEiebZzChPZgnBRhtxkGe1K2BtDSFHntaN0fdjrck//a
	 LQfoTbvTonNz/oyzjZErxU5vPzzzDMlBQ+7dwQYR0FDBK43OW7BjjEoq0Cs6lenjz8
	 zum7bSsdyk6LZQWM+oN81iUovvg4KRS3Y69Zaxouhpjh0SM9ubntBo9sqvsA3Yre7r
	 NaPRubsW8VmWRvXv0/BIoj4LL4VAHbSYVg0ZjnrQyaaZG62UOTibh7CvySxJMMFN+m
	 Uu/9rUUZKAbLEt2Aie9NLxmkEXUdgYn6fruLW1jhnIr0aWK0LJHyIhY5cVWiLVCajC
	 aHHcnIbhjJ2uA==
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
Subject: [PATCH 02/10] ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
Date: Tue,  4 Jun 2024 15:59:26 +0200
Message-Id: <20240604135934.1951189-3-mwalle@kernel.org>
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


