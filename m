Return-Path: <linux-kernel+bounces-534366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2321A465E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3706C3B5DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45421D5A6;
	Wed, 26 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EElQ1jYy"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79B28F3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585471; cv=none; b=BrNP5L3htLwH4zIAfB945H2hPravCjUqlCBHQtdsQFJ8vFVczIwQI/C/tpwfy4Jr1ej9SYx7xEkptIFghMwdmiiHjHs6cMe/iWjkhCMoqh5N8IqcuEWucPQuB+LiJYn4VX60ouswuwaprnBwPMlg5buYKSRPdJma8hkTa6q7YQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585471; c=relaxed/simple;
	bh=YxZXlmzDxwy2lvqThA1zkV3TfPlzzGumgl7JK5Ts7yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FqA2lLOKrIDEex+Sm2tlqSP/8QvPlPbOD1LNLOaYUek47SoZCye+U/AbneEMgwWPs0Lnpg5tBQTTK3i7+8FINPM/ZGplxmz9m/NiAdIxXR9kjUHMV1XVj/cNO0Pqh1v6wVd49nMZF/8R0VxkI10lI2c51riLGlmP9YO7a6U06Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EElQ1jYy; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740585467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48RWjipwBH41Pw7mr++kvwbBLoJUV2TbmuejOTHTPcQ=;
	b=EElQ1jYyhk8s4fToIbbB04L2R2r+ao1WYG1CCAQ/+0yFZoFvsGRPzbq19h7uoqW0EO8a2D
	J3NV97RxqocJXs4r6TzWo065cKkymUvAHFhv1YelY9Y83NiDoGKbe3x6jVfJhmtVTqibv/
	72l0izxi6BID6pFbZKZ/abKUa99y6ng=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: [PATCH v10 08/13] drm/bridge: cdns-dsi: Support atomic bridge APIs
Date: Wed, 26 Feb 2025 21:27:32 +0530
Message-Id: <20250226155737.565931-1-aradhya.bhatia@linux.dev>
In-Reply-To: <20250226155228.564289-1-aradhya.bhatia@linux.dev>
References: <20250226155228.564289-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

Change the existing (and deprecated) bridge hooks, to the bridge
atomic APIs.

Add drm helpers for duplicate_state, destroy_state, and bridge_reset
bridge hooks.

Further add support for the input format negotiation hook.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 51 ++++++++++++++++---
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index c2512342139c..9f0bd07ecefd 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -658,7 +658,8 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+					   struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -678,7 +679,8 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
 	pm_runtime_put(dsi->base.dev);
 }
 
-static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -760,7 +762,8 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
 	dsi->link_initialized = true;
 }
 
-static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+					  struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -913,7 +916,8 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	writel(tmp, dsi->regs + MCTL_MAIN_EN);
 }
 
-static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_atomic_state *state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -925,13 +929,44 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 	cdns_dsi_hs_init(dsi);
 }
 
+static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
+					       struct drm_bridge_state *bridge_state,
+					       struct drm_crtc_state *crtc_state,
+					       struct drm_connector_state *conn_state,
+					       u32 output_fmt,
+					       unsigned int *num_input_fmts)
+{
+	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
+	struct cdns_dsi *dsi = input_to_dsi(input);
+	struct cdns_dsi_output *output = &dsi->output;
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	input_fmts[0] = drm_mipi_dsi_get_input_bus_fmt(output->dev->format);
+	if (!input_fmts[0])
+		return NULL;
+
+	*num_input_fmts = 1;
+
+	return input_fmts;
+}
+
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
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = cdns_dsi_bridge_get_input_bus_fmts,
 };
 
 static int cdns_dsi_attach(struct mipi_dsi_host *host,
-- 
2.34.1


