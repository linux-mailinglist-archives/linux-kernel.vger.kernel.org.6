Return-Path: <linux-kernel+bounces-238437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F91924B06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FB1C2294A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1D183245;
	Tue,  2 Jul 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDDuS4Pj"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4B17DA15
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957518; cv=none; b=dUlhodjC0h91ftg9gnZWI3iyvn7Ll6S4HpHtJMPhGUz8B2EvONSFv+IDMIVAMrPwEQWxC0e4NKCaNCrCmtNTF92rBV6hTJQkXVNeh+hQ+gmWeiZi7iyiCPRTpGSZ7gJ6+5vGqn677oi+PC6S4FMqFIL4LjUrRbLGfbx0KAonO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957518; c=relaxed/simple;
	bh=rkyHyIRrVxPlQtQIJq+1MS/XFdntI2z6XQ5sFA29ViA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llraE/dNfTCWVeOMr0YRUKQZNq2GrrD/XMB/6tQpfBK/wZGHAWpBne90KFjZYYr/2tp0dA/KtbKNpyPSzDj6zDm7ru1W7uvBnxx9rYS7xnJoj+YNoFrjIqNU4pFvyVKTeCX3sVmWd8uVgqTP4raPtQlIE0rzr6Vk4iFDdWgy9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDDuS4Pj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f649f7868dso113911339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957515; x=1720562315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixqe2fvQ+p3xJowFXczfx5KdZEaC8a1vzuHPaRlFrmw=;
        b=FDDuS4PjtkFlT5VXvnbnbapgAvIpDYtoRUVRSm7oId75FzkLx9QgpXETbPxh1qkTaX
         od5he6XFsQ4SPSGVjIxP6yCmhu0L6G9a/2sPH0xqHvJc7gQ2MvXBZ5QjfpVOSJvDNOho
         vbScClwrx52RfSgNdcu05nI4FExmAkuvjnX/rnxc9xDNX6liwbf0YLjP5FmTm+apJGMt
         D1bb4OGOrYzWrOLBXsts+rDRnOZtYT1xoav8SMehvU/5OmPh31c8ORe5ub3iMaNHrrg0
         rOhNSntsP0Se5lqP+SwOrgLU4qh7nqP5dYc/O+UbUwIJ2xtvIIgUVrcGIS9kUk9y+Np+
         M//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957515; x=1720562315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixqe2fvQ+p3xJowFXczfx5KdZEaC8a1vzuHPaRlFrmw=;
        b=EueAQZEHkvoLdAIEoX8FeJ9w+MarMU2ZJAfVb50Gf14viOCoO2ChaKVUkznYYFk+7P
         OXaKZQEMF0OJ4Rs1+3yz0GogeSkm9BNmQww3LUg10nDDkvKGksmwoewrpEyd0mYuT2az
         AvUTIjjgdVtqMjij1gSdxZhs0ZTFkwwGp4Lsc9UrddQCBW3Kp11Wtak6yyjzgO9gc8Ks
         Cjlvja8lLGhsyGHxG08NZ4AHzx+JvBJFNXUQWFXpoT9cw+xmxulGitmU9/WtoIZmW6m6
         K7P95QP8zw4IUsp1LMWxxAExtaeleezCbIj5E0Cvpr01V46SKeQTCHW4aD0FVI89iPKU
         rh6Q==
X-Gm-Message-State: AOJu0YwxdXWMGABsU/OwFJY5ygjV9lJZJwM1/7Q9W9jVN3K6FHdkLCSw
	ZKLZSD2drD4L25V70u+ffQQskMLuo1hMOz3+eY1gQ/27fyq04bus
X-Google-Smtp-Source: AGHT+IGuF3X4wd/Q+QiMc/SNYxya2QDBND8SXs2NtMYBQ3/4cpFsTf5QXlJhmfj13W/6t+FhpK5Wug==
X-Received: by 2002:a6b:6f02:0:b0:7f6:1f4c:96d2 with SMTP id ca18e2360f4ac-7f62ed42fbamr1056411939f.0.1719957515370;
        Tue, 02 Jul 2024 14:58:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:34 -0700 (PDT)
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
Subject: [PATCH v9 17/52] dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
Date: Tue,  2 Jul 2024 15:57:07 -0600
Message-ID: <20240702215804.2201271-18-jim.cromie@gmail.com>
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

