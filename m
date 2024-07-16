Return-Path: <linux-kernel+bounces-254307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E29331A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4971284CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E161AD406;
	Tue, 16 Jul 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9IRwKfJ"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E71AD3F6;
	Tue, 16 Jul 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156375; cv=none; b=LC1XV1XiIX49UN4PDk5QMrTSMV6zUPc5vOg6HiM+PDjpB3LAI6qFUX1zyVQ0Anpa5QXW3Q5g8LvOLOxbWpEjWyOvjag+gI+Vs8tcdzbmKpmQbdFOnqe5REA95QL3w/9wFFrirbJda30oA0usovi2TBl64ipyTvu5SA5EvYWfo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156375; c=relaxed/simple;
	bh=r2J6F3T+xrlwuOrDEvu+SHWJ55NNYhDEHu73NlVsz0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6ELfUujDXe+2ktRIaJdwSLLgkpWMqzSzJ6AsFMVDNSBqk/tWE8RXRprp2q7wqqyNWJN41w/f8RVENEm2dacAguDwIt0lq/4UuSUuKtvKxSKgqT5vtPw5sKuNi0uVbWdyh1TCVd9pVXr3BU3ocLt+TvG92XiIEI/OwsFL3Cacr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9IRwKfJ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f684af6af1so6731439f.2;
        Tue, 16 Jul 2024 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156373; x=1721761173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgAqMd3+iIWmYMpud2tAag7fU0ZRfIKBjcu44k/UC/A=;
        b=g9IRwKfJzHdw0U8tVVfYPJHm8Vm3UbtLyCdww0QuvGTTKFUVLYC9KVAn3oS+fMnkpO
         u7W2tmA3ltjvzbSSY6mTt974XkhbYuHnhlcYgkSbLsCnsqjT6oY4OaUPrZ60GK65FlGF
         b9Fph/nPnRuHRVIZDMC98FT43oXPW7yXxchUMHZ0l4hJPv39/F+P64XVqLQ66fznrZoY
         17R7HqVSFfk7ZWy0AFVUnTL81INIqhiCVvuWzMzyjoU6ePXfd0RbYr9agqTDeHo86MyL
         iVL/OIy5cBhivfsYHxvnBlbVEyuNb15ifnOhsJ0oE7vYv/qLi/AxBVdYBzpNS41GzLST
         5zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156373; x=1721761173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgAqMd3+iIWmYMpud2tAag7fU0ZRfIKBjcu44k/UC/A=;
        b=r/iROHO9VjOuTYxXrjtECIovBfsnRwpng5LDn+It6qSA2SJayLJbifVhN2ZpR+xvX4
         OiNGjJ88U9bUjRjq65Cb8ok/JF1yjq2dvAbUnew1oo6qv55zjghsZxUcBJtvS2bxjD6C
         ga72PpfG3sH+OUwuv7Nf7fJb0DtXRPLJSCmrAACSpA4Y4NE1XYlkdBwHp4ZK4ln2aANp
         OGcfuwtPono6+0KOIYrIakRxdhh2SoymvCnmm/w/pJtYshNIgauFuDyNvLaZO/st6nQ/
         TTI0KEMxIEK+rfGhwCfKFFB1zrHpaUkA5S7MNRZwjxxzmUuBD1dU9i1fS4PULyNLZtBk
         bCgA==
X-Forwarded-Encrypted: i=1; AJvYcCU9HTbXWsK0pMqAXK82SdI45rDUdj24/rmfbmZqA4rwXRuOyBpORcm+qnuhSFhh7bTAd2EayKhnGuzpejtVb3rcPG3buQ6qk6kd
X-Gm-Message-State: AOJu0YwDBHnVV8TSMKKbmawqozk3FN/QL/TcD5KHyRFFYbpf8vU7pZH4
	p3yaL1kpjw1T7EJDvFonVwxBjo5vJU876/NS3YstCRHP6fa4VNq+oEFP/cdt
X-Google-Smtp-Source: AGHT+IFni6bIdZqwUH+Scyf8+nuvN3S+CKoCazA0MHSZb6wujlaADABqWvB5L9YjT5+rHUGh02BCbQ==
X-Received: by 2002:a05:6602:2dd2:b0:7f9:c953:c754 with SMTP id ca18e2360f4ac-816c45417e8mr42533539f.3.1721156372732;
        Tue, 16 Jul 2024 11:59:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:32 -0700 (PDT)
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
Subject: [PATCH v9-resend 53/54] dyndbg: tighten up kdoc about DYNDBG_CLASSMAP_* macros
Date: Tue, 16 Jul 2024 12:58:05 -0600
Message-ID: <20240716185806.1572048-54-jim.cromie@gmail.com>
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

The DYNDBG_CLASSMAP_DEFINE expects a list of classnames, and
maps them to consecutive classids starting at _base.  That
1- list-of-classnames can be syntactically replaced by a
2- designated-initializers-list/map.

But this creates ambiguity. The 1st thing the macro does:

   static const char *_var##_classnames[] = { __VA_ARGS__ };

