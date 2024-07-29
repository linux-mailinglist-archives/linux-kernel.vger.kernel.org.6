Return-Path: <linux-kernel+bounces-265405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764893F0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84971F22FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF8144316;
	Mon, 29 Jul 2024 09:10:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D8143C5C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244250; cv=none; b=Q643yer92pJvXTJcx6JDt3mna79G6fWZyD5eQGsfgvp4Lyaktxk+Cct4SnEkCwz5EtGwTOaqqJSoSIP3CKRBR8Uh5t1c8Iy7qhiUUdFgHveWclFKxz5B0eZveuJPvgPMJOh1S1qjTs/pxxL8JRRrDJM7/T/sJR+QUq8NlUiIMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244250; c=relaxed/simple;
	bh=kVok2J6n/h1H3nLs/VaLRUGy8aB8TzxNm01kkxsgytY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwdvTuE4+JQV629/UgjlfTRQkuT0VauLoeWxWoqPLcp9+Rhlizhq63rDb3yrVvZnYpzCWYuF6QCtB6h+oWYLUIhRbVH14yZCeZwEtgOL70+MmiMN1aMl61S4jsKqBOW6+EDx996rViOUsUTMdskT0VdL5PbbZdFCeOVDn7JQ2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E4FF1F794;
	Mon, 29 Jul 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4411D1368A;
	Mon, 29 Jul 2024 09:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iPArC5Vcp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:45 +0000
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
Subject: [PATCH v2 9/9] mm: Consolidate common checks in hugetlb_mmap_check_and_align
Date: Mon, 29 Jul 2024 11:10:18 +0200
Message-ID: <20240729091018.2152-10-osalvador@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9E4FF1F794
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

prepare_hugepage_range() performs almost the same checks for all
architectures that define it, with the exception of mips and loongarch
that also check for overflows.
The rest checks for the addr and len to be properly aligned, so we can
move that to the generic hugetlb_mmap_check_and_align() function and get
rid of a fair amount of duplicated code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/loongarch/include/asm/hugetlb.h |  4 ----
 arch/mips/include/asm/hugetlb.h      |  4 ----
 arch/parisc/include/asm/hugetlb.h    | 15 ---------------
 arch/s390/include/asm/hugetlb.h      | 17 -----------------
 arch/sh/include/asm/hugetlb.h        | 15 ---------------
 fs/hugetlbfs/inode.c                 |  8 ++++++--
 include/asm-generic/hugetlb.h        |  7 -------
 7 files changed, 6 insertions(+), 64 deletions(-)

diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index aa44b3fe43dd..107566c98938 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -18,10 +18,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	unsigned long task_size = STACK_TOP;
 	struct hstate *h = hstate_file(file);
 
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
 	if (len > task_size)
 		return -ENOMEM;
 	if (task_size - len < addr)
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index fd69c8808554..6a63d82a8ab3 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -19,10 +19,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	unsigned long task_size = STACK_TOP;
 	struct hstate *h = hstate_file(file);
 
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
 	if (len > task_size)
 		return -ENOMEM;
 	if (task_size - len < addr)
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 72daacc472a0..5b3a5429f71b 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -12,21 +12,6 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep);
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
-static inline int prepare_hugepage_range(struct file *file,
-			unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 37e80a32623a..6f815d4ba0ca 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -25,23 +25,6 @@ extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep
 extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
-static inline int prepare_hugepage_range(struct file *file,
-			unsigned long addr, unsigned long len)
-{
-	struct hstate *h = hstate_file(file);
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-	return 0;
-}
-
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
 	clear_bit(PG_arch_1, &folio->flags);
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index 75028bd568ba..4a92e6e4d627 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -5,21 +5,6 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
-static inline int prepare_hugepage_range(struct file *file,
-			unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3f0b8abbf851..1e35f0d3698b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -176,8 +176,12 @@ hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if ((flags & MAP_FIXED) && prepare_hugepage_range(file, addr, len))
-		return -EINVAL;
+	if (flags & MAP_FIXED) {
+		if (addr & ~huge_page_mask(h))
+			return -EINVAL;
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+	}
 	if (addr)
 		addr0 = ALIGN(addr, huge_page_size(h));
 
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 67bbdafcfc22..f42133dae68e 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -123,13 +123,6 @@ static inline int huge_pte_none_mostly(pte_t pte)
 static inline int prepare_hugepage_range(struct file *file,
 		unsigned long addr, unsigned long len)
 {
-	struct hstate *h = hstate_file(file);
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-
 	return 0;
 }
 #endif
-- 
2.45.2


