Return-Path: <linux-kernel+bounces-566162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F465A67402
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C18421A52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54920DD6E;
	Tue, 18 Mar 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MpgWLLb/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B120C499
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301428; cv=none; b=R6H3tW0xUp8PyDGyATOaRSPrVN2iSEdlWBoSjdeWFJHvcwLWspoLituC9xA5tLd/5SbR2P+FdtR99LF2RTSz26S5W/43rc6AQp2PlTIelqJx7i+YtaAJV4sUlp+vks9ziQoCAUevgTKsMCpMmbZI/D4AJe72y6GjnneIVLgaIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301428; c=relaxed/simple;
	bh=MSCgJHnqBdDA4qxZOqPsxwqrzmRwhDa2/mwcEUsiVXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLFLC717elXfwv/TyHHHY6l351lDeUllTlJBWyKHNu0oQTIzHS3kp7uQNyJjLajCOOpfGFTpnpANdItvVn+TS6yfLIeLc7cwsZBcRC+w7rrK/h0wafPwX3vsWA2boOtUBIrZDRjpikh+ZjNNiQ37WSI7zaMKr+SDKIQk8gh4ozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MpgWLLb/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301421;
	bh=MSCgJHnqBdDA4qxZOqPsxwqrzmRwhDa2/mwcEUsiVXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MpgWLLb/TDUbWKm9oOWyJvdOK58hkCExEEJIA1PFVLDa2gO5BrnOOgo+D27OSU8ac
	 DhFKAwZOV9+rKLDcICnG14oCEOf8BGXmalZgdhxJ/9VFgppek7iIMXjRWal6v+eKfg
	 rrUGFegl5AVbnkbnR3+RHgehVPeP0tqj4BF5Yb3jpftcuQtUbo/p2aQmakIgkpkjCa
	 MS5+lUHlwkardOEuHHpNxrGqO9jbKsLiQb62k69gZhUJkU68jPF3IYvl7n5mvLFPZC
	 9ajtCaTTXHWgS8uwNv+oiLLXoRbuuMmoljrvaE3oq2XAMR+RoPGLy+AH8e8Nk8zw2G
	 mO4oKk8vZNZFA==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 32B8B17E0FE7;
	Tue, 18 Mar 2025 13:37:01 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:38 +0200
Subject: [PATCH v6 04/14] phy: rockchip: samsung-hdptx: Do no set
 rk_hdptx_phy->rate in case of errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-4-8cb1678e7663@collabora.com>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

Ensure rk_hdptx_ropll_tmds_cmn_config() updates hdptx->rate only after
all the other operations have been successful.

Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 34a7ef20936422b540b699f1acba44ca465501b7..d0989dc5a0173af4de4521e690c3f7b6cc343402 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1006,9 +1006,7 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
-	int i;
-
-	hdptx->rate = rate * 100;
+	int ret, i;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
 		if (rate == ropll_tmds_cfg[i].bit_rate) {
@@ -1063,7 +1061,11 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
 			   FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
 
-	return rk_hdptx_post_enable_pll(hdptx);
+	ret = rk_hdptx_post_enable_pll(hdptx);
+	if (!ret)
+		hdptx->rate = rate * 100;
+
+	return ret;
 }
 
 static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,

-- 
2.48.1


