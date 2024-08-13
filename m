Return-Path: <linux-kernel+bounces-284594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8C9502F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52782286220
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C219D066;
	Tue, 13 Aug 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQN+FPPg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B3819CCF2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546311; cv=none; b=iuxaW09731bo/s0NbxLP//sUvFo45nXJ14upADwTRBN3AtBygKIdWwWvTlLAFhJx94mR61IIRPiOLfTCXBXm6DzosJpKdEUrQoduDWmwfnnNobRhdXoyxiVtL7rsdlKe5K7SswwpVTih/s/BY13cL+6CGWZaazqxmhFA3j/IUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546311; c=relaxed/simple;
	bh=5VTbR7iPQ9XE5cd0WXphMMLzFTYPblcphuvT2F/YhTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0Gb9t02Z85x3YI2P+yU9Qrsf99Mb+Db7IuK5Y+7Hb84X/kZoRr3zeLg/d9XQ2sizhMhF9vqN3PRC3rI34dLOhoCaHA3VIKnzXa3uuJUqOTkjtFS0OHiLykYxukPXuvt14Y9vvuNMQHLufpG5Bqeoz8KATSb6wXHkMTvIFEh2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQN+FPPg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso9210345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546308; x=1724151108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPJvcbH5lYbi1tdr48EenmYPKkhD5TMeNHQFHVN3Exg=;
        b=AQN+FPPg/sbUKGcRfKikr/NhfH9ppc51WHRR4FBK9tMaMW8o1JQluzQ0FFHbcUJVyx
         so8+/qHm2X1S2vFNV0vSA4vC8JFHGyfRIt04Nqo4QLg2Ao0Bbk7QPZ7yA70vIIjJ7EdD
         F0LJwxp0P+8rQzkYytwqxnoY20+oaMDgwkhe3xQ5AKNXR5je7wdEBPwyyh2GrFaBWLI8
         1F5jMPEWJqGc8JXJs8K9xyJL09rxeG6l3yIZh0umT5dS1icnNqJF6vX4HMx6ZFIPDqMd
         xydWoFIjp1JljpAouLf9ERYcVvYxeFushwsLeaZ25vvQB003uNZy0iBSmtvDAuug0Rf8
         MQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546308; x=1724151108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPJvcbH5lYbi1tdr48EenmYPKkhD5TMeNHQFHVN3Exg=;
        b=a4XjidlhQb8UhDqF4PDbpllm+zYDTYqaSo5D2PLSNSx5FJYQwLTTyN1d30e5BcdUBd
         CfchnfdR/pLVVwjuLWEFg7aOQcI1OfN5lliodvjIgiUGa4eVghMeOeFsntDj1s1q2ZLa
         BdvVklfk0StXJJcIB1/s6nYlfZvG+/z935q5yf67p08C1ApG9NRmgcc5nIMafkbr380Z
         t8c4Lds8ZZESXgy+lGw21xfEcdfHDNN2g+CKgQm+IBlvpQBeId59/DXaKPfdDeLwLRBw
         3OMypGHFkDeweIJdulENje5xwYVddic9iIidHyRI0OpllXYxDeVfT6Ey94KYDBRuFHz9
         hDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZhVP7i5XmoUj7ulVaR/9O5fYFxlnwcMWpPxmFhtAr2/HOxEdxF3/lJhMO1efOhIL35DKZu0e6rOEQFrQd5tnG1SRsqf70eUrpzFvE
X-Gm-Message-State: AOJu0YwyF+Q+7alIZ8W5GajnMySeUiQwp2sRDgU64uLbC7Ufn7O8Eg0R
	oGI3gB0dQwub1zNlVc9Gc3yzr3hz/RMOv33lp+aMw5f7hFH800G4
X-Google-Smtp-Source: AGHT+IHcFaaF5NVEVnvtNiV476r9AqohxbQTNIubIsJ2CbGH8C94GlKmoddxaTxdje9PNBr2TQhbQA==
X-Received: by 2002:a05:600c:1c17:b0:426:6981:1bd with SMTP id 5b1f17b1804b1-429d6280c76mr19765785e9.5.1723546307600;
        Tue, 13 Aug 2024 03:51:47 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:46 -0700 (PDT)
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
Subject: [RFC PATCH 07/17] drm/vkms: Use managed memory to create connectors
Date: Tue, 13 Aug 2024 12:44:18 +0200
Message-ID: <20240813105134.17439-8-jose.exposito89@gmail.com>
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

A future patch will allow to create multiple connectors. Use managed
memory to simplify the code.

Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    |  5 ---
 drivers/gpu/drm/vkms/vkms_output.c | 53 +++++++++++++++++-------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 2466e8b0231f..cac37d21654a 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -121,14 +121,9 @@ struct vkms_crtc {
 
 struct vkms_config;
 
-struct vkms_output {
-	struct drm_connector connector;
-};
-
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
-	struct vkms_output output;
 	struct list_head crtcs;
 	const struct vkms_config *config;
 };
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 7afe37aea52d..4413cf88afc7 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -9,7 +9,6 @@
 
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -29,6 +28,33 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
+static struct drm_connector *vkms_connector_init(struct vkms_device *vkms_device,
+						 uint32_t possible_encoders)
+{
+	struct drm_connector *connector;
+	int ret;
+
+	connector = drmm_kzalloc(&vkms_device->drm, sizeof(*connector), GFP_KERNEL);
+	if (!connector) {
+		DRM_ERROR("Failed to allocate connector\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = drmm_connector_init(&vkms_device->drm, connector,
+				  &vkms_connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+	if (ret) {
+		DRM_ERROR("Failed to init connector\n");
+		kfree(connector);
+		return ERR_PTR(ret);
+	}
+
+	connector->possible_encoders = possible_encoders;
+	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
+
+	return connector;
+}
+
 static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device,
 					     uint32_t possible_crtcs,
 					     unsigned int index)
@@ -72,9 +98,8 @@ static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index)
 
 int vkms_output_init(struct vkms_device *vkmsdev, int index)
 {
-	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
-	struct drm_connector *connector = &output->connector;
+	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct vkms_config_encoder *encoder_cfg;
 	struct vkms_crtc *vkms_crtc;
@@ -117,14 +142,9 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		}
 	}
 
-	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
-				 DRM_MODE_CONNECTOR_VIRTUAL);
-	if (ret) {
-		DRM_ERROR("Failed to init connector\n");
-		return ret;
-	}
-
-	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
+	connector = vkms_connector_init(vkmsdev, BIT(index));
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
 
 	list_for_each_entry(encoder_cfg, &vkmsdev->config->encoders, list) {
 		encoder = vkms_encoder_init(vkmsdev, encoder_cfg->possible_crtcs,
@@ -133,18 +153,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 			return PTR_ERR(encoder);
 	}
 
-	ret = drm_connector_attach_encoder(connector, encoder);
-	if (ret) {
-		DRM_ERROR("Failed to attach connector to encoder\n");
-		goto err_attach;
-	}
-
 	drm_mode_config_reset(dev);
 
 	return 0;
-
-err_attach:
-	drm_connector_cleanup(connector);
-
-	return ret;
 }
-- 
2.46.0


