Return-Path: <linux-kernel+bounces-531932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD49A446BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6453B7AEEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83D19EED3;
	Tue, 25 Feb 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdu7lTz+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2819E966
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501865; cv=none; b=jagx9OVfEhRYZeFabKdr5YMdXKGC3vtmVi8GZze/rp1e4VnzTbJZ1NpcWHlNQxDbik2ewlw55sqzboxPWWU+Sk7fzTYMoXU81QoJQEMKB2On4SMf6E2o8eFg19rEF2QGN7DmXHoiDR3xTzjUEmcpJ4B5MR49bMMqz1pCnpIAXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501865; c=relaxed/simple;
	bh=0pHBWiLF7FqmjJ3t9kErg7VKqqz+a8+rLeHPnlasuq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfKYeMmPysZ/e7DPFmsC1/BvX0l8lVAMoTmxILpgbFftqhJ1EOfOsP2kCzDFw/qBusYfrxgqtY3CUFxbiZTHaPZ/KsaMazh+I3hNr4wqdfEmAdVok05KPXSEYoLAqkZdKpgj73usmQdtPKKAzeWaL5pR7nptIvT8J6GMGbNF1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdu7lTz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B93C4CEDD;
	Tue, 25 Feb 2025 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501864;
	bh=0pHBWiLF7FqmjJ3t9kErg7VKqqz+a8+rLeHPnlasuq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cdu7lTz+aDSKRdhXzfJxaoO2IV/uIlDgon3ntQorvzZfNFgigr9MD/RYYVz6zdUYx
	 RtT1bvPzds1rjiSqdLWf8F66jM6jszGa+OKasrICq+ttBpXG64mrUK5NNnfHuhkPI7
	 kuZzaNvL3cZDRwpSOzlGGJwFvW9/X+RZ9/rcfjRTMSvFqbiWxkoyPhdvfBkq5fiI9Q
	 Ciu9vGWpHyNAMyZyfp1+P0w0SbHOPVvUCHThVKvyAvVLwaNEVLtNhZaN6PqdbSjhYy
	 So8lXa0LZkryxdPM+0ue7WH8BScHxABOXaTy/ZL7R3kR1VS5WEF/cbKqjTMOA+tt1x
	 1qoU9jiJDYgEQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:43:55 +0100
Subject: [PATCH v4 07/15] drm/bridge: Add helper to reset bridge pipeline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-7-7ecb07b09cad@kernel.org>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
In-Reply-To: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3397; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0pHBWiLF7FqmjJ3t9kErg7VKqqz+a8+rLeHPnlasuq4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P/vunr+w4Hi045a/dqXFTic3Vz6PjbmoY3bSgklqe
 XR/2HyDjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR16GM9aXR5Znrlj2f63Xr
 GONe/b3CwUE5OhdYPuYnOmzo/Xbf91ul1vYt1V2ftM5tY8+2mtZ0h7Hed1n3u1ltD99+WLq7LXn
 y/L5T5w/vzL/3JebwKo9Nl5Ijc66fuLaQSY7FjrUgoE9MRqsDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Let's provide an helper to make it easier for bridge drivers to
power-cycle their bridge.

Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8241c00e4506eceeb9bb4ba74a38d8f360c65d38..ca894531a2042fc9296c40a1f51a6cdea6e97ed7 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -24,10 +24,11 @@
 #include <linux/err.h>
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
@@ -1269,10 +1270,53 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 		bridge->hpd_cb(bridge->hpd_data, status);
 	mutex_unlock(&bridge->hpd_mutex);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
 
+/**
+ * drm_bridge_reset_crtc - Reset the pipeline feeding a bridge
+ * @bridge: DRM bridge to reset
+ * @ctx: lock acquisition context
+ *
+ * Reset a @bridge pipeline. It will power-cycle all active components
+ * between the CRTC and connector that bridge is connected to.
+ *
+ * Returns:
+ *
+ * 0 on success or a negative error code on failure. If the error
+ * returned is EDEADLK, the whole atomic sequence must be restarted.
+ */
+int drm_bridge_reset_crtc(struct drm_bridge *bridge,
+			  struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_connector *connector;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_device *dev = encoder->dev;
+	struct drm_crtc *crtc;
+	int ret;
+
+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
+	if (ret)
+		return ret;
+
+	connector = drm_atomic_get_connector_for_encoder(encoder, ctx);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
+		goto out;
+	}
+
+	crtc = connector->state->crtc;
+	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
+	if (ret)
+		goto out;
+
+out:
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(drm_bridge_reset_crtc);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
  *			the global bridge list
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 6fb1da7c195e99143a67a999d16fe361c1e3f4ab..32169e62463bb268a281a5903c0c9f448a1042b3 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1085,10 +1085,12 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 				      enum drm_connector_status status),
 			   void *data);
 void drm_bridge_hpd_disable(struct drm_bridge *bridge);
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
+int drm_bridge_reset_crtc(struct drm_bridge *bridge,
+			  struct drm_modeset_acquire_ctx *ctx);
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,

-- 
2.48.1


