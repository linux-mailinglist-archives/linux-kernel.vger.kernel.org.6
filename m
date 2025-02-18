Return-Path: <linux-kernel+bounces-519146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5EA3987A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7920E18928B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9723957F;
	Tue, 18 Feb 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShM86nat"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA6237176
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873548; cv=none; b=BWJ+J+T6yPQHLsZYeyBsBPIKG/hebLQ/OJCiuAf7ilFxN75uBwkGx4HVVwynt5u/FWiQXEVwCYBWbnb1FLsU8+F5Cd9hBwZpfU0or75v9Z/Nd9u0QTmZ5Bv31xpidi+DfKSf0tBnFE4va7sCGnjSPPs5WHHV9QmE53XPnqFdrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873548; c=relaxed/simple;
	bh=NqKUzI9Kmgs9z+WBxXu0/bcQz0rhTTeF+BXogLGULSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdVJClMBGkyQRzbQ7zJOo4EE2t5jo8IZz5RWezmaKegwDxrx9WRX6oIEOrLGwCjTGHkGSi2hlvJ30IqTPdLcXthGV+dBiyOeIAQvPBRf/M+nn9F2jnaCIwqZuyUQYdhHc9bhyMhsacFXK3X1TKzUxG+6bgZENq9ND9i9CiU1FSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShM86nat; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f2f391864so2269105f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873543; x=1740478343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prbaD9EEGSsUeJKiTeBVWVOJfwbyTxNyFRLpyPWOntc=;
        b=ShM86nat1qWXdAvrFmMUG21IrCMhdSGWzWJM8BVJwlUebgmBKU7gvZtXrsoQR8VS7S
         RJSnqpaWLMKWTQGA2DADjEBrJlAa5G+wyfzzt3E4ij35GhNg0dtTHNvgq0s/Cmp9VxN5
         pe7zS+vTzdjoXXDawPg8rB05ngDEG+h4f/UBAWFpkoTAj6Eqgcm0Y2rPC4ZWld1gUslB
         NHmhjkxR5yKkTLoz86PLpdTByxtOSQ+UujcUqn2ebThpJMmCLF2RiqMBWhZElICwOcv2
         m6iHhYO81rC5m5f+WTTOqwaYrqsmPsi7aCYWjcXUUClmrTyvkFifyB4R1NBplgcQtPVD
         TZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873543; x=1740478343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prbaD9EEGSsUeJKiTeBVWVOJfwbyTxNyFRLpyPWOntc=;
        b=Ht1zgJ3spe2WePAJysE13uCYBrqMYcuq1g6MVrfEqKKGnvWT6PHmIvzRjdB9MtV6I2
         DDDTWLx+Fo9YC287CMxedA9P8ZFUY4qhO+R8JHXz0C6i9E8SotzdWNtnBjKWZsdeRnxl
         VB83rLx8GRRhE1K3tpGh4htubx4UeUBf8O9xkIfydmOM4qIyU2ovFmjwkAHzONuW2Y4p
         WrfOaBKiGdWie9QTkr8yVm4Y4zleQbKy8Rfqzvlua6phqJnHloMnfiQ4JzoBhiZeQN3y
         RaBVxXjDImd9h8puWZnFc9NkN5Jhip5hNSWQrickQK7vwYC84EdARnB3bSN1xdyFKm5i
         LDGA==
X-Forwarded-Encrypted: i=1; AJvYcCUXuxp4VZZ2AgiB5h72ZvxU0q60ISofP4veaeCOSBH4het9hnIaWLc1K59zl12+BT3rTP9j9HKWw8UZFQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhx4e0UAfuBxaQo1gobIdaAjs5xsA3zOj4NfntFuldOBs9F+db
	hsxA32jPO5bqPmFkiWJ9n6TYlphUZxUpFvoNlKuEtKUy9DU9Mi7/
X-Gm-Gg: ASbGncuGu1u90ATxKl/6deraz3ncvh+gdgObWQx7+rs91CJVN97jpLqQ0vUpPJvqPaY
	AdeCt0g2Z9X6gIEGIB4StFsl04QURWoEmiCctXAGG9vGqqcBqMVz7miyovth6Phdl1KmqtJU28I
	H4AjrrR4y8DXNx4djFvbWlwh66Pkq16EVMneKlRcymz3iTDKAyraH2RCQi705jpo+JzYzWbkC5t
	Jg3KLhpg3YLLiuygvnGq9WY/utiLWAmtKIh+IymWQG3TBX1hZjNLDws4aecradlGetpB0lgK2Gl
	+XEx4VB7TKNY03fDeQ==
X-Google-Smtp-Source: AGHT+IFbin/USp6H333KqF9l8q+i0XsBIi470gaQiS/hfbI+WonrzTOhvv1P6C8lRFRMzjHR/pnPIQ==
X-Received: by 2002:a05:6000:1a8e:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-38f33f533edmr11356657f8f.44.1739873543136;
        Tue, 18 Feb 2025 02:12:23 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:22 -0800 (PST)
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
Subject: [PATCH v4 02/14] drm/vkms: Create vkms_connector struct
Date: Tue, 18 Feb 2025 11:12:02 +0100
Message-ID: <20250218101214.5790-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218101214.5790-1-jose.exposito89@gmail.com>
References: <20250218101214.5790-1-jose.exposito89@gmail.com>
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


