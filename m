Return-Path: <linux-kernel+bounces-238451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D03924B17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2231F27973
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671BA1A51CC;
	Tue,  2 Jul 2024 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVF+AWqI"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B2191F9D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957532; cv=none; b=j4kAId4HMcOUqgdru42MXu+ZdFx5ibnu6PdUKz4pkRoaoFm/oGlKkeGkV/khSN0JpIaarg81dQUTM1ozxFg+F5WvySA3atBP/ruUaT2LIojNcavxr0FGLacZqg5NWvhGDSrmXn+m9Omv1VaJwE847rXQbjGL4aqMaZc7PLG7dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957532; c=relaxed/simple;
	bh=SH68ssTO6mhZ+HkxrUbFb9+I+8S84avjy2ls7h7xvGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMbBJ31g9ASZCgY2J1pG/UadQ6QADHIbuNLZjsywlIj8poUeNWvY9tGAwAOM/fuRvXTLUwaHiD0yNAa5x2n/AcE2K3KXkpTCoLfWMPf4V+5mtQQ7MsiWo0GcDsJfhQzdhGVK/IuE32hnuRwS/dVi5KV6QsC9/W7V6f581HTpUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVF+AWqI; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so246289439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957530; x=1720562330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxDd/jlN1Gw8bPV0q5UJew/A89joWXWCEanlG0C3i6Q=;
        b=bVF+AWqIifKfvmSu7wV/3GzPCahxrQvvnt33Kuj/4eh06KItCaOMDH3ttddhnACoaM
         kvL2URkmpOBYqCpX4NbPDs0ivEVX7tr/1SXv/Tw+4cpbgUGLw0myAFP8W46dFRp+8Hjc
         2I2STtw1y2xU70aGXvrGk+SjcFkeBj0MD0fnWPtAKMxQux2b6OBMijp926tbv3SP+HMq
         tnUk0Cw2uuWa5BwQGKCA/sPlxL0Yc8/mgaO2Vm9z2hiJI2zm5bepDBIoIunVm6Qi5VjO
         2qpod+dQrNkfJ7JHfUF3EBTdCawT1huktp0syCfa6VpdxKu478oRtDLevn0/VaLkKZAY
         nl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957530; x=1720562330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxDd/jlN1Gw8bPV0q5UJew/A89joWXWCEanlG0C3i6Q=;
        b=bypfRNXb4C3if9ntgV+B8sh93gvtPvxaxqvOfU5pMOvEDA5Aw3USOKz9olgj9NbwpB
         stcfISLupZbQcw0KGjMeFm6hk5ch10vZcc15EuPCPsLDjPflE6Lf+4KJwYz5j1yxIHeb
         D11/1RVYJ7xH922xDwdXAwRF5jofrHvSWC6sW+pUolqS8DJH7driuAcWi+wI0LGDDHMf
         PiHOBTy8rW9TPEmvCgE36UDFzLzoluMZ7NqDXJk4+K5gguRUH8D0FwwwGWq0smMAPqwZ
         1dKFrhOWi2NOTJVLEioQlOyl6Qwzt2Hvwx8vqRs5KyF/OnM5zXZgY6Xi2n2/voiu9C/y
         Ft7w==
X-Gm-Message-State: AOJu0YxAePGA+mbCV2g+0NZ/Zwycvqo90NaspCm0YvKdvf8rU7ctQgaL
	GQ9MYZFwpOGx1YE43vuQM/GMEuVqjOLA4MuQu1VGKuaDkSCNErxD
X-Google-Smtp-Source: AGHT+IHA5cWQwG7sGQgG2GsZbHmX9YOZDWo74Sg5hZzfWG9rJh2QlSDlAZETNf1gZpS7tHAO3w2Pzw==
X-Received: by 2002:a05:6602:1816:b0:7f6:1f87:70c7 with SMTP id ca18e2360f4ac-7f62ee1b1d7mr1169478639f.11.1719957530383;
        Tue, 02 Jul 2024 14:58:50 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:49 -0700 (PDT)
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
Subject: [PATCH v9 30/52] drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
Date: Tue,  2 Jul 2024 15:57:20 -0600
Message-ID: <20240702215804.2201271-31-jim.cromie@gmail.com>
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
index 699b7dbffd7b..4a5f2317229b 100644
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
index 9cc473e5d353..905fc25bf65a 100644
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


