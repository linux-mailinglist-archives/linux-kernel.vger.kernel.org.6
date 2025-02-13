Return-Path: <linux-kernel+bounces-513204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2DA343AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC8C1893448
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C42010EB;
	Thu, 13 Feb 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bznUsM24"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6BD20013E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457925; cv=none; b=lxRkCuybbO/CDaW5l5sGsSCFKjDW3JZKNj4hqxVNKGHrRk0P5ecAk1pufpDemzeeGD8qE8LmIrzOYgEs+4pfUdEUahgn/yFC1I4QFf3VuxdB/pmKwB3nAYvzsTC4i1nXvq8jwXWyl03U2+qlRKIjLVvFKtytCbmEbKQeN6+BEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457925; c=relaxed/simple;
	bh=97K/zrwMymEcyzYHacN1UMhzLv2qJvVByoMxUvJWseA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+fZctprhDueLso/447uTBfQrRdUB4SDzWCP7+POrJTg5AipoJy+P5WoMt7GIS4HlLaoZEv/fNwOjgBZKuNCDefpTQLWMqWtts1MdxwQk9ggW6iDnCLKu9z0rtswOtn9rno2+CcR3dg6eILem8ZVKbOooEvVT3oOQ//YBfQz5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bznUsM24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09733C4CED1;
	Thu, 13 Feb 2025 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457925;
	bh=97K/zrwMymEcyzYHacN1UMhzLv2qJvVByoMxUvJWseA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bznUsM24ZXcttpjSqjd59MBZ+hPvcPERv8NBFWrofUiTJB/EN4KyziJk2Vp1tDPWE
	 HBqca4eG0vwSCirAZPnVT4Vl7dUNBdcqY+LJNlcorSvExC+M7n1HU9oYXbYMe5oiMA
	 1/FfhE4ZMe7atoPBUn0jvH6HN+dgiVeJTbLuuEnDZnmyRNQg4g/N0xBtOZ3nPM1Nry
	 7YDBMSVzv5lHyQgj/2wd8pjkaC8rZhvBLfiisMmWiqxgrKakI7K9gU05V0cTUyiIWC
	 MXpYZpYd79i0kv+Av0NBsPVpjvH+mLEbL/2rV+WBJsovJOPN2/eEupUNnHLxP4vO3X
	 BE2ilmTG5I5Rw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:52 +0100
Subject: [PATCH v3 33/37] drm/bridge: cdns-csi: Switch to atomic helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-33-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4688; i=mripard@kernel.org;
 h=from:subject:message-id; bh=97K/zrwMymEcyzYHacN1UMhzLv2qJvVByoMxUvJWseA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWFVid/9d4vJnUsueDbGL1MLdovWyGF7cz/7+SahZe
 ueyulsXOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEog4wNkz8ZVd/fPlHbfF0
 s7B58zJ0u2VWsu193Jm6ReZM0ElxAT7m89LG3vWZlmc5k/omNiRZMTY0cV0z2vjzdtez77LOps8
 qZi0QT5WpzZl+w0lZ4v+k3b5ugWaPp0hkiR2c0601ZcWRVXcB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The Cadence DSI driver follows the drm_encoder->crtc pointer that is
deprecated and shouldn't be used by atomic drivers.

This was due to the fact that we did't have any other alternative to
retrieve the CRTC pointer. Fortunately, the CRTC pointer is now provided
in the bridge state, so we can move to atomic callbacks and drop that
deprecated pointer usage.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 29 ++++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 8f54c034ac4f3e82c38607a0e52d4745654b571f..a687585819c014e120176fb990fe0861698448e7 100644
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
@@ -751,15 +753,18 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
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
+	struct drm_bridge_state *bridge_state;
+	struct drm_crtc_state *crtc_state;
 	struct drm_display_mode *mode;
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
 	u32 tmp, reg_wakeup, div;
@@ -769,11 +774,13 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 		return;
 
 	if (dsi->platform_ops && dsi->platform_ops->enable)
 		dsi->platform_ops->enable(dsi);
 
-	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+	crtc_state = drm_atomic_get_new_crtc_state(state, bridge_state->crtc);
+	mode = &crtc_state->adjusted_mode;
 	nlanes = output->dev->lanes;
 
 	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));
 
 	cdns_dsi_hs_init(dsi);
@@ -891,11 +898,12 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 
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
@@ -906,14 +914,17 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
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
2.48.0


