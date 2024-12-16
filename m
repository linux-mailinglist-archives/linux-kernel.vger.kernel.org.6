Return-Path: <linux-kernel+bounces-447711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641E9F364D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198D61883C25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7F206273;
	Mon, 16 Dec 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TfXKhGw1"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824611B87C4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367275; cv=none; b=F+CyIR15gb8nJBL825dSR1PccSCQsScKGutdjCvT09t+Q3OnAdYtBeURfs8ZmmNwK5HOw8mB7+Z+qYFHHlWoX64Tj/Di5mMeEO+Ojwo9PYxrqcoAlW0OcW+46e8k6dhPp86kDpIZbMKgGkBw3v/gfArobl58kRrpi2j1zgbocdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367275; c=relaxed/simple;
	bh=0SJMUdIo0vcYqeGqB8sU7dxtzNBNywrmH0+lcVQv05E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgWzmMQl9DHX0yTJX93EuqjoOWVv3pYDuwjzIoetNffutT4upbjr7ahTT1AK6XyFTQl8Qrrbkj/TTB+maQV5qkRG4AvnzfjDQx5tNgvuBO4Y6aBQu2OKfiL9qePei/I1y4lqPn03AmTp41a7/9h2cSnpfhCLwGMD287XX/GZAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TfXKhGw1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB879E0003;
	Mon, 16 Dec 2024 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J90J1NyXaKoXccZe2X72ycchhXTtGFZ2PH6GpQkBJsQ=;
	b=TfXKhGw1Xu1kMTIPHWCUs8aLwUWzuTKGvJ4j91Qfd6r0hlmwy9jqbDGUa3nK9YjKpnJnwP
	cK53r5KYTSI9yx8tH/zjuFZhBWgUTpbaJX8x06dQO4fSlDokEEimr5TcZHmb5krbdJ60hL
	FMAd7Z8uS7G/ROKDCzU156r1kC6R8C231T1QzABHhYsQA1nX8PrulSaGWMogyY1wzibSjU
	bsqZCDq+mHrv4t5A5dfbxYfHsK4DAh9lOKJ4L7A9IPeve9fYNtC6WAmruHJSg/a8cPNZhk
	8lp0QQaqPShbNAC1lTe4zRpFQxtsqtF9rE8Ajky47TvAs297yqgUvcnumi+Jgw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 16 Dec 2024 17:40:50 +0100
Subject: [PATCH RESEND v3 3/4] drm/mode_object: add
 drm_mode_object_read_refcount()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-drm-small-improvements-v3-3-78bbc95ac776@bootlin.com>
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
In-Reply-To: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Add a wrapper to kref_read() just like the ones already in place for
kref_get() and kref_put(). This will be used for sanity checks on object
lifetime.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v3:

 * use conventions for 'Returns' doc syntax
 * ditch DRM_DEBUG() and as a consequence rework and simplify the entire
   function
 * fix function name in kerneldoc
---
 drivers/gpu/drm/drm_mode_object.c | 17 +++++++++++++++++
 include/drm/drm_mode_object.h     |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index df4cc0e8e263d5887a799cf1a61d998234be7158..b9a16aceb926782eb033434eb6967ce9fd2e94f7 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -217,6 +217,23 @@ void drm_mode_object_get(struct drm_mode_object *obj)
 }
 EXPORT_SYMBOL(drm_mode_object_get);
 
+/**
+ * drm_mode_object_read_refcount - read the refcount for a mode object
+ * @obj: DRM mode object
+ *
+ * Returns:
+ * The current object refcount if it is a refcounted modeset object, or 0
+ * for any other object.
+ */
+unsigned int drm_mode_object_read_refcount(struct drm_mode_object *obj)
+{
+	if (obj->free_cb)
+		return kref_read(&obj->refcount);
+
+	return 0;
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


