Return-Path: <linux-kernel+bounces-259984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27693A0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7C1C22227
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1033152E0E;
	Tue, 23 Jul 2024 13:04:34 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA415278B;
	Tue, 23 Jul 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739874; cv=none; b=OdU9N9KOG2fMex8XEin/TWZ2+tt8N9sCeHaXfjzST9n3uQBo97TLApLoHsMeqotWQ88qrj1896t8KLPjsITMwbzd+rwNbFfW0wqsqnwe4uuw0F+74iZf7k84UlEfCKfKimZ3yk3NV7bG3Qb0FXd/K9H8KrZUl1GUBbGKsubGThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739874; c=relaxed/simple;
	bh=mLZoVtdeN8vsh1LLx1S1tL6hGz3gaMG1cYsa3KbC3og=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZLA7j1X+iMUL/+sR0Axg7Brz5GZRRDJ/xBxZmUnpSncENTaYAwco5kmxe3z+7hQsOyAFTnkf1rjok8AKbjfTBxmhzL9FOKPa1nD6nwNnWv6hABC+hlNWr9IxofG0vvQ0bdp2G2ppXuzAJKNdMW6FTuzX5+zgF4rOq5RUSO37zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sWFBb-000000001CH-0Ryw;
	Tue, 23 Jul 2024 13:04:11 +0000
Date: Tue, 23 Jul 2024 14:04:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
Message-ID: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Clocks for SerDes and PHY are going to be handled by standalone drivers
for each of those hardware components. Drop them from the Ethernet driver.

Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
The dt-bindings part has been taken care of already in commit
cc349b0771dc dt-bindings: net: mediatek: remove wrongly added clocks and SerDes

 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index eb1708b43aa3..0d5225f1d3ee 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -724,12 +724,8 @@ enum mtk_clks_map {
 	MTK_CLK_ETHWARP_WOCPU2,
 	MTK_CLK_ETHWARP_WOCPU1,
 	MTK_CLK_ETHWARP_WOCPU0,
-	MTK_CLK_TOP_USXGMII_SBUS_0_SEL,
-	MTK_CLK_TOP_USXGMII_SBUS_1_SEL,
 	MTK_CLK_TOP_SGM_0_SEL,
 	MTK_CLK_TOP_SGM_1_SEL,
-	MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL,
-	MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL,
 	MTK_CLK_TOP_ETH_GMII_SEL,
 	MTK_CLK_TOP_ETH_REFCK_50M_SEL,
 	MTK_CLK_TOP_ETH_SYS_200M_SEL,
@@ -800,19 +796,9 @@ enum mtk_clks_map {
 				 BIT_ULL(MTK_CLK_GP3) | BIT_ULL(MTK_CLK_XGP1) | \
 				 BIT_ULL(MTK_CLK_XGP2) | BIT_ULL(MTK_CLK_XGP3) | \
 				 BIT_ULL(MTK_CLK_CRYPTO) | \
-				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU2) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU1) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU0) | \
-				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_0_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_1_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_SGM_0_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_SGM_1_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_GMII_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_REFCK_50M_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_SYS_200M_SEL) | \
-- 
2.45.2


