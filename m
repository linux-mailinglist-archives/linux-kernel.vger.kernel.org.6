Return-Path: <linux-kernel+bounces-570214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4AA6ADEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42584A164B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0C22F173;
	Thu, 20 Mar 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDE9ZT0+"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6A22DFAA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496812; cv=none; b=Qn2TDNIQksRulWdOfE2x7l2mveQ3bs+pVdwZQ+dsQ86AUQ40D5/1K4aPjEYGNeCeAefBsfuM5k253uaE0errYodx2wNfMrARa5Jg4Ei93uqPyQPANt/LGzjTkliidmUKz2ztBnu0uRhGnXlGezn/F4itMANjBnh5ymrmYsjQ3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496812; c=relaxed/simple;
	bh=wMVZ/catocoPi6ar1KAn7P/F7YueWg8DlMTGaJ3mKDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7JhnBE1vFmrV/UA69sm510wGeqFJo/w7j1roSgMplqAf5oFPsxXboKmnb8eEtbEQEqre9wmLg23mI5m8SDG/r3Xgtw+mFfqQUv3OjICwQO2GSTvglt0iBXrRDc28hoVhy4kNHLtFHIgV2wBNaMowIEGnXWHh/uI2fjKE7Epn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDE9ZT0+; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85dac9728cdso28594839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496809; x=1743101609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miAnMW+G7+NaoZuEayKbHBb91/weN+swVxu5PtIC79I=;
        b=VDE9ZT0+lxYnBHFprnuEO/slSvncAsuz5rbVwzZaph8sG5ofjLzhcs/QkiVjRCNHf5
         k2WqvV0CAVp0vTITSSVwHXo+pf7Z+1K4JR45AQEo/qCX1Z10NttljRDUuAcCNIK6rtu7
         Lb7VqryrJ5zaKCMLr1r4ePYtJKJAb2f2J1+oTS5BBNMaZUpIHNxFjOsnHIvdOaDj+lXB
         z3SLJosxU6IRPm6dY8AW/g9I1Wf8FJcPxy2ACm9/RKAzGedX7gRkSde4Wi7fpSU8T8V/
         hcxfGAGT/L2UGajtLz0nk2HAGEx4UFYOSWe/piX9ruUv6lSKSsQuZ/H50DbTTtkCRLbH
         XTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496809; x=1743101609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miAnMW+G7+NaoZuEayKbHBb91/weN+swVxu5PtIC79I=;
        b=hMMYtWtkd+cygDFBZ3LXGI/8HEXH6tW8QPxzuw3pntJtc66HJI4bqurx77ynVJpcej
         NaLyiT2cYK/32qlhAGu51Eg6esKk1AaUcbGmOJDYXQ8/uBlkMbcwWn9bZdCs8khMdE//
         a6THgPTdEtXCJj1gjO2d+dQjnAXrUGEAHX9HSst/FQX2+lurP/CvtqjcXY06jGW/YIB0
         fL/Fz5pX5sOSu/zK2BO5ex6pnadMMkRZ/zYx4PGzjgKHYF0KYphqN53LX/fgN0A5VS/V
         9rBfftue3ZvQZfZJKaCoMHxlrPUjCx2+jA+y4t0xMXWQi+ScfOOjWdk+P3zgchtw4jME
         htzg==
X-Gm-Message-State: AOJu0Yz49Xshp0JIDUto+XaO9icH27XdO2ljFAgG+DDrrLED8c7xF4fG
	HMLq8goCBXsIRe3jlSzq0PwOMFIip766dKFM+vkPuCCRi8KJ3/ciRpE5q3Ea
X-Gm-Gg: ASbGncs/vCnCp7G0uAIEi+28HrYyZJCCE7I1fGT/F10uHgWSs0DvouhvAogwt9Hkdkv
	RK+bRhRciZZZ9FLEbrMu1TiEtzBYkw4EYSOA6cem0Q9hzQiJZgymmPaJA7LeaLiUY9WYZkSEYeK
	NMxeZRHVifTczJQMH+Kor8HJZZl9nkX+4JhhOLQcaRQIfZq2Chu4B9sRRQKsqdse94bTpfkVPxA
	9t4HNhZeWfr+naMHNzAMLEY4WbMZQoGIl4yXJd+JZ68r0kSsFTdO1AgiGIv7NEsxe9nyXDIVhyP
	nRub7rrLM3hcfm9PjOaXHPZa+0lNu1rnuR0YMU/HRD+vzH6VJLGbLBqZo6iNDWM9GUCPCO2vcLx
	s2g==
