Return-Path: <linux-kernel+bounces-254287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9C933177
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD671C22BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971431AAE18;
	Tue, 16 Jul 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmC5D32O"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8E1AA355;
	Tue, 16 Jul 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156349; cv=none; b=nKdG7HDDVWHxvacn/C6/s3BBsaYlVSOayVUuKjRIcHixNQV2mlHMD98wydKNbXG/0LdLM3ieUbcN3AkB2oBzNUPKHdW5l+pE/CrB3FpSMOG55cn9J5yHba8fxnpwS2rTq4tpkLzZ+qPWIwDfA2v/lzMCY7O9/ro+OmWuheHr7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156349; c=relaxed/simple;
	bh=hp2dvFGE74xKiGr3DsmKyZBastfXAUcYKeMcCwG8BhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXhuyiaeNwQ0zZ9RPIUwTHuGOecwGSG2n6AfQCIah0Sm4j0N7tw9HV754JjnUhxW9htrVpkEbeBOBvz6kdj+JqT0SD9qkVk935sNs922FVdAo25/t9TnEMsJDQxjEuHz6OpDrc2vyTpyQRDpHo4s6M/6wjDPAJh55xAc7+eii2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmC5D32O; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-383dfcd8cdfso576645ab.1;
        Tue, 16 Jul 2024 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156347; x=1721761147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+5ldzNpNWEVuNo6jiIyzFS2EBImxXk+RE6JhqbDago=;
        b=LmC5D32OUIiHcz3JfN2cjFYn5rZk1FX8t3EXAebSANX1OsV6IHuuikK7QH/y7TzI0+
         4sjELZZYZkq3KsSIkQOwIS0ATCYPAsbZ2cE98ffGW5Xo1OMBg+sSTAchJKEyne27h+vh
         ICbD6ZbU/5M97yq6Uj4qZz1uf8zAEfWaVjJy4xogrEKz8XQSb9j991CPhGonRKIi0b2j
         wErEGuSc0EgYKFmnKuJHY7gUY+l6vrfK1apU2JrzJ5CvRs3D+mBQY+idDJIrrqGuWfW5
         henu13/Eur+nKFyHh2Wj37ItychIzy2xXXkm8Ccq6KaEFiZdbgGrE6AyB/Cp3AYOcK8U
         ZzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156347; x=1721761147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+5ldzNpNWEVuNo6jiIyzFS2EBImxXk+RE6JhqbDago=;
        b=e5QJN91LwqKkeOPkBDP47MOTZd1ZB2aNaZd66aTL45/8sEZewLfeLQEHOKimYQGhdF
         92md4PKcHfTO71WsiCGucdLato2OQp6uYmJ9JiN7tebu8ptmpadUFyH4+G3sj9UnJKY6
         oXhK3banIsSmF0THcFyntI6kjb1lPHb2PLLp839aJ/gE8r+sVSoVPj980UW9TB78Aek7
         0UwfiEu0IIvoNEzmGyZ/H9zSqNBic8Fh0Y0n1oyRFI2ogO7MIxLGjjQXFzMAqVjdyLRP
         FCNy/ueeswI5VX0QVLqFerPT6w47Ky9cXEz/OzXwHBPKpM7K3dJccF0wkk4AL+LfOWeW
         kh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUWP3cUInFXtr3jRrBxTF7PLLkM5QzL5j0jvAbRluUZ44oPxyPrt7oeQljFANtuvN/byO/TvMgmnSLYmrGw0/NFjCXu4CBJplm
X-Gm-Message-State: AOJu0Yy+O7b/b9FTfODMgB+hS+coKL7jwQZzriQBnFx31FXqPfQcOrf9
	TlS1qFsLPPralRSHbNKqKpt+jbU5yKV2Qxb08pYC30W2biXdmf6qKZnL95VP
X-Google-Smtp-Source: AGHT+IFVgXPtcAVN/LY3hiWBdgpsl/UgaLXlcklh8fq4iOux4ImC/Nd3IFqSrYYu5bPD2ZMJxqpWYw==
X-Received: by 2002:a05:6602:601b:b0:80b:8cb:e9a2 with SMTP id ca18e2360f4ac-816c39b5f53mr48171639f.9.1721156347462;
        Tue, 16 Jul 2024 11:59:07 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:07 -0700 (PDT)
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
Subject: [PATCH v9-resend 33/54] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Tue, 16 Jul 2024 12:57:45 -0600
Message-ID: <20240716185806.1572048-34-jim.cromie@gmail.com>
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
 drivers/gpu/drm/i915/i915_params.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 8c00169e3ab7..a8f51f138895 100644
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


