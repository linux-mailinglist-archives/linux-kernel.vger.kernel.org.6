Return-Path: <linux-kernel+bounces-238460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B1924B21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA381F28CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C391B11F8;
	Tue,  2 Jul 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQzKzlPa"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6C1AEFE2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957542; cv=none; b=YMA21TksdyxFe+2W0vfC+nWpCmSFXWyXIPFw/oz3erQ2sOCP3vdXqGq2VwQbbEPbtRWyYoXs7/FS7c4DuhsbocDU+5BFIbgGn+OHKl/CShC/mnmMZtuyGEfp3oMr8yuZpMQcwJ9tIYnohkk4Cd9kX9/lV6BRKKaxsY2MDwFEshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957542; c=relaxed/simple;
	bh=WgSQyM39ri+VuoXguHdRb8eTg/UreiPzGYK2gYDMxNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1r5N2c3vvLlMO505S1P7LHo65vWCRsvi2VqA+zz04q7qq+oQEbTtUDoUYK89OQ2U4yTLGxb3mCWkddZ6cTSwXQZLFDoRxVpGL6PplrWWRgGIlaqZQ4f0wgRcLiNqYSGAKgRRgEMAbQoTek5syxYK8MTie2ixB5JH/cACz5ZsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQzKzlPa; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f65715fe2cso34953739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957540; x=1720562340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axn4TdT8TpzxyaaFFwTK+y02x0fRA+xhIqgCPO86CS8=;
        b=eQzKzlPa8oImICgJ8Dx6fek7hF/kMGAmSACF2YTGuFeSLJkf2uMGjtFHFZxRCO79L0
         0kJ5Qi2+8QPdBQ6jTS4yzgHZhCSSVgrXsxmFIXy2J4BIttNtqDw0q5AGcoMPxtGhfH4z
         /D4UzfYoRDLT+UGv0lZPzL0EXDSlM1U9BFSPQ3XGIOyzaYCfOEZL7ocznjvGo6uBEFO+
         Z+6MdMv5YD6E05v36Vv9Ph5LZ96bTvgMf2bMIKolHDPuoMUJdpFr2b/Ntr/HUFMMv4rs
         aYycGHosUGY6od8aCelYbnNDDXdeQhALXHCSsBBRUUhyFxmpQUtIoXAZNhF6gVCc0Oyb
         3Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957540; x=1720562340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Axn4TdT8TpzxyaaFFwTK+y02x0fRA+xhIqgCPO86CS8=;
        b=SfBYQA1d4PfdM7Gz3Omy5QBxj6R40OPcOlLrPxvZU0njdfiDXeRILrZ5NvKEM2/uxq
         DlWxKYf2WXIAdsjfdk7d/bqUZN54o0uKwNGKDoorMjpyUygDYb9b6orwtW/XuljECclo
         1cVof9TbDT9uq1wZMMVlUhp7GNnZBcTsjU7do0ReVmJUqMGgClS7aUA1mlXYZGgd6L/e
         JEUUCVK5x7Vf579ezg0UW4PxKXlKkT4Zn27zu/pI2t6t0is32y6yhRFctbgxYhQKz2bb
         aHOZ94GUs6zCjl1w31OrcJOw+WNySmCNMEToD8WjQhFFuwEWXSr+svChzAN3KwkJKQof
         TrHQ==
X-Gm-Message-State: AOJu0YypU/0WmiXfle3fFRSL2VWEx5A1L1LiZsxJvi08laF5LHL6meeT
	ROUVdtLXDG+/KYjjkTR5Iao+HGvSFFX1f0mv888lb/TSorgGoygH
X-Google-Smtp-Source: AGHT+IHaOAftkhtE+ssHNVJW7rv5RWXdozZEgyV+TC4e5xBaWpxyJ+CZnnidhCATtDhgoR7BAYqalA==
X-Received: by 2002:a6b:d117:0:b0:7ea:fc3a:fff6 with SMTP id ca18e2360f4ac-7f62ee1da28mr1167201539f.6.1719957540118;
        Tue, 02 Jul 2024 14:59:00 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:59 -0700 (PDT)
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
Subject: [PATCH v9 35/52] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Tue,  2 Jul 2024 15:57:29 -0600
Message-ID: <20240702215804.2201271-40-jim.cromie@gmail.com>
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
 drivers/gpu/drm/display/drm_dp_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index f5d4be897866..d3a7df09846f 100644
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


