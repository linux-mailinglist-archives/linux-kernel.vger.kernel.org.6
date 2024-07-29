Return-Path: <linux-kernel+bounces-265402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC293F0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C20D1C2197A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D513DBB7;
	Mon, 29 Jul 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NBotca+t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="14BhT2RB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NBotca+t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="14BhT2RB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A1142E8D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244244; cv=none; b=ArfG4wy7fUrNKOxpAQZMd8SfMY7YV9G+uIoUXaHoocPSi6+M9uxHyGvkaDhs/ft1GO+XuLdtJu1m+gUCwkvzENSXIpz545UbPldNSqoM1UMkgPXv2Owu9ZylVOJFQld/6SkW9J2e/pViBSPgBj52TooLhKz5ETRqWLIyl3lEaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244244; c=relaxed/simple;
	bh=BbWAl6iTUX3Xn1n0ukfD0VIqCh2vEyR9AWD2ZEjuvFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzsTSNlOSHDaBttjLiiwKyR8slux3Rz695vVkpLghG+V4EzmnrzQoDTeoilhD6U9tKEdNFfV3/SS9pOqwJ81bRdup1fjXxKj89U11CFYATj4TjGqXOLr2RmosaF1UCbaaGavE9MgAhfk3ZLnB4Uc/RB7kjFqviH4FklYZUMhdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NBotca+t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=14BhT2RB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NBotca+t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=14BhT2RB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D81A21BC1;
	Mon, 29 Jul 2024 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722244241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0D03v0CNtg8d+Z2YRTExLn0FsjKOf1vcUEKVYVI3qZA=;
	b=NBotca+t+NBVJkyG1KJ2BeT9oBB/GpLOboqMQvQRyRmYQLl3N6NHlzOVlDWDH1sORtTOhA
	1zUXHQqSgna1nRsWzLZzaXfnvWLAeI5drBIMYRa/l6YP5SLGieif5frv4j3qGDpo5bK2v7
	dvqvFn4MiD+m6D0JmS4htP6SQZtPagI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722244241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0D03v0CNtg8d+Z2YRTExLn0FsjKOf1vcUEKVYVI3qZA=;
	b=14BhT2RBgWuQS9/HaH/h2wDy/QpKlbdFsF/BybzmpSt4rFaVYQ3UWlxckbnxKScwK1hSUj
	ZImZpXgjy2e1LlDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722244241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0D03v0CNtg8d+Z2YRTExLn0FsjKOf1vcUEKVYVI3qZA=;
	b=NBotca+t+NBVJkyG1KJ2BeT9oBB/GpLOboqMQvQRyRmYQLl3N6NHlzOVlDWDH1sORtTOhA
	1zUXHQqSgna1nRsWzLZzaXfnvWLAeI5drBIMYRa/l6YP5SLGieif5frv4j3qGDpo5bK2v7
	dvqvFn4MiD+m6D0JmS4htP6SQZtPagI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722244241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0D03v0CNtg8d+Z2YRTExLn0FsjKOf1vcUEKVYVI3qZA=;
	b=14BhT2RBgWuQS9/HaH/h2wDy/QpKlbdFsF/BybzmpSt4rFaVYQ3UWlxckbnxKScwK1hSUj
	ZImZpXgjy2e1LlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 125F91368A;
	Mon, 29 Jul 2024 09:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IAAiO49cp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:39 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags
Date: Mon, 29 Jul 2024 11:10:15 +0200
Message-ID: <20240729091018.2152-7-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729091018.2152-1-osalvador@suse.de>
References: <20240729091018.2152-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	REPLY(-4.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.60

Hugetlb mappings will no longer be special cased but rather go through
the generic mm_get_unmapped_area_vmflags function.
For that to happen, let us remove the .get_unmapped_area from
hugetlbfs_file_operations struct, and hint __get_unmapped_area
that it should not send hugetlb mappings through thp_get_unmapped_area_vmflags
but through mm_get_unmapped_area_vmflags.

Create also a function called hugetlb_mmap_check_and_align() where a
couple of safety checks are being done and the addr is aligned to
the huge page size.
Otherwise we will have to do this in every single function, which
duplicates quite a lot of code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/hugetlbfs/inode.c    | 22 ++++++++++++++--------
 include/linux/hugetlb.h |  8 +++-----
 mm/mmap.c               | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..5d47a2785a5d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -258,15 +258,22 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 			pgoff, flags);
 }
 
-#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-static unsigned long
-hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags)
+unsigned long
+hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
+			     unsigned long len, unsigned long flags)
 {
-	return generic_hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
+	unsigned long addr0 = 0;
+	struct hstate *h = hstate_file(file);
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if ((flags & MAP_FIXED) && prepare_hugepage_range(file, addr, len))
+		return -EINVAL;
+	if (addr)
+		addr0 = ALIGN(addr, huge_page_size(h));
+
+	return addr0;
 }
-#endif
 
 /*
  * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
@@ -1300,7 +1307,6 @@ static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
-	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
 	.fop_flags		= FOP_HUGE_PAGES,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0ec14e5e0890..1413cdcfdb1a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -549,11 +549,9 @@ static inline struct hstate *hstate_inode(struct inode *i)
 }
 #endif /* !CONFIG_HUGETLBFS */
 
-#ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-					unsigned long len, unsigned long pgoff,
-					unsigned long flags);
-#endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
+unsigned long
+hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
+			     unsigned long len, unsigned long flags);
 
 unsigned long
 generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index 7b623811d82a..f755d8a298c5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -849,6 +849,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 				  unsigned long, unsigned long, unsigned long)
 				  = NULL;
 
+	bool is_hugetlb = false;
 	unsigned long error = arch_mmap_check(addr, len, flags);
 	if (error)
 		return error;
@@ -857,6 +858,9 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
+	if (file && is_file_hugepages(file))
+		is_hugetlb = true;
+
 	if (file) {
 		if (file->f_op->get_unmapped_area)
 			get_area = file->f_op->get_unmapped_area;
@@ -874,11 +878,20 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
-	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !is_hugetlb) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,
 						     pgoff, flags, vm_flags);
 	} else {
+		/*
+		 * Consolidate hugepages checks in one place, and also align addr
+		 * to hugepage size.
+		 */
+		if (is_hugetlb) {
+			addr = hugetlb_mmap_check_and_align(file, addr, len, flags);
+			if (IS_ERR_VALUE(addr))
+				return addr;
+		}
 		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
 						    pgoff, flags, vm_flags);
 	}
-- 
2.45.2


