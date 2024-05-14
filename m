Return-Path: <linux-kernel+bounces-178866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3628C58D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200351F22208
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF617EBBB;
	Tue, 14 May 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynDfwUYW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0817EBA1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700955; cv=none; b=rNSUMRFX6j5vz4iWF+hhjNOFi63TxLAdmMKvLrhzBUuYzf5O+zoczfz02kVu7iSQiq2kAkUcHFlic9J44r2nwcOCS33sdVZzk2Q4AohPnZbhHpSEwaRQGfkwsOAvTzE/0LSK4e7y52IRTuv5fWTQndZtGFrRBSQ6OspzvACB8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700955; c=relaxed/simple;
	bh=tyOLfaPN+vxyxmvRN25LjWKTOxGw/TP319a6bq49tsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p0rY0W/dzcxUZJS6Lbc6aX7wSpfnNnNr/Qmy09AaG82yA9+aG45kBr6MceikasIAgl5GgGtbp7kcaFwPnd16yzyrDj2LQj3wxACpI7hpocsLtAkG2ZR20uO+2dKrKsGT39SiPOISxNKciz2P0HzQbFsAYVxtExQiFsZA2ucnSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynDfwUYW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f9ca09so99430277b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715700952; x=1716305752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8h1heic/WIrKkqKhGl4cPRJjsIzjvgjOs1wUbMcKuFY=;
        b=ynDfwUYW+cvf9+xm+MI9Ojrd1a3pWQ1eMwSiVDRgo5hvJ34CY0ajJCLvQrnQcbxnzB
         F/jsiZJA1q3LkwABfDAzGIxBZxQqRhseh735q/W1Ol8QrWoMPwPw19Na8M8A7BGnqTMw
         d46WVyKjN1JBjt+HfRZGkgjgMn6BwOMRylL+jWHSkIpzbYbEOgsDZ9GFl0pnG/FT4mPc
         Ea8uYOOHvFr+ZXyc3gkd95KmZaqGv+zpQMnML9cvIYHR70ekfbY1PGpvsP3CBG/GgdyE
         WXCaJnArwoX2BTUJscw9lUkPpRkraFiHnQE2f1FbbZRJ9UHg/mIrAxXZZ65GZEO9uybv
         6fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700952; x=1716305752;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h1heic/WIrKkqKhGl4cPRJjsIzjvgjOs1wUbMcKuFY=;
        b=VGj1pNrSuboJ9CHwzI+H9IXi9cQBQDwrFfT+yfc2bsLBNljRdxrEvHGRf5p0qCAIrO
         O5m2o9DlyGJqBTmxSdahvb3nel/r0EFPibbf279MvnFCwngHBNB2DQ+0lTzJrfFaKgkX
         5S705PvJ2i/TR2CFST+XrGc3T4d+1AnIctDo2LUBzNJ25Y2ZSFnF2pcTYqD5U++H6d8q
         mJlaT1X4clUY1DX7QyPDPMo/iqeCiKog7y3LYKs3NOD1BoEVw0ZGsJ6lJ4+iZVA3tiMj
         M+AkNjgrqjq1qCGs8B9DFJfOUMhKoSmw2MDuGmlbRDj3ezyGc28u5hsVoMKTfy61xF1R
         EQSw==
X-Forwarded-Encrypted: i=1; AJvYcCWU/lnOfSEAVxfpszEmKCc4lHMW/a2WcKK2Up67hewPiWp4GrbGimMzwiYPX1HyN9ZXqukSN8lxw6UYctI8uf+7W4SmGUeBNw/4uxRF
X-Gm-Message-State: AOJu0YyC4y+KP3H1awL9WcCYl94gjRbk3HGOjyY+gS0meWcsCrgYku28
	4aCx8dm/DBtFr2GrBtnVDWyNn/ZysCj84yhqSTMxyZqz62bKJtP6eUzRM/3J9b5Xx97R3bUu6FO
	KnA==
X-Google-Smtp-Source: AGHT+IHHSpuTeQek++mFAxLfFAuVppDkYeHqFcKCHk5mMT50eANs346lK6L2OcocmRuT5s6DVjOePQGuj8k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:e8f6:c5d2:b646:f90d])
 (user=surenb job=sendgmr) by 2002:a05:690c:3802:b0:61b:e2ea:4d7b with SMTP id
 00721157ae682-622affa5943mr35383047b3.1.1715700952239; Tue, 14 May 2024
 08:35:52 -0700 (PDT)
