Return-Path: <linux-kernel+bounces-559414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F05A5F3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B043B4B45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E9266B67;
	Thu, 13 Mar 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2s5Buzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AA2673BD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867225; cv=none; b=aelPhqOsgXhNuC4E9GS9Mnxf53Rsy7hGxWu7oJbXNDNTIb9kT401+xOQA/XpjW/X82s+NAG/+zDeZiDQ/wE9cfOyPBfLUWQaTXZrZcirbfPIhF/SXxojzMrFKyeRaeSqYOXsCwBvv3ORejWXmyLnUYSqvd2C0XoXTuliSsbGyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867225; c=relaxed/simple;
	bh=PAnLIJYxHDydmOwTw9IuYZwIeZMi56vmbg2ujThGttc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sL5cyzfZF6a8nmJYDjrY58Nm9iV/ORZAElxwgSsDTzvI2XU2KFEoClzatLDMBHPGhO1Axxy+Pk32iHBaOcRcvyRJaXBXYjs5G9L+6iSGkAxdf9Gm8qI9W26nMg06zH+KT/AlLXnImpA802G6ghwzCOE7AFwqwLK0JYTfACt6aPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2s5Buzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C00BC4CEEB;
	Thu, 13 Mar 2025 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867224;
	bh=PAnLIJYxHDydmOwTw9IuYZwIeZMi56vmbg2ujThGttc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k2s5Buzdq7CDd2ia63i0yKS4oz+MwVUYe/mLRQRsM3zLPu7kSCE3ruLo31ipA8jYB
	 geAx6tB2WFEQxbWyn0SkOzBwQ1FZhOAzn2HoN8+1KiVZE+VOK8WsG9ZA2DC+qxjWFF
	 kydr8zY3QltEcro6isCRy+x2VS0KXmBV9UrBAlK/mXIfYW9gpctdY6NzdSvbn9Qsr2
	 8uKuYV19euFPJBQucxiAtqu2bRhk4z3exkf3Xgssv/B5RWr/tgbLdOkJcYRPFEkIbz
	 XkPxloGNDil8OFfezqyGapPXIoPbe31wb14kiqzO52VNbKXX/u5/47b8AWIB0zOg4O
	 g7JPciKQpMaug==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 12:59:58 +0100
Subject: [PATCH v6 04/16] drm/atomic: Introduce helper to lookup connector
 by encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-4-511c54a604fb@kernel.org>
References: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
In-Reply-To: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Simona Vetter <simona.vetter@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5933; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PAnLIJYxHDydmOwTw9IuYZwIeZMi56vmbg2ujThGttc=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThx4dudN9sn2vQemrvm7/3rql/V7xL//aK2+qxXnI
 rsqK/u4VEcpC4MYF4OsmCJLjLD5krhTs153svHNg5nDygQyhIGLUwAm0nOG4a905oY/21LTlF6s
 2CI8m3W+Ws6eKe9exO3MPnCd7eOjPH4Whj8cso2rfXseh7TUuveIrTomJeuzXz6ii7lJpbb6y4d
 9bowA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

With the bridges switching over to drm_bridge_connector, the direct
association between a bridge driver and its connector was lost.

This is mitigated for atomic bridge drivers by the fact you can access
the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.

This was also made easier by providing drm_atomic_state directly to all
atomic hooks bridges can implement.

However, bridge drivers don't have a way to access drm_atomic_state
outside of the modeset path, like from the hotplug interrupt path or any
interrupt handler.

Let's introduce a function to retrieve the connector currently assigned
to an encoder, without using drm_atomic_state, to make these drivers'
life easier.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Tested-by: Herve Codina <herve.codina@bootlin.com>
Co-developed-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9ea2611770f43ce7ccba410406d5f2c528aab022..0138cf0b8b630dcf86bac7113db0401fa6b45633 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -931,10 +931,13 @@ EXPORT_SYMBOL(drm_atomic_get_new_private_obj_state);
  * case, it is sometimes useful to differentiate commits which had no prior
  * connectors attached to @encoder vs ones that did (and to inspect their
  * state). This is especially true in enable hooks because the pipeline has
  * changed.
  *
+ * If you don't have access to the atomic state, see
+ * drm_atomic_get_connector_for_encoder().
+ *
  * Returns: The old connector connected to @encoder, or NULL if the encoder is
  * not connected.
  */
 struct drm_connector *
 drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_state *state,
@@ -965,10 +968,13 @@ EXPORT_SYMBOL(drm_atomic_get_old_connector_for_encoder);
  * this function will return NULL. While this may seem like an invalid use case,
  * it is sometimes useful to differentiate commits which have no connectors
  * attached to @encoder vs ones that do (and to inspect their state). This is
  * especially true in disable hooks because the pipeline will change.
  *
+ * If you don't have access to the atomic state, see
+ * drm_atomic_get_connector_for_encoder().
+ *
  * Returns: The new connector connected to @encoder, or NULL if the encoder is
  * not connected.
  */
 struct drm_connector *
 drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
@@ -985,10 +991,63 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
 
 	return NULL;
 }
 EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
 
+/**
+ * drm_atomic_get_connector_for_encoder - Get connector currently assigned to an encoder
+ * @encoder: The encoder to find the connector of
+ * @ctx: Modeset locking context
+ *
+ * This function finds and returns the connector currently assigned to
+ * an @encoder.
+ *
+ * It is similar to the drm_atomic_get_old_connector_for_encoder() and
+ * drm_atomic_get_new_connector_for_encoder() helpers, but doesn't
+ * require access to the atomic state. If you have access to it, prefer
+ * using these. This helper is typically useful in situations where you
+ * don't have access to the atomic state, like detect, link repair,
+ * threaded interrupt handlers, or hooks from other frameworks (ALSA,
+ * CEC, etc.).
+ *
+ * Returns:
+ * The connector connected to @encoder, or an error pointer otherwise.
+ * When the error is EDEADLK, a deadlock has been detected and the
+ * sequence must be restarted.
+ */
+struct drm_connector *
+drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
+				     struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
+	struct drm_connector *connector;
+	struct drm_device *dev = encoder->dev;
+	int ret;
+
+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->state)
+			continue;
+
+		if (encoder == connector->state->best_encoder) {
+			out_connector = connector;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	return out_connector;
+}
+EXPORT_SYMBOL(drm_atomic_get_connector_for_encoder);
+
+
 /**
  * drm_atomic_get_old_crtc_for_encoder - Get old crtc for an encoder
  * @state: Atomic state
  * @encoder: The encoder to fetch the crtc state for
  *
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 4c673f0698fef6b60f77db980378d5e88e0e250e..38636a593c9d98cadda85ccd67326cb152f0dd27 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -623,10 +623,13 @@ struct drm_connector *
 drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_state *state,
 					 struct drm_encoder *encoder);
 struct drm_connector *
 drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
 					 struct drm_encoder *encoder);
+struct drm_connector *
+drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
+				     struct drm_modeset_acquire_ctx *ctx);
 
 struct drm_crtc *
 drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
 					 struct drm_encoder *encoder);
 struct drm_crtc *

-- 
2.48.1


