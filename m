Return-Path: <linux-kernel+bounces-195200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D128D48C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A039B25A97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C517D367;
	Thu, 30 May 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oha8PQjl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE1155335
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061829; cv=none; b=YEXeSq3614Dv5bl0Int7edjRrLvAN5/Sk4MAkIcTx3rfULP1xT4FY1ArFk2/L6lq10qSEoBNzYVs3vgny/aYIp8yaYO6JeNTdB1B8xGZEDOXgljz1jLrzEUuQTFkoTsvf8U+rWlqsvZMv6EkG+qFxVuNBY432SYWb2SrzHQ6O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061829; c=relaxed/simple;
	bh=ssOuzRZz0zhXC/m8+8KE9BJFHCMlcpA1tyE1pbyJusE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBQbgBRFB7GXFilXlZUUGiIl2YyU8jvojKa30RVtISE7Irv1ybyS5G50Whv582NGK32K91kqgS0Sd0WGbS7l1+8JtheBGtlL/F/AD+sOMeocRGO+NFLZNOzuzumK5mmAl/iuEUkakkNM7MZMLpKGIfeP3txBqyY52loa4S9cgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Oha8PQjl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9adaM055589;
	Thu, 30 May 2024 04:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717061799;
	bh=YGuptUSUi6PCUNFepUagbXGzpwxcwb18R5SXcLEni7Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Oha8PQjlfEDV/DcneNe98XC/EWOPzqWzol/JGg+cqwkLCyNmrBVKVF6rRTLq8pcRF
	 XKnroqcEFsZxEg2l2+xbJaqD7QFTiBLd0xj7xe6rztoIURjMIDTwICXhZthI8L8B2R
	 4aBtO1yQPS6vomNMdolKStA5bNMuwHRG0wvM2wUw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9ad0Y104087
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:36:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:36:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:36:38 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9abTP086477;
	Thu, 30 May 2024 04:36:38 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Jyri
 Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>
Subject: [PATCH v2 9/9] drm/bridge: cdns-dsi: Use pre_enable/post_disable to enable/disable
Date: Thu, 30 May 2024 15:06:21 +0530
Message-ID: <20240530093621.1925863-10-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530093621.1925863-1-a-bhatia1@ti.com>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The cdns-dsi controller requires that it be turned on completely before
the input DPI's source has begun streaming[0]. Not having that, allows
for a small window before cdns-dsi enable and after cdns-dsi disable
where the previous entity (in this case tidss's videoport) to continue
streaming DPI video signals. This small window where cdns-dsi is
disabled but is still receiving signals causes the input FIFO of
cdns-dsi to get corrupted. This causes the colors to shift on the output
display. The colors can either shift by one color component (R->G, G->B,
B->R), or by two color components (R->B, G->R, B->G).

Since tidss's videoport starts streaming via crtc enable hooks, we need
cdns-dsi to be up and running before that. Now that the bridges are
pre_enabled before crtc is enabled, and post_disabled after crtc is
disabled, use the pre_enable and post_disable hooks to get cdns-dsi
ready and running before the tidss videoport to get pass the color shift
issues.

[0]: See section 12.6.5.7.3 "Start-up Procedure" in J721E SoC TRM
     TRM Link: http://www.ti.com/lit/pdf/spruil1

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 32 +++----------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 6a2223ecff7d..1eedc7053ef8 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -656,8 +656,8 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
-					   struct drm_bridge_state *old_bridge_state)
+static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_bridge_state *old_bridge_state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -677,15 +677,6 @@ static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
 	pm_runtime_put(dsi->base.dev);
 }
 
-static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
-						struct drm_bridge_state *old_bridge_state)
-{
-	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
-	struct cdns_dsi *dsi = input_to_dsi(input);
-
-	pm_runtime_put(dsi->base.dev);
-}
-
 static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
 {
 	struct cdns_dsi_output *output = &dsi->output;
@@ -755,8 +746,8 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
 	dsi->link_initialized = true;
 }
 
-static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
-					  struct drm_bridge_state *old_bridge_state)
+static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_bridge_state)
 {
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
@@ -907,19 +898,6 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
 	writel(tmp, dsi->regs + MCTL_MAIN_EN);
 }
 
-static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
-					      struct drm_bridge_state *old_bridge_state)
-{
-	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
-	struct cdns_dsi *dsi = input_to_dsi(input);
-
-	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
-		return;
-
-	cdns_dsi_init_link(dsi);
-	cdns_dsi_hs_init(dsi);
-}
-
 static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
 					       struct drm_bridge_state *bridge_state,
 					       struct drm_crtc_state *crtc_state,
@@ -968,9 +946,7 @@ static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
 	.attach = cdns_dsi_bridge_attach,
 	.mode_valid = cdns_dsi_bridge_mode_valid,
-	.atomic_disable = cdns_dsi_bridge_atomic_disable,
 	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
-	.atomic_enable = cdns_dsi_bridge_atomic_enable,
 	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-- 
2.34.1


