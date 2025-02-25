Return-Path: <linux-kernel+bounces-531928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363CA446A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AA5189ED62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24231991D2;
	Tue, 25 Feb 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkm37tmi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AB19992C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501854; cv=none; b=CoOL+LotOnfHFOnKBwKyCeJM+o38GzKGXnMzIduFdnxZNkLu34WhGIS/3ho5qtar2MPeJj/IvUAvnd7GGD71YuabZZ6+QzdgfZBjRLzbt949abNyxYINmJr57hc4F+GObMP+BnYcUcT28lG8Sg2lnqOK8h69f4C1clfzvvx08d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501854; c=relaxed/simple;
	bh=xTZqLrferHo57tTvoIcxTpP4bjj1sWinKgv+LhPuzVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTkz8ackQuBjf1KgcYQGjvKQYkcubALcoOg+L+HlF3N6x3p6DenLgO33v3FeYYBWusa6oeXPdwpM2LU5r0vQrnKtYogS9zGorEZoVDgG0kZo2oNIQ/TyonDA0f7C3pm22JSuZFwvZwrImLykeP0FtIph4ISZI20QmvgJ5d/KbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkm37tmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0076DC4CEDD;
	Tue, 25 Feb 2025 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501853;
	bh=xTZqLrferHo57tTvoIcxTpP4bjj1sWinKgv+LhPuzVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bkm37tmi3rI5g4A4qOxbL61Ds9AV7cHeorZXOE9uUI6HhSAfIRAvbGH7j5G8p35cF
	 Co0R+FSYWsIvSt8JiwJwlt1s7rFKw5R7EPIltpdt/P8X6E9H+VnCGxDsNz3oyyJyNC
	 8hJL5vpnBsv/9xO73AXh8gZRfvxfg18KtsZoiU32jdy7zBEW8xmClUcIQE6MpBaBen
	 RsU0O9r/fvZr6GRkOlU8x+tv120NpUS9hcNKmiGQ/TQQTXcC7UL1VG4NufpNA4z+CW
	 LAvEsFHg8XIaNCuIHxn+jIvP67ooduNHJ26Mil204DIhuom3PZCL4UMsTQagurh1su
	 7+zQgpKxrjC2w==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:43:51 +0100
Subject: [PATCH v4 03/15] drm/tests: Add kunit tests for bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-3-7ecb07b09cad@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7892; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xTZqLrferHo57tTvoIcxTpP4bjj1sWinKgv+LhPuzVY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P3s/Ee79wBFT9O3vthXh+5/c2/RFfaLz5VlbFl+cI
 t56Ylro5Y6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwEfn3jHXKqm93nDzTc/TW
 +WZDwzmqr52mcR+XNrWZOsGTvVLXN7SluP1x947Ai6884ppeWmk+PslYX7m9eo731QVJ9588/eT
 F2npjZ1fDmzObrvvP2fXkeqVX0vyle34/6sjxfBEScIb/c6NEMAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

None of the drm_bridge function have kunit tests so far. Let's change
that, starting with drm_bridge_get_current_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/Kconfig                 |   1 +
 drivers/gpu/drm/tests/Makefile          |   1 +
 drivers/gpu/drm/tests/drm_bridge_test.c | 210 ++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index d9986fd52194fae87e04fc7fbf038e7afad320d9..cd950bba379b10bcee5e7fb24c090056c7a6dc04 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -72,10 +72,11 @@ config DRM_KUNIT_TEST_HELPERS
 	  KUnit Helpers for KMS drivers.
 
 config DRM_KUNIT_TEST
 	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
 	depends on DRM && KUNIT && MMU
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_BUDDY
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_STATE_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_EXEC
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 0109bcf7faa54993cce337f522eae78f0fa6ffcb..6691c577d2d4581a4185bac2ce89a6b14b339b35 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -3,10 +3,11 @@
 obj-$(CONFIG_DRM_KUNIT_TEST_HELPERS) += \
 	drm_kunit_helpers.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_atomic_state_test.o \
+	drm_bridge_test.o \
 	drm_buddy_test.o \
 	drm_cmdline_parser_test.o \
 	drm_connector_test.o \
 	drm_damage_helper_test.o \
 	drm_dp_mst_helper_test.o \
diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..c0a05c459d957c3f9d281957f002f6bd36cce367
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit test for drm_bridge functions
+ */
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_kunit_helpers.h>
+
+#include <kunit/test.h>
+
+struct drm_bridge_init_priv {
+	struct drm_device drm;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder encoder;
+	struct drm_bridge bridge;
+	struct drm_connector *connector;
+};
+
+static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
+};
+
+static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
+	.atomic_reset		= drm_atomic_helper_bridge_reset,
+};
+
+KUNIT_DEFINE_ACTION_WRAPPER(drm_bridge_remove_wrapper,
+			    drm_bridge_remove,
+			    struct drm_bridge *);
+
+static int drm_kunit_bridge_add(struct kunit *test,
+				struct drm_bridge *bridge)
+{
+	drm_bridge_add(bridge);
+
+	return kunit_add_action_or_reset(test,
+					 drm_bridge_remove_wrapper,
+					 bridge);
+}
+
+static struct drm_bridge_init_priv *
+drm_test_bridge_init(struct kunit *test, const struct drm_bridge_funcs *funcs)
+{
+	struct drm_bridge_init_priv *priv;
+	struct drm_encoder *enc;
+	struct drm_bridge *bridge;
+	struct drm_device *drm;
+	struct device *dev;
+	int ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	if (IS_ERR(dev))
+		return ERR_CAST(dev);
+
+	priv = drm_kunit_helper_alloc_drm_device(test, dev,
+						 struct drm_bridge_init_priv, drm,
+						 DRIVER_MODESET | DRIVER_ATOMIC);
+	if (IS_ERR(priv))
+		return ERR_CAST(priv);
+
+	drm = &priv->drm;
+	priv->plane = drm_kunit_helper_create_primary_plane(test, drm,
+							    NULL,
+							    NULL,
+							    NULL, 0,
+							    NULL);
+	if (IS_ERR(priv->plane))
+		return ERR_CAST(priv->plane);
+
+	priv->crtc = drm_kunit_helper_create_crtc(test, drm,
+						  priv->plane, NULL,
+						  NULL,
+						  NULL);
+	if (IS_ERR(priv->crtc))
+		return ERR_CAST(priv->crtc);
+
+	enc = &priv->encoder;
+	ret = drmm_encoder_init(drm, enc, NULL, DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	enc->possible_crtcs = drm_crtc_mask(priv->crtc);
+
+	bridge = &priv->bridge;
+	bridge->type = DRM_MODE_CONNECTOR_VIRTUAL;
+	bridge->funcs = funcs;
+
+	ret = drm_kunit_bridge_add(test, bridge);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drm_bridge_attach(enc, bridge, NULL, 0);
+	if (ret)
+		return ERR_PTR(ret);
+
+	priv->connector = drm_bridge_connector_init(drm, enc);
+	if (IS_ERR(priv->connector))
+		return ERR_CAST(priv->connector);
+
+	drm_connector_attach_encoder(priv->connector, enc);
+
+	drm_mode_config_reset(drm);
+
+	return priv;
+}
+
+/*
+ * Test that drm_bridge_get_current_state() returns the last committed
+ * state for an atomic bridge.
+ */
+static void drm_test_drm_bridge_get_current_state_atomic(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_bridge_init_priv *priv;
+	struct drm_bridge_state *curr_bridge_state;
+	struct drm_bridge_state *bridge_state;
+	struct drm_atomic_state *state;
+	struct drm_bridge *bridge;
+	struct drm_device *drm;
+	int ret;
+
+	priv = drm_test_bridge_init(test, &drm_test_bridge_atomic_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	drm = &priv->drm;
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_commit:
+	bridge = &priv->bridge;
+	bridge_state = drm_atomic_get_bridge_state(state, bridge);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bridge_state);
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_state_clear(state);
+		drm_modeset_backoff(&ctx);
+		goto retry_commit;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_state:
+	ret = drm_modeset_lock(&bridge->base.lock, &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_state;
+	}
+
+	curr_bridge_state = drm_bridge_get_current_state(bridge);
+	KUNIT_EXPECT_PTR_EQ(test, curr_bridge_state, bridge_state);
+
+	drm_modeset_unlock(&bridge->base.lock);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that drm_bridge_get_current_state() returns NULL for a
+ * non-atomic bridge.
+ */
+static void drm_test_drm_bridge_get_current_state_legacy(struct kunit *test)
+{
+	struct drm_bridge_init_priv *priv;
+	struct drm_bridge *bridge;
+
+	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	/*
+	 * NOTE: Strictly speaking, we should take the bridge->base.lock
+	 * before calling that function. However, bridge->base is only
+	 * initialized if the bridge is atomic, while we explicitly
+	 * initialize one that isn't there.
+	 *
+	 * In order to avoid unnecessary warnings, let's skip the
+	 * locking. The function would return NULL in all cases anyway,
+	 * so we don't really have any concurrency to worry about.
+	 */
+	bridge = &priv->bridge;
+	KUNIT_EXPECT_NULL(test, drm_bridge_get_current_state(bridge));
+}
+
+static struct kunit_case drm_bridge_get_current_state_tests[] = {
+	KUNIT_CASE(drm_test_drm_bridge_get_current_state_atomic),
+	KUNIT_CASE(drm_test_drm_bridge_get_current_state_legacy),
+	{ }
+};
+
+
+static struct kunit_suite drm_bridge_get_current_state_test_suite = {
+	.name = "drm_test_bridge_get_current_state",
+	.test_cases = drm_bridge_get_current_state_tests,
+};
+
+kunit_test_suite(drm_bridge_get_current_state_test_suite);
+
+MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_DESCRIPTION("Kunit test for drm_bridge functions");
+MODULE_LICENSE("GPL");

-- 
2.48.1


