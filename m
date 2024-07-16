Return-Path: <linux-kernel+bounces-254275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46093315F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038831F2209B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B81A7067;
	Tue, 16 Jul 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdAJHsft"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439391A4F3D;
	Tue, 16 Jul 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156334; cv=none; b=mwURlJXVcrEYQo7u2uByUcFxg/tuquQEziamjqTvq++Zcx7QTbKlgyzRFWYk6aj/KGUgOJAa9Oaa9S4jxHs1BP88uOTCmxQ00a3tnbxO7WiuyITXDnirh/QOTpmZtSbjgvOzXeG5jymRiscITWse05vCYP8+oSfCH8R+K5yppGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156334; c=relaxed/simple;
	bh=OoinRYwI1RLCkMaax/q6nzarMvJOHgCe+p9o/nhwCQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njJO9FMdlM29AkEnm8qLExELM59IE9MIjOQWNm7+JbwwFI6G2taCsyocCClY6R+DpLN4xtLZhl1liFKmvn8B/Zji1zjEaPPZGul7dcGzLONQuVeYa8pI9b4sX/B6w7MmJXfklnEDayRUm6/+9qyGOve+b2KQSQikn0g5v8C7CE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdAJHsft; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8036ce66134so4803339f.3;
        Tue, 16 Jul 2024 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156332; x=1721761132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIvOBtUs6wwUYmdF+Bm1LKjLjq3TMDH2Ljy+h6N5XvY=;
        b=FdAJHsftAKFUKu1WpzM+7sCIOmOwVcLQ4pct8ZPqyfNl5xAYXH600Zw1IyPeoUc5oZ
         R5bYxBCn8pq9+clBiyTWZXeAovKEwakEKi7kfAsXmqepjwWErXdfIwptHhA/x9NC9A42
         FYl+p2orepCl6gMp6RP/neyBRxJOoOvsxzETZ1Y8qqEFS6I/TwgztmmQdZcw5lf7LR21
         Z/KH1wwzwxJGdUC4A2JkA9wqlkCZGoKSDEiffhMMaf+u7gEGGY8jMw5HPLLYUue2dp9l
         ZewaAGGhxdSFpstwOu9mW77V0/hTXgVhdi39syVA4R0zl6ZwAroabpwwPk+vWezsIUIu
         C+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156332; x=1721761132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIvOBtUs6wwUYmdF+Bm1LKjLjq3TMDH2Ljy+h6N5XvY=;
        b=gMhGrh7zNfzHivOu/5oQ7qPnqsmavTgJc92YWrWuegHEbD0l44s28O2BNJ3a+CZidx
         avQkSnCbh/B0+97Y722TANvcbwrT9s+4KE38mH5zTWu3LYQyOrmgNR7EDLs1ggZkInpR
         LGBsOUucuZVXTuVK6zP/Ud6H58xqyqom2GPgBORhHB1pV3Ji1UHsvhnslsq5t5PKmV+e
         bEczILO9iVsVIUeCKNL3D57zkYmsmNSm1nG2gv0A9XYxWviGr03S7NCcAPKiKdY84NUA
         rjxqQFy8+ufVbyvHgPPPVmLHYE3+DX4JInvY7rkWJruondVPLN5wEpxNKfFprNUYJ+Dc
         EoUA==
X-Forwarded-Encrypted: i=1; AJvYcCWihKPsjlLGkCBQ7cZKaZu3hei1N78cbFsobR+6kgylAXTPBvwmvApSe1nLFhl1RT2EfSNZxQiZhx1UJ/kxejVmJ4RwZT25h/iT
X-Gm-Message-State: AOJu0YyclJ12sXB3bmoroqR43EFQWob4Y5mOqvQqF8RAmoeiNYRtIUAH
	PbON8Kg9THBt4JC0Z3clvjTdU267bCHTmDVQOgyVJBZB1+ujSvxlr3fq1yYO
X-Google-Smtp-Source: AGHT+IGIzqzPIEDRHp4d7Lzv1bJMSuo67sIN7LKuY04te4B9L6LczQkAf5ej+65dlhPKvxI7KIqPPQ==
X-Received: by 2002:a05:6602:13d0:b0:806:6b24:ee2c with SMTP id ca18e2360f4ac-816c5883f11mr40915339f.16.1721156331976;
        Tue, 16 Jul 2024 11:58:51 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:51 -0700 (PDT)
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
Subject: [PATCH v9-resend 21/54] dyndbg: split multi-query strings with %
Date: Tue, 16 Jul 2024 12:57:33 -0600
Message-ID: <20240716185806.1572048-22-jim.cromie@gmail.com>
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


