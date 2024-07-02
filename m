Return-Path: <linux-kernel+bounces-238425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E496924AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EACEB24A29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7421019D;
	Tue,  2 Jul 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwZiScSR"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E049205E36
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957502; cv=none; b=LEMxV4fQqNFp/3LBvoxEKdLbiOnHTS76wPvQM1WTutSnAqbyHSys21m+XPDEeuCNjPxf1rmM6cWkOejlCBPj0Qi+ZC0ZrSLDmdEDTwTlbZV4yxXNkMGNvHyWsKOkAhbp9h23gaFkjpF7AEXX6FoTOqzABBTRjB5FWPd2MUKaK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957502; c=relaxed/simple;
	bh=a62lPW7eVhSkQloPVjs9VB1a7U2lNEYmwgn/yXAkEJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZeolK/L1FkYgTLtJ4O0Dp7rzYEMdC/4sobhP/Lub+5pUrTjbaskvELCkEh/JBRXTsarKEG+rTOMG6FR9/Q4/lXJ8JpiUwdyo0/TibCI/osWQiwPo3eJUc81sZehRJF924N73VtsBfi+GMhHX9c9OknjF1hSb2LgBV0e1bVFDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwZiScSR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eee7728b00so189198539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957500; x=1720562300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52iPg28HXqn4X2lm9WUrOmLU/4QpKAFdaAvrwuYTPPw=;
        b=iwZiScSRPU/UjVaV5KaabYmwUKKxslUEY9OJq/ByFgSP3rDeGNcOqir1ZqG2391BuL
         /c2veJBUpKwQGyRn7DhCB+dDSKgEhLIjj4pZgs4v4Grcn/W7Ky3QBZNggdtjhLa/a8nz
         JayTSKRnzoFC4EfOkcSXx63qN6/SlQx2/TR3XlSTc70qAv7JBWdMQysyN1z2eCdE9fm0
         4QRm+9D8bCDVYXDSjTBhmG0j5xAXUCJWP9af+AiZhjP2c2uFKk9eDiQxEtuuL880monH
         abh3zXN1KtFWsuk+xmmkoKZE1NIjjda0YDZV9YHwEqsw2CUcTq5jo1LGMu10/03+0VpX
         pCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957500; x=1720562300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52iPg28HXqn4X2lm9WUrOmLU/4QpKAFdaAvrwuYTPPw=;
        b=Ib+6ACgOFOHW7ir733jjHYsKfd3sKg5jbHQIAr55gVGt321FzbJgz8B0MZNbKoFQbx
         C4XxNRHpyik94LSxLC7bNqhR8gJzf4TtCIZ9Nb5R8XvcTWVU9MrEt1lGONOmI5BpmGq4
         XWmnrkjQ5TTzgWSNutSd5uaGSsN242FgGp9VP1velBwOJoDUvLHw1qwaMBVtcr2F/Edx
         x9cSq5ultgs62A3OSWf4/LqK1ZWNGFH1YSqhGP9HtYVQyr8EdgdzT7hrbx9fFigyGIQ1
         r6ZzNFn2xhfxaRQd21BQNUS6MopnjEy5f7wKr3ll4Td0tc0MoyiXIOofH2MdY8AbCyq1
         JfDQ==
X-Gm-Message-State: AOJu0YzglWnIfbdAVNLk6rvkMJSsRno/s3M5y9MfWwyPCezenESfzecB
	TRc5mvEHdLlk1CbmYY1Ysl5f08Aoqmdqwwne20J7w6k8pQY21cF8
X-Google-Smtp-Source: AGHT+IFFbCIfl8bx2w+JuzIZmXvsJ6oAJ2Emqs0cnXdbK8ry2e4bmgYEQW6dg5QtzqjQCMNgfaCDxQ==
X-Received: by 2002:a6b:5a0f:0:b0:7f6:1cd3:9659 with SMTP id ca18e2360f4ac-7f62ee0d9bfmr1193270039f.6.1719957500464;
        Tue, 02 Jul 2024 14:58:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:20 -0700 (PDT)
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
Subject: [PATCH v9 05/52] dyndbg: replace classmap list with a vector
Date: Tue,  2 Jul 2024 15:56:55 -0600
Message-ID: <20240702215804.2201271-6-jim.cromie@gmail.com>
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

Classmaps are stored in an elf section/array, but are individually
list-linked onto dyndbg's per-module ddebug_table for operation.

This is unnecessary; even when ddebug_attach_classmap() is handling
the builtin section (with classmaps for multiple builtin modules), its
contents are ordered, so a module's possibly multiple classmaps will
be consecutive in the section, and could be treated as a vector/block,
since both start-address and subrange length are in the ddebug_info arg.

IOW, this treats classmaps similarly to _ddebugs, which are already
kept as vector-refs (address+len).

So this changes:

struct ddebug_class_map drops list-head link.

struct ddebug_table drops the list-head maps, and gets: classes &
num_classes for the start-address and num_classes, placed to improve
struct packing.

The loading: in ddebug_attach_module_classes(), replace the
for-the-modname list-add loop, with a forloop that finds the module's
subrange (start,length) of matching classmaps within the possibly
builtin classmaps vector, and saves those to the ddebug_table.

The reading/using: change list-foreach loops in ddebug_class_name() &
ddebug_find_valid_class() to walk the array from start to length.

Also:
Move #define __outvar up, above an added use in a fn-prototype.
Simplify ddebug_attach_module_classes args, ref has both address & len.

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
2.45.2


