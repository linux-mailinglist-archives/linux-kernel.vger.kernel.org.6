Return-Path: <linux-kernel+bounces-247474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89892CFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4095E1F219B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AF192B74;
	Wed, 10 Jul 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A98K2eBm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j/VNTJ8g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rs4IeFFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t6BWMfnr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563C191F95
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608696; cv=none; b=f2Bk6y6mfrnWo3zNxAPnWngmIA0+7/W5EbJHMJYy5AR0IfhGbwPgmn78BSQ8gX8wn5yi2GHrUi7przHfTbfRxMMvK3waFEscff5tO6uqa5Hjv8ScOo3lZ9ZkicyQ9B9uc9RMJYuz3G+rHHP9WmvJxESakd+Mjn/kbIznE1xs44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608696; c=relaxed/simple;
	bh=ybqIPHDsajNAyasPWa/siY7VxuHeP9mYmsaiuNS9Z9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEmG5STOVo3cltCoc8ReMJV6lltjrC6A0Q25WpWk4GrP7GWeqsa0TjwR/lPC+SQWlz9MNjR7nNpkutvZvphYI8kenMcJR3yQ8cjdRV/8LEy3/Har9Yj6UWOBBgr8Tf88LLqA5aw6fS1XQpEyrC2y3CIaz2bjv5fLS48lBDmYS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A98K2eBm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j/VNTJ8g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rs4IeFFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t6BWMfnr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E21F121A3D;
	Wed, 10 Jul 2024 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7b0FFfloSBNSR2ZzezMp+fU3t5dKSCqfMIY6cE3U0k=;
	b=A98K2eBm6Gsqbion+I8upTty0hFnnNSEoZJDzP8V3Ba7Zd8avnjBnknSIEblzvcgRWO3f9
	7xTFJhTCQjH2Hq6tGHv4juQDJiWHP/5vdUjuLKqRFfQi7Im1E9JCcrwRa5A09W2oFetiIB
	11iXdwkRurVljAjqGqpWXIeVyeS4PtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7b0FFfloSBNSR2ZzezMp+fU3t5dKSCqfMIY6cE3U0k=;
	b=j/VNTJ8gVG5iHz8ywTjWTHn20BAe7Zgu3aD9+u+Ei2+8RVyx0Hfk6rgbHq0UxO64HONWBC
	p5bNzdbCwc84EBAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7b0FFfloSBNSR2ZzezMp+fU3t5dKSCqfMIY6cE3U0k=;
	b=rs4IeFFzhz69FMWvI0QKY00JQtl778j3n78qia0/IsoPc0P6GNP6iBmn8UOFrweyMGe4Md
	Xy87v1OVVvjvvuz/nc7EKHWWeRkgAa2kustip+8z2BPVKzM/SHL5ubgqlYQKI9dcWh9rYW
	PQcxbkGSx8kMqhv9vEUcDHH4184Qnno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7b0FFfloSBNSR2ZzezMp+fU3t5dKSCqfMIY6cE3U0k=;
	b=t6BWMfnrG2VPsHdWL347hUkhoiFuG1SE0aSsXFmtmrBxY0QA0RyX3XAgJUyybj2K3cD+H7
	PsC15Z+C8sHLNvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB26D1369A;
	Wed, 10 Jul 2024 10:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8L0uLbNnjmazcwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 10 Jul 2024 10:51:31 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 8/8] mm: Consolidate common checks in hugetlb_mmap_check_and_align
Date: Wed, 10 Jul 2024 12:50:42 +0200
Message-ID: <20240710105042.30165-9-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710105042.30165-1-osalvador@suse.de>
References: <20240710105042.30165-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL61jpu64h8b3ddwbzqogesdsf)];
	RCVD_TLS_ALL(0.00)[]

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
 arch/s390/include/asm/hugetlb.h      | 16 ----------------
 arch/sh/include/asm/hugetlb.h        | 15 ---------------
 fs/hugetlbfs/inode.c                 |  8 ++++++--
 include/asm-generic/hugetlb.h        |  7 -------
 7 files changed, 6 insertions(+), 63 deletions(-)

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
index ce5f4fe8be4d..38a10b47dc99 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -23,22 +23,6 @@ pte_t huge_ptep_get(pte_t *ptep);
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
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
index 722e60327615..82ec499feb41 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -180,8 +180,12 @@ hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
 
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
index 6dcf4d576970..d522581441e5 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -115,13 +115,6 @@ static inline int huge_pte_none_mostly(pte_t pte)
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


