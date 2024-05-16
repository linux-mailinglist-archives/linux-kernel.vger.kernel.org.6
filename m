Return-Path: <linux-kernel+bounces-181411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4248C7B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D13A1F21B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130615CD72;
	Thu, 16 May 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpV+K0Nd"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96315CD41
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881515; cv=none; b=SaSqDaV2d++6yq8Q7d5RuaQAUI4ocIPHL5Oh8t/DVXt4JHSmSdmuYM0dV5SF5bJQW2Vb58N/gqLRU6k8sUZIH/3Vncxh+TZKild5t7wkpudN+0IydRNa7Yo3PLnqqQ99J50CVC3t1//uzz7ZRDbtSacT0iGfG+BtJqCl3NNy/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881515; c=relaxed/simple;
	bh=aTQGGNmi0yNbpQJeet+hYQWWfGCVSXpdCjm4Gt7I6+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8TwQQumFzHrwYc9PNSOS34mqg4tLOEfu0agoBiOzbLUCOPvahkXE1s2PTx8V771+TXFoPgeNNh1Ihfk8MZGGirXdXF61Hjx89V964T0ZyDlUH7+XnMo3C05bQapxdYkxAJBXW+J0N9Bb42GDPCEWoQkhuEpEBC5JhpO0x43Oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpV+K0Nd; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e1bf0e9ab5so62841039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881513; x=1716486313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MttqmCnvGJ5H20CP+TVSJnxFzBK+hVVV1LSH1eFSpC4=;
        b=XpV+K0Nd9Xm5w5omW9FQBzaM/MlgFpFeTVCVc1FhuLP69FTzl1p6G2Xa3I9+x338Vf
         gReUFON8ASAb37FIYs+n6KliYY3UX2U+lQUodRPXdgkqMKwd2Q1/rhIwGp1bVIQguCZ2
         u2VPsrCKrWdeLs+9W2YMP+x5GvsRK0zOT3svqyBpiQENYDKjqKIS869aTtYitCToBNYI
         KXBrl5Kya4s5d5jq+GtmTsaEYErEJGvmjzn6ARPeJUpekjNX9gZdxkjILTieH7qKWgWf
         q2Gdp0pemhujpUWR9ccyOB8ZXE2XrMLmwfqld865eUJH263/i4a75N2MMl08/bu4KLdB
         BkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881513; x=1716486313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MttqmCnvGJ5H20CP+TVSJnxFzBK+hVVV1LSH1eFSpC4=;
        b=FlKeQOdJsA/QwZrY2hFa9B/nSvbfL57uV0Du2MObr56jv3KF3Qux67Fk8Dh6DLHiIb
         anQz41nt6fOuB0BSyXyGif0V69PHT7jjSHBHjSt7P1uWwbbY0eelx5MiGQ3bsQEd8koq
         qdXGSF7MspxzN5CZOMzjfY/mdwZFeQTBhvlSiIz1LtPngTs6Kli/3b4tXKrVPwWiHiuC
         g67T4W0pdw/8apTiRkpa0mvsDGbQpb0CQofFZioY4pHm2LtwQ4h5RfpvC3os1EPAvTiY
         c0oOgc0EdB9pHPosOtU1x2kqshMlgMVgfbUjm1OeOS2nZRIghKoMhkaFNPQdyj9G8HOe
         5QKA==
X-Forwarded-Encrypted: i=1; AJvYcCVm4GSNTZRM+J4odLMOkufTK1uVXDOaqpKvAnPTtr21idLHoHIOeyxmtJif33wZUVLdh6Dul6eqhOl3HQCBCZ1f+EzIgPl26dqcElK2
X-Gm-Message-State: AOJu0YxC5dVkqpNf4V1A+tcTDRGVEhiuVWEY8Rkkqke1E7LjCKUBHHCQ
	V6qBTTJ7IrmT+9it+iuaE8sJk/IjxCCtd+537T1ZPO1oaVseBLgs
X-Google-Smtp-Source: AGHT+IG7d02P9XnjdK+dzFg+syAJa4w9AKg+W40iJ5EGJYG4XmNlNZUvjMDb2oNR6+4+x9AeQtZWQg==
X-Received: by 2002:a05:6e02:15c8:b0:36c:42a0:7abb with SMTP id e9e14a558f8ab-36cc1503191mr234788725ab.31.1715881513583;
        Thu, 16 May 2024 10:45:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 29/33] drm-dyndbg: adapt to use DYNDBG_CLASSMAP_PARAM
Date: Thu, 16 May 2024 11:43:53 -0600
Message-ID: <20240516174357.26755-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use new export

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 8 ++------
 include/drm/drm_print.h     | 6 ++++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 4a5f2317229b..efdf82f8cbbb 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -69,12 +69,8 @@ DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
 		    "DRM_UT_DP",
 		    "DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
-	.bits = &__drm_debug,
-	.flags = "p",
-	.map = &drm_debug_classes,
-};
-module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+DRM_CLASSMAP_PARAM_REF(debug, __drm_debug, drm_debug_classes, p);
+
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 905fc25bf65a..95c667934bbb 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -141,11 +141,13 @@ enum drm_debug_category {
 };
 
 #ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
-#define DRM_CLASSMAP_DEFINE(...) DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
-#define DRM_CLASSMAP_USE(name)   DYNDBG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_DEFINE(...)    DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)      DYNDBG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...) DYNDBG_CLASSMAP_PARAM_REF(__VA_ARGS__)
 #else
 #define DRM_CLASSMAP_DEFINE(...)
 #define DRM_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)
 #endif
 
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
-- 
2.45.0


