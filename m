Return-Path: <linux-kernel+bounces-348976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077C98EEBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AAD283EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E06158DD2;
	Thu,  3 Oct 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTi2trF3"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5AE13D245
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957225; cv=none; b=JEsBPgx75BQVNds0Xm4tun6O/YIH5avObOePUZ0RVMheyy6j2OQ2lTNz9OD79rLgppUT3NSah2cP84jJvb2YgHP0gQQFaJzdIhewwRte54eDY29u2j2vXDhJM+BG7klMeV1qHrLWcq29GFPMcrcQCW0a+2gcG8jMj1A64Zszkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957225; c=relaxed/simple;
	bh=nHw/Cgh/A45jVuav0wZXD/senHY2VZ6AM5LdzHqNegY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGSnzEtec0zRL9nzZfBrgh0l0FVVOscZdKvzNxyCgdJugNxUgKo9qd0U2LpkiL3oTuURnJVEzaMOMYHzKBYWSS/Ij5tNuK0DDbUZy8akmd83zSzbsIILEAibduLSLjWsvCCgA1DExy/3QUI9Q3Dsk+EnNpM1rctNsCIltpXEFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTi2trF3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71788bfe60eso713833b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727957223; x=1728562023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tENLZuUZDqCKRHgFd+nN+o31lrR5w79lUzAqq4taxj4=;
        b=NTi2trF33dE0nHylzPhjZO1OBHj/BuT5EOtY/LFySbvRcBsXgWVNgxwh5ZTVXxrPIH
         buzlO8Bdg6K5MHbffqn+VyeqgqLU7OUxt4ZdqQ/FRlfy83bGEiD09bsTU1pCEwcYkqCZ
         1DQ93DrQoY05UEWr0zXySk29DLy60z6Fm2ZB6/vHh3qKuQ64aUtJDktAiHor5JPzvVfY
         IhZxSO6KTO0tzUnLWFBTCkOSrYV21M8wlelGEyYKAQd+plCSWjig6QwNKh0O/cPXhmmq
         sHs2j8kSzkEQU66j0Dtt7IkX1XxkkWJWl43ozsFiQC7kGHJyyiw9sqTb9jihDZUeFT4Q
         CkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957223; x=1728562023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tENLZuUZDqCKRHgFd+nN+o31lrR5w79lUzAqq4taxj4=;
        b=StNgMIeFjiGg9HL+tZcydb2b1BLBFOIxiBkC3rqruxGVLXWjKEAEx2kclWgi6Hr52u
         Z5fMe20H8Uj3DutThdNznyWIVN/o8eAVdLXrFMkFouXEbNoZJGeWMps78LmwsTuIfVug
         dKZvmvscnR7+FkSPxzhjWqHJXC6hmT1pOw973LMY8cRA5Od3dm5AJr7B/LiSUVMWXj1m
         QeJ5ewJxJn9q0nUFuO3xE1CYvM8j7gAGF7QdiSW0uuvf3rnjSCQrRD2IBsW92Xtdf8Rx
         HyON3ih901PR7HAftu4LwI1k7pHY5Nc67XGpmkzwnE9k/PXq0TEH9i4GyddVgAr+POjv
         Z17A==
X-Forwarded-Encrypted: i=1; AJvYcCU1iqiZHSBT47rVmc0ffOvKL4EHnJajp4E630pHHlrU9tRyHlEWDUMpfrbXSADwZeMQPuAS20tLazEV/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRGpckye968gFksBbWEbdkCekGsYYDYTHKfA/YTaPIB5OsW/G
	PJQ4wJ5E4FzveO6k5m18kM1L7773H4J7+EHdXlbYOehnKYa2wHpy
X-Google-Smtp-Source: AGHT+IFxqoj5fyUph4UhadmHB8SVnCU8LR0L/apgVycs4/k3ghkiqeSJseoHUadhnddg+9TcHN3m2w==
X-Received: by 2002:a05:6a21:9cca:b0:1d4:e4a9:c126 with SMTP id adf61e73a8af0-1d5e2d9e0a5mr10236329637.32.1727957222574;
        Thu, 03 Oct 2024 05:07:02 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:4888:86b4:6f32:9ae])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb138f3sm601150a12.40.2024.10.03.05.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:07:01 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm: set gamma_lut or degamma_lut based on HW in setcmap_atomic
Date: Thu,  3 Oct 2024 17:36:55 +0530
Message-ID: <20241003120655.53663-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setcmap_atomic always sets gamma_lut in setcmap_atomic

Address the following FIXME to set gamma or degamma lut
	FIXME: This always uses gamma_lut. Some HW have only
	degamma_lut, in which case we should reset gamma_lut and set
	degamma_lut. See drm_crtc_legacy_gamma_set().

