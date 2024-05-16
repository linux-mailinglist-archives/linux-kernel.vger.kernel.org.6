Return-Path: <linux-kernel+bounces-181403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FAD8C7B94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71DF1C21CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC31598E2;
	Thu, 16 May 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2hDBwrL"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0115746B;
	Thu, 16 May 2024 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881506; cv=none; b=IgmGUyol2KfCczcs98WNRwxLO1xPx3VrZ2u4ofoGsD68aEkgufh4YVwjV7LODEHQSCuIWK68xPxAVQtvPC0nbK2ntI7zrJABOe6UNs3eUpO2+iCHWrjQlSzooyfPwpIWivrYyrIBH7bngiVrFVWqw67Udh5yUnGKr2pp7sRo3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881506; c=relaxed/simple;
	bh=GM9N2LrlUL8U0wq9Ag+waTG9Hi+B5LIi7b+LNnW+GLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ7DplCWVo6Cm8VwxIOtFpAFXpju7yHwSRqXyJBRTegX64TgCOyb8BDwwKp6M/CJmx1juPBb9YYJoYBuW9bLAuHWDAwBhqa63JOUhQkxA7ucvp3oOKd+93RiD8RYHG0yxerohLa7ktGRWKqJMTySP6q1oJGV8kJYC9OwYpy5cG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2hDBwrL; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e1d1caa7ffso66187339f.2;
        Thu, 16 May 2024 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881500; x=1716486300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLBKzxxH2pRFwxzcdRvJn2RLwMnUnuSXZFAsD4xZDeo=;
        b=E2hDBwrLAYygAlVFudvFcuC7ZX7tGfj4Gp4fPjAde8EYfSVK7zYsXKmXYcnb9pbiRS
         yEc1Fy+GSGpdljCbZ3d6RDbRfeX7DRDfzdM/r2lgnpGdobGhCHihARWsJfUQ/2Wpy+A3
         DKP4eRgeBrhE47r0QqcR7w4GePt5o4mhEJM2WY9eoXqsGt+8lMMeS4eybkoKMRKVa5Uz
         ju3EPBwk4sWgCfzB8DeeHabIEWHHWKLsre9CBK2iKn6Cvipf51ApJW+xBoUVsEFdPMNG
         pqDXAU6ScaI5u7ApnXx6VjT7dt2s0fOOMaXztsjScPHcgeYss5twQ6EfZgKHwyfcDXZU
         p96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881500; x=1716486300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLBKzxxH2pRFwxzcdRvJn2RLwMnUnuSXZFAsD4xZDeo=;
        b=UP9wgnDEoZKQBxTBkIfjl/r3mQwcVWH4zaYLPsfk4PUEvYedsqCdGAzj3lCGwVckRj
         UXBmY0VdrSXmrSix6NXpCDjLJK59TY5ymYVSVjpfybcFI1IXTWFnPKFf/+gpUlilbhe4
         c/A+ry4aEGtWaYXhzGPlcJb3BSJpjmK1Xko/5EdElh+0RaJ68EeZqSmU2vLOF02sImRC
         i9a0UA+uhJ0KwqP+4PkLa328DTI5qzUXg14vJ4XIMlO3g35uwBidbBGtm8Gw2+lW9Cco
         IhYAklUCFRN15ijOUTQvTpO6FBQMLJiEhGrO4Xf0keGrAw+Bx/dpLFHfjPMveD615Vlc
         U9+A==
X-Forwarded-Encrypted: i=1; AJvYcCUKm9jyrUVrzlOaXtsv6s+dZV0ee2tBQj/6IcWVQcIpNhDCs4BN69KxxRKs4RyBwqhCG3U1z8Bp1jGBGMB6sVJ/soaeILtNChBFvaSCKpuLH19YB+vuGE9ExwX0WJcT/tF3gxFjAOn1
X-Gm-Message-State: AOJu0YzGqM4lGwK84TGoMF22Be5leZBi462MgYXRwAPwjWHuGmI+puQ1
	tKO4aqwIPxo2SzYrcofX11B2UCIHvlGJrcfDEKToBXHA1dOZE7Ew6F+rYfwO
X-Google-Smtp-Source: AGHT+IF/+eG2qtE07kKJaVQnO9f66GBm40WERaL8uTXj4qQUQvXwvu2VIwG8Q36c5154c75Shh3DSg==
X-Received: by 2002:a6b:600c:0:b0:7e1:79ef:b78a with SMTP id ca18e2360f4ac-7e1b522a828mr2069164039f.21.1715881500524;
        Thu, 16 May 2024 10:45:00 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:00 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v8-RESEND 19/33] dyndbg-doc: add classmap info to howto
Date: Thu, 16 May 2024 11:43:43 -0600
Message-ID: <20240516174357.26755-20-jim.cromie@gmail.com>
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

Describe the 3 API macros providing dynamic_debug's classmaps

DYNDBG_CLASSMAP_DEFINE - create, exports a module's classmap
DYNDBG_CLASSMAP_USE    - refer to exported map
DYNDBG_CLASSMAP_PARAM  - bind control param to the classmap
DYNDBG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5 adjustments per Randy Dunlap
v7 checkpatch fixes
v8 more
---
 .../admin-guide/dynamic-debug-howto.rst       | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 6a8ce5a34382..742eb4230c6e 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignored.
 Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-fslmpt``.
 
-
 Debug messages during Boot Process
 ==================================
 
@@ -375,3 +374,65 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+Dynamic Debug classmaps
+=======================
+
+Dyndbg allows selection/grouping of *prdbg* callsites using structural
+info: module, file, function, line.  Classmaps allow authors to add
+their own domain-oriented groupings using class-names.  Classmaps are
+exported, so they referencable from other modules.
+
+  # enable classes individually
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+The "class FOO" syntax protects class'd prdbgs from generic overwrite::
+
+  # IOW this doesn't wipe any DRM.debug settings
+  :#> ddcmd -p
+
+To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates all
+classes in a classmap, mapping param-bits 0..N onto the classes:
+DRM_UT_<*> for the DRM use-case.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, naming
+each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
+type, and mapping the class-names to consecutive _class_ids.
+
+By doing so, modules tell dyndbg that they have prdbgs with those
+class_ids, and they authorize dyndbg to accept "class FOO" for the
+module defining the classmap, and its contained classnames.
+
+DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP that
+drm DEFINEs.  This shares the classmap definition, and authorizes
+dyndbg to apply changes to the user module's class'd pr_debugs.  It
+also tells dyndbg how to initialize the user's prdbgs at modprobe,
+based upon the current setting of the parent's controlling param.
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNDBG_CLASSMAP_PARAM - modelled after module_param_cb, it refers to a
+DEFINEd classmap, and associates it to the param's data-store.  This
+state is then applied to DEFINEr and USEr modules when they're modprobed.
+
+This interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+amongst the contained classnames; all classes are independent in the
+control parser itself.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the class'd pr_debug callsites can be forced off by toggling the
+classmap-kparam all-on then all-off.
-- 
2.45.0


