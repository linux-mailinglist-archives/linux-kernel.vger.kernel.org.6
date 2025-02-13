Return-Path: <linux-kernel+bounces-513200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E37A343A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5C71892002
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197B188CDB;
	Thu, 13 Feb 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzMJFvu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE308188583
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457914; cv=none; b=jHrvyEmllm4iA0gun71bmyVMpqyTOu4VHOQUXbifSKf8csy5BUP4C7FwtNJhedqrZsHSdbL3bi1j1qZidQdZITIMWMcQn7CryTAo55N5YzcyBeS2KgUZxqOqNHHG7dczU95eG2MpanNDtkwOo+ux3pI4mNVGJx6nkKr4gRivCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457914; c=relaxed/simple;
	bh=G/dtHGJLltHvyQvOlbZxv0Dbjvb3n4W6Sq3TiFqZN7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HohXZrpPhQUmdLdRs7s1Bq64nwCWvSyhhUgtc9MsczOlanf2rNNdjsM8ROUYre9/UHdyK9eW5sjJsKRhLjJUzeO7ywQ7cWxvBd7nuzJc3m78mDyf4S9yW9NK4OGNq/T0tOiX/IEZqBkGukxF3+AjaSyUW2Q/Ia2ZY4QkuVxTIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzMJFvu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5CC4CEE4;
	Thu, 13 Feb 2025 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457914;
	bh=G/dtHGJLltHvyQvOlbZxv0Dbjvb3n4W6Sq3TiFqZN7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CzMJFvu3mGQSIUbWRdPNGlktfm9tTcHsneSZ6VGrkosVec/KofGhk0jYwLRfilOkl
	 nx0jVjbgz/BdxLezIhIqNLaJtfCws9wy22NfrId90FitkbhOnzKNA3vHJv4A7R1y5o
	 ZTACp5x/zLXzLWrFA0Nk2XsYdksocrwzgyVvj9O0fwPeXME/9mQgcOv1+pgEwG3gIs
	 Evj78V3wOLgrNcvCS102fLqWfyQ+eYEk6yBIyL5CLsdaN7D3fK9Kh431sVTycHTl2d
	 ifvntnXKBcBi82hkUt5eRRswCboNPFU3XXbut8p1czan2Ssj1QlF8eHJi8T1gxodu0
	 EU+fFaknmMlog==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:48 +0100
Subject: [PATCH v3 29/37] drm/bridge: Introduce drm_bridge_is_atomic()
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-29-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=mripard@kernel.org;
 h=from:subject:message-id; bh=G/dtHGJLltHvyQvOlbZxv0Dbjvb3n4W6Sq3TiFqZN7Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWJV/vm+4t8Y1e/mDxwuOGM18a7vr0OvNa+LKvm4/9
 T8nyXuDfcdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYyNV0xnpntr7bD3TyYrdy
 x1V1FMhbKd4NOJFQmfH754z6eX4iEx2+B9/sPb7j1iZe/R26s0VceRnrTE8mrPky+/KRZZruTiE
 RXsfPPDOSXbDxx/rGORN9VVgXm2h03pr3ysOBb/YBL8leudsqAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We test for whether the bridge is atomic in several places in the source
code, so let's consolidate them.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8241c00e4506eceeb9bb4ba74a38d8f360c65d38..d2525d0b1324cc3a63e32f5bf6ca6c4f9034eb4e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -278,10 +278,15 @@ drm_bridge_atomic_destroy_priv_state(struct drm_private_obj *obj,
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
@@ -330,11 +335,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
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
@@ -375,11 +380,11 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 		return;
 
 	if (WARN_ON(!bridge->dev))
 		return;
 
-	if (bridge->funcs->atomic_reset)
+	if (drm_bridge_is_atomic(bridge))
 		drm_atomic_private_obj_fini(&bridge->base);
 
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 

-- 
2.48.0


