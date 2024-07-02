Return-Path: <linux-kernel+bounces-238442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB5924B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59BAB248E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E618B427;
	Tue,  2 Jul 2024 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb7BUTE5"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3F20FA82
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957523; cv=none; b=aSQg+3EOwW++Tn27i/vGeKhrubf8B/jP+Wr8IB/3BufAu5lsjXF+rCqlrYfIErcW9vQRlvULyncIlfV4IMrF1HON0UvnM9gdNR+Xz+h3uRLdZAIowPug59Pok7NmdQgSvZ6JaBQyQlsJpDI1uzJwa0ddUxeY92lX/gSLninmrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957523; c=relaxed/simple;
	bh=OoinRYwI1RLCkMaax/q6nzarMvJOHgCe+p9o/nhwCQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8vndTxXDzzKrXuxH/mneZky0PvstFt2S0UNC+2izj03pJerflmQCQV5Rq7UwM2tOn/tp3KbIK3Jt0/dFGRYFc+DFfwP5xzBNIL+n9uAv5QdfgSIkFutyv68O5TQQi8/9KN0rPYD+qfRoE92j9kpSfqX/cGr5BVi0dqdVk1fyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb7BUTE5; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e21dfbc310so177438339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957521; x=1720562321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIvOBtUs6wwUYmdF+Bm1LKjLjq3TMDH2Ljy+h6N5XvY=;
        b=Bb7BUTE5Yl0XAOBG15VcOLeBXu/YalxFQD9pOIjPNsXsqOwIGNnACw03Au1HOcfLFX
         ESAxlfD/Mun/WU5JFAnBLVZQlEZm8pQjgyBNn/xAr5cvU966z7vjtMLJjWrm+Z/MR2wJ
         WbdjAh+yH+pFmHeQsSfSNDuoBnPyuyTO6aACAcryXsWggYSvtfEv++ToMLag+UVLlwva
         tPZBRJ7TxJNF22Iaw7W+2p6oIBrnA1NkVVBFumrict1n3ooaSO40xk/oMmemZPSkEmjN
         tXcaF4BxWbEkXQF20SBB1YYAUd2XgKMdRKqyvmEBF6S6vBkYUbn1yTC8SdObSm/AY5gJ
         TuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957521; x=1720562321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIvOBtUs6wwUYmdF+Bm1LKjLjq3TMDH2Ljy+h6N5XvY=;
        b=GpkT61DnzsmjL8xvRnc/0mKdgj+qnsRLWYYXHVNsuazzdB5F5kwkY4mH6voRdgTSZB
         GUjjm8NByyAKb2o2CEJeowv1Lazhn/ZMRL45u5KIVDZ064P9VIK2ZR/XEoAAjPWL+m5L
         WWCiZtN7Z3qub6YYsAO2DSh/m3+zk/52fhY/kI6JRxDimhKkVAdexYJgRjCEcYIL6U9T
         Vd3yJb8ppRDf4tiIomwBKGoSko12OniXHM8q2sH7KnvECJwXr4FP8pSaykXz/iM1NS0G
         mRMSERiZUoNVMcC16eYIHN0wVjIBLioK/zBpx37auT+CC9iBzWL63jrRj5rckbrxUwDn
         Alig==
X-Gm-Message-State: AOJu0YxdkkbYuY59XAvMx7PvetgGPjVCNgulZ6oswqQ0aeZdpbmJMUkD
	1kFCLjZPVbI+Emd+v6iHjMN27Nk7gBjLjqg1Rnacy6xuxnqEl2F+
X-Google-Smtp-Source: AGHT+IEk2c1hL6ZUgrQgYe6v2wFx5FJYF6vj0/kQsd1seeLP/2lOU4aeFAE+8OqE7VHd9h3YIT7KPg==
X-Received: by 2002:a05:6602:1209:b0:7f3:c683:2266 with SMTP id ca18e2360f4ac-7f62edff7b4mr1072199639f.4.1719957520998;
        Tue, 02 Jul 2024 14:58:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:40 -0700 (PDT)
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
Subject: [PATCH v9 21/52] dyndbg: split multi-query strings with %
Date: Tue,  2 Jul 2024 15:57:11 -0600
Message-ID: <20240702215804.2201271-22-jim.cromie@gmail.com>
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

Since commit
85f7f6c0edb8 ("dynamic_debug: process multiple debug-queries on a line")

Multi-query commands have been allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

That works, but it needs the escaped semicolon, which is a shell
special-char (one of the bash control operators), so it is brittle
when passed in/down/around scripts.  In particular, it fails when
passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-command
separators, which is more shell-friendly, so you can more fully avoid
quoting and escaping hassles.

NOTE: it does break format matching on '%' patterns:

bash-5.2# ddcmd 'format "find-me: %foo" +p'
[  203.900581] dyndbg: read 26 bytes from userspace
[  203.900883] dyndbg: query 0: "format "find-me: " mod:*
[  203.901118] dyndbg: unclosed quote: find-me:
[  203.901355] dyndbg: tokenize failed
[  203.901529] dyndbg: query 1: "foo" +p" mod:*
[  203.901957] dyndbg: split into words: "foo"" "+p"
[  203.902243] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[  203.902458] dyndbg: expecting pairs of match-spec <value>
[  203.902703] dyndbg: query parse failed
[  203.902871] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

The '%' splits the input into 2 queries, and both fail.  Given the
limited utility of matching against the working parts of a format
string "foo: %d bar %s", nothing is actually lost here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 235d85765b63..dcec7b3657bb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -596,7 +596,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
-- 
2.45.2