Date: Tue, 14 May 2024 08:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514153532.3622371-1-surenb@google.com>
Subject: [PATCH 1/1] lib: add version into /proc/allocinfo output
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Add version string at the beginning of /proc/allocinfo to allow later
format changes. Exampe output:

> head /proc/allocinfo
allocinfo - version: 1.0
           0        0 init/main.c:1314 func:do_initcalls
           0        0 init/do_mounts.c:353 func:mount_nodev_root
           0        0 init/do_mounts.c:187 func:mount_root_generic
           0        0 init/do_mounts.c:158 func:do_mount_root
           0        0 init/initramfs.c:493 func:unpack_to_rootfs
           0        0 init/initramfs.c:492 func:unpack_to_rootfs
           0        0 init/initramfs.c:491 func:unpack_to_rootfs
         512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
         128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/filesystems/proc.rst |  4 +--
 lib/alloc_tag.c                    | 42 +++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 245269dd6e02..97d76adb1ecf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -961,13 +961,13 @@ Provides information about memory allocations at all locations in the code
 base. Each allocation in the code is identified by its source file, line
 number, module (if originates from a loadable module) and the function calling
 the allocation. The number of bytes allocated and number of calls at each
-location are reported.
+location are reported. The first line indicates the version of the file.
 
 Example output.
 
 ::
 
-    > sort -rn /proc/allocinfo
+    > tail -n +2 /proc/allocinfo | sort -rn
    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 531dbe2f5456..777b5cebf9a4 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -16,44 +16,51 @@ EXPORT_SYMBOL(_shared_alloc_tag);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
 
+struct allocinfo_private {
+	struct codetag_iterator iter;
+	bool print_header;
+
+};
+
 static void *allocinfo_start(struct seq_file *m, loff_t *pos)
 {
-	struct codetag_iterator *iter;
+	struct allocinfo_private *priv;
 	struct codetag *ct;
 	loff_t node = *pos;
 
-	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
-	m->private = iter;
-	if (!iter)
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	m->private = priv;
+	if (!priv)
 		return NULL;
 
+	priv->print_header = (node == 0);
 	codetag_lock_module_list(alloc_tag_cttype, true);
-	*iter = codetag_get_ct_iter(alloc_tag_cttype);
-	while ((ct = codetag_next_ct(iter)) != NULL && node)
+	priv->iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&priv->iter)) != NULL && node)
 		node--;
 
-	return ct ? iter : NULL;
+	return ct ? priv : NULL;
 }
 
 static void *allocinfo_next(struct seq_file *m, void *arg, loff_t *pos)
 {
-	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
-	struct codetag *ct = codetag_next_ct(iter);
+	struct allocinfo_private *priv = (struct allocinfo_private *)arg;
+	struct codetag *ct = codetag_next_ct(&priv->iter);
 
 	(*pos)++;
 	if (!ct)
 		return NULL;
 
-	return iter;
+	return priv;
 }
 
 static void allocinfo_stop(struct seq_file *m, void *arg)
 {
-	struct codetag_iterator *iter = (struct codetag_iterator *)m->private;
+	struct allocinfo_private *priv = (struct allocinfo_private *)m->private;
 
-	if (iter) {
+	if (priv) {
 		codetag_lock_module_list(alloc_tag_cttype, false);
-		kfree(iter);
+		kfree(priv);
 	}
 }
 
@@ -71,13 +78,18 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
 static int allocinfo_show(struct seq_file *m, void *arg)
 {
-	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
+	struct allocinfo_private *priv = (struct allocinfo_private *)arg;
 	char *bufp;
 	size_t n = seq_get_buf(m, &bufp);
 	struct seq_buf buf;
 
 	seq_buf_init(&buf, bufp, n);
-	alloc_tag_to_text(&buf, iter->ct);
+	if (priv->print_header) {
+		/* Output format version, so we can change it. */
+		seq_buf_printf(&buf, "allocinfo - version: 1.0\n");
+		priv->print_header = false;
+	}
+	alloc_tag_to_text(&buf, priv->iter.ct);
 	seq_commit(m, seq_buf_used(&buf));
 	return 0;
 }

base-commit: 7e8aafe0636cdcc5c9699ced05ff1f8ffcb937e2
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


