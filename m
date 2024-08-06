Return-Path: <linux-kernel+bounces-276327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7D949225
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CC01F26E46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229220FAA2;
	Tue,  6 Aug 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pMLv4XFD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0A205E3C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952273; cv=none; b=ozAwM8t+mc0ywe6526nhHnN8SJwigfQY9/3PejsnPFXl63Qkn6LUxjvEq095+ECmi2/F/WbaG2sypqBXevV0kLJVvC22PYnR3xukES0LT+c8zloboWp8xDjLBEW1RZrqndWIyTzqQzx/LYcfUBCiwR8cxhSHrQ65psTeFy35SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952273; c=relaxed/simple;
	bh=a7acWR7Le5QkCzpyIDk+oh+JY2htlUFkpLsst2Ppr5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9dpsypOrGFzRtQFGHancuI/DXpCuUnKSfLiULaQ5gPzY7AGs2fvIJGL78Dwo2qdfOkPq5S5C6dGKLKk/vIf227mR9vuhaMH74RyukqubjgZNDLhFzllduQLa6QoerS/WudC+H2ZNjovEundHL8Fg09m/WtYI4Wu/N/u4PhNNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pMLv4XFD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-156-87-48.elisa-laajakaista.fi [91.156.87.48])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 934F9BC0;
	Tue,  6 Aug 2024 15:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722952211;
	bh=a7acWR7Le5QkCzpyIDk+oh+JY2htlUFkpLsst2Ppr5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMLv4XFDxqgoCHeS+aoTA5qcAOrRGxJ+ZnIcsFsAaO3fg9vgUVfLcWi0v/+E6h42W
	 m1yEx4ayuwIQOZenO2+jRBT6+G932+Bhlg51VWw3ZeJxUBxQoVwVYwf89BrX48u33A
	 Nb9qJty70aqhXNK7ot8n0f3KODqOU1FRPOdhw/4s=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 06 Aug 2024 16:50:29 +0300
Subject: [PATCH 3/3] drm/omap: Fix locking in omap_gem_new_dmabuf()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-omapdrm-misc-fixes-v1-3-15d31aea0831@ideasonboard.com>
References: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
In-Reply-To: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=a7acWR7Le5QkCzpyIDk+oh+JY2htlUFkpLsst2Ppr5g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmsipDMaYFgD5vpr6RkMRCIoSv3wdaUuKlQkb6e
 c0lVrFNyq6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZrIqQwAKCRD6PaqMvJYe
 9bWTD/sER6U4oJPVWCNmpL47P1MhAcA/AeSBxXG1cNtcoiSYfqOQ1thxFi0/e0JAxzqWnTHt+YQ
 ottXymv3nS3o5+mJIskRtpywgI2oE+IVnSF74BwxwUxIerY58q9bR7O0XpttkpjAqn89RVU20qd
 5e7WLWd7w74cbjCLw8iIx+7kEg6k0Pf8t0q0kqk+ET2ZeETO0Mfgbx2WYjZJ/+8d8CcYfyefP/7
 M3VUH/Ry3MM3gPSHJyvmFNOxlGbPAFp44Q0vI3hOOSizf0Rv2Y2EbbXYnGZRfJmVWkFeZbH8Omd
 Dgr2mC8dYAN8IlZpwyuc3LTbr07WRu4p5tH+nOTDXfqxG9zJC0PFUA8XUL5UqQ7a1nug9gkNigd
 6H3mTl1nD/qYeHnc7sVDfL3J6nBMsTx6mtQb8rLpnKwJxl7CKzXe3qUT/6FBCiiwlg/FP1jFQ9x
 djWSBbK7HXiIX7sMgsq6ukm3WCVxXteu9mtoI1glUcnska1IOEBdgfBhv3DrV/XiX7cZHtYEWch
 uCE/Tusn9UjJzZvoG45e803hGjP+gI/Ycb6gAwuyv14bmoxDWrof2yqleyGfUVQpkWzCGcmrq1Y
 uJ+POEQ44gloEwXZ2if9Rs+FdYweYlIUVsGETkkSN7I6k9l4zH7s1TaK560EVYUr+o3Pc9DpSqN
 VZJ8Qf+zKwux5OQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

omap_gem_new_dmabuf() creates the new gem object, and then takes and
holds the omap_obj->lock for the rest of the function. This has two
issues:

- omap_gem_free_object(), which is called in the error paths, also takes
  the same lock, leading to deadlock
- Even if the above wouldn't happen, in the error cases
  omap_gem_new_dmabuf() still unlocks omap_obj->lock, even after the
  omap_obj has already been freed.

Furthermore, I don't think there's any reason to take the lock at all,
as the object was just created and not yet shared with anyone else.

To fix all this, drop taking the lock.

Fixes: 3cbd0c587b12 ("drm/omap: gem: Replace struct_mutex usage with omap_obj private lock")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/511b99d7-aade-4f92-bd3e-63163a13d617@stanley.mountain/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 9ea0c64c26b5..ebbe80c1c0ef 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1402,8 +1402,6 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 
 	omap_obj = to_omap_bo(obj);
 
-	mutex_lock(&omap_obj->lock);
-
 	omap_obj->sgt = sgt;
 
 	if (omap_gem_sgt_is_contiguous(sgt, size)) {
@@ -1418,21 +1416,17 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
 		if (!pages) {
 			omap_gem_free_object(obj);
-			obj = ERR_PTR(-ENOMEM);
-			goto done;
+			return ERR_PTR(-ENOMEM);
 		}
 
 		omap_obj->pages = pages;
 		ret = drm_prime_sg_to_page_array(sgt, pages, npages);
 		if (ret) {
 			omap_gem_free_object(obj);
-			obj = ERR_PTR(-ENOMEM);
-			goto done;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
-done:
-	mutex_unlock(&omap_obj->lock);
 	return obj;
 }
 

-- 
2.43.0


