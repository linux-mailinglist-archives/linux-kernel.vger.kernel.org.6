Return-Path: <linux-kernel+bounces-254308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F819331A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D513B21F63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBEF1AD9E6;
	Tue, 16 Jul 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUcZWYcT"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B11AD40E;
	Tue, 16 Jul 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156376; cv=none; b=pldj8hzqOpwWaXITUUpptkR4PM6IvG9DyN21Tw4FJGZZbyZTFsbdBIOMu1MFpTKxLgyTi3pwRWeqsd9VWdU0BcEPrIXemL7G1jSQn8xjLLB/bXuS+VSyQZe++ONBLRsRGevPuoLih5+aE6JjNPQNUOliMfelAUL8CwGQqoi1Lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156376; c=relaxed/simple;
	bh=AhxpBW2V1Nnpaq8GxpYUxfaMj7C/CnQkNUZprsGq5Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYAbZ/GQ6kjQrMkmLrbPLS+RoLfO7861XjPwCxezX6MkiXQSfZd2XwpB9iIigXH2nMFXiMp61Ewl+hQFWDm9dvpu9i7xgte3mv72CcXFsR2fD3iIAELRzE5TMLwqDUHdNJKPvwodAz/LGfpeiHOyVxLO2cGxBfFSdwWDIOua1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUcZWYcT; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8036ce6631bso5987239f.1;
        Tue, 16 Jul 2024 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156374; x=1721761174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02GQEyQ8Fgm4yEF+9D4Fm23zLJa07LslS1GKZkXapgQ=;
        b=MUcZWYcTh1pNdJxMKvF5QFuqTKPpRcpZIl2uMB5aA0nNkQln3hrASw6yGX5IShjxsw
         KhSgTtcrBkh6dQYN8S0AWdi3SoiIJH2BDkJLFUVujJj1MpvM1zHftpfPc8QW2/iE8Hpo
         BM7SaCs0nlFQqlKqnhLcC6z/yCAZ/tRC6fI5OUpS3jTkvvzVhgODehMcCgg1h9wo2wud
         I+X8SnOBR5YhYzU+ohEeHouOvCe8J4b4w8qpf3yhqYM9Z72ZS5v9Lan44imhokC0o2ql
         u2yU/oImS0/YL4cPB3+R7qyvxB/HWXq/0XEQthfgr9R46gt1avVzoTjYrVFRx2A9q5Ek
         chew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156374; x=1721761174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02GQEyQ8Fgm4yEF+9D4Fm23zLJa07LslS1GKZkXapgQ=;
        b=vmI3e1u2F4f6vCiQw4Bc2RK9IUZcNEDOT5oeX6WMbqN3RtdJ+yMF2s2MBsoLwQN5P7
         QMfPJ56XJyK80MyLcOTRqmEr6UllrKTRt7ACNAZ+Ce/C4/2XXt9awMbuhwpCELRDYY7H
         HIM41mxzobklnIa9sa/zFO2bJ2cUXgit8EhDIsJ8L5bpX8+6t3VW3XSuGKixoy6UUVte
         cEnB9OoIFsQ6F7Nj4ED5WBFXFQ9Djm8A4s+PfKn1kHADPV4ocF/jDoDx/g1P8+Q5BmAx
         emYGvqv6xUq9h+bdf8r/l4u/84wSSsmxAxf73fzSzqAOqNlFkN7J4T3x7D8RtT594/uE
         z0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWKW6PotlVA/DfjcKwvgTXN18ClEyNc3YolvahZSXi6pLctFTokclLPqi564/CXV0GZOhgynhiVsryrAAEEwVMLkoaOkKSgAP9N
X-Gm-Message-State: AOJu0YxV7yVejnF+Nq0N+/mt7kwwjFlho1XxxNRl7Lx257PderZ0/HrJ
	AOEiwDw9VNsFchh9caeFPZDJfVGULJhl1gR/N0Z5RtIrq8laQYlLhgrBAz+x
X-Google-Smtp-Source: AGHT+IH2P7UQSoQkuUq22B0bjuKA/ngzw01JbZNtKHx44WAJD4WRstjL+48jrY+j0JQqgWF+0C1c2g==
X-Received: by 2002:a05:6602:1548:b0:804:f2be:ee21 with SMTP id ca18e2360f4ac-816c2c0d633mr43164039f.3.1721156373964;
        Tue, 16 Jul 2024 11:59:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:33 -0700 (PDT)
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
Subject: [PATCH v9-resend 54/54] docs-dyndbg: improve howto classmaps api section
Date: Tue, 16 Jul 2024 12:58:06 -0600
Message-ID: <20240716185806.1572048-55-jim.cromie@gmail.com>
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

