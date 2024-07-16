Return-Path: <linux-kernel+bounces-254277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C05933163
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94D9283891
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9C1A83A9;
	Tue, 16 Jul 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feHEnsqV"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D981A08BA;
	Tue, 16 Jul 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156337; cv=none; b=gato61mD9/sWpn+0ilyKiH1b85+j5KxIF96ifN3BqmNSmkNLVllL6QPfQsFMGrofoGZTpTXVL5QAeiNcEiqiPBlBXpusbaKJ+OSCLymZdHqocX+KlE+hfcqUHVxKwLkFF6tOYhfg9ygPikGTF6E6+xmMMsvRXfsACdIn+JsvkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156337; c=relaxed/simple;
	bh=K2Pt5C7+uMfFDUJDGtIwDknCNCrErFm8MnfSc8YM8c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELwk79WNEnfj6+BboyG4LnJmdAJvs29xRZdPJHysLaSIKx62XsZFIF6B/N2ZneISbNaVi36amp6UTsr9aOTf6WD2UKUVll6JoF3PI7NUwJeSzR98UYrtbk0SQ3/U8eiz5dqBTr0Dxpf5Jajr3p2Vuh9+KCXjavLQ81fjk8+lw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feHEnsqV; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f70a708f54so6553039f.3;
        Tue, 16 Jul 2024 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156335; x=1721761135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXTp2HWUUrTrRl4eZ7svqhTsXgDwW8WuleRWg/xTtcY=;
        b=feHEnsqVk9VfNpf76r6EHMyHqLPlzH3cjQOgbgsRx9Nt40Owjl9KQ4xoOdQwICHWEQ
         bGbn4Fd/k96xRChq/sVLw3LRvLvUfUMhUJvUD/FObW2zgd04nM1Rcm7NgD2l+B4Sys9t
         HXgl9ZTEeGpFWC9XvQPCZZgOrLtMjbFBmxl9QIKDcuzJQe6tf8TGs8VlY4/oGBlo7CSI
         3irIrrRGmYpf5PySFc6A/0T6vAnBKRuz8KyoiHpCJjrlRZBqFGFaU1D6eXOmgvhtK0W0
         QJDy+5rA7xcAUaZH4mzhj0VNQU1mNBgngtcR5JrTTqUwR+7w/xTB/kcMEmLUydN9ggRX
         98QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156335; x=1721761135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXTp2HWUUrTrRl4eZ7svqhTsXgDwW8WuleRWg/xTtcY=;
        b=eP1LZKk0S+aQqv70nldoNoHSvLYrNzDzIKw4eAgMsP0VX1IEVS3LsZxD3u4wIu7sLZ
         NygttvkEWgluO9FzUpkyroW0xU2o+cpCCLQ4TNAtuoNaskNA02wfJQ85DV8zqOVSByYW
         mLwBbp18bIRt2ei1Zebnvhhf+S+wUzR0YXFWTjq3nlbxBahQtg+xqGvxdUwGyFi5o61d
         9am2+Rb6ZuHbtVUL+9SWWD1phZMRvMRRw7rJXtk/RqJLH7JZENOVFJYR+Rpcd5nSW9QO
         u81kSNN/5wD9yocDx9H9TpoGB6flqo5rbsrsOtTeLXQLprpicK0UsRC8NaUeGr3A+EgY
         qUbg==
X-Forwarded-Encrypted: i=1; AJvYcCWibw2EgStbPDT5qRtUdRNtFIHnGAwnyk/yt/4VPO6MXlpPzOz2mHs45TZBOFHx0AOykTVLjwdewKPLVcPjjoH1PfRch7fOooUO
X-Gm-Message-State: AOJu0Yxuc9l/+rbmEUDr+d0yz7HPBUd46V+p0EhUGHOUR5GuvkDYXQsF
	qi5rIxcPHxPLF1ixy1u3UZit4IHQbc30JIcxynhYOaXuQh2NdFlLw4e/UIdl
X-Google-Smtp-Source: AGHT+IH2C/cO4EXdioXS3mRKkhPmm4/Juz5I1U0b++x+rWSnGrySgsdsPc6Js5tCOzBXgxSZ2aDSeA==
X-Received: by 2002:a05:6602:3ce:b0:7fb:790c:a317 with SMTP id ca18e2360f4ac-816c32c9ademr47925339f.6.1721156334626;
        Tue, 16 Jul 2024 11:58:54 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:54 -0700 (PDT)
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
Subject: [PATCH v9-resend 23/54] docs/dyndbg: explain new delimiters: comma, percent
Date: Tue, 16 Jul 2024 12:57:35 -0600
Message-ID: <20240716185806.1572048-24-jim.cromie@gmail.com>
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


