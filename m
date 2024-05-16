Return-Path: <linux-kernel+bounces-181387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6708C7B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4042E1C21B05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7771E156862;
	Thu, 16 May 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDOB5QGU"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A18157470
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881457; cv=none; b=kp9LOQF7r2/6Os/i4xFn0/2ejhT/RnVheiN6xxbggNxkf1usT00vG08T6CS/McPEQBKpWhiLMxqUjaKF/bBfHkuI0lfSUBWvLgvPiBPIBYFB4yZHpzTc8b/cmwrKzr+/3VCxQPQCM1n9CYbrPaBtrNQ/4g2+dDmhAe1us3N6vTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881457; c=relaxed/simple;
	bh=ntlEMLmTT3GKxdWMvXvLjjYoIasMg2Z9d/4Z4RLRF6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8Su6+5J4HXeiBTjMevleNm9dNDlkFL+R+VWvHUo/s6nxjcLhykJNj7tstyBQ0K8TAgzsspDxlK8KKirSkADLVIYeebwG7pap53Jtr5Ai58JI2Xb35gEBnLEjKJ5y5tMqK7khMZ9bisGh6AtGq/cyVCu9G1c2wfpVwoQpi9noQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDOB5QGU; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e1d924b0b0so62355339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881455; x=1716486255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g5CKbHMZ7wHQleUE8G2Jo73R4WSY99H0174ziTVcvE=;
        b=GDOB5QGUlCSjFdVMvkFwFHcLhTp1Phk2WoDHVqIXB32/9wDkuFP9apoge0m8inunaC
         QtcbgVJnc3rkV9RoEsJlVZ5isHZOsAlnenVa15yeSQ7kdjNgKtr8AOjtQKNkhnK1K/in
         cii7i2RMp5NjumvOzt11EVfZIuXGKru3cC2pa21pCEgFUh1jfZFzh+fi8mxscHjLbiwg
         phHcvRW8wqlyFPiOPQDgtiO9x4WZBMCCRryCEBu8MAQnClB59Kg6ryLMvbTZhfcXtNYi
         3FXjy53doMLZWD05dw4jaDAH/B5iMdRtYKYonNvZJCNezf2+/VmhCFKvTZTP8Irws6oZ
         yYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881455; x=1716486255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g5CKbHMZ7wHQleUE8G2Jo73R4WSY99H0174ziTVcvE=;
        b=Rtv3fSxo4uJDM7/nIjCys5c/amxhaMBxI2d3UakSXGzc4C1S2d2AUjWRjFCnNByrtg
         uJ3c51RWEdBY9T8ak7ABsncgP8+6D0NKJOQ4bKwht1uKXcTeRtNfVuI2wiyUjij+VofK
         wa7g/AQ5qlITrOi3+oUtwmEdRby0xXKHkSXL3gJYX9RpKIzrHwn9z+gEI2PXTF6nD3cM
         FuYm+9af+rEIE9vwTrTlwHJfwTmP0D2dkOyYSh1rTQEMnjz9yFl96Dok7HmlQ6WIVENf
         o0Uzh0T06jOpUtjvLLRr2MOHQz+5sUcZ75dtLRJ6ibdY9fduNFm5EUka9uT365OdNM0u
         1YjA==
X-Forwarded-Encrypted: i=1; AJvYcCXCXPk+CUJZjefnaGTZt6b2+sZ0DUmF5ZtUr1CqB0v5SVBXVEkf1tHAgB4lYRTa52xFAMCcfsemmf2g7wENsrdr1F53VmPjym44T9oI
X-Gm-Message-State: AOJu0YwU6QuFh3qLZAoKFA1Meehn3Gwovo8AexYNXIfMmu9kHvAxzKG0
	BzzMG9Oq5INruGrECCvmef4mV4ZvB01I6JglIpyDonzBc1pSbezO