move the DYNDBG_CLASSMAP_PARAM macro from test-dynamic-debug.c into
the header, and refine it, by distinguishing the 2 use cases:

1.DYNDBG_CLASSMAP_PARAM_REF
    for DRM, to pass in extern __drm_debug by name.
    dyndbg keeps bits in it, so drm can still use it as before

2.DYNDBG_CLASSMAP_PARAM
    new user (test_dynamic_debug) doesn't need to share state,
    decls a static long unsigned int to store the bitvec.

__DYNDBG_CLASSMAP_PARAM
   bottom layer - allocate,init a ddebug-class-param, module-param-cb.

Also clean up and improve comments in test-code, and add
MODULE_DESCRIPTIONs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

fixup drm-print.h  add PARAM_REF forwarding macros

with DYNDBG_CLASSMAP_PARAM_REF in the API, add DRM_ variant
---
 include/linux/dynamic_debug.h   | 37 ++++++++++++++++-
 lib/dynamic_debug.c             | 70 ++++++++++++++++++++++-----------
 lib/test_dynamic_debug.c        | 50 +++++++++--------------
 lib/test_dynamic_debug_submod.c |  9 ++++-
 4 files changed, 110 insertions(+), 56 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2c6944c0d6cd..19f959f9a6b4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -91,7 +91,7 @@ struct ddebug_class_map {
  * used to validate a "class FOO .." >control command on the module
  */
 #define __DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, ...)		\
-	const char *_var##_classnames[] = { __VA_ARGS__ };		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	struct ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
@@ -164,6 +164,41 @@ struct ddebug_class_param {
 	const struct ddebug_class_map *map;
 };
 
+/**
+ * DYNDBG_CLASSMAP_PARAM - wrap a dyndbg-classmap with a controlling sys-param
+ * @_name  sysfs node name
+ * @_var   name of the struct classmap var defining the controlled classes
+ * @_flags flags to be toggled, typically just 'p'
+ *
+ * Creates a sysfs-param to control the classes defined by the
+ * classmap.  Keeps bits in a private/static
+ */
+#define DYNDBG_CLASSMAP_PARAM(_name, _var, _flags)			\
+	static unsigned long _name##_bvec;				\
+	__DYNDBG_CLASSMAP_PARAM(_name, _name##_bvec, _var, _flags)
+
+/**
+ * DYNDBG_CLASSMAP_PARAM_REF - wrap a dyndbg-classmap with a controlling sys-param
+ * @_name  sysfs node name
+ * @_bits  name of the module's unsigned long bit-vector, ex: __drm_debug
+ * @_var   name of the struct classmap var defining the controlled classes
+ * @_flags flags to be toggled, typically just 'p'
+ *
+ * Creates a sysfs-param to control the classmap, keeping bitvec in user @_bits.
+ * This lets drm use __drm_debug elsewhere too.
+ */
+#define DYNDBG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)		\
+	__DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
+
+#define __DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)		\
+	static struct ddebug_class_param _name##_##_flags = {		\
+		.bits = &(_bits),					\
+		.flags = #_flags,					\
+		.map = &(_var),						\
+	};								\
+	module_param_cb(_name, &param_ops_dyndbg_classes,		\
+			&_name##_##_flags, 0600)
+
 /*
  * pr_debug() and friends are globally enabled or modules have selectively
  * enabled them.
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9150e0e5145f..e9a95b0f3757 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -657,6 +657,30 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
+static void ddebug_class_param_clamp_input(unsigned long *inrep, const struct kernel_param *kp)
+{
+	const struct ddebug_class_param *dcp = kp->arg;
+	const struct ddebug_class_map *map = dcp->map;
+
+	switch (map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		/* expect bits. mask and warn if too many */
+		if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
+			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+				KP_NAME(kp), *inrep, CLASSMAP_BITMASK(map->length));
+			*inrep &= CLASSMAP_BITMASK(map->length);
+		}
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		/* input is bitpos, of highest verbosity to be enabled */
+		if (*inrep > map->length) {
+			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+				KP_NAME(kp), *inrep, map->length);
+			*inrep = map->length;
+		}
+		break;
+	}
+}
 static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *modnm)
