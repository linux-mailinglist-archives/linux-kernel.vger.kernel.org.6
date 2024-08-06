Return-Path: <linux-kernel+bounces-276730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887A9497AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD541C21DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC37BB15;
	Tue,  6 Aug 2024 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBWObezb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C262A1C5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969742; cv=none; b=j5O5xhNDG1Guc9v2+jcIcXBOfUruEGoBYXIGrMyqWfhsPeiMBLTxMAZSsUo70JAleg3aeGKY15QPO+9DmR6xEjskvB7s4H7fbFj/9kOe7GdmgliJoIsyYpclZY0m2oMagdJKsVI3y/gDnj5DDw7+/2JDxVCLKLFptfuKGqhy6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969742; c=relaxed/simple;
	bh=8/LNtSdxllfNhsk0i9Qk8AYD4pKa1OaINKSVCMv+I3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxi/BeMWHvw3F1C7M5GdH9i+nCHVUrAznR88SV4hZaCvVLQ3gyBHa+Rm26jxxdtsL12JMIP/kkhoBELS9iDHPHboDF4MOoSBFxFmx+z5gzPVyeUpCVEuPS2yeplqLsedsGZBvsF5um/tWbHThNWMCvzgTz7ZcS+q5L4x+m+y95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBWObezb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722969739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTOhpRVmhZuXkHBiygGH1i2Eclfn36V87P5jpIjXJgU=;
	b=OBWObezbOdihyL5U9Qqsbq09pej8mJr/59ULsVTlZV3lt0IugRquxIgKwI7PsNPIZURH2C
	//Ur3bmX9UG/XazOqRrY38Lt5D6WxC8rcP0mV2vfwkm6L8b0X9VP5y0eZt966T2rwKYKZS
	HN5Gs3tkQCU012EjwiZc/6beyKjMxCQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-sYYEXG7aOOe91eXv4XdpWA-1; Tue, 06 Aug 2024 14:42:18 -0400
X-MC-Unique: sYYEXG7aOOe91eXv4XdpWA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-368448dfe12so50364f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969737; x=1723574537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTOhpRVmhZuXkHBiygGH1i2Eclfn36V87P5jpIjXJgU=;
        b=VdjgHv8u+GjUc0BDkcKOX0WOL8C+ej5i/fgLp1bt51OJOD1faxZSDjxVZv8Dwwh63I
         bVe5FjVchIUym3uJ9ofQnSdyJk7zXqcPYw4gXfl3L32rQGR29yVky9Z8TMGCBDtAM/Zc
         0h9p5fFojHf7P3UaqnHm8mfqjRpqp42dleqX1RPPcNhVhqgFAyC8AzzkyoAh3vFo08Ch
         RxqZJFUfRzw1ArjRvIlHzaiOQQrJJpBjqTGW4Eh/ZTspfyxgkxLq/66ONDXbpcr4t42k
         1EMZyMMN3ctsnyL5YGAxFXH8dbSDAjYILAqPh4YHa9s70L8GikGTx/LlJGuezrr4nLpM
         CyJA==
X-Forwarded-Encrypted: i=1; AJvYcCVDyC3nFgaLkk+Illco/x33iArmz7r+UNx9IEmYBPSKtFjnOKoPORlMLvS9Paal4V44FpLP1oL44VNugJFmxV6tVK/88viIlcaCHLs2
X-Gm-Message-State: AOJu0Yxq7tYi/zuE5VBWP1+1xz4DFI80KBThNgYhvutQq9SepBDiIZJ7
	OnzDPgbvm8P1bx0144TrrDdbtOyri4/DIOfcI3+YIjdLrtbn/e8DSVn659JaKBDkgOJzyk4NcZP
	IviFPlD72ixhGcZ2jimxFxyFatLYDDHh2rHwPyifxrdZDU0SMKfo4++dZXmFPdQ==
X-Received: by 2002:a05:600c:46cd:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-428e4713f62mr134423475e9.6.1722969736663;
        Tue, 06 Aug 2024 11:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr5Jf4uJJrllifZn/qGW9eINl+OCbwq5032Gwf/jPT83g6dT50HU1rINEr2nwgAWfHi7K58Q==
X-Received: by 2002:a05:600c:46cd:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-428e4713f62mr134423345e9.6.1722969736214;
        Tue, 06 Aug 2024 11:42:16 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:898e:ab00:d894:f48:6689:8e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3ef10sm196595695e9.24.2024.08.06.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:42:15 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Sebastian Wick <sebastian@sebastianwick.net>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Hung <alex.hung@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Roman Li <roman.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "drm/amd/display: add panel_power_savings sysfs entry to eDP connectors"
Date: Tue,  6 Aug 2024 20:42:10 +0200
Message-ID: <20240806184214.224672-2-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806184214.224672-1-sebastian.wick@redhat.com>
References: <20240806184214.224672-1-sebastian.wick@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Wick <sebastian@sebastianwick.net>

This reverts commit 63d0b87213a0ba241b3fcfba3fe7b0aed0cd1cc5.

The panel_power_savings sysfs entry can be used to change the displayed
colorimetry which breaks color managed setups.

The "do not break userspace" rule which was violated here is enough
reason to revert this commit.

The bigger problem is that this feature is part of the display chain
which is supposed to be controlled by KMS. This sysfs entry bypasses the
DRM master process and splits control to two independent processes which
do not know about each other. This is what caused the broken user space.
It also causes modesets which can be extremely confusing for the DRM
master process, causing unexpected timings.

We should in general not allow anything other than KMS to control the
display path. If we make an exception to this rule, this must be first
discussed on dri-devel with all the stakeholders approving the
exception.

This has not happened which is the second reason to revert this commit.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 80 -------------------
 1 file changed, 80 deletions(-)

diff --git ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d4c75173fc3..16c9051d9ccf 100644
--- ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6772,82 +6772,10 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	return ret;
 }
 
-/**
- * DOC: panel power savings
- *
- * The display manager allows you to set your desired **panel power savings**
- * level (between 0-4, with 0 representing off), e.g. using the following::
- *
- *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
- *
- * Modifying this value can have implications on color accuracy, so tread
- * carefully.
- */
-
-static ssize_t panel_power_savings_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
-	u8 val;
-
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	val = to_dm_connector_state(connector->state)->abm_level ==
-		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
-		to_dm_connector_state(connector->state)->abm_level;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	return sysfs_emit(buf, "%u\n", val);
-}
-
-static ssize_t panel_power_savings_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
-	long val;
-	int ret;
-
-	ret = kstrtol(buf, 0, &val);
-
-	if (ret)
-		return ret;
-
-	if (val < 0 || val > 4)
-		return -EINVAL;
-
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	to_dm_connector_state(connector->state)->abm_level = val ?:
-		ABM_LEVEL_IMMEDIATE_DISABLE;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	drm_kms_helper_hotplug_event(dev);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(panel_power_savings);
-
-static struct attribute *amdgpu_attrs[] = {
-	&dev_attr_panel_power_savings.attr,
-	NULL
-};
-
-static const struct attribute_group amdgpu_group = {
-	.name = "amdgpu",
-	.attrs = amdgpu_attrs
-};
-
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0)
-		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
-
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
 
@@ -6952,14 +6880,6 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0) {
-		r = sysfs_create_group(&connector->kdev->kobj,
-				       &amdgpu_group);
-		if (r)
-			return r;
-	}
-
 	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
-- 
2.45.2