X-Google-Smtp-Source: AGHT+IGK1XWGhvYAXE19qd7204RoipTQ+tiIB8Lv3aQ8KFeTci6df9p5MK/8RYSfeYjILj4i3Z+Zzg==
X-Received: by 2002:a5e:d517:0:b0:7de:c8c4:74d4 with SMTP id ca18e2360f4ac-7e1b51d09c5mr2049084639f.11.1715881455063;
        Thu, 16 May 2024 10:44:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:14 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 05/33] dyndbg: replace classmap list with a vector
Date: Thu, 16 May 2024 11:43:29 -0600
Message-ID: <20240516174357.26755-6-jim.cromie@gmail.com>
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

Classmaps are stored in an elf section/array, but are individually
list-linked onto dyndbg's per-module ddebug_table for operation.

This is unnecessary; even when ddebug_attach_classmap() is handling
the builtin section (with classmaps for multiple builtin modules), its
contents are ordered, so a module's possibly multiple classmaps will
be consecutive in the section, and could be treated as a vector/block,
since both start-addy and subrange length are in the ddebug_info arg.

IOW, this treats classmaps similarly to _ddebugs, which are already
kept as vector-refs (address+len).

So this changes:

struct ddebug_class_map drops list-head link.

struct ddebug_table drops the list-head maps, and gets: classes &
num_classes for the start-addy and num_classes, placed to improve
struct packing.

The loading: in ddebug_attach_module_classes(), replace the
for-the-modname list-add loop, with a forloop that finds the module's
subrange (start,length) of matching classmaps within the possibly
builtin classmaps vector, and saves those to the ddebug_table.

The reading/using: change list-foreach loops in ddebug_class_name() &
ddebug_find_valid_class() to walk the array from start to length.

Also:
Move #define __outvar up, above an added use in a fn-prototype.
Simplify ddebug_attach_module_classes args, ref has both addy,len.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 61 ++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 5231aaf361c4..b53217e4b711 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -83,7 +83,6 @@ enum class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 152b04c05981..46e4cdd8e6be 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
-	struct list_head link, maps;
+	struct list_head link;
 	const char *mod_name;
-	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct ddebug_class_map *classes;
+	unsigned int num_ddebugs, num_classes;
 };
 
 struct ddebug_query {
@@ -147,13 +148,15 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+#define __outvar /* filled by callee */
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							  const char *class_string, int *class_id)
+							const char *class_string,
+							__outvar int *class_id)
 {
 	struct ddebug_class_map *map;
-	int idx;
+	int i, idx;
 
-	list_for_each_entry(map, &dt->maps, link) {
+	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -164,7 +167,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -1114,9 +1116,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1200,30 +1203,31 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt,
-					 struct ddebug_class_map *classes,
-					 int num_classes)
+static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
 	struct ddebug_class_map *cm;
-	int i, j, ct = 0;
+	int i, nc = 0;
 
-	for (cm = classes, i = 0; i < num_classes; i++, cm++) {
+	/*
+	 * Find this module's classmaps in a subrange/wholerange of
+	 * the builtin/modular classmap vector/section.  Save the start
+	 * and length of the subrange at its edges.
+	 */
+	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
-
-			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
-				  cm->mod_name, cm->base, cm->length, cm->map_type);
-
-			for (j = 0; j < cm->length; j++)
-				v3pr_info(" %d: %d %s\n", j + cm->base, j,
-					  cm->class_names[j]);
-
-			list_add(&cm->link, &dt->maps);
-			ct++;
+			if (!nc) {
+				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
+					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
+				dt->classes = cm;
+			}
+			nc++;
 		}
 	}
-	if (ct)
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
+	if (nc) {
+		dt->num_classes = nc;
+		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+	}
 }
 
 /*
@@ -1256,10 +1260,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1372,8 +1375,8 @@ static void ddebug_remove_all_tables(void)
 	mutex_lock(&ddebug_lock);
 	while (!list_empty(&ddebug_tables)) {
 		struct ddebug_table *dt = list_entry(ddebug_tables.next,
-						      struct ddebug_table,
-						      link);
+						     struct ddebug_table,
+						     link);
 		ddebug_table_free(dt);
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.45.0


