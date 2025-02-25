Return-Path: <linux-kernel+bounces-532159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE436A44967
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBD6189D5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB50211296;
	Tue, 25 Feb 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjL5aOiR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907C20E703
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506400; cv=none; b=DxKLotW+ZjossTSITrXb53eviDBelDMC2EUDgvTDoCFnPdwfcZV0npRR/hv0XOtgeW9UXxCD4Znw8+v9NKwPTBS1ENtpcOjvM7JL02FY/khcanLPSIqfuypMQyQWwlZCy97d1BLtQgp68fx+EjM5ARmaFaJqHX6M3IyAbwMjmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506400; c=relaxed/simple;
	bh=/ItqekCx0ii3dBLNjzbyU9huWDpEytIDpvuIVGMSb7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSNt3lERebFs7ksH+HihB1LB3dcsEmW0voFrzRhi8u3JWw6lOlOtsTC4EBPn8ealjuxJBAZGFegwFnNG5X2xH3qy0HrcwwQhGqhj7SDFbEI6/HU0N59wlK99dLEBYgoavbh+rUZrsl73qOi/b2WqaQFPJWQu0S5sLkfb8pVUwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjL5aOiR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so15362785e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506397; x=1741111197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDAURXwAx1KsBXr4riUk4MzDkYMXGUuztgEFx9hlcRg=;
        b=RjL5aOiRAn0RR0C6Zsz9tuLRwbaRrCoJZD73xQpAjw1Xfv+UNpPgMLhtSQXaHxCvat
         OIDgkmAca3O4RYFh/adIjNXrLgX41XAIvDzZH0rt24g3Uc+e0R/swhA7jRH0AjFwz7go
         V2HxtXgB1y/u9XCLJeZeOkXO8fNA/DtvyWlFyUgEt72MCIOdjHpm1otDajirWi8mMykP
         HiKHw8NPK4Tq4o0IAJNUTO1T/7XliFgsLsYh2QlTMUATO7MQImfBu/R24qErO71vu+Py
         ecoHdbuaQjqxE5drw/yXVIYKJ9eO4ybc1x+Bvex9XVtmEKF5YeJwL3XMrAT5e/25ApKJ
         CYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506397; x=1741111197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDAURXwAx1KsBXr4riUk4MzDkYMXGUuztgEFx9hlcRg=;
        b=gv3i1ErcNkVfWrxLLSJZ88PIauuLQrcGLTmJ4x9KitpocQwn3r799I9jXV/vGUe/OE
         bPDo9+UZVV0ANP/FJ/dZppRnsXf59vnGqj5iwJv98VdaqrEOgfr3HK3akvalUfv5ePPZ
         YafmlMT4aPS8+bGpfVDFCKgcjDzs9Uqgq5cmWDAZ6GhDQJtvFdDUhqI+bLm8OsF1SG/l
         ZPBau85Rcjn2cP1QkOEvUb+7VKTKE81FM+X1m1heF62H4Nu2ccrpZa8Oon6lSEajwz0k
         FN7dQdKuLLJMKXaZM24SXcnBIIabtDSzqkUUqTWM5BXnwn/d4OTvU2TSnky5/ophzCKW
         2YWw==
X-Forwarded-Encrypted: i=1; AJvYcCXSM19j9ltNgUx7T5O3hDVOaKLgUgo2p1yodWRI+DjEfwzsoaOOpDNbu9MN7iy9Wxgn9Q9S3M3kWJIP5Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnzTtI8x2Q1vLLmIXpjKnDejZr9mmv9l/qnPIc82V8UZtQT6v
	h8pEGj8DVhQFkWPf8Rv0PzCTvaKIHtXKVic/M0hmnieDTG7y0FIc
