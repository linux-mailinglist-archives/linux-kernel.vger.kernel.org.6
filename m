Return-Path: <linux-kernel+bounces-238452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE46924B18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51857287923
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E61A8B03;
	Tue,  2 Jul 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUbzpDT8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB661A51AE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957533; cv=none; b=uQlCopgum77z04JhB3+kDbCbCY1mgSmlGDOVSwA83uijJlyrZEMm88rHT7D6RnEhlq0dCWqCb0tkCGRzrO0XPHeFxzhrBc/pUG/jAsF9fSFQBbqFkYVQOV6HKaLW+vcn6F4Za3LI0hu1OJ0im5GXgKijM26HDd3MQN8COqheLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957533; c=relaxed/simple;
	bh=POnNemmaKMixF/7nR0EBXjmxEXWg84NxV4GYS+t83tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeq4Jh0NAJ29ft8Ov2zoaGVmrsfP7+FdrmWtKGOFTE2HLvN3FDIIdDU5WcL9jFHBJdGNhYT+hnNHmAvPIlf7uNHHUFQDW/MzAXiQlhQtPg0+xrN2EHRR+/t4Eg9W/auuKLq1snMq2OBd7f1H2ivAAKO03vvyIU3ixV7ZHttjM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUbzpDT8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f5f7ecacc0so203281239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957531; x=1720562331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82cgNbRoYEtZbLGOSF5g6lGYBT3iAgTZZ5N8otaIkxw=;
        b=SUbzpDT88RVFsyVg2L+EP/MH11d2NBJfeFZt2HjJugr0FHfyFVySL0inwEF9FW/Xkl
         CaWT9WCwkMOffad/rGR92qqEfcFij+aMcSixP8GJpPSHS1v+xf8yQ3zgA/ow2BYXDHIe
         NK/riyw7ngM23RK4cczlNWX9/ND/6It6NavYfT7LMVFdoIV1i9HVqKFPXNhdf7CK6pPD
         /QF3dfdZVhdawemxk2sZ4fgZEsMnuMtYSudJ0Blqulspv1OcoCtcdPHfY/t4/oWHcYpf
         bBOGBq9/PrgiaqZlSNQwkfd+RSwWiVzMGXrP3V2JevzJe4hFeRP1+JiKFRIY19T45jfy
         Aw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957531; x=1720562331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82cgNbRoYEtZbLGOSF5g6lGYBT3iAgTZZ5N8otaIkxw=;
        b=BuaA3F/9gP1gOW8hbRx2+A4IVUxclNkiY/PRAdWui7pE+LoBar378zEEsh1NP5kYrE
         8BGKYWgq7SewrGh+Nt/D13IOeaPHcq9L8FLDPQfTtqbxho0vo3b5JSSis3RFHa6MuEDu
         q22JjHIesIciFheV4+NCbCmrPhvvcryymGCn1Dq1HgdFxNOBhrxv1qwrD+wgGOEQNavI
         J/xdE25CPtMboBS1VzVTYkYyZaIzVG+NqAYToT9gxHmOtIlFiMVhFwamTC7dBa8YbkoQ
         X5nWtdu1afktbTw/INlLM/OXc4weE7v1VZbTHq+AcTUYVMnreUASVGO3+zSxFz+DtPFH
         pFgQ==
X-Gm-Message-State: AOJu0YyHt3yLA93EDOsnA/YAlwyhJY2/zuZ1vTmEbO3WxVESfk5R5nkC
	mHkB/jCrNnTE36RC73v1U/lii+AixtiunWwW7A29ZYFp73Y1Nk+z
X-Google-Smtp-Source: AGHT+IF0XfGuaBZergfyh09/+1cwiSfDW4SSxiw5JoBgqXQoqE0seQNYvFesDvoSIIDGsiZcxnz7Ow==
X-Received: by 2002:a05:6602:42c8:b0:7f3:d811:d808 with SMTP id ca18e2360f4ac-7f62eeae89fmr1232570639f.17.1719957531440;
        Tue, 02 Jul 2024 14:58:51 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:50 -0700 (PDT)
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
Subject: [PATCH v9 31/52] drm-dyndbg: adapt DRM to invoke DYNDBG_CLASSMAP_PARAM
Date: Tue,  2 Jul 2024 15:57:21 -0600
Message-ID: <20240702215804.2201271-32-jim.cromie@gmail.com>
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

Invoke DYNDBG_CLASSMAP_PARAM to hook drm.debug (__drm_debug) to the
DRM_UT_* classmap, replacing the ad-hoc wiring previously doing it.

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
2.45.2


