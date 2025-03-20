Return-Path: <linux-kernel+bounces-570198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53770A6ADDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C74A0860
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD7229B27;
	Thu, 20 Mar 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/A0SVqM"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717922A4CD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496791; cv=none; b=RtLCVV9Uq9HZkta0giK3Xnw3gH8zg929m71fTlj9zXwfIgWneTuerg5uHXYF3J6lEu48PxwfzxpkvzbCcAhjR/rJx/qP3UKMTqSOsT/KRZz2pZFc0KfZrA+CpRYJ41auBPWPfS4hkkKZoPc4saqlzv8x++YOw2lRYNl1euezkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496791; c=relaxed/simple;
	bh=zTzu1lwT/yPrwrMLE6P5y0xJGhOKXxeyMkk94mm8q0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS3bVH9VjzGue97dJn+S+25ik3BKMIKCLKPaXG+St1MgDImwUkYla1koCylJ0EkHzHZt2SeTdkBnIom1Cbbf527dv2bElkRiUy5mOeVcjXIKY1cxK/gaTbeLTdB7Dyq+UaxJGAtcQTvsmmWe4+HQRdPmCjXPyHCgnGNy95GupQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/A0SVqM; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso31242539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496789; x=1743101589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gFevukveSt7PbWkbUevQGA0uvSXu+LT7vaKBaZctmY=;
        b=k/A0SVqMLg4wbzGXZKQXJLxxKYrdvvKz3XXZOKAoQboM+1uICV5wEtwUReVBWYwj9b
         lNDCS4+S7ZrOM1FOAl6itWimQ2KtWxSX9XXX5quWVmMAYFf7dYmEwUtboKuS3RrljhHD
         7UfB3zCdRaTeS6tWIrIdpXYwla3D8CxmcaP+vozYpBhn+f65MS7e8sEECSSQ/BHe/4vW
         4r4wNTnwNn0hY+NHa6GSWgQlGheve2HlWk4sWkkgE08O4IEwGekeaijLy40UiXPav8Nk
         0Ttd9slAP8f1769DsYdronZLyi2hdFkyE2mYvaOsnrpObojdLjiehU6Y1KgQPyV5tRQB
         SWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496789; x=1743101589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gFevukveSt7PbWkbUevQGA0uvSXu+LT7vaKBaZctmY=;
        b=TZZ8EuyJxd4/K0qcmnUjSQJjWW67bgRf4Y6cxCiojEA8UUQRU6Mx/1iTufj6Cmx3No
         3GR0a3/nwejxKYfMAVSk5ILAl3HOvvuuuYGbBChRtg/lMjY/1FqtT+vesJApmTRu5yWC
         OuH4+g1BvUgLDRrv8Y0zJSpYglEcDNoGMJ2XlJXa+oDgm/7Dp2qtZbsvi8fxTbyzkTUS
         dziU3ezdrBDm7czZHaDvrUdnR8+1NDTeqRTredxzelEXrn7LTGxjWAcR34eTMspwse1r
         RIMfBr/frYSofTDC6O1LnOhweXJwPCII7+yRwMxLqBJoohmtdFiWjW1oLu/3r020W/Gd
         +L7Q==
X-Gm-Message-State: AOJu0YyjtQtWhwJcMvUvplzzeZOqtORkuFR+d/hEhWXu7qUYPKUYfQ+S
	K56sOTMlRf4wStyByr2hgWLiprfBKY3rqNqt4LotW2ZujXsoDee167SFr/My
X-Gm-Gg: ASbGncvrafBFiLP5DtQv0yB48IHkMuqEsJt9xow30H65TAGO4z3mrQLymcyFAoX8bPm
	fbL3JXPB4AuRB3A6L4I2nT/puBMx/GWW3YkDjvkKPOy5BLAQsqYBfLfyqnPIOTbCWPjtFBYJCK8
	RlWNq15EYQKHTqtVRZPWu6/LaSI4MGBgBhF0dSlYxQ6PP/G/UU2h29vZ6s+785VvB7E51cqnBrL
	DGzC7YrmUnjv3eG8lQW7dTVDGIEV5k0/5IOaSnNAoUGoqssXLSaI1o56PWz97wn7tW6wZZI+ZCt
	QPFV99LAoRQiHOBlwsfKBVlRCfl4l04rP6IU6AGbIJIittzChI0X88bkAfYVDVq1Db0T1kTwlsE
	TGQ==
X-Google-Smtp-Source: AGHT+IEl5TzbnKxAjaqmsC8k+Jv8OPkwqppFAxXArvgR0WfDE036J6MPxh1ZsMPTCMeE31lygTHh/Q==
X-Received: by 2002:a05:6602:3787:b0:85e:180d:7c97 with SMTP id ca18e2360f4ac-85e2c8f0cb8mr51954339f.0.1742496789264;
        Thu, 20 Mar 2025 11:53:09 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:08 -0700 (PDT)
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
Subject: [PATCH v2 07/59] dyndbg: reduce verbose/debug clutter
Date: Thu, 20 Mar 2025 12:51:45 -0600
Message-ID: <20250320185238.447458-8-jim.cromie@gmail.com>
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

Also reduce verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
-v2 squash several verbose cleanups together
---
 lib/dynamic_debug.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 55df35df093b..c609ff873224 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -264,9 +264,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -499,7 +496,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -513,7 +509,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -529,7 +524,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -539,7 +534,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -557,10 +552,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
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
@@ -1234,11 +1226,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.49.0


