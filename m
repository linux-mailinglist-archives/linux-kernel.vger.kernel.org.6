Return-Path: <linux-kernel+bounces-319190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FE96F91C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62901C21608
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3211D4171;
	Fri,  6 Sep 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KB4ENeco"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C01D362B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639313; cv=none; b=EB43g5f2IHpbX4S5mUCqW+Wf6o/35jyT8YAO4iaxi/Rop6gdkaXEbmTBt9Mqml6/164PzMUk/wBoCg/D98h3IPmmaN4DIMviMnfmNewedRSOJzVUYdT7y4CZODdvrOqeJD8DeSRSX1i11v/8dD6ITIKrIJvBGNPFUWuZbZjISoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639313; c=relaxed/simple;
	bh=iSCIYXd8JJ0yfB4/YW7mtkxVQvJuK/tFIsGk1qmWCO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pUkQLsWJqB5TfCVQQbJPejHqXwwAgLcEGURGSFX1snhgOD8YNScFVhQTKF4O3wfbqXKGjsQeoAf3aWWFUXRDpwrD9LUdBkQ7FNH+ohpbH03yjdVrSj59/PGOySkHezpVSNwLCammrenLBizxwKn/rrbvcyAEs361DMrb4bdspFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KB4ENeco; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CC71C0004;
	Fri,  6 Sep 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725639308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q0PnbrhF1O5fN1oqIgr5KPh4QtUbDp9bJEI4UAGjXHQ=;
	b=KB4ENeco7YyieKpKIx3rPRs6rRSjmfka09HrCf8Em5yU00HB/pPEj7uvKF8nWXS+1OqffG
	edlCqZbvdaeLRyA6oraXGbD3l0rl2WlmIr6WxuccCxz9k4aqBink9jXY2BJDDW1mlpV2EJ
	srpKx01l8sahDmEwmUDAVZzfFgwfIC+7SKGkbgYkloa9+QCmBDqcupLJ3tmxFLoxccBzu/
	HjNJzDYnKKXeUmb710P+E5xG2DKwUwPcWFOq3q7KzD/qvPIL+xoXr6u+MPYyDWF8ID24It
	hMh1x5/ZJj4oUTp5LxwDRmuGPr1W3ccUaDl+fz+nt2KWbSJq0JzL810zx1jpqw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 06 Sep 2024 18:15:03 +0200
Subject: [PATCH] drm/vkms: Add missing check for CRTC initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-vkms-add-missing-check-v1-1-1afb3bf3d0a6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIYq22YC/zWMyw6CMBBFf6WZtRMLGiL8imHRxwgT0qKdSkgI/
 26VuLvnJudsIJSYBDq1QaKFhedYoDopcKOJAyH7wlDr+qpb3eAyBUHjPQYW4TigG8lNSJVtiG6
 +spcWivxM9OD1F773Byd6vUs/HydYI4RuDoFzp3wK36A7/wdGWjP0+/4BgDmxV6IAAAA=
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=iSCIYXd8JJ0yfB4/YW7mtkxVQvJuK/tFIsGk1qmWCO8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm2yqKxmnf/KuDIrZgHU7yobFH88ctGQ1uL5ixH
 5kiONWKGcuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZtsqigAKCRAgrS7GWxAs
 4vjwEACyrhtIbPu6IwBIDsy9yrifGo3ghgr/BtMLTkIjCWdLrF6MTBce228A7wf9n5rJSIXF8XY
 bJ+h3tJrhsVCtJQt1z0UgQPSaHCfE4Plv223T/mlS231hcSp7dtjNBxxEWbmfteg9sb63MJRnN/
 E5hSkHWlwrbQj7e4uTgDAhP4FP5FgOV9oUxpPLdtAaSrJ29EfjLPyUaOCTlTOL7p1Gdloiz+ys6
 0e1mXXRbcCl9Hf0FClqeGcWsGkl3kKy1MvAZU5YJpEwLebPYeub1mWoFqjwBRIrq8y1qsIgCn0i
 MJOk1SkehBh0PyF5f41NMsgC24MiWRmFtzkFTVIGxwSuM7gl5mZUovi1c/aGBn/OyeCMn7cumR+
 MbcNGESdv3kXVJTNbg4zB+fEnaMpLdfCkQzzng9X1TEc9jGPMo3fS/nMyMbGr75cBd05POlSQJk
 0SJVuppmJr6ZRJT2Zg4GsWOrYyCSCXIdLI8pVhuD3VU1gGZonfRyeGbutiOUddyfTgeQiNU3WD1
 DiZy8DxEAJgnSIvrPPtgxAq3F1H71eDkpD4fXKqmoQ3Uy+yrlfSupuD4DxmIsb0kteQIU+cCL4G
 +bN30ChfMnzCOhEm8cfMTAwq/0GM71PtnB9RSBZOIrXdSF8FiJnolCZgZGu0DuJDyXEHEbeOmdB
 fg99kJ3WOg2N44Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

CRTC initialization call drm_mode_crtc_set_gamma_size without the proper
checks, introduce this check to avoid issues.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 40b4d084e3ce..e4f93dfbd071 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -287,7 +287,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
 
-	drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
+	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
+	if (ret) {
+		DRM_ERROR("Failed to set gamma size\n");
+		return ret;
+	}
+
 	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
 
 	spin_lock_init(&vkms_out->lock);

---
base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
change-id: 20240906-vkms-add-missing-check-e1b6ee8d1b39

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