X-Google-Smtp-Source: AGHT+IH8NGUJWZDIAw9cJiX8xKNRxEy2HrBp//+fKWV20TsAyodyKB+bj0tCWt8XGY6BDeLYkZ+T1g==
X-Received: by 2002:a05:6602:488b:b0:85e:1879:c708 with SMTP id ca18e2360f4ac-85e2ca388bbmr48595939f.1.1742496808909;
        Thu, 20 Mar 2025 11:53:28 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:28 -0700 (PDT)
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
Subject: [PATCH v2 23/59] dyndbg: move .mod_name from/to structs ddebug_table/_ddebug_info
Date: Thu, 20 Mar 2025 12:52:01 -0600
Message-ID: <20250320185238.447458-24-jim.cromie@gmail.com>
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

struct _ddebug_info already has almost all dyndbg's info for a module,
so finish the encapsulation.  This puts the datum closer to where its
needed, improving the chance that we can obsolete the _ddebug.modame
field with a desc_modname(dp) accessor fn.

In static ddebug_add_module(&_ddebug_info_cursor..), force the
cursor-model by dropping the modname arg, and setting it explicitly
into the cursor before the 3 calls to it.

struct ddebug_table only uses .mod_name when applying >control
changes, and it has a _ddebug_info member anyway, so it keeps access
to the field, just with a different offset.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  1 +
 lib/dynamic_debug.c           | 41 ++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 03a83a83b621..8043966a0fd6 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -198,6 +198,7 @@ struct _ddebug_class_users {
 } __packed;
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 	struct _ddebug_class_users users;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3c9fb8324ad6..cd3eec5bb81c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,7 +49,6 @@ extern struct _ddebug_class_user __stop___dyndbg_class_users[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -166,7 +165,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 #define vpr_dt_info(dt_p, msg_p, ...) ({				\
 	struct ddebug_table const *_dt = dt_p;				\
 	v2pr_info(msg_p " module:%s nd:%d nc:%d nu:%d\n", ##__VA_ARGS__, \
-		  _dt->mod_name, _dt->info.descs.len, _dt->info.maps.len, \
+		  _dt->info.mod_name, _dt->info.descs.len, _dt->info.maps.len, \
 		  _dt->info.users.len);					\
 	})
 
@@ -215,7 +214,7 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->mod_name))
+		    !match_wildcard(query->module, dt->info.mod_name))
 			continue;
 
 		if (query->class_string) {
@@ -283,7 +282,7 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  dt->info.mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1123,7 +1122,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   iter->table->info.mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_putc(m, '"');
@@ -1283,7 +1282,7 @@ static void ddebug_apply_class_users(const struct ddebug_table *dt)
 #define dd_mark_vector_subrange(_i, _dst, _sp, _box, _vec) ({	\
 	int nc = 0;							\
 	for_subvec(_i, _sp, _box, _vec) {				\
-		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
+		if (!strcmp((_sp)->mod_name, (_dst)->info.mod_name)) {	\
 			if (!nc++)					\
 				(_dst)->info._vec.start = (_sp);	\
 		} else {						\
@@ -1314,7 +1313,7 @@ ddebug_class_range_overlap(struct _ddebug_class_map *cm,
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
+static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
@@ -1325,20 +1324,19 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
+	v3pr_info("add-module: %s %d sites\n", di->mod_name, di->descs.len);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", modname);
+		pr_err("error adding module: %s\n", di->mod_name);
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name lives in .rodata and is
-	 * immortal. For loaded modules, name points at the name[]
-	 * member of struct module, which lives at least as long as
-	 * this struct ddebug_table.
+	 * For built-in modules, name (as supplied in di by its
+	 * callers) lives in .rodata and is immortal. For loaded
+	 * modules, name points at the name[] member of struct module,
+	 * which lives at least as long as this struct ddebug_table.
 	 */
-	dt->mod_name = modname;
 	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
@@ -1368,10 +1366,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	if (dt->info.users.len)
 		ddebug_apply_class_users(dt);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 cleanup:
-	WARN_ONCE("dyndbg multi-classmap conflict in %s\n", modname);
+	WARN_ONCE("dyndbg multi-classmap conflict in %s\n", di->mod_name);
 	kfree(dt);
 	return -EINVAL;
 
@@ -1436,7 +1434,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1456,7 +1454,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1556,7 +1555,8 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1567,7 +1567,8 @@ static int __init dynamic_debug_init(void)
 	}
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 
-- 
2.49.0


