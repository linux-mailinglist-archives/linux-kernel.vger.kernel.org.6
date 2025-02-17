Return-Path: <linux-kernel+bounces-517314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2275A37F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E271897322
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0F216E27;
	Mon, 17 Feb 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiMnWXVy"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A42163BC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786489; cv=none; b=Bin+yo/hSZ/v/jhpU1lUZ8qc4L2uUSyfwuVHQjCmUeKK4pJHyK7i3pVHzbFi0usIXANMM7rAF7oA6gsIf3SDOVoxToobkRYB1MUeS7OUCguNWylgE86TWOIVElPJp70KP0BZ5VpoeOthZp+jD3sfN6x5JBrfGipQC0tLo3ENv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786489; c=relaxed/simple;
	bh=NqKUzI9Kmgs9z+WBxXu0/bcQz0rhTTeF+BXogLGULSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OghrEDiIXGbI/6eNXPDZSxZHAYD0iYZAVTQqrUV6FWkk0MNWxDhBsl7KBda94Jq49Ea68lkolJanSgC5c9JAQhTJ2dGT2DLCXkNH/9ZCjkcVypryJxxrn27xaE+ph4GblB4dz3YqDFyNfNAlUQRfFUvamwQ8NbDn8c1NROn2Zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiMnWXVy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so2149673f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786486; x=1740391286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prbaD9EEGSsUeJKiTeBVWVOJfwbyTxNyFRLpyPWOntc=;
        b=QiMnWXVyw8JJKK1ysZHCxRpJiqSPKCLp5gPedbOhiaS9KkjWEoEOSqBOzVnMuq9Y19
         LPbTxj1k+bg5oTDI8ZIfQlrA/+cbyeTInhiUJuWOZ/PmFVXoCLjfuj1tjNIQPLAO5Hul
         m7rpNhpl3heiLi+V5Q68E2CMClCctNXzaq6CzzFL0Qro2TEA9FqMiphoC+YmYF5D1zRd
         sGIFqxSW24Jpk0YF1pSp+RVNp0SkTnnYAYcO4RC+lYAwu2lXYVQ+xGYZlNF1Xo7iDnMM
         JuFTSIZVnQMgELGUtfZa3f+I6XGtKxYGf4O9+ZCDXE0ndH/X5+WoOWXMfq0+EKt6dUAw
         abKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786486; x=1740391286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prbaD9EEGSsUeJKiTeBVWVOJfwbyTxNyFRLpyPWOntc=;
        b=OvFSy5nh71LHKCuooV3nn7aEm1PUZHjBcufGUWKtMOWCki3F0ip3qWjGSiXuSShV4t
         5OW4wenLQS/5Z5jhIY/GVITh9VMj7CEQ0ywuOEqYt7ZXbba4BqAxvBIx3YnbL6nmDILO
         rBrkeWS+2ghiChchrhfUmVZZZh79GWNpYCc+I8Sz07niDHb4+2/k6dJHwDwWopMS3gm5
         riioEqyYZ/x91LlwsatsOUEuzeksKbVgXXbfE7xWJMDbHeKwTvD/GxWurnJBDJYBmQ2u
         Aipg2MUlZnlH5IqnN4TtdIsN/M9eLgL9o7y7Nmc2w9l7ouTrLNQ/NfarFnEiS/KUGoLF
         qFbA==
X-Forwarded-Encrypted: i=1; AJvYcCXHSFzJDdODwOR5qO8NvsR5uKTD6kE1bhB4VCeDeCSsH6OLFjAMKPCMkZVfUrO3PmNBimLFpGxJ5W/o8TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KhnGzJ3O8X22lbCx6USbnF7IZTPNkHJcpM4Px4W+28WLPLyi
	4TQNHegoF4HDnIcBXcECHETw6wpeFvPQIh+cRS5XZ8w7zUatMCdO
X-Gm-Gg: ASbGncvfGnCW/ZgF8YJO/4CqNlXHgkQjLWCUaYxkwiJdNudsEJcURazFlSrgDnVT1TZ
	dGE2bKBXrbDlYhvt1aPRGqHHaW43jiZK4QA0WRlO7P2lli7SV0jUToxaQgmLQ87YUy174h8IfwG
	0B4IoCWPpe50nY+P1spU7V8hi1kCVupB7gJP2g/JjvRdpYKUG3tGw6THR6Q+Nb0vnXOePr9zXpw
	5NvYIlkBFf1j7+wjKGC0EzAgoxYba484Y2YtcyNgZbMl1OPFIb7okQ0OWrDGMw9H5no4WXtq03Y
	KFXxTn9jwcMg15SlGg==
X-Google-Smtp-Source: AGHT+IEdub1ENivcRK+0XnYHr4w7hyC6AU7B2PacCu2x37x4fKN/+Z9glwiYOFaDq7cRKGtz5fNHfw==
X-Received: by 2002:a5d:6d06:0:b0:38f:4cdc:5d36 with SMTP id ffacd0b85a97d-38f4cdc605bmr768718f8f.43.1739786486004;
        Mon, 17 Feb 2025 02:01:26 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:25 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 02/14] drm/vkms: Create vkms_connector struct
Date: Mon, 17 Feb 2025 11:01:08 +0100
Message-ID: <20250217100120.7620-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217100120.7620-1-jose.exposito89@gmail.com>
References: <20250217100120.7620-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a structure wrapping the drm_connector.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c |  8 ++++----
 drivers/gpu/drm/vkms/vkms_connector.h | 11 ++++++++++-
 drivers/gpu/drm/vkms/vkms_output.c    |  4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index fc97f265dea6..ab8b52a84151 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -29,22 +29,22 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
-struct drm_connector *vkms_connector_init(struct vkms_device *vkmsdev)
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
-	struct drm_connector *connector;
+	struct vkms_connector *connector;
 	int ret;
 
 	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
 	if (!connector)
 		return ERR_PTR(-ENOMEM);
 
-	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
+	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
 				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
+	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
 
 	return connector;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index beb5ebe09155..c9149c1b7af0 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -5,6 +5,15 @@
 
 #include "vkms_drv.h"
 
+/**
+ * struct vkms_connector - VKMS custom type wrapping around the DRM connector
+ *
+ * @drm: Base DRM connector
+ */
+struct vkms_connector {
+	struct drm_connector base;
+};
+
 /**
  * vkms_connector_init() - Initialize a connector
  * @vkmsdev: VKMS device containing the connector
@@ -12,6 +21,6 @@
  * Returns:
  * The connector or an error on failure.
  */
-struct drm_connector *vkms_connector_init(struct vkms_device *vkmsdev);
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
 
 #endif /* _VKMS_CONNECTOR_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index b01c3e9289d0..4b5abe159add 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -7,7 +7,7 @@
 int vkms_output_init(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
-	struct drm_connector *connector;
+	struct vkms_connector *connector;
 	struct drm_encoder *encoder;
 	struct vkms_output *output;
 	struct vkms_plane *primary, *overlay, *cursor = NULL;
@@ -69,7 +69,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	encoder->possible_crtcs = drm_crtc_mask(&output->crtc);
 
 	/* Attach the encoder and the connector */
-	ret = drm_connector_attach_encoder(connector, encoder);
+	ret = drm_connector_attach_encoder(&connector->base, encoder);
 	if (ret) {
 		DRM_ERROR("Failed to attach connector to encoder\n");
 		return ret;
-- 
2.48.1


