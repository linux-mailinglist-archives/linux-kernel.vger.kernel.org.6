Return-Path: <linux-kernel+bounces-238458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E3924B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5DD287A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05FA1AEFDD;
	Tue,  2 Jul 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG4j0ldx"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48D1ABC4C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957540; cv=none; b=Qfyj2sRtFOL6fOmW2lHx+smjxJTtHVDP4kC/mYqAXowCIjhv9cuZ9/3LtGSlczdyISNUsjkj8ISmn5UVNzGOIR3pIWUutHKAGIfwYip2HcL1nIETCfhoc444XqTsphSwAGLY86pl3B7nWXNZ6HftH2Fnjc28LFp6cIy5dMu8e6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957540; c=relaxed/simple;
	bh=BmoS/pi4WE3RilgtxDmWX/Z/qwCySxzocceyZaJhNAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBLeWNzZtw5IKXIug7mi8fEbVJmsgu73zIjZag7A3jLlpzzlNOu8UV8kGZtadpqKt0oBCbEI45v+El82Lh5g9OEbd8kVyNQ6QFg2Ppvm5Y3dAsdZL5JrF4BcfIGCllTdfPXkw9uBEZwKYjpKctY4NvP4aJZcbvOATIdh5kCQ0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG4j0ldx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f64f66fdd7so60623139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957538; x=1720562338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94MIkUtYPNbEjf2ABNxMIbyceZTrdE5XkTP/b1VTHKc=;
        b=kG4j0ldxkZpfNsdamHeNpHlyzessz4115+aDbzJaBfmQQKf57CUWeq4YPgMRppD6KK
         mqKJor56qZsZ6nTn7KZBaJA9jIE7y/xmzp0luc9e3DjIPU8MtDluwxOOBApsrFW/B8Rk
         caBIdFUOq2PiXFWqcJwIScroO+ajxlYeABk03U3saQlZtt8GZiJb7oTwcZKqLSvISpnR
         z2EPLsL3f1mtlXRs+OTplaHDfrUgm4RodW31TdXnrs04yzViJSdgzUL9fUDmNT61LqQT
         L9375au7MNLafdfFH8bPWrru1S3i7sBx1UpdtA5vvDnk0UiheNLlir+EiR9CKCZiO9tj
         Wv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957538; x=1720562338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94MIkUtYPNbEjf2ABNxMIbyceZTrdE5XkTP/b1VTHKc=;
        b=gbz1QUfIYXyaJnOts0YUg67aLaF7QwjUL4ZJJPpGWtg35JKFbKtHZiJrFHRH9VA/Gg
         WAsx6H7rrsJk53fOMX/ww81MkfOWxtJa1ARWc5Pc9xVhP8dI6emhXSed0fWYG88Q3stc
         qiUXqePeurGShbqTYxVHv5Ci1oEHHA/4wOvlZU23CYWPf9ISpmI6cl40C7DguGqbSjNi
         5gaXGreRAlmkHvjPQPhNq2Q2ZafeAwuVRVqJCEvNWACf7/jBbajSb0Y91vG5RAehVqrv
         WqpD2K9TgVLxS3u6Baxv3fMfKHgKlnfpuMn4DDHEBOTDR1azgkoCwlLwQeaU6TliKCNW
         wZbQ==
X-Gm-Message-State: AOJu0YzqtHSGm0JPtufSPWbaJebTgswdbqRWp7yb0XySKxzCyTFECEWE
	0iDIz9Pj7wsrWQF9Jl4tMPR0g9tAbo8hIBPK0dHxcvyE9BzME8/B
X-Google-Smtp-Source: AGHT+IEeyfoDsrnF6r4ABpMFuIX2eN+Lbm0YqA2PfdZDRQYY0jl8O9vciO2Q9HKa3iN91XoM/brm0g==
X-Received: by 2002:a05:6602:600d:b0:7f6:5035:1826 with SMTP id ca18e2360f4ac-7f650351c42mr444802439f.11.1719957538015;
        Tue, 02 Jul 2024 14:58:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:57 -0700 (PDT)
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
Subject: [PATCH v9 34/53] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Tue,  2 Jul 2024 15:57:27 -0600
Message-ID: <20240702215804.2201271-38-jim.cromie@gmail.com>
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
 drivers/gpu/drm/i915/i915_params.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index de43048543e8..dccf12d05105 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,17 +29,7 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
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
 
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
-- 
2.45.2