reword the classmaps-api section to better explain how it supports
DRM, and (a little bit) to steer clear of designated-inits in the
_DEFINE description.

probably just squash this back in

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 64 +++++++++++--------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index ccf3704f2143..1ffab6be07fc 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -390,42 +390,56 @@ in case ``prefix_str`` is built dynamically.
 Dynamic Debug classmaps
 =======================
 
-Dyndbg allows selection/grouping of *prdbg* callsites using structural
-info: module, file, function, line.  Classmaps allow authors to add
-their own domain-oriented groupings using class-names.  Classmaps are
-exported, so they referencable from other modules.
+Classmaps adds the "class" keyword, which selects prdbgs based on
+author supplied, domain-oriented names; this complements the code
+organizational keywords: module, file, function, line.
+
+The main difference from the others: class'd prdbgs must be named to
+be changed.  This protects them from generic overwrite:
+
+  # IOW this cannot undo any DRM.debug settings
+  :#> ddcmd -p
+
+So each class must be enabled individually (no wildcards):
 
-  # enable classes individually
   :#> ddcmd class DRM_UT_CORE +p
   :#> ddcmd class DRM_UT_KMS +p
   # or more selectively
   :#> ddcmd class DRM_UT_CORE module drm +p
 
-The "class FOO" syntax protects class'd prdbgs from generic overwrite::
-
-  # IOW this doesn't wipe any DRM.debug settings
-  :#> ddcmd -p
+Or the legacy/normal (convenient) way:
 
-To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates all
-classes in a classmap, mapping param-bits 0..N onto the classes:
-DRM_UT_<*> for the DRM use-case.
+  :#> echo 0x1ff > /sys/module/drm/parameters/debug
 
 Dynamic Debug Classmap API
 ==========================
 
-DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, naming
-each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
-type, and mapping the class-names to consecutive _class_ids.
+The classmap API is closely modeled on DRM, which has:
+
+enum drm_debug_category: DRM_UT_* // 10 independent categories. 
+dyndbg's .classid encodes that directly, allowing 0..62 classes
+
+DRM has ~5k calls like: drm_dbg(DRM_UT_KMS, "kms msg");
+these are unchanged, even in argtype, since classid === category.
+
+DRM controls the classes together via sysfs; bits 0..9 control the
+classes independently.
+
+Its expected that other classmap users will also provide debug-macros
+using an enum-defined categorization scheme like DRM's, and dyndbg can
+be adapted under them similarly.
+
+DYNDBG_CLASSMAP_DEFINE(var,type,_base,classnames) - this maps
+classnames onto class-ids starting at _base, it also maps the
+names onto CLASSMAP_PARAM bits 0..N.
 
-By doing so, modules tell dyndbg that they have prdbgs with those
-class_ids, and they authorize dyndbg to accept "class FOO" for the
-module defining the classmap, and its contained classnames.
+DYNDBG_CLASSMAP_USE(var) - modules call this to refer to the var
+_DEFINEd elsewhere (and exported).
 
-DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP that
-drm DEFINEs.  This shares the classmap definition, and authorizes
-dyndbg to apply changes to the user module's class'd pr_debugs.  It
-also tells dyndbg how to initialize the user's prdbgs at modprobe,
-based upon the current setting of the parent's controlling param.
+Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize
+dyndbg to update those classes.  "class FOO" queries are validated
+against the classes, this finds the classid to alter; classes are not
+directly selectable by their classid.
 
 There are 2 types of classmaps:
 
@@ -436,9 +450,9 @@ DYNDBG_CLASSMAP_PARAM - modelled after module_param_cb, it refers to a
 DEFINEd classmap, and associates it to the param's data-store.  This
 state is then applied to DEFINEr and USEr modules when they're modprobed.
 
-This interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+The PARAM interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
 amongst the contained classnames; all classes are independent in the
-control parser itself.
+control parser itself; there is no implied meaning in names like "V4".
 
 Modules or module-groups (drm & drivers) can define multiple
 classmaps, as long as they share the limited 0..62 per-module-group
-- 
2.45.2


