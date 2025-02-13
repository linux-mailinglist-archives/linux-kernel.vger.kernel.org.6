Return-Path: <linux-kernel+bounces-513181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF89A34374
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5291893D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268852222B1;
	Thu, 13 Feb 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHd1dwwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA24502A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457863; cv=none; b=MD5/7rpJtCU4eLXEnVebxM1cFeeQnZhHr1wDigpbvmKb8CjKPPBfQMoGYw9+HrfY39qqJ7FFJdlpTusP4TKGx6NZryFAfPQ9bLYULr4rXT9yPhb6VynUQ9vq/7tJDUgP3MQcE3VuxJSvhynJj7Mv3hxT1M2XwdbHdlevR5ZYpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457863; c=relaxed/simple;
	bh=5CvWOl1z7nMVTEJUfcpuXVWnspcQOUwXQCb4ZCyqRHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKZrghc+4MZV4VXUrPGfir8Hc0QZVwj/l2CTRKLP2k2fSedFod29SOmw45XvFHFqagw+h+BDUev8yZBHchP7Xaye0hCljgND50vQRMa5g+fkYhk1ncsQ4oYnoPGgjNX+M1Um8V2PX/WjXZeVIP7xqvW/F84tSDfiSmg4eLmzN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHd1dwwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB45C4CED1;
	Thu, 13 Feb 2025 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457863;
	bh=5CvWOl1z7nMVTEJUfcpuXVWnspcQOUwXQCb4ZCyqRHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KHd1dwwvUwnVMt46yub1eZbG686jmsY6xmWoSwbZphdIIRmFQMhO9zmnhaDzaQ+K5
	 7WPT/4RM45DvnL8avn67wwrDvFlHXau483h1u77NpfljAtC5KjsyM+O+jXOW8+GDT3
	 yWXc1gJq/ObtosVVu5og6bHQobGu18jFEic+9d2dhRtWEOu9salAPiqXKEdMCT5Mps
	 tus9MDF2eH8XXrgH72f5E5tnS2MKxfZjrEV05bN7Fz2cKuy8uTNtecDsXy+cFx7no3
	 INWqC5tdPtFC8WAPiA85f7WCpp1I9qiH1OM/1iejaLUYEp+hJ/HcH/mKOswbsONtNB
	 qkR/jkP7ImHiQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:29 +0100
Subject: [PATCH v3 10/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_modeset_disables()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-10-e71598f49c8f@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5CvWOl1z7nMVTEJUfcpuXVWnspcQOUwXQCb4ZCyqRHA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWKXO7Wu42KWcY+izVyl3jfDVOt/eyY5/7m4NuR9TF
 6NygvVrx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI4T7Ghs2Jcn9eL5/x6ao3
 X0OiWqnpU/4z59T/LxR9+NTZZDW/5qLgYwqygSF8L588nLp589M4EcY6PZdJsy4e3/fQfELg7hg
 NUUGGnXNWMOx5ssNo7nVV4TtWWTbai5L+xAW57OZkrFqRfVQQAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_helper_modeset_disables() disables all the outputs affected
by a commit. It takes the drm_atomic_state being committed as a
parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index e5484ed31cae24700ff64ccbe67c570bf46b8ddd..3d66626273245c3db42325ab5f5527fb4214e92b 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1437,11 +1437,11 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 }
 
 /**
  * drm_atomic_helper_commit_modeset_disables - modeset commit to disable outputs
  * @dev: DRM device
- * @old_state: atomic state object with old state structures
+ * @state: atomic state object being committed
  *
  * This function shuts down all the outputs that need to be shut down and
  * prepares them (if required) with the new mode.
  *
  * For compatibility with legacy CRTC helpers this should be called before
@@ -1449,18 +1449,18 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
  * does. But drivers with different needs can group the modeset commits together
  * and do the plane commits at the end. This is useful for drivers doing runtime
  * PM since planes updates then only happen when the CRTC is actually enabled.
  */
 void drm_atomic_helper_commit_modeset_disables(struct drm_device *dev,
-					       struct drm_atomic_state *old_state)
+					       struct drm_atomic_state *state)
 {
-	disable_outputs(dev, old_state);
+	disable_outputs(dev, state);
 
-	drm_atomic_helper_update_legacy_modeset_state(dev, old_state);
-	drm_atomic_helper_calc_timestamping_constants(old_state);
+	drm_atomic_helper_update_legacy_modeset_state(dev, state);
+	drm_atomic_helper_calc_timestamping_constants(state);
 
-	crtc_set_mode(dev, old_state);
+	crtc_set_mode(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_disables);
 
 static void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
 						struct drm_atomic_state *old_state)

-- 
2.48.0


