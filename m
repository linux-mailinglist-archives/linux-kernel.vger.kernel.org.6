Return-Path: <linux-kernel+bounces-291016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC67955C3D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAB01F214FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E0144D01;
	Sun, 18 Aug 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gjSqJwH1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AE75809
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977830; cv=none; b=n3Lc2opUUfSHLagKYYpPJU3eVPSGGN2OwhSwq6aPCEQWBZFCm5OirToRNAL69FamW/it5HyOxwvyxJUMWuHy3IqaykgQsGDjuqPVzxoJscDKZC+fBGnhQXpa43uvKqXBJE+Z58dgT9uLkZIh/8Y3XUK6yIlix4yG21D8oWA6oS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977830; c=relaxed/simple;
	bh=zNpawsVFRDk6vrSECsGfQPnlXBxT3clIu57tYxQtJTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFLWYSq538k32P3IRqO0xNx9SFxbeMz7fgecpk4EHcJS+9cdKGPmq2ZzGzqdD5UnWAHp8zJ3oeLZttqqhtOYSoWjgX1rkaMJuOfqDKMFS6L6zYPMNIYGBtEab31Wjue/WcN1AvOqoEW1AkTF36VdT2lp6zMZxU8632xbovES9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gjSqJwH1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=zNpawsVFRDk6vrSECsGfQPnlXBxT3clIu57tYxQtJTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjSqJwH1l3YisR4wu4uoMTnT4VyqZ32lmXhUjRNH/HAKopGorWiO3lKf6+CBFj2Md
	 kiclCPNQShJaichlb3I5dsxf86EqTtfX8xKquCumfJU8CwDaCiWnMzlulCJ2VXq3xN
	 m+iVpg+Z8gVFPs8cXdfCyDfgadk65qI7XgPGBVp4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:34 +0200
Subject: [PATCH 10/12] drm/edid: add a helper to compare two EDIDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-10-aea66c1f7cf4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=1920;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zNpawsVFRDk6vrSECsGfQPnlXBxT3clIu57tYxQtJTA=;
 b=LhDAhouDFnqt2Qjronm11swSH/altKLu1DfmQcdZo7y7dhXuRu1xxeREPmyIR1vaiy9f7GKjP
 7YJxlXRJaQNDRkpUIhH7V5gANCsX9m1W8wm6itHksC6oDy9ILKRD3Ff
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As struct drm_edid is opaque, drivers can't directly memcmp() the
contained data. Add a helper to provide this functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/drm_edid.c | 18 ++++++++++++++++++
 include/drm/drm_edid.h     |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 69fb11741abd..c2493c983a64 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1840,6 +1840,24 @@ static bool drm_edid_eq(const struct drm_edid *drm_edid,
 	return true;
 }
 
+/**
+ * drm_edid_equal - compare two EDID
+ * @drm_edid_a: First EDID data
+ * @drm_edid_b: Second EDID data
+ *
+ * Compare two EDIDs for equality (including extensions)
+ *
+ * Return: True if the EDIDs are equal, false otherwise.
+ */
+bool drm_edid_equal(const struct drm_edid *drm_edid_a, const struct drm_edid *drm_edid_b)
+{
+	if (!drm_edid_b)
+		return !drm_edid_a;
+
+	return drm_edid_eq(drm_edid_a, drm_edid_b->edid, drm_edid_b->size);
+}
+EXPORT_SYMBOL(drm_edid_equal);
+
 enum edid_block_status {
 	EDID_BLOCK_OK = 0,
 	EDID_BLOCK_READ_FAIL,
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index a5b377c4a342..35b40a9d3350 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -456,6 +456,7 @@ drm_display_mode_from_cea_vic(struct drm_device *dev,
 const struct drm_edid *drm_edid_alloc(const void *edid, size_t size);
 const struct drm_edid *drm_edid_dup(const struct drm_edid *drm_edid);
 void drm_edid_free(const struct drm_edid *drm_edid);
+bool drm_edid_equal(const struct drm_edid *drm_edid_a, const struct drm_edid *drm_edid_b);
 bool drm_edid_valid(const struct drm_edid *drm_edid);
 const struct edid *drm_edid_raw(const struct drm_edid *drm_edid);
 const struct drm_edid *drm_edid_read(struct drm_connector *connector);

-- 
2.46.0


