Return-Path: <linux-kernel+bounces-216983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23190A959
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600AF1C20C03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C909195993;
	Mon, 17 Jun 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcO8MRlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E5191487;
	Mon, 17 Jun 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615667; cv=none; b=MVP/CnpfKDaw4rzQhvElVJB+Tfq+w4NKJN8UpX2bMjc93Zvl2prYN7mNMt8O/qBUBXFO9s8GzD6uL5ebhDLVn8fC5wAZdmE3UshtNNIHsdwED718Cg/MGfm0+w3E61Tbc6BUA3+a1O9Qxa3osO5IAW1UGC/EIUAfw2faP+qgBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615667; c=relaxed/simple;
	bh=fLzK0kTI9Tfc5pcfO4P9fZmej83wx+iFj8ikPvPtfBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp+NxgHQtZCw6Bv7FnOZGr+OLk4a1njAX3TOEdik5AME++6Wo+wwy5VqHBtaIu+lUAIl/P7WUeXHZgLaqMcqGZhRdaDvYErSlcm0HhJVR8E45YQVNOjXkjn0CWmg7fvlBUE4MWxpMoOyJyOVL7lsRLi9Pxe2T0ybmfVtCBW0Ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcO8MRlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52717C2BD10;
	Mon, 17 Jun 2024 09:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615667;
	bh=fLzK0kTI9Tfc5pcfO4P9fZmej83wx+iFj8ikPvPtfBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcO8MRlJHQv5Cc1SUYTMLubHFcdI5yS2+ktpI5gmXmNFmHvD7feGXtQd8ebxjwjaD
	 yJRMXF4BAt0r7lR3bckBUQB133KRDLOaUSPPik/vfbRPucDaqD/Vcr2r90mRIYhfev
	 FTFb+NeCr9JmalkKumPvOCW2B3Rv3nkOHsX/QSMX7yVeZM7cgTvxMjxcgtD3CF804W
	 I9XEleethBz79+wnCOH2zNm+TSTeZ+3PJacP8t8rSAHKSmCHT5hv6YAyDpvJbCsZN9
	 LvViBkWvHsO+2vnqKne+rmPRxm+hDYpol1wM1A65/lnw/3bzj6aYSm+H81FAp3vnga
	 yDPzHRTM031wg==
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
Subject: [PATCH v3 10/13] ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
Date: Mon, 17 Jun 2024 11:13:38 +0200
Message-Id: <20240617091341.2375325-11-mwalle@kernel.org>
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

The PCIe reset line is active low. Fix it.

Fixes: 2a51f9dae13d ("ARM: dts: imx6qdl-kontron-samx6i: Add iMX6-based Kontron SMARC-sAMX6i module")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 7eeffd6eb476..17abebc006df 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -744,7 +744,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	wake-up-gpio = <&gpio6 18 GPIO_ACTIVE_HIGH>;
-	reset-gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	reset-gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
 };
 
 /* LCD_BKLT_PWM */
-- 
2.39.2


