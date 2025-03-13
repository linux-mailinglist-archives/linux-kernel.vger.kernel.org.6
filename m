Return-Path: <linux-kernel+bounces-559420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D85A5F3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6979B19C130C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB9267B0B;
	Thu, 13 Mar 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx9YkFDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8EA267B04
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867238; cv=none; b=crhPn3z/bymSr8OFUwO8Emsw1dYptSM7aptZw3C3pxHGUpChVZNYISJo38zmd0g2IXUlErYN2SqrXZYHKXNhwYha+H0QdGA68L4ti7fb78s9Cp8sgHvWCXqeNZdQd+gst22EBOV+TL53LHDtgyM7ZSwkWquIIKlsxgl1LMk/mVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867238; c=relaxed/simple;
	bh=ftdIwsjmLXoIk6CM48IyctmPnT/90xD8ZSeUkKWs8ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVDtkgK/rXgjp6Eh5XaupVLDQMel62WaqG3VptuzPdfO29XOQSOOqnYR+5XEg1rSzKgcjfwVh0qrvQgKr6VkBoRn0DzGGCFa55X+YyoCRZikqze53BEkP3eGC974XPbmmk1oHKo7M4V7AR55cQVkeTF9e12ENUyg5KYkrTjf7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx9YkFDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489B9C4CEDD;
	Thu, 13 Mar 2025 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867238;
	bh=ftdIwsjmLXoIk6CM48IyctmPnT/90xD8ZSeUkKWs8ug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jx9YkFDUTsV71mojJio5YxLLYMf45Co7363q8bQc6F2EAM/uoSukXcPJPdIJIxdc0
	 dwubkmwoEAfXrC8O031EyKID9JzZRkGcDyr+zE2uLZyuZuUdrUod/bxekJ0iDQg2Va
	 LSnchOGyIe84nXaDq3hKaXMpzuR16YWugnwwxtq+23JwK16lMmJOIuVRiAoGn/egj5
	 rct9tm7wOR6cZ7hXibviKwHJ1v7sCJFuWtXxqAGChUrqHuJvRS4nTHshx0UapPwaO8
	 ZZSGptOVoD6YEFmV73Df+H80aUuO/2ginM2lavW92YLOXDAbciAhjLtBD0QjM9z1EU
	 dH5u14bw6lU6w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:03 +0100
Subject: [PATCH v6 09/16] drm/tests: bridge: Provide tests for
 drm_bridge_helper_reset_crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-9-511c54a604fb@kernel.org>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7995; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ftdIwsjmLXoIk6CM48IyctmPnT/90xD8ZSeUkKWs8ug=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThzexZacfDeieLnz2Wn3IxxeznyY8jJeX1xX+5bb5
 PXHI6/4dJSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiV50Y/vDNualzbvPifn+W
 93HHzmh93qBu4yT3I9g1JeNP9bcZCX2MDPM22igsyGxbH1jPHiWvt2ve9fn7jzueWNnh8MZhAUe
 9LhcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Let's provide a bunch of kunit tests to make sure
drm_bridge_helper_reset_crtc() works as expected.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 209 +++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index c0a05c459d957c3f9d281957f002f6bd36cce367..ff88ec2e911c9cc9a718483f09d4c764f45f991a 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -3,10 +3,11 @@
  * Kunit test for drm_bridge functions
  */
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_bridge_helper.h>
 #include <drm/drm_kunit_helpers.h>
 
 #include <kunit/test.h>
 
 struct drm_bridge_init_priv {
@@ -14,16 +15,56 @@ struct drm_bridge_init_priv {
 	struct drm_plane *plane;
 	struct drm_crtc *crtc;
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
 	struct drm_connector *connector;
+	unsigned int enable_count;
+	unsigned int disable_count;
 };
 
+static void drm_test_bridge_enable(struct drm_bridge *bridge)
+{
+	struct drm_bridge_init_priv *priv =
+		container_of(bridge, struct drm_bridge_init_priv, bridge);
+
+	priv->enable_count++;
+}
+
+static void drm_test_bridge_disable(struct drm_bridge *bridge)
+{
+	struct drm_bridge_init_priv *priv =
+		container_of(bridge, struct drm_bridge_init_priv, bridge);
+
+	priv->disable_count++;
+}
+
 static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
+	.enable			= drm_test_bridge_enable,
+	.disable		= drm_test_bridge_disable,
 };
 
