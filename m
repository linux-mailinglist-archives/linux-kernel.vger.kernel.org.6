Return-Path: <linux-kernel+bounces-195201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F818D48C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CDE1F21638
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8817D375;
	Thu, 30 May 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jwIKfK2i"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16F155381
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061830; cv=none; b=BzbU7uHd7s+Ko3dZupaCLy9FHddUxmTI7kJn2ANajTjGMZ4C8MbNbcSdjx+zrGv0iM1JX9q0LyI3Kg0TRGLCXjt61Tv3QqeunjmoJzJlEO6nGX2PKnY2wqOfgonxhFQEn50pj7+jcmH8SjaqxZSc0elMXKy0ugapndCOIEr76II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061830; c=relaxed/simple;
	bh=Co3NApN5PH0RwrxV3ma4J3plO3ITMnzTINS3wtyhh5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+XJ0T6j0Fg3ZOw4brOhTqSapHTMwvRoLvw8sL9JlDkR8xrBsWnxFDN1lj9RaabyEJhAnvtUHbxWxF9QwwiJuzyyO6xZGCkNxGpha5Czy4XQvZiyUWY6LBSZG7KC4hcvMI50O/sbXNIFPjEvN+pVTeA8NausjmjoCiFo0VQtzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jwIKfK2i; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9ab0t030998;
	Thu, 30 May 2024 04:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717061797;
	bh=BF4OeQ8AnLvIg0Vy2/wLlvEDPShVZWkGdXBbmVkNmes=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jwIKfK2igZooIYzC3x851LvNhg1dgoxaQO7dAT1uWWhCCFtUzicsAlHhd+Opg56Fb
	 5b5uSL0JZuhZjMQIN0de3x4ZqTRfOQ27UJNpTmkP3uESHHoo/IwBEs9iL1cCtco+5B
	 XbCkLrcuZx/PQMWZXpv844HL3th05Ag5gghze4+s=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9abGo020248
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:36:37 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:36:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:36:36 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9aaJH000663;
	Thu, 30 May 2024 04:36:36 -0500
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
Subject: [PATCH v2 8/9] drm/atomic-helper: Re-order bridge chain pre-enable and post-disable
Date: Thu, 30 May 2024 15:06:20 +0530
Message-ID: <20240530093621.1925863-9-a-bhatia1@ti.com>
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

Move the bridge pre_enable call before crtc enable, and the bridge
post_disable call after the crtc disable.

The sequence of enable after this patch will look like:

	bridge[n]_pre_enable
	...
	bridge[1]_pre_enable

	crtc_enable
	encoder_enable

	bridge[1]_enable
	...
	bridge[n]__enable

and vice-versa for the bridge chain disable sequence.

The definition of bridge pre_enable hook says that,
"The display pipe (i.e. clocks and timing signals) feeding this bridge
will not yet be running when this callback is called".

Since CRTC is also a source feeding the bridge, it should not be enabled
before the bridges in the pipeline are pre_enabled. Fix that by
re-ordering the sequence of bridge pre_enable and bridge post_disable.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 70 +++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index fb97b51b38f1..02e093950218 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1186,8 +1186,6 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 			else if (funcs->dpms)
 				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
 		}
-
-		drm_atomic_bridge_chain_post_disable(bridge, old_state);
 	}
 
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
@@ -1234,6 +1232,49 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 		if (ret == 0)
 			drm_crtc_vblank_put(crtc);
 	}
+
+	for_each_oldnew_connector_in_state(old_state, connector, old_conn_state,
+					   new_conn_state, i) {
+		struct drm_encoder *encoder;
+		struct drm_bridge *bridge;
+
+		/*
+		 * Shut down everything that's in the changeset and currently
+		 * still on. So need to check the old, saved state.
+		 */
+		if (!old_conn_state->crtc)
+			continue;
+
+		old_crtc_state = drm_atomic_get_old_crtc_state(old_state, old_conn_state->crtc);
+
+		if (new_conn_state->crtc)
+			new_crtc_state = drm_atomic_get_new_crtc_state(old_state,
+								       new_conn_state->crtc);
+		else
+			new_crtc_state = NULL;
+
+		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
+		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
+			continue;
+
+		encoder = old_conn_state->best_encoder;
+
+		/* We shouldn't get this far if we didn't previously have
+		 * an encoder.. but WARN_ON() rather than explode.
+		 */
+		if (WARN_ON(!encoder))
+			continue;
+
+		drm_dbg_atomic(dev, "disabling [ENCODER:%d:%s]\n",
+			       encoder->base.id, encoder->name);
+
+		/*
+		 * Each encoder has at most one connector (since we always steal
+		 * it away), so we won't call disable hooks twice.
+		 */
+		bridge = drm_bridge_chain_get_first_bridge(encoder);
+		drm_atomic_bridge_chain_post_disable(bridge, old_state);
+	}
 }
 
 /**
@@ -1469,6 +1510,30 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 	struct drm_connector_state *new_conn_state;
 	int i;
 
+	for_each_new_connector_in_state(old_state, connector, new_conn_state, i) {
+		struct drm_encoder *encoder;
+		struct drm_bridge *bridge;
+
+		if (!new_conn_state->best_encoder)
+			continue;
+
+		if (!new_conn_state->crtc->state->active ||
+		    !drm_atomic_crtc_needs_modeset(new_conn_state->crtc->state))
+			continue;
+
+		encoder = new_conn_state->best_encoder;
+
+		drm_dbg_atomic(dev, "enabling [ENCODER:%d:%s]\n",
+			       encoder->base.id, encoder->name);
+
+		/*
+		 * Each encoder has at most one connector (since we always steal
+		 * it away), so we won't call enable hooks twice.
+		 */
+		bridge = drm_bridge_chain_get_first_bridge(encoder);
+		drm_atomic_bridge_chain_pre_enable(bridge, old_state);
+	}
+
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
 		const struct drm_crtc_helper_funcs *funcs;
 
@@ -1514,7 +1579,6 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		 * it away), so we won't call enable hooks twice.
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
-		drm_atomic_bridge_chain_pre_enable(bridge, old_state);
 
 		if (funcs) {
 			if (funcs->atomic_enable)
-- 
2.34.1


