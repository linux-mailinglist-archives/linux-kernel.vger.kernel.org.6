Return-Path: <linux-kernel+bounces-254289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131993317B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB33283BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742F1AB510;
	Tue, 16 Jul 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKLJmsaJ"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4F1AAE23;
	Tue, 16 Jul 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156352; cv=none; b=moQ14r4qG8bK7FbyZ+AVDU9gkmfeQ5lFXVpEWEoqwQXSwa9j4OcZzdVbnyzm6DX5nVgY727cOkqPp2XfPA56brgxBkGVJnDDj6kai1OXDKKFU3+fgRM2NlOTk4EKO5VGFmS4JwtW0SYT/viTsvY9j7cCw3zwIIYy8ENsD8YBue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156352; c=relaxed/simple;
	bh=ZtjiOxyDx5G+NF0MTgM592M7DAgCamR0xuhg7eXNnRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8rVvc9zj6Gm2fikSvNH9WuzUuNzHBkZFWPHNgvFvK+ZLz5YCfasbjmUzEAMJLLqxWHWbEk4YH+SrygMCcoBil0OD1bbw7f6VemAFM44ZARmIDM1S0LZ77V/zF/peJivnfPl+2jhAZq6Q7YU5uxOSoG0bxtlKP72EnsBzkiChkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKLJmsaJ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3833cd120e5so184885ab.1;
        Tue, 16 Jul 2024 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156350; x=1721761150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzkSEhdc6qQPvOwslzLZ6D0OWHzi5mSETKdlQKCmmYw=;
        b=AKLJmsaJ6WSRRwUfLzKnUGcj1K2aDkPuZ7mY6u4BrVhIHbURUeh6wPBWrg7MMzonWc
         9RTPkDrBrqKyjil7DUs8kU+CRGR78VrVlzmjO4faGhVpwInMf9wSSpkjEEK0UY5UXcxa
         azgy97OEa9fGuFPrW9TS0PnUGnEC6uir3y8N1CUTsfO8Qmn4X16jGOAFcr/F/vtQmMnm
         yiJfLxwn5N3DiJ1oLKTjNQlXDsuXp2F7qpbpIiESK+H1bGlK606iGSMf4jM+oqVfILSV
         9JqrNYleD7Qz0IhjRGiXd1tuAl/Xx37OSoScU88ICK+m8jK+NsIIPspcpPqeKt/jqkbD
         CgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156350; x=1721761150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzkSEhdc6qQPvOwslzLZ6D0OWHzi5mSETKdlQKCmmYw=;
        b=g2UF5Ba0hk6zt4Gw1sMrH9yTUlnWya2F2zLHmCgyJRe5clDazRsMOsUW/9wmdK2ucy
         85rASAYTaBy/LSvQaE4NvwLHKBsEDrX3WHIqJm9MAywrmlLkgo2NnW0EOF5wwumVShWI
         xs754MOm2HSesf1wS1210DNNME8VuHg1gvzQm5IocFn9z9BBWlvo9QbvDU7y5zz69vG5
         wElSV5lx1kZKILhJmezmY9UVW7RkZBQyQ5MRN/R9sDPD/2cTtO4DAotc1tyUdOfAxKfX
         LxGK+y4K9TYBdAqxKcl2ujXJ1Y0ZCUZNGhyHT8K35bp4BLVIj5kVGzMew5pJC1/jj7YP
         ZhJg==
X-Forwarded-Encrypted: i=1; AJvYcCVbhXoE4wmO4eN48tO5YeeTHRqXnjJZOwWUjYojCzhYVS78iCHtsHdO5mDkB2aCLVKb6nrjUAJDLEEBb2B0X2dTgL6+J0jHbZ6f
X-Gm-Message-State: AOJu0YyS+92oJwCIfkwhgVveKLw3H5ZKuCSjPJRmFaJtMnSMYgEdnBaS
	C2xPuqW5zlwPT+VidWog1qC3v4WL7yXoXzHOQHQQqmN1eSiGIwbGNF/JrYju
X-Google-Smtp-Source: AGHT+IEKdNdnUCPqRDB/cRLNi7N28OEYYkl4r/3na57zdfEFy5knZy9YrMuwF5a4lw45gKdShvcnlw==
X-Received: by 2002:a05:6e02:1a42:b0:38b:3985:433e with SMTP id e9e14a558f8ab-3950de3a6e2mr1987225ab.7.1721156350166;
        Tue, 16 Jul 2024 11:59:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:09 -0700 (PDT)
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
Subject: [PATCH v9-resend 35/54] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Tue, 16 Jul 2024 12:57:47 -0600
Message-ID: <20240716185806.1572048-36-jim.cromie@gmail.com>
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
 drivers/gpu/drm/display/drm_dp_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 79a615667aab..26e01845531e 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -41,17 +41,7 @@
 
 #include "drm_dp_helper_internal.h"
 
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
 
 struct dp_aux_backlight {
 	struct backlight_device *base;
-- 
2.45.2


