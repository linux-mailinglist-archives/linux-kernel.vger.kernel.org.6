Return-Path: <linux-kernel+bounces-520087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9ABA3A57F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875D3188A8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E417A2EC;
	Tue, 18 Feb 2025 18:27:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242C17A2E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903241; cv=none; b=gq9xWRNJcy7FCU0Gr3dxxqsG9rDdun9gS1WQmqh/2BpW5oNrIM0w7eF3rIcQWom5VjmwCQHyBgXw0IG+we/KZ+dGWnrT5rNRMsk2VQof5HEGYI5Gplr7A6G33l1Yebzn6Gdoy+mN3JG9+9HP/sA3GV4vhv2p3ae95J7dM7tUQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903241; c=relaxed/simple;
	bh=QingAdBWEQbqiJhLelCQaU7rvUBDQR2RcgntHJJclcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4FjR/ab+ME+GJQBtijiuA5BqGwyei5RicAAf0amf0Ak27v/x84+Ei6qZUosdu6vvkx5NlQv5XZzdQxO9eiIq0xgqx1fJoWDMLsPN3WrdOmQk025G2XGC4BILcmM5KT1NWaCtNtAZNZMLgc3RYn1/PTqjMssybStgC07M61PgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIy-0006Bj-0z; Tue, 18 Feb 2025 19:26:48 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIx-001dVD-1g;
	Tue, 18 Feb 2025 19:26:47 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIx-00A9Hm-1E;
	Tue, 18 Feb 2025 19:26:47 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 18 Feb 2025 19:26:44 +0100
Subject: [PATCH v4 4/6] arm64: dts: freescale: imx8mp-skov: configure LDB
 clock automatically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-imx8m-clk-v4-4-b7697dc2dcd0@pengutronix.de>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
In-Reply-To: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abel.vesa@linaro.org>, 
 Marek Vasut <marex@denx.de>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The comment in the DT mentions that "currently it is not possible to let
display clocks configure automatically, so we need to set them manually".

Since commit ff06ea04e4cf ("clk: imx: clk-imx8mp: Allow media_disp pixel
clock reconfigure parent rate"), this is no longer the case.

Make use of this new functionality by dropping the now unneeded
assigned-clock-rates in &media_blk_ctrl.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 .../dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
index 2c75da5f064f2b0cd97f5040febac13c4adc020b..a13f6d76a495936575ead53e4ea69ed39f80d61c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
@@ -51,8 +51,11 @@ &lcdif2 {
 };
 
 &lvds_bridge {
-	/* IMX8MP_CLK_MEDIA_LDB = IMX8MP_CLK_MEDIA_DISP2_PIX * 7 */
-	assigned-clock-rates = <490000000>;
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>,
+				 <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_DISP2_PIX * 2 * 7 */
+	assigned-clock-rates = <0>, <980000000>;
 	status = "okay";
 
 	ports {
@@ -64,18 +67,6 @@ ldb_lvds_ch0: endpoint {
 	};
 };
 
-&media_blk_ctrl {
-	/* currently it is not possible to let display clocks confugure
-	 * automatically, so we need to set them manually
-	 */
-	assigned-clock-rates = <500000000>, <200000000>, <0>,
-		/* IMX8MP_CLK_MEDIA_DISP2_PIX = pixelclk of lvds panel */
-		<70000000>,
-		<500000000>,
-		/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_LDB */
-		<490000000>;
-};
-
 &pwm4 {
 	status = "okay";
 };

-- 
2.39.5