X-Gm-Gg: ASbGncuxEHcvAohWsTnaNrD3+9VtUxrvvNSyp46sc5PudipRSEqUf6R3FLSlDTl99Bo
	iz5LnFxFlNsQneZ656k2Gxjg6B0y6TckDjcSydp7Im7qdsaifXI8mZMY86c0egCEiPVjLntUuxg
	A33kQJhYdfWCoxQvFvCD4kCjGsbPQ7/x5xY3Lwav5dM2k/toYXC7mJrv34XgENBai8FsOObZAfn
	flOu9w7cdKbj9ykk/5mOaBYPtBtoSCY68P5+R8/LCA8FeWDfwPm3Q4Q/G4abXt+MRICjDu+ocPf
	+HukTGnBgyY7Zim8y7pVlgd+/LFk
X-Google-Smtp-Source: AGHT+IHoNrE7lElorE2nBrogemoz9GreX5xiOI4tcL2igHg9mmoHPhzuv6lZfljM8vKeq46S3NNwkA==
X-Received: by 2002:a05:600c:3582:b0:434:f131:1e64 with SMTP id 5b1f17b1804b1-439ae1e960dmr143520395e9.9.1740506396488;
        Tue, 25 Feb 2025 09:59:56 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:55 -0800 (PST)
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
Subject: [PATCH v2 14/16] drm/vkms: Allow to configure connector status
Date: Tue, 25 Feb 2025 18:59:34 +0100
Message-ID: <20250225175936.7223-15-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow to store the connector status in vkms_config_connector and add a
getter and a setter functions as well a KUnit test.

This change only adds the configuration, the connector status is not
used yet.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 24 +++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            |  8 ++++--
 drivers/gpu/drm/vkms/vkms_config.h            | 26 +++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index ff4566cf9925..3574a829a6ed 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -916,6 +916,29 @@ static void vkms_config_test_connector_get_possible_encoders(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_connector_status(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg;
+	enum drm_connector_status status;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	connector_cfg = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg);
+
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_connected);
+
+	vkms_config_connector_set_status(connector_cfg,
+					 connector_status_disconnected);
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_disconnected);
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
 	KUNIT_CASE_PARAM(vkms_config_test_default_config,
@@ -937,6 +960,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_plane_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_encoder_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_connector_get_possible_encoders),
+	KUNIT_CASE(vkms_config_test_connector_status),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index a1df5659b0fb..f8394a063ecf 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -361,8 +361,11 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
 		seq_puts(m, "encoder\n");
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg)
-		seq_puts(m, "connector\n");
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		seq_puts(m, "connector:\n");
+		seq_printf(m, "\tstatus=%d\n",
+			   vkms_config_connector_get_status(connector_cfg));
+	}
 
 	return 0;
 }
@@ -588,6 +591,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 		return ERR_PTR(-ENOMEM);
 
 	connector_cfg->config = config;
+	connector_cfg->status = connector_status_connected;
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 0118e3f99706..e202b5a84ddd 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/xarray.h>
 
+#include <drm/drm_connector.h>
+
 #include "vkms_drv.h"
 
 /**
@@ -99,6 +101,7 @@ struct vkms_config_encoder {
  *
  * @link: Link to the others connector in vkms_config
  * @config: The vkms_config this connector belongs to
+ * @status: Status (connected, disconnected...) of the connector
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -109,6 +112,7 @@ struct vkms_config_connector {
 	struct list_head link;
 	struct vkms_config *config;
 
+	enum drm_connector_status status;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -434,4 +438,26 @@ int __must_check vkms_config_connector_attach_encoder(struct vkms_config_connect
 void vkms_config_connector_detach_encoder(struct vkms_config_connector *connector_cfg,
 					  struct vkms_config_encoder *encoder_cfg);
 
+/**
+ * vkms_config_connector_get_status() - Return the status of the connector
+ * @connector_cfg: Connector to get the status from
+ */
+static inline enum drm_connector_status
+vkms_config_connector_get_status(struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->status;
+}
+
+/**
+ * vkms_config_crtc_set_writeback() - If a writeback connector will be created
+ * @crtc_cfg: Target CRTC
+ * @writeback: Enable or disable the writeback connector
+ */
+static inline void
+vkms_config_connector_set_status(struct vkms_config_connector *connector_cfg,
+				 enum drm_connector_status status)
+{
+	connector_cfg->status = status;
+}
+
 #endif /* _VKMS_CONFIG_H_ */
-- 
2.48.1


