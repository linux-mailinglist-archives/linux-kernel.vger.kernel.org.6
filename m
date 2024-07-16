Return-Path: <linux-kernel+bounces-254263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86213933110
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B921F23C49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57B1A2FBD;
	Tue, 16 Jul 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUwS3mMa"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DD1A2C12;
	Tue, 16 Jul 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156313; cv=none; b=a7Cemv9KJsf4ITocnuUOweDRSc8W+qpzFJ7am9qTmZtESClZAkGjG7CYcvEKUjNVi45M/NFV68KPbtJysmPvdkgClMmJjCZTMn1jn8l1JNuBijiOrklwt9NscGo4X1EdYZsVHa1uHrOKH0+lW/RlH6akP3IPaxrlpx03OydwiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156313; c=relaxed/simple;
	bh=2orYXb/DEjBbzyb8Caox8Abxcs9fSEtj7EsxKJLeFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAoC4aEEVbA81mpswFMW3j1YGiSCqo6NF8gl8KlNMnSUVr44gfv7MqLXTFSKlR+WQMOO2HbNlxrnvlitEjxVgvKVKhnG2ecq8fI/Szn8tQodokN53rRxtZ3b2FcpRr6H87+oTUuTjdkPfLrFjGpPOzE5xg5v58ciUjLcvPM6zL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUwS3mMa; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8076ef91d8eso6243539f.1;
        Tue, 16 Jul 2024 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156310; x=1721761110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/963zG9LNPxu+BVNW7S/xeH6c8P5d5ieMeYbq4Ngms=;
        b=KUwS3mMaMXvkW5F3YhYQmQVsSckXJRpeJS12fwmUNBYxnJWTs1hmXrF6XJztz2+eNX
         I/d2usPy7/ay/VenIWOVBzR2JnMuLwr88Xp/wtUd8VIEqrzeMWTKe8jidXsevTCixn8L
         IHLtDj1eUs2PkWQozJ/hgMmbRSOOkxdapBmFKWoSKHzaIOKsGrnl/m7Y4CaXEsCIw6nk
         0+8XlozmFp13syiT+gCznjCGX5OHgN6eidDubHR7S09mAR/8/O5lIuhUwBPfAdhl4bwX
         LWk3XbCVpzSTd+OyNWJ+QGVy3rHVFq5IxuNEpomVdPLCy7No+j2Zev2yPTPvXTBtOAXd
         HdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156310; x=1721761110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/963zG9LNPxu+BVNW7S/xeH6c8P5d5ieMeYbq4Ngms=;
        b=jEtbTkkBnwTYdVz8CQuoIB838MA0TTUuX1v7C3Adu4ZP/T0kPnXkLiVoa68oiWNyyd
         ET822gjY0M7QUKmbxnPWwhAg4p0Mj4mMuv5hrpB4I1PgRK6bhgSILZMZu/svp5ZY/g66
         aFosCv3suVd9+dIy0HfiNoGnR/NT+VVsPcVPRcvdy3/D/u4tlVOenP7lC36GzcITV9Hj
         rcDJ+tt84+YEon/+7fBn0jFqyHOBis0UNa01jOmyRs73p8tl3L1BER+jZCnm+IrJ00cx
         xGU4LDQLryXusqB7zbhin8qeNQHAphOiRJm9QTQ2a0Pm+dhVVcXoAm9AptNVXUDxO8CH
         I+hA==
X-Forwarded-Encrypted: i=1; AJvYcCXpTBelma2mt0f9zN5kGjNGgjEvZmc7GhrQyVdca9M2KnbuC291hXA19S5RCqhfwF+8THdXYFSRHuv5fyLCijHARGBT1mqjnkMT
X-Gm-Message-State: AOJu0YyNrTTDDSRVrgxhbGWGCkiYZ4+DWHgil3qTFfss+hnTPWbK7GRm
	c0oOMgBoDY6ApzWMrHoAbp0pwl8y06/AF/v/jHZ+Gnht8HEDMZwiNWB9r+Ks
X-Google-Smtp-Source: AGHT+IGst7Pb1aOlwZJwZi1xRL71bE8jQTjJ2ODygIZkbSk9dKUSw1szwoP6NrksbYl2gFvzuix05A==
X-Received: by 2002:a05:6602:1612:b0:80d:19e4:9d63 with SMTP id ca18e2360f4ac-816c2eef606mr48916939f.3.1721156309942;
        Tue, 16 Jul 2024 11:58:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:29 -0700 (PDT)
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
Subject: [PATCH v9-resend 09/54] dyndbg: reduce verbose/debug clutter
Date: Tue, 16 Jul 2024 12:57:21 -0600
Message-ID: <20240716185806.1572048-10-jim.cromie@gmail.com>
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


