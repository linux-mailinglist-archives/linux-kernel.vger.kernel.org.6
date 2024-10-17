Return-Path: <linux-kernel+bounces-369120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43E9A1938
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74C4B24E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60313B797;
	Thu, 17 Oct 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NsddcrC1"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08351F94D;
	Thu, 17 Oct 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134729; cv=none; b=Do7s8/429AyEKtYKyRY0FF0KpgP5UIxSZwNin4PxD2xlZsdFyWon//XGIG58A6XfTPP77nQ0LM6b0w4f5N7SR6MVj1p8cukUjWS9dwhG+OGV5oN1qxzAO/LrQQrqht+MXFMBAaN1bF7+hYnVBLR63WdqfTigwuKa6IcciOR4ShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134729; c=relaxed/simple;
	bh=0IkbNxOYpWXhsI2aop9kBqve+SFPotsqZp42C7oEock=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auOO+USocBeAG7MTq7xyGVem2DUBZ3XBkeVpQB2+BHLZF16AXxokI1+9be365lRdaIfhnvGvhkBSf5Fr9mSDSHA1ZdXy/bnzmvO7DGKeN/wKQo2CzoS1FJPFS3oNS/kUdAACUAefQwTF77VKZOsrXTy+N+it4XgOTL1PVslEA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NsddcrC1; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 802D488E1B;
	Thu, 17 Oct 2024 05:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729134723;
	bh=wNosOTgIHyHlJ/O2cQTioP0e+HMKQiAOT0yUIRwpr7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=NsddcrC1DsO83rFLHFQf8qad3Q1V5IN/EmarqxLMCadbeB/sdN9DUMhS8e9CRflJC
	 uAj8pZesrs1YsVx6xy8thEDeJxYm1RdzrCuWK3I18wL4RpKQ8RU4fqHPWjMwMxo/uW
	 mHowOGo9iJTQ+fBE6Xk6O806PKKniWhbtvJ16fpCcrzgIsDcRyP5DwAHGu4ofy0+r9
	 I7A3qBMhGAJlw3H7putLDAVMkAG4YdkL9am/bId8l6tNSnivNSd7T/BpHfmSn3J3hV
	 cnSmySnknIEbyoF2WNBdUvi1KutxxbeJAhUJ0EzyHxHpItphHkWyOHI0DphevzhyaK
	 PeWixrh6iAgrw==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@dh-electronics.com,
	Marek Vasut <marex@denx.de>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Yannic Moog <y.moog@phytec.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1 frequency to 506.8 MHz
Date: Thu, 17 Oct 2024 05:11:20 +0200
Message-ID: <20241017031146.157996-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The LVDS panel on this device uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1
to 72.4 * 7 = 506.8 MHz so the LDB serializer and LCDIFv3 scanout engine can
reach accurate pixel clock of exactly 72.4 MHz.

Without this patch, the Video PLL1 frequency is the default set in imx8mp.dtsi
which is 1039.5 MHz, which divides down to inaccurate pixel clock of 74.25 MHz
which works for this particular panel by sheer chance.

Stop taking that chance and set correct accurate pixel clock frequency instead.

Fixes: 326d86e197fc ("arm64: dts: imx8mp-phyboard-pollux-rdk: add etml panel support")
Reported-by: Isaac Scott <isaac.scott@ideasonboard.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Isaac Scott <isaac.scott@ideasonboard.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Note: I do not have the board, but Isaac reported they tested it successfully.
      TB would be nice.
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 50debe821c421..9c102acb8052c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -218,6 +218,18 @@ ldb_lvds_ch1: endpoint {
 	};
 };
 
+&media_blk_ctrl {
+	/*
+	 * The LVDS panel on this device uses 72.4 MHz pixel clock,
+	 * set IMX8MP_VIDEO_PLL1 to 72.4 * 7 = 506.8 MHz so the LDB
+	 * serializer and LCDIFv3 scanout engine can reach accurate
+	 * pixel clock of exactly 72.4 MHz.
+	 */
+	assigned-clock-rates = <500000000>, <200000000>,
+			       <0>, <0>, <500000000>,
+			       <506800000>;
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
-- 
2.45.2


