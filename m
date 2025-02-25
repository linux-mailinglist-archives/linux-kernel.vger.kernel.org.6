Return-Path: <linux-kernel+bounces-531941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41222A446F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C69D7AEA10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EF1A238C;
	Tue, 25 Feb 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYunjb/i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1D20D510
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501884; cv=none; b=BQIrGMoVpIrXU9g8i9d34UQh/Gjk6IpYQ7QoUARYfleWAUvbZs1ycfp1tUEb35gVf9y7csSvt3t+qxMoFQNEWTxVKaz6BkIajo5+FE3F25ngJJiSDogHjOr0MtjRNlEXz4LHI8n2sjln5kYkb1C24ked5YVtDqjQ4AbYJ3lmLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501884; c=relaxed/simple;
	bh=KeATheLJvy4KSWQ+MgWTM+CiR2EGa9nqBzJQ0G9F4FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjlMURUyEYsW1IVYovzA8xQUdmgd0g3Tru4u+4OOUrxND819dMi4Pa5EwMrfMHfQkkRv/TRnizaA/0KPN3kTsUCVa30OFAcPAJj1ZLJ34BCG0zw0xzyMfoWvPqxLTV6rIdYb87rgt0Ee+H6S25fC8uYMemKDcnSledCEJNI/VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYunjb/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCDCC4CEE6;
	Tue, 25 Feb 2025 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501883;
	bh=KeATheLJvy4KSWQ+MgWTM+CiR2EGa9nqBzJQ0G9F4FM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lYunjb/iww9NceM8Cr/JxYE4PO0J6JqQ1Hzyrxdx9gkcYulk/qjMVWEbSuctbo7Mm
	 2S3sM/upwiLWpiTRGKg6dvmOhjdnqqH6+BLljR94ttH+mjgXT64WXxnXt7UT5TpcZq
	 U0O9ufK1NVavv/UQuBR+2vhmRcMVbyc6/pXwpQh6Z0rC+30s4vQfvSlXmVFzoV1b3x
	 Lxme8mTJ0pEtdSBa94Cf/xG3BG2K8Rkgxd7kgPIuy59ece2fLYp0SvOcHteb3VtI6G
	 1IgtRO4Fcn4XBH7wR0jnGL5l/Fh6TsaNQM7kghj1Q9Baa7BlamQ3xqZj8Z3zTjlRS8
	 iSEdFTRxob4wg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:44:02 +0100
Subject: [PATCH v4 14/15] drm/bridge: tc358768: Convert to atomic helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-14-7ecb07b09cad@kernel.org>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
In-Reply-To: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4662; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KeATheLJvy4KSWQ+MgWTM+CiR2EGa9nqBzJQ0G9F4FM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7Pwf47crVMPsRJF8roxmm4Rw4XfLi603Btfu1JcwaU
 0LOnp/eMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACaibcjY0G7Gw3TBe9ZXDxad
 m+GRWhvaf01dIP1nR/u6VLn0osi+BRXN87w6jSq3M4isW8sscuQ1Y32eeanOdbPI2pVPQ7z098z
 +/G/XRqOJR6ttVjRw3V408Vx9lrBA8pGuP7N8WvenHZU90wAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tc358768 driver follows the drm_encoder->crtc pointer that is
deprecated and shouldn't be used by atomic drivers.

This was due to the fact that we did't have any other alternative to
retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
in the bridge state, so we can move to atomic callbacks and drop that
deprecated pointer usage.

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


