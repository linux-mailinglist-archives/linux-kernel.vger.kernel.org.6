Return-Path: <linux-kernel+bounces-543973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A6A4DC0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86BF188F7F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80521FECCE;
	Tue,  4 Mar 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if4nqoEk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16341FF1CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086672; cv=none; b=VGjpEETnx4Ri2PFH6k40qKq8TaQbIa5kgh1Bsk5YjLE8o5rV6im1GfOgOPFZohw4wSfbZnbfoeMLau5x0qs33gV9rNJYmr/gLEWFZoosmH02om+unwMbJUIbZrCqtU6kZKooMBebZhr63TY88zae56p1Wa9OFJc459EtN60nFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086672; c=relaxed/simple;
	bh=0hHbjox8UHRiKYoDTXGFrh7PgRlPnPde9Kma2JZkQzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kdx+FdFi28DuqSKDNzDjUuoTqXzLOndptj/iE/OCJrPnFgOQfnJ/ImYYq3AWB48niMif/vXURPsIot+7UaNBuX7LQtHgrvXTEg0JAMYjdgwH4QuGup6JCwnVYrE2g6h/84ovZMJ78+FG6KJcQ9NW8LjH8koMMdPd8aXzG7C/nKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if4nqoEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0EFC4CEEB;
	Tue,  4 Mar 2025 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741086671;
	bh=0hHbjox8UHRiKYoDTXGFrh7PgRlPnPde9Kma2JZkQzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=if4nqoEkyQ7W+J3Os0FRrgnxj75CJooegPS/AYvtGYoTo/Z6U2DYGimptdK/c622n
	 aZrZWHlfr03LBWPZEdP1ufMqc40wpAbLSxOx1Ob4dfqgiVfWfaZIEzkCK90ozscmET
	 aIrXQ6cwQ2YN70a3nuTgBrZ1GzO033kYOhqa2ILshiwgOt+eXksGFEZGAnYHsL1AAg
	 N4cinMYx3q1x4b44gWpLzL9qc5VRIDawlGh0K64DXEPd4ycDFBjn6R0P5Yz+Lb7Wze
	 Oww6vAxyY1fSKAZ4GeJxRkCgOSccWHk2DeDU12PX2f5mEjdJot0iGamLDe8p5O8xxj
	 xC9zDoz4T99pg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 04 Mar 2025 12:10:46 +0100
Subject: [PATCH v5 03/16] drm/tests: Add kunit tests for bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bridge-connector-v5-3-aacf461d2157@kernel.org>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7953; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0hHbjox8UHRiKYoDTXGFrh7PgRlPnPde9Kma2JZkQzo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnH7u99pOLGtGjfTNNj/nyGfqf7AlW+HRQV1nvtuFKh4
 NOmZJufHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAib3MZKxl1j652vdL9c9Fm
 vjsl2y/f2hh3/UDo4lztuVXJwV835u/Z/j7gpbaBxsJVb0+ePtM5TYKx4eV6/rUzHTVElPdxb1z
 wsf7UlsPvN5RYv+Bx7Cu+qjWxcletZ3GD3dQQBwGZJbnCemvmAAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

None of the drm_bridge function have kunit tests so far. Let's change
that, starting with drm_bridge_get_current_state().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/Kconfig                 |   1 +
 drivers/gpu/drm/tests/Makefile          |   1 +
 drivers/gpu/drm/tests/drm_bridge_test.c | 210 ++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e5b59de28216385f3783373e636d193d38d02646..9b406123132912f0578e9c8288d4c80e65f75f67 100644
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


