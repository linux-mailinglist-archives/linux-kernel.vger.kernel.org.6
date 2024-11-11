Return-Path: <linux-kernel+bounces-404049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A009C3E87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F857B21451
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277319DF48;
	Mon, 11 Nov 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ik/UjZ5k"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD21199938
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328591; cv=none; b=ABNGsDc3wbPPXLQ3a41VEQa9D7dEKD7eSa7jLIOo4+BXQGEGPisgp3x8envlA7nULatTO4+ng1h6ADKGq9gRFO8Qj8Op71brFJVCWGgGWJwiI+ka7P4zsIWLHTlvvd8xN0luk4qR/AA+Yu3kXih2ajVUyovmD6udBXsXPC0y1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328591; c=relaxed/simple;
	bh=0SJMUdIo0vcYqeGqB8sU7dxtzNBNywrmH0+lcVQv05E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGwutuSSzPxRdxxoASOv4CWnd9JW8qRWhr+eVLFzhjsbTdfXRw3sR/GnsjbyqiKlBnpWiXHTSCp6NqRIayB1aqN8Lc5TRM0yubxoZqHvNREeaUbPaWM+iim1tGb/DFbHUL5rDXybQ6EpgoZ06vgSyVW2jIfBIkXLeMBzA7vgRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ik/UjZ5k; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BCFD1BF206;
	Mon, 11 Nov 2024 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731328588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J90J1NyXaKoXccZe2X72ycchhXTtGFZ2PH6GpQkBJsQ=;
	b=ik/UjZ5kr0Ad8hjStoOIneAgh2ZLiENJBEpnLMi+S8NqjvfpY0KieoBs+OZnU1Zk5hJ0C5
	VYH1y8+uGfLFccje9VR5csfmr8SU5+rrE4Kx4IqVhcdDqhWh+C2Lyuvye5K2zBf8ffNYQa
	rNXGKsWsDEN8qvCUFa0eHQrvbatX31gPKYcVMIkJelOKnNZwiKDh/Hp742tv51ApX3cJuZ
	+GWZuOKU4/RvIqDCCNiZkfuHmimrd4RHvtUSMS+W9NjKmMyd4ikKgEIjhZez/W1bVFZ4zb
	bAObfeKbIPuXoPPIGSV0PcaDl5NdOPApsGonT+Spe5vy4zwen7pn/YYQcur54g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Nov 2024 13:36:22 +0100
Subject: [PATCH v3 3/4] drm/mode_object: add
 drm_mode_object_read_refcount()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-drm-small-improvements-v3-3-a9f576111b41@bootlin.com>
References: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
In-Reply-To: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
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


