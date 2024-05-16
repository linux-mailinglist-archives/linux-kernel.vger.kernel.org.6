Return-Path: <linux-kernel+bounces-181391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6274E8C7B84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866741C217C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BD1586D0;
	Thu, 16 May 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA0tAO5O"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C659156C74
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881461; cv=none; b=AJYuY/LLd0+sTP1wEcOBJsZmoo61jS8IbdFJ9moDIVH+pOktjFwfe2WrWQ2rc72pzW3yMyub0UBDxUBTeyqD3D7DEgJvqL82XRtZcl+PNYbwWsBYxCCwD0HpntPifMVaqQ83+HXITA/kT4Lg/J84Hdo0FZl86bfiymPXxTEBwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881461; c=relaxed/simple;
	bh=zRw7b4KxY6XwSKZoRGW1l0s8wJscpuoS2KwZ+Arhbyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Csqd/0hvat50Q2H20b1jcqo3HASgUcIVr9l4HuEU5O8bYoqk+3QP+T3rbwQqGfJSNkhUpWQp4HppELKUZPmdZm6fkrdg8QG0+0WM2ZGI9mqfAunQ6f/cp65lNQNAbdm65MMtF6KcuglUIn3J09T94Xjk7UZ3fG0fzg88hBtN0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA0tAO5O; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e2025c3651so62759139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881459; x=1716486259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQuNI/VL3/Itw4aJGKYcYvYUzx59qbXu6ruzCspuP/A=;
        b=gA0tAO5OytNtZ89he8x72sobhp9+pnpCyqivVFCut5NA1ebXrgHDy/LknpMxVz7xJa
         xxSIrpYS1jPcopE4Gj5Wk3R85PzV9EUXIlwnoTduROaTRTgRGwGXOwt1zu/aom/IA1K0
         BHJJqZvdr+0GNK9xchatp6D/Pg2I8D4p1aaqIuPkl/AtpjQPaksSs+7cm2Al1xFuWSjV
         Zhk1OPN1eYQJayp2AuxV3YFJelr7Hg8/7GZdrSc2nvkmA8q93u+ws6iGPZRl+dL1mFNN
         d8T4hcbcoM32unrcMksEApbxR4NiX8EA1XSa3YWTU4INvey/HTOrhWAOxDbnjBXtZrQW
         rjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881459; x=1716486259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQuNI/VL3/Itw4aJGKYcYvYUzx59qbXu6ruzCspuP/A=;
        b=OuUtYx1hqJ5vexj0jmQ97oBReaopyRmijGFwbyyvDnc2/DtkVOu1LoMmX4swk8aBQj
         77qNk6ByKJ8v2590UpUpeQWzpAANpDFt/xbdJQ4Z8HRKaU9Rvou9SXJdryLqtmGC8LYI
         9TyZbTgaHhF2xzl3jEtDOccHQP6jO4m0sJRohvPZrngeJSi8Aq31A/OO5KZX/itRrY4H
         UqnF7wA9mTBW9JYyUHuXBXblPx4xohLU5KwvF+eV537Pky0idJ3WNC3rPth/hD98o6iM
         HyLtRjxVK4NlYYhqdJW/3/o0JsrCb7nX0F5J7rRQioF+OXmjtFThlR73uBWJjN7wW58T
         l2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWYw/Ayti3uFD6eWytFxqK+C6qK/2f7xp/O+5GXHhT1dOR06sYxV6s1f+3knFL22jdDz8QemO1HJJoHB5OZSxQoxDZqS8CUIXqAZ+gB
X-Gm-Message-State: AOJu0YzEnLd29/ZVUt23d9T6IwP5gpXJW+/NNqQlvurRdN31KzEidXr8
	WaIBXsHbo6aL8qBmoLGJXU9hIBUy5VwnW6P193I258h5inLBIT4c
X-Google-Smtp-Source: AGHT+IEf7CGzZ4PWnr6XB/a/3ybomaaf+WvBUPxqjK+CuOxKiIR+I0SpD/Ou7m4w3zDhAPmCoe+f8w==
X-Received: by 2002:a5e:8a46:0:b0:7d9:a53a:c9bc with SMTP id ca18e2360f4ac-7e1b51c7b16mr2196661039f.10.1715881459466;
        Thu, 16 May 2024 10:44:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:19 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 09/33] dyndbg: reduce verbose/debug clutter
Date: Thu, 16 May 2024 11:43:33 -0600
Message-ID: <20240516174357.26755-10-jim.cromie@gmail.com>
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

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4a48f830507f..368381dbd266 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -266,9 +266,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -501,7 +498,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -515,7 +511,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -531,7 +526,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -541,7 +536,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -559,10 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
-- 
2.45.0


