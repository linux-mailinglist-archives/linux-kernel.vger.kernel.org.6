Return-Path: <linux-kernel+bounces-235288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB391D2FA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A946D1F211F3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11515747E;
	Sun, 30 Jun 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSc+/DYY"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB515746E
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766848; cv=none; b=UsQicXrVBQnPyShFoDpfH35k0bH+De3q8Hd/4GNMuAKgLO44XCJ88ZIKOdtkNfMRxiF6U3OMWxT5YJiSDsi5llz5LZvh8ycPI60j58vq+fK9kret2HGu/JeukTKYYkvzX4lIfdlsu5sDdNLKt7aMauJPyDuE9t+Pyrt+3dhNm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766848; c=relaxed/simple;
	bh=nEpCkBiwbFODLXA9jzwipHEHIfkSgL3slFEN2sohEBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7Ior3QC9PPXIMT1Z2vt6WXxSosE+idNZXGQpwu+sVx7hAEWSDQh8V4eF7m4dWBwK6hgbrMiLMmVTaUgaN6r0+83h0DIRAwKryRFPnJ4X3dV9ucO5NKH7p6PTWCauFsZwqaFQD1vt1iwQZsHDRYyGUpc/PWWK/k3DhXqhq2ZV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSc+/DYY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79c0e7ec66dso200012685a.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719766846; x=1720371646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHutpqbU2XFBkO4ZS+HSx6BtgstQ81ZFAirtiKOfnNQ=;
        b=jSc+/DYYRrzUWnZEUSAut1jN/KIPqveva6xF8D1lU0rcuwXYHqzdcQraNaSEGujXOc
         5aKsRLizEOIMUXNdfeFA5YXJavgyNG8PXs1nH6jRtZ+0xi4wSUlVo6674NnVZimLX6/d
         odd6+KT4O+4xMI3f56ksEN++Oroy7OGTy7MRP8TzKw01mcL3NhZu1EunbmzBW6rkgTbn
         0P8PR0CJuGhKQLj7kWoPJpZJPy3rhyprUmEa44HdtVkQpZ+U0OBdVxV4mwYkOiQ1tnJX
         XpSw8JK3Iyps4UmYWJdaly6lhPrIACyWYib/glsSO9//lsshnpf4wp+oCsalP55/1DsX
         BzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766846; x=1720371646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHutpqbU2XFBkO4ZS+HSx6BtgstQ81ZFAirtiKOfnNQ=;
        b=KJIzQx5J3bHorZDnBaeOhC/9LsCvB6HKys80Av3hYqIQ3BnYKEYwPzNXmwbeuoEOGg
         z5l/mDhwGjiAml1F6/HW3HMJj1Ez33HSGiNZqEVUdqZBvqESe5lRhyaah53Z7rOVNlrX
         cKozEg1hskVnHHcjNqoop6moWsBrkSZskhDWV+SlrF+4LZAKaA4gUlsuYIiARZ1qW+4c
         4L+HoJyQrxRouIgG8kLxL9dy/oQI9sO9Aqi3KCzyoRKTj9sMQ8jh7oulQR3Mg5wyJSNp
         QgXq/C5dcppVNyNILSX1nulIJ9bZBpwG9JbdzPm8s0RUVkGXTR/BKIFVuhg4xo4URkYC
         nWgg==
X-Forwarded-Encrypted: i=1; AJvYcCXDycF7OGs0BmiW1qP8aTqSaY6MqY2iMYjIg2eM4ypoyqI288wrTwC9rL4CN6BXJq1z0Zjw1SmofqAawBiJDwXLFojURxTlAyqQWp7f
X-Gm-Message-State: AOJu0YwgvrKf1e+aRXHRajORYT+KHWwrSX+kXAHVxcIV3/PihTCrh+Vn
	3HvkahkcmXhnb/mANN364I3lQp4t4f1O+zkDGQqTNsQUvPLagL3v
X-Google-Smtp-Source: AGHT+IH0ztPyCY6Dqt4NpzMUYWlI0A2tAzXkZ1Uarh7nDBydP0UxmseHQ2j6rrqIVN9lnOUSv3vNKQ==
X-Received: by 2002:a05:620a:204d:b0:79b:f641:e6c with SMTP id af79cd13be357-79d7b9b0fcdmr432140085a.14.1719766846526;
        Sun, 30 Jun 2024 10:00:46 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295f5esm263431785a.56.2024.06.30.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:00:46 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] drm/radeon: add helper rdev_to_drm(rdev)
Date: Sun, 30 Jun 2024 12:59:20 -0400
Message-ID: <20240630165949.117634-5-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240630165949.117634-1-wuhoipok@gmail.com>
References: <20240630165949.117634-1-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper rdev_to_drm(rdev), similar to amdgpu, most function should
access the "drm_device" with "rdev_to_drm(rdev)" instead, where amdgpu has
"adev_to_drm(adev)". It also makes changing from "*drm_device" to "drm_device"
in "radeon_devicce" later on easier.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/radeon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 0999c8eaae94..ae35c102a487 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2476,6 +2476,11 @@ void r100_io_wreg(struct radeon_device *rdev, u32 reg, u32 v);
 u32 cik_mm_rdoorbell(struct radeon_device *rdev, u32 index);
 void cik_mm_wdoorbell(struct radeon_device *rdev, u32 index, u32 v);
 
+static inline struct drm_device *rdev_to_drm(struct radeon_device *rdev)
+{
+	return rdev->ddev;
+}
+
 /*
  * Cast helper
  */
-- 
2.45.2


