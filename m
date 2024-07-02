Return-Path: <linux-kernel+bounces-238439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DC924B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580191F25418
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ADB18324F;
	Tue,  2 Jul 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBFrM+oq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2717DA22;
	Tue,  2 Jul 2024 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957519; cv=none; b=WFt51S0BK5QG+mAlhVpSAdeD+s2P3LBMbMsYPqz01mgCSTAmmyEz2x0C1fC/0TaU6UCgdcxzZKYFHX0Dl8f3DONv6+SLQh+5WWeNGdD5jRIlup9ZALUb3DPsmJtvQWMy87ch91O/TPw+Zo3fa1xCcFOWof5pyh2AXEenE3tyw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957519; c=relaxed/simple;
	bh=BW4pO7uYwWxn0ojsfglU05J91bpCDuylVWspoKc2hXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr4/dJdnXQ7XExKLcp0f0LFIhONeI2NHPB7gPA0l4waPuTB4ed84y2rwpjCx9Z9Zp+x/ruILeEVygj86IIAPSSJu6g97jSzi5Jrdo0YwTdCHtWaGBB1ZMxW2DZ+cC8CLFR5GtcUNXaYloPc6VVaJx7kcSZDaR4bP5waR0h1AOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBFrM+oq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f3d884e70bso237612039f.3;
        Tue, 02 Jul 2024 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957517; x=1720562317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkFYDr1/VaUp9nR5GtDe+QedLaRcp6UcXGPB2Rd9f4k=;
        b=aBFrM+oqYgM89FB4oWMiwIVd0vonjcj6j78KDq7E8mZeNyf1JdJaOTOp6cOD2pvjcG
         qJo9+tR9akqJ+mKf2m4BJM3Cw64ccWlQfuu9ZnM1rLayMZe+y2fBTAbgFkrF/0IJ9vcV
         eZBLTzPoYv93VhxW/CbJyRalF9pcH07+ze8He46SPmaX6onEPMFjU4dWVdaGlMyGIXAe
         FG3CpM4KScitmhc1crsg/nI8gfu3QqinXgE0bgcSpMjetCP+y+dUkS74gQcobZVNocA5
         B9i5ZQXWz58qm/BtIItK+DjZDrxpcO7/E94wQBU583q13WCTwwr16DFVTxop33yXq7sP
         UcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957517; x=1720562317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkFYDr1/VaUp9nR5GtDe+QedLaRcp6UcXGPB2Rd9f4k=;
        b=nzcqHBl9z8s7nXnKAraL5o9EO+k38s9IsqagokGr5UnJnmR8QLGnfRJrLsPJDnxcsu
         zyvAe+ZVqDdYPLGocegfEhU6SetiMjXVR2LfhlBtk6A8ClU8QqIzd2EGY/ZM6JXisML9
         FzIkMrgXC6fdA8VmUxOKBL7l94INpyPm4eo4dAU8fZb8JG/9RUYyWJ4rv4KmjAgnC/se
         ++A0d9K0O4nCzpEUO50oBB61eCG03MVJAYQwmZ2Dms0FQb2rhg6jRfwY8gIB8c0TPizJ
         6OoaQ4CB43ZLJtKY5JqWjiEvNZ2cjp1u+G/x2P7noezhNQFJERLN+0zfpptDQPqxdCl5
         TvwA==
X-Forwarded-Encrypted: i=1; AJvYcCUOg1l7uxwRnD8WpMIRDcXqYr17AMAOz9CvVsFQq594hZlp8qha7hm4FnjxVIvoQOhaLP82OXvM9UJyQhNJl94DRoX2A2IMAvYg
X-Gm-Message-State: AOJu0Ywo9451ITIdefKu3By7V9dVOw6LNDi48zJAPwbKeWrCfpTs2Ako
	YJaIZfpHnKZTvfu0rvL/mXyWmP2/TXv5qgNvIxciwcIZntH07jDb
X-Google-Smtp-Source: AGHT+IHrYge+G9SxEL7voNd3XWXoqJIq9/3lBcjxHvh2FJylH832o2Rfwee+jZnNxzuJYbl2IZHY9Q==
X-Received: by 2002:a05:6602:355:b0:7f6:1dff:e364 with SMTP id ca18e2360f4ac-7f62ee02647mr1168440039f.1.1719957516607;
        Tue, 02 Jul 2024 14:58:36 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:36 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v9 18/52] dyndbg-doc: add classmap info to howto
Date: Tue,  2 Jul 2024 15:57:08 -0600
Message-ID: <20240702215804.2201271-19-jim.cromie@gmail.com>
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
2.45.2


