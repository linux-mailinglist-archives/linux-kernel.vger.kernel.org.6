Return-Path: <linux-kernel+bounces-570224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D04A6ADF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B200B485A35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F48230BFC;
	Thu, 20 Mar 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0GUwDxd"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7682327A3;
	Thu, 20 Mar 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496824; cv=none; b=ajeRnTRbbb16lC1G478/wG+Mt7rg7JPDuqAHsuFjlGOOcgucJkp9s0ExpTlgBR4dLHHshMaG54DiiHYSL8tJf7a5lTn6COZBAgbxfghy7aVZHW2anf8jqgAR8hGY+fOktivb/j51mLGqS9ORUbfuZpkbgl99QEdq55sHR1VqlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496824; c=relaxed/simple;
	bh=aJ/D7usPSlAaXa5RYkYp2EWZZhosXbZpnA7cfZLfreo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW/6RsRFHwUOGk75SGhnrzPmVVPPMTpXJ8GduNbfiOk78wsSG3YNzh2Sww5pfGmDyGcI24ES7/lh4gnivGvpob6+/5EWta2IJzSPDnQJS4uDzObWXWa4xBuDMBGbQXF5o5Sc+tU0PQOdPfgoSnqrd6bHfwNyyN50p3Ed2yzCUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0GUwDxd; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85ae131983eso125344139f.0;
        Thu, 20 Mar 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496821; x=1743101621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiJ7Gpr92Q6ANZI0grpR2HAyoakBNuE25K03SLq7bv0=;
        b=S0GUwDxdja4ha7Ng3au5L/LBEGKij+P5GSaPlVpmsFLGOaMA9dDOc7iriuVJ/1oes4
         ssB4kIconloMUoPzaS9nNzVB5tEdIFHvqHxXlIeCBMrofacI564vd497gRpaRt7aR5UW
         wjR2hOhLPu/4bVWfNskrjr9K2XyRbEijP1eufmi0Lx0UtBuxrFwScEPjzeqc4L1duFZD
         FNQLe0fsSTHnytSe/pHDfrDTy+FfgaIVBu0dB9akeBoFPDKg+KrGK5U6lzlCIEm52iir
         oqTkZcacmh8Qeq6Tos3JOeKhGnLEMPZvokYZG4gxBBHL4JEyvK5aPGe/Sw8Rt8devr/G
         GUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496821; x=1743101621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiJ7Gpr92Q6ANZI0grpR2HAyoakBNuE25K03SLq7bv0=;
        b=qqHegNijUQti62qz59zzSU8X5UoDBt5ZKeBB5dHZ5SkqQJzejbSNoQ5EhGCDdcvOd3
         vcqiLRMqR7rj3sOd3Ss/tPUWFbbnmVfYYUhaAV2OkcRHqfrxvxNMUCLcgLOmfz6UJivz
         W0TqRS8Avp3hFiZvKd2ownzWZnN51kMJn2joPznQpPxatx3dr4NePVdCHQZpHx38CLxD
         UfAfHwswwZ9KhAqLOJwcT2fr43f+2p/fmJ/R8ENwtEamQhZKPNinUcSpMqWuo3NHo+Ba
         H3MNF3/GAcqbkFrdH6p2KrvODkdrC9ivmxluQc8EOv+jRsFqNiUjsQnu/VGnrz2JXwvc
         6cbg==
X-Forwarded-Encrypted: i=1; AJvYcCWCqNRQ/113FU+QlkJPVX39oP2gHSa5FgoXHUNH1zjz7YcZSGQhMrUcWZjROTR8APxCZVwlvxxhUrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz017dmJlcgFaSM+s3tnJxlk0Ars2qJQipXhFrieqqCtB1oKwe3
	YXpeYjGyIMVWYO63O4LzhjD0PWrkalQgW4DOmPqavf4vHh4CjkRnGI0SKTDp
X-Gm-Gg: ASbGncv2pNNWq/ayHVFpt9Oh+5OMLtjDqoH546dZEnI7Wj/uOh1cwVG6uaRvE9IlNXM
	b+0J9aOpvLnAZVdBHmCUVOh0Cq1aCQHRMUsEOa4ZI3YCsGTTNhNt81qUmRjC1onGcFc+nS8aoWq
	Bpfov5BPD1JbaUTQ0jy+J3ZtFL8WQwrDihPzYyYS/9T18aLC36mzpf2rM9hN7xODCnMFVP632S+
	31X+U7Gg+F5rhzjJTu7yzARR6Fnhe5zwl5hcvUYoYcgDOTDedEFxfglqGWaH2u6Frn/AeJuzlhJ
	cs2LsPwrFX7lf0Pae351RAzwRhnX4sA9mt2Z64VDJhxlIUmnaFrXb8iZL0hRkR2eooJLUTlAulF
	AbA==
