Return-Path: <linux-kernel+bounces-551551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A637AA56DEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ED93B744A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892042417E4;
	Fri,  7 Mar 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvT8bmoP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98A24292C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365261; cv=none; b=BrlUdsPMstdq3wxh8fE4w5/PnfUgYsA4UCUsAflNw+1VQjDIKmQDmtqedDUoCWNE0i7JT6ZhwjSNZ/BtQhKTRpqPRmgl4lzVVj4DP7fZTFeZEU8T5O7atwg3ts9jmzdlcbJfSZXnH0dD5dRDjPgwpAWm7xdD1O5Hdg0ux3t4o1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365261; c=relaxed/simple;
	bh=/ItqekCx0ii3dBLNjzbyU9huWDpEytIDpvuIVGMSb7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lb6uRYwK9kb/EXBehM60ubu6OqjhNUGklEPbDejJPJwawAxbmdiJuH3rgid5t6abh3Dkr94HtHobKUe17MIZfJ7WocE1347vRBo6p+F0U0wIORfvpaJ8LOfXFSCFXtDoi28og6MUxyTETCxUqpM9OZWfg4vIXLyfpUhz1HFteT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvT8bmoP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso12621275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365258; x=1741970058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDAURXwAx1KsBXr4riUk4MzDkYMXGUuztgEFx9hlcRg=;
        b=kvT8bmoP5rgStld8PQ4mbMpewjLB1pXN/MCHypQ/lk2DB9v/kSZgsYLWMItZwEhrrG
         xp7/W4Fa+B0N+t4AIvmeOqC6mpc3PQNIoYInTjNnkElyrDtgAnmlXxsSyRtGdBKqc8TL
         r/vNXyJcDruwoABUMsXuNgai+3wTffxfgQun/wXXPvx7q574x1QgcOs6p8wTjjbMoZzL
         vdsHYa5BEoMW5tFlG9XQDjwXtObLXfEU5QziBs6WK+Tn48kawBJpiDuw+qHZGxixxrC6
         xIiG5c0ZZRN5wq1IGVXSRaSA3keJ/BXP2wIjEWi++TIH1uE5O7hdiNpxzDigiE7471q/
         i/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365258; x=1741970058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDAURXwAx1KsBXr4riUk4MzDkYMXGUuztgEFx9hlcRg=;
        b=BvO3q/Sb1UVVTFuFRoeWqvN4BDFu/WOmuSCMR1GwamR/fYG8CjNXBd33bY35TnvefX
         1tqax3u734WNfpf0/YXH3wjGaOpZhDNREi4HjEzbGFRwlU9UuvMbV3vAch6rgyzPFsF9
         /7Olleh0MshpPIcZE6iMyDUS8fwFTeYCCl8vhWAxC5BQyWT2OD/whwID5oQobWaRLfzy
         slTTJQ/SYpFE+11zJduEaDPfnWc7d/uHiuylLu6BIe8PV/YuuttacQkZ/yYqfZfyolO2
         TVlu9ky5QqAn5bwcaIrHTWY3VLjPgaVilRbLs+C645BNiNSKTZ93hLdncDMz9kqn/4pr
         qT9g==
X-Forwarded-Encrypted: i=1; AJvYcCWaUSroEDHHwKn8FhAdHG7D0bLmbWEhUPDxLzPbl/kpMw89Uf3p/hkWNXxK4GPr5e4Hz7z3kQ7gCOIOsFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGjGE95+uhZHThXtAhh5dAZNcl6pqO+FADi+YD+DjU4SYlZa5
	agiH0n+i5z5/gIEZ3EljAMq6HOOI2qcDvncwjgdQ1jHBLTI94be7
X-Gm-Gg: ASbGncuD5jNsJRFpdAcKn9Gpv+ge5Zzpz2E97IuHd7vSn18a78lT2q8FGX8tzeOcceK
	iDlHyAnzJD5ngRkNmDHPq0LdJIyMxsfwF4HtVkVd9dNcKgL0wFnqvP31BBdx7hsqYNdqAi3BxTd
	syjInrQ8psUFQ1I2XP8KNnD0p/EJZr7ruv6H99xe1sj4iRF0ppNP5lnFlAEIBckA9qq1MAUemXj
	ogykVJNqYdPFxHCyGqSTmxX5tcg1sWA7U5iCo5IAIyi6ij4/HK+FMN4/ecgxaQtGRNIi9Lezvdu
	dlw5hRVm+Us3dJLGMzujfMzsYTpopaO/OKgYKmx0gIYrFNc=
X-Google-Smtp-Source: AGHT+IEHAK/O4CJHl9ysak7QbxIiuSOZVGHkpbi9q4T78G4ZtKDKPIP1C1QDFQphOc/Ef8wVAs612Q==
X-Received: by 2002:a05:6000:186d:b0:390:df75:ddc4 with SMTP id ffacd0b85a97d-39132db1113mr3150084f8f.44.1741365258109;
        Fri, 07 Mar 2025 08:34:18 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:17 -0800 (PST)
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
Subject: [PATCH v3 14/16] drm/vkms: Allow to configure connector status
Date: Fri,  7 Mar 2025 17:33:51 +0100
Message-ID: <20250307163353.5896-15-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
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


