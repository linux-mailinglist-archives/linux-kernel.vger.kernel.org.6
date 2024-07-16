Return-Path: <linux-kernel+bounces-254288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE5933179
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7A428217A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559981AA346;
	Tue, 16 Jul 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IROmWSRJ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C261AAE0E;
	Tue, 16 Jul 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156351; cv=none; b=qjoJa+WEbUZ3hA5RzKOj4WnOAbNMInMeI33wW8EGjGePmAhqjexGvIQMSg00gexCv3kCzEJVrMpGt1HakJE/Y+TBW5fj5X9K36gC8U3SyPiNetRtCcCL9VrEUQa/w0/Xe+dPREkEVtZJs0T+00Oy1B2V9Y+wCl+aQ5qb2TPRTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156351; c=relaxed/simple;
	bh=lnEKbpx31gnha3NjGpIlzNeFmEq5vg/O7ge86dQKUe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ1gdVneOFrFCyfZtQYdNLGthp1uchUrzfQsFJbtf5aoxswtzrmt/fsfuhvSK04PaL7X4S0eq7FpSPdgRoY203gn6tq9kZNh5gH2j8YGGAIPvtjazVW/Mue/OGpURfJMfXveG3wHUW3b7hIKvsGgKyGJjiGgUijAebPRSUl/neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IROmWSRJ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7fe8d029fbeso5430739f.3;
        Tue, 16 Jul 2024 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156349; x=1721761149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4fvGJdIiqN/FgQMIjeZ3X03BzfZdJ4Rgy3d37CjnOY=;
        b=IROmWSRJRxxDSmRHUp2N4yb+gPAI4GkJv2WmdpiIyLWQM/553I6iLBVPMH8tSU9eCS
         +9p8OvdpwUccEUtXc0YpU7wN4v/VwIWOko+57GPxeIvyQ59IZba+skZf5vffMRi5uozz
         W0W6ZeLr6cxC+f8jU11St5UQG+LwrcZ9mBRGfY4LeiOxAgGwymMwp5QBlCDm4bvwRipG
         je2+n304JymEDCiVIl8XURzB236MnaeWiMvtCPu+6aFLC1Ult3Eu0ozlTKNqlEa9dhv2
         B8sbjkgP755B0kbKLT9q+RKhiKsNrB8Nwq66zJslMryC+uuYnzOIT0i43hsw8gCe+JGJ
         9nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156349; x=1721761149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4fvGJdIiqN/FgQMIjeZ3X03BzfZdJ4Rgy3d37CjnOY=;
        b=bqcXhXMrYsm4jlELOncFEn2pxOqcqrjWoU4CvmYbTU4um7nkEcdGaRkOAgxDMx+oXr
         V10CtuXLBXcqMD10KCmC3rmEDfR8048vc/s4Dbjum5nI8r7ked9sYdE0YF84gwtBYf87
         lEPCwyO0eYmtFaqMox0hZtzEXi2WUg+DKXZY11ts7Rf7RqgcI8Hbz+rTRf9oQQ775pJR
         8pR6bqW2iYcJsIvkU600FzSOZm3gQDmVD/PXj1cyiSImjvGV7H68cYGn0OvT4NVjoqYd
         SGDvYVL6lcESAq6U7BcCC5EkGxv286xX8Cq8vA+oyeG+CutNOitBqvV0DIe+WvpM+qAY
         L6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcQrt0kihjEpZQVqXjtEZammVFM3mH+4JdSP92Jz4r3lKiG4MpqaMnVZCsm3Pgxf+sUJJphpoovaWmTbp5KvE+Sy50SWRtv+2n
X-Gm-Message-State: AOJu0Yz5eZCOjfvxwqVbl+7u9kpV0UEu8lpi3lQ8dyibWlQCBLFu3kYL
	s51YrTANbRBmud9X+nQKfkdye90WzEvhrHPhrRr5dKF6HZAjCBHKzhV3POB2
X-Google-Smtp-Source: AGHT+IEoPFvoLU8se7cKFs7615nIvxsDK/GhCsg3TpkmqEyVLb7MNLpf5NEeCEideKkhW1/TmoHWuw==
X-Received: by 2002:a05:6602:154c:b0:7fa:2902:aec5 with SMTP id ca18e2360f4ac-816c578db22mr35533339f.17.1721156348981;
        Tue, 16 Jul 2024 11:59:08 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:08 -0700 (PDT)
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
Subject: [PATCH v9-resend 34/54] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Tue, 16 Jul 2024 12:57:46 -0600
Message-ID: <20240716185806.1572048-35-jim.cromie@gmail.com>
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
2.45.2


