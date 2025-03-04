Return-Path: <linux-kernel+bounces-543983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E76AA4DC26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AA51784EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E32040BF;
	Tue,  4 Mar 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly1nyLrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221C2040B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086696; cv=none; b=bAcO+ENpKgyGvQRZUz7jMSP3wE5b+lCtxSGcCoQLY2Cp/m0YDWrvqA3a0kCOFIbuApHbnXmYWBXRBWmH/c891Cb0xx93qF/FxH/viQ1l3hovmcf6eLD+PxRb2dy0Yk3U3cRqOzflo7jJtmfu3QubBJul6swEHF6EDpgpFZPvL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086696; c=relaxed/simple;
	bh=Z8DL/EfDlcq69p6mKKmu1mSIB6ysWUIqx05ZFHNUr4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ialxy87oEHEj4GxbL89mmx8J+Gse42f+TrxG1Hs9MhAcG5nA1yXd5oAWbo12fmgpsjR99F0Ma1XcdyY77Wbe8QOST3NRSdX7eF4JuOtw/lLABP3Mt15hOpgZfdSjUXQo/+NIHPqpsukuNMNKY4Hmr+AwzixjsZYMeGuPMbienPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly1nyLrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF87C4CEEB;
	Tue,  4 Mar 2025 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741086695;
	bh=Z8DL/EfDlcq69p6mKKmu1mSIB6ysWUIqx05ZFHNUr4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ly1nyLrDnGkVrET4BYRHbmtrvgmh+S2WPZ5NL/jBK7Oha8w+Rr3fGh/reRNMxxuTE
	 CNJmpD+MDaybtEtN7y3EULD33pBRnAvsRi9XGtcRd6PEAHyk2txTbHZTZIs35S/ITB
	 49Bbo2+A1nCeYaecgIF33v3ZFpwWZxvUyV0IZUkULw/IdH18gJ0WIx5NNhljgkuX6T
	 rqURrLy6kuv17Tiekr3/nWBCxVcHGYBnVmFI/2v4t+mRylZ2Z3NOKQ1qheh3Jb04wc
	 yJFoOnxu3U8uu+TVai9TZ6ENqtRH5U4UdVThPqOezv4mtwtzn9yA/oLnLvc5HrxsiE
	 WIAI4ov3k7PxQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 04 Mar 2025 12:10:55 +0100
Subject: [PATCH v5 12/16] drm/bridge: cdns-csi: Switch to atomic helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bridge-connector-v5-12-aacf461d2157@kernel.org>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
In-Reply-To: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnH7h/MP5b65GOQ192beeF6FUkuDLsysvTmdD8QmMq6x
 icqb/m6jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARzwrGhksdsaxXlS7G3lxx
 /OIzXxYWj/MGRYLncy9bn0rUb/ytOHXZw+WXTrbZ/BZMTC97+fNqJWO91wQl5q1KVg0vqtqair5
 de1EU4Dmr4brU5dOeE/yE1qx4JnpQZOOEH5f3LFgfIsXuvMUSAA==
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


