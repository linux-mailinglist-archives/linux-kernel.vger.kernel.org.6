Return-Path: <linux-kernel+bounces-513189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA97A34383
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071111889E39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB31487FA;
	Thu, 13 Feb 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtVQUjsR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D823F42D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457885; cv=none; b=lPsYLwolcQ25P/bMaN8aD7U32J8MHGva1ZRK2NpIoJi9x+qXk1D/7Ts5OuCuscaPJ3dNSrhsL+tXWNIy37oH552tgtzeB8BMRBDxDC+0bOujBSErueUy7kiYJQSKBnK/vpzLtwVCyI4INw7JQuvur+rbNT75bDCVHtafRGHdGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457885; c=relaxed/simple;
	bh=bLQlvUPK5MwSbxTg0psAGWYR0TzhNMipULajeO64aDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieo2SY7SWjfXnUeevc4oy6fIyhvFEo65XO3G+fTpqiXDY3RARXcZ5M0ExegeoA24nVB3+ENj2YYpfjB2Ms3bHUTqsSn121ls/Y6ooKXer03oVPFbMuuF5d21pF4hZuJtk4sMzDeiC4kkoyqfr8/TbqSZK2Zi+fGTpd/EHyoeoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtVQUjsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C79C4CED1;
	Thu, 13 Feb 2025 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457884;
	bh=bLQlvUPK5MwSbxTg0psAGWYR0TzhNMipULajeO64aDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FtVQUjsRz4vK1aEKmVob8onLSENcSZAqKHPnaEaJxEVuMPLhyyWJ3tuhzwunOSlS8
	 Zg53bP6QVFkt2UaDj4bdve6VbCZLuoQ299ZHpcEaryVkbNsWUUQeMhxMDG//M+DV5n
	 5Dkh30aShTAno4UwcxktCJJu5NMAH92686Qal2+WYii+GzljpD8zqAT/Y79mKhVdOt
	 5ReY0RaVft2j6oUm4dn+TxRpey9K2VQn6PkAbdubn7lv0jE0L39nNvdjZMM+Xbica6
	 NHIrvo+SlgbxQn2939Y49x1w+sxnc/T+d8MoDYO6uuF0sJTcSejJ/SqdpLD+Hr33Tv
	 a6v5xoQiLXzXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:37 +0100
Subject: [PATCH v3 18/37] drm/bridge: Change parameter name of
 drm_atomic_bridge_chain_pre_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-18-e71598f49c8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2872; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bLQlvUPK5MwSbxTg0psAGWYR0TzhNMipULajeO64aDY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWOUEfs7o81DqlpR98iFjtm2eX7LLB0+J9R/2BHK99
 RQJePq2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykU42xzppx9+wjhQK82Y8q
 fviKXD3S4/jf9J2Y4arWIx8l5/scNz7PufXWgeIou/sSTxpVIgVMGOurvL8xn73G1CCoe3RfIa+
 AhpZe587iEyEP4z9XNxv6NBXaXL350ulPcLp8TqVTWLZBBQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_bridge_chain_pre_enable() enables all bridges affected by
a new commit. It takes the drm_atomic_state being committed as a
parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index b63ec3d0b285949ebe75f28b526e2833d0e6a850..41bb3700ca7b6f267a75481ae942b9357b5777c9 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -676,23 +676,23 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 	}
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
 static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
-					      struct drm_atomic_state *old_state)
+					      struct drm_atomic_state *state)
 {
-	if (old_state && bridge->funcs->atomic_pre_enable)
-		bridge->funcs->atomic_pre_enable(bridge, old_state);
+	if (state && bridge->funcs->atomic_pre_enable)
+		bridge->funcs->atomic_pre_enable(bridge, state);
 	else if (bridge->funcs->pre_enable)
 		bridge->funcs->pre_enable(bridge);
 }
 
 /**
  * drm_atomic_bridge_chain_pre_enable - prepares for enabling all bridges in
  *					the encoder chain
  * @bridge: bridge control structure
- * @old_state: old atomic state
+ * @state: atomic state being committed
  *
  * Calls &drm_bridge_funcs.atomic_pre_enable (falls back on
  * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
  * starting from the last bridge to the first. These are called before calling
  * &drm_encoder_helper_funcs.atomic_enable
@@ -708,11 +708,11 @@ static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
  * Bridge C, Bridge D, Bridge E, Bridge A, Bridge B.
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
-					struct drm_atomic_state *old_state)
+					struct drm_atomic_state *state)
 {
 	struct drm_encoder *encoder;
 	struct drm_bridge *iter, *next, *limit;
 
 	if (!bridge)
@@ -747,15 +747,15 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 					/* At the first bridge to request prev
 					 * bridges called first.
 					 */
 					break;
 
-				drm_atomic_bridge_call_pre_enable(next, old_state);
+				drm_atomic_bridge_call_pre_enable(next, state);
 			}
 		}
 
-		drm_atomic_bridge_call_pre_enable(iter, old_state);
+		drm_atomic_bridge_call_pre_enable(iter, state);
 
 		if (iter->pre_enable_prev_first)
 			/* Jump all bridges that we have already pre_enabled */
 			iter = limit;
 

-- 
2.48.0


