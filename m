Return-Path: <linux-kernel+bounces-570233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A988DA6AE03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BA4483992
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C45238D45;
	Thu, 20 Mar 2025 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjS388p3"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DC237193
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496834; cv=none; b=c2ZMd8M7RCUZ+wssYkpnKzkjCGG4imVB+Ve7kn00irgoF53RDVfo9f24NGgRKe69WX6jgit2GjndyFivnVLdox4iXMZ9/wwmgLYiSGcuwlGLUJxthxbiYr1AirFRwrwg0zJVXu3lDAXpUMU+yc1UEAc+mofcgVg8V/Y3QAdp0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496834; c=relaxed/simple;
	bh=g3lVXLb67RaSnFsR5clPnGA5HZIP+XFeHTcH+wOXkV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXUpSoKCxagIvG+XTIK2TZ+4MOvsym5qjqAL862VinrC88d5L8Dwv/Ps7ZJqDC+//rID0GW9mq8qCxX2HNlO/Tx2f5O1AmLvj2r/BDRn8LZwZuWQzDIt8fJxMGur2zM0G950iJ0f6PWY4+1HVV88IO7xYwACAP5NXGLS7GHW+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjS388p3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso41415939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496832; x=1743101632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YY4p1KIoF8NcF+Z/sMeox8vZB2Tw1a5BANUy2dvOpI=;
        b=VjS388p3BwcSSIM3egR0T9l1QxYvesA9Q5q9HaD1zNtzZa5dQlVeBCcYhFcu/5bRLj
         RFwJ84F8RWXnZInpPGWbaRWIEo/5gUhvcvCZgfPaTs4gKlN6f0XCgnHMxg54z1x0MW4L
         oNyf0foPfQF1bSE0g/zOZ7KGi5+7BnCo0bUE1nRMyDmpVieGBTLGCghJASTw0e+Sq3az
         x9B2P1t7sjLGwU2y5D816yUGBi0hAlv3kutPMTjcwhNBVhu3T7/vVesH3eJZOlqSNA7/
         rYfQEknTa7eFoChYDU8Q0Dv7+el7mjt5Pvo2SGCaf9TJsj9nVVU5z2IoSyMuON6XreOX
         1ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496832; x=1743101632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YY4p1KIoF8NcF+Z/sMeox8vZB2Tw1a5BANUy2dvOpI=;
        b=oI1X+zFDE40v057u3plcctYtWlLsswggw5ynmI69SbxXIHKcffPoDGQl5XXtwfb2cL
         BK5awNUpx4yJDK9AQ49o7gpLMxRkRfFogP0l9S7BhhyrnZgOFJg+yFhXziDMMDMdLQoi
         OTeKIgwfxe9itqt5zwlAOJfqFLoQaIbLe2jY6v77Z3uwwJzCn0YcKoh/DzaLx0VFnunB
         +o6N0isVvzPkBTioDvzVV2V2633/1XDk/ROm1XAWnSYN2/ag033x34CP2xrZPqNJriO+
         7xX7vP3LU+WIHi3/u1JoB7GNceA6r9Fv1Yd7h/JStk2veDpqciItPiZfUEylIPgFimAq
         JhVQ==
X-Gm-Message-State: AOJu0YwlYOHciPw6qxpvCydfwSqjp91hAqiLOqoHxHhO646rXehwU7Az
	KM5ouXUMwKa1wczXMl9HJUq17uhr2mxVfXrDD/gCd/9EzsV6SJam4RubX4SE
X-Gm-Gg: ASbGncv1EtKzVMtKAfARzftggyx3rCalha/nTCiSnIopPJL9PtFzjIHHwuhxC+YQGQZ
	rAZ5ZQ5I5SPzIPEE7GlhEOduUJ5eMk5e9HCX9iPnfsBIGQ3RwTAQN4Wh1cJ5SmL/5XyZXopH5ED
	2/3Hsre4p5mBD+V9zC7wQg6MxH/PwZlks6KM6a0QTLCE6TaXlbRPLHF4x6i/nUM665a4W2iWPdE
	SeqJGTXLgLEav25qJ7bZFkESm8yhr95ZNWVr5acRkqWQ5pvTCzT0Jb7jePiMshJXwr+JisKfu1D
	UepCf97wnOeg/2gwGYlUrQBc6lIZnKJLnLwoXOpreVew/o517C48WhgC84t4vPeHYIcl2Ydfhbp
	xJg==
X-Google-Smtp-Source: AGHT+IFRfc+XzhcXsN2Drd9zujyOgJy6REOdYhT/1Oijm2SQSUJCYNpgS+yjBgNdLmsoPBETLNSPbw==
X-Received: by 2002:a05:6602:3a13:b0:85b:4d78:cfe7 with SMTP id ca18e2360f4ac-85e2bec5c71mr92629139f.4.1742496831849;
        Thu, 20 Mar 2025 11:53:51 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 42/59] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Thu, 20 Mar 2025 12:52:20 -0600
Message-ID: <20250320185238.447458-43-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
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
index 61c7c2c588c6..68ba17eb2541 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -43,17 +43,7 @@
 
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
2.49.0


