Return-Path: <linux-kernel+bounces-238455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A433D924B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EF7288A69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A81ABC2E;
	Tue,  2 Jul 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1+zKXV4"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBD1A8B1A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957536; cv=none; b=Sg15EruLHkS/CSsYulxbQCLwm52fzf4bCWu1CIAZmAU2fOCicNMbklpUd3o1glzc1ktUCBV/OtnTF98MYC22uf2AoziflbolrlsRN6bQMuPZzUzDsSEUal2mn3lpaDaNWF9SWuPcC/64rkulgEKq/rQOHSwrzda1aOXpdaPtQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957536; c=relaxed/simple;
	bh=ZaC1vkdGQIEO4AVm55hDQCbxRTzLsnX/1CWODuwSgZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7IcT7tFBOZ2Bk3SvATFyVBOmdXI+uWqKV2lywNQFiAKOimg9EC+7D1irJfKa3bL4TJn5Nn2V54lZb41/N4bZReEGRDYlhTHknq43u9sEjaSomILrS1q0EF/YilZbIeOvWSNkjJrzVUfi4IkTxr6l8KT80qy+RpXNizWFXM+F3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1+zKXV4; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f620f349f9so193146839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957535; x=1720562335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK1rhky1L0Uh2dLu61vy8boLc9OqspSM7tQ5uDrS370=;
        b=K1+zKXV4cw2bANyNv4ltL20EEtXjjxF7Fupoy6RgpuPOnd2NwcZQSQQJmFzkTnvKYf
         CVO9yvWIihqjPsQJ1yQmKG72jKx8VBwWufX3s90ENdj2Pt6eoF9O3+o/fj2YUTZIXUAN
         ZiBkEcpgOK2PDDj7zDvvf1WXZHWgvgZO+EV3HbPf+kw9D3ayi298QNisTQqLPpxDAkVb
         sWs6SFKf8ViJXJpx0SiWn2aRKhxwnGRmklXpvDlAGaTOEI4tIOa1FiRwsQYwJYqAAP2Y
         UpEvsKg25n3DLsKyiPZtBYVjDCreK9lTyZWbSQ9VWCo6C4za1xBuscCAJ0z33s7iN15W
         uyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957535; x=1720562335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK1rhky1L0Uh2dLu61vy8boLc9OqspSM7tQ5uDrS370=;
        b=BlElIWwqa6A0nHekxX9wiODDro3mTKy1va0RmIDTFxwFs/aNglZOa7ZUMug77qHtqt
         NIqj+1YUqruL8mrQzLxGnBFSSaiF7ylwh45S9w8gWOPUf7ZXN6cNxpgq4c2B/yTIhj0b
         mMmqt/6Y04t9eBAmy+e7P/2AX2CnMxCe0edssLMPBR2p3Dkr447Ec+ec+bVuN8OzA4qi
         VahZLZaAFqxzt3ZSltOIMBxrqTc4aH31NhpI6JsTEv5/RhQUD/raee1GxsY1tmBu/I2N
         7mF+9sROl9IuYBa49kdzabtHzHaepT+hCtj8bfV3fHdbcTrzBTY3M4aEZzzOsMfajNEl
         CaPQ==
X-Gm-Message-State: AOJu0YwaMbBrXp4G0lUzAwfC/V++i3cz7q6vjC4LNkfq3zmvHd8MKiSl
	FtFW/109K6Z8XV1jbAu5nmI6fPCP4CcPQUu7MYGZyioAhzlSWMwt
X-Google-Smtp-Source: AGHT+IHLc/l4rSLolOTsFYm7TsKqkhWE4Jfzo0NU47TaXhV5RuwQAoXmcV+1NSMfPYNESCW3q8/CLQ==
X-Received: by 2002:a6b:6106:0:b0:7f6:2e72:e81b with SMTP id ca18e2360f4ac-7f62ee168f6mr1110047139f.4.1719957534832;
        Tue, 02 Jul 2024 14:58:54 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:54 -0700 (PDT)
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
Subject: [PATCH v9 33/53] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Tue,  2 Jul 2024 15:57:24 -0600
Message-ID: <20240702215804.2201271-35-jim.cromie@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e4277298cf1a..b287f0cfd8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -217,17 +217,7 @@ int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
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
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-- 
2.45.2


