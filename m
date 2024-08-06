Return-Path: <linux-kernel+bounces-276731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894159497AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3371F22AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62C480024;
	Tue,  6 Aug 2024 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeBEAl6s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431335B1FB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969743; cv=none; b=U85JG849dw0xLHCiqzD7Vqep28YmDOCdguHsXfwiw2Uab4z9jN4VdbyM5sZ8k2JmUnCn3g6dv5XDj9VFdhjJcSzhQrnnuZFkD+4fyQXqV8CDpwrN5Ez6wVczWsCce99RFYlk+qrs3U0hUtpNDQS53DFLpJAGp9Ldr2plzCFbssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969743; c=relaxed/simple;
	bh=GyY4PhNUWlKlk+whyYrUpRBdriJGWzraFcL9FW/D/Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LejPlOFtN8Wui6LJT7wEwBNiz72HSHHl5Cop2L9DjQS4QBtJR/43Hx5w6+xB3Z90IIwzVMRRcoHW216hQy4Z4fXDCbCqkCAVr4rM8qnBR79L5mWHWby9jpnr3uokMJlwSvhQ5sFB0EjI4t/KappHdPxnCQ5ZtjIPkDppHZxKKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeBEAl6s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722969739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=01pYy0RoeEupYF7zERqbs3TQif/Fpq9bfAeMMVajTZo=;
	b=IeBEAl6sbHMJ3jvqbuK9aH/eLcpMoWfD7U18PUl1LKJJvuukWRyGgNmCIxrpb1HDLEwAyj
	GaJP42Lx6M4pArDO2Ox4t1KPS0yx7HtJRTLeEFS9VYtyrhMNXw/P+YG7aO+L4i9wJERzqB
	RbIlfNMFIgDzldP6LDKh0cssyVOnR2Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-QCi7aMyuP6erlRTY8DlxSg-1; Tue, 06 Aug 2024 14:42:17 -0400
X-MC-Unique: QCi7aMyuP6erlRTY8DlxSg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42807a05413so7426975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969736; x=1723574536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01pYy0RoeEupYF7zERqbs3TQif/Fpq9bfAeMMVajTZo=;
        b=vEARsdMjZ6WhcjDR/IY+4R2OYAk9adbL3MIOcsBp2xZjHtgUCWqLkx2XICEfnmqFvc
         PjOEWvOIfJtD85iAnGwjNfYGiTFe/d16r7mkXSnpQnUOBb9NfCNTLWUzU62yqPn+S+yf
         JT65kuYyp7s/xQRznzg/eG8eHg7eVLJc1C+5TmFcAL5JhcJ6UGWDAu+TYVl7taK08juW
         0BDvTlbSnx5yDq2/gdfoEXVu2abOHdrDE/f7wloLAxFx7jP1JRfAg7nM6FRfvTqggPwk
         +GeObUSQ7qikGkPCA5Z/JTN0bNQDXLQwsO5En/6llt8RgTHAgDfxH4XPdCP+G2kGqWxN
         4AUA==
X-Forwarded-Encrypted: i=1; AJvYcCVvbUD0CxIE2x7axmcXEwadMVCrteOQPY9SPlt6vI4F/7XlSRX1ptEVsxq+nd87SnJ8VN3QqGoiyBYDJxhLWQ8ol/01yZvHQX8XQMCV
X-Gm-Message-State: AOJu0YwxkQcTZNCRDQc86OQJu+Af7Sal2CXekhv00trwcUFIW1j3MhYA
	Awm6z9DSNNCYNEnjgQJpyFBMRgLWztuLmFxbuthxMPFcQelmA0Y6ahbHALlYmZn5e1lbW/YPBDB
	U+m7RgVZX0etDFlv27BOyXsw0XpM5AZKfni9Fe+3kKd0luHr7jt/yFYviB5gvLw==
X-Received: by 2002:a05:600c:4691:b0:426:61af:e1d3 with SMTP id 5b1f17b1804b1-428e6b93599mr102556305e9.31.1722969735936;
        Tue, 06 Aug 2024 11:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFpIvlI8k7114/ZEzme3IC5OCI9T0woaEQMiy/WOE6Z1hplw5fhcTbm7blEJxF4i2lUmGOg==
X-Received: by 2002:a05:600c:4691:b0:426:61af:e1d3 with SMTP id 5b1f17b1804b1-428e6b93599mr102556085e9.31.1722969735360;
        Tue, 06 Aug 2024 11:42:15 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:898e:ab00:d894:f48:6689:8e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3ef10sm196595695e9.24.2024.08.06.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:42:14 -0700 (PDT)
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
Subject: [PATCH 1/2] Revert "drm/amd/display: Don't register panel_power_savings on OLED panels"
Date: Tue,  6 Aug 2024 20:42:09 +0200
Message-ID: <20240806184214.224672-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Wick <sebastian@sebastianwick.net>

This reverts commit 76cb763e6ea62e838ccc8f7a1ea4246d690fccc9.

Reverting the panel_power_savings sysfs. See next commit.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++----------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e7929f24ae4..4d4c75173fc3 100644
--- ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6840,34 +6840,12 @@ static const struct attribute_group amdgpu_group = {
 	.attrs = amdgpu_attrs
 };
 
-static bool
-amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
-{
-	if (amdgpu_dm_abm_level >= 0)
-		return false;
-
-	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
-		return false;
-
-	/* check for OLED panels */
-	if (amdgpu_dm_connector->bl_idx >= 0) {
-		struct drm_device *drm = amdgpu_dm_connector->base.dev;
-		struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
-		struct amdgpu_dm_backlight_caps *caps;
-
-		caps = &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
-		if (caps->aux_support)
-			return false;
-	}
-
-	return true;
-}
-
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    amdgpu_dm_abm_level < 0)
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
@@ -6974,7 +6952,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector)) {
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    amdgpu_dm_abm_level < 0) {
 		r = sysfs_create_group(&connector->kdev->kobj,
 				       &amdgpu_group);
 		if (r)
-- 
2.45.2


