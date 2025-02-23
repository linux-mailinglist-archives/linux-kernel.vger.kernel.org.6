Return-Path: <linux-kernel+bounces-527692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2BA40E39
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65D316881F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CC207A3F;
	Sun, 23 Feb 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TmbmcNdQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100D2AF04
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308555; cv=none; b=ebUfINQtfvPZMfnw4tB5SiU+884D51qyn2TugwfvdXR3KaQwMv9mzVJyBbZ1ILDu0lJ9LEEgspXB0zH7eep/R+I8P9nUWz+vFMBlN5kmsGLT4j39fZgdriw7/AlY20LQlaY9c0nnIBl2ipWQrfFh6iJrElITBbc4xo/HWvnaYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308555; c=relaxed/simple;
	bh=0dn21Kt3/3x2MUjvwMowS6nDRN6vgqToU9gCl2sx3Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asXpQr2BJD0ckTq8KLHkuHc6stiLOEH07X1jJugskRmt8fg1ezHrIt1/Uq67o5XPqNIvIp1pxFPKqA81HYu+1xOY9TvjpgKd1TlMjQTMMjKqFAmgstEUzOGhfg2FgZ/oqOcVwrLzvS9Khd7ja8xruvsS4Yo2sylCHfoM4hf3JTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TmbmcNdQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308551;
	bh=0dn21Kt3/3x2MUjvwMowS6nDRN6vgqToU9gCl2sx3Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TmbmcNdQzhl5jplBgNx4a8dNssqfY/l/mbYDtpkuYUPcO0SVkhS0GB+ttgN355ZGM
	 r5nceZR0gSbg3HGegxKLLfqkh1QKW9H1BAvnA4VBL371gqEwW5FcspRmdDLcVLHPJ5
	 ZwkW5vwWmxtEHidrM3P33Jf5bsZDPsAtF8BrxSYt/haBW7olBbrngPjgeuxYFJSBDO
	 Tz8vcuaLjZkejSKkXlevjmrOlaHTfZWL1Fn/DgzW8KkvoeLblIH+jAkPT/zATtBL6k
	 +E1Y74hQWXahkZmOKQZPoJ6VtoSXyoyP3hNmVTnUyzQBVLAMWXYmHoOr5ARyUJYkXl
	 zJV8v8IBzbH5g==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9D42617E087E;
	Sun, 23 Feb 2025 12:02:31 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 13:02:14 +0200
Subject: [PATCH v3 7/8] phy: rockchip: samsung-hdptx: Cleanup internal rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-7-66a5c8e68327@collabora.com>
References: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
In-Reply-To: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Drop the rate parameter from a bunch of internal helpers and, instead,
make better use of the newly introduced ->tmds_char_rate driver data.

No functional changes intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 27 ++++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 792ed3d1459f84e735041f55cac15941f6f785ef..fdac60bb87510002626735e0e9f18ad5de9a6642 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1042,14 +1042,13 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	return rk_hdptx_post_enable_pll(hdptx);
 }
 
-static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
-					   unsigned int rate)
+static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx)
 {
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (rate > HDMI14_MAX_RATE / 100) {
+	if (hdptx->tmds_char_rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
 	} else {
@@ -1101,10 +1100,10 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 		     HDPTX_I_BGR_EN << 16 | FIELD_PREP(HDPTX_I_BGR_EN, 0x0));
 }
 
-static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
-				     unsigned int rate)
+static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 {
 	enum phy_mode mode = phy_get_mode(hdptx->phy);
+	unsigned long rate;
 	u32 status;
 	int ret;
 
@@ -1121,8 +1120,9 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
 	if (mode == PHY_MODE_DP) {
 		rk_hdptx_dp_reset(hdptx);
 	} else {
+		rate = hdptx->tmds_char_rate ?: hdptx->rate;
 		if (rate) {
-			ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
+			ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
 			if (ret)
 				goto dec_usage;
 		}
@@ -1420,23 +1420,24 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_phy *hdptx)
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	unsigned int rate = hdptx->tmds_char_rate / 100;
 	enum phy_mode mode = phy_get_mode(phy);
 	int ret, lane;
 
-	if (rate == 0) {
+	if (!hdptx->tmds_char_rate) {
 		/*
 		 * FIXME: Temporary workaround to setup TMDS char rate
 		 * from the RK HDMI bridge driver.
 		 * Will be removed as soon the switch to the HDMI PHY
 		 * configuration API has been completed on both ends.
 		 */
-		rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+		hdptx->tmds_char_rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+		hdptx->tmds_char_rate *= 100;
 	}
 
-	dev_dbg(hdptx->dev, "%s rate=%u bpc=%u\n", __func__, rate, hdptx->bpc);
+	dev_dbg(hdptx->dev, "%s tmds_rate=%lu bpc=%u\n", __func__,
+		hdptx->tmds_char_rate, hdptx->bpc);
 
-	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
+	ret = rk_hdptx_phy_consumer_get(hdptx);
 	if (ret)
 		return ret;
 
@@ -1467,7 +1468,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+		ret = rk_hdptx_ropll_tmds_mode_config(hdptx);
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1811,7 +1812,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate / 100);
+	return rk_hdptx_phy_consumer_get(hdptx);
 }
 
 static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)

-- 
2.48.1


