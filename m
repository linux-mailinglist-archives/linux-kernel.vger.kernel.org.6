Return-Path: <linux-kernel+bounces-254285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBEA933173
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965611F21D66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941B1AA35E;
	Tue, 16 Jul 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rat52FxB"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB611A990F;
	Tue, 16 Jul 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156347; cv=none; b=fG6Xidbq+pOumsm+FPoPogVKr7Nv9Hh2u61/KWMWCrB9+lofUluBzoDl306+74+VcEipWuMCHwkRnUDRm5kKGoHc2SNM9z9hTdkvkRgFJTYJn+38ecGQ1U265u+9XRNmF3AmgUSjNK/IA0uj+BL5NIZ6JzHCqpH4xEbVz7mFNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156347; c=relaxed/simple;
	bh=Fo3ouD/xxQzt9CuwigIdltJve9vn+WUo/Pr6E3kGia0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOF6pfYcewIThxZ6T/4KAYhn3ufxOHoj6Sad1tEmKWThzggkHxjWYbP+mdmRhrI2k72Ivzf45vvGguUcpq8aZ4Y27WHL+VvlyI5kEISEkQKEksxVnbCTRxIo8ZKdahMxdx2EOfEaXmEAVSeKy8TxwDqurlNhg/KswC2mE1wb7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rat52FxB; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-808a8c90f5bso4659339f.2;
        Tue, 16 Jul 2024 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156345; x=1721761145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6blOBSVnowRsDepJzeTCLiu7QXKUuExri+0RrzbqrM=;
        b=Rat52FxBFTnMZ1xLpkDaSv7omzCHxhYkafHgvBXS/HAibo1qXaJTxG1TiaOz7vNB9I
         N0cDsHv5DOJBEOCvtRAQdqu+/V0pn4jszePXTC8D+IR9OaSv8PjXto+GC/TUxk7JTNh2
         nlHEjt/E5qqvk/uAx+kZMmbf+/i4wg7Nyyy4u+SmeqpEITSKHY/KeomA0w5pkMmePHpq
         9M7JxT5OvLvEa/NXKgFdNDAe1U074DRbZTJA9iSytl40CPRWGfJCO49ej2vsTsHcjnhS
         rRY6Kic6bpEgFy4MSTOnkHrepMcJsIY+Jsggreb0nBEisE5n3xZuhmp5bmRt4Fe1RR21
         e/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156345; x=1721761145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6blOBSVnowRsDepJzeTCLiu7QXKUuExri+0RrzbqrM=;
        b=oGRIr3j3E1ueecS9zScrgv/YtHsO955zm42AXJDHDTkuXSYJRiDeTZ1fdhtIy6IAsH
         Vky4w3LvrrhIzbto/OK9zCdS1ETC9ng1m1qvlIkZRia8v+moEqQq0u7A5Wa//ds4d20x
         x0MxphgpX+1G44qJobOQkWgY3hNTvqZLy8wf/nZ5mdYs4ca/RW1nQPW5YRgPevXP4WoD
         HBSg7xK6ba9HzldcIPWMXH48ESr6w2ppyW3IGy17SB/XMtRTVVHnk3ZKCQMdiw283J+q
         odmpo3pSldVRfPo6figxocef9T8VLIxicziYw8mLk5/i69Q+w0SGbtFM/p9grWl+8Hhu
         YO6g==
X-Forwarded-Encrypted: i=1; AJvYcCUo0P6gVrgMKoVnFikQqfLXhs3DkYsvGWW+fF2X+6QCZaRtZU4gwY9IN43pp/7gVYkRfOqog1d1r72TPNwyP/mKcFbo4cZfte2c
X-Gm-Message-State: AOJu0YxQ5NVrhZ5+uHT3T1ihzjc6fDwIvXD73UTXXRa2ChJR9JP5hUyy
	B8928OQk1U3mXndgj6ZlphgDkX8NBvV5fNWVNtJb2JFaJQNXhB636uupESa4
X-Google-Smtp-Source: AGHT+IHupF215B8HUHSFyCfq+EhhBdI8n2Uwkool8jFM4Uueq2pJrHXQgCTgI0PTVZNLug7iKTYbjA==
X-Received: by 2002:a05:6602:14c5:b0:803:85ba:3cf9 with SMTP id ca18e2360f4ac-816c38c0218mr44418339f.10.1721156345102;
        Tue, 16 Jul 2024 11:59:05 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:04 -0700 (PDT)
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
Subject: [PATCH v9-resend 31/54] drm-dyndbg: adapt DRM to invoke DYNDBG_CLASSMAP_PARAM
Date: Tue, 16 Jul 2024 12:57:43 -0600
Message-ID: <20240716185806.1572048-32-jim.cromie@gmail.com>
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

Invoke DYNDBG_CLASSMAP_PARAM to hook drm.debug (__drm_debug) to the
DRM_UT_* classmap, replacing the ad-hoc wiring previously doing it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 8 ++------
 include/drm/drm_print.h     | 6 ++++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 41f167082042..c7455f2076b4 100644
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
index b467ee67a281..aa3708c7b6d8 100644
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
2.45.2


