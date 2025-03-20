Return-Path: <linux-kernel+bounces-570221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5550A6ADEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6395189DB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3FD22A1D5;
	Thu, 20 Mar 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2t0OrND"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC556230BE7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496820; cv=none; b=QjzBQz2nTHRa9hkTPApf+Ay3OMna1dbsEbEfa7DT47UHg4eFbIWflkXPxqLgq9rfZxMmjlkHC6NGQsGVajD/xb9jbtQoxhJ3GRg7CaGW/SHoh0d4OskpQD04oafX8KrlQAOQS77cJpvDtg25YVH7V8hzsNWpIFA0rP18tC7ql1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496820; c=relaxed/simple;
	bh=36NWAficZDHpEm26W8XaIeLJzui4w8rAyDxigzWGwww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqlu0Djdxhul3EOIIH6Od0HbtK8GsRQ/KDNV+er8c6baI5c96wPTzrpNHr4I+ANrOio+gEOzDvWjXTP7udsTBSUESWyPWEk7IE9xn6sBRNhJ/7iy9KnxJ8MnnRm2rvTa7THJkdh6pj66SwBWMGBy/n5+SNoUb4aftmdrb6FJtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2t0OrND; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso13778239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496817; x=1743101617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpbhRZZt9AFd87SNc1x+tRriKokTIY/B2ItoxXJziSE=;
        b=m2t0OrNDPpF2YIrnZnxQv0GN5TLHMi+WIGp1ToFTGzbcsDPQ5E36/38k2zBo6aITip
         SZST88jKzgcJJscEFDBHaDKvP6jRee9R7rxBrIQrBXxtZr2GbhBg6u2lchfuNVJ38rFs
         z0God3ua9WGbkCxwzmzwgoZhaG513s2zaXL4NvChs0MWpgRMS+eO69YBHoDC4qwUeNTK
         WEgtrFVPygmDUT2jW7Kn5U6ItFoYULXztiBBDlxDGCu7ExkiiI9eSDv3VthSyqSBkWsN
         z4nAyB81cpnraoA7w5sDAZwXS3JF5nah+AZX2Xm4Uu8NNRG6ZF4eoN5BZLcE99EZJqED
         Rybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496817; x=1743101617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpbhRZZt9AFd87SNc1x+tRriKokTIY/B2ItoxXJziSE=;
        b=tT15SGqWqTX2eSX0YP7DlCdOhOY4v5DhSGG4bwOSMnmKE4EjR4acftHkFuf3gcxi+Z
         2ip/agIgy6XvzlmpBCM0IWokSLL3+z+LRIAZGiY5IHNHDBhWOKTi5dOHAWTg7Ef8AJRW
         /4EZuS9j5KxatmIxX9CFtDxmYNV9/ECULvZuG0iXB7O0YQa3AGj8P3Oyj8DMETa+P7im
         3o1uoZm2Y5ag+9OKTZaFOIihbWBBPt+M/BL1URHyljVYvvEhdxzNyukBESa9Dd5AkeJU
         ok016vz+iKafWTedfeytBxGz9XfjYZkdV6wf+mGVcCvs2iopScYJW2dusAdH/Z74V+nR
         Ovfg==
X-Gm-Message-State: AOJu0YxqVY41iwnh7e3KQktRe1zVmp9SGB/pNHUrHmj5HR736jeFwUXQ
	Ph0QniFHFhiLhweFlfxmmE58v3x+ibOkPfju9BW057uuReVRCi01KV6a5wqL
X-Gm-Gg: ASbGncvWdaNlXM8N9dPWo7Pn2P+xhzCvp4Fjlto0Om9RETLJpLZHtW25f9tpBgw5XDj
	pjfBS5ExW9ibGaR3ZJqITiWbJvlpLbLOoV6mHLUxN3n3/D6PEX0kc3xgw/5BgPYt+ecnUC1vlIG
	EW9FQwxxiV2qp3ttdZCpsIy3SKWS3KDAXkFSv4wZjFn/FRXi1yfsbAWm90kOq2Qd9mjdWaCjCSE
	WrFGb3sNWuyIAe320cClOyNgQK06v9TzG3EQHM/EcfWNssoy8BNv7PCU3EGFcGr4BeYiJOkkYjW
	4ed1rqnp4huGY79B0UUIr9sX9leVoBn09PZB0ryTV4G2IwTz09lj2rCdKMdXoz7uIvnqC2WsgWl
	eyg==
