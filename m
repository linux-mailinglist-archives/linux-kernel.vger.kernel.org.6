Return-Path: <linux-kernel+bounces-551552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA3A56DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208623B6F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F312459D0;
	Fri,  7 Mar 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOB4kUry"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94324500F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365263; cv=none; b=tCLWGCLxSDSoBUTG4VEFefqJ7HgvkHZ7ZSWExHtlSclGd9886m8Vb+MTU/g2BElDhxGcfGEbUvpZ70yySBUN8gbmufTqu4owQzZzeMkMEIPl0sJdT8yH7Z924Jl/6oFAGf1+i6QJQyAG1iAAR53EfSGmqTNRkkYLHbzUI+RWlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365263; c=relaxed/simple;
	bh=tHLRch/pNbAPUwCypXIU0Msmm9PT7vJclyYGUr0D7F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1YFJeNSKevyBGr3gD9xLdC7Wf2Ybx0IKgxQVMJ4K5LBqhxbckGZWGSWPC77Jj5CzA5MIopaTUlS/S6CtiebGMtdAHe28rtj8+hsVjjWKv4Nmo6QEo6wdFVkRr7z4WOXs6yTWf2PqQxCyG1iukSjFGWPqvNj7jWiDBDNUcFCTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOB4kUry; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so24109765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365260; x=1741970060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnVpWku238hbA4Nkq9IkwuoRE17xKzZpiURAgcmw2aY=;
        b=iOB4kUry9HdC6/zoDFpAyl+gUuqCgngSkxzaXtxxE6lPNs2vKWxpJWLtPxXpHBcPD1
         /H3SJ4p9iIh2HhwF34WORGpO+C0bI5CJ3/Dd3ho/bL7IV2aO0U73K6+sSQFIC1lGciPx
         zSu65eJ+6M8l9jfu/3VNKTZ+/OEElhiBk6cbXp9taIjYCW9YU9eMtlMQu1uY4ptQQrsd
         rrh8tDG+VM6KA1IlwPTAljY9HrpfoQn24IxIUzSeYnGeQrQFvz4bv/hY56iIh2w1l5iJ
         rg9PabSgtrXx13Z2pEDlKTpmY9tIn1pPj6wxb8PF64DTpFQi61Zw3+qM87WqNby3Z1kP
         IAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365260; x=1741970060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnVpWku238hbA4Nkq9IkwuoRE17xKzZpiURAgcmw2aY=;
        b=IbLPedu93IW3yNx9BOMjQ/83tLWhDlnJ0ygFgIMBGMpWmii8AuSZTMK1jfKTmpK4h7
         u85p6kgt6VS45tOxpeJpa7oQZQTFC4HtIQCzR5j5tHufp2+YS3Q6Wjy+E+pJCt9TEkK+
         hrj8yNT5MMpsxrLoJWNT8+EBGhTjNwlriB8UWIppsyGCDOBZSQ1GTu8G8Iaru61v/g6O
         xWpD7eoQmxE4zUm1NI6nB/8LA+qg9FVoxQCNdQ018phDbpJLbw8nZ6ZMchitNRvnZEPn
         nj0/GEq7T2Aj7kLy4mvhjryETUU4UKWwl3NF24rusdzRoXodHEAoS11EXHY6EGteoZom
         ajNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVctNURRueVf7hq4zB4Z4cqB1oZDyjjSP0s1b0aUDR5+S7ydalNp2UIFXR1SE9CrGv6QHeUYg+05YrhKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGMTePTrLF55ycky9JDVJrobRktk4iVCEJYJR+oKQUfCjVk7U
	X4TZi6RxBUsdC/CBin/pgiPYjbUPikIvSvqHRnV9WrjRrP4+f0E51pvvOQUn
X-Gm-Gg: ASbGncsHMlXenpkqAHtSe9BUqXsn5+SKlMC9BlJBEve2GAdy1i4AGTtek8yEpGAOnjY
	DYFAFNFOuanOIlKMMZzyEGKGw+J7OuSh/4CTV2YIPCn1zGhv9fJWLY0K9omzVDuxQ/SFvtPiDeh
	+gH4sCNeSXpWxjxURakuq7Y9S355sOTB+kuR7/+r01pZiOAzPedUi0ipdX0hSCptba1LypSkMGq
	aXIMXY/TCvZPNfq1IKISo43CDbUWQU2PqAqckCOEJtYQFqye5sptuIg6Zk7JlKwH/PIfLyrovCm
	KrPSQMeVttCr4rhfRonYWCIPOZ4LShgOFsRKLZxV4PCM+N0=
X-Google-Smtp-Source: AGHT+IF9VU28XVk26daC2mTqspzNuZbNjUdKZ9qIjQPsZn1hhFXRxmxu6k5LBVmtgB181vLER+ecvg==
X-Received: by 2002:a05:600c:3b88:b0:43b:da79:582b with SMTP id 5b1f17b1804b1-43c601d67edmr41758015e9.18.1741365259880;
        Fri, 07 Mar 2025 08:34:19 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:18 -0800 (PST)
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
Subject: [PATCH v3 15/16] drm/vkms: Allow to update the connector status
Date: Fri,  7 Mar 2025 17:33:52 +0100
Message-ID: <20250307163353.5896-16-jose.exposito89@gmail.com>
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

Implement the drm_connector_funcs.detect() callback to update the
connector status by returning the status stored in the configuration.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 28 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 48b10cba322a..89fa8d9d739b 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -5,9 +5,37 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
+#include "vkms_config.h"
 #include "vkms_connector.h"
 
+static enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
+						       bool force)
+{
+	struct drm_device *dev = connector->dev;
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	struct vkms_connector *vkms_connector;
+	enum drm_connector_status status;
+	struct vkms_config_connector *connector_cfg;
+
+	vkms_connector = drm_connector_to_vkms_connector(connector);
+
+	/*
+	 * The connector configuration might not exist if its configfs directory
+	 * was deleted. Therefore, use the configuration if present or keep the
+	 * current status if we can not access it anymore.
+	 */
+	status = connector->status;
+
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		if (connector_cfg->connector == vkms_connector)
+			status = vkms_config_connector_get_status(connector_cfg);
+	}
+
+	return status;
+}
+
 static const struct drm_connector_funcs vkms_connector_funcs = {
+	.detect = vkms_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index c9149c1b7af0..90f835f70b3b 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -5,6 +5,9 @@
 
 #include "vkms_drv.h"
 
+#define drm_connector_to_vkms_connector(target) \
+	container_of(target, struct vkms_connector, base)
+
 /**
  * struct vkms_connector - VKMS custom type wrapping around the DRM connector
  *
-- 
2.48.1


