Return-Path: <linux-kernel+bounces-513188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7155A34390
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF553A37C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870D271282;
	Thu, 13 Feb 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYF4dF+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613F271277
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457882; cv=none; b=GCmJItrLuDSJB3qeZlcWotCHCyDWgl8en/1eCA9kfAgkzSjmh+OTUrR57AbPurmBKgZkzlGTkVNVkT26RwnCVwP9s8YhZtEI01kzOxtqiohgmHYOx59BvdXpVERYHRfMn5mc8LTCTwrHSvHZMr1Mb8hkdDT7SOprFPGzqjVjTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457882; c=relaxed/simple;
	bh=vkmsQVJmDiBD+o85i9Hy+FmSGOjR/a9ZS0sHiO5uueM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7KtxVwkLpROwUfh3OTFlEX53R1xWwslq3eJtnGdZgnCp5M5zGiyv96AGtJpNJ5DXbe1xAzMLG6EkidGKbjTCNRe/Ih/fLnlNJ7UqMSNsUywjSXmsYSBT+mDRTRSDi/KJeCwt18REqG4y8UuYqmgqWXYkec/zkBurTYD7aRUI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYF4dF+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9534C4CED1;
	Thu, 13 Feb 2025 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457882;
	bh=vkmsQVJmDiBD+o85i9Hy+FmSGOjR/a9ZS0sHiO5uueM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AYF4dF+CmqrAXzd45F3AsIfkxtzfnq45LsmXlgv8V9FU7jT9BeLhiE3ifNhIA23TE
	 mofh7MJcZUMKWkhp2unNX2/Z8KjC+FDSDY/ugn/8RxuZtORosOmp66XuZxxjD6utCm
	 IhPjZVnERFK8vYa+jcrJrVf14B52ie+xBEYnh2aUmi7tG2Iytdy8dHlwzWB4X3+zVA
	 1b2PuArbkT8LKjV0RzLPMwRqo/vd3BDuQ+i4ufW6Q0+h8TmrVquyz3EqverVBz+vEx
	 V0IX6VC/kFiY0i0tq8Tv4Njn/bK4TcZopnJV09T5URKBfeh7NP4Tt3uUDGOHjE7Yk+
	 eOGSepy8QvIog==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:36 +0100
Subject: [PATCH v3 17/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_modeset_enables()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-17-e71598f49c8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4126; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vkmsQVJmDiBD+o85i9Hy+FmSGOjR/a9ZS0sHiO5uueM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWGXFGBJatmRbP5wdeeTbNbE57u6Ss5lWPJkssnufg
 GHCz/8FHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAilgqMDd1Lo6STQ2NDOZ3X
 J7ow2v9cXX8l6SKH8/fdt+IDdS4sPJQr/TRSNGrik7M3mnl9j8Z0MdbZ8p86J7cs9aqFAc/GhS3
 +f2ebOVx7+r3TLO+kgvzMdFXGEzbsN2/UOt5jnTfpGq9UxSUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_helper_commit_modeset_enables() enables all outputs affected
by a new commit. It takes the drm_atomic_state being committed as a
parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index c01832d6953fc0863db7532aca909516d1796b72..1fc15d4ab096ada43969f5d9f0c74a4384208582 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1484,11 +1484,11 @@ static void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
 }
 
 /**
  * drm_atomic_helper_commit_modeset_enables - modeset commit to enable outputs
  * @dev: DRM device
- * @old_state: atomic state object with old state structures
+ * @state: atomic state object being committed
  *
  * This function enables all the outputs with the new configuration which had to
  * be turned off for the update.
  *
  * For compatibility with legacy CRTC helpers this should be called after
@@ -1496,20 +1496,20 @@ static void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
  * does. But drivers with different needs can group the modeset commits together
  * and do the plane commits at the end. This is useful for drivers doing runtime
  * PM since planes updates then only happen when the CRTC is actually enabled.
  */
 void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
-					      struct drm_atomic_state *old_state)
+					      struct drm_atomic_state *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_connector *connector;
 	struct drm_connector_state *new_conn_state;
 	int i;
 
-	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		const struct drm_crtc_helper_funcs *funcs;
 
 		/* Need to filter out CRTCs where only planes change. */
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
@@ -1521,17 +1521,17 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 
 		if (new_crtc_state->enable) {
 			drm_dbg_atomic(dev, "enabling [CRTC:%d:%s]\n",
 				       crtc->base.id, crtc->name);
 			if (funcs->atomic_enable)
-				funcs->atomic_enable(crtc, old_state);
+				funcs->atomic_enable(crtc, state);
 			else if (funcs->commit)
 				funcs->commit(crtc);
 		}
 	}
 
-	for_each_new_connector_in_state(old_state, connector, new_conn_state, i) {
+	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
 		const struct drm_encoder_helper_funcs *funcs;
 		struct drm_encoder *encoder;
 		struct drm_bridge *bridge;
 
 		if (!new_conn_state->best_encoder)
@@ -1550,25 +1550,25 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		/*
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call enable hooks twice.
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
-		drm_atomic_bridge_chain_pre_enable(bridge, old_state);
+		drm_atomic_bridge_chain_pre_enable(bridge, state);
 
 		if (funcs) {
 			if (funcs->atomic_enable)
-				funcs->atomic_enable(encoder, old_state);
+				funcs->atomic_enable(encoder, state);
 			else if (funcs->enable)
 				funcs->enable(encoder);
 			else if (funcs->commit)
 				funcs->commit(encoder);
 		}
 
-		drm_atomic_bridge_chain_enable(bridge, old_state);
+		drm_atomic_bridge_chain_enable(bridge, state);
 	}
 
-	drm_atomic_helper_commit_writebacks(dev, old_state);
+	drm_atomic_helper_commit_writebacks(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
 /*
  * For atomic updates which touch just a single CRTC, calculate the time of the

-- 
2.48.0


