Return-Path: <linux-kernel+bounces-169906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF98BCF30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0891F213AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19083CDA;
	Mon,  6 May 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkIFGsQv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024C79B9D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002552; cv=none; b=UEaMLwBiUgr4MWeI2qQogJ0Jn7Ma7HtTMnua5kxRxJf+7kaT27XHhvj7xRWutf4+PMgMHYNkUsieHYYTI/u28JpigXoJOIyG9V45pkemTtV1egwIgeH8JzQOxCEdCGpIWnymsuoSgnWugc/oio23Id3HnXUlsmy+QllSOKfpMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002552; c=relaxed/simple;
	bh=WxRrG6WTFlRQfn6WWcefR6HHCbkvvHD6Cc1lLV/qbGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9QkpXlpJAI5GN/pm3/gz/hn/rBmrYZriCpnBqm3jZBocuoeJDQ1ZRTXi4037riUbBU01NhTxlGKN0ZZa5dj4y562VDKyE3BRx8Erhas9lXcgyHbiEpaX7rN/pXW4f23lKuk61cVdB0wo6HW28ZBCxQ5dapkGl1fCRfojnkDfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkIFGsQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6E7C4DDE0;
	Mon,  6 May 2024 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002552;
	bh=WxRrG6WTFlRQfn6WWcefR6HHCbkvvHD6Cc1lLV/qbGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fkIFGsQvkv1zts7XnHArWvq5f6naVeYQf+gyv4hIjws7yh55elTEiD8E/gZClAhKt
	 2Nm8vAV4FymXXd+glXnlSr9Wi4znWxmiXt0ju4tdA60Zf/sl9QcxuMD6XMzogZ0i+f
	 XZekXyKMV8g+eGYA8o2AxeORRn1LY73iuelV5XTvS8qB9VhsOyNcdYRR1VI7F31Bqy
	 61wBlpLyw6poCnKygq72ifnnqGRa2Y9LtUlhMr6OB6IDF7522UfUhiu07Dc907F4GA
	 LrfmNplDZxSkhYiQGJjHvN4Rf3vmZd1re2RAEgCYpFFCwgSkRTME6JNwvTXNNQaen+
	 +vPi2Xo0NRgZQ==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:39 +0200
Subject: [PATCH 10/20] drm/bridge: tc358775: simplify lvds_link property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-10-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

The LVDS link can either be a single link or a dual link. No need for a
u8. Replace it with a bool "lvds_dual_link".

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index a9d731e87970..be2175571b99 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -231,7 +231,7 @@ struct tc_data {
 	struct regulator	*vddio;
 	struct gpio_desc	*reset_gpio;
 	struct gpio_desc	*stby_gpio;
-	u8			lvds_link; /* single-link or dual-link */
+	bool			lvds_dual_link;
 	u8			bpc;
 
 	enum tc3587x5_type	type;
@@ -409,7 +409,7 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
 
 	val = LVCFG_LVEN_BIT;
-	if (tc->lvds_link == DUAL_LINK) {
+	if (tc->lvds_dual_link) {
 		val |= TC358775_LVCFG_LVDLINK(1);
 		val |= TC358775_LVCFG_PCLKDIV(DIVIDE_BY_6);
 	} else {
@@ -460,8 +460,8 @@ tc_mode_valid(struct drm_bridge *bridge,
 	 * Maximum pixel clock speed 135MHz for single-link
 	 * 270MHz for dual-link
 	 */
-	if ((mode->clock > 135000 && tc->lvds_link == SINGLE_LINK) ||
-	    (mode->clock > 270000 && tc->lvds_link == DUAL_LINK))
+	if ((mode->clock > 135000 && !tc->lvds_dual_link) ||
+	    (mode->clock > 270000 && tc->lvds_dual_link))
 		return MODE_CLOCK_HIGH;
 
 	switch (info->bus_formats[0]) {
@@ -516,7 +516,6 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
 
 	of_node_put(tc->host_node);
 
-	tc->lvds_link = SINGLE_LINK;
 	endpoint = of_graph_get_endpoint_by_regs(tc->dev->of_node,
 						 TC358775_LVDS_OUT1, -1);
 	if (endpoint) {
@@ -525,13 +524,14 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
 
 		if (remote) {
 			if (of_device_is_available(remote))
-				tc->lvds_link = DUAL_LINK;
+				tc->lvds_dual_link = true;
 			of_node_put(remote);
 		}
 	}
 
 	dev_dbg(tc->dev, "no.of dsi lanes: %d\n", tc->num_dsi_lanes);
-	dev_dbg(tc->dev, "operating in %d-link mode\n",	tc->lvds_link);
+	dev_dbg(tc->dev, "operating in %s-link mode\n",
+		tc->lvds_dual_link ? "dual" : "single");
 
 	return 0;
 }

-- 
2.39.2


