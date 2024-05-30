Return-Path: <linux-kernel+bounces-195152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6C8D4840
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBDA1F2197E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480D6F301;
	Thu, 30 May 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B4/28tsI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DA183999
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060711; cv=none; b=G2G7JJPZmleXUlykESyO4NBzkEeAywQt+zVfvDzND4bLIZTjjjZ3SIYhf3wcJbOxfZu7dHnrhvskJnHnKzEkYN1E7KHPhP9V7UseOobXhbcWcT2l3YmYVLe0hILayqNrgn9G0tQfgPiJ6apiElTpkKAOIodxZcPHfZfIpkDHE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060711; c=relaxed/simple;
	bh=zO9ShCoFXelPtI8Jo03DMY5HzkzzcN1uFHRTYYZao1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brSEWVkegnY8N5lqEoG6Yb39xK44ZKWn5Tu5S7uG+d9fwKCmRInIX3IIjYU2jgvZfm6ry/EHA/GkWVzE8ANO5Uf7n9QOazc+t9U9E30gTl1YewHk+LSLHKjf6fLzBiVicfhvheCirMYaMmEEE7CAOURXgYjaYkwoFrCfcZL59Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B4/28tsI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9Hw9v027328;
	Thu, 30 May 2024 04:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717060678;
	bh=nifFyWavGbEvmrxaSGZKNyaYc2U3Tro+G+/rqBFVG+g=;
	h=From:To:CC:Subject:Date;
	b=B4/28tsI/5vt1/dpnbWKj+V5F7NB11k3Da5dfEVdjUhyYuLiZuKDj+EBLRpbliRs+
	 xU45BkGkAMq6bH2wCHNuU9dr9qvMiFoScY8akAbFXD4MxRavY44xjkHH7nRjq2rGDh
	 8fOzgUOP41rBAcEANLW7zO4QhZLH99i93g2acRKI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9HwVH093381
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:17:58 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:17:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:17:58 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9HvjQ058569;
	Thu, 30 May 2024 04:17:58 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <a-bhatia1@ti.com>, <u.kleine-koenig@pengutronix.de>,
        <javierm@redhat.com>, <jani.nikula@intel.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2] drm: bridge: cdns-mhdp8546: Move mode_valid hook to drm_bridge_funcs
Date: Thu, 30 May 2024 14:47:57 +0530
Message-ID: <20240530091757.433106-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

With the support for the 'DRM_BRIDGE_ATTACH_NO_CONNECTOR' case,
the connector_helper funcs are not initialized if the encoder has this
flag in its bridge_attach call. Till now we had mode_valid hook only in
the drm_connector_helper_funcs. Move this hook to drm_bridge_funcs to
validate the modes.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

Changelog v1->v2:
- Remove mode_valid hook from connector_helper_funcs as it is not required.
  (Function despite being identical has been moved below with other
   bridge_funcs instead of keeping it up with drm_connector_helper_funcs)

v1 patch:
<https://lore.kernel.org/all/20240524071348.106210-1-j-choudhary@ti.com/>

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 8a91ef0ae065..8a6cd00a1443 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1617,24 +1617,6 @@ bool cdns_mhdp_bandwidth_ok(struct cdns_mhdp_device *mhdp,
 	return true;
 }
 
-static
-enum drm_mode_status cdns_mhdp_mode_valid(struct drm_connector *conn,
-					  struct drm_display_mode *mode)
-{
-	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
-
-	mutex_lock(&mhdp->link_mutex);
-
-	if (!cdns_mhdp_bandwidth_ok(mhdp, mode, mhdp->link.num_lanes,
-				    mhdp->link.rate)) {
-		mutex_unlock(&mhdp->link_mutex);
-		return MODE_CLOCK_HIGH;
-	}
-
-	mutex_unlock(&mhdp->link_mutex);
-	return MODE_OK;
-}
-
 static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
 					    struct drm_atomic_state *state)
 {
@@ -1678,7 +1660,6 @@ static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
 static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
 	.detect_ctx = cdns_mhdp_connector_detect,
 	.get_modes = cdns_mhdp_get_modes,
-	.mode_valid = cdns_mhdp_mode_valid,
 	.atomic_check = cdns_mhdp_connector_atomic_check,
 };
 
@@ -2233,6 +2214,25 @@ static const struct drm_edid *cdns_mhdp_bridge_edid_read(struct drm_bridge *brid
 	return cdns_mhdp_edid_read(mhdp, connector);
 }
 
+static enum drm_mode_status
+cdns_mhdp_bridge_mode_valid(struct drm_bridge *bridge,
+			    const struct drm_display_info *info,
+			    const struct drm_display_mode *mode)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	mutex_lock(&mhdp->link_mutex);
+
+	if (!cdns_mhdp_bandwidth_ok(mhdp, mode, mhdp->link.num_lanes,
+				    mhdp->link.rate)) {
+		mutex_unlock(&mhdp->link_mutex);
+		return MODE_CLOCK_HIGH;
+	}
+
+	mutex_unlock(&mhdp->link_mutex);
+	return MODE_OK;
+}
+
 static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
 	.atomic_enable = cdns_mhdp_atomic_enable,
 	.atomic_disable = cdns_mhdp_atomic_disable,
@@ -2247,6 +2247,7 @@ static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
 	.edid_read = cdns_mhdp_bridge_edid_read,
 	.hpd_enable = cdns_mhdp_bridge_hpd_enable,
 	.hpd_disable = cdns_mhdp_bridge_hpd_disable,
+	.mode_valid = cdns_mhdp_bridge_mode_valid,
 };
 
 static bool cdns_mhdp_detect_hpd(struct cdns_mhdp_device *mhdp, bool *hpd_pulse)
-- 
2.25.1


