Return-Path: <linux-kernel+bounces-392713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5099B975E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7972F2812C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF511CEAC2;
	Fri,  1 Nov 2024 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wfz/pUwM"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1F1C9DCE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485454; cv=none; b=MFIrUyj4yPQE+YLHC2VCV5kx/0oW6NsL2xHtBgxgMRr5GL51dPXgOSak8H7rqprXqdeYxsTlWeF9kOj36RR2JTBjkz2Zs8/hgyBFRhJPVvKoXD5el+rIkwgLSz0MiD1+EplB38/pbf4Oc2DXTn47lbKGuPK/oVTNN9TkQEV29Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485454; c=relaxed/simple;
	bh=eOfoHIS7ai+DrUPiw1CA0yLTfVi2UBFNInB44MAA1ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAFifGvMSeGfongtv3K4ZpPZXS2c5vzFg8QTV6CZVdY9vQT6GUUwz78SYpqvIXPfsUd1bnbF8olE9D8fs29KTlfzHQNdX63WpfWmX/d/ztML8MA7Cy2jZDh/sincMz/OJCLrL3L3ldvN0S0sSZmpZ394Bh212gf87r5WGLSewso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wfz/pUwM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJ2HTplSW4KwnXcLWKk3RlCjYiAPM3moOM2p6p61nbM=; b=Wfz/pUwMiF+BndkF0k3J32+OLP
	TOWTgToX6zRjB250vlrB80A8BQo2l3GfvA1QABpgXdsGNyZOVQrhfk/R5jXG5EaPVI/3g0s4ueSxR
	uloPxwNWJ4PSjLCAD/W/Lfh1wctsD0VZ2axNSR7t7mDdavc8p53tEMncvUmwG+baoTBDWovQB2JSS
	32vxN75lK8gif52j7YOmUn0QInkRLXhjTz2zrI+BBEyHNvhPH8dqJwt/ZJNg6eMxHfmzzCh9f6Xeq
	JquaI6IzPaKt5MchNsjSwkXBvBfjWodRi2iZLMtyHPpRUYL8af66LlzoQjaQ3y7HY/emPn+a+3pks
	CLs2mOgA==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6wJd-000XDx-Ie; Fri, 01 Nov 2024 19:24:09 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 01 Nov 2024 15:23:47 -0300
Subject: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which planes
 to async flip
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
In-Reply-To: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, dmitry.baryshkov@linaro.org, 
 Simon Ser <contact@emersion.fr>, joshua@froggi.es, 
 Xaver Hugl <xaver.hugl@gmail.com>, Daniel Stone <daniel@fooishbar.org>, 
 ville.syrjala@linux.intel.com
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Currently, DRM atomic uAPI allows only primary planes to be flipped
asynchronously. However, each driver might be able to perform async
flips in other different plane types. To enable drivers to set their own
restrictions on which type of plane they can or cannot flip, use the
existing atomic_async_check() from struct drm_plane_helper_funcs to
enhance this flexibility, thus allowing different plane types to be able
to do async flips as well.

In order to prevent regressions and such, we keep the current policy: we
skip the driver check for the primary plane, because it is always
allowed to do async flips on it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v8:
- Rebased on top of 6.12-rc1
---
 drivers/gpu/drm/drm_atomic_uapi.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 370dc676e3aa543c9827b50df20df78f02b738c9..a0120df4b63e6b3419b53eb3d3673882559501c6 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -27,8 +27,9 @@
  * Daniel Vetter <daniel.vetter@ffwll.ch>
  */
 
-#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -1063,6 +1064,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 		struct drm_plane *plane = obj_to_plane(obj);
 		struct drm_plane_state *plane_state;
 		struct drm_mode_config *config = &plane->dev->mode_config;
+		const struct drm_plane_helper_funcs *plane_funcs = plane->helper_private;
 
 		plane_state = drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {
@@ -1070,15 +1072,32 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip &&
-		    (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY ||
-		     (prop != config->prop_fb_id &&
-		      prop != config->prop_in_fence_fd &&
-		      prop != config->prop_fb_damage_clips))) {
-			ret = drm_atomic_plane_get_property(plane, plane_state,
-							    prop, &old_val);
-			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
-			break;
+		if (async_flip) {
+			/* check if the prop does a nop change */
+			if ((plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) ||
+			    (prop != config->prop_fb_id &&
+			     prop != config->prop_in_fence_fd &&
+			     prop != config->prop_fb_damage_clips)) {
+				ret = drm_atomic_plane_get_property(plane, plane_state,
+								    prop, &old_val);
+				ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+				break;
+			}
+
+			/* ask the driver if this non-primary plane is supported */
+			if (plane->type != DRM_PLANE_TYPE_PRIMARY) {
+				ret = -EINVAL;
+
+				if (plane_funcs && plane_funcs->atomic_async_check)
+					ret = plane_funcs->atomic_async_check(plane, state);
+
+				if (ret) {
+					drm_dbg_atomic(prop->dev,
+						       "[PLANE:%d] does not support async flips\n",
+						       obj->id);
+					break;
+				}
+			}
 		}
 
 		ret = drm_atomic_plane_set_property(plane,

-- 
2.47.0


