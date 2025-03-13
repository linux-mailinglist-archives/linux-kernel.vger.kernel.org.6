Return-Path: <linux-kernel+bounces-559426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29477A5F3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC553BBC29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689EA267F72;
	Thu, 13 Mar 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvqWcg2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A04267393
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867254; cv=none; b=tklEDfHnIa1154CxmppqQptr+yKTI2scgWcdzAbQleKfunx3FQMNO2mHemTI70NqgfZOFeRPjn75EH6ejbSBWDmkUwJ/RI8C7LVe+N3YFBe/CjZx2WvbZRw3HC5VikIRxxWUj5l/JoDJyPnUKujK9G0zc1Mh8Ls/87rNBMm2F6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867254; c=relaxed/simple;
	bh=pLWjIY6WqePBrvjqbQ1+ak02eZ5uPMBYm5c60VLzABc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaj8E/DNvgpcn6rFOC0nBhUao4I5wAzSJ93oICpzTBO9hw4v8MPEmra0h/Jfpk5GV5vsXNxtgZYgES8xb+kfAWRlI3u79YrvBsr/LRFnoBTzdoibZUILcx1/GwJIzhfgmfwLe0p5TfGaZHbZzNpw0Dyr/Ge4AlPIbfEW/FN3Ip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvqWcg2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44244C4CEDD;
	Thu, 13 Mar 2025 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867254;
	bh=pLWjIY6WqePBrvjqbQ1+ak02eZ5uPMBYm5c60VLzABc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GvqWcg2hqb4YJmxMkopriaWArpO3AAGwlQg4W0WsrU6Gu0XVuxaIE+AnyEXtSZInF
	 Q3AjY2oRhzpeWZ5Ig5C6t8nnpmkHx4L9HBrfOvE9kvrq6m2enMTpVy6rAv0dz/ekF6
	 sSgNkezuKf+aNe+kbu9H24fIYD3dOLeZ3x1ZwyWMMiqoGTXHQuzh70gjbi0LFtF80g
	 A7QGypj3kPMxhGAS0V2bdWLD1JXNRYbxYI2pfHFebuDVJllLBZz2iNsIglcZehTyt6
	 JQzl33ixrRu8mmvvtezkCHM9Fa9YKWRwEFtnR+Ueot+Uc0XJPrqJ+4LM7Jg2AVuctP
	 XJM46CzgNuYLQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:09 +0100
Subject: [PATCH v6 15/16] drm/bridge: tc358768: Convert to atomic helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-15-511c54a604fb@kernel.org>
References: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
In-Reply-To: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4765; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pLWjIY6WqePBrvjqbQ1+ak02eZ5uPMBYm5c60VLzABc=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThzv22R8gf983vdVUg55CSdPrjno5zepwNPV2XXVQ
 9/2Z5qHOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCR7AqGf6q7Ggv/yok1T203
 f33AuzHJOyWcrbSyTN34+qG63FNPtjH8T1b0sfnPfr0ybs7SQobD6sZPTs8LWGzDu97vqu1yg0e
 zGAE=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tc358768 driver follows the drm_encoder->crtc pointer that is
deprecated and shouldn't be used by atomic drivers.

Fortunately, the atomic hooks provide the drm_atomic_state and we can
access our current CRTC from that, going from the bridge to its encoder,
to its connector, and to its CRTC.

Let's convert this bridge driver to atomic so we can get rid of the
drm_encoder->crtc dereference.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 6b65ba8aed86012bc0f464bd5ee44325dae677c6..063f217a17b6cf32e9793b8a96a5ac6128584098 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -579,11 +579,12 @@ tc358768_bridge_mode_valid(struct drm_bridge *bridge,
 		return MODE_CLOCK_RANGE;
 
 	return MODE_OK;
 }
 
-static void tc358768_bridge_disable(struct drm_bridge *bridge)
+static void tc358768_bridge_atomic_disable(struct drm_bridge *bridge,
+					   struct drm_atomic_state *state)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	int ret;
 
 	/* set FrmStop */
@@ -601,11 +602,12 @@ static void tc358768_bridge_disable(struct drm_bridge *bridge)
 	ret = tc358768_clear_error(priv);
 	if (ret)
 		dev_warn(priv->dev, "Software disable failed: %d\n", ret);
 }
 
-static void tc358768_bridge_post_disable(struct drm_bridge *bridge)
+static void tc358768_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_atomic_state *state)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 
 	tc358768_hw_disable(priv);
 }
@@ -681,17 +683,21 @@ static u32 tc358768_dsi_bytes_to_ns(struct tc358768_priv *priv, u32 val)
 	u64 n = priv->dsiclk / 4 * priv->dsi_lanes;
 
 	return (u32)div_u64(m, n);
 }
 
-static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
+static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_atomic_state *state)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
 	unsigned long mode_flags = dsi_dev->mode_flags;
 	u32 val, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
 	const struct drm_display_mode *mode;
 	u32 hsbyteclk_ps, dsiclk_ps, ui_ps;
 	u32 dsiclk, hsbyteclk;
 	int ret, i;
 	struct videomode vm;
@@ -718,11 +724,14 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		dev_err(dev, "Software reset failed: %d\n", ret);
 		tc358768_hw_disable(priv);
 		return;
 	}
 
-	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	mode = &crtc_state->adjusted_mode;
 	ret = tc358768_setup_pll(priv, mode);
 	if (ret) {
 		dev_err(dev, "PLL setup failed: %d\n", ret);
 		tc358768_hw_disable(priv);
 		return;
@@ -1079,11 +1088,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	ret = tc358768_clear_error(priv);
 	if (ret)
 		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
 }
 
-static void tc358768_bridge_enable(struct drm_bridge *bridge)
+static void tc358768_bridge_atomic_enable(struct drm_bridge *bridge,
+					  struct drm_atomic_state *state)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	int ret;
 
 	if (!priv->enabled) {
@@ -1159,14 +1169,14 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.attach = tc358768_bridge_attach,
 	.mode_valid = tc358768_bridge_mode_valid,
 	.mode_fixup = tc358768_mode_fixup,
-	.pre_enable = tc358768_bridge_pre_enable,
-	.enable = tc358768_bridge_enable,
-	.disable = tc358768_bridge_disable,
-	.post_disable = tc358768_bridge_post_disable,
+	.atomic_pre_enable = tc358768_bridge_atomic_pre_enable,
+	.atomic_enable = tc358768_bridge_atomic_enable,
+	.atomic_disable = tc358768_bridge_atomic_disable,
+	.atomic_post_disable = tc358768_bridge_atomic_post_disable,
 
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_get_input_bus_fmts = tc358768_atomic_get_input_bus_fmts,

-- 
2.48.1


