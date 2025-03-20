Return-Path: <linux-kernel+bounces-570228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C847A6ADFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D04A134B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B32356C2;
	Thu, 20 Mar 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Jd1s+n"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704582343AF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496829; cv=none; b=V+bvt1EofyYRBO4tmViBQpoxyKcXnbKUiIXBhZxf/OgQT9EIzk+T3LvR3E9pHXLz+OgvQTlJEJ7HMr3NDColb8DkGUi5W1Y3z7kzOYhysQT1iesO1MIYz7hZjXpBCJq1p/kgCOG1cTD0/xly/8U2inN8VoRAJwIalExEw1O8krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496829; c=relaxed/simple;
	bh=qi16htlIBXLIqgnOua66A4zrZXmKOWHgavbKOveaWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9hVXZy/w4wEt2N2qONwEdvww2+oVH9hKhSaqC8XjGnTkt7/C5z/l3s4hbsRhTk17ZVFooMBZxKqLa1QfnExQTda/RjawEfVGSOw3Yxy9pHsm1SSst6vz5VGsp26ePd8Fw+EbA9QuH+nWCy+uYHm+PlbLtUePrH5bX5Whq32+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Jd1s+n; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b58d26336so94041039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496826; x=1743101626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgDI/aHiLK+dNOZ45pw21AxG10xFqv/7yudaH0jzRkU=;
        b=X7Jd1s+n1+9mltUuW914pIHa/kt+gkvfHJqpXhAPo+a9A72Ux24pzxRWuNRnkQQgnE
         OdeJbAAerjzWjJGyg3+osANjZkXHF0hjIi37S3IU6/Qv5zPAW+F28mFN64SciwK+rqR7
         CdtNh+MMqF8Bl4biuvArc+2KItOwlatoVN9vyyBj+Q2DcrFA9ul7cSO1RWx6KyjMo+X3
         qjmD8AoaCJuN4tr29x+cB8H8iI5L2YjxAxTQ497s7O1jPK3evV4aDzCCVuqlWqxiktxJ
         hSH9nTQ+ZSr37uiOPGtQfPt0Mfsyz/Zr6N4RC4pswf7IvHclqkeXWYVrlXtmZgKmfX8d
         4LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496826; x=1743101626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgDI/aHiLK+dNOZ45pw21AxG10xFqv/7yudaH0jzRkU=;
        b=XbDr0sbbnzFL4llf+BfgBceR3RNdiNEIZv/0NAN4up0GkNld/OBJCZKhmBiqqC3GSk
         eHnbB/2gru0fjXKEZfvCLlaoNF3FCMtzXg+HcQpLZdMh5w/xNJdPsxa/rGaFA94Kcs3m
         etHHpVXsLKqrBzKZtMYnE//tRYy+hLRta3tykjtbPoaRA1JPiWSTQSuZeafgUT9FnwE4
         Ii8bjgdeRwgiY5LaZFsiRo3ejJIFjrILfNPXNhZG49/Ff9ktVrpasY7VaqXmlC1M3lgO
         OP+HeIPoOxE/R6sj0uk3OFryR3jJSWbj6z3TIrCQjeBuRRsTQ5aRL2dPNO1wDmPfPhYD
         3tTQ==
X-Gm-Message-State: AOJu0Yz9RZ9ynjsG/7QBxMlQx2OTpcBTy3H4t9l3KSVhiRWEj5+BY8bk
	lTuQTt1jGauDn/GP8ILV+PBHFfwli7wxOjlGe9Rx8uYeSEUE0RU5pCsWgAWg
X-Gm-Gg: ASbGncv/wvZeq83+thvf5SmnX+sfUzEEZfKSxFiWVu/Z/dU5+Jx7x3RdNn5aDpQkCNw
	HRlVp5cgTK2tzJeUvxSrp/k0PpthlSu3GMs5mBnmq275jQKQwRaCXnwukKuyTWZ2/UOOJO53HCb
	c5R5GcYb4wbsKarUL0H42MgoQTWXy86bUYNAI6kcKTVtudkjeJq1z9cM15Q2lP87lxcSAE+q05W
	TqXbq6Uf8anla4m+yUnnIUNHgrWpbya00sDzN8PzVGXayjL4zz0mG2KFyxy9VIzuQeqWPluoRQ0
	Efu6M/pesE0cc0tnvfxLvAu/nOW310qm4OIwHby3+0LPEL8cNfoC7GvrwT2lY87eMJIh8utKPMN
	mzw==
X-Google-Smtp-Source: AGHT+IH3per7MoX6CWSL0WNqymKLyYhHLAin9x57NXxWEpGpz2bnHtHQVSAlR4WrR+FYtRpO9rivXg==
X-Received: by 2002:a05:6602:399a:b0:85b:58b0:7abd with SMTP id ca18e2360f4ac-85e2ca35536mr54055539f.1.1742496826529;
        Thu, 20 Mar 2025 11:53:46 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:45 -0700 (PDT)
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
Subject: [PATCH v2 37/59] drm-dyndbg: adapt DRM to invoke DYNAMIC_DEBUG_CLASSMAP_PARAM
Date: Thu, 20 Mar 2025 12:52:15 -0600
Message-ID: <20250320185238.447458-38-jim.cromie@gmail.com>
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

Invoke DYNAMIC_DEBUG_CLASSMAP_PARAM to hook drm.debug (__drm_debug) to the
DRM_UT_* classmap, replacing the ad-hoc wiring previously doing it.

Add DRM_CLASSMAP_* adapter macros to selectively use
DYNAMIC_DEBUG_CLASSMAP_* when DRM_USE_DYNAMIC_DEBUG=y is configured.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 8 ++------
 include/drm/drm_print.h     | 4 ++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index a3b70d104afa..46d53fe30204 100644
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
index e86ebb716b4c..8758449491b8 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -144,9 +144,13 @@ enum drm_debug_category {
 #ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
 #define DRM_CLASSMAP_DEFINE(...)    DYNAMIC_DEBUG_CLASSMAP_DEFINE(__VA_ARGS__)
 #define DRM_CLASSMAP_USE(name)      DYNAMIC_DEBUG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...) DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(__VA_ARGS__)
+#define DRM_CLASSMAP_PARAM(...)     DYNAMIC_DEBUG_CLASSMAP_PARAM(__VA_ARGS__)
 #else
 #define DRM_CLASSMAP_DEFINE(...)
 #define DRM_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)
+#define DRM_CLASSMAP_PARAM(...)
 #endif
 
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
-- 
2.49.0


