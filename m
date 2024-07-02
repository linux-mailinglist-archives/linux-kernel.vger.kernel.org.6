Return-Path: <linux-kernel+bounces-238456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB0924B1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0715D2868D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CB1ABC4D;
	Tue,  2 Jul 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li2ZY6JM"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EF1A8B38
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957537; cv=none; b=KHuthtDEVxG+bH4SJOz7Aft4L/1GNpoGHV1nA/88gEhM0xMMwyUpTSifOix4Guq4Bgaus4/+ixBIUJQcEUrU9q8+Jskkz1xK8dPdzyvRp4gXmBkQRy8TicZUAyIZywbpCDH675GZNMQ+EihXJwt1ljfwz11Z5qPE8lLSer7MBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957537; c=relaxed/simple;
	bh=BmoS/pi4WE3RilgtxDmWX/Z/qwCySxzocceyZaJhNAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEkHkE8Utr9ETHCaCTIdAiCj0WEAyrykDfBnXAOYkNVNCFZWDX/udK1rX+YTvRPFpISDmhUhZAR4lVZ/Eo6Z/Rd96HlaXZQWbUw8IsBOLC4MFZjiYfgokpbt5ud32Dv02fIyFFlygJeD7y+f55kdZpQPC/4lZ2hDet8AxSLDB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li2ZY6JM; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f61e75642cso212356839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957536; x=1720562336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94MIkUtYPNbEjf2ABNxMIbyceZTrdE5XkTP/b1VTHKc=;
        b=Li2ZY6JM3ytLILLFZycibU+iBmcnAs6x8gc7RXXMqccsZUZZ4Xpcq7utOnh/xYzOmG
         d+NUTqB7APPkk8AvHMmoXpmNNlREbV/Uv+cVPpz0AJ/Z/NjNGL7k8gm88MiJ1eCpm4cc
         S/eiwTAAsgO9BeSxInEHSiSNFRzKkLm6hspFihEmPxEpHLaDrBbGy9zk+imqONdicnp7
         +AaTgitjO5ACAkJdLmj7oUU2mnTlAFAWnvmCgKzYdg5VaL7Amyz5qaRRWEK2Hl7wf3gJ
         kI5eajD6I7vMAsqnK7I7OYaOW24ngN0SWz6z6owiYbiCpaRhU+CwZZ9BxwHM6Pm087ng
         RbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957536; x=1720562336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94MIkUtYPNbEjf2ABNxMIbyceZTrdE5XkTP/b1VTHKc=;
        b=kenGL1rNmoNwq7cji+TLQnGHi918axiSYsuAyYQmDTXjx1v79kJv3dLoUINJvQCFXp
         iXmTpFMwnKtfTA8YcKcnXU43MzK8E60sYsyDzQnz/zitYQewu93INR749veAOniRbTFf
         aUWn4PnNbodfIkKwhQy9Pwi6bbZCNdvQ63ysr9KqMzsZz6PWF6T/3TXU/UNP79ogA7DW
         ld6/UrYUamsbii0Qwii8c4TfZ3YYn2oEFjuCuXhvGG+Y7X5Dspq+PziHSopIYD3Kza2s
         w/GrofWK9ljObb6Kcl1ZsSyQNKwJx2S8nmKgmma5HDq8a6aITivO5i80kNCwJgm55dzA
         aLfw==
X-Gm-Message-State: AOJu0Yz+WLXCyB9sEa2zSIV3o3QIzzXJKgAmnSg+WGHBBsbLgBtD7rA7
	QK+SW6Fo3kv836TxLeDdbktuPKLGCdt6RLvj6NnI0hkWCKvuSHil
X-Google-Smtp-Source: AGHT+IHWBl0Ygyolnpn0Hok9dt+fa5+/pnDWaVB438H2fcp/zc4YMHsu9praTrPy+xMKUV2fg9LvpA==
X-Received: by 2002:a6b:5b09:0:b0:7eb:b592:6add with SMTP id ca18e2360f4ac-7f62eeb026dmr1066340839f.20.1719957535801;
        Tue, 02 Jul 2024 14:58:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:55 -0700 (PDT)
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
Subject: [PATCH v9 33/52] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Tue,  2 Jul 2024 15:57:25 -0600
Message-ID: <20240702215804.2201271-36-jim.cromie@gmail.com>
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


