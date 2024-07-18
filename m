Return-Path: <linux-kernel+bounces-256287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93739934C18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF13284CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3A13C660;
	Thu, 18 Jul 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5eI1VcQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4rbEJ+Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5eI1VcQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4rbEJ+Y"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CB13AA51
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300363; cv=none; b=u37pizUTDZ6NBYqlSQbcx9CwlGD/UBlVUZpRSVQsmWNednXEYTb3R2+0Hv/Gjqhu2755ga+/87kId6Gpcyasqo34yqAA81zvCRWSLf2utvUsLC0LeGfHh+uv7pa1iKZ2oln3JZqzgN/2J0duM43F5vc6HhW7RLuiHoCJUcswSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300363; c=relaxed/simple;
	bh=Z5xwROHzxoXWJTzZ5jfEtK825wqYsYEDnx+2qEPVX30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB3dYmTVJHfsvpWT0rVOlfu/ETJXJBgBTG7T1QC3bVsWVIhg34yFDi3QMGU/1PCJDGWkEjWBZbmkheU7yyX8TLMMzQlbBpI/k2pmHS1cSziZQlhOxl8owoitFDONkDl1UaOH4UGtUwT2swblnPndpWMvZeVCgpAuRCGTnkpLmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5eI1VcQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4rbEJ+Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5eI1VcQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4rbEJ+Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 407C91FBBE;
	Thu, 18 Jul 2024 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sPGyH5z7l/pm0TX/hh9KWyWWpcRI/yb9hB1nzYK2f0=;
	b=z5eI1VcQIrnLNx2Z0oK330o9OEByJyUoURwS49Ys44trBlZ/l7ix0vn9EWT1GWuyZGhjUs
	r2LtEo47jmzw0u57xl9/9M8Q4UxrQIwAjGjEYaGcxEfach1ESHp437POhkkzYPZCF5ZD9y
	Y2LHEodX4at6FpHiaDavKdKcccmTfqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sPGyH5z7l/pm0TX/hh9KWyWWpcRI/yb9hB1nzYK2f0=;
	b=X4rbEJ+Yn1vnB9FjpFiteKUi4ZJqJ/ZU1kpljjScD/+NNRgV18aVF/aYxaHV6hClFIckw8
	3Yf5i9Bv93dYvSBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sPGyH5z7l/pm0TX/hh9KWyWWpcRI/yb9hB1nzYK2f0=;
	b=z5eI1VcQIrnLNx2Z0oK330o9OEByJyUoURwS49Ys44trBlZ/l7ix0vn9EWT1GWuyZGhjUs
	r2LtEo47jmzw0u57xl9/9M8Q4UxrQIwAjGjEYaGcxEfach1ESHp437POhkkzYPZCF5ZD9y
	Y2LHEodX4at6FpHiaDavKdKcccmTfqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sPGyH5z7l/pm0TX/hh9KWyWWpcRI/yb9hB1nzYK2f0=;
	b=X4rbEJ+Yn1vnB9FjpFiteKUi4ZJqJ/ZU1kpljjScD/+NNRgV18aVF/aYxaHV6hClFIckw8
	3Yf5i9Bv93dYvSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F5E7136F7;
	Thu, 18 Jul 2024 10:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YEPXB4f1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:19 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags
Date: Thu, 18 Jul 2024 12:59:00 +0200
Message-ID: <20240718105903.19617-7-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240718105903.19617-1-osalvador@suse.de>
References: <20240718105903.19617-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

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
index 81dab95f67ed..d02b4bc6c5e9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -257,15 +257,22 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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
@@ -1302,7 +1309,6 @@ static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
-	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
 	.fop_flags		= FOP_HUGE_PAGES,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1c7b0b32ff7e..9183ef95dfb6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -555,11 +555,9 @@ static inline struct hstate *hstate_inode(struct inode *i)
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
index 09131b705e7b..8130b25b8cf5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1860,6 +1860,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 				  unsigned long, unsigned long, unsigned long)
 				  = NULL;
 
+	bool is_hugetlb = false;
 	unsigned long error = arch_mmap_check(addr, len, flags);
 	if (error)
 		return error;
@@ -1868,6 +1869,9 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
+	if (file && is_file_hugepages(file))
+		is_hugetlb = true;
+
 	if (file) {
 		if (file->f_op->get_unmapped_area)
 			get_area = file->f_op->get_unmapped_area;
@@ -1885,11 +1889,20 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
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


