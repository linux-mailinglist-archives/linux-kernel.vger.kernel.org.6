Return-Path: <linux-kernel+bounces-513195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E5A34399
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4661888577
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552226B089;
	Thu, 13 Feb 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7zCaZ0G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FC241684
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457901; cv=none; b=E0/mCu3lre20fXswYzPg8Wo52a9u++oYHfrFUofJh9TyblMTFjMVMNHZeozl20l0q2bYhMUBPN5VZ8Wftmvx96XgvvlRUTwkDjTo/RGlZWfw4loTKTEecPeC+hYtjOI0lej8EVUn2K7IBlAA00O+421j6jma5BYefAto8ID79EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457901; c=relaxed/simple;
	bh=C1A9IEgT2YApuD/rIJh3Cq5kR2HpRAe1NB3F6wBv3uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSwlYVRDcadUYSZ6d26ryh9FXgOPNZdUUtQwb6/2pJgoI+pHZEs8zNYRi2J8XDiu9k3tNZDzLHMuTb94+8zi9GOQl421W+QIC/fXe0XqJByjgB/si9wUtnVHr0vOgveb5lfbSVeI2ekZJdhyJQ94yF8CtAgaBaGRXllkzCsgUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7zCaZ0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE2C4CED1;
	Thu, 13 Feb 2025 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457901;
	bh=C1A9IEgT2YApuD/rIJh3Cq5kR2HpRAe1NB3F6wBv3uQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7zCaZ0GPOachMEglrnum1WgdjKGkeH/43gK7mcsL652O0YwyNJyDlp2SXJpHSGtw
	 uQFEd3aDO5CzP4ezP6lGtyhDZcCszuclUvWb1qCYMUTOEVKSMGjROnYjcvkCgBPmqx
	 fgT2jaPI7wOPWLh5IlEcWvD1tWvues4J/rLkBHXUQkGDiLgaan0HPd6SOHPH3fyBd+
	 lB0tT8swrMhu9EL7iq9KHriDHI8KNClc5AaP9ui251BSGPbpF/Z715/tEhAi4bfesc
	 xk8zsZzWhw5lilzNsNwoN/PHItrJ6S699E6+y5nOZdaN6hVmO/1zSmSNcc6btPfEI+
	 kinfnudCMNMrg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:43 +0100
Subject: [PATCH v3 24/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_cleanup_planes()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-24-e71598f49c8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=mripard@kernel.org;
 h=from:subject:message-id; bh=C1A9IEgT2YApuD/rIJh3Cq5kR2HpRAe1NB3F6wBv3uQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWBW+mnJf19p068jdSbM2Zy8Ramtry1l8w+COC/ecu
 08DGozudExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJWP5ibLiY0b4/vfqlmXNM
 57M605l/Y+JvdTWln5QWllBc3LP4yNSoFa/VP/Se1zFluMe8V1d7KWOtkKtPq/eWC6r3l+z5K/u
 5sV+htimp+ueJaSGe5xYF71DdUcUh8M7Aczp30fP9yesPKxsDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_helper_cleanup_planes() is one of the final part of a commit,
and will free up all plane resources used in the previous commit.  It
takes the drm_atomic_state being committed as a parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d2bd7862e0158647d9638a6db25a8743f89ad7c6..c4de263f7c0dc5750bc99cf8f719707a7e384de9 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2987,28 +2987,28 @@ drm_atomic_helper_disable_planes_on_crtc(struct drm_crtc_state *old_crtc_state,
 EXPORT_SYMBOL(drm_atomic_helper_disable_planes_on_crtc);
 
 /**
  * drm_atomic_helper_cleanup_planes - cleanup plane resources after commit
  * @dev: DRM device
- * @old_state: atomic state object with old state structures
+ * @state: atomic state object being committed
  *
  * This function cleans up plane state, specifically framebuffers, from the old
- * configuration. Hence the old configuration must be perserved in @old_state to
+ * configuration. Hence the old configuration must be perserved in @state to
  * be able to call this function.
  *
  * This function may not be called on the new state when the atomic update
  * fails at any point after calling drm_atomic_helper_prepare_planes(). Use
  * drm_atomic_helper_unprepare_planes() in this case.
  */
 void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
-				      struct drm_atomic_state *old_state)
+				      struct drm_atomic_state *state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
 	int i;
 
-	for_each_old_plane_in_state(old_state, plane, old_plane_state, i) {
+	for_each_old_plane_in_state(state, plane, old_plane_state, i) {
 		const struct drm_plane_helper_funcs *funcs = plane->helper_private;
 
 		if (funcs->cleanup_fb)
 			funcs->cleanup_fb(plane, old_plane_state);
 	}

-- 
2.48.0