@@ -675,26 +699,15 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		pr_err("expecting numeric input, not: %s > %s\n", instr, KP_NAME(kp));
 		return -EINVAL;
 	}
+	ddebug_class_param_clamp_input(&inrep, kp);
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		/* expect bits. mask and warn if too many */
-		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
-				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
-			inrep &= CLASSMAP_BITMASK(map->length);
-		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* input is bitpos, of highest verbosity to be enabled */
-		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
-				KP_NAME(kp), inrep, map->length);
-			inrep = map->length;
-		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
@@ -1161,16 +1174,27 @@ static const char * const ddebug_classmap_typenames[] = {
 		  ddebug_classmap_typenames[_cm->map_type]);		\
 	})
 
-static void ddebug_sync_classbits(const struct ddebug_class_param *dcp, const char *modname)
+static void ddebug_sync_classbits(const struct kernel_param *kp, const char *modname)
 {
-	/* clamp initial bitvec, mask off hi-bits */
-	if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
-		*dcp->bits &= CLASSMAP_BITMASK(dcp->map->length);
-		v2pr_info("preset classbits: %lx\n", *dcp->bits);
+	struct ddebug_class_param *dcp = kp->arg;
+	unsigned long new_bits;
+
+	ddebug_class_param_clamp_input(dcp->bits, kp);
+
+	switch (dcp->map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		v2pr_info("  %s: classbits: 0x%lx\n", KP_NAME(kp), *dcp->bits);
+		ddebug_apply_class_bitmap(dcp, dcp->bits, 0UL, modname);
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		new_bits = CLASSMAP_BITMASK(*dcp->lvl);
+		v2pr_info("  %s: lvl:%ld bits:0x%lx\n", KP_NAME(kp), *dcp->lvl, new_bits);
+		ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
+		break;
+	default:
+		pr_err("bad map type %d\n", dcp->map->map_type);
+		return;
 	}
-	/* force class'd prdbgs (in USEr module) to match (DEFINEr module) class-param */
-	ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);
-	ddebug_apply_class_bitmap(dcp, dcp->bits, 0, modname);
 }
 
 static void ddebug_match_apply_kparam(const struct kernel_param *kp,
@@ -1185,9 +1209,9 @@ static void ddebug_match_apply_kparam(const struct kernel_param *kp,
 	dcp = (struct ddebug_class_param *)kp->arg;
 
 	if (map == dcp->map) {
-		v2pr_info("found kp:%s =0x%lx", kp->name, *dcp->bits);
-		vpr_cm_info(map, "mapped to:");
-		ddebug_sync_classbits(dcp, modnm);
+		v2pr_info(" found kp:%s =0x%lx", kp->name, *dcp->bits);
+		vpr_cm_info(map, "  mapped to:");
+		ddebug_sync_classbits(kp, modnm);
 	}
 }
 
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index ff9b879286d5..b3c6f90b9fe8 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing dynamic_debug
+ * Kernel module to test/demonstrate dynamic_debug features,
+ * particularly classmaps and their support for subsystems like DRM.
  *
  * Authors:
  *      Jim Cromie	<jim.cromie@gmail.com>
@@ -35,24 +36,8 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
 
 #define CLASSMAP_BITMASK(width, base) (((1UL << (width)) - 1) << base)
 
-/* sysfs param wrapper, proto-API */
-#define DYNDBG_CLASSMAP_PARAM_(_model, _flags, _init)			\
-	static unsigned long bits_##_model = _init;			\
-	static struct ddebug_class_param _flags##_##_model = {		\
-		.bits = &bits_##_model,					\
-		.flags = #_flags,					\
-		.map = &map_##_model,					\
-	};								\
-	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes,	\
-			&_flags##_##_model, 0600)
-#ifdef DEBUG
-#define DYNDBG_CLASSMAP_PARAM(_model, _flags)  DYNDBG_CLASSMAP_PARAM_(_model, _flags, ~0)
-#else
-#define DYNDBG_CLASSMAP_PARAM(_model, _flags)  DYNDBG_CLASSMAP_PARAM_(_model, _flags, 0)
-#endif
-
 /*
- * Demonstrate/test all 4 class-typed classmaps with a sys-param.
+ * Demonstrate/test both types of classmaps, each with a sys-param.
  *
  * Each is 3 part: client-enum decl, _DEFINE, _PARAM.
  * Declare them in blocks to show patterns of use (repetitions and
@@ -64,7 +49,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * Modules with multiple CLASSMAPS must have enums with distinct
  * value-ranges, arranged below with explicit enum_sym = X inits.
  *
- * Declare all 4 enums now, for different types
+ * Declare all enums now, for different types
  */
 
 /* numeric input, independent bits */
