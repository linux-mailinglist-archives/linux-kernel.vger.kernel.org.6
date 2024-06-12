Return-Path: <linux-kernel+bounces-212326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604B905E83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACADDB22941
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB578129E94;
	Wed, 12 Jun 2024 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kdMw/eYn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B281DFF0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231324; cv=none; b=sNSSPX7ph7gDZb+7RVrsLS6ezORLGSTVioY90/gpSM9Qqvzq/tZcQYn7VAhesfRISRFgYKhWXFVECE+Jy2kqPOeexgQanAdi6qJ5SKcNmgO5GGsfnnCHvlcPu/gVHEFCbMc54J5630AwRRysyBNRUlUhruWFG0hfuPqHRahkmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231324; c=relaxed/simple;
	bh=ovszzoD+l1HTEFhiU4/Ym/jkxpe19V1Bxj8HyByAAeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s59oaM3gKm3oGR8fIsOnHpW3BsTiYeJY9MA3yK4RX/l54JnnwX5SCCTFfKPvJesH+FHR5ypfzY3udN5gbS37Dp9rgIwH6WVgSAvxxwUOhpGU3G6fMMmwCLq8UY0P+KiAGaQd8zkEpqRgdXq9SKxrDWpypwgi7T2mMb8Q3T3H20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kdMw/eYn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f7028196f2so3372695ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231322; x=1718836122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/jWWU1pq804c3ou2ews3riGNTGElQFQ1wAS5cHqZxA=;
        b=kdMw/eYnIS9YM2lPJCLnDePC1E13EH3z6QdYHe7Wymd/aDP757eYh2RjCllrknQJTn
         bvl1Pj2Rvv+ydAq2DNodyxmJ9rkseErPa6ESw+9k3sf+CAODnWc4BGcRLwklajA/7hrQ
         22DKMtVYrnIE5nCk5h+ZPaPETLPs0LWg7D8bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231322; x=1718836122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/jWWU1pq804c3ou2ews3riGNTGElQFQ1wAS5cHqZxA=;
        b=bsmIOFJjGPz2BBZvcs1QtGMTXS+S3IKujCTumCDWA1QM57lBNj2SRmxB5EijpEmGzU
         oLUpHqxGDCC7sNXE+poJtvOjUOhc1xXZB8Sa3ldBs2HDjrZvoGXyhMVTvekwcKQqRwyS
         uFqJm9jsOn61G0qiFiAF2E27uH9GLj4TGaCiNdnPwarjR5cSuX6sEviZXUCOuSqHoKVZ
         +Qpg4/gAQ/GsabHDBwKOz6ECTxb1SeTCf3FosVjqSsLf1c774DeLpvN7o/+BMaNu8oUu
         8NLUqSOinlYxOUyCAA9VicKU9bfPYgRp0GlT3LEAmgojB4DY+hgH5GZWSY7BGKSQCsxP
         Tz3A==
X-Forwarded-Encrypted: i=1; AJvYcCUdMTlwcF/3pAgq74tKmyXQjY1cVGl9X25DsYhWUmEtD14kA12570BYGY8UfUIOG+NFjmo5TYs+MvLuICCV69XQs28c9AS/IzMvfA17
X-Gm-Message-State: AOJu0Yy05ns1mC43rHLF9e4kyJ7+XYM8gV6b46j0f+cxVAERCEWRVsJ1
	CKN7bj4P1sES0dJO2V4qXZ8mvj+WR8L9m/RdfcZgeMzzGuLpz6pmWRtNLQVb5g==
X-Google-Smtp-Source: AGHT+IF/TlcvLXIfZfu54yCkggfRcKPb4J9ZvGiYz9EXPf3MwPKKQhOCuUiLPrDC9MOJJ/dvVbiIOQ==
X-Received: by 2002:a17:903:234a:b0:1f7:187f:cb5b with SMTP id d9443c01a7336-1f83b7f5871mr39623195ad.64.1718231321795;
        Wed, 12 Jun 2024 15:28:41 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f336d172sm87788575ad.247.2024.06.12.15.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:28:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] drm/radeon: Call drm_helper_force_disable_all() at shutdown/remove time
Date: Wed, 12 Jun 2024 15:28:03 -0700
Message-ID: <20240612152752.v2.7.I022cfc2dcd30e77d4f7005a2d912dd7ab76c0338@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on grepping through the source code, this driver appears to be
missing a call to drm_atomic_helper_shutdown(), or in this case the
non-atomic equivalent drm_helper_force_disable_all(), at system
shutdown time and at driver remove time. This is important because
drm_helper_force_disable_all() will cause panels to get disabled
cleanly which may be important for their power sequencing. Future
changes will remove any custom powering off in individual panel
drivers so the DRM drivers need to start getting this right.

The fact that we should call drm_atomic_helper_shutdown(), or in this
case the non-atomic equivalent drm_helper_force_disable_all(), in the
case of OS shutdown/restart comes straight out of the kernel doc
"driver instance overview" in drm_drv.c.

NOTE: in order to get things inserted in the right place, I had to
replace the old/deprecated drm_put_dev() function with the equivalent
new calls.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I honestly have no idea if I got this patch right. The shutdown()
function already had some special case logic for PPC, Loongson, and
VMs and I don't 100% for sure know how this interacts with
those. Everything here is just compile tested.

(no changes since v1)

 drivers/gpu/drm/radeon/radeon_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..9ea7f163a731 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
@@ -330,7 +331,9 @@ radeon_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
-	drm_put_dev(dev);
+	drm_dev_unregister(dev);
+	drm_helper_force_disable_all(dev);
+	drm_dev_put(dev);
 }
 
 static void
@@ -341,6 +344,8 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+	else
+		drm_helper_force_disable_all(pci_get_drvdata(pdev));
 
 #if defined(CONFIG_PPC64) || defined(CONFIG_MACH_LOONGSON64)
 	/*
-- 
2.45.2.505.gda0bf45e8d-goog