Tested by calling setcmap_atomic in drm_fb_helper_setcmap with out
the condition check.

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 50 ++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 29c53f9f449c..48f053f7ac89 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -871,11 +871,11 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
 	return ret;
 }
 
-static struct drm_property_blob *setcmap_new_gamma_lut(struct drm_crtc *crtc,
+static struct drm_property_blob *setcmap_new_blob_lut(struct drm_crtc *crtc,
 						       struct fb_cmap *cmap)
 {
 	struct drm_device *dev = crtc->dev;
-	struct drm_property_blob *gamma_lut;
+	struct drm_property_blob *blob;
 	struct drm_color_lut *lut;
 	int size = crtc->gamma_size;
 	int i;
@@ -883,11 +883,11 @@ static struct drm_property_blob *setcmap_new_gamma_lut(struct drm_crtc *crtc,
 	if (!size || cmap->start + cmap->len > size)
 		return ERR_PTR(-EINVAL);
 
-	gamma_lut = drm_property_create_blob(dev, sizeof(*lut) * size, NULL);
-	if (IS_ERR(gamma_lut))
-		return gamma_lut;
+	blob = drm_property_create_blob(dev, sizeof(*lut) * size, NULL);
+	if (IS_ERR(blob))
+		return blob;
 
-	lut = gamma_lut->data;
+	lut = blob->data;
 	if (cmap->start || cmap->len != size) {
 		u16 *r = crtc->gamma_store;
 		u16 *g = r + crtc->gamma_size;
@@ -911,14 +911,14 @@ static struct drm_property_blob *setcmap_new_gamma_lut(struct drm_crtc *crtc,
 		lut[cmap->start + i].blue = cmap->blue[i];
 	}
 
-	return gamma_lut;
+	return blob;
 }
 
 static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_device *dev = fb_helper->dev;
-	struct drm_property_blob *gamma_lut = NULL;
+	struct drm_property_blob *blob = NULL;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_crtc_state *crtc_state;
 	struct drm_atomic_state *state;
@@ -926,6 +926,9 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 	struct drm_crtc *crtc;
 	u16 *r, *g, *b;
 	bool replaced;
+	u32 gamma_id = dev->mode_config.gamma_lut_property->base.id;
+	u32 degamma_id = dev->mode_config.degamma_lut_property->base.id;
+	bool use_gamma_lut;
 	int ret = 0;
 
 	drm_modeset_acquire_init(&ctx, 0);
@@ -941,11 +944,21 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 	drm_client_for_each_modeset(modeset, &fb_helper->client) {
 		crtc = modeset->crtc;
 
-		if (!gamma_lut)
-			gamma_lut = setcmap_new_gamma_lut(crtc, cmap);
-		if (IS_ERR(gamma_lut)) {
-			ret = PTR_ERR(gamma_lut);
-			gamma_lut = NULL;
+		if (drm_mode_obj_find_prop_id(&crtc->base, gamma_id))
+			use_gamma_lut = true;
+		else if (drm_mode_obj_find_prop_id(&crtc->base, degamma_id))
+			use_gamma_lut = false;
+		else {
+			ret = -ENODEV;
+			blob = NULL;
+			goto out_state;
+		}
+
+		if (!blob)
+			blob = setcmap_new_blob_lut(crtc, cmap);
+		if (IS_ERR(blob)) {
+			ret = PTR_ERR(blob);
+			blob = NULL;
 			goto out_state;
 		}
 
@@ -956,15 +969,14 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 		}
 
 		/*
-		 * FIXME: This always uses gamma_lut. Some HW have only
-		 * degamma_lut, in which case we should reset gamma_lut and set
-		 * degamma_lut. See drm_crtc_legacy_gamma_set().
+		 * Some HW have only degamma_lut, in which case we should
+		 * reset gamma_lut and set degamma_lut.
 		 */
 		replaced  = drm_property_replace_blob(&crtc_state->degamma_lut,
-						      NULL);
+						      use_gamma_lut ? NULL : blob);
 		replaced |= drm_property_replace_blob(&crtc_state->ctm, NULL);
 		replaced |= drm_property_replace_blob(&crtc_state->gamma_lut,
-						      gamma_lut);
+						      use_gamma_lut ? blob : NULL);
 		crtc_state->color_mgmt_changed |= replaced;
 	}
 
@@ -988,7 +1000,7 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 	if (ret == -EDEADLK)
 		goto backoff;
 
-	drm_property_blob_put(gamma_lut);
+	drm_property_blob_put(blob);
 	drm_atomic_state_put(state);
 out_ctx:
 	drm_modeset_drop_locks(&ctx);

base-commit: 7ec462100ef9142344ddbf86f2c3008b97acddbe
-- 
2.46.2


