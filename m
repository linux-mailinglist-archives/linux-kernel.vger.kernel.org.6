Return-Path: <linux-kernel+bounces-238444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3480924B10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738BA1F268FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3218B45F;
	Tue,  2 Jul 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2tjSWve"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809817DA09
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957525; cv=none; b=IV7qePR9T3wHHXPtBQByp0cFbarfmKOPF9K4TfzcS2xSR9lwMpFDFC1cB9F+mWkYgFcsh/METsbZIWEWcCgSZ31UAyJY4d7ix3EZH6/CGLKyeh6mxIIHXYYRpOIlEDwZkj3m9H4hXGT9A41yQZQqBR13ivf1YU6N1XlMU7lMLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957525; c=relaxed/simple;
	bh=K2Pt5C7+uMfFDUJDGtIwDknCNCrErFm8MnfSc8YM8c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3rLloCQftHPf9EciPNVSkPiaWXeCB04UxpcRWqX81W/Ze68DXqrxnqyLvYyM+bZ/ZO8AYlthpgimcz0uxwFwYl4RumoR6QFsCJ2kalOUM0QFJPzqIb0fKm8tVFofkj31Sh+44A+8e51rwcmFOhIdl0qVMr7Im/N/SJIA1Y4nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2tjSWve; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f38da3800aso181523139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957523; x=1720562323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXTp2HWUUrTrRl4eZ7svqhTsXgDwW8WuleRWg/xTtcY=;
        b=C2tjSWvewxr/umgzhV0pjeymWCpk37u0aTwXqFGNGpPdY3z0aLRmH+1KeWK805d3G9
         3/t75WfoiJhd+fwImqDXAqksNQ4hkwq2QR29ZU9hal2HxoLtfQwVzkVrZrVsCT45rRVj
         r3aiUXGcRKYVRdZLg3MiU1tigKCjoeckC7u1XtXavlPbfdobUhZj1DsHknzybEW5qr1k
         VG/5GH39tQstLsbN7Y1Z+AIa8yrsVl4Pe4WjPgUaXrqR7yNMxhSHs7KUyjLju1HQc3CW
         E63k1xsbm0wDXMXpRCNTDZX9bcEsr93OSHR2q0Kt9shse27HSoQ6OHiX45xUx7XYAUI5
         Cr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957523; x=1720562323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXTp2HWUUrTrRl4eZ7svqhTsXgDwW8WuleRWg/xTtcY=;
        b=FfttVBtEbnHXRFW6cCi7u0oOJ956feoGTjJoCnklpGXyd6GLE6Pai7ejiIemaLKXhz
         ZNm6b/WOmObqyPHbJqDYS5ktOCCujy+VshDxNWLd18nxiTq/rkbggZMYGFbTkHhX2Y8I
         epNkE36aPr6LWguJX5n5N6+kAZd7eaiw8hG+pX9UDQEnwrNPOhUQyZmxlMDNat6WIhow
         mSZ5VtSOUmHAmAX2UpD/mDjRxUk4DQ0p8cEHES+OpDzXFA863Zl9kwjtBeTEkDH9sFzM
         UweU6HTfDJUYPFbvW5ZsPKNZCWwdw/3JjyhGLfjQbT4MGH7riCzkaqWXTbK2PWt3cmJu
         5Owg==
X-Gm-Message-State: AOJu0YyHTHs+MV66C2wxGZWBZplYsFnhdVuYzS+RDLoV4iUTMNMyEHNB
	96UzuBYT5cqWRXjucYVhglclQiYnyZkRjwmSyjnjhza6hZ5/u0MZ
X-Google-Smtp-Source: AGHT+IFrIiyJSkf6W2TunW5BCKgPQouB2T+lSzdbM4fMP+xI9st2vbvsZqO7st8XPig5Y++ArDLzWQ==
X-Received: by 2002:a05:6602:355:b0:7f6:1dff:e364 with SMTP id ca18e2360f4ac-7f62ee02647mr1168457139f.1.1719957523053;
        Tue, 02 Jul 2024 14:58:43 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:42 -0700 (PDT)
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
Subject: [PATCH v9 23/52] docs/dyndbg: explain new delimiters: comma, percent
Date: Tue,  2 Jul 2024 15:57:13 -0600
Message-ID: <20240702215804.2201271-24-jim.cromie@gmail.com>
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

Add mention of comma and percent delimiters into the respective
paragraphs describing their equivalents: space and newline.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst        | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 742eb4230c6e..7b570f29ae98 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -73,16 +73,18 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
-Command submissions are bounded by a write() system call.
-Multiple commands can be written together, separated by ``;`` or ``\n``::
+Command submissions are bounded by a write() system call.  Multiple
+commands can be written together, separated by ``%``, ``;`` or ``\n``::
 
-  :#> ddcmd "func pnpacpi_get_resources +p; func pnp_assign_mem +p"
+  :#> ddcmd func foo +p % func bar +p
+  :#> ddcmd func foo +p \; func bar +p
   :#> ddcmd <<"EOC"
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
@@ -104,7 +106,6 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
@@ -128,7 +129,6 @@ keywords are:::
   ``line-range`` cannot contain space, e.g.
   "1-30" is valid range but "1 - 30" is not.
 
-
 The meanings of each keyword are:
 
 func
@@ -153,9 +153,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
+
+    Examples::
 
-	module sunrpc
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
-- 
2.45.2


