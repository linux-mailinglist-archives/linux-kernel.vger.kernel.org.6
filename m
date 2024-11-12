Return-Path: <linux-kernel+bounces-406536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39779C6086
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528311F2583B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82999218D81;
	Tue, 12 Nov 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rMalO9Ta"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD2217F3B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436469; cv=none; b=ivVYcu7EZ0YYU8KuNVrB6jvpyDfxR/q1ByGKGy27IyaqgBo2Nq5NFY1nuDGaf5Tu58B7xNlrh7ccGnp7hOdXROL0V8N3L93IvnITlxfhQPck0C3qz7JioPBnll/FHJ7MP0MwiH658NpeuRJ0uxgHQVBwTz5UABRLRIzumYcoI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436469; c=relaxed/simple;
	bh=OCMki1vQqbDliRkOMezACkpm1Q36q6wLOkTgwor2sVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZI3/uS13qNc+gnbc+K1dCKA25OT7v0O84WHfyGvJ3lkUqZ6zbTtR/Xac6FPeCbzJoxia/AH9vArelTzOaaY2a7jP0ilQ69XBwnRQaFRA3TAFqiyrW2OUridb7cFUBAOc+T4QKbX1Fa7hX0osyXkq0DttQXNJ1NGMKTRDgMNbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rMalO9Ta; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436455;
	bh=OCMki1vQqbDliRkOMezACkpm1Q36q6wLOkTgwor2sVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rMalO9TaEUVfeVBWfJC8vJPCeZyaLbaD3ioHhJ2otPSxCRAZzRd3nPeXNEYucB5H9
	 W6ncVnx7bpKq7Mb3eFqODFpvcH6DvaLfOZz7cpnrkf8N74g98IBITim9N6mJ1gBA46
	 x/r6DycF3Ubt4KaYLI18UbdPcXM3mClAE9OyaXLU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:34:16 +0100
Subject: [PATCH v2 7/7] drm/amd/display: Switch dc_link_add_remote_sink()
 to struct drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-amdgpu-drm_edid-v2-7-1399dc0f0469@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=6539;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OCMki1vQqbDliRkOMezACkpm1Q36q6wLOkTgwor2sVw=;
 b=ivWuWrGWBTBrHZtGZ8K6EFZ4S0boWjcegIJwbAhytLAqAYLmxQnpjj5yol6OlTrlX/w3mHYvQ
 MNeJgFiZ5GEAZGjhTpMZ6kKzVtivWazGXTH+sJRlyDxt87rFx9IRHkH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

"struct drm_edid" is the safe and recommended alternative to "struct edid".
Now that all callers of dc_link_add_remote_sink() have access to a
validate struct drm_edid, pass it around directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 4 +---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 +---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                         | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h                   | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c        | 5 ++---
 drivers/gpu/drm/amd/display/dc/link/link_detection.h        | 2 +-
 7 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b09e13aed570756655b94647d4346c722a02e34a..a555809f2691001b26fc2cbcd3dff41484521365 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7218,7 +7218,6 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 			.sink_signal = SIGNAL_TYPE_VIRTUAL
 	};
 	const struct drm_edid *drm_edid;
-	const struct edid *edid;
 
 	drm_edid = drm_edid_read(connector);
 	drm_edid_connector_update(connector, drm_edid);
@@ -7232,10 +7231,9 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 
 	aconnector->drm_edid = drm_edid;
 
-	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	aconnector->dc_em_sink = dc_link_add_remote_sink(
 		aconnector->dc_link,
-		edid,
+		drm_edid,
 		&init_params);
 
 	if (aconnector->base.force == DRM_FORCE_ON) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 554cc7a7216858ff10e138bf71ab826aa635afe8..df70f6bc92a3fa247aa9389ab29d8e249bb683ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -361,12 +361,10 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		struct dc_sink_init_data init_params = {
 				.link = aconnector->dc_link,
 				.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
-		const struct edid *edid;
 
-		edid = drm_edid_raw(aconnector->drm_edid); // FIXME: Get rid of drm_edid_raw()
 		dc_sink = dc_link_add_remote_sink(
 			aconnector->dc_link,
-			edid,
+			aconnector->drm_edid,
 			&init_params);
 
 		if (!dc_sink) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index be55165a16df65c623092906582ba7e81a141464..26c975ec7861848d458d13190cb173c6e1003cef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -266,10 +266,10 @@ unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link)
 
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *link,
-		const struct edid *edid,
+		const struct drm_edid *drm_edid,
 		struct dc_sink_init_data *init_data)
 {
-	return link->dc->link_srv->add_remote_sink(link, edid, init_data);
+	return link->dc->link_srv->add_remote_sink(link, drm_edid, init_data);
 }
 
 void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 60f535fd39620b5657c1bc34b7f2e1509f62a5f3..b12f95ba7dcd29f2722d0e9d498295c34de40b2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1851,7 +1851,7 @@ struct dc_sink_init_data;
  */
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *dc_link,
-		const struct edid *edid,
+		const struct drm_edid *drm_edid,
 		struct dc_sink_init_data *init_data);
 
 /* Remove remote sink from a link with dc_connection_mst_branch connection type.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 76bac2e773b0f5036b82942ed90b9c43c6558d4c..12a452315b0ee84412b36c66b231658837186537 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -109,7 +109,7 @@ struct link_service {
 			enum dc_connection_type *type);
 	struct dc_sink *(*add_remote_sink)(
 			struct dc_link *link,
-			const struct edid *edid,
+			const struct drm_edid *drm_edid,
 			struct dc_sink_init_data *init_data);
 	void (*remove_remote_sink)(struct dc_link *link, struct dc_sink *sink);
 	bool (*get_hpd_state)(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index f13b4e8929d5b217495b5fd29c4da7248a01a8e6..387117863c9e8af6298b07d2040a4372f94c8c88 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1403,10 +1403,9 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
-		const struct edid *edid,
+		const struct drm_edid *drm_edid,
 		struct dc_sink_init_data *init_data)
 {
-	int len = edid ? (edid->extensions + 1) * EDID_LENGTH : 0;
 	struct dc_sink *dc_sink;
 	enum dc_edid_status edid_status;
 
@@ -1425,7 +1424,7 @@ struct dc_sink *link_add_remote_sink(
 	if (!dc_sink)
 		return NULL;
 
-	dc_sink->drm_edid = drm_edid_alloc(edid, len);
+	dc_sink->drm_edid = drm_edid_dup(drm_edid);
 
 	if (!link_add_remote_sink_helper(
 			link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.h b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
index dec5001411be2c008c8684f474b020bf78278442..c35b4f5304c6e8bcbb6f998962d089b43104db89 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
@@ -31,7 +31,7 @@ bool link_detect_connection_type(struct dc_link *link,
 		enum dc_connection_type *type);
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
-		const struct edid *edid,
+		const struct drm_edid *drm_edid,
 		struct dc_sink_init_data *init_data);
 void link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink);
 bool link_reset_cur_dp_mst_topology(struct dc_link *link);

-- 
2.47.0


