Return-Path: <linux-kernel+bounces-531931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38334A446DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C94C17DE18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889719D898;
	Tue, 25 Feb 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPgHSTZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7519D090
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501862; cv=none; b=HClJbVgoU/jQjguHUJYSd1GZ+HvPHnjb36nKau13c7Ht2vuknfRTgNOqb9ZUppYUGQ+F78Mg3Y53Ef4GE4RDQIW8q78d/X7W1TtJU3yCZJpwtk+aOGHYO44V1UKZXCpdpyhCr6rKmUzqZBzCwLAqezh2szV0jVNKGhaPMjD2rRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501862; c=relaxed/simple;
	bh=YFMDXBuU+KtKk4l46IJbNkqHIHU2gK0Gq6lgEuBglcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4vtT+vg7EeRv6mD01OmLadqukv9dfgG3zGlMlNqF/T8nUrlWLonWQ5R3EEpu10sj3GFQXMpw22N1NdTN0fVlYq8Nue3WT0DxiDG81kR6qQUMFEkwBqKLeMrBjlnsCYJlTpL5Te+n07PshOk+8xBwDz5j0rOCxpTAsxpyny7L/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPgHSTZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C8DC4CEE8;
	Tue, 25 Feb 2025 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501861;
	bh=YFMDXBuU+KtKk4l46IJbNkqHIHU2gK0Gq6lgEuBglcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tPgHSTZ1vHzcHcIzf/cdZe9tzxwqIRZniQTvJ/IGE2ZwdHrkF/bmUlBPBw8ds4psv
	 RH4DwHBkgVrEltHlwjCTYWnFO/f/4hgHK6ueyTvACEsLMIHEn25It6znCatQ+nTTDT
	 7BDzqf2uwVWwn1YUF6+xkztt0N/tJCP120usYmUDUVS9EWuPXH3eMLNsuOsDMkerIT
	 tXiYVdg5YtlvZHU0RDfWJjhz/NZc0TVPOuevupDz8NSg4kVFoKgJPesdila0e1EcPl
	 xBQTRFt6Xp9SkgFXXGc0wWVqWqHdUpZWfpNSxq/m9je53SOT+rlZ5B1hARU/Kua0NR
	 M7S/AGHXdt9gA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:43:54 +0100
Subject: [PATCH v4 06/15] drm/tests: Create tests for drm_atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-6-7ecb07b09cad@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5572; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YFMDXBuU+KtKk4l46IJbNkqHIHU2gK0Gq6lgEuBglcs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P/sYpZz/r+cTbRXJoXmxuae98aGPk0pkQG6uZpekk
 LWf7faOqSwMwpwMsmKKLE9kwk4vb19c5WC/8gfMHFYmkCEMXJwCMBHLTsb6HFdl/YAPO1P2BNmW
 fe/XLzHis+RR23b6VnyxnOjKaa4/N/2elJ8T0FM/ecfSdw0bDyozNnwSZPi70KOKSf3XRR22sqy
 Dv6uD/67Vty9v0387qWb2ineGM/jel6rv23lkubuE3u+f+wE=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We don't have a set of kunit tests for the functions under drm_atomic.h.
Let's use the introduction of drm_atomic_get_connector_for_encoder() to
create some tests for it and thus create that set.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/Makefile          |   1 +
 drivers/gpu/drm/tests/drm_atomic_test.c | 153 ++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 6691c577d2d4581a4185bac2ce89a6b14b339b35..3afd6587df0831a0d10e91ff0a584af6ba1813e4 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -2,10 +2,11 @@
 
 obj-$(CONFIG_DRM_KUNIT_TEST_HELPERS) += \
 	drm_kunit_helpers.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += \
+	drm_atomic_test.o \
 	drm_atomic_state_test.o \
 	drm_bridge_test.o \
 	drm_buddy_test.o \
 	drm_cmdline_parser_test.o \
 	drm_connector_test.o \
diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/tests/drm_atomic_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..ea91bec6569e688ad33149d8ee6ecc3562b61254
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_atomic_test.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit test for drm_atomic functions
+ */
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_atomic_uapi.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_modeset_helper_vtables.h>
+
+#include <kunit/test.h>
+
+struct drm_atomic_test_priv {
+	struct drm_device drm;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+static const struct drm_connector_helper_funcs drm_atomic_init_connector_helper_funcs = {
+};
+
+static const struct drm_connector_funcs drm_atomic_init_connector_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.reset			= drm_atomic_helper_connector_reset,
+};
+
+static struct drm_atomic_test_priv *create_device(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_connector *connector;
+	struct drm_encoder *enc;
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct device *dev;
+	int ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	if (IS_ERR(dev))
+		return ERR_CAST(dev);
+
+	priv = drm_kunit_helper_alloc_drm_device(test, dev,
+						 struct drm_atomic_test_priv, drm,
+						 DRIVER_MODESET | DRIVER_ATOMIC);
+	if (IS_ERR(priv))
+		return ERR_CAST(priv);
+
+	drm = &priv->drm;
+	plane = drm_kunit_helper_create_primary_plane(test, drm,
+						      NULL,
+						      NULL,
+						      NULL, 0,
+						      NULL);
+	if (IS_ERR(plane))
+		return ERR_CAST(plane);
+	priv->plane = plane;
+
+	crtc = drm_kunit_helper_create_crtc(test, drm,
+					    plane, NULL,
+					    NULL,
+					    NULL);
+	if (IS_ERR(crtc))
+		return ERR_CAST(crtc);
+	priv->crtc = crtc;
+
+	enc = &priv->encoder;
+	ret = drmm_encoder_init(drm, enc, NULL, DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	enc->possible_crtcs = drm_crtc_mask(crtc);
+
+	connector = &priv->connector;
+	ret = drmm_connector_init(drm, connector,
+				  &drm_atomic_init_connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL,
+				  NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	drm_connector_helper_add(connector, &drm_atomic_init_connector_helper_funcs);
+
+	drm_connector_attach_encoder(connector, enc);
+
+	drm_mode_config_reset(drm);
+
+	return priv;
+}
+
+static void drm_test_drm_atomic_get_connector_for_encoder(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_test_priv *priv;
+	struct drm_display_mode *mode;
+	struct drm_connector *curr_connector;
+	int ret;
+
+	priv = create_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, &priv->drm,
+						     priv->crtc, &priv->connector,
+						     mode, &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn:
+	curr_connector = drm_atomic_get_connector_for_encoder(&priv->encoder,
+							      &ctx);
+	if (PTR_ERR(curr_connector) == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_conn;
+	}
+	KUNIT_EXPECT_PTR_EQ(test, curr_connector, &priv->connector);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+static struct kunit_case drm_atomic_get_connector_for_encoder_tests[] = {
+	KUNIT_CASE(drm_test_drm_atomic_get_connector_for_encoder),
+	{ }
+};
+
+
+static struct kunit_suite drm_atomic_get_connector_for_encoder_test_suite = {
+	.name = "drm_test_atomic_get_connector_for_encoder",
+	.test_cases = drm_atomic_get_connector_for_encoder_tests,
+};
+
+kunit_test_suite(drm_atomic_get_connector_for_encoder_test_suite);
+
+MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_DESCRIPTION("Kunit test for drm_atomic functions");
+MODULE_LICENSE("GPL");

-- 
2.48.1


