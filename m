Return-Path: <linux-kernel+bounces-570232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6D0A6AE01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19E44A2612
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A2237713;
	Thu, 20 Mar 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXpCrZsL"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB479236457
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496833; cv=none; b=tSfROUcYjlhV+JunFxFnybVNSuYFwu3SZqaMIcRq9+VlUnqesO9l6F0ES6QQQsc3tABoNo5l9etODfzz2uI0dLNOXgbk7oWhAtdY3G02qaZX27rrha4QFf82B0vW4hvJADvBb83UFGQSRtbStcBOsDP4RK8FZua8JWasDlrG+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496833; c=relaxed/simple;
	bh=WO84BC81aPkf8NiCFVzSg6a+pS1rTrwLykHCk+BIFVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkZCCXLonbdmdQ/NDY+nF+OI6FgcCdP/goEc5NZ6t1qbGbJRqcNgKqdvx6ImuzPnvlPCZvYyTZIriHOBCPP/hUamDi4/k61f0SUHxK9L4JCTYoNKjlmqiojuyMVwo1Y5P4I5vk/pVypVRrp8zZqA61PAInO+xlaEWuMDVZjAdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXpCrZsL; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b5e49615aso98856639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496831; x=1743101631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOnjwrNgNXmQwo8Xc/3OEw5JLT52e2RrDPlaTkjrhJY=;
        b=FXpCrZsLgj2OHFzTJ0uBzAWUHScmnryaZomR+m6c4gpfWdJW4hnK4/9Q7/ps5iFCGA
         miFoaHnopPBil6fmQCKHuEMZhTpYZGXdTGHo1KsED6o3WTRng0duXlhVi1LMOF68oCRm
         YfCgne1rfaQA+4ifOqj+SsCN3zyvV1Ob1c6uhXbnKk75goc4ErRS8JT82nwPux5p/Cjq
         7X9fiJ2duS89hnY1s0txDkm9h3zlbmCo6nX7HUSetIL6SK/AkWqCQZzfA43KyF0QVW4C
         eD/MDFikjG5k1XlL+zGi/VAxrfjXbIE8FfhaMvtRIc/WyM4gxTYFBtmL+Zm0UhLBaS0R
         SuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496831; x=1743101631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOnjwrNgNXmQwo8Xc/3OEw5JLT52e2RrDPlaTkjrhJY=;
        b=pzdu31C6DSmD5bNJpov869NgVnSUH9W3u47av86rk9I+XI0wyAaOuk4hkCXZgAU7P8
         VxRH9D3BGsL/epf4JyCX2RjPFiMDODnBUl/Tg07i1U5MogU3Me4T65iyQRDGP1pogTYm
         Y79t9++rUhXrNhPrRrUzhz29q3UfPGUpRefvKHwPnEe+KUpUmF5CZOu4m3VZm3vMGntU
         /snMx/s3cHDDT4UeghiQQx2AdrkrBBPSS22Mx0kGIroJb7xf0ptCyVGZXdJ9X0A5orT2
         2MV7SsNNmF3M/5ac/uYKDe+bIrO7UbhOvG0uPqB0E0BtRZ/h1sbdFB3XobMatrXDflwd
         3mOg==
X-Gm-Message-State: AOJu0Yy/BjyqwiWR66m40jjh2ZJ3swkYSMfBEvVtZJiiZFdZyk9xlggD
	o7TFKPMKSYAdwulijFo0FgbEXRY2w2TpscchEVxfkDpRG4t4x0j5T0oM/RKC
X-Gm-Gg: ASbGncu3QFcQsn8XdEbGop1HXXzoIA+alGId///iuH1geAYNoz77IidcfyX/HlJGVg1
	WLxg9hWFKfi9ebjJ0hY4mNmOB2TdpuRPcRn58WHJ88MmfxYZDdXIQgks31yBfbI+ypygRJRuO91
	mDrWchpko+hUjSHp1IcIlcFC9nU2XHY+z+9097ZshrnClPn6Aj56LlOL2+gQZigTFYSEop/xd+/
	tKasq2M8ad63h7KBasB5uG14HJDA32f7fZ5fvKBtqPproXrCA5GRll1E3I2TK4agKFN3TS9Znce
	9j32yTw7m3dGSZGliyKOx0e0fQYV3nG3R6KNIOIkZULtHcXX56L6zsrTzP5Zw9SEanQDn+SYZaG
	X8Q==
X-Google-Smtp-Source: AGHT+IEkXfyfgc8DOtUffsyGAP4ytd6cOqEMSx2D4ufj2/8LvypyXJa5qCoVaVVDmcFvkRtysEUacQ==
X-Received: by 2002:a05:6602:3a01:b0:85b:3d1c:87d7 with SMTP id ca18e2360f4ac-85e2ca36477mr39378439f.3.1742496830852;
        Thu, 20 Mar 2025 11:53:50 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 41/59] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Thu, 20 Mar 2025 12:52:19 -0600
Message-ID: <20250320185238.447458-42-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
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
 drivers/gpu/drm/drm_crtc_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 0955f1c385dd..1d08d759f238 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -50,17 +50,7 @@
 
 #include "drm_crtc_helper_internal.h"
 
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
 
 /**
  * DOC: overview
-- 
2.49.0


