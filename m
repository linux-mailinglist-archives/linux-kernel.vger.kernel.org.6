Return-Path: <linux-kernel+bounces-284588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D422C9502E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BC1F23974
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B3419AD93;
	Tue, 13 Aug 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5v5gxaq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242119A2BD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546304; cv=none; b=guiIytzwX5T8ru6/jDlg/jR3NrWNa+7/UOX2Pw6Uq8uePsUzk2mKk5LBvD9wYQGBNIFOtk5pTFpYVQLrCZXzxtiACKL4X/xM6eO6F3LdlyRnjRgBzr7AEKD4BdEX3o1qyo5xljpPJRdzrC5rNTqgHZi7EhaJzCPo0ZAEVb8TFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546304; c=relaxed/simple;
	bh=UYVRK9fRkB+3IkiH7yMbBh6im7iaeZ+VrbiWQe8oV7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnwYCfgFRvFv8dR5KT66Jg03rB+NDz3v2cmQoOJIIrMWAPA+4mMboGZ7dwY44r3e0oQzGBfzaNNc6wM60cSguF+xp2QSWNtPGTfIVeXFpQS2XDvOMSKMjjPnCI2KU/4qbL7VEkXJmvPmpebhoVquSR5cd8nYpJAcdBDXH2rWqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5v5gxaq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5320d8155b4so2458979e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546300; x=1724151100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lragSOY+WyXV5ZZ+AC/3nB1kh+DnIY/4SWizX87fSmc=;
        b=N5v5gxaqdHXopi+iXV6h4b0KDL4LM+VhqwQuK6T8Br8I0E8hlPbtbD20cCYxVKQ62C
         vSo3UYWenfBY/aw0bmmgDgYFmmGb9Ru76aV3Dz1UUEqVT62CAaoJ4FxAMXhNZ/0uWfJy
         6Yp9z8fIKv7+HHKeks+8iRkXb9JO6X7sAyWM4mZb0vXbxwWTJmmCfZ6jzgIeXfMvAJRQ
         q4WeAIvFBsxUTlSyaLG+IEZaeRBvAFYg+nKfxuHGqQvAUPk/FQ9jaTsRIvo+xMvhYdzm
         Fgqz6McnEO/TPuDynb9SsElm2F/QqkVqzuvd9B00CC/UvSs5sduaBssLN51ZLRXdb/xV
         wcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546300; x=1724151100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lragSOY+WyXV5ZZ+AC/3nB1kh+DnIY/4SWizX87fSmc=;
        b=xTye1y9J9vKrVnYM3aDs9Ac/A5BwOZb6J6HAaieEMo5PvfNNRhkEQgSRmET12JiAAh
         EnVwHxBeV5pE4XVAXjhyfaFOe16fR9nB9hDoONhQqKkFEwSLEbLrDIxPvVRLdmXSv4jF
         CZdA1dQOV0aRjymCcnHZBvF05AHO6ZvFVZS5i6F/I/QuLTvWd1AckPb9hKNBGgHV1lP1
         RF0zmIyu/5y4iinaS7P+JIiVSLys6wCPtIwdSdf0AA1y7JVTqONk8IU3tTiIZUsbV0kI
         3NwN7zZq/JQ9lcT0VzBUTqIMEwBqDGGKjeyodtyi0urQw9uZ2j+LrE+VebDDEZjsPDul
         zrdg==
X-Forwarded-Encrypted: i=1; AJvYcCVIHUHOiIvRb3Y+A6Oj+B+4E7TunXaeqFwH1VXbVNjDlyrUiWUGE+zHy3Cq/hBsznWuGHhpXG+AB4WkzSKrvMNkjj2WN2Dg1HiHGycL
X-Gm-Message-State: AOJu0Yzaphw6BZMdaU6y1lbULcoamrGrqjogF7cZNrIjVioQF2+v7tUT
	MgoasPgwwX7SylGdwIM4K/pZ1uRMEVh4sigy5So6OZWGVVzKQEUR
X-Google-Smtp-Source: AGHT+IFBmBPHwR0QDHZKoVinyy3tTqQhhWg3jOVvvlJ/Sxvq5wNS2shu8jAtd2HItIOh+bOK6z5ezA==
X-Received: by 2002:a05:6512:10c6:b0:52e:95dd:a8ed with SMTP id 2adb3069b0e04-532136613e6mr2058293e87.35.1723546300375;
        Tue, 13 Aug 2024 03:51:40 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:40 -0700 (PDT)
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
Subject: [RFC PATCH 02/17] drm/vkms: Move default_config creation to its own function
Date: Tue, 13 Aug 2024 12:44:13 +0200
Message-ID: <20240813105134.17439-3-jose.exposito89@gmail.com>
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

Extract the initialization of the default configuration to a function.
Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 17 +++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h |  3 +++
 drivers/gpu/drm/vkms/vkms_drv.c    |  6 +-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index c58eda76c238..4c7cda16dfd8 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -19,6 +19,23 @@ struct vkms_config *vkms_config_create(void)
 	return config;
 }
 
+struct vkms_config *vkms_config_default_create(bool enable_cursor,
+					       bool enable_writeback,
+					       bool enable_overlay)
+{
+	struct vkms_config *config;
+
+	config = vkms_config_create();
+	if (IS_ERR(config))
+		return config;
+
+	config->cursor = enable_cursor;
+	config->writeback = enable_writeback;
+	config->overlay = enable_overlay;
+
+	return config;
+}
+
 void vkms_config_destroy(struct vkms_config *config)
 {
 	kfree(config);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 65da8cd6ff96..83181760b02b 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -17,6 +17,9 @@ struct vkms_config {
 
 /* VKMS Config */
 struct vkms_config *vkms_config_create(void);
+struct vkms_config *vkms_config_default_create(bool enable_cursor,
+					       bool enable_writeback,
+					       bool enable_overlay);
 void vkms_config_destroy(struct vkms_config *config);
 
 /* DebugFS */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 6bf462985731..4e36989589f9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -219,16 +219,12 @@ static int __init vkms_init(void)
 	int ret;
 	struct vkms_config *config;
 
-	config = vkms_config_create();
+	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
 
 	default_config = config;
 
-	config->cursor = enable_cursor;
-	config->writeback = enable_writeback;
-	config->overlay = enable_overlay;
-
 	ret = vkms_create(config);
 	if (ret)
 		vkms_config_destroy(config);
-- 
2.46.0


