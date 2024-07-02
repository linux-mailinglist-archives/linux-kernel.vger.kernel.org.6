Return-Path: <linux-kernel+bounces-238454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7267924B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847E7284174
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427C1A8B3A;
	Tue,  2 Jul 2024 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1S+sklg"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8251A8B04
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957535; cv=none; b=M6qrcVFuvCBQhwH2Xf548UQeXap0aeTVFvqQ821cqXf4P2nPwyMD90e+Iet9G6NUnR4s2Tk+TwvMjxfLDynjf6TrUl94WF3JvHi14oC5z1pMnbW2WNN3V5x13Wd4unhmIi3NUQcXETOInSg3PVQvCCEUQOrccXKa+4IuycOHG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957535; c=relaxed/simple;
	bh=ZaC1vkdGQIEO4AVm55hDQCbxRTzLsnX/1CWODuwSgZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8lUXUHh7vIJ8eHNsA1IQHu6f00ASFEn4U2sWdeVH9BfKUPoNTmBZXgxSOy+0DQyJnro0xHhvlwStjaDudAkX6Ou/7ghyb4tNjiCX/FIsJc4gqay6bjpekwk3N6brglDIbjvZWG9LzIkS7tUiggv01hCf4fSVjzE152W9Cyq1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1S+sklg; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eba486df76so868139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957534; x=1720562334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK1rhky1L0Uh2dLu61vy8boLc9OqspSM7tQ5uDrS370=;
        b=T1S+sklg982OboW8XCXsq2CIfO63KwLQaD5i9U7yrYNnO5WHsg9QEu/3n2wlf+NUu/
         3BMZUtY1MXt/rI3OhQLifgGIjnjZmkyr8cb4B8kHyeE0sggBLFUXYhAUWAbmRDXf5ULb
         OyFwOPDI8N81QRtLY1D37Z7+pDxFu5mhYHRJABZJKLHj/8AVXuTLhoXYv6/qYFzKwSLg
         cPuOO77N+a2Ksuu9HH8JBvCQLAqXt9h/KL0jBnIcBzksRxaEmHHSkmtTT3xua5rw/+Df
         g54FFPtV0MixEYa6/nXxLEy+VRHcrz0SJcmH8VgZ8CxRJFOBWZqcSa4QjM0bgFNglBzP
         Z9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957534; x=1720562334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK1rhky1L0Uh2dLu61vy8boLc9OqspSM7tQ5uDrS370=;
        b=PamSEXFiH9GW6neZhEAHBPNyd+WQNaY2gQDNw20wDf38hJe0z9FjLpwTzarNR1YaJb
         fq945D/qvhTvVfd8es5zdnpH4pGH0zKJjiIMYKcsX5oZOZdLJvTSsQrcweJoP8cjthqU
         otsNFmcukv1wWeKxZBoRSpKhJZlT3NM8gnrGUKiq1J62ue9OyTjAu7XNiUDEwlQ1Da7Z
         z5ov5XmRIgH222pQS3PRmQHHjOYLsz3DF/ujzwnki0xrqPJLaoHNTSPxp4ltL6syAqCw
         Q7a9mxB39UTBOpxqYpUjKH+qf5K7bDA2RNIIwv1qbT5siWgL3hkTWpWslrAwWdFZWbwA
         J16A==
X-Gm-Message-State: AOJu0YyWAavfTpCYMykhgkQ4f/p9z0SVCsFSwfk3D2cRLixbDnEzTttq
	b4hpIlzajru8xVw/Tg9KyNOEeA0oiFyj9MZlbRXzget4Zka/ZsGA
X-Google-Smtp-Source: AGHT+IGYp0RboRXc4AYNUXGuU4aFvoVlXDTzLDPuxZv6t3qpmmIpFtCdOXEccDrNUTrugIVGTZM8hg==
X-Received: by 2002:a05:6602:2558:b0:7eb:dac1:16bf with SMTP id ca18e2360f4ac-7f61f5243e0mr650832239f.6.1719957533818;
        Tue, 02 Jul 2024 14:58:53 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 32/52] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Tue,  2 Jul 2024 15:57:23 -0600
Message-ID: <20240702215804.2201271-34-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e4277298cf1a..b287f0cfd8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -217,17 +217,7 @@ int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-- 
2.45.2


