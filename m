Return-Path: <linux-kernel+bounces-254284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA35933171
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE8283B91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2731AA348;
	Tue, 16 Jul 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8Llw1QM"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4721A98F9;
	Tue, 16 Jul 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156346; cv=none; b=BhqwmTRKqN8lJ7ePuAsD32kFJqmm64daugmEPxoYChPw7K2+RuejcpWJkspczPOZN5NmvN5mZ82qGm37DtZrrQwuszyb3pXVO0WExMj6TBZ3KIgvDXNiESOwTPxf5EqHSVT5CEf1ZTAwJg5EbvO6/X8dJALBnk4wD88VBUYI7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156346; c=relaxed/simple;
	bh=VKETVvP29EC7pBLY1S1yuOzRNXKTxw4JIyKxF/iAfi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dy/dEwIVoaT+HNUvZnUhXx91Rmvk8B6eJ2jai1I8aUuy5hIjL2FBLLyjsjxSr3TM10NMIZIM/ri3SFm6vDwXCyI7oLtv6WVsrIEr6MloD51fpKJf7lkMmYbzLOMoJUQMJXFh3+2BBRq5zsWWk0YsgSZ8U+d+l3UbuaRYeMfxz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8Llw1QM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-382458be739so541375ab.1;
        Tue, 16 Jul 2024 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156344; x=1721761144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7xcpbsTDFqLNkX6yLBfMI4Cmqq9UEc7Ib3kRvowNps=;
        b=V8Llw1QMf5BlQb0mCfSi1u+NGLnQbBp6Tw88BAbYcgHxpAQ1zOUTLf074IuyC008tZ
         C8gMEEECqwXnZVpGQ9JqvEtZWA9mcsTrHOQRYg79dTZRGnOl6denVyXpD9pZfCGojI+N
         dx5p9w+vV4QNsCcPuTTJOGE0wyGCyTxRNuForywY10hviCCc9tEfvplgyVgAz10MC5zn
         JJI77Pmoq5fTD/bG0MsCFct9ZVPaIBl+i2+2ugq2V5YhP4rb6Zu/Ls7RJ6E5me/pmkkY
         nxnKZHY325PUEyxQVjJb6QGH4dCP94Op+bv4BKA7Smz619gyMRiGw1fHfTMQYXJIsKC0
         Emyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156344; x=1721761144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7xcpbsTDFqLNkX6yLBfMI4Cmqq9UEc7Ib3kRvowNps=;
        b=dNXORWHZzfPJCWJ4dJuXszAbhT3MWtBMh1yU5JgKc1kfonBPckgVPqgkbfau0mvYR7
         EcEHPYo2tpGwh6wvhyU/IHDqwKNTxfY1sUA++yL0yk5g50iNBiKCdTViISAtVyU/m9u0
         naD20ux3qHjTanGLCn15rzvZ8zRX+2qPEauce7YA8sYBLl+3/s0V+h51yykZarmw0yic
         nyoC4Ht907GgHUNmNSXuZZSumL6Gaa5lFW2hXVvKFcNZpQDd3O4+DuWEKC69VvhNivIJ
         hWTKDKR93TglEb6+6aLP+FLS3kt90U9GWniCsBm+uoT5GGXKkNAnNazWtPYX+kJT2dwd
         b5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDLDlxdawaqS48GjZfFEUvkm3THIuFGv1HK8lBFk7JqhFr1PXuZodlh22nlHsc8x6nzbOiQGmpS4NBr3U5lmKh+tcPQbrttirg
X-Gm-Message-State: AOJu0YyWMAzT+qDffpCacZhqTWUgZ0wW9QtPBZTuYhnpfRhTXQ0AuSqh
	dqm5qVynSW3BsqtvQGPaFsXiv50tguB+bMpGmWdE1VCnaBdtfxYtOdTuXr0y
X-Google-Smtp-Source: AGHT+IExllrK/dDXx9zHRPe0P0zQSNNZHGhy8f3RcoaQKjATZG0VIQe5Ln/GSLSi2fMerteHcMi6Pw==
X-Received: by 2002:a92:c267:0:b0:375:ca62:a418 with SMTP id e9e14a558f8ab-3950e9d74d7mr3061045ab.22.1721156343924;
        Tue, 16 Jul 2024 11:59:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:03 -0700 (PDT)
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
Subject: [PATCH v9-resend 30/54] drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
Date: Tue, 16 Jul 2024 12:57:42 -0600
Message-ID: <20240716185806.1572048-31-jim.cromie@gmail.com>
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

dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried to
do too much.  Its replaced by DRM_CLASSMAP_DEFINE, which creates &
EXPORTs the classmap when CONFIG_DRM_USE_DYNAMIC_DEBUG=y, for direct
reference by drivers.

The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they still
redundantly re-declare the classmap, but we can convert the drivers
later to DYNDBG_CLASSMAP_USE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
 include/drm/drm_print.h     |  8 ++++++++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index cf2efb44722c..41f167082042 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 module_param_named(debug, __drm_debug, ulong, 0600);
 #else
-/* classnames must match vals of enum drm_debug_category */
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
+/* classnames must match value-symbols of enum drm_debug_category */
+DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
+		    DRM_UT_CORE,
+		    "DRM_UT_CORE",
+		    "DRM_UT_DRIVER",
+		    "DRM_UT_KMS",
+		    "DRM_UT_PRIME",
+		    "DRM_UT_ATOMIC",
+		    "DRM_UT_VBL",
+		    "DRM_UT_STATE",
+		    "DRM_UT_LEASE",
+		    "DRM_UT_DP",
+		    "DRM_UT_DRMRES");
 
 static struct ddebug_class_param drm_debug_bitmap = {
 	.bits = &__drm_debug,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 089950ad8681..b467ee67a281 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -140,6 +140,14 @@ enum drm_debug_category {
 	DRM_UT_DRMRES
 };
 
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+#define DRM_CLASSMAP_DEFINE(...) DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)   DYNDBG_CLASSMAP_USE(name)
+#else
+#define DRM_CLASSMAP_DEFINE(...)
+#define DRM_CLASSMAP_USE(name)
+#endif
+
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
 {
 	return unlikely(__drm_debug & BIT(category));
-- 
2.45.2


