Return-Path: <linux-kernel+bounces-169914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58B8BCF41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F168B284C14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF085C7F;
	Mon,  6 May 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9s/WUkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173258594C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002587; cv=none; b=I+cJWQhCeGofpXtgP7NjSS9w+LJdrquYDztRW9yVpO6cPxfRPPPsJ6qY7FJgK1egQcZLLUD3ZRHAqQ26n1OeVzzkwgIRJNNbO3I52ym6Hw2KvPrGeM9ewkWlC5yZrPYoE3PqhhlHPzWQYixWvgwbR4cX+eOPrOeCATMOcN8vy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002587; c=relaxed/simple;
	bh=Hm8IbzH7o86qGsPyzm5DKDFy+pWLYyONwjVqfO4C4rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSHSAMt5cXrr5QX0Bv72qpKabv2u7OO41dG3vvhBJywBWcsEgxniKcIC5ZI3YNQExUUw+3s+FVIW0P/9zAF9Dj64veQAaO1Y1YGMxkXEoKtESl9g8w8gJEcirlRJiX6USR+5LSLP77pUDgWSznvzqjW00Xocq/A9wwkyx133rE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9s/WUkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C2BC4AF68;
	Mon,  6 May 2024 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002586;
	bh=Hm8IbzH7o86qGsPyzm5DKDFy+pWLYyONwjVqfO4C4rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9s/WUkzLe0/Gv60ykQuMYisA+qfLshxmw/LYojmokJi/IFRzXPXz3p7WTjXqTUcu
	 9cO9wxDiJJ7V/gNHD316aargzM6HJ5kQz5tLFxy4b09QtHmY9CGScsnCBH9raaqgg1
	 ovFY1Lzdq3L8wtWXvB9u6txLzMzgSj7OAApgNpQ7MjR4Q+gv5VBsFB0jo/myaNQ5ep
	 yyg8txlfAv6PT6aHaUh56acPXe/OiSPLwqS6+rv6rmUM7jbdnhK1aCssHYK1R/wfF7
	 AhMejO6EnmKXCMlB3MpkvgKwRNXoZhDi9d52bnu5PEsjffWVTT3Bf5rKI+RhyPmL8P
	 iWTPegQ6Oqw3g==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:46 +0200
Subject: [PATCH 17/20] drm/bridge: tc358775: move bridge power up/down into
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-17-545dcf00b8dd@kernel.org>
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

Move the bridge power-up and power-down handling into own functions.
This is a preparation patch to fix the power-up sequencing of the
bridge. No functional change.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index c50554ec4b28..d5b3d691d2c1 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -215,6 +215,7 @@ struct tc_data {
 	struct gpio_desc	*reset_gpio;
 	struct gpio_desc	*stby_gpio;
 	bool			lvds_dual_link;
+	bool			powered;
 	u8			bpc;
 
 	enum tc3587x5_type	type;
@@ -233,9 +234,8 @@ static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
 	return container_of(b, struct tc_data, bridge);
 }
 
-static void tc_bridge_pre_enable(struct drm_bridge *bridge)
+static void tc358775_power_up(struct tc_data *tc)
 {
-	struct tc_data *tc = bridge_to_tc(bridge);
 	struct device *dev = &tc->dsi->dev;
 	int ret;
 
@@ -256,9 +256,8 @@ static void tc_bridge_pre_enable(struct drm_bridge *bridge)
 	usleep_range(10, 20);
 }
 
-static void tc_bridge_post_disable(struct drm_bridge *bridge)
+static void tc358775_power_down(struct tc_data *tc)
 {
-	struct tc_data *tc = bridge_to_tc(bridge);
 	struct device *dev = &tc->dsi->dev;
 	int ret;
 
@@ -279,6 +278,20 @@ static void tc_bridge_post_disable(struct drm_bridge *bridge)
 	usleep_range(10000, 11000);
 }
 
+static void tc_bridge_pre_enable(struct drm_bridge *bridge)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
+
+	tc358775_power_up(tc);
+}
+
+static void tc_bridge_post_disable(struct drm_bridge *bridge)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
+
+	tc358775_power_down(tc);
+}
+
 /* helper function to access bus_formats */
 static struct drm_connector *get_connector(struct drm_encoder *encoder)
 {

-- 
2.39.2


