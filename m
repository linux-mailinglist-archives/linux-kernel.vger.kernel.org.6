Return-Path: <linux-kernel+bounces-566312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5DA6762B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DF93B97F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCB20D51C;
	Tue, 18 Mar 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOcIvueU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64E20E70B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307474; cv=none; b=TZRd6vy4nOwALvaQhsF21Vaf+OspVdm5C3OIcR48l1ztYuW/kh2glW0xx2P8RwRoxiLlYyhmHABk+JtMJ4E+shSkyy6Vsa88LyUn9vah3jd0mXhiLvZQPbUOcIYsqnSmaYTNc7Xkuk8D//NCPniQTJFsyk3FHqbqpcieSpEfVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307474; c=relaxed/simple;
	bh=Qse+YpYm1YMkR9UE3SKy6BavWvSqQlpvnDsgaxildas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9jf2HkOaZgZJTxRB+TFaQNHyWMdN56euLkkoTDgJU57w/Y6uZ01fYgjCP/Rq2BRwF598sgZ087m03hAP27AUscrNkNujriBcAt2F5kN1dNI2fb6IapXDNlTug73TaBZsraNk7tNVNQSPbMp1SOoqaJhqsKMklnIoWbAHckT5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOcIvueU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAF5C4CEEE;
	Tue, 18 Mar 2025 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307474;
	bh=Qse+YpYm1YMkR9UE3SKy6BavWvSqQlpvnDsgaxildas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tOcIvueUgOEJxFr9+nGMRNUA7zNlNutA1Dh32HyaZQRSl8v0BpwARLovQmDZqU/EW
	 N7z5vxkxESfQocNDRjqBQo90m0A8GBjOaArI1S2Oib4ISCI6iHOoGBRREmzPtI3/xU
	 FjLUwW8TQqHEBAsuspQV7L37XjPGau7/yzO3tLG8SgGosAfhnnGg4PKWTzDbAUabOG
	 rJV7ZcBjZRyxcMUdRkCEwjeZQjXt5cuXodUcPEVjjWdwbGWynFExDM0Y19+iMqePl3
	 1UlehcexXnMXfjUgm3xXamVQtbE5ZUiZb9mer+u+MVMRuK+kyluGD2lruspIkyo/3e
	 DH9+banXXoDOA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 18 Mar 2025 15:17:40 +0100
Subject: [PATCH 4/4] drm/vc4: tests: Retry pv-muxing tests when EDEADLK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-drm-vc4-kunit-failures-v1-4-779864d9ab37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6791; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Qse+YpYm1YMkR9UE3SKy6BavWvSqQlpvnDsgaxildas=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOk3G5q/2ngGhdZ+u2l560t2WsaM7d5h0Wa/7Jdtl/X6s
 DZ++ZJLHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiRy8yNtzoWOv2J0B4jUyz
 ZmQxs6VMf/Jkz5fmEk1XIo8Krcu5lxARcOvcLr2JYtZc0ded90kvZmz42CfLm/b/Y9+/r+smfJG
 7/2hx8fUHT7QOxW+9af5+Ul6v14rWLK+qnxN4pjBfa+c7enAWAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Some functions used by the HVS->PV muxing tests can return with EDEADLK,
meaning the entire sequence should be restarted. It's not a fatal error
and we should treat it as a recoverable error, and recover, instead of
failing the test like we currently do.

Fixes: 76ec18dc5afa ("drm/vc4: tests: Add unit test suite for the PV muxing")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 52c04ef33206bf4f9e21e3c8b7cea932824a67fa..94e05bddb630a79aab189d9bc16f09a9d84ce396 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -685,20 +685,26 @@ static void drm_vc4_test_pv_muxing(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 	vc4 = priv->vc4;
 	drm = &vc4->base;
+
+retry:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 	for (i = 0; i < params->nencoders; i++) {
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		ret = vc4_mock_atomic_add_output(test, state, enc_type);
+		if (ret == -EDEADLK)
+			goto retry;
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry;
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_TRUE(test,
 			  check_fifo_conflict(test, state));
 
@@ -726,21 +732,27 @@ static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 	vc4 = priv->vc4;
 	drm = &vc4->base;
+
+retry:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	for (i = 0; i < params->nencoders; i++) {
 		enum vc4_encoder_type enc_type = params->encoders[i];
 
 		ret = vc4_mock_atomic_add_output(test, state, enc_type);
+		if (ret == -EDEADLK)
+			goto retry;
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry;
 	KUNIT_EXPECT_LT(test, ret, 0);
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 }
@@ -811,17 +823,22 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
+retry_first:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	new_hvs_state = vc4_hvs_get_new_global_state(state);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_hvs_state);
 
@@ -834,17 +851,22 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[hdmi0_channel].in_use);
 
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+retry_second:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
+	if (ret == -EDEADLK)
+		goto retry_second;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry_second;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	new_hvs_state = vc4_hvs_get_new_global_state(state);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_hvs_state);
 
@@ -885,20 +907,27 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
+retry_first:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	new_hvs_state = vc4_hvs_get_new_global_state(state);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_hvs_state);
 
@@ -919,17 +948,22 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[old_hdmi1_channel].in_use);
 
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+retry_second:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_del_output(test, state, VC4_ENCODER_TYPE_HDMI0);
+	if (ret == -EDEADLK)
+		goto retry_second;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry_second;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	new_hvs_state = vc4_hvs_get_new_global_state(state);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_hvs_state);
 
@@ -979,29 +1013,39 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
+retry_first:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry_first;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+retry_second:
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
+	if (ret == -EDEADLK)
+		goto retry_second;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto retry_second;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	new_vc4_crtc_state = get_vc4_crtc_state_for_encoder(test, state,
 							    VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_EXPECT_NULL(test, new_vc4_crtc_state);

-- 
2.48.1


