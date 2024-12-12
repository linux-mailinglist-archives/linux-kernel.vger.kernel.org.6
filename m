Return-Path: <linux-kernel+bounces-443869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C09EFCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDD316C000
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9F1D8DE1;
	Thu, 12 Dec 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hXjf0I6K"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EF1B4120
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033848; cv=none; b=r/e/Emzw77/5G/+YHU5mw9W6U4zyeilAZH63MzYXNJqZi1Sw7B5vYZAJ8QdINX2N556kihu6z/ulk6qEphjog0AYKPtcwV32Ck2F0Om/ohAw2hXdlNMyfmmbkPdG7KXqZ24Z9PsQ9rMmCGaTvgKFYLpEvu/KJQLrFP46uV/IWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033848; c=relaxed/simple;
	bh=H/Zc3kk2/NoQ97dNv5UBIPpAh2oYcExYnQ8LjYtdYTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vz/IrHaPhmwTvw8NNWW2n+dLG2KG86IqosRAgFVH6/ocFsawPjh3RNZZ/S8U26z73UIdY0Q7jmbNYgDgjPKnYMpLFIQPTY84+tej7Xe58/zRxK73EV3xwZKJqg5UQd1UvWjfwkaY2qaDwGNfx8J7loiPXOpps9vEJxt/0bpz/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hXjf0I6K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734033840;
	bh=H/Zc3kk2/NoQ97dNv5UBIPpAh2oYcExYnQ8LjYtdYTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hXjf0I6KjvxuGBT/Bwd++0eRLDEcHMGwR2IBESAORKXR4kx0mfF0YB8fiez1f06K1
	 6XJk6C8un4ByQzV2Zm4UMOpZX80Rb67cbuqYHsowlr0jOvDlnj2Fp5Cojx40AznI4P
	 lmGSvkFWfrsDe0eKUxNHAh0H8mNdpAFMm3S8K9b0HhR+nTOsP5u0eoLkHSzp1GZ+td
	 vGxTQliI/yCeoP41kIztD5TbawBohGTLHXBgjPT4KMf5o4Qks8ySVABWa0Jgqq2OAg
	 c4Qq+uEaFjR0Lx+Y49g3Gq/LUzDg7GAQebbwwywoGVe11CrWPUZz8Vabq19rpA8aZe
	 oh5iGg0hpnLvA==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 175DA17E3803;
	Thu, 12 Dec 2024 21:04:00 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Dec 2024 22:03:38 +0200
Subject: [PATCH v2 7/8] phy: rockchip: samsung-hdptx: Cleanup internal rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-phy-sam-hdptx-bpc-v2-7-57e672c7c7c4@collabora.com>
References: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
In-Reply-To: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
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
index d90d89cfdff561e13ac3db3f143a4eef9cc85a03..bc513ddd5c052763856a113a7f1e58660f7372b8 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -796,14 +796,13 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
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
@@ -820,9 +819,9 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
 	return rk_hdptx_post_enable_lane(hdptx);
 }
 
-static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
-				     unsigned int rate)
+static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 {
+	unsigned long rate;
 	u32 status;
 	int ret;
 
@@ -836,8 +835,9 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
 	if (status & HDPTX_O_PLL_LOCK_DONE)
 		dev_warn(hdptx->dev, "PLL locked by unknown consumer!\n");
 
+	rate = hdptx->tmds_char_rate ?: hdptx->rate;
 	if (rate) {
-		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
+		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
 		if (ret)
 			goto dec_usage;
 	}
@@ -879,26 +879,27 @@ static int rk_hdptx_phy_consumer_put(struct rk_hdptx_phy *hdptx, bool force)
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	unsigned int rate = hdptx->tmds_char_rate / 100;
 	int ret;
 
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
 
-	ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+	ret = rk_hdptx_ropll_tmds_mode_config(hdptx);
 	if (ret)
 		rk_hdptx_phy_consumer_put(hdptx, true);
 
@@ -950,7 +951,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate / 100);
+	return rk_hdptx_phy_consumer_get(hdptx);
 }
 
 static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)

-- 
2.47.0


