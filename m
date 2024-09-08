Return-Path: <linux-kernel+bounces-320273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B457970840
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC77E28292F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B6A172BDE;
	Sun,  8 Sep 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Xcwgz2+y"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0217279C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807344; cv=none; b=SJAkU/tj43Mg3S6wQO0X+rr8AgMEl8L0J/aDpSSk4toR9cI/fdhwJEw6sBM9m+OI1UsozsNwGcJk4x3yFJwwKaJyY3tI4vypW+CwAfiYhAnlmSxCBFxNPN71dqEj01Fs/4M0JWtQDdYfEB0l+dKPzTyJ1QSeNYfoTd368UtSBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807344; c=relaxed/simple;
	bh=trEG3kdvJwkXD+tVfXvh2GrCYgOUnKsz+e7BeCR8dzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW5moyRTBaOCt4EcQ/eDE8hiDsv2NJXwH9PIc6IEzz+kgP5rMmzDCej3iCcv6eRLcYDtOAXNlYtOEay4qrCgKPhRrN3hVq2nuXtt2vcQYik2d5K7mXqwVT/iJdUGIFffpw54JOu8t/UyJX/J7nelCOTLS+kffV0BstrAp7u9J/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Xcwgz2+y; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725807327; bh=V2dGVPkW7unWHK16HPMh1/1tKtsd3J5CV8rFRUeW/os=;
 b=Xcwgz2+y07DjXft8NL+zfJrIjmZ8fw28DzkAvO75Yq1c3YWf+mmsCKWB6RW3IrXy9wJC8N7UW
 fUcvLtn1GWtp73WlMCHVUxqIwj3NPOOrXAjK/Bru3lzI+fCCE2VkQrk7CDfXPJTC39PhZ/xOWU1
 h03E6Xnq9KHY2XpDPs3oWAnYfww4LjV1ofRPXKjWHGxuanY2fUb5EMeB4pVvkNNiAs8pGgMCZB6
 pZ3J3xhvQCPljW4JqLlkQAoPPCuA/SO04okkwx00X5kxtx2nUk3a8scv4GRsMcUsV0GqbP5g9jt
 u6w/T+WzEO70CmXKY7vqIAeVp8i3eLxkFAHZJVJJ+QlA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/7] drm/rockchip: dw_hdmi: Filter modes based on hdmiphy_clk
Date: Sun,  8 Sep 2024 14:54:58 +0000
Message-ID: <20240908145511.3331451-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908145511.3331451-1-jonas@kwiboo.se>
References: <20240908145511.3331451-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66ddbadb3c9877b459588e82

RK3228 and RK3328 clock rate is being validated against a mpll config
table intended for a Synopsys phy, and not the used inno-hdmi-phy.

Instead get a reference to the hdmiphy clk and validate rates against
it to enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228 and RK3328.

For Synopsis phy the max_tmds_clock validation is sufficient.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64
---
v2: Collect t-b tag
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 35 ++++++++++-----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 240552eb517f..36cc700766fd 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -76,6 +76,7 @@ struct rockchip_hdmi {
 	struct rockchip_encoder encoder;
 	const struct rockchip_hdmi_chip_data *chip_data;
 	const struct dw_hdmi_plat_data *plat_data;
+	struct clk *hdmiphy_clk;
 	struct clk *ref_clk;
 	struct clk *grf_clk;
 	struct dw_hdmi *hdmi;
@@ -251,10 +252,7 @@ dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 			    const struct drm_display_mode *mode)
 {
 	struct rockchip_hdmi *hdmi = data;
-	const struct dw_hdmi_mpll_config *mpll_cfg = rockchip_mpll_cfg;
 	int pclk = mode->clock * 1000;
-	bool exact_match = hdmi->plat_data->phy_force_vendor;
-	int i;
 
 	if (hdmi->chip_data->max_tmds_clock &&
 	    mode->clock > hdmi->chip_data->max_tmds_clock)
@@ -263,26 +261,18 @@ dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 	if (hdmi->ref_clk) {
 		int rpclk = clk_round_rate(hdmi->ref_clk, pclk);
 
-		if (abs(rpclk - pclk) > pclk / 1000)
+		if (rpclk < 0 || abs(rpclk - pclk) > pclk / 1000)
 			return MODE_NOCLOCK;
 	}
 
-	for (i = 0; mpll_cfg[i].mpixelclock != (~0UL); i++) {
-		/*
-		 * For vendor specific phys force an exact match of the pixelclock
-		 * to preserve the original behaviour of the driver.
-		 */
-		if (exact_match && pclk == mpll_cfg[i].mpixelclock)
-			return MODE_OK;
-		/*
-		 * The Synopsys phy can work with pixelclocks up to the value given
-		 * in the corresponding mpll_cfg entry.
-		 */
-		if (!exact_match && pclk <= mpll_cfg[i].mpixelclock)
-			return MODE_OK;
+	if (hdmi->hdmiphy_clk) {
+		int rpclk = clk_round_rate(hdmi->hdmiphy_clk, pclk);
+
+		if (rpclk < 0 || abs(rpclk - pclk) > pclk / 1000)
+			return MODE_NOCLOCK;
 	}
 
-	return MODE_BAD;
+	return MODE_OK;
 }
 
 static void dw_hdmi_rockchip_encoder_disable(struct drm_encoder *encoder)
@@ -607,6 +597,15 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	if (hdmi->phy) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = hdmi->phy->dev.of_node;
+		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+		if (IS_ERR(hdmi->hdmiphy_clk))
+			hdmi->hdmiphy_clk = NULL;
+	}
+
 	if (hdmi->chip_data == &rk3568_chip_data) {
 		regmap_write(hdmi->regmap, RK3568_GRF_VO_CON1,
 			     HIWORD_UPDATE(RK3568_HDMI_SDAIN_MSK |
-- 
2.46.0


