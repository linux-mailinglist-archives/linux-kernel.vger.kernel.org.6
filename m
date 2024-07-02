Return-Path: <linux-kernel+bounces-238462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0C8924B24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6BD1C21F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E51B121D;
	Tue,  2 Jul 2024 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEGt/5Ei"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037F1AEFF8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957543; cv=none; b=Kyhm9pUFqJTkPIxMwP1dmaJFwKM5S0uLyjfcQBl8DRzhSVl4vZfFMSVjhvwjk/JNKvK8RIONLU5ktWVn95TPyZrb+GDyG8DdaB1xbMxcJfmRBgmD7QUgWMQtYIrvNJX6oIlS4Un9U1Z5SvRIPa9ULy6dpJ03Vlc+h2I+xiB3t98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957543; c=relaxed/simple;
	bh=WgSQyM39ri+VuoXguHdRb8eTg/UreiPzGYK2gYDMxNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQtYQL13EOzPyehX1AsHsMdn5LzCBjogJtJgLfk/fv7Ha8rKImfTzlP2J8NIPLEKc7RSfAw3LHzNpwXzFA+9mx5OHHQdbWpYwXht/VHH/V7AhfguoIegB+lMnOlpCG8q+hR+Jfn3URTb104xP5L7p94l5P9aVyJv6tdvA1OZxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEGt/5Ei; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7eeea388a8eso185103139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957541; x=1720562341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axn4TdT8TpzxyaaFFwTK+y02x0fRA+xhIqgCPO86CS8=;
        b=hEGt/5EigLNhoix7iqlK7Hb5+2b340mjXMZJrdo3YtXAFJe9owIdNWjJH3+qvDHDQY
         COOfH9YHQkQI2Ks/p0LEpABBKtu+45VpDK4j5IKEMBvAfKnfFEjJ3Dvmo/8g8tCmgQyD
         rjyaMxXNNBJh+TuMcVmR8lnjXZkRIgQdJ9A8vhX0LLOXNvbGKY2aF5y+AOxg6YZsBah/
         KCyOBXMD9dwoylM/VL5z0+vhourh9X/rFwBkXTXj48ccGTFyHf3DYgJ4Kt4XeTEhX9SG
         UYdHdYXRXu50scIegn9TcyhNEX4xeSX0v1ty+mJMihw0BEFbl6VPTS995hOBJtO1B+Hg
         ttig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957541; x=1720562341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Axn4TdT8TpzxyaaFFwTK+y02x0fRA+xhIqgCPO86CS8=;
        b=fjYXr11+16DcNoLarcbEM1l3AgJD9XV5vuEkO3tnXw8Tl6XLZYR/uvpsVPwzCvktYi
         tVOimYdx1wnxoGaItfU6XTjlxedJHOrPfgKMMiPyhVmaxlT51wbYV1RDzszroVhfvKRb
         GF9oX+3+9aNHM+vK3bxDexHJmapb+ifcKQ99e4V9x6Ce7kMKe0kmgjqTc0AE85Fl8C36
         LWdIIkQDQgqXBnImCJaDM4dGCdkJ1f9KVur/w3Dlpc8ZwVrC3GY7lFjgv6jqZmzxXk8v
         FkTvcJGhFgKDAbGYh5GBGLy5iac1jjBNK44i3heZx0cZJjTCT3/RIxBe5WwjkSDtprm6
         s5Mw==
X-Gm-Message-State: AOJu0YwgyfpmTyvRVS9xGWMgO2HMBNNilT8XnIPIOkNCjN9Q33PSXYxR
	rxgZLeqXy/p2i0tncYKC98HckugKVEby3NtNVA4m6t13DQ15WxGk
X-Google-Smtp-Source: AGHT+IHjv9k2KwZ55PoCGQdZFNcDsK4OFlHELx0TrRLo/YHjIbxVBPr7YJh6jsm+YsFDmma01GPMGA==
X-Received: by 2002:a5d:841a:0:b0:7f3:eda9:8037 with SMTP id ca18e2360f4ac-7f62ee3d7famr1042777939f.7.1719957541077;
        Tue, 02 Jul 2024 14:59:01 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:00 -0700 (PDT)
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
Subject: [PATCH v9 36/53] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Tue,  2 Jul 2024 15:57:30 -0600
Message-ID: <20240702215804.2201271-41-jim.cromie@gmail.com>
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


