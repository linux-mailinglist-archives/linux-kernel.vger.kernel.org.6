Return-Path: <linux-kernel+bounces-416765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513499D49EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D8F1F21809
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7E1C7299;
	Thu, 21 Nov 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoffOYkd"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9082890
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181057; cv=none; b=J9yZuWiSzjH2VffM7YvZy3qEt/HxexpRvJ+e4SfTx0hms4nTwQdFj8oBYTAKvPcvRdVAs9ojhYT2xgYcUKQoeoBIOZ1bx0ZZ0PgpOQ9Wokn39vCdYxvOhq+zbvlWE4p0uToPX0nV8wQfBsVnUYetL9AtgDx4UrJJSAf5858OQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181057; c=relaxed/simple;
	bh=YIvR/FcWchEFYkSvjVNzlb1IfbQeE4XBcgUMTXBCt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNnJ8vtwdnDHeBH661QuBxS3yQCjgHbxCGmNAV/J/CP21PdUF6VkfWj9nZRnXrSQX4+N1+GlpaKao+ZfXs6MiHkeEb8+jA7e3D+BWI4L+0zv3rB7qGrBczzsndbi5WWLVYY/nWIfzY08QTsi03t7R3m5bg/or3f80HM/EI3c4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoffOYkd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9eb3794a04so79744066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732181054; x=1732785854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7j4QqoxhFbCgJwkjEEmxm2qKB1etaPM/Wk727FzG74=;
        b=eoffOYkd2Oj3PdCvM4y7M7FsJQAlaVmi43ADi6NAc7Ze/RXyezRU+dMrOkUma8AapW
         F4re0bs6ws5suM3YkB6d1/iE3bxF0RzoqrtlbBLvd1yiHZgoSK2vzVdBNPkPNWjYamCF
         HiNq2AkHo5wEfF16X6C5M64cSpGwGluXt0hM46z+jZYyndpo42i+1JlVvgwhP/ElrV52
         3hGKrYUKTmsP4/H8Cp/ITkaFxWCPXpD9TCeRXeUI9qQCvJ0DiQv7/1NfJK2sxapaifTX
         70DT6MvbHWXCYZJZnEVfPJ5QiAtJNd4RJktK4IYa2QhW0Oqg9up5Jo1cJP7tpcvVEhR1
         MYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732181054; x=1732785854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7j4QqoxhFbCgJwkjEEmxm2qKB1etaPM/Wk727FzG74=;
        b=P6HpYHQP6OReoYgyuMCSJ7ZzZz+d44mPI0IMk3FrxOA6ohMUAa72X9jxMTDILt5vIF
         oa04Bw4+qYvGRm6htGp/vv1lm9XcCr3T2284ysCxSF2+ak30geoO5//LbmOAYWghLit/
         9a3JNtX6HBfwrcTcERmpXOmIQmaHARc7N7Dv69yF0FhaY1Pf2BFjrgGeT+0/09Xdkvks
         TglhPLpcGJpY3fYAlTuMdQoXf5iYQzOm8tI4STdmaL3QIDcVnEgkATX6SAaepwtL5n+H
         CVY1z/ql9UUfHplTxaEtahR9MRQy3nMa4Ozsm6nBUS5M+TgnvxV3mOvUYoYaw+uxNWME
         x0iA==
X-Forwarded-Encrypted: i=1; AJvYcCUGmSDhMXEbcHmJA/2Y3C+ra7jGONoLH4cY3WF3w4EtFDvSDpgP1Njtxd+IjD/NWWl83bn1P8szMP8EEZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNT8Is3ITW78gS3GUGH3+VHV/DBhzLdNAL9lZc5T+AoEn9RaJ
	b6QPzbFePTWwRwwhqYipaxeVnjW+uloLm8kJNB5blztM5xPoTGRR6YM/OM1i+m4=
X-Google-Smtp-Source: AGHT+IEZYPG7qh/PlestFeKGHpZh1lDojcSBdGkG+BBHCtprwgWlBnbq7O9VkXEfLN5oXr+sCBlAcg==
X-Received: by 2002:a17:907:7ba3:b0:aa4:9ab1:1985 with SMTP id a640c23a62f3a-aa4dd760d98mr510243766b.51.1732181054107;
        Thu, 21 Nov 2024 01:24:14 -0800 (PST)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at. [62.178.82.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4153741sm59112066b.20.2024.11.21.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:24:13 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com,
	tursulin@igalia.com,
	Christian Gmeiner <cgmeiner@igalia.com>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/etnaviv: Add fdinfo support for memory stats
Date: Thu, 21 Nov 2024 10:24:08 +0100
Message-ID: <20241121092409.3859592-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

Use the new helper to export stats about memory usage.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 12 +++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 ++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..35f47dd6367f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -488,7 +488,16 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
 	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_FOPS(fops);
+static void etnaviv_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	drm_show_memory_stats(p, file);
+}
+
+static const struct file_operations fops = {
+	.owner = THIS_MODULE,
+	DRM_GEM_FOPS,
+	.show_fdinfo = drm_show_fdinfo,
+};
 
 static const struct drm_driver etnaviv_drm_driver = {
 	.driver_features    = DRIVER_GEM | DRIVER_RENDER,
@@ -498,6 +507,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = etnaviv_debugfs_init,
 #endif
+	.show_fdinfo        = etnaviv_show_fdinfo,
 	.ioctls             = etnaviv_ioctls,
 	.num_ioctls         = DRM_ETNAVIV_NUM_IOCTLS,
 	.fops               = &fops,
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5c0c9d4e3be1..e81c261b0017 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -527,6 +527,17 @@ void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
 	mutex_unlock(&priv->gem_lock);
 }
 
+static enum drm_gem_object_status etnaviv_gem_status(struct drm_gem_object *obj)
+{
+	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
+	enum drm_gem_object_status status = 0;
+
+	if (etnaviv_obj->pages)
+		status |= DRM_GEM_OBJECT_RESIDENT;
+
+	return status;
+}
+
 static const struct vm_operations_struct vm_ops = {
 	.fault = etnaviv_gem_fault,
 	.open = drm_gem_vm_open,
@@ -540,6 +551,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
 	.get_sg_table = etnaviv_gem_prime_get_sg_table,
 	.vmap = etnaviv_gem_prime_vmap,
 	.mmap = etnaviv_gem_mmap,
+	.status = etnaviv_gem_status,
 	.vm_ops = &vm_ops,
 };
 
-- 
2.47.0


