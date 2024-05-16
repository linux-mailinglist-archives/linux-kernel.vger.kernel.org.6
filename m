Return-Path: <linux-kernel+bounces-181406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562518C7B97
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797881C21497
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD9159204;
	Thu, 16 May 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2s9qS9s"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43585159917
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881509; cv=none; b=fL6AP3N8HCwPE7jyh8qK6E6mydhztvCmHf8vnwSXtoP+BwIR3IIJ6vGk3ShjeDKLDfg65IjWMn947w88OV331hk1vZIlZYyPwYZ9S/cvXq5t1hRKw7W8vVEySK0tVHZ4yMhD3lIT5K5D4x+4RHPA4UKTYGFP+B84DtGQb1Z0fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881509; c=relaxed/simple;
	bh=wyt5TeuMHVxw0kvBQCXwTOsU2/UU1RQiOPIBUMKdca0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB5X0Jmd/gy235IGakWqJoikwKWsCNRee6t8mGC0mJixM0eExrBFUQQ1WSls14lhdM3MU39vXWOzMnR12RVkMxjGr3mBzDsEJ6vEXMKrCIQK4cOOdBrC2Lmg+FhPORF1BaVkOVuyxOs94gjFbJoEhMyaerC892MSVxlZ9Mh3IMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2s9qS9s; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e1e06c9a10so67248239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881506; x=1716486306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6B0otVk+eOeb6hk65r7u/cdtYXtppvakvgUuU81roA=;
        b=R2s9qS9sF8HcsXfbEuFi44o3qK7+zHrBtqML5CNsQhK6MniDuazdbjBXMqwIDowekk
         DMIgFybVgoTnRIFhe3rUvI0PP0iBhO/3V8VoSFNlyEqoBk+Hr7oEFxkZZxOBvB0cTYLY
         /BNQ1JMC3Q8nNOjnCj+SX51g5c4DBFpVqCU1pn23Z+edHchbiHCTldDsFto0A5fk4Ks2
         iUJriNgIg5eU1yrZGvDC0/AWQ7yNJNTojIjkc9pZSz9NVQbS2UcLnB5hK5ayEmEuZpdI
         MtO2dEjEVSRfWAf1H2PXBpep6YJaxiRrCUfmnUY4nezuhWIQOxhiPO2fSvTIVCTLSAqI
         VMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881506; x=1716486306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6B0otVk+eOeb6hk65r7u/cdtYXtppvakvgUuU81roA=;
        b=DaVRsfr/0OuFlwJWzKBpfreB1DrAXDzMcWodLxmKHI8muXSTMN1cfY5i/KPG8Jp4wu
         /hYusVBBTMY13Kt7yByd9lEE3lMaDbnusx643GuXxCkTc6BisFz0pIzDHVxjGeQ+NO4t
         dx2DZNtxJ5dZHAuJ+W02I1m6iyLCZmJRcC4HnIvkOk6MJVpKz8KXp1FFSapybFbGS1+X
         pY5yZUfMjW1mC42Y5FrPVoLfig7mK7P7xzThHGLt34B8HLddxNOa30kD0pYVB8JMZIoZ
         /PPzz8RYj4ylbDVkll152syLLf0NZ7SMy6SsXvesEItzUiycB74gRUUrnXOu5+R5HlyI
         XCow==
X-Forwarded-Encrypted: i=1; AJvYcCUwQCrYZ4R+awcbSTYoi7kIrYGYAHVXjtAzSHFP4SLCX2JY1LyPLjFBTead2m71/8TLLhwC3cSvInU+p5MmMDNF2Bq00I5O4kfp9uue
X-Gm-Message-State: AOJu0YyVwe83KcAsG+zUoDtxq22cSzWOu+G66guya+TttHXLvgwhl9XH
	I37xhiEd0SsEgLiHINQ9sAlQgaW+Tv7khcXb3mVmxOdvGuBnQjJF
X-Google-Smtp-Source: AGHT+IFfNKxOu0YMJf8LIdPkkjzcglQuoJNP/OgNxbJXyxVYC2axWflxm1HjwNIxuW2cTmt4VSSykg==
X-Received: by 2002:a05:6e02:1543:b0:36b:26df:ccec with SMTP id e9e14a558f8ab-36cc1447afemr229618225ab.16.1715881506442;
        Thu, 16 May 2024 10:45:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:06 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 24/33] docs/dyndbg: explain new delimiters: comma, percent
Date: Thu, 16 May 2024 11:43:48 -0600
Message-ID: <20240516174357.26755-25-jim.cromie@gmail.com>
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
2.45.0


