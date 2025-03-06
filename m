Return-Path: <linux-kernel+bounces-549819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05BA55791
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCDB188E9D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EA278114;
	Thu,  6 Mar 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ocIaY6br"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867D276D33
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293557; cv=none; b=EZuakX2RXtYR9mjze7EkkZisVtdvRaO17RQfYTHU7uubVpA4FXkz+h3jhfd6LJIFshTc9n2uZP8nBgVSyuO2TZhu6AjzRMh4WfzX6NiZhj/dt93+1pkzqy5fCmffkmGfHw3PbMRVSy4SK64gkuLfl6xVrZwNUO2OKEsIRd5/02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293557; c=relaxed/simple;
	bh=9aoxFI2B+mD9My0HbvJ4N51Lsc7k7yX5fH7tkCyc4HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZavwJItNO/Q0c91V5taChfnWp3QNjz9r2umd+eLjnr+qOjYjxPZl4xodd9n+0AZ+SweyWRrT+UE/0bkA6XLmg86Wskf3fvelpJuAzhqZcB/zCg3yABjqXoj7/2ZWgfkEGSmI9DAdndJpat3LfDZbEqA1GyJWrefLN6z/waF1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ocIaY6br; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741293554; bh=YyDWZm/uji1wnOwzLL0mO19G3wOIsbkpkj7q10ooChs=;
 b=ocIaY6brCvyCWigrNCSntNZ278iUaEDFBNh1LKBp/NYTO/Wt7AMeiCvIKqr34lQPyYZIbw9Qj
 v+a0wtjH9eOx63STBt5hmRkP5Q2UP0jarbljnpKiQsHuS64KYKYdeCpKonf1/fG/GZe4jsv+SRv
 Xw6p/a5lmWzvI9a3LVsURypiKVymx3yBZ7+ktdTdcS0Ow+Klduswh5TEQo8a4TocduCt8vEzHxE
 5mrWXh8yWUX2SsbqrMzysBcbDZU68Z/WaInN4/Tqe/xW9kfBbW05XwBxer4oy3YoKPiPQbpRREY
 c3kiwC1myykkYJ7kobyd3b8qFRyTG22yBEWeQSYiWK8w==
X-Forward-Email-ID: 67ca07f0deafcb1458af9276
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	David Wu <david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3566/RK3568
Date: Thu,  6 Mar 2025 20:38:53 +0000
Message-ID: <20250306203858.1677595-3-jonas@kwiboo.se>
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

Support for Rockchip RK3566/RK3568 GMAC was added without use of the
DELAY_ENABLE macro to assist with enable/disable use of MAC rx/tx delay.

Change to use the DELAY_ENABLE macro to help disable MAC delay when
RGMII_ID/RXID/TXID is used. This also re-order to enable/disable before
the delay is written to match all other GMAC and vendor kernel.

Fixes: 3bb3d6b1c195 ("net: stmmac: Add RK3566/RK3568 SoC support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 297fa93e4a39..37eb86e4e325 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1049,14 +1049,13 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
 				     RK3568_GRF_GMAC0_CON1;
 
+	regmap_write(bsp_priv->grf, con1,
+		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
+		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));
+
 	regmap_write(bsp_priv->grf, con0,
 		     RK3568_GMAC_CLK_RX_DL_CFG(rx_delay) |
 		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
-
-	regmap_write(bsp_priv->grf, con1,
-		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
-		     RK3568_GMAC_RXCLK_DLY_ENABLE |
-		     RK3568_GMAC_TXCLK_DLY_ENABLE);
 }
 
 static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
-- 
2.48.1


