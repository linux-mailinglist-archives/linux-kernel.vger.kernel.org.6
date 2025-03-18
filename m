Return-Path: <linux-kernel+bounces-566165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05606A67412
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318171892028
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4120E33F;
	Tue, 18 Mar 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OOEc5DA0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2F20C488
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301433; cv=none; b=OTkZNSKSRdTPisr/UoQVwJWVCv/vsqfspIOLsG2bLuDKamR3+R2EjV1tSpzCrCY2VrjsFJukkG9rs7B5mFMd3ZKGld7W8NnhVIXPLnkKycFL42wYB9dZuIsY+TF2AkPu0NJFFoDLYTK5+UfRRGHx0iOogNOP3mXsa2DVLStAShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301433; c=relaxed/simple;
	bh=Zv+BNdHCJgaPNEBscSjouCA08gwqHt64Y9Rx7ThPniA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVsrkdnkceo3YWVSL46pqBG3uu4fYBi5FnlIVjC/qpte8f+PFohtP/buVhf1sY0KeXl8GO14VqrUb7NAcMW4EMSrD6mTrPFjCoiyNiuzS9UAYFwqkkrhKyddaCq0hin27DvJkf/xX8zfcNaNuenPidVKrtoSY+NTjelD6p3EVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OOEc5DA0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301430;
	bh=Zv+BNdHCJgaPNEBscSjouCA08gwqHt64Y9Rx7ThPniA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OOEc5DA0XgZagbryYov9P3WNfJRzQmdnCyN/aua/rq6LIh+lPppAMiu371mbXjbaK
	 T6fBzj+A/vgLfJlSHW5Y53V2+w0WdbY5Af3RkO5EDfZM6E7v5eLPrkLQwouKLI9fqB
	 3m5u+XfqHen4VOop8f7IUhx5jh0pu73iz0Fh4ccth9cw9vnFXW2RKDagY6kRgWsXwu
	 I27+w1/r6Pt1xrx/SQniKr7g/JFuC/6uMCTvt6nWId8DRR9LHxzI/CeXQDpMpIGg+t
	 /wfNx7XQNuXXMQ5AVN21mfcaAfXx03bv6iMV7+IV4wONAnpWwCJHTBM45bapWltxWq
	 oZCRdRWn12fbQ==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 1EB7017E1567;
	Tue, 18 Mar 2025 13:37:10 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:45 +0200
Subject: [PATCH v6 11/14] phy: rockchip: samsung-hdptx: Restrict altering
 TMDS char rate via CCF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-11-8cb1678e7663@collabora.com>
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
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 52 +++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 80dd896861bcac6ef9dbde410327b893f8039627..2feb46f6d4e5bd2f43140e465cc25d2b0c363df4 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -402,6 +402,7 @@ struct rk_hdptx_phy {
 	/* clk provider */
 	struct clk_hw hw;
 	unsigned long rate;
+	bool restrict_rate_change;
 
 	atomic_t usage_count;
 
@@ -1758,10 +1759,12 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 
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
 
@@ -1848,20 +1851,31 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate)
 {
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
-		if (rate == ropll_tmds_cfg[i].rate)
-			break;
+		if (ret)
+			return ret;
 
-	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
-	    !rk_hdptx_phy_clk_pll_calc(rate, NULL))
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
@@ -1869,6 +1883,20 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
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
 	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
 }
 

-- 
2.48.1


