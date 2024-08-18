Return-Path: <linux-kernel+bounces-291017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EC6955C3F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5951C20E64
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A73314659A;
	Sun, 18 Aug 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="szTFfoMo"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F77581F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977830; cv=none; b=XSDX9DzhDp07Y7+O+iAP1sY5xUqkk/k9OlwfsP+WBd1EYWws2QlHydZNfX7idNoSl603BP+3KkfL/rvQNTvPiij7tMqHD5GS/niHX2J922vZy6W9zXWc22bLNsBmDVhr8Pznghz8QBOyrHcWOrieIyJMcroAyJI1tdefTm9T4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977830; c=relaxed/simple;
	bh=o8j1TRsZVRx80CEDrMrwODXpPj/rWeZUErsBRynhHbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPwVXiDqxAYBXzIcjw433do8qZ10cjw9AEdf0ITp1i4AkrU7H6lPMx0hwdpVKCIMSYMYvsnbvjPk2bDk0ARD+rP+izYlyzVmQ2hIw6lWimrsGWAP6ZJ48G9wQ3KhgNd3/aLQszZxQLhkp4INH4GxYvmuNpPH2Ugun+T7OlAZKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=szTFfoMo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977822;
	bh=o8j1TRsZVRx80CEDrMrwODXpPj/rWeZUErsBRynhHbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=szTFfoMoSlvBOcNGYuNyHycYfG+w8V/PfS5+qtObTmgM1rOshjoHco4h3vJ31T44z
	 9Z/4PFNOFQTdb2UzjfDdO0glzWtIFgBcLI4ITY3yyOAZdo3oTVYgqfoGtmQw7zvSRV
	 5FfulRPWWRDO1xEPuXUJO4t3PAflALIeiUbzknDc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:36 +0200
Subject: [PATCH 12/12] drm/amd/display: Switch dc_link_add_remote_sink() to
 struct drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-12-aea66c1f7cf4@weissschuh.net>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
In-Reply-To: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=5589;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=o8j1TRsZVRx80CEDrMrwODXpPj/rWeZUErsBRynhHbQ=;
 b=CJWBu27eXE/DLU6HnLXv3rTp0kb97BiJxvrnvwqoetXMNcfZy7rwsiBDodLngC5UeYDbkL4lh
 z95tHQIpD4TBPieVXG2/hHKiiN9f2JZRDfZ9FEBSNk/DoW9QfNhv/3b
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

"struct drm_edid" is the safe and recommended alternative to "struct edid".
Now that all callers of dc_link_add_remote_sink() have access to a
validate struct drm_edid, pass it around directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                         | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h                   | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c        | 5 ++---
 drivers/gpu/drm/amd/display/dc/link/link_detection.h        | 2 +-
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e5ac1e6eca80..23582fa4fd2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7102,7 +7102,7 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 
 	aconnector->dc_em_sink = dc_link_add_remote_sink(
 		aconnector->dc_link,
-		drm_edid_raw(drm_edid),
+		drm_edid,
 		&init_params);
 
 	if (aconnector->base.force == DRM_FORCE_ON) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cd03108db28b..f49af060c0e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -362,7 +362,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 				.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
 		dc_sink = dc_link_add_remote_sink(
 			aconnector->dc_link,
-			drm_edid_raw(aconnector->drm_edid),
+			aconnector->drm_edid,
 			&init_params);
 
 		if (!dc_sink) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 5fb7bf1d9034..e35e6763dcbb 100644
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
index eb151a637f1a..ce1cde89c621 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1832,7 +1832,7 @@ struct dc_sink_init_data;
  */
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *dc_link,
-		const struct edid *edid,
+		const struct drm_edid *drm_edid,
 		struct dc_sink_init_data *init_data);
 
 /* Remove remote sink from a link with dc_connection_mst_branch connection type.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 828b0bd71261..062109823f32 100644
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
index cdbf6bcc8f68..64d30ba476dd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1371,10 +1371,9 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
-		const struct edid *edid,
+		const struct drm_edid *drm_edid,
 		struct dc_sink_init_data *init_data)
 {
-	int len = edid ? (edid->extensions + 1) * EDID_LENGTH : 0;
 	struct dc_sink *dc_sink;
 	enum dc_edid_status edid_status;
 
@@ -1393,7 +1392,7 @@ struct dc_sink *link_add_remote_sink(
 	if (!dc_sink)
 		return NULL;
 
-	dc_sink->drm_edid = drm_edid_alloc(edid, len);
+	dc_sink->drm_edid = drm_edid_dup(drm_edid);
 
 	if (!link_add_remote_sink_helper(
 			link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.h b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
index dec5001411be..c35b4f5304c6 100644
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
2.46.0


