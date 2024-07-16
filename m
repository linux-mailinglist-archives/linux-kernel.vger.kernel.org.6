Return-Path: <linux-kernel+bounces-254272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD8933150
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0CC1F23071
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C911A08AF;
	Tue, 16 Jul 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU6+WbcH"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988371A3BDB;
	Tue, 16 Jul 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156331; cv=none; b=PynkcuXwZntRABXiJUuQnKQ24wfKCruhdQoiJPszwwMPiHq0mcnbN6BHJa1ohsdxwDwRwQOaLKWEwkDk2HWuJVIyLjlCtFHOvLwR8q3fE6u5Kq2frvh7nsohc3RV2KNJBVHp2FMQRho+iEeaOyxokIW4b5MmmY6jBehsTfZbhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156331; c=relaxed/simple;
	bh=BW4pO7uYwWxn0ojsfglU05J91bpCDuylVWspoKc2hXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIBH1Dhvn5NYwPZLArBfQTTQVAHy7MaOlFFX3FpuUCKtaNx33vueXmQGCMi31TpWUfVK3nOAbNKDLaEbtX6pvrxNjlRy3bG9MyDAVqUfZNsWRE8+qbMcwHBEMhsU0UgEnemua6RB9Ps7JOPxJ2Oi+LE8PlzgPX5QCKkEvOSwT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU6+WbcH; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-383dfcd8cdfso574975ab.1;
        Tue, 16 Jul 2024 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156328; x=1721761128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkFYDr1/VaUp9nR5GtDe+QedLaRcp6UcXGPB2Rd9f4k=;
        b=XU6+WbcHLcZt/bsYSFqoJTP/NqUS420SKFkbwPZEVHFikkF1g6vw8Bw08oHFWbXzuL
         xYoX/FmpnofxVWcaTAa9HgJKtPwBEZtYE2GZVawF2ycAP2kZCmdOt7V2iwLxO0HYdY5H
         YnK2aGm/I08MXlKFa3qr2wn2gm/4zYW/tWNogkPXu3Cf/WHo0/hKexJ9STe8m3oLocWg
         h6SsnlvOyT7UW4Qr99Px0ZxOx22XZ9vHw7sl4rgfYD1V1na7mb1TmsseXE4VqHdzZyYY
         0RbTEX3ew9GBG/h01iIPhRHdsftyh6kXFpxLvNJzfzJopZ6Zgxn60aM0eEHPy4M8SVhe
         T+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156328; x=1721761128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkFYDr1/VaUp9nR5GtDe+QedLaRcp6UcXGPB2Rd9f4k=;
        b=H3l7COfOjJmejZBWGHAR2vWC5ZK69nrEhM9ePwZI+ZUI7bs2UQnjo/YRGuukzUXNYg
         RmO/+KeN0AjIklbff2ODk76nnkGu43uNtXChE1EJ2JO8x0zRLH1aJkiMSLlCxG4WTOG+
         2nSLkNGS3rOh8gPq5UVqxMu7KvWoXs+XxpXY93XzDxM/CVpthKmwYdkh9aBO00p/Z5RW
         LMV9yZlBkFK0vyrZJpienbPoMp6GosSvQe6h2t3a65MEwDox7AzRJZPotJV1b9TSMYtU
         IcGC/HN4d3loNli8lPi3d5moJceUnwgayILTaxFO4IJn/sP1aQYkT+ke+x375b727gJi
         446g==
X-Forwarded-Encrypted: i=1; AJvYcCVJiSrRHnwOusyJXTbNEk1CYOGWcHAk2cVXpPwVJcpkxitAorVc1dvWTfx90IN2RKcjKHvmQy0U0Kvn37k6nHugYfKZ0erXZHdx
X-Gm-Message-State: AOJu0Yz0CnrXwCJGuFpX77vXk03zYHBcJBMLtkpD+uVSpThLWPC92mwc
	2TshSBzEQeC0hCSPyNIZr/b8vHtMDyXQW1C+qBeNbVz9SLMJ7bStHc4eo2ST
X-Google-Smtp-Source: AGHT+IEDXU829hTYXjpQpLIXYUbB2ymJ2g2HpirLkcPY0d/I9d3Q+7hGqbny6/SZBNd7qQlx61Y+GQ==
X-Received: by 2002:a05:6602:154a:b0:804:c529:8601 with SMTP id ca18e2360f4ac-816c2dfb0e5mr47126939f.3.1721156328275;
        Tue, 16 Jul 2024 11:58:48 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:47 -0700 (PDT)
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
Subject: [PATCH v9-resend 18/54] dyndbg-doc: add classmap info to howto
Date: Tue, 16 Jul 2024 12:57:30 -0600
Message-ID: <20240716185806.1572048-19-jim.cromie@gmail.com>
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


