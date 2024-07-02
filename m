Return-Path: <linux-kernel+bounces-238459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D649C924B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC33287B01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E601AEFFD;
	Tue,  2 Jul 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkPczX4f"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55D20FAA9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957541; cv=none; b=IxvsQ1m7621txp92ugHKq6xfKJ+oI8cXawGtECtU2778GBe8XtG99doW+R7210CY2f8iF3PHBQXuGm1hqHKxQ/yOX793KqWWkWa0wkzF/sdBo/JjWp/PMr/HlzbHzZyU2yF15A3OtGNKAUjIukYde+OQzA/890e1bJLbldSg7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957541; c=relaxed/simple;
	bh=gmzz9xKUKEU2FwGVjtUT8xi4cORsbLKLRijp90yxR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr9jtI76IfYh8VNhXjE7ky4uj2xDThscW1gkbMAJi5yg+r5Qt2aLIgyasYW7yrMr4QniEW7sPIqdYbhEn5I3jhZ5qml0mVVdO1P66CwnrRvyPTUDgguPYOtQxbICMt3O68d9GCP6noJfdSlEnY6tOCEtZV6jm/mSPcpIAHVHyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkPczX4f; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f3cc78afb6so165126239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957539; x=1720562339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SUm8Nyqte9xAsE2tQLuwSyCdCfAncJgW1l33uKzz4o=;
        b=jkPczX4fYwyJuR8Z1/C3i/T+vPLVBrKbXj+ncrNLksqCYjhzRww62H2YlQRHLvmTBN
         9BNUlPRa0Q23flr260ijxH7qrc0F200WFjV4a0gmcIq5xgZmAg5OlwKgM2m+wyCmaf08
         na/PPFvRp/2rRMkAI/D+wSWQ8yvQVLHkmLnWc0vbppTpOU4/+rKWazHq77C1OKnJNnjU
         EKO31gmJtLT8Lz4uud7/aJ44SDc0i9gpiSrnkBMOaVY0EuT1rdTcpAYPiK8UqBIDngMB
         xGXE59OsNUVwAnWlVOEl+BevvOgOgqadcPLA2RiDAf32ztXPCR7LkeinM4l0unBYddv/
         uiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957539; x=1720562339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SUm8Nyqte9xAsE2tQLuwSyCdCfAncJgW1l33uKzz4o=;
        b=vvuH7zvMVxVkMFIjdoMkv9a4WDYDEz6YSl0zNR6wLohM1x3di9bFZ/J6xKHzK5Muzg
         0XIK6NiUpw6aQwvAIbZxvUG7SHDz+h674Md5RWBE5gAjRarUJt82HN1LNoXrkpTpw3KU
         ub5fOnJgkRoXCMwkxVoBRZCRhqqQ/QK6N49ZIm1ImXOdK7MgKi4IDpVmlE8drqNutRdG
         G7Uvuoe2lZghhjgp71SQzf+SVlnDp7OMtSUzsnaExvxy7MaZkkG4ziJHl5b2wZmidRtu
         hWMYrlY83AuopTlREI9RpB7Y0Tf5FZiAwY4XEnMU1iixp8SFAgHdgA/g0M3cTJ/GuQKP
         QAWg==
X-Gm-Message-State: AOJu0YxJdWf1uxDtn5KgSp/kCJUuTS5pAdcV59G3SiWSGlqmmaOFaqis
	WivpQZrjpWVdSrCwbuCcYL8nn/fG/vj6qxPSx1X4du66PeXLRzLF
X-Google-Smtp-Source: AGHT+IEUnJOZJMWFZCPfI0cb1ttS0mdFvKdodraHs1JHxvSWaTiAIpWzxzSmb2Z5C00Z5H72ikNb1w==
X-Received: by 2002:a5e:d606:0:b0:7eb:d640:274 with SMTP id ca18e2360f4ac-7f62ee622b1mr1057821039f.10.1719957538981;
        Tue, 02 Jul 2024 14:58:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:58 -0700 (PDT)
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
Subject: [PATCH v9 35/53] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Tue,  2 Jul 2024 15:57:28 -0600
Message-ID: <20240702215804.2201271-39-jim.cromie@gmail.com>
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
 drivers/gpu/drm/drm_crtc_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 2dafc39a27cb..e9d229a393f4 100644
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


