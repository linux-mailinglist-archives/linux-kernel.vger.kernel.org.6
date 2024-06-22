Return-Path: <linux-kernel+bounces-225641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A791333A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0881C213F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0395E14EC44;
	Sat, 22 Jun 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iFCkNHtm"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909D15442C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054610; cv=none; b=dTtF209flBvHcKn0oUGayZ7PjGd6y39qDNYm9+/5sLRVtGenSWoF8py1qU9ScdYTrM//dRiP8uyq4RtyfZI8N54A2BZUG17t+mI5sHWs6M2i+DO9I3vTwDSeRKtaI8DHNZE5oFtJhp/o19d8T3rNARfSzOAplCjSdH8uWaAk6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054610; c=relaxed/simple;
	bh=4egxLL34lf8chf8eukaVbrky5QXf5o7Qi1tnJsreDRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/WUXRac+UwGwOW/S3YYPsTY3Ivg0Lx++GgryXxyk74LG8pmI21+Oj/WgSRgwy0yF3dGa253q2sy+GwbF+ACfB97gEZfKyzRjgDQbL8qTaujEpS3Iy9lmikypvb5F/1RoC+fX1h2pCWF36Zofj38Jeo9AtDVyLWkUXKhLUkdh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iFCkNHtm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9ikG009946;
	Sat, 22 Jun 2024 06:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719054584;
	bh=jxMjj6XvBeezwFxxYR9UvDx7d1pMmSkH+vu3+H6DBe8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iFCkNHtm2awIHf6P7pBVlj27F7g6kVBlT3yyNJgDWjeyJFrS43eWiOGDwrGgZwcOX
	 S+dv0d1QvroRZzv6BPhY4NSsfLZu6te3sOoZaGdDFdb7L8BS0D2y7UH2e98buB+zca
	 bBV1OT2W/4cUhqosMl9OKjtIuV0fP+fTdjHdOOrs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45MB9iNI003588
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 06:09:44 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 06:09:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 06:09:43 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9hTk023242;
	Sat, 22 Jun 2024 06:09:43 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Dominik Haller <d.haller@phytec.de>, Sam
 Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Kieran
 Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri
	<praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v4 09/11] drm/bridge: cdns-dsi: Support atomic bridge APIs
Date: Sat, 22 Jun 2024 16:39:27 +0530
Message-ID: <20240622110929.3115714-10-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622110929.3115714-1-a-bhatia1@ti.com>
References: <20240622110929.3115714-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Change the existing (and deprecated) bridge hooks, to the bridge
atomic APIs.

Add drm helpers for duplicate_state, destroy_state, and bridge_reset
bridge hooks.

Further add support for the input format negotiation hook.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 51 ++++++++++++++++---
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cad0c1478ef0..c9697818308e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -655,7 +655,8 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+					   struct drm_bridge_state *old_bridge_state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -679,7 +680,8 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
 	pm_runtime_put(dsi->base.dev);
 }
 
-static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_bridge_state *old_bridge_state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -755,7 +757,8 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
 	dsi->link_initialized = true;
 }
 
-static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+					  struct drm_bridge_state *old_bridge_state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -906,7 +909,8 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	writel(tmp, dsi->regs + MCTL_MAIN_EN);
 }
 
-static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
+static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_bridge_state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -918,13 +922,44 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
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


