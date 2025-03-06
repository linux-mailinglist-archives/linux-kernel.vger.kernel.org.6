Return-Path: <linux-kernel+bounces-549820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EAEA55793
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B717ABBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B6276020;
	Thu,  6 Mar 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="BlqF1OUY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04727275604
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293565; cv=none; b=kezhqTwfBQ8M5yqQubT6ocUK9Fd2tniPY80KQSzGo4ijbiXKsA5eb51gX+W3R1B3nTDA7iWBRGDorxgpxEzoFKubJx7CH7wjkV0IdT72OIuC5DASmFtg+b0yMQWdk0IpEeEiAy2KBlpOxJ8AEXLGszVmxX4lk/SBiotEUMmxjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293565; c=relaxed/simple;
	bh=3oyhS/neJz80BZOQqYNoBOpdxi5uNvHfAJDCokDJxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omvz1wqvqpAFnd3KAq1lY+1IpSZJqs+Z9ULRgLnsNjVOPVmQseOzRNVpomQfoNHPGXPSDiZGCinC7028umikm9ubtk9NiFebKA6GsbxBak9eyVQFq1lV6PdyQ2tsGXNMEfkYYfbtFgE99XpI0IJr7pDWguQV4+ISSipI4DfykHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=BlqF1OUY; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741293563; bh=qK3GcAy1T7b7ZQP5vAw6ojWgGkMIfURsR+RxPTcGPYs=;
 b=BlqF1OUYam+fpDXa8SzcU2uNa5WCLOkCY+3nzkkGJw2Ni8oUOz52FZrZH9OANWZtWk9FUCRyQ
 +hYdKHwKlka/po0pG76Ha7fVfZ+3yKQx7aGiWu8o2zUQ7yot2+Xjdn22tOQJgpfraTqTpns5IDp
 yBusYKWOW/JjvPMhddnCF4AQZIgZE4mDbjij5wUgOVKYNeQN3KIUtPsgt+da9UzSB1B6Vk0mcbD
 6ncMA1M9zJhvB9BspTDlaPYfmIr7i69NCwHwSLAR7xgLu8z7GxqD7ggL/6V3MWn+bnYDMZAGxFC
 mRL1E/guuboJSCCOkHhKe9wzSGOQvSMIeDxkyEw4QvrA==
X-Forward-Email-ID: 67ca07f4deafcb1458af928b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Wu <david.wu@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3588
Date: Thu,  6 Mar 2025 20:38:54 +0000
Message-ID: <20250306203858.1677595-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306203858.1677595-1-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Rockchip RK3588 GMAC was added without use of the
DELAY_ENABLE macro to assist with enable/disable use of MAC rx/tx delay.

Change to use a variant of the DELAY_ENABLE macro to help disable MAC
delay when RGMII_ID/RXID/TXID is used.

Fixes: 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 37eb86e4e325..79db81d68afd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -91,6 +91,10 @@ struct rk_priv_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define DELAY_ENABLE_BY_ID(soc, tx, rx, id) \
+	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE(id) : soc##_GMAC_TXCLK_DLY_DISABLE(id)) | \
+	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE(id) : soc##_GMAC_RXCLK_DLY_DISABLE(id)))
+
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
@@ -1322,8 +1326,7 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3588_GMAC_CLK_RGMII_MODE(id));
 
 	regmap_write(bsp_priv->grf, RK3588_GRF_GMAC_CON7,
-		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
-		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
+		     DELAY_ENABLE_BY_ID(RK3588, tx_delay, rx_delay, id));
 
 	regmap_write(bsp_priv->grf, offset_con,
 		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
-- 
2.48.1