@@ -83,12 +68,15 @@ enum cat_disjoint_bits {
 /* numeric verbosity, V2 > V1 related */
 enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
 
-/* recapitulate DRM's parent(drm.ko) <-- _submod(drivers,helpers) */
+/*
+ * use/demonstrate multi-module-group classmaps, as for DRM
+ */
 #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
 /*
- * In single user, or parent / coordinator (drm.ko) modules, define
- * classmaps on the client enums above, and then declares the PARAMS
- * ref'g the classmaps.  Each is exported.
+ * For module-groups of 1+, define classmaps with names (stringified
+ * enum-symbols) copied from above. 1-to-1 mapping is recommended.
+ * The classmap is exported, so that other modules in the group can
+ * link to it and control their prdbgs.
  */
 DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 		       D2_CORE,
@@ -107,19 +95,18 @@ DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 		       V0, "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7");
 
 /*
- * now add the sysfs-params
+ * for use-cases that want it, provide a sysfs-param to set the
+ * classes in the classmap.  It is at this interface where the
+ * "v3>v2" property is applied to DD_CLASS_TYPE_LEVEL_NUM inputs.
  */
-
-DYNDBG_CLASSMAP_PARAM(disjoint_bits, p);
-DYNDBG_CLASSMAP_PARAM(level_num, p);
+DYNDBG_CLASSMAP_PARAM(p_disjoint_bits,	map_disjoint_bits, p);
+DYNDBG_CLASSMAP_PARAM(p_level_num,	map_level_num, p);
 
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
-
 /*
- * in submod/drm-drivers, use the classmaps defined in top/parent
- * module above.
+ * the +1 members of a multi-module group refer to the classmap
+ * DEFINEd (and exported) above.
  */
-
 DYNDBG_CLASSMAP_USE(map_disjoint_bits);
 DYNDBG_CLASSMAP_USE(map_level_num);
 
@@ -180,5 +167,6 @@ static void __exit test_dynamic_debug_exit(void)
 module_init(test_dynamic_debug_init);
 module_exit(test_dynamic_debug_exit);
 
+MODULE_DESCRIPTION("test/demonstrate dynamic-debug features");
 MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_dynamic_debug_submod.c b/lib/test_dynamic_debug_submod.c
index 9a893402ce1a..0d15f3ffe466 100644
--- a/lib/test_dynamic_debug_submod.c
+++ b/lib/test_dynamic_debug_submod.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Kernel module for testing dynamic_debug
+ * Kernel module to test/demonstrate dynamic_debug features,
+ * particularly classmaps and their support for subsystems, like DRM,
+ * which defines its drm_debug classmap in drm module, and uses it in
+ * helpers & drivers.
  *
  * Authors:
  *      Jim Cromie	<jim.cromie@gmail.com>
@@ -8,3 +11,7 @@
 
 #define TEST_DYNAMIC_DEBUG_SUBMOD
 #include "test_dynamic_debug.c"
+
+MODULE_DESCRIPTION("test/demonstrate dynamic-debug subsystem support");
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.45.2


