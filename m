Return-Path: <linux-kernel+bounces-543978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31ECA4DC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDAC17739F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3E201256;
	Tue,  4 Mar 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK+NjEmm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330C20124F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086685; cv=none; b=mLXL+e4hnWlbMYXPijLNBUfyk9pMfeWWKQi42ebArYukVPYawOJ4EZzpFP+ubz1I1z1kYbcjdPITD3o8xUEvQy2UnnreFSTKt8tuyO/r1neoJEgvbJzy1qx1NKHZFUNbfUDUF0frBHrffTKTk3cR5NTL/kSQ5e6ykChIkPdf0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086685; c=relaxed/simple;
	bh=Xt3tyJYOhvKRkneUvpuVFBQt7kxeuH06uiim8XR86PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqoecoHVqawRJPZnOAq1qXMFsQ6AnEGRyKPRT5viDD+6MsPfR13DrGpB4LkjFeuosZlkJ/2pzO/iL7aeBUlpDrxqlpMMBsnCn5+bOvuuWq8x85Ox71krDacD3XjWzHFkobwVUpXNd7etPSDqZrXSmw12QXor5x9Q0Oo5TjTGiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK+NjEmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A02C4CEEC;
	Tue,  4 Mar 2025 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741086684;
	bh=Xt3tyJYOhvKRkneUvpuVFBQt7kxeuH06uiim8XR86PY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MK+NjEmm/Dw4ZX3fI1zVULGQFMfi2ghzwqaqWDkQEZrdT1Wwb3mOqlH1MDPQQ1CgZ
	 ijbeqw/G5nkKnWMZG1oyCK6FDyUFMUDLDGy2C62bfu0TVx9x8MOSyGkYe1E/a1IXsF
	 LbzApN17PjjX5abvl0VkO3uIDCPAIyPOIFJ+6+detlyxhGEfPZSXmecwzfpN4xF33E
	 dAdbHHO1uuuQAxa6JQ4cIzSBnlZlntVBpf9CgRGXdQPvlyZihHrT5JVRly6GMa3mSO
	 dyfjjtUb38xKvFwkZ22NoCKayMrcL7RZtD15Yi20IOJY5yyrP5DVw0L8TYKqZo6Cxj
	 ql3rgj3i/eLng==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 04 Mar 2025 12:10:51 +0100
Subject: [PATCH v5 08/16] drm/bridge: Add helper to reset bridge pipeline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bridge-connector-v5-8-aacf461d2157@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Xt3tyJYOhvKRkneUvpuVFBQt7kxeuH06uiim8XR86PY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnH7u+3iAu7/J7B4azGRXfN1H0r120t4PkreXBeZfmPS
 n2+jd2XOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEzixhbLjJciVtpe3OHx19
 80RPFF4V2LR9TVDlSWX/QlZp5z5fX46+ivrkl4yL+sqlNpZI354ayVjvKiAb+cB4+9k6b/+TlU9
 U7k8MWZ33SDv35L2cKNN/q3y5U3rZ4nTbYzuO3bQ/YWJ96h4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Let's provide an helper to make it easier for bridge drivers to
power-cycle their bridge.

In order to avoid a circular dependency between that new helper and
drm_atomic_helper_reset_crtc(), this new helper will be in a
drm_bridge_helper.c file to follow the pattern we have for other
objects.

Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/Makefile            |  1 +
 drivers/gpu/drm/drm_bridge_helper.c | 55 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge_helper.h     | 12 ++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 4cd054188faf0b3dec442efd99ae52604541bce1..5a332f7d3ecccb6e5e1fb9fb811eab7aa5a84a21 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -131,10 +131,11 @@ obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
 #
 
 drm_kms_helper-y := \
 	drm_atomic_helper.o \
 	drm_atomic_state_helper.o \
+	drm_bridge_helper.o \
 	drm_crtc_helper.o \
 	drm_damage_helper.o \
 	drm_flip_work.o \
 	drm_format_helper.o \
 	drm_gem_atomic_helper.o \
diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_bridge_helper.c
new file mode 100644
index 0000000000000000000000000000000000000000..521df9d5dcb3fef842a95cdb2865a8b8d09b0fbe
--- /dev/null
+++ b/drivers/gpu/drm/drm_bridge_helper.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_helper.h>
+#include <drm/drm_modeset_lock.h>
+
+/**
+ * drm_bridge_helper_reset_crtc - Reset the pipeline feeding a bridge
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
+int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
+				 struct drm_modeset_acquire_ctx *ctx)
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
+	if (!connector->state) {
+		ret = -EINVAL;
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
+EXPORT_SYMBOL(drm_bridge_helper_reset_crtc);
diff --git a/include/drm/drm_bridge_helper.h b/include/drm/drm_bridge_helper.h
new file mode 100644
index 0000000000000000000000000000000000000000..6c35b479ec2a84aa43283351a6f18e49a9f9c177
--- /dev/null
+++ b/include/drm/drm_bridge_helper.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __DRM_BRIDGE_HELPER_H_
+#define __DRM_BRIDGE_HELPER_H_
+
+struct drm_bridge;
+struct drm_modeset_acquire_ctx;
+
+int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
+				 struct drm_modeset_acquire_ctx *ctx);
+
+#endif // __DRM_BRIDGE_HELPER_H_

-- 
2.48.1