X-Google-Smtp-Source: AGHT+IH4i8LbvrmrRpjy8J+JJRVU0+1Vb1Ug4cLDBgaSWuZTQzWXN+4Vhhh5tVc2tWWaiXCHMDRfQg==
X-Received: by 2002:a05:6602:3786:b0:85b:5869:b5b with SMTP id ca18e2360f4ac-85e2ca899f5mr52693339f.6.1742496821278;
        Thu, 20 Mar 2025 11:53:41 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:40 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 33/59] docs/dyndbg: add classmap info to howto (TBD)
Date: Thu, 20 Mar 2025 12:52:11 -0600
Message-ID: <20250320185238.447458-34-jim.cromie@gmail.com>
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

Describe the 3 API macros providing dynamic_debug's classmaps

DYNDBG_CLASSMAP_DEFINE - create & export a classmap
DYNDBG_CLASSMAP_USE    - refer to exported map
DYNDBG_CLASSMAP_PARAM  - bind control param to the classmap
DYNDBG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

TBD: some of this might be over-specification, or just over-talked.

NB: The _DEFINE & _USE model makes the user dependent on the definer,
just like EXPORT_SYMBOL(__drm_debug) already does.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5 adjustments per Randy Dunlap
v7 checkpatch fixes
v8 more
v9 rewords
---
 .../admin-guide/dynamic-debug-howto.rst       | 80 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index d2928884c92b..9422dc4917d0 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -243,7 +243,6 @@ the ``p`` flag has meaning, other flags are ignored.
 Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-fslmpt``.
 
-
 Debug messages during Boot Process
 ==================================
 
@@ -393,3 +392,82 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+Dynamic Debug classmaps
+=======================
+
+The "class" keyword selects prdbgs based on author supplied,
+domain-oriented names.  This complements the nested-scope keywords:
+module, file, function, line.
+
+The main difference from the others: class'd prdbgs must be named to
+be changed.  This protects them from generic overwrite:
+
+  # IOW this cannot undo any DRM.debug settings
+  :#> ddcmd -p
+
+So each class must be enabled individually (no wildcards):
+
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+Or the legacy/normal (more convenient) way:
+
+  :#> echo 0x1ff > /sys/module/drm/parameters/debug
+
+Dynamic Debug Classmap API
+==========================
+
+DRM.debug is built upon:
+  ~23 macros, all passing a DRM_UT_* constant as arg-1.
+  ~5000 calls to them, across drivers/gpu/drm/*
+  bits in /sys/module/drm/parameters/debug control all DRM_UT_* together
+
+The const short ints are good for optimizing compilers; a classmaps
+design goal was to keep that.  So basically .classid === category.
+
+And since prdbgs are cataloged with just a DRM_UT_* to identify them,
+the "class" keyword maps known classnames to those reserved IDs, and
+by explicitly requiring "class FOO" in queries, we protect FOO class'd
+debugs from overwrite by generic queries.
+
+Its expected that other classmap users will also provide debug-macros
+using an enum-defined categorization scheme like DRM's, and dyndbg can
+be adapted under them similarly.
+
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(var,type,_base,classnames) - this maps
+classnames onto class-ids consecutively, starting at _base, it also
+maps the names onto CLASSMAP_PARAM bits 0..N.
+
+DYNAMIC_DEBUG_CLASSMAP_USE(var) - modules call this to refer to the
+var _DEFINEd elsewhere (and exported).
+
+Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize
+dyndbg to update those classes.  "class FOO" queries are validated
+against the classes, this finds the classid to alter; classes are not
+directly selectable by their classid.
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM - modelled after module_param_cb, it
+refers to a DEFINEd classmap, and associates it to the param's
+data-store.  This state is then applied to DEFINEr and USEr modules
+when they're modprobed.
+
+The PARAM interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+amongst the contained classnames; all classes are independent in the
+control parser itself; there is no implied meaning in names like "V4".
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
2.49.0


