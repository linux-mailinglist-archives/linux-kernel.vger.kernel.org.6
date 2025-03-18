Return-Path: <linux-kernel+bounces-566310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EABA67626
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C161690E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0320E6E8;
	Tue, 18 Mar 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dugLojLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BF20D51C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307472; cv=none; b=vGIdtRv43XHzUEQLBBuuLXYuj757iOBpyEUAsPiZJFh7l/OZH8TZoecM11Jq3ho8s5+BH6Y35pzkAaLvBlbVDubKbi/ZC5dK8xL8cvY3rKDSJcUekS7MkiYyQsAARqpXp7XgpGmyRM+BOGfcOmCcCOoaFenxXWqFdB46xmF7uMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307472; c=relaxed/simple;
	bh=Prf+J8pljFFHYbYN80B3nf3AAv7dZSnSo25RANF9Ijk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLWF8HcOQhMcR2BnHT5UpZSq0HjOfz5MSy8RylFAHtZ5td3HOtJbXDz9otL4acw46VNksd69K5siqEKyExBgUcJPCGMP90zgBK1pWqcV2mnut9YE5uOADm27QsN+Uk0vIq8Slq4ofRbqjihKq5n/qihLqgQI/xnlvTJyIuidmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dugLojLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A21C4CEEE;
	Tue, 18 Mar 2025 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307471;
	bh=Prf+J8pljFFHYbYN80B3nf3AAv7dZSnSo25RANF9Ijk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dugLojLyfQ0/vMMS2aIMtaRWBUM9THTPLiqmrukx0XADzbcP+q2yFe4TlQ6BnjRir
	 JRKZEKWc0/GZyl+Ee55QbZkIK+ul5yHZ3zOj2TTh8kq+8mvC1hUQH1emqD4UdJOP1a
	 u1DLlYez2AFw0pkXkRax9cdUmmmTBpuWsge9KNnDxbVujSpFfdkmvilU1RdeGSsoEu
	 VDSZssMiOuVqjYopB7ki6UxBWXLvmQI8sI4ZvpHWKYZ4XlOByTdDAsU+6LuxzKcjjg
	 UxzTvY52j+UBbsaTNKhhHvLwo1KEhwksBDcofISUD6Zjo58UI57iUAwFvBJ3rPQgTD
	 D7O3CJsFeSLnQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 18 Mar 2025 15:17:39 +0100
Subject: [PATCH 3/4] drm/vc4: tests: Stop allocating the state in test init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-drm-vc4-kunit-failures-v1-3-779864d9ab37@kernel.org>
References: <20250318-drm-vc4-kunit-failures-v1-0-779864d9ab37@kernel.org>
In-Reply-To: <20250318-drm-vc4-kunit-failures-v1-0-779864d9ab37@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4561; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Prf+J8pljFFHYbYN80B3nf3AAv7dZSnSo25RANF9Ijk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOk3G5rY0nTKchS/SZzRdTryWedr/eGHmqFPDt8KO8991
 7Kq09ShYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkugVjw8dr+jfTcvJSexg+
 /z+7Mkr3UvXPxyf3ZOo8WFAmxG9loj2vV6DRXiNI+7h3Vtsx0U9bGRvOSd6rMOMzci8UvufMqNX
 td//w5u7MxVuYI1OrjqxIPPzRKnTyTJaHl5puRh+fIMO5cBoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The vc4-pv-muxing-combinations and vc5-pv-muxing-combinations test
suites use a common test init function which, in part, allocates the
drm atomic state the test will use.

That allocation relies on  drm_kunit_helper_atomic_state_alloc(), and
thus requires a struct drm_modeset_acquire_ctx. This context will then
be stored in the allocated state->acquire_ctx field.

However, the context is local to the test init function, and is cleared
as soon as drm_kunit_helper_atomic_state_alloc() is done. We thus end up
with an dangling pointer to a cleared context in state->acquire_ctx for
our test to consumes.

We should really allocate the context and the state in the test
functions, so we can also control when we're done with it.

Fixes: 30188df0c387 ("drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 41 +++++++++++++++++---------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 992e8f5c5c6ea8d92338a8fe739fa1115ff85338..52c04ef33206bf4f9e21e3c8b7cea932824a67fa 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -18,11 +18,10 @@
 
 #include "vc4_mock.h"
 
 struct pv_muxing_priv {
 	struct vc4_dev *vc4;
-	struct drm_atomic_state *state;
 };
 
 static bool check_fifo_conflict(struct kunit *test,
 				const struct drm_atomic_state *state)
 {
@@ -675,14 +674,23 @@ KUNIT_ARRAY_PARAM(vc5_test_pv_muxing_invalid,
 
 static void drm_vc4_test_pv_muxing(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
 	const struct pv_muxing_priv *priv = test->priv;
-	struct drm_atomic_state *state = priv->state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_state *state;
+	struct drm_device *drm;
+	struct vc4_dev *vc4;
 	unsigned int i;
 	int ret;
 
+	drm_modeset_acquire_init(&ctx, 0);
+
+	vc4 = priv->vc4;
+	drm = &vc4->base;
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 	for (i = 0; i < params->nencoders; i++) {
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		ret = vc4_mock_atomic_add_output(test, state, enc_type);
 		KUNIT_ASSERT_EQ(test, ret, 0);
@@ -698,56 +706,61 @@ static void drm_vc4_test_pv_muxing(struct kunit *test)
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		KUNIT_EXPECT_TRUE(test, check_channel_for_encoder(test, state, enc_type,
 								  params->check_fn));
 	}
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
 	const struct pv_muxing_priv *priv = test->priv;
-	struct drm_atomic_state *state = priv->state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_state *state;
+	struct drm_device *drm;
+	struct vc4_dev *vc4;
 	unsigned int i;
 	int ret;
 
+	drm_modeset_acquire_init(&ctx, 0);
+
+	vc4 = priv->vc4;
+	drm = &vc4->base;
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
 	for (i = 0; i < params->nencoders; i++) {
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		ret = vc4_mock_atomic_add_output(test, state, enc_type);
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	ret = drm_atomic_check_only(state);
 	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static int vc4_pv_muxing_test_init(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
-	struct drm_modeset_acquire_ctx ctx;
 	struct pv_muxing_priv *priv;
-	struct drm_device *drm;
 	struct vc4_dev *vc4;
 
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 	test->priv = priv;
 
 	vc4 = params->mock_fn(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 	priv->vc4 = vc4;
 
-	drm_modeset_acquire_init(&ctx, 0);
-
-	drm = &vc4->base;
-	priv->state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->state);
-
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
-
 	return 0;
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
 	KUNIT_CASE_PARAM(drm_vc4_test_pv_muxing,

-- 
2.48.1


