Return-Path: <linux-kernel+bounces-249105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0792E6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD868283F67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8015ECCE;
	Thu, 11 Jul 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gxzGKVt0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56226156225
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697235; cv=none; b=V/3w/5puiR07WPutD2EfPDYW8KbE0rdwElt55oYHTQE49+JjO131E7+vziL6nbKG6diszWEWGApfhokmWCraNH2ekQZlUlP4JWRPE3iUTKwionqXpTNRs1Cr3z5Zoqy0h7oM6Uw38o1SoCVv+E6UUbqEi69rFEqBz6UjZnVCTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697235; c=relaxed/simple;
	bh=yYEpV6mgz8Ga+AjpAiMeT63sbhybaoeCYkwkqiyqnac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=maiLSeAymNpBurDHFIAk2Ey9LPLJ9dd4dhBhuuV+Jz7sJDExYgj4m5ru+xK4brVNIObhyDR+QZ5P6qI714+lc54gQo9ahDwNyrW92r9ldo9sPzNaaut7g5Y7bUnPhosaNtppyGKWcGtPKmD6d6SFImlaUsfL8H5uhD2QIC3n4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gxzGKVt0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720697232;
	bh=yYEpV6mgz8Ga+AjpAiMeT63sbhybaoeCYkwkqiyqnac=;
	h=From:Date:Subject:To:Cc:From;
	b=gxzGKVt0luCl6OOlv0XQK3+THNu/Uhyz5wMbAEccZfD0XM0QT7SuJjenzhqIVKNoh
	 aUIJd4h7GapobNbaX/77BoMfw2ho1mCc+oBMnFt8K40mKw2TXs9WV9vLTxblXghEqF
	 j4g4eVNTJy/tLRcOC+qPVsDzrN1vTuo3brD1YeD1g+OKfamKswz+aPCOCTrtzJKElE
	 H3GnJE5i10k9BNQW7MPxmBmb+Sf6qv95DNEJ9LBNuF84XH2BbaNF4shu9YKVfSlyaH
	 PaQ96RWNwN7a9DAoZxoGejHxJ3jdIlBWhjYlAjFHXEbyz27zONq3R9m1zJQH3ghulT
	 CeYTimGF7bV+w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4DAF63781185;
	Thu, 11 Jul 2024 11:27:12 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 11 Jul 2024 14:26:55 +0300
Subject: [PATCH] drm/bridge-connector: Fix double free in error handling
 paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
X-B4-Tracking: v=1; b=H4sIAH7Bj2YC/x2M0QqDMAwAf0XyvEDbFWT+iviwNqkGRiupyED89
 4U93h3cBZ1VuMM0XKB8SpdWDfxjgLy968ooZAzBhehG7zGpkNncauV8NMUiX6T0waLM+CJ6hlh
 cCqMDe+zK1v//ebnvH4bFYfJvAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The recent switch to drmm allocation in drm_bridge_connector_init() may
cause double free on bridge_connector in some of the error handling
paths.

Drop the explicit kfree() calls on bridge_connector.

Fixes: c12907be57b1 ("drm/bridge-connector: switch to using drmm allocations")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_bridge_connector.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 0869b663f17e..a4fbf1eb7ac5 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -443,10 +443,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			panel_bridge = bridge;
 	}
 
-	if (connector_type == DRM_MODE_CONNECTOR_Unknown) {
-		kfree(bridge_connector);
+	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return ERR_PTR(-EINVAL);
-	}
 
 	if (bridge_connector->bridge_hdmi)
 		ret = drmm_connector_hdmi_init(drm, connector,
@@ -461,10 +459,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		ret = drmm_connector_init(drm, connector,
 					  &drm_bridge_connector_funcs,
 					  connector_type, ddc);
-	if (ret) {
-		kfree(bridge_connector);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 

---
base-commit: 1eb586a9782cde8e5091b9de74603e0a8386b09e
change-id: 20240711-bridge-connector-fix-dbl-free-9dd324f0b270


