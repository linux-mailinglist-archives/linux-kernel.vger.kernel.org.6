Return-Path: <linux-kernel+bounces-256148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451419349D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660641C21D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44B79DC5;
	Thu, 18 Jul 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2v0nAgkI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE578C89
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291122; cv=none; b=Ok4hP8cJ9jTg8XO4TDU18yZzucSbxOvU+Zg3xG/PmpcfR+Fa/fU5bxc8SORgIR5R0q8ssabp+ceEAvVjUJzdX57dKc2T7jt3fbu7mMholiRyMzLgGTyc/1Z7wqdXLJx24gUG+5UGv6kBV6qYzKIWeH+zmzou3p0T0ySAD4y7F58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291122; c=relaxed/simple;
	bh=89eygFmnv7fnoScWyve+SwrE7rlZmWG+C4XF1WW1nLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9pM/rfDKHaVxGwSsHdIXYwR7LgT9WZLU5f6xtYbbwXHCEpyzRUPT5cD9qfNP4ZZfqdcPTeFuZ7t/dpWI8vMKBjWk34DphGRfT0QB66mdmCwz/U/T/4VctoPBKXYaiMlbi0FllZ9L5Dqj3ocXGZ+CnmWq5JEx4yrISlPu6lB/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2v0nAgkI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721291119;
	bh=89eygFmnv7fnoScWyve+SwrE7rlZmWG+C4XF1WW1nLE=;
	h=From:To:Cc:Subject:Date:From;
	b=2v0nAgkIbSzaxpv1BTleKVSzfGwm1gJxuZE2JJSLnsiCUcLYI+frzTvgvAKan+bth
	 uHmmKOVbMuiYnzxMx1ecPgENRdMUmiTEmhugyKykbHMKJtdPt9+LV+e/8NZeIac9pB
	 bD1o25H0rd1INIF64BiIl4gG2/tClhnSvz7IKoIwcpXBYB9vb/YtXlXntDnTuG1k6O
	 BwPUY4DGIIGY9MmhZBmSi6Sw5jNWbOWQ1nIHcUU1Ao5qHkMn170ZIeKK8gTREbmkVn
	 DrmN9m5RLR9ODnnIexicR+ow8raLbkzCwC67n5cLPWHTP0Ta4oWu6rQOs2/K6has8Q
	 TggjAYnqFPOoQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B06A43782167;
	Thu, 18 Jul 2024 08:25:18 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	ck.hu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] drm/mediatek: Declare Z Position for all planes
Date: Thu, 18 Jul 2024 10:25:07 +0200
Message-ID: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek SoCs support multiple planes, one of which is the primary
and all the others are overlays (and CURSOR is the last overlay).

In all currently supported SoCs, the Z order of the overlays can't
be changed with any fast muxing action, and can only be changed by
swapping the contents of the entire register set of one overlay
with the other to internally reorder the layer properties, which
is indeed feasible, but probably more expensive than desired.

Declare the Z position for all planes with an immutable property
at least for now, so that the userspace can take its decisions
accordingly.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c  |  2 +-
 drivers/gpu/drm/mediatek/mtk_plane.c | 18 +++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_plane.h |  3 +--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 072b2fdae87b..327214721b4d 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -874,7 +874,7 @@ static int mtk_crtc_init_comp_planes(struct drm_device *drm_dev,
 				mtk_crtc_plane_type(mtk_crtc->layer_nr, num_planes),
 				mtk_ddp_comp_supported_rotations(comp),
 				mtk_ddp_comp_get_formats(comp),
-				mtk_ddp_comp_get_num_formats(comp));
+				mtk_ddp_comp_get_num_formats(comp), i);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 5bf757a3ef20..7d2cb4e0fafa 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -321,7 +321,7 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
 		   unsigned int supported_rotations, const u32 *formats,
-		   size_t num_formats)
+		   size_t num_formats, unsigned int plane_idx)
 {
 	int err;
 
@@ -338,6 +338,22 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		return err;
 	}
 
+	/*
+	 * The hardware does not support repositioning planes by muxing: their
+	 * Z-position is infact fixed and the only way to change the actual
+	 * order is to swap the contents of the entire register set of one
+	 * overlay with another, which may be more expensive than desired.
+	 *
+	 * With no repositioning, the caller of this function guarantees that
+	 * the plane_idx is correct. This means that, for example, the PRIMARY
+	 * plane fed to this function will always have plane_idx zero.
+	 */
+	err = drm_plane_create_zpos_immutable_property(plane, plane_idx);
+	if (err) {
+		DRM_ERROR("Failed to create zpos property for plane %u\n", plane_idx);
+		return err;
+	}
+
 	if (supported_rotations) {
 		err = drm_plane_create_rotation_property(plane,
 							 DRM_MODE_ROTATE_0,
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.h b/drivers/gpu/drm/mediatek/mtk_plane.h
index 231bb7aac947..5b177eac67b7 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_plane.h
@@ -49,6 +49,5 @@ to_mtk_plane_state(struct drm_plane_state *state)
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
 		   unsigned int supported_rotations, const u32 *formats,
-		   size_t num_formats);
-
+		   size_t num_formats, unsigned int plane_idx);
 #endif
-- 
2.45.2


