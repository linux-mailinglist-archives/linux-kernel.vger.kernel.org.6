Return-Path: <linux-kernel+bounces-443827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B19EFC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98D616F587
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45461A8412;
	Thu, 12 Dec 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Mk3VbTqk"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572A18A95E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031235; cv=none; b=r3O6cz7BYLYVmUjRlEtmjQov3XNm47QOHi6c1796QVe/orE5rxyk1INlmjFH9iO630XdY3OCsDX5DhDu9gyN5ztX2qH3/gqySFzPUxIii2GpK4po59jtGLQs2X+AvxVJJeRB9f/FzS+GU4PhGYBeKPeVromwjRiCf/mjvIvgAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031235; c=relaxed/simple;
	bh=CRGZDOb8GTf+yj3B22H38kn8Dcq6iyLsNuQin0WBbso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHZUw6qf4ayQNhvrKaHj1QJNGbzfzpGtgno3qyYVenCvedsZGDZdGVXv8n20GLxBEO40eCNiUl95VGx+n85Q0kKAvf3tHyC+dhifpqv/qlM8iPa0bH/KDWf0YdmKRjnOdJr+IfwEOVoHIvkfb6S4pu8CDec7A0CRx3GhqfLJHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Mk3VbTqk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z2ipejCRyWSKv27ShitN4KY4MHhmTPh5W2J+LTJowRg=; b=Mk3VbTqksrdXuSWlApUZxWrQ84
	emq5DahrVJA8WVYeNFS5rlee5JvOMKSr7Zx1Bbzl5vEqGMxlKe2eTI5DSSgkOgzE3XC/61ehur+Yb
	q+iPttpGsVraPNhXISNtDiSdV7bFdHzgdsdJra0rUWOiwD5NBRcT32JseKjpftfBqkb/pYhECpb3e
	5qqWuKzlmGwcVLLBJvP2kTS+0rgXXsevzHEL7d2shc4uUMchDvmHfqi+q9IFz+9TyiHDEKrLotsY5
	RLcsmTWmSdZSfB39K1sicw9z1H5mWinMBIqzynlXYuyTm5liQF8a46AFWxZVDz/vOAqJ0aV5GpgIm
	gYw0rRAw==;
Received: from [179.193.1.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tLojT-002MsO-O1; Thu, 12 Dec 2024 20:20:19 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 12 Dec 2024 16:19:34 -0300
Subject: [PATCH v11 2/2] drm/amdgpu: Enable async flip on overlay planes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241212-tonyk-async_flip-v11-2-14379434be70@igalia.com>
References: <20241212-tonyk-async_flip-v11-0-14379434be70@igalia.com>
In-Reply-To: <20241212-tonyk-async_flip-v11-0-14379434be70@igalia.com>
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

amdgpu can handle async flips on overlay planes, so allow it for atomic
async checks.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426db0182cb2811bc6d5d09f52f8a4b..2792d393157beec12d6e96843c43158c03f16027 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1260,22 +1260,25 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 }
 
 static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
-					      struct drm_atomic_state *state)
+					      struct drm_atomic_state *state, bool flip)
 {
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_plane_state *new_plane_state;
 	struct dm_crtc_state *dm_new_crtc_state;
 
-	/* Only support async updates on cursor planes. */
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (flip) {
+		if (plane->type != DRM_PLANE_TYPE_OVERLAY)
+			return -EINVAL;
+	} else if (plane->type != DRM_PLANE_TYPE_CURSOR)
 		return -EINVAL;
 
 	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
 	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 	/* Reject overlay cursors for now*/
-	if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
+	if (!flip && dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
 		return -EINVAL;
+	}
 
 	return 0;
 }

-- 
2.47.1


