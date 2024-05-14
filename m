Return-Path: <linux-kernel+bounces-178954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911808C59C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FCB1C215C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A65FEE4;
	Tue, 14 May 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Todc5KTi"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC61E516
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704294; cv=none; b=tNeWQXcZ8CZEWixHFKOULEMoRED6HA1eDG+rGN7NCdoCA2jhHfrtaodec82LIjxXcZiJ3KUjB4DYck0ojTWFJcsKtHzfM2DpncpQYZgmYrlXiru2rdhQxZrK7lWHYxYC8NQil73addAjQevkk2Ts+WTsEowMQhT3/awuQdvjFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704294; c=relaxed/simple;
	bh=rE7C4vtwa8/uDMo2Wgp+2p9AlpJrvqpyAqwxVawPprQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qRmhEugRtxwlO+pMIaGzjVBiGTquVPgkQhlNKpJ9zsD4x2XiVMpNVncYPurwcYBg4s3IHNG8WKx8xyuJwCL997lzQ/+dLR/HCixGCIOo+UtUpyvXFfgKkfrlU6Ej9kmKNiSVN3QsVc/IrEqDghcqDvVcNuGztbLyvSXZMNX8MdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Todc5KTi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60321ce6cso10466310276.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715704292; x=1716309092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYV+SMOQiamlhj9PR1ancAtyOBQwhK6fsau38j27Dhw=;
        b=Todc5KTihZbph7wGN7+EnC/oJvpH7BkmfRT8iTk/Ap5UvYSnXjPPUDmxE54hV1Jbhe
         8W4Hwl5EdYRTxiaAcPkYK7Z8d8kvraM5XdqmUliW+O3QqHiUF8Nzbe2QmeIynzRWdHNg
         kIBWxMdF7PjQ6a9Z8fazRXPxbf5RaAIh1viOrBaCRIgDE9358MsQSRgze+QCbPnw7QgS
         uA214fe2KQ9oZhcn1RoF1NdItswFBZXhghsGs58V5Hk5rwdKzUbbjCyGMWEkDMafc2/O
         ihMA03I2EtzCntjST0QwDZEqVo08Y1YKOoAeS6qtj9CT9uVVxg1XEsFQEFo39melG9UR
         DDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715704292; x=1716309092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYV+SMOQiamlhj9PR1ancAtyOBQwhK6fsau38j27Dhw=;
        b=Dw6Rtw/mXIcQLSQ29w9dTqDaRisBJX9Cya5x92aLQVkndgaz2sE8ETt3xqNkA07QXy
         RSOI4toxePMNRQQZ6UX2z0ijcuHcWc1U2hRJb5ErOx65v+e/+iDrufHey9P+jc2MKYjA
         k6b+awJCAqCKi1lhKa1EHcaSc48DyBfFz3PccvBlbHYJvltdlQUl8Vb8v3ro0n4vgR/K
         ewQtiVBxQ52fVzQPIl/vxxLVWKtUzzjapJndcAbDFgTIRaUffNnvY+bCQlc3GuasV+Wo
         BZNQTDEPJeQivs+xaonZM5td+sDGAi/r+Js2YpdNiD1n25ERQ//I+vHfPgzKrY6B2+FL
         qlqA==
X-Forwarded-Encrypted: i=1; AJvYcCUEsq90owxcAxUyhcj97na4+Bg8vPnNzdGgqktaVn94FuZF6CeNR4JyJUU0EZiQp39qgYmzCUFfDBkqfCQzp7G++zRVxICIrmZFtbX/
X-Gm-Message-State: AOJu0YyZ4FoWOyl1D63Qbtv6WSiTqIRTa5m69bK1tKYdY8c/e2xEVON7
	jSpbmwRduNJoiOThHueWuQRCdMU13VFvHiOGFCiG46o7hkHL0JVVJgvPSlTCEq29HFGfSIZrK/x
	zuw==
X-Google-Smtp-Source: AGHT+IH8tWOuykXAgU5Pee8JW3hexeYZkHO8+gPnARCp67pA23h8mZSsUc7ypioRDnfO1jlvRbsOhwVLSfc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:e8f6:c5d2:b646:f90d])
 (user=surenb job=sendgmr) by 2002:a05:6902:1027:b0:dcc:c57c:8873 with SMTP id
 3f1490d57ef6-dee4f3659c5mr3649331276.9.1715704292212; Tue, 14 May 2024
 09:31:32 -0700 (PDT)
Date: Tue, 14 May 2024 09:31:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514163128.3662251-1-surenb@google.com>
Subject: [PATCH v2 1/1] lib: add version into /proc/allocinfo output
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Add version string and a header at the beginning of /proc/allocinfo to
allow later format changes. Example output:

> head /proc/allocinfo
allocinfo - version: 1.0
#     <size>  <calls> <tag info>
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
Changes since v1 [1]:
- Added header with field names, per Pasha Tatashin
- Fixed a spelling error in the changelog

[1] https://lore.kernel.org/all/20240514153532.3622371-1-surenb@google.com/

 Documentation/filesystems/proc.rst |  5 ++--
 lib/alloc_tag.c                    | 48 ++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 245269dd6e02..4b71b3903d46 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -961,13 +961,14 @@ Provides information about memory allocations at all locations in the code
 base. Each allocation in the code is identified by its source file, line
 number, module (if originates from a loadable module) and the function calling
 the allocation. The number of bytes allocated and number of calls at each
-location are reported.
+location are reported. The first line indicates the version of the file, the
+second line is the header listing fields in the file.
 
 Example output.
 
 ::
 
-    > sort -rn /proc/allocinfo
+    > tail -n +3 /proc/allocinfo | sort -rn
    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 531dbe2f5456..cbe93939332d 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -16,47 +16,61 @@ EXPORT_SYMBOL(_shared_alloc_tag);
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
 
+static void print_allocinfo_header(struct seq_buf *buf)
+{
+	/* Output format version, so we can change it. */
+	seq_buf_printf(buf, "allocinfo - version: 1.0\n");
+	seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
+}
+
 static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 {
 	struct alloc_tag *tag = ct_to_alloc_tag(ct);
@@ -71,13 +85,17 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
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
+		print_allocinfo_header(&buf);
+		priv->print_header = false;
+	}
+	alloc_tag_to_text(&buf, priv->iter.ct);
 	seq_commit(m, seq_buf_used(&buf));
 	return 0;
 }

base-commit: 7e8aafe0636cdcc5c9699ced05ff1f8ffcb937e2
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


