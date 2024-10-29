Return-Path: <linux-kernel+bounces-387922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB19B5804
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0E61C20D41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375F320E03D;
	Tue, 29 Oct 2024 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="s58++sij"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF620C00B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245644; cv=none; b=DBRFTvKIVnHJxsaFk/GrVhXnkOyCGMJdVKuNl8o6vgMmRXgt+KMXI2Er/+EaVRUV6xtjZg/zC3MvtNozytk1GTM9NjFF2aIHJ9XGuM70tXElIThVq9EMN4vh4Vh6hAjSDUpeJkSF0hqUbAMWtGQ/UvjFpiYawffYI6Ecr9LmtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245644; c=relaxed/simple;
	bh=QcGFaPSJct1OmkBWVCZ4OamUBIoVF3eOq0TDb8sD7Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0NoinFgj9FSJjggQwg1/P2kQ0cCAZuJMEr6fPHn9LkSplFrU/cjLQd4BZeTHvYISuxsu6JGH7jHAv7ExEqN6Y0ub0blxbnB5ZEE3gLrb0ZeGCtMsxw0odYNQ1kMRzVUQrbqels0OV3Wd6wqmdgNCLIjy3c/Rn9fF2kVF2IrouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=s58++sij; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=q6KYr6GX03M+Jc/IuwI+wp3bmGaFy8No8qY4nPfb1c0=; b=s58++sijcLeKwTXm
	wGEjJosh4SJ8wnHzmGTYDQQ4jU7F1hi45+enQfHBCmxdWlPrMHckbKGKA+EFGCy/ryNl/iFCRXFVp
	C9GSvq8lT2imZ63nzKNNZPiY3zb61zoBOuDCY8v8VPLxrOSGMlXN524qzu3DdVgRNjzag1U5xbKjD
	Wo1xsgj0aj4vGgPSssLKViHGyXsiAXzFdyDdUpV77pWiA6SbHigrNhEdU15E9DNPMev9aaNCmFCOy
	+uizTpbNfIC3kyDomfrKF/8xrbE14vORDWr2lMZ6GEa40Q0hO62EAlVNnCpJWe4izZ3ljo3kQSBHt
	T5E2nKY83xuBoqJJjA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t5vvX-00EMNX-2z;
	Tue, 29 Oct 2024 23:47:07 +0000
From: linux@treblig.org
To: dmitry.baryshkov@linaro.org,
	ville.syrjala@linux.intel.com,
	jfalempe@redhat.com,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 1/3] drm: Remove unused drm_atomic_helper_commit_planes_on_crtc
Date: Tue, 29 Oct 2024 23:47:03 +0000
Message-ID: <20241029234706.285087-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029234706.285087-1-linux@treblig.org>
References: <20241029234706.285087-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of drm_atomic_helper_commit_planes_on_crtc() was removed
in 2018 by
commit 6c246b81f938 ("drm/i915: Replace call to commit_planes_on_crtc with
internal update, v2.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 72 -----------------------------
 include/drm/drm_atomic_helper.h     |  1 -
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 43cdf39019a4..dd8f7d6f5a36 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2705,8 +2705,6 @@ static bool plane_crtc_active(const struct drm_plane_state *state)
  * crtcs need to be updated though.
  *
  * Note that this function does all plane updates across all CRTCs in one step.
- * If the hardware can't support this approach look at
- * drm_atomic_helper_commit_planes_on_crtc() instead.
  *
  * Plane parameters can be updated by applications while the associated CRTC is
  * disabled. The DRM/KMS core will store the parameters in the plane state,
@@ -2833,76 +2831,6 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_planes);
 
-/**
- * drm_atomic_helper_commit_planes_on_crtc - commit plane state for a CRTC
- * @old_crtc_state: atomic state object with the old CRTC state
- *
- * This function commits the new plane state using the plane and atomic helper
- * functions for planes on the specific CRTC. It assumes that the atomic state
- * has already been pushed into the relevant object state pointers, since this
- * step can no longer fail.
- *
- * This function is useful when plane updates should be done CRTC-by-CRTC
- * instead of one global step like drm_atomic_helper_commit_planes() does.
- *
- * This function can only be savely used when planes are not allowed to move
- * between different CRTCs because this function doesn't handle inter-CRTC
- * dependencies. Callers need to ensure that either no such dependencies exist,
- * resolve them through ordering of commit calls or through some other means.
- */
-void
-drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state)
-{
-	const struct drm_crtc_helper_funcs *crtc_funcs;
-	struct drm_crtc *crtc = old_crtc_state->crtc;
-	struct drm_atomic_state *old_state = old_crtc_state->state;
-	struct drm_crtc_state *new_crtc_state =
-		drm_atomic_get_new_crtc_state(old_state, crtc);
-	struct drm_plane *plane;
-	unsigned int plane_mask;
-
-	plane_mask = old_crtc_state->plane_mask;
-	plane_mask |= new_crtc_state->plane_mask;
-
-	crtc_funcs = crtc->helper_private;
-	if (crtc_funcs && crtc_funcs->atomic_begin)
-		crtc_funcs->atomic_begin(crtc, old_state);
-
-	drm_for_each_plane_mask(plane, crtc->dev, plane_mask) {
-		struct drm_plane_state *old_plane_state =
-			drm_atomic_get_old_plane_state(old_state, plane);
-		struct drm_plane_state *new_plane_state =
-			drm_atomic_get_new_plane_state(old_state, plane);
-		const struct drm_plane_helper_funcs *plane_funcs;
-		bool disabling;
-
-		plane_funcs = plane->helper_private;
-
-		if (!old_plane_state || !plane_funcs)
-			continue;
-
-		WARN_ON(new_plane_state->crtc &&
-			new_plane_state->crtc != crtc);
-
-		disabling = drm_atomic_plane_disabling(old_plane_state, new_plane_state);
-
-		if (disabling && plane_funcs->atomic_disable) {
-			plane_funcs->atomic_disable(plane, old_state);
-		} else if (new_plane_state->crtc || disabling) {
-			plane_funcs->atomic_update(plane, old_state);
-
-			if (!disabling && plane_funcs->atomic_enable) {
-				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))
-					plane_funcs->atomic_enable(plane, old_state);
-			}
-		}
-	}
-
-	if (crtc_funcs && crtc_funcs->atomic_flush)
-		crtc_funcs->atomic_flush(crtc, old_state);
-}
-EXPORT_SYMBOL(drm_atomic_helper_commit_planes_on_crtc);
-
 /**
  * drm_atomic_helper_disable_planes_on_crtc - helper to disable CRTC's planes
  * @old_crtc_state: atomic state object with the old CRTC state
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 9aa0a05aa072..6ad50c531fc0 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -107,7 +107,6 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 				     uint32_t flags);
 void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
 				      struct drm_atomic_state *old_state);
-void drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state);
 void
 drm_atomic_helper_disable_planes_on_crtc(struct drm_crtc_state *old_crtc_state,
 					 bool atomic);
-- 
2.47.0


