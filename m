Return-Path: <linux-kernel+bounces-406532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5D9C62EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795B0B87C49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543821791C;
	Tue, 12 Nov 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UxhbOJvi"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47721744B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436467; cv=none; b=OR+xUwk8n/v92ULG2cXNXHGLCMECzqdfCe9vXlZ5dx4KgaX81z3cW67UOvcZjya+KHlG2oaga+VOwLFBqNG+MASy7x7G4SlQyrkhcWrnPtIviBNg3VI6Hr5/11LUJUWFhiNiwhmN2sPMy6rS/IavK9wZzpiF9YSGcsfgS0Vd11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436467; c=relaxed/simple;
	bh=D8AJIQ5upY8eIDK7kgKoJ9mXt4n5iLxc9GyefKFO1as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utVOcJKeatUUofCJL7RlkRjeTYQQL3gjixcCfBw0BJDjPBPwu9UenZHut+RTktpI4uMOFj2xdjD8LiYDj6Yn6la1D1Z/iklRRJJ3b6CYGitM5geXKKRVLSrhWPhsPez30sXghh6oODqEPBMCdEVII+IlmShHbIfhhUxw9Ftjc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UxhbOJvi; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436454;
	bh=D8AJIQ5upY8eIDK7kgKoJ9mXt4n5iLxc9GyefKFO1as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UxhbOJvinHsBreT0MEYShJ55mYn+jd99g2DRDSjfb6fxmT8DfkrFhLpH73JdvrCMA
	 AbaoNK9KVj499S4vpkSsqXYqTVlRnK+mFsbTRqHSULd/lvD7sKYI5d6yGciPAzybB/
	 pKvTf7X3/5i666nKw8/lT/KDdpLT6N3Xcu7Gypmo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:34:12 +0100
Subject: [PATCH v2 3/7] drm/amd/display: Use struct edid in
 dc_link_add_remote_sink()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-amdgpu-drm_edid-v2-3-1399dc0f0469@weissschuh.net>
References: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
In-Reply-To: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 jinzh <jinzh@github.amd.com>, Aric Cyr <Aric.Cyr@amd.com>, 
 Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=6543;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=D8AJIQ5upY8eIDK7kgKoJ9mXt4n5iLxc9GyefKFO1as=;
 b=p/EST7Fq9ZNgbLgF5pH1TNbVBowHlwlxeYHEDfTxcPgmBxwqUgl0Na1cQWg9vWVvm48ykZBgN
 /OKKLuJm1IDC4osAHQs6VcDWZZsn0sV+nsMS2COUquCMA+8BURaUx6U
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The callers of dc_link_add_remote_sink() are using 'struct edid' which
they all need to cast to uint8_t *.
Allow the direct passing of 'struct edid' to avoid these cast and also
move the length calculation so it does not need to be duplicated
everywhere.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 +---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c       | 5 ++---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 6 ++----
 drivers/gpu/drm/amd/display/dc/inc/link.h                   | 3 +--
 drivers/gpu/drm/amd/display/dc/link/link_detection.c        | 6 ++++--
 drivers/gpu/drm/amd/display/dc/link/link_detection.h        | 3 +--
 7 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f0a6816709ca7dad6415d16f9806f18065026cf7..4a093aff4499add545f7beb654ace477036b46fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7242,8 +7242,7 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	aconnector->dc_em_sink = dc_link_add_remote_sink(
 		aconnector->dc_link,
-		(uint8_t *)edid,
-		(edid->extensions + 1) * EDID_LENGTH,
+		edid,
 		&init_params);
 
 	if (aconnector->base.force == DRM_FORCE_ON) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 6e43594906130c1cbea3e510e87d2013903b1bb5..554cc7a7216858ff10e138bf71ab826aa635afe8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -327,7 +327,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 				dc_sink = dc_link_add_remote_sink(
 					aconnector->dc_link,
 					NULL,
-					0,
 					&init_params);
 
 				if (!dc_sink) {
@@ -367,8 +366,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		edid = drm_edid_raw(aconnector->drm_edid); // FIXME: Get rid of drm_edid_raw()
 		dc_sink = dc_link_add_remote_sink(
 			aconnector->dc_link,
-			(uint8_t *)edid,
-			(edid->extensions + 1) * EDID_LENGTH,
+			edid,
 			&init_params);
 
 		if (!dc_sink) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 457d60eeb486c228fde050b206fbe1c9043cdd33..be55165a16df65c623092906582ba7e81a141464 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -266,11 +266,10 @@ unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link)
 
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *link,
-		const uint8_t *edid,
-		int len,
+		const struct edid *edid,
 		struct dc_sink_init_data *init_data)
 {
-	return link->dc->link_srv->add_remote_sink(link, edid, len, init_data);
+	return link->dc->link_srv->add_remote_sink(link, edid, init_data);
 }
 
 void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e143fab00a861c4f578167702c648d2b4b043945..7d5c790cab50987f361e1b4228562483a0f908f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1846,14 +1846,12 @@ struct dc_sink_init_data;
  * called.
  *
  * @dc_link - link the remote sink will be added to.
- * @edid - byte array of EDID raw data.
- * @len - size of the edid in byte
+ * @edid - EDID data.
  * @init_data -
  */
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *dc_link,
-		const uint8_t *edid,
-		int len,
+		const struct edid *edid,
 		struct dc_sink_init_data *init_data);
 
 /* Remove remote sink from a link with dc_connection_mst_branch connection type.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index f04292086c08a081fce8e780c584a0ce66668f12..76bac2e773b0f5036b82942ed90b9c43c6558d4c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -109,8 +109,7 @@ struct link_service {
 			enum dc_connection_type *type);
 	struct dc_sink *(*add_remote_sink)(
 			struct dc_link *link,
-			const uint8_t *edid,
-			int len,
+			const struct edid *edid,
 			struct dc_sink_init_data *init_data);
 	void (*remove_remote_sink)(struct dc_link *link, struct dc_sink *sink);
 	bool (*get_hpd_state)(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index e026c728042a5f47decbc3e7c80583c0d31fa700..05adaf8248b1b11675aa9e86a24fa24a2a811e01 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -48,6 +48,8 @@
 #include "dm_helpers.h"
 #include "clk_mgr.h"
 
+#include <drm/drm_edid.h>
+
  // Offset DPCD 050Eh == 0x5A
 #define MST_HUB_ID_0x5A  0x5A
 
@@ -1390,10 +1392,10 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
-		const uint8_t *edid,
-		int len,
+		const struct edid *edid,
 		struct dc_sink_init_data *init_data)
 {
+	int len = edid ? (edid->extensions + 1) * EDID_LENGTH : 0;
 	struct dc_sink *dc_sink;
 	enum dc_edid_status edid_status;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.h b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
index 7da05078721ef4d9a2e10c52da4eb30510d9c160..dec5001411be2c008c8684f474b020bf78278442 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
@@ -31,8 +31,7 @@ bool link_detect_connection_type(struct dc_link *link,
 		enum dc_connection_type *type);
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
-		const uint8_t *edid,
-		int len,
+		const struct edid *edid,
 		struct dc_sink_init_data *init_data);
 void link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink);
 bool link_reset_cur_dp_mst_topology(struct dc_link *link);

-- 
2.47.0


