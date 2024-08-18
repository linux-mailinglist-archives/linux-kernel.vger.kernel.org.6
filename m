Return-Path: <linux-kernel+bounces-291014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4D955C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EB01C210D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420D199B8;
	Sun, 18 Aug 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XodzYGrn"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065A4CB4E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977829; cv=none; b=Dkhas0sVSKUSjzEx6YqNzwpk+N24ps94/HnOJe381kUZ1oKeJmhYqr++mXBH15KjzZtQ45faQJY1WxRhBdCoyr1Ya8bdpVMRK/+Dx90zsGtpid+0zYiS/w3+t/n+4gDsxPdRRAACpB4a4MDijCIl+Tvzw6kD9zbj4bZCqGB0QHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977829; c=relaxed/simple;
	bh=h+vDTnH3DDu+8RyHiUdxUe+8vxjeNNH3grJdJdANAxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bioteTjYkRuWTBCxS6OWRbma7n0LTOjcfeBZohdMQe0N2T9DHIxnqVUvnSJMZ5IS9LaRGqlM3cwq37uVABPihpSW+sbZQpBh14I3Hms+yFbxRdXLspWY8NxdCjebQ99qGwliJlf8xDPg8Lt2vM8VSXc44baT3M6wO2LJXaRPhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XodzYGrn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=h+vDTnH3DDu+8RyHiUdxUe+8vxjeNNH3grJdJdANAxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XodzYGrnfJ6G4YMDxiNJR0PMbJcdkOHLTzXFveCKNE5u2mv4jU3vM75SfpoZifUs4
	 stXBzKXHa4qXo6bUuyVtmskmT/E9iSIlMibSnQst0lXqwwA5MvzKcqryOUvYiLdUwW
	 ud+f7szSts/WT3QJB8gzrbulWDHMqudzcjisD4i0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:31 +0200
Subject: [PATCH 07/12] drm/amd/display: Use struct edid in
 dc_link_add_remote_sink()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-7-aea66c1f7cf4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=6099;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=h+vDTnH3DDu+8RyHiUdxUe+8vxjeNNH3grJdJdANAxU=;
 b=4Jq37a97qqa9wcs/LsX4+tTQdI1A0iqDlZHvLdTK7j13xubeoG/TOAbw592BmnuJBFKggrJO0
 j+mBRIhS9CeBHntA7UNDDpdijV0YXpqRkjkevAUjKwcdt2gnXZpKP43
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
index 4e7f40481379..bd9a1a21720e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7103,8 +7103,7 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 
 	aconnector->dc_em_sink = dc_link_add_remote_sink(
 		aconnector->dc_link,
-		(uint8_t *)edid,
-		(edid->extensions + 1) * EDID_LENGTH,
+		edid,
 		&init_params);
 
 	if (aconnector->base.force == DRM_FORCE_ON) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2e9f6da1acdc..25e98d248c21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -325,7 +325,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 				dc_sink = dc_link_add_remote_sink(
 					aconnector->dc_link,
 					NULL,
-					0,
 					&init_params);
 
 				if (!dc_sink) {
@@ -362,8 +361,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 				.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
 		dc_sink = dc_link_add_remote_sink(
 			aconnector->dc_link,
-			(uint8_t *)aconnector->edid,
-			(aconnector->edid->extensions + 1) * EDID_LENGTH,
+			aconnector->edid,
 			&init_params);
 
 		if (!dc_sink) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index dfdfe22d9e85..5fb7bf1d9034 100644
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
index 6b036417a73a..4b2abb25ca3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1827,14 +1827,12 @@ struct dc_sink_init_data;
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
index 72a8479e1f2d..828b0bd71261 100644
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
index 391dbe81534d..6a190d084a94 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -48,6 +48,8 @@
 #include "dm_helpers.h"
 #include "clk_mgr.h"
 
+#include <drm/drm_edid.h>
+
 #define DC_LOGGER \
 	link->ctx->logger
 #define DC_LOGGER_INIT(logger)
@@ -1379,10 +1381,10 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 
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
index 7da05078721e..dec5001411be 100644
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
2.46.0


