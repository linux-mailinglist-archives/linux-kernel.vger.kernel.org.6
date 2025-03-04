Return-Path: <linux-kernel+bounces-543974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9969AA4DC11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF81759F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFA1FFC70;
	Tue,  4 Mar 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlUcn2Sc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E81FFC69
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086674; cv=none; b=VcP+dfjK7slsSGvvOQk9wLlACtXh1dieYlwlr7wNlsyFZTsrchoA1G/dLSEP/eauo7i2MAGLQG3kmolbXIyk0cFzg2NM+B4RpxErJZgwAAi5mN/qoSMHiQ/jo/vjK1p0VUymfKYJe9DvgUj9W1n/oyY8gWeRHF67fxR2Vcq08Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086674; c=relaxed/simple;
	bh=c4enJvuOsjuBvzTrNIZ2FxCNV61d34aGwAuZ5+78ldc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTSpzz37iuHXAFTyvI4Bdvvd87jSqBtvcmcA8M+QI73jOsuQLGMESrav22U30h06IRQ7GPlnEUscEQglIggZN53Rq/u2U0mGjGq2YpYbstIjzBLBFir1Gc4W1Cv35CYfziLioFgQfg7Px5KNV9RF3KNEHsA6BPdOO4JlqWz6trU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlUcn2Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B284BC4CEE9;
	Tue,  4 Mar 2025 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741086674;
	bh=c4enJvuOsjuBvzTrNIZ2FxCNV61d34aGwAuZ5+78ldc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IlUcn2ScgUy9KR/oJfbOxixGN0FWE3B/0MUVCO6R3UROgMQMBC/SKNb67ARz5SRcQ
	 qGn6236wbMwiMHaq4NYCZhv5mmWNl2FFqSaREN8joS08j0V0hJoj2VBE68jJ7AJ/vd
	 YsIQFVygUE+BsOVq92Lz+wxbnMsVjxDUUlxlKrYjQM8CL0XAFMyu14eXELzUFOyZdW
	 61z4zaryZ78nio5l9tJyW/A/ItRMLY2dCGceo/uVum9RzjfP9Jf7FuwQZtoK98sKbv
	 uVpLol2i7lmfd9g62Om5qmuCBI/oDrNkVKKLFHF5HX+VzWFOvR/0AOo1wt6nyHAP95
	 ZOSDYVtOKMlQA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 04 Mar 2025 12:10:47 +0100
Subject: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup connector
 by encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
In-Reply-To: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
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
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3956; i=mripard@kernel.org;
 h=from:subject:message-id; bh=c4enJvuOsjuBvzTrNIZ2FxCNV61d34aGwAuZ5+78ldc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnH7u87zeTCsfRr3WnboyVdUqFZ5Qv649TX/3fTctP+O
 GGu5fMJHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiVQ2MDT+Onn7EwWNvl3v6
 hMut385Pgr7GTxQ8tZXllLjLpzliKs+qEr+2X9hfnpgq25cQIfk6k7Hh8q7Q2C0fSw5EBk/9NTM
 g6VOc2zrrgM3rhELdp6hvsmaJuXqudffCTX7OMV32GbZOqUYA
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
Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41d48eb4da4bccf170ee236 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
 
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


