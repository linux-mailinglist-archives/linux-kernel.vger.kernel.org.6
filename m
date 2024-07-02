Return-Path: <linux-kernel+bounces-238464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC5924B28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35982885B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E21B6A6D;
	Tue,  2 Jul 2024 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJpCWqN0"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2101B11F4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957544; cv=none; b=ocqgJN2fIZeAQxAoE38dnGvscbRBPUdAYxRUl+jtlvgbDxiUEG2ENIexFXs0BfKspvVNdMbmhpjudb7WH0y6V8PUCtDbnD5DTn4ezB9YRx66qCIQt/6ppRjA/ya+rUJJrAZG0cVipm0wdhQtsuZt6UyBjXuTvRtPPfriiTZEk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957544; c=relaxed/simple;
	bh=HsVJ+8bSyTwxbd5PVHZFf8uV50bzhcBL2G646/K/2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgHAdcQnmzz6D/yaTyGglNMxZRK6YzdVxPi6wXJxsyL0i8PE5X/hEt/K/KqYYW56IScRRgOA8ZFtE+D2imS+EzKqV752pWPim9TxEItmInX+vSgCJG5yvWSUrhevRyNKaMJ6KMfUSWTD0jxOxGUz8rPncaf0/NQ2inlzihFlDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJpCWqN0; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3d3f1294dso169391539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957542; x=1720562342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc7kDWbr1ZOLQ8+EMlKcMIOk0gPIa550UiXaV/Fsdqw=;
        b=IJpCWqN0O5YY+ciAbjwuYsqQlyT6Fc9eCUCSbtWegSSQYY++6nXFu0HotUrm+Gyb1R
         gP73l4DcyUUb9A0lTJ86fCXyhEiwz5mq+iAUl17i+QWNRaVRtsYyeIkCrgF3LTd788yk
         p3RNVawBu8tdy3VTHcMN2mcWfQERpqqmZ+8Be+er5p1j79N2hDov2YxBICAQb1HWkSy3
         9jrivxWfJ3x5iFDXIfK1yux43edpI8FeojeGeAc5/LC23nTNcvoIt+SX9LLxATrwYrWd
         X2EUISyQLn+Eoe6AfKoRtDEnBUru//Hlkl13yvYQuVZSIvJvfwmS7sQrH6m3iEhK11s7
         DVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957542; x=1720562342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc7kDWbr1ZOLQ8+EMlKcMIOk0gPIa550UiXaV/Fsdqw=;
        b=OUT186lm1i+fVprC4v9eBNWSZ6fKuG6n+ZP9VQQkOnJM931/7k9Tw3Qf8m39hzIwXJ
         rK1k1bsAO4sjL00l7U6Wv3vCkzNinyyAbwhj3f5rUPIYFySqD+WzvUp5yunrHTKdmTqb
         R8NE7zladuP016qwK7bvaGeeN0A7sdpr8aWCpF++LBta45lmPaOvtRgsQ2h0Ptr5cslq
         /pq/PS1RbeBPtx2GDOCUS52aZMhZ/zG8xJA000d/rk/1EWwDxgdrm1sGBFB4kWhzd7bm
         rq//HstJZmJ3pgyt8nN4k/3sJT61OCa7nv40gwXxKpmAAEIShR9nksQclpyuCbMQDfEl
         pBng==
X-Gm-Message-State: AOJu0YyxzgISm4KSrW5i1VS5BCXq8aqluIRZBZFpe+eRhU4FwZhUvMMR
	FZ6oCUcMh1vuQseSpHH3kRd4Qivqk3zkC2US0XFPxqcPrBzl6FkW
X-Google-Smtp-Source: AGHT+IEDyc9E1PwwY+Pk3LT0DP2fwrHuyrUsNmUtygBhUpQrRyXS1AQocEBRzUzkRTfsja1fYVr45A==
X-Received: by 2002:a05:6602:54:b0:7f3:d795:d9f9 with SMTP id ca18e2360f4ac-7f62ee82b18mr1067791539f.18.1719957542151;
        Tue, 02 Jul 2024 14:59:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:01 -0700 (PDT)
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
Subject: [PATCH v9 36/52] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
Date: Tue,  2 Jul 2024 15:57:31 -0600
Message-ID: <20240702215804.2201271-42-jim.cromie@gmail.com>
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
 drivers/gpu/drm/nouveau/nouveau_drm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a947e1d5f309..27995c0c9b31 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -72,17 +72,7 @@
 #include "nouveau_uvmm.h"
 #include "nouveau_sched.h"
 
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
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
-- 
2.45.2


