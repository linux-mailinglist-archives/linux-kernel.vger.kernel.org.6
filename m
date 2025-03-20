Return-Path: <linux-kernel+bounces-570204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F4A6ADD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B82189168B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2022C331;
	Thu, 20 Mar 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZWGYZjJ"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E622B8AC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496799; cv=none; b=U3++CMBuFyB2Pnr3iC7X2OBAzRGIjNEH/2L/MjjZ/ERha1aEVz4C7Xrgt61N7r4ECd5asYkz/Bqj7/WcX0nRsZDASOgMQcG6VsSoaoOyioImrqhJV4DMRy0gvW0kUkt+bCZ+t1LXlVAFiK15I90LgnMpJR1okfjEgt7sgTnxgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496799; c=relaxed/simple;
	bh=UXC15kbZCaTco50epMVCElx0nBgn4V0FD6B3mqO6Z2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSq7uChaej4tMYXN6l8putBeLVEGEKm4szNzIasPwpodObJ6aXeLcGV8tXFo1w4tVuA/W6p5boJZJj5g+6yTbcsvMIV/HnOyDUZ4amBfsih+isxm2e515jP4CYoEcUZ7TzrrOTyP7oUYplRKFUoAH60F8w40hAMW/7oMKC7YH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZWGYZjJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85dac9728cdso28591739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496797; x=1743101597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMU0x5TrIGi1TlXMZD5rXGa9j1LnP0o62QpnxxI3Tyc=;
        b=nZWGYZjJQKH7V/zvDmxlqs9c1tNqksr75PJqeqbF2ZMSOg/n3QV9zbA5qmTMYDyAgx
         +tv5vn/7JMSaodjLIJgo/WpF0WiR9N7PL81DeaMfe+OYosZqRXWJIoZmUJHKIg0tW+XD
         PqaAUjUQs/RWKDFSST974yjydvoETBGF1FoQC8nV3n0jyLCHogVak0k9TadgPUUEUvZS
         DXeqgjRkzUPkjC64Ki2jq2TSe47SlGTtsbBsLiXM+GiM5V4esuD+ecCcfPrs13tH/moe
         V8EYcFgbNXvI3EVA5xtOUH+/IxDJhk/m9MRJcVIoCV8i1v0Eu/XOf9AbGn9Zi18fIgk4
         THlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496797; x=1743101597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMU0x5TrIGi1TlXMZD5rXGa9j1LnP0o62QpnxxI3Tyc=;
        b=SUoNZjZKZkVoSdwxHoFvr/dCFz2l+95VVVfM1Q2OgLevSu7eOf3B1o42wLmVhmwl6S
         Lq3RzZR59wPvrA4cgK0F+2h+todOaZHtKTjlvou3ZsTR5sM7s7+d1bTvpphFCOukAJ/T
         CeepA4k0j7hpofEiCu3hA3dAOaf8m70zQEdbSKF+FhR5kllI2Pvjj/Ab+XWbPQ8KbioC
         U3offUfkDmFIAlUNwgsulT4dO+vftlW1TFHxi62XZP06kcvd8R0eCFvuhm5YpkO55AtK
         4MNGOBeIAd9kAHJYqqCwjDvjRGxbAxLy9jbpbYdFfb5uEqdwDjD77wyjfNjw47kvvfWi
         TzgQ==
X-Gm-Message-State: AOJu0YynDu7USjxS4zhFtekkSW/H1LqU5WnKS9MFbHcfrWeh5ju9H/Qr
	7bL4Y36ZxIkDbnKc5v80SlTvYlj3Z2sXhgaAogZtqjIWmVvvUc/52bhx8au1
X-Gm-Gg: ASbGncsoReiVR64CZhzcQCgrValJ7uqztI9GmEcQOJ8B01Y0c+UF+TXKcWIqnOlNDzT
	wfdBzmTYOa0ig2CP+MBVZcsAqgMgTTQ+OxHIMA3u3cIb4yYwflANnZKS8rn2BlskAvBjNKl0DUD
	wD+ncxwZuK0gOUsJIzTIVwobpcESDCM3CHYJQ9fR2pQmVQM7+5AzO7P8fSelTIkDyBvlMDA3ZaN
	TpHBZ4jKxZ5R4oXXoNYlcUO7PHc8rOaOmBxi1fYb/krZs0JRMIVgZtUkkWUFi4iyHxkIcBKqI/w
	ZJdxw7rc516AbmRP4faf5iwqMgK4WM/bVuqp0ja+yAsAv31lFn2SBkIz1KJWGuARhL2DO4jAZDj
	jQsAoNMgqt5pc
X-Google-Smtp-Source: AGHT+IE5FnFrhXl2OsaLefG5e0LQc4fASL3FmWcjz9fvpoJJMFl+j0awErZ0XrOva1EzRD5jexTdnQ==
X-Received: by 2002:a05:6602:c89:b0:85d:aba6:4f4b with SMTP id ca18e2360f4ac-85e2ca388afmr47078939f.2.1742496796745;
        Thu, 20 Mar 2025 11:53:16 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:16 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 13/59] dyndbg: add 2 new _DPRINTK_FLAGS_: INCL_LOOKUP, PREFIX_CACHED
Date: Thu, 20 Mar 2025 12:51:51 -0600
Message-ID: <20250320185238.447458-14-jim.cromie@gmail.com>
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

Add _INCL_LOOKUP condition to separate +mfsl flags from +t, allowing
(after refactoring) to avoid a needless call-return.

Add a PREFIX_CACHED bit to remember that a pr-debug callsite is:

- enabled, with +p
- wants a dynamic-prefix, with _INCL_LOOKUP
- was previously called
- was thus saved in the prefix cache. NOT YET.

This allows (later) to cache part/all of the dynamic-prefix for each
pr_debug that gets called.

NOTES:

dyndbg's dynamic prefixing can get expensive; each enabled callsite's
prefix is sprintf'd into stack-mem, every time a pr_debug is called.

A cache would help, if callsites mark _DPRINTK_FLAGS_PREFIX_CACHED
after saving the prefix string.  But not yet.

-t  thread-id. not part of the "callsite" info, derived from current.
    doesn't belong in the cache. it would be wrong.
    can be done in outer: dynamic_emit_prefix()

-mfsl  module, function, source-file, line
    we cache these, composed into a sub-string.
    they are "lookups", currently to descriptor fields,.
    could be accessor macros to "compressed" tables.

All enabled together, they compose a prefix string like:

  # outer   -----inner-------------------
  "[tid] module:function:sourcfile:line: "

So this patch extracts _DPRINTK_FLAGS_INCL_LOOKUP macro out of
_DPRINTK_FLAGS_INCL_ANY macro, then redefs latter.

Next re-refactor dynamic_emit_prefix inner/outer fns accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index c388ab05a6e1..82eabaa6e827 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,11 +38,13 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
+#define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
-#define _DPRINTK_FLAGS_INCL_ANY		\
-	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
-	 _DPRINTK_FLAGS_INCL_SOURCENAME)
+#define _DPRINTK_FLAGS_INCL_LOOKUP					\
+	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |	\
+	 _DPRINTK_FLAGS_INCL_SOURCENAME | _DPRINTK_FLAGS_INCL_LINENO)
+#define _DPRINTK_FLAGS_INCL_ANY						\
+	(_DPRINTK_FLAGS_INCL_TID | _DPRINTK_FLAGS_INCL_LOOKUP)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
-- 
2.49.0


