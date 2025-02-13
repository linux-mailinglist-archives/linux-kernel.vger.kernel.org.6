Return-Path: <linux-kernel+bounces-513180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65863A34373
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D40C16E91E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC5245017;
	Thu, 13 Feb 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeob8JLm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BE245011
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457861; cv=none; b=Ug1X6OVDgur6w2jKYlOuoIDxZR9cu18XoFPrxS5R9O3Mdv2778mnra90dBgteC85XlX3cpni2Ot0cl+vnWBKswc6FXph9y0fDTujHtIlmPdmIiSBjtksiGlpMUIPi+P8sJUq6/t+63rVh/EUZ16a4e/yzn+fmt+nNsyF7lkA/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457861; c=relaxed/simple;
	bh=52uVK/rb7u8V6tG/9ABcRRDv4rmXXJOzJ2Xv/qtF3hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRmR53b0y3ViUTkIwHuzFtj5q1rEDf+JA+9IcYacVa2zMAeOdo3g3J9sNLBbshAEpQqkHQi05xHMIgkK7F7MiqYL1YiwwNB31RNOyvlWuCalogi78ecdWmhu+EN2DgwwSTdpMGsQ7EJX/LmG9nWA418aCZ9NeFfSPDmmKaG5NDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeob8JLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586ACC4CED1;
	Thu, 13 Feb 2025 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457860;
	bh=52uVK/rb7u8V6tG/9ABcRRDv4rmXXJOzJ2Xv/qtF3hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qeob8JLm2puH/aNTZfiQ07qH7ELP3l1Kxlv6Lmw4zrOpb8GVFcHIZ8XnPEnY8neff
	 DebELHRNhcE7W1Uvdjt7PEeA7T6La47ea9LMsp8VdlV8HPWQMSdJtLO/9q4pYMieZq
	 +AGNjah9IlyV6srEYUu7Tr+pFV+wgZ6faC2Y95pjGak6ss5tCSHnecs0ygO4/UHgMR
	 1bT+Y1YxMCH1I+iD3uXIRxh3xlIDPSMurlVsbz0JzGqtVC3k1/BOSM/ABvgJTBrGgv
	 LER+T+ZeTOB2BK2eIavMMSSFeu8KKHNscxJbieY9ugcomDmMlDSvUd7rGzEA/Cn0GR
	 LfSOEhu0opb1A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:28 +0100
Subject: [PATCH v3 09/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_tail_rpm()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-9-e71598f49c8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2592; i=mripard@kernel.org;
 h=from:subject:message-id; bh=52uVK/rb7u8V6tG/9ABcRRDv4rmXXJOzJ2Xv/qtF3hQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWCV3cxzdW6EeLh8ksfjeH7GQgxZOKmyCGv/nP6qaE
 e33IVOuYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkYjRjfb7NVx+LjZxi9Q7m
 x/1+xe0RTf8X6u5+4ZJBxcMcA68HD+oDT/zdqn/O5VzTpS3aFfyCjA2H+T5mB0+1VZq3b9YMY8/
 zC58uU6q8ypO76nGb382iq15VS9mv/ylgEtZn2Sj6Tiv6vBAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_helper_commit_tail_rpm() is the final part of an atomic
commit, and is given the state being committed as a parameter.

However, that parameter is named old_state, but documented as the "new
modeset state" which is all super confusing.

Let's rename that parameter to state.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index fbff59f9c00e319a7649c6961c60839dc302a44c..e5484ed31cae24700ff64ccbe67c570bf46b8ddd 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1799,36 +1799,36 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *state)
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
 
 /**
  * drm_atomic_helper_commit_tail_rpm - commit atomic update to hardware
- * @old_state: new modeset state to be committed
+ * @state: new modeset state to be committed
  *
  * This is an alternative implementation for the
  * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
  * that support runtime_pm or need the CRTC to be enabled to perform a
  * commit. Otherwise, one should use the default implementation
  * drm_atomic_helper_commit_tail().
  */
-void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
+void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state)
 {
-	struct drm_device *dev = old_state->dev;
+	struct drm_device *dev = state->dev;
 
-	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+	drm_atomic_helper_commit_modeset_disables(dev, state);
 
-	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+	drm_atomic_helper_commit_modeset_enables(dev, state);
 
-	drm_atomic_helper_commit_planes(dev, old_state,
+	drm_atomic_helper_commit_planes(dev, state,
 					DRM_PLANE_COMMIT_ACTIVE_ONLY);
 
-	drm_atomic_helper_fake_vblank(old_state);
+	drm_atomic_helper_fake_vblank(state);
 
-	drm_atomic_helper_commit_hw_done(old_state);
+	drm_atomic_helper_commit_hw_done(state);
 
-	drm_atomic_helper_wait_for_vblanks(dev, old_state);
+	drm_atomic_helper_wait_for_vblanks(dev, state);
 
-	drm_atomic_helper_cleanup_planes(dev, old_state);
+	drm_atomic_helper_cleanup_planes(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
 
 static void commit_tail(struct drm_atomic_state *state)
 {

-- 
2.48.0


