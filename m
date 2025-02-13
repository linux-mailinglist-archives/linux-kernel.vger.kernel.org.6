Return-Path: <linux-kernel+bounces-513190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8AA34384
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97473188E0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B227424B;
	Thu, 13 Feb 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnCH+Iri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EB274243
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457887; cv=none; b=jWciB4W3NY59xZk387tfgmZuHhPVQV+ebrYXR2OtRyabSPk6ZjUNynQEBPuz0CDPJ/rYfk6Nd03hWkxxnQpiOqXqM9SVk2+E8OBzNyNGS0WCyrjnwWA7CyI8DwCYiVmc9YjrTPYnRTOVRyI/JG4IH6KE4rO4L+zTW8WyyWfVerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457887; c=relaxed/simple;
	bh=zI++OHT/zy7L9G9KDHxBKDrJcggygqGsKRhGcwsf6Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3NHLmCmXFmGQDFguNydTtdi9tPs+0HliSgadQ04VFyPejvUHihM7By22Rbdbw8oeF2wH5DQGPK22pZ5peoRyKTowv7q1RnTk4QtYpb6lPf0JiNK5KuMHLw8/c7m3p3yZ5cWlii51kf8J0Sdix0qgXf21qteTlyz80Og4YpeLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnCH+Iri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4EC4CED1;
	Thu, 13 Feb 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457887;
	bh=zI++OHT/zy7L9G9KDHxBKDrJcggygqGsKRhGcwsf6Lk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KnCH+Iri2ipZjz6Lo8wxFce3DLvf5nmPey55BQdMzFogCaBAu/9E9uMaHXQZpcGeS
	 UYqztzNnY/BkKKv+B3/efZS4LbaqhI2AzG+tFbQIXIy/unSg1jTh8drA/W48H4dk0b
	 K4+te6/xhVocQOORCO7sOFSguuoUfvH3wfTKAHtSqW28sL+RFHJhONF3IKPR/SaFAY
	 OU4J17dRjwvQCKs1sqL5O9lwBNjJVU7MvhDzQl5Hh/W14+idK2mritaj/KuPekrOl1
	 e3PhQ2S7oIy4w2D+ROE57VNFpXbellaEA/rlpDBS2ZboqMaKUttIdDENYnQWvuRqF6
	 gGG0TWGMfhKiA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:38 +0100
Subject: [PATCH v3 19/37] drm/bridge: Change parameter name of
 drm_atomic_bridge_chain_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-19-e71598f49c8f@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zI++OHT/zy7L9G9KDHxBKDrJcggygqGsKRhGcwsf6Lk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWOVqthzrf+kbm+AdXZjLo27b1VLkJuRweaqaSnPXh
 AZDQYeOqSwMwpwMsmKKLE9kwk4vb19c5WC/8gfMHFYmkCEMXJwCMJHbhxkbbh63vdhauGt76OtX
 MclJe6/dP5OV8pqJzzXT/c1vk6Ns4hzS6zuts4xSjvNe6ypZfTmUseH8PLX/ZzNat+7oX3ZthUq
 L/fzDaoInZadJLlhswBkguOXtOXbpO56+xYvFBcXYciPqbAE=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_bridge_chain_enable() enables all bridges affected by a new
commit. It takes the drm_atomic_state being committed as a parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 41bb3700ca7b6f267a75481ae942b9357b5777c9..fa2794217a903b6c61e58edf14756a72f99dad38 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -766,31 +766,31 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 
 /**
  * drm_atomic_bridge_chain_enable - enables all bridges in the encoder chain
  * @bridge: bridge control structure
- * @old_state: old atomic state
+ * @state: atomic state being committed
  *
  * Calls &drm_bridge_funcs.atomic_enable (falls back on
  * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
  * starting from the first bridge to the last. These are called after completing
  * &drm_encoder_helper_funcs.atomic_enable
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
-				    struct drm_atomic_state *old_state)
+				    struct drm_atomic_state *state)
 {
 	struct drm_encoder *encoder;
 
 	if (!bridge)
 		return;
 
 	encoder = bridge->encoder;
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		if (bridge->funcs->atomic_enable) {
-			bridge->funcs->atomic_enable(bridge, old_state);
+			bridge->funcs->atomic_enable(bridge, state);
 		} else if (bridge->funcs->enable) {
 			bridge->funcs->enable(bridge);
 		}
 	}
 }

-- 
2.48.0


