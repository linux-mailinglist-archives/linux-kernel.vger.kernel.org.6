Return-Path: <linux-kernel+bounces-531312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A60A43EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E1E19C5928
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89F268C6D;
	Tue, 25 Feb 2025 12:07:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A5267F5F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485259; cv=none; b=mW+PVDQvdI1UQT+yGBLKcpfRrYd4J/u+6g/s/8/eBkd1BTnwhDvrHz4MDOv0YjsXF5xfRMpZDAlweUh8wcYSv59MMewSyKUjYsD6RtCgw8sG7MgCycZ8N7bX7G3vJcXluBBPaMFWHXlea7HUOWa4IyzzA9tFglmSdDD7T6Xwsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485259; c=relaxed/simple;
	bh=19NJbungl9hZx6mGNRWPf1F9WxtvUR9pblNC0dEkMiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtqO2k7+2ZfrvDthGM+Ws77fft3n+U8YX2fvxy0+voTeIKNV69YX8Kz5Vmr4hYD9Zhy2wp3jIOMMf+btN2if1orNlNaBJh6b7uJdImUE36qFbitRK4g966mspnVxnnDLWMAOjrx9oL678ICrD78XXrZPs45EwGuz9PXaIdAJBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1tmtie-00055V-WB; Tue, 25 Feb 2025 13:07:25 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, Sascha Hauer" <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de,
	aford173@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mp: fix micfil dmas settings
Date: Tue, 25 Feb 2025 13:07:05 +0100
Message-Id: <20250225120707.2658709-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225120707.2658709-1-m.felsch@pengutronix.de>
References: <20250225120707.2658709-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The third dma cell is used for priority information not to encode
something else. The NXP downstream kernel use the third cell to encode
more information:

 - Bit31: sw_done feature enable/disable
 - Bit15~Bit8: selector
 - Bit7~Bit0: priority level

but this was never mainlined. Therefore drop the further information and
just specify the priority which is 0.

FTR: The sw_done feature was mainlined without making use of the
devicetree.

Fixes: 5c6d04e48197 ("arm64: dts: imx8mp: Add micfil node")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..af51f1caa71a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1544,7 +1544,7 @@ micfil: audio-controller@30ca0000 {
 						 <&clk IMX8MP_CLK_EXT3>;
 					clock-names = "ipg_clk", "ipg_clk_app",
 						      "pll8k", "pll11k", "clkext3";
-					dmas = <&sdma2 24 25 0x80000000>;
+					dmas = <&sdma2 24 25 0>;
 					dma-names = "rx";
 					status = "disabled";
 				};
-- 
2.39.5


