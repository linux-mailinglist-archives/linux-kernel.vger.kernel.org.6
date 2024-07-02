Return-Path: <linux-kernel+bounces-238429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37A924AED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01354B2533E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02A21C19B;
	Tue,  2 Jul 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEPjBQNj"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1A21C169
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957507; cv=none; b=MxYCKubDEb5C5zVhZLbLhQtdnBvTQvNtbaRk9dTSxMVePWVlHJ8xgXsiOLT9osnhGis2Vx7FUlLMO4GEGcdwcfzfIx+PVlb++unQ4dN+uTb9GO+QnyfHAyWVMHe5VjhlzbXfQNw+HMU+LqfPjCJkQRD69EcNXCtV2zo04SkNEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957507; c=relaxed/simple;
	bh=2orYXb/DEjBbzyb8Caox8Abxcs9fSEtj7EsxKJLeFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYBdw1JBcxvi1DKPs1CHjIY8BUHhAKkxfWgdvd+PmigXu4AtjNutEAuv1xdgZ43pgB983PQE0sQJh5Pe9t5auBXLbk9QN3wkKiVxbBIl/bLk8DV60ZMVk5UWC8i1ORPbDGtr+m8yyotnIvs6qxLWZ7S6bW3V286+M/ArPM3dkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEPjBQNj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f3d3f1294dso169373639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957505; x=1720562305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/963zG9LNPxu+BVNW7S/xeH6c8P5d5ieMeYbq4Ngms=;
        b=bEPjBQNje3CYzAX9OK5EM0hPuhvQCqh4tveRBG+VbInTkv9C4prydv9dOJjeXV0tBC
         RzUT1o3d7GdfzNguyQv7e6xI5lM2ZgobEOeOLotGlrHpWtuUo3qxvry7DeVTtj8udLC1
         vy5jU38tYOkSHKXARzpztSWqC2YX+BZzeHIunse0bOsIFJ1gFyMZKi36EmanwJuvaqVl
         uFyCJHOEZaoWQChK1IT1cUlnzFdiNemZo6apdtgSHrbxX0AeeMpvkyK/JZLhNaB17J11
         R8oZqycaBYEknv3cwf2XRjqR8/CPfdKCrA2EPTyUDvi9ddDUM3udTiEFp6k5dO6TxKhU
         Nv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957505; x=1720562305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/963zG9LNPxu+BVNW7S/xeH6c8P5d5ieMeYbq4Ngms=;
        b=l/g/LK4WO1Tjj0fi8DkPjBu9L05x9taFys561qhtgbcDJKlXUzxqkm/vblFcfm90bU
         mAV9xDKC8/vkch8NLa+1t371ivgKJjp4UPXf6mdLE3mUEmCfiRyaoExMyn0ruDDP6zTB
         753qDfZYdJuhu0m8reJKIz8UUlk2m8q1yyO671VcXN/FJAspadScEdRpYtOWOi0n/DRp
         9oTSZzay3vMHkiPIc27NZ72W/w8+1ihQ+FCGZYKL8/V9IpNgbgUplfK3SRX0/EB147H+
         IvtfnlzXd4gNTZNgN28nyycRC5y03M52SuZE/cK3hxm6osem7Sqe7xylywGxcSeXeuV4
         FTDg==
X-Gm-Message-State: AOJu0Yx74o9gpkMftTULuG/Nlkq7wEmaRa4LUJ28ZRQUKbpA7eVwy2Q8
	WYLgBfLpDWCPkDc43gVdkkgACUE5mpA7ZfSuKjEoQNC1ZlbhquOf
X-Google-Smtp-Source: AGHT+IGX6ME8eGVqlfazOAcN/G0b48tkJYoxa8zIbYTUGgfze2KInpikaNyiDKbQdhqd9nSM7L0cIQ==
X-Received: by 2002:a05:6602:808:b0:7f6:15be:a6e0 with SMTP id ca18e2360f4ac-7f62ee82b0cmr1045219839f.20.1719957505324;
        Tue, 02 Jul 2024 14:58:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:24 -0700 (PDT)
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
Subject: [PATCH v9 09/52] dyndbg: reduce verbose/debug clutter
Date: Tue,  2 Jul 2024 15:56:59 -0600
Message-ID: <20240702215804.2201271-10-jim.cromie@gmail.com>
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
2.45.2


