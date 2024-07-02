Return-Path: <linux-kernel+bounces-238457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9EC924B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37281F28693
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C820FA9F;
	Tue,  2 Jul 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1ISPZCH"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E021ABC29
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957538; cv=none; b=fboKfO2iaOtM+aJjjEAZYP/7SRA3kqE4KSkrCRF8go/5Qgp7AbuUH1CHyS5Jk4P/7oaoa9v0yG2fWafc4bbhlFQemAJ2O5vMueNVIrmBM6L7pmVXHSaLxHzNCvnOZ4JfjblRWCvfwvlcebQeucbBHiwY8X8DOUCPkladQNlJIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957538; c=relaxed/simple;
	bh=gmzz9xKUKEU2FwGVjtUT8xi4cORsbLKLRijp90yxR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOSlK0CAw27h5GmXrrvJgx5By7PStT6lDcAyy12QLQ5VJNzokI0S4SbujtmFuDBm8vptSHZ/hvOOcAazBzp9l3e5hDYB2Uz44rXWKJDl9GyvKdlTIWkyxlV2c9/LmqWmAHCM2Fwegiw9XCY6aXEChzAwrwKXfhJj7CoYZ1R6BaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1ISPZCH; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eba486df76so869039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957537; x=1720562337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SUm8Nyqte9xAsE2tQLuwSyCdCfAncJgW1l33uKzz4o=;
        b=Z1ISPZCHMpmR/juDZFPqc+FfFfdiExFEAn8QnzkGyYwA4C5WUdfTsNTmkQwlm366/j
         zmn4EtfEidPE5liJ4uKIfYpKQrXg/KVpji0ded+88EBYpzpwF6afV8BgtXgpg1wk1P/7
         8vp63cxeoQ1ya1LC4TBgppDq342cgRMraWn0V26qPJXrLi7I5vv+EDs+5Tv4vZNR5RPQ
         JINmTRkug5KLcgIrrWpE1Y/4bEebZcgCsra927iJP1oDHFNWI65eJx+LR9kbvnjoDL1o
         eqzIyu9PWtNcgmvRAekTTOYmKSmCw5Y8AvNLDC5OQzentaJ6wnDbTW9L4l8NBV4U7D7G
         D2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957537; x=1720562337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SUm8Nyqte9xAsE2tQLuwSyCdCfAncJgW1l33uKzz4o=;
        b=V4tDQXuRJh7rE6KBfdCLu6lZH5/Nea+dUAXmcpryuJ+H9NkQsIZi5Xj4dmka+r6dEp
         DzaPUfhlgg1Axx1CmEenoJ5pIm0Tnvz4vyVY8FnsYX0iqQW1BPrwLS1dbfLEA+QK8ybd
         EffNz6f3S3Nbzu+FaaIrp56VC3x4tExQ2iucFm+k/xUVhCV/LuUtkAeqsO4l968zsAq0
         b+H1J1iSjABPmYo0SVqWIiLOWtQxzYRSH8OzYrQohsSXh4p6jbMLSIQC1SSGeLbvqBP6
         PfA3aUy7PfsfZYBn0ggVvMHm5JI9D3lD7uD1U2ZQa5isCtmzM1v75S3Z05Y0IlyYgj5V
         B3og==
X-Gm-Message-State: AOJu0Yw9OicNoJoCgDIGMx+qu8iQ7oA/skOsdX++fm2LzOTlT2N19I9Q
	nAaJUmCaQjBuy4XZTSCCGHe/mhdM3xbd1FXH+unebuswKCVRBKHW
X-Google-Smtp-Source: AGHT+IED/9tj/T0S2oY6w3s41P63jq6wO6ykpkmAJc3dcy/2ScxeaNeGXWxznCgBmuXHX3egfMu8Vg==
X-Received: by 2002:a5e:8d02:0:b0:7f3:d863:3cd5 with SMTP id ca18e2360f4ac-7f61f524391mr662424439f.5.1719957536733;
        Tue, 02 Jul 2024 14:58:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:56 -0700 (PDT)
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
Subject: [PATCH v9 34/52] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Tue,  2 Jul 2024 15:57:26 -0600
Message-ID: <20240702215804.2201271-37-jim.cromie@gmail.com>
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
 drivers/gpu/drm/drm_crtc_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 2dafc39a27cb..e9d229a393f4 100644
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
2.45.2


