Return-Path: <linux-kernel+bounces-216974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67690A981
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F488B2BD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9B194092;
	Mon, 17 Jun 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8yzg3Uo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08DF1922DB;
	Mon, 17 Jun 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615633; cv=none; b=PEd6Gto50eU8Tkjab7mZ6glAtiLDW1tXUopw7qxikvmQAOSL9f/W0WywBGKtwgZSxBooRcA+MT+iArH+znazmcS7HvAXhG2mwJZfeDS4MA1ogiEVKY7vKeo7q1u923RKJockJ0OrHJyEhg6rcgWdhKB0cRNITfbHOxRZhNiMIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615633; c=relaxed/simple;
	bh=jfhN3gQeFOooI14dJj12+Nce4ihd2CQevZSJ2wlc8zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQ1lwxgjvUjUvoXH28BhXa79Q8ojgVMrA7vPa7JC2OlfZDzn1B/3ql0zy7Srcv95aNuqpuipL36WstJZil/96OsWljRhq2NKgOJpskvf/p8fNrLDuAqgPpPCH188MHd6hbazL2Xe/h5RKsZr6ynHRW+feQ0EDp2dbA8wp62g4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8yzg3Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9604C2BD10;
	Mon, 17 Jun 2024 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615633;
	bh=jfhN3gQeFOooI14dJj12+Nce4ihd2CQevZSJ2wlc8zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8yzg3Uo2PocnGtNi6iyzvh/9o1b4zQJ0poqyeVS7fkVD+Qkf1sKs8CiqxM114l6+
	 ozeLNNyvnJesOK8T+xJFLF40MrvMF28JiPNH7Ggx9KGziLCry8Et2JiISuztO8e7S6
	 JGW5wzleWjZrhGYK9GX9Mc8rPC9PnULN3AWRmxiO4TRSAchsOy8iRyY2U6EfmclYfH
	 aYHjaPdAieqHCJAt1gi95pTeg9n8xI7jijlV+JaViKwrIEUTGLAAuM+aGxFZXAhO9u
	 7NApD6dFsPoyZakqyxfSQOELx6AFbpH2KMuIiHPXGEaJ3B9HKTVo0liloyE0i+INuH
	 HSUSm5xF8byzg==
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
Subject: [PATCH v3 01/13] ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
Date: Mon, 17 Jun 2024 11:13:29 +0200
Message-Id: <20240617091341.2375325-2-mwalle@kernel.org>
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

The i.MX6 cannot add any RGMII delays. The PHY has to add both the RX
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


