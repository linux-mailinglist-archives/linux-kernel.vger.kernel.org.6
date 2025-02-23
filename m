Return-Path: <linux-kernel+bounces-527691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13CA40E33
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335DF1894BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E179207A11;
	Sun, 23 Feb 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oHi4R4xd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D70205E0E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308554; cv=none; b=qhK6bOZnp4N8570Lz9yI8fE1MauAIaa/yI99PPenVvtEznN9aNYfykKE/rXtIbho7+QQUECx36MCy9J0k6cHNesQtTAo1EhHBNCSXagQE3DbhkYryxXKh0CJD4zxz/p9SOAQFk8kwsbnW3Pfg8k9i9NWyddtK866vfoCu/tBvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308554; c=relaxed/simple;
	bh=tpPMKEn4y6Q4gIkPhcILqIjsfH9Lu+r8Lssviy8ylJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdfnG9tebR23DPuZjH1qTRVHz2wI7dms86r6sk0Qq48fjgmQ5abssErsxlUUMqHSyLAisnGRQXVuO0T93+mrOdT4oc+8ZCANBTDgWS5W0qHJcYajrTbphKP0fKpG6cwWXp9HJ/TFVmwQOCpV5+KU0vLTYU5OS6NdbXCBduocqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oHi4R4xd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308550;
	bh=tpPMKEn4y6Q4gIkPhcILqIjsfH9Lu+r8Lssviy8ylJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oHi4R4xdGmLKlq+ydb5zw2ytPy4NnojgNAWLi3TI7x5rKuGtEXzmq9KpfDRtlyRKw
	 oIxv2VY943jzsX3ne08xc+w3EDXl2vcLExy3aMKOKm3y1dsiMVY/sKGb4zUPiNzlI0
	 AoaROsM81rHEVfKqN7wMPeE21gPJb/02sdKTfkIaIau4fQMDJyfoP27dyrtj+ERHHI
	 CRIuwK8ERloLbCygNVdExgD0YyED1YqoCT0CCJpTwac4BfAtwHJ2AfTiYHhLPO8j53
	 4DqSy32OQ+/SmW8nOvJjlkkhKGSd3OV5Zx0i+A2eizaMmpPHh5rm+RIeMNBQmpc0cQ
	 Ow4taIL3jsMEw==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id D4EC517E0DD7;
	Sun, 23 Feb 2025 12:02:29 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 13:02:12 +0200
Subject: [PATCH v3 5/8] phy: rockchip: samsung-hdptx: Setup TMDS char rate
 via phy_configure_opts_hdmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-5-66a5c8e68327@collabora.com>
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

The current workaround to setup the TMDS character rate relies on the
unconventional usage of phy_set_bus_width().

Make use of the recently introduced HDMI PHY configuration API for this
purpose.  The workaround will be dropped as soon as the switch has been
completed on both ends.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 37 +++++++++++++++++------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index f9b5c96d6c789e435657e224032d35b5a6950945..dd91a7272e246b2133112effdb080a847fd15abe 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -402,6 +402,9 @@ struct rk_hdptx_phy {
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
 
+	/* PHY config opts */
+	unsigned long tmds_char_rate;
+
 	/* clk provider */
 	struct clk_hw hw;
 	unsigned long rate;
@@ -1413,19 +1416,21 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_phy *hdptx)
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	int bus_width = phy_get_bus_width(hdptx->phy);
+	unsigned int rate = hdptx->tmds_char_rate / 100;
 	enum phy_mode mode = phy_get_mode(phy);
 	int ret, lane;
 
-	/*
-	 * FIXME: Temporary workaround to pass pixel_clk_rate
-	 * from the HDMI bridge driver until phy_configure_opts_hdmi
-	 * becomes available in the PHY API.
-	 */
-	unsigned int rate = bus_width & 0xfffffff;
+	if (rate == 0) {
+		/*
+		 * FIXME: Temporary workaround to setup TMDS char rate
+		 * from the RK HDMI bridge driver.
+		 * Will be removed as soon the switch to the HDMI PHY
+		 * configuration API has been completed on both ends.
+		 */
+		rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+	}
 
-	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
-		__func__, bus_width, rate);
+	dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -1734,8 +1739,10 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	enum phy_mode mode = phy_get_mode(phy);
 	int ret;
 
-	if (mode != PHY_MODE_DP)
+	if (mode != PHY_MODE_DP) {
+		hdptx->tmds_char_rate = opts->hdmi.tmds_char_rate;
 		return 0;
+	}
 
 	ret = rk_hdptx_phy_verify_config(hdptx, &opts->dp);
 	if (ret) {
@@ -1830,6 +1837,16 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
+	/*
+	 * The TMDS char rate set via phy_configure(), if any, has
+	 * precedence over the rate provided via clk_set_rate().
+	 */
+	if (hdptx->tmds_char_rate && hdptx->tmds_char_rate != rate) {
+		dev_dbg(hdptx->dev, "Replaced clk_set_rate=%lu with tmds_char_rate=%lu\n",
+			rate, hdptx->tmds_char_rate);
+		rate = hdptx->tmds_char_rate;
+	}
+
 	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
 }
 

-- 
2.48.1


