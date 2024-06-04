Return-Path: <linux-kernel+bounces-200762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF38FB49D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD3C2842C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D83BB24;
	Tue,  4 Jun 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCqaUlTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F68F45;
	Tue,  4 Jun 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509592; cv=none; b=blXTRR3mNsq3B8eZN0+SEF63M7QB0SboyAG7xdcTVNlUFy/bmetOSBJlvXf4SXIIuoaHCWSGiGHPbNFyJMasdhAxd3Na0TOqrw9HyoK4VQC3BGqUc49KZxFVsthYjQH4WyNJI26VG/26jEDrtILQKF0yndQ0SYFIwcXERpOptio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509592; c=relaxed/simple;
	bh=Fc3EWf1xyaS4qCDa8Ib0P/io9+UBcvdp5p0ftGP6Cpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghjut2guroOuEYRXPCr/bt/DksAxqVwoo1v7HbKu+gioa5SHnxXv0uo+HFf+MHBTWLtG02MR84+rh9NTRRZ03z9fmExxocquWtxPYWFBDtLXjHU2PE/twAQ6xMtELv/7M/QfTP9kOgHlquvyfZuNjWWE+QuAeQvFxyyGvdIeeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCqaUlTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325A0C32786;
	Tue,  4 Jun 2024 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509592;
	bh=Fc3EWf1xyaS4qCDa8Ib0P/io9+UBcvdp5p0ftGP6Cpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCqaUlTVX31xEbNvWVZsSdUFZg+20t161rlA6M3O5hkG5wjWkXXH1T5jUZGux42Wr
	 B5/UngxDYKXJ+d3GaG2xZLS9VVokncniWMzwzCh8tg0fS2cJQBWh05hrLS2LyiAmwr
	 95cZ5k+iBJFE5y/5w12LwMl5vJon6BGizZDcTfkpJNEnGS3K087wEBcPZ5FbkCpZFr
	 LWLbM2O5j2Y2WrFCDzs+ISXUVy89/gynAvzXaq7W5+PySuB0gmle/9qbgnrHGn1r5w
	 SIwEHxdbjweK/TLmKzdNMLBfAktRiyDvzhPLyhal+L4HVUquuoPLI7iCtCRpzJOmVD
	 G8jpq00zbQH9Q==
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
Subject: [PATCH 01/10] ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
Date: Tue,  4 Jun 2024 15:59:25 +0200
Message-Id: <20240604135934.1951189-2-mwalle@kernel.org>
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

The iMX.6 cannot add any RGMII delays. The PHY has to add both the RX
and TX delays on the RGMII interface. Fix the interface mode. While at
it, use the new phy-connection-type property name.

Fixes: 5694eed98cca ("ARM: dts: imx6qdl-kontron-samx6i: move phy reset into phy-node")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 85aeebc9485d..d8c1dfb8c9ab 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -259,7 +259,7 @@ smarc_flash: flash@0 {
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-connection-type = "rgmii-id";
 	phy-handle = <&ethphy>;
 
 	mdio {
-- 
2.39.2


