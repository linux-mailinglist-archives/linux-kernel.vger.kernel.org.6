Return-Path: <linux-kernel+bounces-284591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485A9502EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B9D1C20BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC219CCF0;
	Tue, 13 Aug 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbiZVP43"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47B19B3E3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546308; cv=none; b=RkWv9btknyjSnFm08o6Qqo298v8gTq49H8T/k8g+ktET2LZO2sS+Swi2ARYO1FNAypvWI+gFRld4BD9noFDAU2MZ6VDQh6MpkQ+reSb2nanhDc9Su6d/jijAHHqT/OcGDl+tlJHzvMqZwL0RboDNWqKpQKN0bXsHvkeiknXfoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546308; c=relaxed/simple;
	bh=WRQW85+YRd0SC11lbJ8BQt+pFhrRPczXl0WEAT1Lk6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPJWw6BXppGhZ5/CastghQuL+AVPlOfs6A/TCUzpHvGHhFAnluEvyBvq7NnQr7pmnjvKByYnK5YRUR38WBMsj2qNZhrNA27qcpoG1Gn9bmJoSdXkTP8pRq1RzUiqBDVX3JLhoVtsQ72Dz1D6AsGPm9iBnamWOL5IuU/3+5bIwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbiZVP43; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42809d6e719so40947045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546305; x=1724151105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWE8rKtVdiKUJxK18Sz+dZAuEs9UiARix9m9SAPeTeE=;
        b=VbiZVP43n6iZXIu4C9qEjs2OtfTPvmGnxN7q6J9qIfkFoFq/8St+qw51MbPKjP8FUb
         DTf8GNLdLzdpikf421KRGnLBT3sZzMqJBPurFggAvicZL8Ugna73NCmftW1QWJGPSQ0P
         YSyTn/y7ftvDVhao3psZafUjwOuP3tsksQQ20KA1qxJ2z9I6y0PdnpDyG5chsX4eznaA
         Cids3r+m7C4P9fcEUsCii7+/on8afHWCmZGycjkRHv2Awz5olAMqm3en9mCZmWE1NvmF
         9eBfOe63bEhcyEdvSOVA2NkkTZb0+vXrFqCMEeX9I9hSwvFEJGpgh8X3163jR4mOlfwF
         tKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546305; x=1724151105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWE8rKtVdiKUJxK18Sz+dZAuEs9UiARix9m9SAPeTeE=;
        b=CSK+3XEcgmmqupVPrL2lCPxCmPStKF2Mx1CqbCJ9jn56zSpPvghTVny1fIyzr37Y09
         4LowAIFV834nCAc4Q5dJbWC8VD6x3Eb6Y72nFvS/8o2sgEPhb9f4JlQwq2jp1yXact7q
         mX7syka2dCJyym6pbKsh1Keavj63+n91mkOp73E2R/xUOtepB3HO5ATKOea5K5FHP9j1
         /mACfZVcxfXyhwT0nnnV/7O/kiwUH7hT3C8hS58fiA3wIIlT9UKxPnvwF529M9ZPFsIo
         QYUOT00K0Uq2d1UclsITpalBdP8eYQQgWLYy/k5wEhF3Hvn+Ut+tygITjt6sPAOY701W
         G/gw==
X-Forwarded-Encrypted: i=1; AJvYcCXXIDURLYh2gQIRmbilMWJKMJ+6TX5ZLYNk4VUMxfeJhcXU1FIrZmpY9Mix4IxihVfhK4iiJQO5QHuRMUfc5nSs9oAwFP0wcGAm4hBT
X-Gm-Message-State: AOJu0YyafsfiEuU7gWWpFrrMOrPCPMIl8xMqKKoDJ+cxkQ+M/AsqcvFq
	NhsXe0srdGfw4dvvsVyMFs28wnKbNM21lfaHW4wRhB0HWi4bpXFD
X-Google-Smtp-Source: AGHT+IEOoGiAX7Jk7kFX/Cpb+81DazihuxVSJAl0cnfxJtAI3Kt5FKlL5DDzE+cNeO48UflBpAHuFQ==
X-Received: by 2002:a05:600c:5246:b0:426:5b21:9801 with SMTP id 5b1f17b1804b1-429d486ec8amr25687205e9.27.1723546304967;
        Tue, 13 Aug 2024 03:51:44 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:44 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 05/17] drm/vkms: Use managed memory to create encoders
Date: Tue, 13 Aug 2024 12:44:16 +0200
Message-ID: <20240813105134.17439-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813105134.17439-1-jose.exposito89@gmail.com>
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A future patch will allow to create multiple encoders. Use managed
memory to simplify the code.

Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
 drivers/gpu/drm/vkms/vkms_output.c | 45 ++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 3156ff896c33..2466e8b0231f 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -122,7 +122,6 @@ struct vkms_crtc {
 struct vkms_config;
 
 struct vkms_output {
-	struct drm_encoder encoder;
 	struct drm_connector connector;
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index dcd32bc30e17..15f0b72af325 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -4,6 +4,7 @@
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
 static const struct drm_connector_funcs vkms_connector_funcs = {
@@ -14,10 +15,6 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static const struct drm_encoder_funcs vkms_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
 	int count;
@@ -32,6 +29,31 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
+static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device,
+					     uint32_t possible_crtcs)
+{
+	struct drm_encoder *encoder;
+	int ret;
+
+	encoder = drmm_kzalloc(&vkms_device->drm, sizeof(*encoder), GFP_KERNEL);
+	if (!encoder) {
+		DRM_ERROR("Failed to allocate encoder\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = drmm_encoder_init(&vkms_device->drm, encoder, NULL,
+				DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret) {
+		DRM_ERROR("Failed to init encoder\n");
+		kfree(encoder);
+		return ERR_PTR(ret);
+	}
+
+	encoder->possible_crtcs = possible_crtcs;
+
+	return encoder;
+}
+
 static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index)
 {
 	struct vkms_plane *overlay;
@@ -51,7 +73,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector = &output->connector;
-	struct drm_encoder *encoder = &output->encoder;
+	struct drm_encoder *encoder;
 	struct vkms_crtc *vkms_crtc;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_plane *primary, *cursor = NULL;
@@ -101,13 +123,9 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
-	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
-	if (ret) {
-		DRM_ERROR("Failed to init encoder\n");
-		goto err_encoder;
-	}
-	encoder->possible_crtcs = 1;
+	encoder = vkms_encoder_init(vkmsdev, BIT(0));
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
@@ -120,9 +138,6 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	return 0;
 
 err_attach:
-	drm_encoder_cleanup(encoder);
-
-err_encoder:
 	drm_connector_cleanup(connector);
 
 	return ret;
-- 
2.46.0


