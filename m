Return-Path: <linux-kernel+bounces-543074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59B5A4D129
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36EF17382C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F291E491B;
	Tue,  4 Mar 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L/BsZ7IT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF015CD46
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052672; cv=none; b=XBfVkHxQ+E9qXPmyWL5Cq21ByD49K4Nu5DaWqm+8556ixi76LrYWwro7eWY8N1MEcUYcD1301geWfmrEiqvZhEk8XMsnPCmxWqoqbh7jIHi9coyknIN9Njv/shTpcFvrQyaIOi5N+vgh4VUngAANe3/kV4JnHDdV0FQMGYnLTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052672; c=relaxed/simple;
	bh=l4kiELVlGlbq53QeXi0EurEOvtdzTD58A2iUc1upzgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOlzIvqAzNNKIOJWrhjGocQFzd+GpCWPcCpM6Lw/WTCQ2euRea7nKGqzUf/9hSe2TpgvmLBnZUMdM7DajEWzbs0Ce0iYTq51Ow4EbThEfJWcZSX5lq9QO+CpIHZNGQqErByfl9QEjexsuYLhJKuUdxt/1jXcpbqGKMVZXMyD/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L/BsZ7IT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052665;
	bh=l4kiELVlGlbq53QeXi0EurEOvtdzTD58A2iUc1upzgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L/BsZ7ITapv0LiEkQrT8859nFykO7sHJVRJjgwRWZBBUaW+nbQrDJ3a5yOHS0W6OM
	 rlxUnw2f9ZVoHRCp+yLMiopaC+GE2r6XQ6uEEgH8YaOgl6hftuJbEqvqwbdF8k+h0T
	 WFM2FoHs3dVqpsgKxLBJZaOrz/HcYH78UQlOIjULBdc0YzzPpxtULY5r9Z3DlWU1IJ
	 qWV8INHL/kXDdwH7YPcXz2d816ocMq4o6apTuMr/oUxOWOodHOP18ERa4AueGRgoru
	 EMdJS9bs9ayfMXpWSdyAuZptyPnNTqXD/r8kWx/P8aJQKRdHDuo1dvbTjv4JM35+Bu
	 NHAzxYjZFpkpA==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 1550717E1047;
	Tue,  4 Mar 2025 02:44:25 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:08 +0200
Subject: [PATCH v4 09/12] phy: rockchip: samsung-hdptx: Restrict altering
 TMDS char rate via CCF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-9-8657847c13f7@collabora.com>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Although, in theory, the clock provider functionality could be enabled
as a standalone driver feature, in practice it is unlikely that it would
be ever needed separately from the common PHY related features, i.e.
making use of the PHY PLL as an alternative and more accurate clock
source for display modes handling.  Which means the PLL will be always
programmed according to the TMDS char rate set via the HDMI PHY
configuration API.

Currently it's possible to freely adjust the rate via the clock API as
well, that is through clk_set_rate().  Making the clock read-only is not
feasible since we need to ensure any rate update done via the PHY
configuration API has been actually programmed into the hardware before
CCF accesses it.  This would be normally done during phy_ops.power_on()
or clk_ops.prepare() callbacks, but it might happen that the former gets
fired too late and the latter only once, hence we need to keep handle it
via clk_ops.set_rate() as a fallback approach.

Prevent changing the TMDS character rate via CCF by letting
rk_hdptx_phy_clk_round_rate() always return the value set via
phy_configure().  To avoid breaking existing users, i.e. RK DW HDMI QP
bridge driver, until the switch to the HDMI PHY config based approach is
completed, introduce a temporary exception to the rule, toggled via the
new ->restrict_rate_change flag, which indicates whether phy_configure()
has been called or not.

Additionally, revert any unlikely rate change that might have occurred
between the calls to ->round_rate() and ->set_rate().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 53 +++++++++++++++++------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 47db1395051f5d900197871694bab90ca4d6e38e..b4d2f04842b5c5b425c5b73a8b27fabecbbbd6bb 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -402,6 +402,7 @@ struct rk_hdptx_phy {
 	/* clk provider */
 	struct clk_hw hw;
 	unsigned long rate;
+	bool restrict_rate_change;
 
 	atomic_t usage_count;
 
@@ -1759,10 +1760,12 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 
 	if (mode != PHY_MODE_DP) {
 		ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi);
-		if (ret)
+		if (ret) {
 			dev_err(hdptx->dev, "invalid hdmi params for phy configure\n");
-		else
+		} else {
 			hdptx->hdmi_cfg = opts->hdmi;
+			hdptx->restrict_rate_change = true;
+		}
 		return ret;
 	}
 
@@ -1849,21 +1852,31 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate)
 {
-	u32 bit_rate = rate / 100;
-	int i;
+	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	if (rate > HDMI20_MAX_RATE)
-		return rate;
+	/*
+	 * FIXME: Temporarily allow altering TMDS char rate via CCF.
+	 * To be dropped as soon as the RK DW HDMI QP bridge driver
+	 * switches to make use of phy_configure().
+	 */
+	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.tmds_char_rate) {
+		struct phy_configure_opts_hdmi hdmi = {
+			.tmds_char_rate = rate,
+		};
+		int ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &hdmi);
 
-	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
-			break;
+		if (ret)
+			return ret;
 
-	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
-	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
-		return -EINVAL;
+		hdptx->hdmi_cfg = hdmi;
+	}
 
-	return rate;
+	/*
+	 * The TMDS char rate shall be adjusted via phy_configure() only,
+	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
+	 * a different rate argument.
+	 */
+	return hdptx->hdmi_cfg.tmds_char_rate;
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1871,6 +1884,20 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
+	/* Revert any unlikely TMDS char rate change since round_rate() */
+	if (hdptx->hdmi_cfg.tmds_char_rate != rate) {
+		dev_warn(hdptx->dev, "Reverting unexpected rate change from %lu to %llu\n",
+			 rate, hdptx->hdmi_cfg.tmds_char_rate);
+		hdptx->hdmi_cfg.tmds_char_rate = rate;
+	}
+
+	/*
+	 * The TMDS char rate would be normally programmed in HW during
+	 * phy_ops.power_on() or clk_ops.prepare() callbacks, but it might
+	 * happen that the former gets fired too late, i.e. after this call,
+	 * while the latter being executed only once, i.e. when clock remains
+	 * in the prepared state during rate changes.
+	 */
 	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
 }
 

-- 
2.48.1


