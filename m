Return-Path: <linux-kernel+bounces-181404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9B8C7B95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E70280E61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4815AACD;
	Thu, 16 May 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaiZWjn/"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418D158DBF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881507; cv=none; b=B8ubNGxj46IlYekLav3xZN0YZmtvde4w/fXa8tLIfWoCD9AUknY+uWpgULVJHuMgdf12rTAf3Xlv7KP+0czI2RQm2mP9ASp6CEK2ZLv7opNofUy2D4IlSFXI7P+oujlLXikIkHanATGRqocImEvWdhb61TK84thtnzCBYQ+F0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881507; c=relaxed/simple;
	bh=8iUlHoA18CODHTvP01/7nn44Fu6mfDtGqRxAHN6bArU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+8PKB9IlHuc648EVTFpiig0ODTdOfiuUSvzZqsU5NrFGReyYnNjWQtGQLn6Xf+9wyni+PR21ghhnM3Kq6ru8qQP7wxWEOG2ozukbaugSVoyQzZOcNTY9D3GLMENfPu4fCwLenn7mubvln4o+B0x5MVG5o8PnRUur72vIGUVveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaiZWjn/; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e1c2ea8481so29715239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881505; x=1716486305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1/6ZyOjyDKXy+eVnlQt6M6tqfLK/4vR0B+QR44xbZ0=;
        b=VaiZWjn/Ugl+HtgfbTjxCTcR60NkI872PlG19/eap16EkassUA6+uNFYZOudAJU7GL
         YE1PijxtSb5BTMtemqLazeJInz3lRGZljDrQvwZ0ePqL4tS9qWyTCIE/XCuvZa3ZpH5G
         UygyHS36slN9bs7zCLN5lufoZWq3gpo7pSxwsTQ5KoLnJmK8VVIMhBtrcGcki6ZCgf84
         93sK0GSaZvBNDSHNYwjWJ1LGUjLwu7xMIlqLiL2GKOmW58Qgf/UAb+H2aKbV0XBGccKf
         55iXAsA6pNiVa2Oifri7QmFaenbOUxiz/kIw4TQyt6Yobn+5FA/o8IcSfYK2TSH5Q5pK
         TOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881505; x=1716486305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1/6ZyOjyDKXy+eVnlQt6M6tqfLK/4vR0B+QR44xbZ0=;
        b=om3d/ld5hfFWGUNIKUlAABy4sYYIB0AVvjqQ+uXKFHZfLMdVbnkoVB+015UkL5OaJg
         Dd7CbrbbiHtXYXeXJuRw2ZBe0Xd8d5ddYtec3APK82rtHiH+gYHeMmCU5vt41IzNrIMv
         3JEArPaXQn7hxIboka+XRAjrsomz3FK0aZ//LQKm7t+Fb5NRFHdewQyNZ9YJl88iU29A
         24NmouM7vnW8f4pfI5RKAck4X0jfQwrTKQk50/5KKteFe1T93OIzJMWK800BVgHNvjNE
         oBVSHkk3ILtBqvbosOIpQgbbhzSmwLVQe/fMGCY+v8hGyiPtfXwpOy0sIJ2BJmf7VW6r
         cbTg==
X-Forwarded-Encrypted: i=1; AJvYcCVkjkUzx0P2GzNc7U5NmCIl5FCyquIaiy13SsD7g8UYnhPzraY/Bc3mjyBaX7x0UfQ9fWpBgC/u9sVeXvJ9NWvMytfpA4On1/UCKITF
X-Gm-Message-State: AOJu0YwQAl6QFQHOuLQ2/I8HVSsz9C+rZTyS7tQHWDtWXDV7heIlswen
	amoRmb+IGmHQGwmex5Uvn6P9TdqHhNTsO8vp3ukczT+h5LIZ0VDJ
X-Google-Smtp-Source: AGHT+IGDMUhFkxe4ntEiFSPM7Sg4FIARBDM6OgYtOIZyFR+kdTX8zSD97dTtznse244WRGROvCyurQ==
X-Received: by 2002:a05:6602:3049:b0:7e1:d5cc:84bf with SMTP id ca18e2360f4ac-7e1d5cc851dmr1109118639f.6.1715881504096;
        Thu, 16 May 2024 10:45:04 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:03 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 22/33] dyndbg: split multi-query strings with %
Date: Thu, 16 May 2024 11:43:46 -0600
Message-ID: <20240516174357.26755-23-jim.cromie@gmail.com>
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

Multi-query strings have long allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

That worked, but it left unfinished business; the semicolon in the
example above is a shell special-char (one of the bash control
operators), so it is brittle when passed in/down/around scripts.  In
particular, it fails when passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-cmd
separators, which is more shell-friendly, and also avoids quoting and
escaping hassles.

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
index c1bc728cb050..625838bd74aa 100644
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
2.45.0


