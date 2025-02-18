Return-Path: <linux-kernel+bounces-519932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B23A3A3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DCE16BB88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F12274250;
	Tue, 18 Feb 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNI75qHd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064D272903
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898511; cv=none; b=nBHdNhoBH1pS3jycCtts6FJ764CK3nzdUlRxtzYxnKpcODaiqP1XO5/YDYnZ+vu1PItT4ksfAWSQqdVdy7lEZuw2aiDuIh1d5AT9jaSvXBM49RIzQMDIzrBbJ7iQ27Dq/CdtHBU+jj2ToVkagp6t5Ls07OrnflpSLxN/9wEUFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898511; c=relaxed/simple;
	bh=/ItqekCx0ii3dBLNjzbyU9huWDpEytIDpvuIVGMSb7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfIi4Pv+R74QvDuhcSTp6C1kQMPqS5cwDTpB46XLAP202d+/zjL7rXkC1C2JfesVSZ6rstOItKfs02APUkroAy+sHCEPSiqiRgVYbOccf+uwo5eG9abRnV5WzlDBBbDt3uaxnzoNoehvx7J+uQ+7/jmDyqM9J9B5K/mSS3yrPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNI75qHd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4397dff185fso25374755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898508; x=1740503308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDAURXwAx1KsBXr4riUk4MzDkYMXGUuztgEFx9hlcRg=;
        b=hNI75qHdZRzFb8I6sRU+e8ALlcVNw7ed9E6ItDFBexCBAOEQmyLN8RAFCXRPs4n+2Q
         2gifIKhvkkyYtVexzKuLmmzmLnUHV6kRyWLqeOEyGGD428mWFvDEe7QUqYiuHoOS7q1N
         kghQOpE/Jlaag6eJ7INKun7J4o7FePwfn6m56Gw4vvtKrgxBZRZ/7MSjATJmMeWmgpw+
         HBHEZvf3/BmxnSBelkP7TgduWoOlYXvhfhqCA0iQ5E6Azdg6bY/lBxKMJ8KH1QyCiZmB
         YC7C19chs2TqcULK2fW5J9G8I9c5NMJKHB5yiyRgLEGmtXxODARAiL01crfDYKEBKMx/
         44aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898508; x=1740503308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDAURXwAx1KsBXr4riUk4MzDkYMXGUuztgEFx9hlcRg=;
        b=FWrFytpXjiQ9YIhVTBTEbtElXmcrZ6FIWsC1Svh509hj27njsD6z18v6BqM06+UvhN
         KSeVf1WYXfm1SrSfVGdOJLbE4gyJo7459YeXZvAjbVE95J9S3C57KKPsKcVqcARUgsD6
         UYB4ryY+hY3D1hIx/u5B30MG0PLASIT7LfRDWi8ra4ClxHrmzNkLgC52Kn/I+y1My20D
         xgM8W3pMeRADcvJVRiUy2XFW8CljM0yHJgCPEuXqXtteWS1fdgj40CFCKi8FUfd7JOE+
         /sEXn2fGEhlezvQt23TzxVRdMDWlJpTLv0tvgE0sEcjD97ZB/+COdgZdN+22T2OXE3EY
         nZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8rTrTxnMfrgs/NPZmUBr923CbjoepV9Og0E7njGhLRfNdPyOtf0I5etikw3DNSUXin87IgLme7gmC6CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2GukO845HxkaWYWJwA1EPYs6Rgihvo0fTpWsPmROlllX+y0D
	yjBG7gOK7fFy1BAw10xEGRjnfj3jyNRhNvTWqIuWi4traxzA6M2G
X-Gm-Gg: ASbGncsxHVtjlCKAFQ9l2tk4Fyo7mCz1fJRUKRNLJePpnw/yMmigQoHbBiWUA9dhCw4
	SuJiVjU6sVX1NR5bh6RDLkoNlLs2ivK6xqx018wEDZ0nCeZPBa+niD2WDo/s+c1VlKBUvl/SWxr
	nysir3S5wDHnRtwm30zDQEVOJ3RFXHWov92fzyVX7edknRQjiWG7pN2pimoSywWxoYR+939ZJnZ
	schDaQ0vbMB5rrSjLGKcIBy0LjYfkkQcIMTYrt+3sPXkoJPNUYAOu2W7XazsMznDSNRzL0i/dZb
	EDBFgxGWEwRfloJfNQ==
X-Google-Smtp-Source: AGHT+IH86DlM2bJkhQtq/SuDDWBdaxNVLBKTS9fR8nYsmP+2MFV+J87LH9yijU9dT1LYxHXVZBQyaA==
X-Received: by 2002:a05:600c:5114:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43999ddb366mr4554355e9.29.1739898507577;
        Tue, 18 Feb 2025 09:08:27 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:27 -0800 (PST)
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
Subject: [PATCH 12/16] drm/vkms: Allow to configure connector status
Date: Tue, 18 Feb 2025 18:08:04 +0100
Message-ID: <20250218170808.9507-13-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
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


