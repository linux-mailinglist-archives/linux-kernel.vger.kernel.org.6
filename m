Return-Path: <linux-kernel+bounces-559423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FADA5F3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C0D17ED86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE835267B84;
	Thu, 13 Mar 2025 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL35nksl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36E267393
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867247; cv=none; b=TUsddjBS8I7A7xaauouqOi7uleCs4RhknUhIEf0yB11/Z9DUrpNwX3JPElggG1btVCgX8434cKJ29sqSPEufU4x1nigI3ZBckVaAfxGfWUaT/GMk663v69Ma/eBvrL71uI+SEJR5IB5mC2e6b4IPLY/Y0AUgGvoXHjXIELYa99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867247; c=relaxed/simple;
	bh=Z8DL/EfDlcq69p6mKKmu1mSIB6ysWUIqx05ZFHNUr4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHVEghp9JWMU6lDd9DkFhaNcg5dIp8azfdGNHXMiIn+4yaKWTx+383UXInow3fdOvQO7EMcLl0aNdREfC2WZsLMiDNM3xCBmZieK7N8xy2vGr7+hgO2vsE6rcOAEUm1LD6t07R0Gl9XBih4PhkVQmyhcWdF2fMsOGDuDZ1Ifb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL35nksl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB85C4CEEA;
	Thu, 13 Mar 2025 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867246;
	bh=Z8DL/EfDlcq69p6mKKmu1mSIB6ysWUIqx05ZFHNUr4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uL35nksljLEW4uFZC+nZmvjoFeEBlz2jYR31lVzG0EB4ohQJ6UwoeJXo6+cKQc4z5
	 NSYZERoAhB7b2F0KjeEGHZVTXVeN9gR8j4GFC+KVmrUF79RgRLv1jYdUYhH0L7phta
	 IFh9cI+IM3/OqENfmZPC37bG5mBmacghu4+WLN3eN9nQYaXEiK6fDRmb6iswVL6Qss
	 PZ3BnucOZ8I91ehZpZmobrHeKMeqqVWr1Mz4bTBmu4F1anEwd9emP0kyD4p7qfjKbU
	 zgB5yMmPHR2OSKImuDyv5P7w7YcuPhUaaW9rQKQT8QD2teqftToGSkHYkJCbgOrFuk
	 fA2efsM4pRc2w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:06 +0100
Subject: [PATCH v6 12/16] drm/bridge: cdns-csi: Switch to atomic helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-12-511c54a604fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4929; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z8DL/EfDlcq69p6mKKmu1mSIB6ysWUIqx05ZFHNUr4s=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThwNPXxZWINhycH6V1L2ta6K7zVambPbbBi59gRzT
 Y2S4m/pKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwESYnjP8L1JdoqErGMmy4vfF
 bc49X+bd3fcmw2F97HlOa8G3qvM/HWT4Z806k0+3+BDLkSVX+VZcNrl+qk9V3S+0cg5PeqObaUU
 AGwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The Cadence DSI driver follows the drm_encoder->crtc pointer that is
deprecated and shouldn't be used by atomic drivers.

Fortunately, the atomic hooks provide the drm_atomic_state and we can
access our current CRTC from that, going from the bridge to its encoder,
to its connector, and to its CRTC.

Let's convert this bridge driver to atomic so we can get rid of the
drm_encoder->crtc dereference.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 31 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 8f54c034ac4f3e82c38607a0e52d4745654b571f..99d43944fb8fc685520b78732cd1181175ff7cc9 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -654,11 +654,12 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 		return MODE_BAD;
 
 	return MODE_OK;
 }
 
-static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+					   struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 	u32 val;
 
@@ -674,11 +675,12 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
 		dsi->platform_ops->disable(dsi);
 
 	pm_runtime_put(dsi->base.dev);
 }
 
-static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 
 	pm_runtime_put(dsi->base.dev);
@@ -751,17 +753,21 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
 	writel(val, dsi->regs + MCTL_MAIN_EN);
 
 	dsi->link_initialized = true;
 }
 
-static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+					  struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 	struct cdns_dsi_output *output = &dsi->output;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
 	struct drm_display_mode *mode;
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
+	struct drm_connector *connector;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
 	u32 tmp, reg_wakeup, div;
 	int nlanes;
 
@@ -769,11 +775,14 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 		return;
 
 	if (dsi->platform_ops && dsi->platform_ops->enable)
 		dsi->platform_ops->enable(dsi);
 
-	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	mode = &crtc_state->adjusted_mode;
 	nlanes = output->dev->lanes;
 
 	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));
 
 	cdns_dsi_hs_init(dsi);
@@ -891,11 +900,12 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 
 	tmp = readl(dsi->regs + MCTL_MAIN_EN) | IF_EN(input->id);
 	writel(tmp, dsi->regs + MCTL_MAIN_EN);
 }
 
-static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
@@ -906,14 +916,17 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 }
 
 static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
 	.attach = cdns_dsi_bridge_attach,
 	.mode_valid = cdns_dsi_bridge_mode_valid,
-	.disable = cdns_dsi_bridge_disable,
-	.pre_enable = cdns_dsi_bridge_pre_enable,
-	.enable = cdns_dsi_bridge_enable,
-	.post_disable = cdns_dsi_bridge_post_disable,
+	.atomic_disable = cdns_dsi_bridge_atomic_disable,
+	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
+	.atomic_enable = cdns_dsi_bridge_atomic_enable,
+	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
 static int cdns_dsi_attach(struct mipi_dsi_host *host,
 			   struct mipi_dsi_device *dev)
 {

-- 
2.48.1


