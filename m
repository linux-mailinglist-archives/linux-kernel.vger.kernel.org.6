Return-Path: <linux-kernel+bounces-534354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD98A465C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C233A8020
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEA223321;
	Wed, 26 Feb 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLj1Qt5I"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A021D3C1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585208; cv=none; b=f3npvITcqEl/O/HCxBRTM/53YJ9FLJBeBppR1DR5soImYkzQtArH6ma5BhA/oxsx1NtTObbt32FpocNS8M/ivWL48PHB72pJ7VIpSkO8QsETbDkt4VA1yT8znRnJLzBMfhexMan5RI8FGiOvdpX68+VrwiwXI96AEQzQOESTFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585208; c=relaxed/simple;
	bh=OHdXXOUPpkn9RkycrhGhRhHj/Xriw87NlVhr6kBgbJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTUVzmZyPWtb0jENOLtkfxLmUmiHyWjK1YBo6eICPPDKBo1dMb8HOkHIleEYHj0w+G9no1EkL0Y846TV+yrdoUWO6zmt8DkWuRo8EQFmn/PGq0Dt0HXw0n//MiRBGhyHgq7J3ipDykez9tyN3l5969uIEamlysNgUkkzhmtt2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fLj1Qt5I; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740585203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7NMtDHbuevgiT8wcr3gh6V+afY/ND0IPd6hQ5X6ZjE=;
	b=fLj1Qt5ID0GQe5hlg/Ra/ZKFhmqYmp5+KDevq/a1TWvLKkb5qbrDYOrb0q4oWzKDAiyOqM
	hYtIl1wDI/VFXLwIZAW0PkKyF5ICD8vnihR4/3PXw/JELEm3SmZudM4D1Lc2YufFEjYg3n
	Wuy0Wdf2axXOLjo+vzXjWHe5lmJpkY4=
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
Subject: [PATCH v10 06/13] drm/bridge: cdns-dsi: Move to devm_drm_of_get_bridge()
Date: Wed, 26 Feb 2025 21:22:21 +0530
Message-Id: <20250226155228.564289-7-aradhya.bhatia@linux.dev>
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

Instead of manually finding the next bridge/panel, and maintaining the
panel-bridge (in-case the next entity is a panel), switch to using the
automatically managing devm_drm_of_get_bridge() API.

Drop the drm_panel support completely from the driver while at it.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 28 ++-----------------
 .../gpu/drm/bridge/cadence/cdns-dsi-core.h    |  2 --
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 6a77ca36cb9d..c2512342139c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -941,8 +941,6 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 	struct cdns_dsi_output *output = &dsi->output;
 	struct cdns_dsi_input *input = &dsi->input;
 	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	struct device_node *np;
 	int ret;
 
 	/*
@@ -960,26 +958,10 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 	/*
 	 * The host <-> device link might be described using an OF-graph
 	 * representation, in this case we extract the device of_node from
-	 * this representation, otherwise we use dsidev->dev.of_node which
-	 * should have been filled by the core.
+	 * this representation.
 	 */
-	np = of_graph_get_remote_node(dsi->base.dev->of_node, DSI_OUTPUT_PORT,
-				      dev->channel);
-	if (!np)
-		np = of_node_get(dev->dev.of_node);
-
-	panel = of_drm_find_panel(np);
-	if (!IS_ERR(panel)) {
-		bridge = drm_panel_bridge_add_typed(panel,
-						    DRM_MODE_CONNECTOR_DSI);
-	} else {
-		bridge = of_drm_find_bridge(np);
-		if (!bridge)
-			bridge = ERR_PTR(-EINVAL);
-	}
-
-	of_node_put(np);
-
+	bridge = devm_drm_of_get_bridge(dsi->base.dev, dsi->base.dev->of_node,
+					DSI_OUTPUT_PORT, dev->channel);
 	if (IS_ERR(bridge)) {
 		ret = PTR_ERR(bridge);
 		dev_err(host->dev, "failed to add DSI device %s (err = %d)",
@@ -989,7 +971,6 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 
 	output->dev = dev;
 	output->bridge = bridge;
-	output->panel = panel;
 
 	/*
 	 * The DSI output has been properly configured, we can now safely
@@ -1005,12 +986,9 @@ static int cdns_dsi_detach(struct mipi_dsi_host *host,
 			   struct mipi_dsi_device *dev)
 {
 	struct cdns_dsi *dsi = to_cdns_dsi(host);
-	struct cdns_dsi_output *output = &dsi->output;
 	struct cdns_dsi_input *input = &dsi->input;
 
 	drm_bridge_remove(&input->bridge);
-	if (output->panel)
-		drm_panel_bridge_remove(output->bridge);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
index ca7ea2da635c..5db5dbbbcaad 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
@@ -10,7 +10,6 @@
 
 #include <drm/drm_bridge.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_panel.h>
 
 #include <linux/bits.h>
 #include <linux/completion.h>
@@ -21,7 +20,6 @@ struct reset_control;
 
 struct cdns_dsi_output {
 	struct mipi_dsi_device *dev;
-	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	union phy_configure_opts phy_opts;
 };
-- 
2.34.1


