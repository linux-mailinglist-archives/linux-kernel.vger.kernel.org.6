Return-Path: <linux-kernel+bounces-398055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DD9BE4BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1D61F269FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2D1DEFC7;
	Wed,  6 Nov 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fl1PBQ8v"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1B1D278C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890128; cv=none; b=nQHZcGp3rWstURUjOksjLUr4UfAhu8v4tFUMkz620PqULf/EfRilLaU8NFK/t+riDDv2iqL5uMpI6cMSrvDbb4AqfzVUlCYcn07emigmM2cfisRSJ4Fwfzwdz8EbLvoX2UxA1vu0jTtOb9R875lEroXURpOrLF4T90TV7sYUW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890128; c=relaxed/simple;
	bh=4binOEGfu3XAPZLpw+QDubNdxl5QHjAjAsV26Hkdbos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fccBmJS8iVV2mOr+piGkBYKbhUS0+bFKEaNuh5Ap5VjhaO0ASPu20j/5c3iDaHejE94OTlPGATS6bYLwiMIF75FvGIDiZG596RVERWSXij2uLPUKqp5wOR6JyuH/qvANbgnj3g48uPWW2n1hBDn8vLy9tJhx9ESFLXXpLzpiewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fl1PBQ8v; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B00336000E;
	Wed,  6 Nov 2024 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730890124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pRM5jscZII9GohdxbWbdZ5ZoYRQpxbmot/dqfyy/mM=;
	b=Fl1PBQ8vf8xbrbvYM3xWTxSpEI3DdCvhNIBTbOYp6R+eDrsVaCDOKt0Jox0oPfimU1B9YA
	pHfLSpEqovaIxofsgJhE/kStmQesRRrZ0t/Pkptx6G3Uw4xLiTPe0CXzwD4C7H0dsR7/Y6
	qi89zz5Y3iHIs+mDjaicJW1eeYQeGDzVj7hbBvDspF6VZg5nuR5TEksv97XYsCvG7n3yXd
	qTicJU3CcnPNi6EO8gP0kxj9vMtjnTdTJ/YtBcGqYe8jJTyMdO+/L/d71J8lmwKWod57eL
	ANYApORKl9n8h07Ab2yZpYzTsbZBgcDUvkwCqzdpiYbM9ClTo6iBsepwJHBi4Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Nov 2024 11:48:26 +0100
Subject: [PATCH v2 3/4] drm/mode_object: add
 drm_mode_object_read_refcount()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-drm-small-improvements-v2-3-f6e2aef86719@bootlin.com>
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
In-Reply-To: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Add a wrapper to kref_read() just like the ones already in place for
kref_get() and kref_put(). This will be used for sanity checks on object
lifetime.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_mode_object.c | 20 ++++++++++++++++++++
 include/drm/drm_mode_object.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index df4cc0e8e263d5887a799cf1a61d998234be7158..f990cc7e9b5d3bda3453123593314fa1ea2bf923 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -217,6 +217,26 @@ void drm_mode_object_get(struct drm_mode_object *obj)
 }
 EXPORT_SYMBOL(drm_mode_object_get);
 
+/**
+ * drm_mode_object_get - read the refcount for a mode object
+ * @obj: DRM mode object
+ *
+ * This function returns the current object's refcount if it is a
+ * refcounted modeset object, or 0 on any other object.
+ */
+unsigned int drm_mode_object_read_refcount(struct drm_mode_object *obj)
+{
+	unsigned int refcount = 0;
+
+	if (obj->free_cb) {
+		refcount = kref_read(&obj->refcount);
+		DRM_DEBUG("OBJ ID: %d (%d)\n", obj->id, refcount);
+	}
+
+	return refcount;
+}
+EXPORT_SYMBOL(drm_mode_object_read_refcount);
+
 /**
  * drm_object_attach_property - attach a property to a modeset object
  * @obj: drm modeset object
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index c68edbd126d04d51221f50aa2b4166475543b59f..3d2c739e703888bf4520c61594d480f128d50e56 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -123,6 +123,7 @@ struct drm_mode_object *drm_mode_object_find(struct drm_device *dev,
 					     uint32_t id, uint32_t type);
 void drm_mode_object_get(struct drm_mode_object *obj);
 void drm_mode_object_put(struct drm_mode_object *obj);
+unsigned int drm_mode_object_read_refcount(struct drm_mode_object *obj);
 
 int drm_object_property_set_value(struct drm_mode_object *obj,
 				  struct drm_property *property,

-- 
2.34.1


