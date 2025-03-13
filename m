Return-Path: <linux-kernel+bounces-559422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43CA5F3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDC817F442
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB926739B;
	Thu, 13 Mar 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvpVCLn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326D266EF8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867245; cv=none; b=ujL6WCFqJmjlYYcHitzfCm3ATJru/93bVgsORFlRU8Xw/5vXkpt+Zn6XLlz4bhVfhUJvnoqrNj1pqje18m9M/Bv4ANKJZuSmfOa8Y9tezj5rGl6A1DFBQLXcQrzOm56PpV4PRfpQnARD1eV5Rko2uSj+XfxXw38dK/S0u9MbKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867245; c=relaxed/simple;
	bh=EUewhanqsgL3E4pPLl8bCzs5JweSDQRhJsHCwfNO/+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1AEv6sVIZYUG/IiFwyIaQh0MEUoShfu3FwPAbnCD6IYHUKUbWh1/5gtG+RfQVi6YPuYKADhoJvBeAvkzYs+Z0UrLTIQsCb2B4bmQjLPR8+dnd1iLIT7TJ0Zg3D9mmmhRM177qBWvEQfWdRw1bGJCuGbR7Xcv5yq3TCHrQjUiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvpVCLn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C3DC4CEDD;
	Thu, 13 Mar 2025 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867244;
	bh=EUewhanqsgL3E4pPLl8bCzs5JweSDQRhJsHCwfNO/+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NvpVCLn+EICHTmjoc+rC7239hr+En3BknmFbkLXpvNgv6XKPhzOaihjwotOoXiU67
	 79qqcWIz5ZMgzpO5Vn8VUAmtetddt6u0vjo+Uz9ESQq0rd8hPE+ARKAWqSR9vjpkaz
	 31xhlmMzqyAbNChi0QSxB1xcgdoKg2FZ2PEcQITl/LNCtWPYH0NfG5if6u1qVf2HJ2
	 /iZv7/gjcg7MZKd2HseKE0yuQCm+Ep8Q6a7mzywV9snzHHE9Jqr+Kg9CeY6m8Qc5Ac
	 wQp4x3+Kcde4iZue2oJEWYsuMJSNjVVu+C96dw3hhW2g0VASSnGYi+g6wh/8GGWYQm
	 ACbl56d5yv5vA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:05 +0100
Subject: [PATCH v6 11/16] drm/bridge: Introduce drm_bridge_is_atomic()
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-11-511c54a604fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EUewhanqsgL3E4pPLl8bCzs5JweSDQRhJsHCwfNO/+s=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThzdK53x/dWzhnIXz3XcNoH6oa4KM9qtZytwyym+X
 tKsG+jZUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgJt8gOGvZFmX71cV+U0mBhna
 Wy022Zw1Pdn5LW79tWXOPY2bbswKYWT4+Yfj1u32uSlynGtepDRP2G+cJHt06qnNu48n1xWf8vr
 KBQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We test for whether the bridge is atomic in several places in the source
code, so let's consolidate them.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 5bdce9db4475c9699bec11b1e4c0615af028b33d..ef98e21dc593f38a2d3c67b850032ece38bec5e8 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -279,10 +279,15 @@ drm_bridge_atomic_destroy_priv_state(struct drm_private_obj *obj,
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
+static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
+{
+	return bridge->funcs->atomic_reset != NULL;
+}
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
  * @encoder: DRM encoder
  * @bridge: bridge to attach
@@ -331,11 +336,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
-	if (bridge->funcs->atomic_reset) {
+	if (drm_bridge_is_atomic(bridge)) {
 		struct drm_bridge_state *state;
 
 		state = bridge->funcs->atomic_reset(bridge);
 		if (IS_ERR(state)) {
 			ret = PTR_ERR(state);
@@ -376,11 +381,11 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 		return;
 
 	if (WARN_ON(!bridge->dev))
 		return;
 
-	if (bridge->funcs->atomic_reset)
+	if (drm_bridge_is_atomic(bridge))
 		drm_atomic_private_obj_fini(&bridge->base);
 
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 

-- 
2.48.1


