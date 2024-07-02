Return-Path: <linux-kernel+bounces-238465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEDC924B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B321C22763
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBA1C0930;
	Tue,  2 Jul 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Da93wx"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6E1B1215
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957545; cv=none; b=TMdYMBmNgIgDl+sJEBW6Z3AouIfEFlUxNwGsqMbeqeBczop4T+WTjcVtP3KCe2npwJZdBYmIaSIVLDikPuXkuCN9spoWB9Y45QmHisD1i1h27AkJ9PLL9R8oHoNLpHliz4gykNC+5v5rg4Hluk5n04seUV6KUx/l6UCyS025pAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957545; c=relaxed/simple;
	bh=HsVJ+8bSyTwxbd5PVHZFf8uV50bzhcBL2G646/K/2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t92RZaFPSGXyWW+YthLBS4AAaUjdL6qmRZ+hT9jVIuUKu/2KHgFsCFW4iXmr2eGj8zbJPEwXVpwvVczalgPRuUaNYYSzQFhcMTlmQB5DPXnv1ZiepnEmzbQ9F7rIzQeix7OhOjDGhLBhG8HBv0xMA2cNGom2csfb2PJ+XNtNOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Da93wx; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f3ca6869e8so168994939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957543; x=1720562343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc7kDWbr1ZOLQ8+EMlKcMIOk0gPIa550UiXaV/Fsdqw=;
        b=G7Da93wx6fn1iPHLsVMNJ7ZK3+mNFvgg0SWnz6P7agZjhSsUM0SRaRavyZL20xVlsZ
         +nDuWfcoMK4HNFicOdpbHWVmBuHcY1mZrEnB3hr/0hqFwrTKwoSHR2IpyEUC+XB4jN1m
         VayGGRtNkzZoGbiVr9OdAy9feoNXiuzWgq5MsW3whKUW5LNn50G7nNJuf9m1QoPEle67
         kGjJbJuBy9vmg6kDUYummVZW1ZVraQJ1uN648u8EnlIFPNRb+Gw8RJKZRFsGVxuPjDJ7
         wJ5DCFJ8zZVJH3p7jUgk8rKy+e8dYtYJfDNTK0mFNrQE7gydWR3kRjDd/X0QZPLE7FyD
         bkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957543; x=1720562343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc7kDWbr1ZOLQ8+EMlKcMIOk0gPIa550UiXaV/Fsdqw=;
        b=T9QGAos6apQ32KtFKHkLm4B4EkUFiTj2JbAPCrrh11ncGRYWPd7I5ISrNlKHDexhIN
         st56wEXfDjg5hBCuImZfZy8+8kT9HO/FmrTKjVWCeR8r2DRlxEvydG68Ix2TYMxBCCY/
         483VpAdIxo6ka8h/jA7dcezAKw+5QEvFNQ8OdXtIwe4lUFMU4iOwgzziirOR2/eCYrdr
         fjaAOYBRApyUK0x1OboYTplaNxYJQpDkgGeTdtuBYi4W+qhWjRBmtc/yP63YGvA39ujW
         RyuuN69EuUND64pM0atX9YrRJabLqLURGNf6eFJt7Oii4+Ya9RKX5Is5VJ29Wr0yHq3J
         72JA==
X-Gm-Message-State: AOJu0YxZYsAgFBTUFc+Cdru+KGp7VAWnV5MOi0W5a0b/nu4o6yUaap2h
	FovtGZmlsE5fV+qyYY2BuCpIgUZ6yEhfrv9XWhCmQ48c+ZTIcL+n
X-Google-Smtp-Source: AGHT+IFU7HE3OnORXf/jPfIvwK8ZL9okfkzaVw0Y9XlHErXhQ5Il5ia22RtTXqA/C72TmprohxCaoA==
X-Received: by 2002:a5e:a819:0:b0:7eb:c68b:8250 with SMTP id ca18e2360f4ac-7f62ee8d422mr1089812139f.18.1719957543284;
        Tue, 02 Jul 2024 14:59:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:02 -0700 (PDT)
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
Subject: [PATCH v9 37/53] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
Date: Tue,  2 Jul 2024 15:57:32 -0600
Message-ID: <20240702215804.2201271-43-jim.cromie@gmail.com>
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


