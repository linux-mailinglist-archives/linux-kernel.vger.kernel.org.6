Return-Path: <linux-kernel+bounces-284590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853E9502EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74DF1F22C63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B319B3ED;
	Tue, 13 Aug 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrLVox5G"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347F19AD73
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546306; cv=none; b=UaRnbbfv4Ol6epUh2DC3UdNcf6pCD56uU64zLOEingAMNhIh78UqRb41LuDKdpasDgp2Jt6LG1k99jWddFfuZJxOsWttZJcv+iHqXV9WrNcFW5lK6/5/fKFkw5qy2MYv4ladiVJxutMIjeTqwtq/bbCTrHZD8xeE7TflG8qUjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546306; c=relaxed/simple;
	bh=vnoCN8F2NWikR+1epy2VJ5R0HpgEtOoZr6bzBa706dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSaHEmflZU//jxUO26qlwn7dnv1Ka1pecozSG7YBUxyrAetjnCPsj7wBZqI8bbRhoUs7fB0K2HN3+FFJq5xppZHpWaFbBc3lkQ4hA4mcO8qCnEM+T8Xg1JlAMri0xeDCuS+eGdiAnya/mkRLhx9XL795WZAp6KkkDoCodqMBZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrLVox5G; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04150796so6887051e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546302; x=1724151102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQhdCIG6a+LBFR6SphoPahDGZ++LmLY0vx0sk4HKH/c=;
        b=XrLVox5G9ZqVQWpwf+SpVxE7hT/XjP2BiTzH/kF4EK+BaLLfITT2WkSYFtvN5EOW4J
         2O2tkUgmKqNtEuH8mpyjgQ9DGtZn+YjhjOY/ecC+piAhEdwOSnlr+3B+ioALyyaHKsC3
         9Ht6iAACrtBjk3yhl/v4sFeDdTZyF0IofzUTHe2vbN24mCGHVYrtirnbN9/llU++Q1B/
         0+nAxbRQnhPoesZ90DelSWUszrTTH3GC2+RamDOsgdLpQndRM+tvxxSsVd6TiodUOdAj
         LYhDaPRjJVp+1m4YmFkHihdHPSUcL5puxP3MKIieB65IerJfGNcI+rSBevw/n2/6d+++
         i4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546302; x=1724151102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQhdCIG6a+LBFR6SphoPahDGZ++LmLY0vx0sk4HKH/c=;
        b=F+9jsRhVKiOruO5z8clO7Mz8+yIHd8ao23Iv+MCCvHD/7Rxr7ha+2la1DeYOuHDQLP
         es99ZW1ES+XnF0jT0LU94ZuPZcGSJcQLbAseAjSwVa9lYAkCpP4ju2C5dHvcdT0c79SK
         RZm1mMILqpI4+KwgJo09vDP891pNus4gdUeNfldlhaelozjwbAsooxW2lbnxU7FW/Qgc
         p455uxJLRY3fjMuRaBQv4jMuLtCMsEhcLSXjFEC/oXFQJaTlAgd3PaCw+SJ6FEaAiXK2
         OXe3ExUw8fave3sBs2TciZsC0hDe9KyTPP+u+YfvSZsPHlo+FW56zscBX3lV6PE900g1
         ZyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgt2x0/W9xEn6rjrQIiiCqe3u2haiPRwlgd7Mt0JJPhToeNTV+GIW7KEyWqWIAl2LSr50jtIkFLREIdyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxQNwZHjd3E/HHZN8FV0mhWq9YxjoUANxNZutFdi7dp+wUGqM
	L3QMy8h1LzuIyq/6wkuMP39fDohT6kHJHCRstTiH9Kar161Z7bGtvk9peIrL
X-Google-Smtp-Source: AGHT+IGz72xfDrVPTMYgNZfRCFDLS7p2EH5rjzJWTApdrx62JJLa/NcdcQnhtxEsWIZrL7727HPLLA==
X-Received: by 2002:a05:6512:282c:b0:52c:cd4f:b95b with SMTP id 2adb3069b0e04-53213657d99mr2098654e87.22.1723546302294;
        Tue, 13 Aug 2024 03:51:42 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.40
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
Subject: [RFC PATCH 03/17] drm/vkms: Set device name from vkms_config
Date: Tue, 13 Aug 2024 12:44:14 +0200
Message-ID: <20240813105134.17439-4-jose.exposito89@gmail.com>
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

In order to be able to create multiple devices, the device name needs to
be unique.

Allow to set it in the VKMS configuration.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 7 +++++--
 drivers/gpu/drm/vkms/vkms_config.h | 3 ++-
 drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 4c7cda16dfd8..6ab8091bf72f 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -8,7 +8,7 @@
 #include "vkms_config.h"
 #include "vkms_drv.h"
 
-struct vkms_config *vkms_config_create(void)
+struct vkms_config *vkms_config_create(char *dev_name)
 {
 	struct vkms_config *config;
 
@@ -16,6 +16,8 @@ struct vkms_config *vkms_config_create(void)
 	if (!config)
 		return ERR_PTR(-ENOMEM);
 
+	config->dev_name = dev_name;
+
 	return config;
 }
 
@@ -25,7 +27,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 {
 	struct vkms_config *config;
 
-	config = vkms_config_create();
+	config = vkms_config_create(DEFAULT_DEVICE_NAME);
 	if (IS_ERR(config))
 		return config;
 
@@ -47,6 +49,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 
+	seq_printf(m, "dev_name=%s\n", vkmsdev->config->dev_name);
 	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
 	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
 	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 83181760b02b..ba06aad32799 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -8,6 +8,7 @@
 struct vkms_device;
 
 struct vkms_config {
+	char *dev_name;
 	bool writeback;
 	bool cursor;
 	bool overlay;
@@ -16,7 +17,7 @@ struct vkms_config {
 };
 
 /* VKMS Config */
-struct vkms_config *vkms_config_create(void);
+struct vkms_config *vkms_config_create(char *dev_name);
 struct vkms_config *vkms_config_default_create(bool enable_cursor,
 					       bool enable_writeback,
 					       bool enable_overlay);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 4e36989589f9..2f9d1db0cfae 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -160,7 +160,7 @@ static int vkms_create(struct vkms_config *config)
 	struct platform_device *pdev;
 	struct vkms_device *vkms_device;
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	pdev = platform_device_register_simple(config->dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 5c523ca27f22..87e44b51a03f 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -12,6 +12,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_writeback.h>
 
+#define DEFAULT_DEVICE_NAME "vkms"
+
 #define XRES_MIN    10
 #define YRES_MIN    10
 
-- 
2.46.0