+static void drm_test_bridge_atomic_enable(struct drm_bridge *bridge,
+					  struct drm_atomic_state *state)
+{
+	struct drm_bridge_init_priv *priv =
+		container_of(bridge, struct drm_bridge_init_priv, bridge);
+
+	priv->enable_count++;
+}
+
+static void drm_test_bridge_atomic_disable(struct drm_bridge *bridge,
+					   struct drm_atomic_state *state)
+{
+	struct drm_bridge_init_priv *priv =
+		container_of(bridge, struct drm_bridge_init_priv, bridge);
+
+	priv->disable_count++;
+}
+
 static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
+	.atomic_enable		= drm_test_bridge_atomic_enable,
+	.atomic_disable		= drm_test_bridge_atomic_disable,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_reset		= drm_atomic_helper_bridge_reset,
 };
 
@@ -201,10 +242,176 @@ static struct kunit_case drm_bridge_get_current_state_tests[] = {
 static struct kunit_suite drm_bridge_get_current_state_test_suite = {
 	.name = "drm_test_bridge_get_current_state",
 	.test_cases = drm_bridge_get_current_state_tests,
 };
 
-kunit_test_suite(drm_bridge_get_current_state_test_suite);
+/*
+ * Test that an atomic bridge is properly power-cycled when calling
+ * drm_bridge_helper_reset_crtc().
+ */
+static void drm_test_drm_bridge_helper_reset_crtc_atomic(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_bridge_init_priv *priv;
+	struct drm_display_mode *mode;
+	struct drm_bridge *bridge;
+	int ret;
+
+	priv = drm_test_bridge_init(test, &drm_test_bridge_atomic_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_commit:
+	ret = drm_kunit_helper_enable_crtc_connector(test,
+						     &priv->drm, priv->crtc,
+						     priv->connector,
+						     mode,
+						     &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_commit;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	bridge = &priv->bridge;
+	KUNIT_ASSERT_EQ(test, priv->enable_count, 1);
+	KUNIT_ASSERT_EQ(test, priv->disable_count, 0);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_reset:
+	ret = drm_bridge_helper_reset_crtc(bridge, &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_reset;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	KUNIT_EXPECT_EQ(test, priv->enable_count, 2);
+	KUNIT_EXPECT_EQ(test, priv->disable_count, 1);
+}
+
+/*
+ * Test that calling drm_bridge_helper_reset_crtc() on a disabled atomic
+ * bridge will fail and not call the enable / disable callbacks
+ */
+static void drm_test_drm_bridge_helper_reset_crtc_atomic_disabled(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_bridge_init_priv *priv;
+	struct drm_display_mode *mode;
+	struct drm_bridge *bridge;
+	int ret;
+
+	priv = drm_test_bridge_init(test, &drm_test_bridge_atomic_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	bridge = &priv->bridge;
+	KUNIT_ASSERT_EQ(test, priv->enable_count, 0);
+	KUNIT_ASSERT_EQ(test, priv->disable_count, 0);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_reset:
+	ret = drm_bridge_helper_reset_crtc(bridge, &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_reset;
+	}
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	KUNIT_EXPECT_EQ(test, priv->enable_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->disable_count, 0);
+}
+
+/*
+ * Test that a non-atomic bridge is properly power-cycled when calling
+ * drm_bridge_helper_reset_crtc().
+ */
+static void drm_test_drm_bridge_helper_reset_crtc_legacy(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_bridge_init_priv *priv;
+	struct drm_display_mode *mode;
+	struct drm_bridge *bridge;
+	int ret;
+
+	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_commit:
+	ret = drm_kunit_helper_enable_crtc_connector(test,
+						     &priv->drm, priv->crtc,
+						     priv->connector,
+						     mode,
+						     &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_commit;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	bridge = &priv->bridge;
+	KUNIT_ASSERT_EQ(test, priv->enable_count, 1);
+	KUNIT_ASSERT_EQ(test, priv->disable_count, 0);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_reset:
+	ret = drm_bridge_helper_reset_crtc(bridge, &ctx);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry_reset;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	KUNIT_EXPECT_EQ(test, priv->enable_count, 2);
+	KUNIT_EXPECT_EQ(test, priv->disable_count, 1);
+}
+
+static struct kunit_case drm_bridge_helper_reset_crtc_tests[] = {
+	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_atomic),
+	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_atomic_disabled),
+	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_legacy),
+	{ }
+};
+
+static struct kunit_suite drm_bridge_helper_reset_crtc_test_suite = {
+	.name = "drm_test_bridge_helper_reset_crtc",
+	.test_cases = drm_bridge_helper_reset_crtc_tests,
+};
+
+kunit_test_suites(
+	&drm_bridge_get_current_state_test_suite,
+	&drm_bridge_helper_reset_crtc_test_suite,
+);
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
 MODULE_DESCRIPTION("Kunit test for drm_bridge functions");
 MODULE_LICENSE("GPL");

-- 
2.48.1