X-Google-Smtp-Source: AGHT+IFuMQEbeQUc6coivxGrnHYjElXfmW7jKz6VfBVmZjpWHuswcV+q2LjK12WbmEyPhHwatFPU1g==
X-Received: by 2002:a05:6602:c8b:b0:85b:4ad2:16ef with SMTP id ca18e2360f4ac-85e2cb0e8d8mr39024439f.9.1742496817484;
        Thu, 20 Mar 2025 11:53:37 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:37 -0700 (PDT)
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
Subject: [PATCH v2 30/59] dyndbg: drop "protection" of class'd pr_debugs from legacy queries
Date: Thu, 20 Mar 2025 12:52:08 -0600
Message-ID: <20250320185238.447458-31-jim.cromie@gmail.com>
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

Current classmap code protects class'd pr_debugs from unintended
changes by "legacy" unclassed queries:

  # this doesn't disable all of DRM_UT_* categories
  echo "-p" > /proc/dynamic_debug/control

  # name the class to change it - protective but tedious
  echo "class DRM_UT_CORE +p" > /proc/dynamic_debug/control

  # or do it the subsystem way
  echo 1 > /sys/module/drm/parameters/debug

This "name the class to change it" behavior gave a modicum of
protection to classmap users (ie DRM) so their debug settings aren't
trivially and unintentionally altered underneath them.

But this made the class keyword special in some sense; the other
keywords skip only on explicit mismatch, otherwize the code falls thru
to adjust the pr-debug site.

So Jason Baron didn't like this special case when I 1st proposed it;
I argued 2 points:
- "protection gives stable-debug, improving utility"
- __drm_debug is authoritative w/o dyndbg under it.

I thought I'd convinced him back then, (and the patchset got merged),
but he noted it again when he reviewed this series.  So this commit
names the "special case": ddebug_client_module_protects_classes(), and
reverts it to Jason's preference.

If a class mismatch is seen, code distinguishes whether the class was
explicitly given (and always skips/continue), or the DFLT was assumed
because no class was given.  Here we test
ddebug_client_module_protects_classes(), skip if so.

Later, if any user/module wants to protect its classes, we could add a
flag to ddebug_table, a means to set it from CLASSMAP_DEFINE, and
check it when applying a classless query/cmd.

CC: jbaron@akamai.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c44502787c2b..13de0dd3a4ad 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -193,6 +193,17 @@ static int ddebug_find_valid_class(struct ddebug_table const *dt, const char *cl
 	return -ENOENT;
 }
 
+/*
+ * classmaps-v1 protected classes from changes by legacy commands
+ * (those selecting _DPRINTK_CLASS_DFLT by omission), v2 undoes that
+ * special treatment.  State so explicitly.  Later we could give
+ * modules the choice to protect their classes or to keep v2 behavior.
+ */
+static inline bool ddebug_client_module_protects_classes(const struct ddebug_table *dt)
+{
+	return false;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -206,7 +217,7 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	int valid_class;
+	int slctd_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -218,21 +229,26 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 			continue;
 
 		if (query->class_string) {
-			valid_class = ddebug_find_valid_class(dt, query->class_string);
-			if (valid_class < 0)
+			slctd_class = ddebug_find_valid_class(dt, query->class_string);
+			if (slctd_class < 0)
+				/* skip/reject classes unknown by module */
 				continue;
 		} else {
-			/* constrain query, do not touch class'd callsites */
-			valid_class = _DPRINTK_CLASS_DFLT;
+			slctd_class = _DPRINTK_CLASS_DFLT;
 		}
 
 		for (i = 0; i < dt->info.descs.len; i++) {
 			struct _ddebug *dp = &dt->info.descs.start[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
+			if (dp->class_id != slctd_class) {
+				if (query->class_string)
+					/* site.class != given class */
+					continue;
+				/* legacy query, class'd site */
+				else if (ddebug_client_module_protects_classes(dt))
+					continue;
+				/* allow change on class'd pr_debug */
+			}
 			/* match against the source filename */
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
-- 
2.49.0


