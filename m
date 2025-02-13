Return-Path: <linux-kernel+bounces-513187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3647A34380
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A6F188456A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470227126D;
	Thu, 13 Feb 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkvwo92Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F07271264
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457879; cv=none; b=WpJGxYunjK6pKYAjqtPbfqOFGGOtGnYReVuI900sPYM8vpyAgrPkzr4mLysmOQwfKYUOmrg3YIZG+TqX0i7g0Et5DezJ+UYOj5Xy0cm5Oz7ZC5FLpU1ASTDiDO+OLKab7jxbmUjxshjjuBzGZFJ0u0iOhrq37KCrf8Vc5ye/6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457879; c=relaxed/simple;
	bh=4nUqhJjigGGbt2walxpWzZ8GLT1mDjsNHKrAmKMJ+KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5bqDw/msr+i7t+7i4qwIxxQs1hd9Jlaw6KhRVHupyUmMOXxEtSN8Rwf0qFpKCDdNoXQBxt7m+HM/9Enut4mXcNO+3ytkshvn+cYb5sB/v32WkBY38H9EzL1f1/l0fvd9JpdCAXbRioQKhIVFB3GtYO9p3tbF78LvJwStztrGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkvwo92Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272A4C4CED1;
	Thu, 13 Feb 2025 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457879;
	bh=4nUqhJjigGGbt2walxpWzZ8GLT1mDjsNHKrAmKMJ+KA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fkvwo92ZrSTCE+IxeQg2PsKqN+qRPe0omBnTtbpffofZi2yhhCHVuVpsgO5lotLq7
	 ytcUnBRaTOO1/6HKleJpnhwGO4P4mEA6E9LdCQtZUOaR/JoYpzdFPkxswubekykw9b
	 N69dD5v6brS2j5CMkhptHX9//StPSvdpjejTAWeIzmge/Me+uXawLvWoczY3ruVwgS
	 AWQF96/KGXrj4UMfuMs8i3HsyRWy2X30c+WFGpBn/oWv5ch3gQbcQhpKbTQsPTQd14
	 IwCcvFOtjxL2kCa2CeTo9X/5mlw62F+Fg5CSF2v5dM5io8Bw/iKHNqJMHOnC5uCEEh
	 ZW9IjYp6ZH41g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:35 +0100
Subject: [PATCH v3 16/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_planes()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-16-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4891; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4nUqhJjigGGbt2walxpWzZ8GLT1mDjsNHKrAmKMJ+KA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWGWnng879/zu26dmWWkPy3IY9wYLMIW/cmWc2s6uu
 jRcMOdbx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI7VbG+pzrMxPZJYoZA6YJ
 Cp3rOlHvVNmwcBb7gdfWr6stFh+37fbe+NvN2u3l+Re/2Zq2RyarMzZ8viBwUM82ZtcDu3vXq1l
 PLvKpSpWOCu3/s1hka9Ivh20Gj84vMTRgU7u2+tMDwRUrrzYDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_helper_commit_planes() updates all planes affected by a new
commit. It takes the drm_atomic_state being committed as a parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6ca8bf5f433c9c93981f808ac1cb60a442674f78..c01832d6953fc0863db7532aca909516d1796b72 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2729,19 +2729,19 @@ static bool plane_crtc_active(const struct drm_plane_state *state)
 }
 
 /**
  * drm_atomic_helper_commit_planes - commit plane state
  * @dev: DRM device
- * @old_state: atomic state object with old state structures
+ * @state: atomic state object being committed
  * @flags: flags for committing plane state
  *
  * This function commits the new plane state using the plane and atomic helper
  * functions for planes and CRTCs. It assumes that the atomic state has already
  * been pushed into the relevant object state pointers, since this step can no
  * longer fail.
  *
- * It still requires the global state object @old_state to know which planes and
+ * It still requires the global state object @state to know which planes and
  * crtcs need to be updated though.
  *
  * Note that this function does all plane updates across all CRTCs in one step.
  * If the hardware can't support this approach look at
  * drm_atomic_helper_commit_planes_on_crtc() instead.
@@ -2768,36 +2768,36 @@ static bool plane_crtc_active(const struct drm_plane_state *state)
  * The drm_atomic_helper_commit() default implementation doesn't set the
  * ACTIVE_ONLY flag to most closely match the behaviour of the legacy helpers.
  * This should not be copied blindly by drivers.
  */
 void drm_atomic_helper_commit_planes(struct drm_device *dev,
-				     struct drm_atomic_state *old_state,
+				     struct drm_atomic_state *state,
 				     uint32_t flags)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	int i;
 	bool active_only = flags & DRM_PLANE_COMMIT_ACTIVE_ONLY;
 	bool no_disable = flags & DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET;
 
-	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		const struct drm_crtc_helper_funcs *funcs;
 
 		funcs = crtc->helper_private;
 
 		if (!funcs || !funcs->atomic_begin)
 			continue;
 
 		if (active_only && !new_crtc_state->active)
 			continue;
 
-		funcs->atomic_begin(crtc, old_state);
+		funcs->atomic_begin(crtc, state);
 	}
 
-	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
 		const struct drm_plane_helper_funcs *funcs;
 		bool disabling;
 
 		funcs = plane->helper_private;
 
@@ -2831,40 +2831,40 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 
 			if (drm_atomic_crtc_needs_modeset(crtc_state) &&
 			    no_disable)
 				continue;
 
-			funcs->atomic_disable(plane, old_state);
+			funcs->atomic_disable(plane, state);
 		} else if (new_plane_state->crtc || disabling) {
-			funcs->atomic_update(plane, old_state);
+			funcs->atomic_update(plane, state);
 
 			if (!disabling && funcs->atomic_enable) {
 				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))
-					funcs->atomic_enable(plane, old_state);
+					funcs->atomic_enable(plane, state);
 			}
 		}
 	}
 
-	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		const struct drm_crtc_helper_funcs *funcs;
 
 		funcs = crtc->helper_private;
 
 		if (!funcs || !funcs->atomic_flush)
 			continue;
 
 		if (active_only && !new_crtc_state->active)
 			continue;
 
-		funcs->atomic_flush(crtc, old_state);
+		funcs->atomic_flush(crtc, state);
 	}
 
 	/*
 	 * Signal end of framebuffer access here before hw_done. After hw_done,
 	 * a later commit might have already released the plane state.
 	 */
-	for_each_old_plane_in_state(old_state, plane, old_plane_state, i) {
+	for_each_old_plane_in_state(state, plane, old_plane_state, i) {
 		const struct drm_plane_helper_funcs *funcs = plane->helper_private;
 
 		if (funcs->end_fb_access)
 			funcs->end_fb_access(plane, old_plane_state);
 	}

-- 
2.48.0


