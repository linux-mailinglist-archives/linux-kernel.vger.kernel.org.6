Return-Path: <linux-kernel+bounces-513201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC96A343A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6956816ECBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462D1D516A;
	Thu, 13 Feb 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6HbeCUn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566619E975
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457917; cv=none; b=OCq9x0ldVsuZ1JzAiL9NgQRsR0g/B1jAyWKdCBtlj5YXLbodja0p1GRJjDEF/fGmXdVafgaDG9o/KU6jvQbsIffur1l+w7MWTXRlOS0r18srhIszJ0g8MBrfaPgNRCID0ElVLdpmBVKUWSTAZoNbb8P+M3tEMtRJ7tV2wvqltLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457917; c=relaxed/simple;
	bh=KSXYWH3Ves9FGs7/gAI9crsBWVHKvvZPhvWTImVWl3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4QTxaQtEmCszqqqtC8zvwOo/RyUjohOviPV11T+TJC9/S3T7X7KCAWbt0XxyxAckBhkuf2R33IuNk3uj6PLZ0sSqU8TMy2SmZ4ZXY7pO2uNsKCjuQSLCv+n4PPwWMSNfPJzcpTDQWOdxisfbInrzaQKorxx4ViooRy95I523SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6HbeCUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415EC4CEE8;
	Thu, 13 Feb 2025 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457917;
	bh=KSXYWH3Ves9FGs7/gAI9crsBWVHKvvZPhvWTImVWl3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G6HbeCUnoMEqq0sib9Sm5hvc/g5lQc2ZL4c6grKhlXsSUOpXS/1I+5xBf6adm58s0
	 NUnzvmlZGthij0PvaYx8zbQG1BMGTxhb/vXjPdp5T8Gl7pGAs/G1B48a0NHMgeZ0fl
	 R3mTpvFaTnq6RnvSvUiDGizIaBiiWtu+V43bomessMCR9+a0CUKyc70MteOkpUUryW
	 6c86WKtJZjGO5vcB1r+E80toa93X97R2jwbu8IWKVDbycODdg6XiAFSbriS+o4FCas
	 jDm3YxeVCrX82dr7iErLsEFsND5tBp2SjCDnugaZZHTu0aUQYBMJHXhhcso756g2iM
	 EsX6FFLHG6b0w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:49 +0100
Subject: [PATCH v3 30/37] drm/bridge: Assume that a bridge is atomic if it
 has atomic_reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-30-e71598f49c8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KSXYWH3Ves9FGs7/gAI9crsBWVHKvvZPhvWTImVWl3g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWJUPJUQen3uaP/1F+JVMc23GzpAns88osIvMieIpn
 ysc+qOuYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExk+w7GOiVdJ93n817sUH1s
 XefG6lkql7OrpDdoccOxMMV/N5KmRjHu45eZu312oDt/foX4v7eejA0nLpTsbJnibnvKMNzg144
 TM9W/ph17//f3qrevYgVXqvJU7e7oTlji0xhrUHRzd8xD4bsA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The drm_atomic_bridge_check() runs the atomic_check callback if needed,
or falls back to mode_fixup if it's not there.

Going forward, we'll need to setup the bridge atomic state even though
drivers might not be implementing atomic_check at all.

We can thus switch to using drm_bridge_is_atomic() to take the atomic
path, and do additional things there in the future, or go the mode_fixup
route.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d2525d0b1324cc3a63e32f5bf6ca6c4f9034eb4e..b6d24092674c8fa33d9b6ebab9ece0f91fb8f8ea 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -803,23 +803,25 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
 
 static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 				   struct drm_crtc_state *crtc_state,
 				   struct drm_connector_state *conn_state)
 {
-	if (bridge->funcs->atomic_check) {
+	if (drm_bridge_is_atomic(bridge)) {
 		struct drm_bridge_state *bridge_state;
 		int ret;
 
 		bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
 							       bridge);
 		if (WARN_ON(!bridge_state))
 			return -EINVAL;
 
-		ret = bridge->funcs->atomic_check(bridge, bridge_state,
-						  crtc_state, conn_state);
-		if (ret)
-			return ret;
+		if (bridge->funcs->atomic_check) {
+			ret = bridge->funcs->atomic_check(bridge, bridge_state,
+							  crtc_state, conn_state);
+			if (ret)
+				return ret;
+		}
 	} else if (bridge->funcs->mode_fixup) {
 		if (!bridge->funcs->mode_fixup(bridge, &crtc_state->mode,
 					       &crtc_state->adjusted_mode))
 			return -EINVAL;
 	}

-- 
2.48.0


