Return-Path: <linux-kernel+bounces-235025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA491CE8F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 20:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31618B213B9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7512FB34;
	Sat, 29 Jun 2024 18:32:52 +0000 (UTC)
Received: from mail.asbjorn.biz (mail.asbjorn.biz [185.38.24.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B75660
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.38.24.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719685971; cv=none; b=GMWrKt/v8J/vB6ZIUITxKpcoqdxNeN/2Bv+Yw7T0BFrhl7nS6g2IMgv5zHcR0Huy/EJbKbBssPUqySMJ4aAyZuo/sZtdll9CQUE0/mupw8saeEMnR0SZ6W59gNeRqvIW3/0YDGQlwzT4ZuZKqiJu9FmSb0i/d6ngsFhdCuYYc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719685971; c=relaxed/simple;
	bh=STBPCs8SDAJB8vAZOpZaJuTyIH4sta10k3Qf4/aJAoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHAbqPgpBenLSGQ45Mdq5FUdiX5jP2EOf/AKEQXBXaucGLaliNEJSAQxL78W+Vx85uy4hR9ij15oY27WDer3Bm+8yfnjb7ZLiBQ9CTWAjkAQJlFPKXMyUVTRrG/3MSwnx2Syx+sgTgHQo/ZGeuO4Uog9/op5kGA0eHrD5/qU89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asbjorn.st; spf=pass smtp.mailfrom=asbjorn.st; arc=none smtp.client-ip=185.38.24.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asbjorn.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asbjorn.st
Received: from x201s (space.labitat.dk [185.38.175.0])
	by mail.asbjorn.biz (Postfix) with ESMTPSA id C4C351C0A988;
	Sat, 29 Jun 2024 18:25:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 212A62025CC; Sat, 29 Jun 2024 18:25:27 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <asbjorn@asbjorn.st>
To: intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <asbjorn@asbjorn.st>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: implement vmap/vunmap GEM object functions
Date: Sat, 29 Jun 2024 18:25:06 +0000
Message-ID: <20240629182513.78026-1-asbjorn@asbjorn.st>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement i915_gem_vmap_object() and i915_gem_vunmap_object(),
based on i915_gem_dmabuf_vmap() and i915_gem_dmabuf_vunmap().

This enables a drm_client to use drm_client_buffer_vmap() and
drm_client_buffer_vunmap() on hardware using the i915 driver.

Tested with a currently out of tree pixelflut drm_client[1] on:
- Lenovo ThinkCentre M720q (CoffeeLake-S GT2 / Intel UHD Graphics 630)
- Dell Wyse N06D - 3030 LT (ValleyView on Intel Celeron N2807 SOC)

[1] XDP->DRM pixelflut: https://labitat.dk/wiki/Pixelflut-XDR

Signed-off-by: Asbjørn Sloth Tønnesen <asbjorn@asbjorn.st>
---
This patch applies on top of drm-intel/drm-intel-next (32a120f52a4c)

 drivers/gpu/drm/i915/gem/i915_gem_object.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 58e6c680fe0d..356530b599ce 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -873,6 +873,30 @@ bool i915_gem_object_needs_ccs_pages(struct drm_i915_gem_object *obj)
 	return lmem_placement;
 }
 
+static int i915_gem_vmap_object(struct drm_gem_object *gem_obj,
+				struct iosys_map *map)
+{
+	struct drm_i915_gem_object *obj = to_intel_bo(gem_obj);
+	void *vaddr;
+
+	vaddr = i915_gem_object_pin_map(obj, I915_MAP_WB);
+	if (IS_ERR(vaddr))
+		return PTR_ERR(vaddr);
+
+	iosys_map_set_vaddr(map, vaddr);
+
+	return 0;
+}
+
+static void i915_gem_vunmap_object(struct drm_gem_object *gem_obj,
+				   struct iosys_map *map)
+{
+	struct drm_i915_gem_object *obj = to_intel_bo(gem_obj);
+
+	i915_gem_object_flush_map(obj);
+	i915_gem_object_unpin_map(obj);
+}
+
 void i915_gem_init__objects(struct drm_i915_private *i915)
 {
 	INIT_WORK(&i915->mm.free_work, __i915_gem_free_work);
@@ -896,6 +920,8 @@ static const struct drm_gem_object_funcs i915_gem_object_funcs = {
 	.free = i915_gem_free_object,
 	.close = i915_gem_close_object,
 	.export = i915_gem_prime_export,
+	.vmap = i915_gem_vmap_object,
+	.vunmap = i915_gem_vunmap_object,
 };
 
 /**
-- 
2.45.2


