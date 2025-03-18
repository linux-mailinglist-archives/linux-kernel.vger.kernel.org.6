Return-Path: <linux-kernel+bounces-566309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FDA6764B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FD19C2C12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900420E323;
	Tue, 18 Mar 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJVeVSH7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205120E316
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307469; cv=none; b=HBwakYafA1oijnwsS3JaH4JRBOGoEb6bSkBntVV2Fbi4wqfYBnwG8v+RPIummBi4JAhGaD9TiVVrrp48ywAB5NESl+HafmHdZWxt4r80FcBcQUker0NecbJ0xfJnmpXRvhHWFLEQRTXOzXDOwNf4BgjolSf+HytR2xL8cp7is/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307469; c=relaxed/simple;
	bh=HFNgZYKkW843dsEsmC3CFnAVtqRf7rRG/r1OkrdhDR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkNxLdo3o/0Ih1UjjKxCp6HjFAghHHm2eiFlh7/7ZgLm+fCFhZND/jwkQbqefMwVz50E/tz6rzI3hwFv2GVALy5ua6fDauXh2cchvSXcCtxEKbvlFBkBpKYqgoycYPXlDBRkRgDRWJxdMM+ql7jxeHTZWaSbAH1l9poolgZflPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJVeVSH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F8C4CEEE;
	Tue, 18 Mar 2025 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307468;
	bh=HFNgZYKkW843dsEsmC3CFnAVtqRf7rRG/r1OkrdhDR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uJVeVSH7iH7kPPO8QKLot3q2csVbAZGXzE0a0I7WmtH3A68tDgiID1+VarIm9Kwl0
	 SGyfBwvQXTsF2oSXQkqvbn+ldFDHjEsq3cGr3lbcfhkCYimkSIxlD44oWX7Ii7UCaj
	 fvzaH6hj5VR3gukBBOehaXscptaVYmeuNheg312bwp3JO9vUUZ1LQWn4hHoY+kXMvo
	 HH7oIJvsmWgSKSgI03ANVsUH3ncVBFeXyshPaKvi5/Ze8UJkpYP+R1DqZiD3pExu9O
	 ld+kYUrIjQkCgk+I2eT+zxO6Cye7nUKHHKM3QUL8TM9CltjkG/VuZRNqP26o57o3zC
	 42yyJg3UOSwHg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 18 Mar 2025 15:17:38 +0100
Subject: [PATCH 2/4] drm/vc4: tests: Document output handling functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-drm-vc4-kunit-failures-v1-2-779864d9ab37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HFNgZYKkW843dsEsmC3CFnAVtqRf7rRG/r1OkrdhDR4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOk3G5pYVin01MlXHv53+oeS+ImaYpWFFxce7tbj/OSzi
 qtBpexsx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIrRJjfUaYZW38Lwahq6+a
 Ht3muXaYdeMs/4hLx+JjZY/5/v967gpXfhynpPytOZkzZ83d/8T7EmPDlaVWs+5Jpb97tPBYg9c
 Kc//P91/N974R2bbh0+sdNUay8ytrXeIzJnx9sF9TrIJFjX8tAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

vc4_mock_atomic_add_output() and vc4_mock_atomic_del_output() public but
aren't documented. Let's provide the documentation.

In particular, special care should be taken to deal with EDEADLK.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
index f0ddc223c1f839e8a14f37fdcbb72e7b2c836aa1..577d9a9563696791632aec614c381a214886bf27 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
@@ -59,10 +59,23 @@ struct vc4_dummy_output *vc4_dummy_output(struct kunit *test,
 
 static const struct drm_display_mode default_mode = {
 	DRM_SIMPLE_MODE(640, 480, 64, 48)
 };
 
+/**
+ * vc4_mock_atomic_add_output() - Enables an output in a state
+ * @test: The test context object
+ * @state: Atomic state to enable the output in.
+ * @type: Type of the output encoder
+ *
+ * Adds an output CRTC and connector to a state, and enables them.
+ *
+ * Returns:
+ * 0 on success, a negative error code on failure. If the error is
+ * EDEADLK, the entire atomic sequence must be restarted. All other
+ * errors are fatal.
+ */
 int vc4_mock_atomic_add_output(struct kunit *test,
 			       struct drm_atomic_state *state,
 			       enum vc4_encoder_type type)
 {
 	struct drm_device *drm = state->dev;
@@ -103,10 +116,23 @@ int vc4_mock_atomic_add_output(struct kunit *test,
 	crtc_state->active = true;
 
 	return 0;
 }
 
+/**
+ * vc4_mock_atomic_del_output() - Disables an output in a state
+ * @test: The test context object
+ * @state: Atomic state to disable the output in.
+ * @type: Type of the output encoder
+ *
+ * Adds an output CRTC and connector to a state, and disables them.
+ *
+ * Returns:
+ * 0 on success, a negative error code on failure. If the error is
+ * EDEADLK, the entire atomic sequence must be restarted. All other
+ * errors are fatal.
+ */
 int vc4_mock_atomic_del_output(struct kunit *test,
 			       struct drm_atomic_state *state,
 			       enum vc4_encoder_type type)
 {
 	struct drm_device *drm = state->dev;

-- 
2.48.1