This construct accepts either list form, cannot distinguish between
them, and they place data differently.

1. puts the string values into array[0..N-1]
2. puts them into array[_base..N+_base-1]

2 wastes 0.._base-1 indices, and more importantly, also spec's _base
twice: as a parameter, and then in the designated-initializers-list/map.

Further, the code is written for a contiguous range of classnames and
classids, and passing a map allows casual violation of this reasonable
design choice.

In particular, DRM_UT_* is a contiguous range, and each maps to a bit
in drm.debug.  The macro interface shouldn't suggest a sparse map is
possible.

So reword DYNDBG_CLASSMAP_* macro kdoc to more actively guide reader
away from designated initializers here.

TBD probably squash this back into the patchset.

CC: ville.syrjala@linux.intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 52 +++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index c958085e0df4..d75a5d3ae388 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -80,15 +80,22 @@ struct ddebug_class_map {
 	enum ddebug_class_map_type map_type;
 };
 
+/*
+ * modules using dyndbg-classmaps must invoke either
+ */
 /**
- * DYNDBG_CLASSMAP_DEFINE - define a set of debug-classes used by a module.
+ * DYNDBG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
- * @_type:  enum ddebug_class_map_type, chooses bits/verbose, numeric/names.
- * @_base:  offset of 1st class-name, used to share 0..62 classid space
- * @classes: vals are stringified enum-vals, like DRM_UT_*
+ * @_type:  enum ddebug_class_map_type: DISJOINT - independent, LEVEL - v2>v1
+ * @_base:  reserve N classids starting at _base, to split 0..62 classid space
+ * @classes: names of the N classes.
  *
- * Defines and exports a struct ddebug_class_map whose @classes are
- * used to validate a "class FOO .." >control command on the module
+ * This tells dyndbg what classids the module is using, by mapping
+ * names onto them.  This qualifies "class NAME" >controls on the
+ * defining module, ignoring unknown names.
+ *
+ * The @classes also name the bits 0.. in any CLASSMAP_PARAM referring
+ * to the classmap.
  */
 #define __DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
@@ -131,9 +138,9 @@ struct ddebug_class_user {
  * DYNDBG_CLASSMAP_USE - refer to a classmap, DEFINEd elsewhere.
  * @_var: name of the exported classmap var
  *
- * This registers a module's use of another module's classmap defn, so
- * dyndbg can authorize "class DRM_CORE ..." >control commands upon
- * this module.
+ * This tells dyndbg that the module has prdbgs with classids defined
+ * in the named classmap.  This qualifies "class NAME" >controls on
+ * the user module, ignoring unknown names.
  */
 #define DYNDBG_CLASSMAP_USE(_var)					\
 	DYNDBG_CLASSMAP_USE_(_var, __UNIQUE_ID(ddebug_class_user))
@@ -165,27 +172,30 @@ struct ddebug_class_param {
 };
 
 /**
- * DYNDBG_CLASSMAP_PARAM - wrap a dyndbg-classmap with a controlling sys-param
- * @_name  sysfs node name
- * @_var   name of the struct classmap var defining the controlled classes
- * @_flags flags to be toggled, typically just 'p'
+ * DYNDBG_CLASSMAP_PARAM - control a ddebug-classmap from a sys-param
+ * @_name:  sysfs node name
+ * @_var:   name of the classmap var defining the controlled classes/bits
+ * @_flags: flags to be toggled, typically just 'p'
  *
  * Creates a sysfs-param to control the classes defined by the
- * classmap.  Keeps bits in a private/static
+ * exported classmap, with bits 0..N-1 mapped to the classes named.
+ * This version keeps class-state in a private long int.
  */
 #define DYNDBG_CLASSMAP_PARAM(_name, _var, _flags)			\
 	static unsigned long _name##_bvec;				\
 	__DYNDBG_CLASSMAP_PARAM(_name, _name##_bvec, _var, _flags)
 
 /**
- * DYNDBG_CLASSMAP_PARAM_REF - wrap a dyndbg-classmap with a controlling sys-param
- * @_name  sysfs node name
- * @_bits  name of the module's unsigned long bit-vector, ex: __drm_debug
- * @_var   name of the struct classmap var defining the controlled classes
- * @_flags flags to be toggled, typically just 'p'
+ * DYNDBG_CLASSMAP_PARAM_REF - wrap a classmap with a controlling sys-param
+ * @_name:  sysfs node name
+ * @_bits:  name of the module's unsigned long bit-vector, ex: __drm_debug
+ * @_var:   name of the (exported) classmap var defining the classes/bits
+ * @_flags: flags to be toggled, typically just 'p'
  *
- * Creates a sysfs-param to control the classmap, keeping bitvec in user @_bits.
- * This lets drm use __drm_debug elsewhere too.
+ * Creates a sysfs-param to control the classes defined by the
+ * exported clasmap, with bits 0..N-1 mapped to the classes named.
+ * This version keeps class-state in user @_bits.  This lets drm check
+ * __drm_debug elsewhere too.
  */
 #define DYNDBG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)		\
 	__DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
-- 
2.45.2


