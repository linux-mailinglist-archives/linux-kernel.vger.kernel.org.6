Return-Path: <linux-kernel+bounces-203930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8798FE216
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9928BE20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ECD154458;
	Thu,  6 Jun 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGAvkZAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B62E3E5;
	Thu,  6 Jun 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664543; cv=none; b=ourysi5AqK3NuOxut5zPhnGhi5xmrEoHnWvDCoWwMN6ZTFjmqibspsVfNnWuQESzNu+Y1yT2H33pe7JoTzGiuaLJ2EyKPAsitneGRcfgDyvqbZ2H5vngDD4ZDDwZv+KDKy0Gdc4p4wrC957V6phIEQ7jfrhCH1nyZKzbzW9KJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664543; c=relaxed/simple;
	bh=Fc3EWf1xyaS4qCDa8Ib0P/io9+UBcvdp5p0ftGP6Cpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClK0/4qRSYDoDTt2juhBun+uYrZbuyTM570X7o4aTkJa4GI2y3A2qk3flYW7LlYGV7Q/iUra7oEAYhDcm99LN+2E5BXnxEdbq+aShDhDcdAqIM2SEZodBGGBb2yOYittNKLDuopvcBgMbcEcpVd7QeuBug8OBW3YK+W2o3uNBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGAvkZAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0997C4AF0E;
	Thu,  6 Jun 2024 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664542;
	bh=Fc3EWf1xyaS4qCDa8Ib0P/io9+UBcvdp5p0ftGP6Cpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGAvkZADY2fa+063+uyU0aMLkNJvvH/MfVMK4hYUYHlswrgrz9jqwmemtCKibo9ix
	 w4qhSB3XZuNR2AbiZ8msPxv8dpR9W6cEvvTwI/qZ8Kfy4Pc0mQStMuRClMuoAUgUy5
	 ze35Poq+wQe8F3HxIm+WSmkj19CTVSbHZaoJJfnjjXl1JGi6XM++MlL/Mq2M5Pd2V4
	 6lYEo42TS9ZELlqjWxs8+9nijO+p4HQgYZgA4QK0RVls8ggrB9TvvR4SZDQej7v60B
	 oe/Ox3l4lmfKDuwTlHbes3KvRFc01xao6wsQnH5q7AzropRG+CsTPhti79vD1uKxXM
	 +uEV4oli0MrEw==
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
Subject: [PATCH v2 01/13] ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
Date: Thu,  6 Jun 2024 11:01:54 +0200
Message-Id: <20240606090206.2021237-2-mwalle@kernel.org>
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


