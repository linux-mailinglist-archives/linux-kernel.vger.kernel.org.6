Return-Path: <linux-kernel+bounces-570201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62484A6ADD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD0188963D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339622B5A8;
	Thu, 20 Mar 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RohgweeN"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EC22ACF3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496796; cv=none; b=acfqG8/uRwdOWDrVQ+XhulioZB7y5WeAd8dgOWACHs+Sun684pN7Q7JgX/1YgxeZS9fZOZSQ+MSHBLQmWhuyYMr4ncUC4abK8NL9SKqOqDf16W1jC69diTgH8PHUyEbnaCKw4gRDjDlh2Yn/gLHGu6AOtksgkh1kilDxk3hea/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496796; c=relaxed/simple;
	bh=usQXJ6acUzXbWC14vd9VoA6lMsRwOXskrYH9hSAqoX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHBs8bMNkCGmqkx0cQ8M93xVDd4E+mZuOb4qUbcSTt1c4ySHr/8wZYd88LTi4h7Vf+4nM4ysHSwLsid8YQo/jHC6XHMa6SpDo0Obd7lSQWyIip57eN6Tk6CLyWm1obMlV4E5LIOry8tn0mPIr2cng3inDUOAzgRvbbyQlNMhkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RohgweeN; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b515e4521so36853939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496793; x=1743101593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+F+GnadhvpI9NV2I8vagHLeGPOa3WWFte+bwa7InHw=;
        b=RohgweeNyaEVkz6a5UwpWX2r8bwXHey9hKbcEwzwnybhKjlvUY9NUYbEHy+Z2PpMQH
         G+uR4IytNBbCe97GKd8/H8x6yJSwTx8Xo9qk/sn8lfRFYwNKr8w6+KzBwufaQpWLF8L4
         METl10/Gr5WhNFxh1DMruXv3f2rgWWyprmESEQrTL8+D2cGcrjq2h44tpVDrPUMmuE8M
         vlgjwH/1TQOMn23Tggh44Ms5nx1kzcIIMPal4Yti/JARsoVJ7e5JqPDrTnxCCGifgUq+
         dEWwZf/EcwI6nQZRl47qs27mGRkcZl+bVleGsGruR1cwLvH1FaT7r5aD/iWbu2JKit9G
         zZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496793; x=1743101593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+F+GnadhvpI9NV2I8vagHLeGPOa3WWFte+bwa7InHw=;
        b=rgVwOQU1v/u3cyEQui7jjNpXzkTi6ZBpF7tPJK5/m+JX1mSaeF8jNBNGf3jYP1Wrs6
         lTmcZLahh8gcCDKVlX4nO9eQW5ceIPBBXrW43eIGe5jVZi66JMSz8oaly/CwpORoKEhz
         xiTkPZgkmgni9r8qqZentk/mxWqHa/fmOGE4tKwSSIslw7JVAq60YCPpbcoRT9FKBCKx
         I9hsb2HIW02wwK5M3SntbE/94Ct7td1puJEJB+q/qUvHcwYrFg09PJ4C1tYz5g2+pjrV
         lPWfUJxVafpxhQecyTOrNzycMEx0bWql+BqLwBOTYJ0RRtVY2Cfiw0gb1dZuDu0MwJq5
         iD7Q==
X-Gm-Message-State: AOJu0YwlUnJAzS/LMybd2JNgKAl3O0GHTgIYw/hz+XEtbn2C1GsPFxJp
	KC55aQEi//gBZViDCiAb4pE7CAQE2sB7PapwHzT0IJv/SDuXl1UYo9xxF4cy
X-Gm-Gg: ASbGncs42Doez71Ehx+H13wiPz0VVymyB1+7vbvFyrVzT78aimnI0JYGJT9QxBa0uMu
	hMU8Yig3lwhenmWG7wJh8VkiP9FNrrnZtUSZ5ZcDj1s1bZWJRln1lZKzYIQGy1pdComUDKhsbCR
	q4OKsc3HMypBgOIhpfKifiYy5HbrXVC8BPakRdE8BxqlQyGt4bJi/T0vF7ySjPfHqqMvvFJMb/x
	BFJ+2vxpeBHsdlfpk9So+nrd+Ls8IB9iUp9IJS8O/4fnMD8HkHrC8v+xgUz2MduaDnhhS5dHMFo
	FXaHe+M1ZD8qOJg5y4gQcddnu1QTW1mYeoZU2kxEMmEvCqyklOtanuoQaB/LZhgu+ob81vzlXp5
	8IA==
X-Google-Smtp-Source: AGHT+IGnG99MvFBv0aeAcenkC/9JJPmAdrK6Gv1t2I88hEhHRTs25Tm6iR+r0LaSw7twnnyVIIXtkg==
X-Received: by 2002:a05:6602:6cc6:b0:85e:21bd:8a00 with SMTP id ca18e2360f4ac-85e2ca8065dmr45249339f.8.1742496793240;
        Thu, 20 Mar 2025 11:53:13 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:12 -0700 (PDT)
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
Subject: [PATCH v2 10/59] dyndbg: replace classmap list with a vector
Date: Thu, 20 Mar 2025 12:51:48 -0600
Message-ID: <20250320185238.447458-11-jim.cromie@gmail.com>
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

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classes are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members.
The "select-by-modname" condition is reused to find the start,end of
the subrange.

NOTE: This "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie at least one step closer to ddebug_init(2),
which already splits up pr-debug descriptors into subranges by
modname, then calls (1) on each.  (2) knows nothing of classmaps
currently, and doesn't need to.  For now, just add comment.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 61 ++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ac199293d203..e458d4b838ac 100644
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
index dd7320b9616d..d5572712ce55 100644
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
@@ -1122,9 +1124,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1208,30 +1211,31 @@ static const struct proc_ops proc_fops = {
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
@@ -1263,10 +1267,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1379,8 +1382,8 @@ static void ddebug_remove_all_tables(void)
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
2.49.0


