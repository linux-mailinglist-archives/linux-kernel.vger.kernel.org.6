Return-Path: <linux-kernel+bounces-254290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922893317D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677D21C20D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A61AB52C;
	Tue, 16 Jul 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS/T4BaB"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F861AAE3B;
	Tue, 16 Jul 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156353; cv=none; b=XZzgGSFQvGbWqy2F4kUksHJNWhsHZ6ALtNOc2PHh1cdTTer0oULcn//+RCI3IW+4pmm2WC+KaY1Wk6FgSzkvPAJZwZEf7lK+GYXH4+yhGXPGxLR0K4MEuwpRoNjXh7KDD7EpjJs2ZN8ACqGqGYLXueZzpV9pNNkBgk16FGusNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156353; c=relaxed/simple;
	bh=HsVJ+8bSyTwxbd5PVHZFf8uV50bzhcBL2G646/K/2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yia3MVu4Sj/Z5H2JxHAzLxuY+CFim9zAhmu8Ct7krwe2sRMaU72waK13HyJIFz2JUSKdOrPR5watifhxliGc8MmmtnTfGqWn6l0zJlVz65WDpWtqG25CMGtmiXtskl1Pd6ipjEM7i5NJo7IxT5izKHd+d+Rqh/J3R8RnURIcLSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS/T4BaB; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8046f65536dso6078139f.1;
        Tue, 16 Jul 2024 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156351; x=1721761151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc7kDWbr1ZOLQ8+EMlKcMIOk0gPIa550UiXaV/Fsdqw=;
        b=CS/T4BaBvJZJOi3TWTCoFEwIqxYetz3ip+DkmTy4p7mYeXSM2k0Qe+ggUNKgfjay0j
         PKt7NwkKRSuKCPnV3U978J5YHWMYuzmxmekCtyTXnRJe3qhv0ckvVyRtbL0WBLKHkjzg
         0V5pkZX4SjyLtCv0BmJaqkMOW+ksRh+CoG4fAzW7Y4UXB2us4sG6U1Spqr8Dyt8oLO7r
         MLmKnC1mmTLCqNlPQi6EKoKotMq+3Apqc1NESDyXnx27m4LGCc+dlbUkOpj2imV+48Pd
         yetxDlS/AB4bfQ6T5byI6GcBTxU2MTfJLcvRgBpVzYqNncMgweCxthqO+DHNkIVGwcN1
         zHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156351; x=1721761151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc7kDWbr1ZOLQ8+EMlKcMIOk0gPIa550UiXaV/Fsdqw=;
        b=kPqc4n+sF5TOIEqTbYqxQoYeAfkfwAySV1JSMska/5tdrGljwHIin7w8DuwrD89LFx
         Ofb9sJbW4UJojowko7oskVlNomzPjgqX9StonvFPfOQBN9kN7vs8uJ4BbDOpca5yNHdQ
         9/25lyKm/MvLI/U+z2w/xVwWqFmZd55fBcEd1VC61Hku0lrXTctso+Mla/tSU5Y7jIJn
         /zMwC2h3XTddXl8/Ya8G/GbVDg6Xx0VrhO3Vcnn8+igDLEqA6+IlgPPaF9wHXsNmgCWY
         MOYs1yheiLNxzcugXZW9P7Eop/KPozTPm01HcnUoFu2mIdJATeYf6mfFI5FG3w/0p5CN
         zh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvN4/YGLi5y6tGpqxnxCT++xGyy9mWv4tz7eLB1NyvCjjAjUO9V0J4nKj6ygvdtaS8UCKyAFhuICbPnvsZHQ6SrXl4wnXKEhmn
X-Gm-Message-State: AOJu0YzwqL7Zp+QGlVvVz7pvtJTrMIyLN4r8rFJ12S4mHjHMNsZj3cVb
	IlskWNeypBkI6aJRna4vXfS1ZXusfj+Lp4z9TNV5V1sfN0oelVwDA8quTwtw
X-Google-Smtp-Source: AGHT+IHniHFngXKTceOiLqztTPmU7D7E7YPzARR6ATJ7IKtQAVjxB0kHb2reQWR1pBYIGtzlOj9sIw==
X-Received: by 2002:a5d:9f52:0:b0:7f6:565d:9046 with SMTP id ca18e2360f4ac-816c52c12c9mr28199839f.19.1721156351398;
        Tue, 16 Jul 2024 11:59:11 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 36/54] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
Date: Tue, 16 Jul 2024 12:57:48 -0600
Message-ID: <20240716185806.1572048-37-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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


