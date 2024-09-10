Return-Path: <linux-kernel+bounces-322604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7592C972B60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D761F23ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC7D188CD6;
	Tue, 10 Sep 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="giYkk7zX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uCeWmHNi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="giYkk7zX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uCeWmHNi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECD188591
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955260; cv=none; b=nTxV6Ne7sLSXhs6CBnZj7F1wDbZs/fHZv7cijd1tcnzgPqU+HYkwZTcvIpvaUDXx+04ZJsdz3Qg34RUx8I5pxIkGllLtiQArJMwwYaKcTbKW9Kg5BeAiJP6OwsF8728JMG12Jh0dukYl7+G9rONfQPlet3al5nJYbTBmHHmaNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955260; c=relaxed/simple;
	bh=8eEqmN4G8Rn5jUT514gJxGi/t89cOnF4YrN75lqHmb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPeK1s1609OV7AYsC9SkOJGed9CaNEGaEmczc2gMMDZ+Te2hSUIJOx7s8Oxn9JrDmRzej9zfg88Oqax+5KGoJes7aQM2Xmg7B4oZHNZxhsixNHjeJStlDc+nOUCUP5PeMtoTnZx1H14kqp/QgUVZ15deagwrDeY2mBCl7zA8jaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=giYkk7zX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uCeWmHNi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=giYkk7zX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uCeWmHNi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D57D421A41;
	Tue, 10 Sep 2024 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDltFrQL6gOEy4l6VLVTy9j8S44tPEMq7/+b46Xvkc=;
	b=giYkk7zXHO/VOT4TuhTNSNl4gT0+qh8Og4h40nMzbBJdkf0jxf2tIRrWuMdIcHLLJ3ihIQ
	0GmSecGp3egdIS8gzGkUKxJco1eF08+P9TlvdVLnfhQa2MLPcUeju7n6vuCq7eV8VKGa/6
	rl7Es7D5Cs8ORNk16yJgPHvjUsJyiPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDltFrQL6gOEy4l6VLVTy9j8S44tPEMq7/+b46Xvkc=;
	b=uCeWmHNiOO0qicZD+hBu97YjyCz59gAOvid1pqOyFdSroieAtCXJKoYGD2jxi4WdYxl+ba
	1P0uJ3A3Zi8NHpAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=giYkk7zX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uCeWmHNi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDltFrQL6gOEy4l6VLVTy9j8S44tPEMq7/+b46Xvkc=;
	b=giYkk7zXHO/VOT4TuhTNSNl4gT0+qh8Og4h40nMzbBJdkf0jxf2tIRrWuMdIcHLLJ3ihIQ
	0GmSecGp3egdIS8gzGkUKxJco1eF08+P9TlvdVLnfhQa2MLPcUeju7n6vuCq7eV8VKGa/6
	rl7Es7D5Cs8ORNk16yJgPHvjUsJyiPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDltFrQL6gOEy4l6VLVTy9j8S44tPEMq7/+b46Xvkc=;
	b=uCeWmHNiOO0qicZD+hBu97YjyCz59gAOvid1pqOyFdSroieAtCXJKoYGD2jxi4WdYxl+ba
	1P0uJ3A3Zi8NHpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26273132CB;
	Tue, 10 Sep 2024 08:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GF00Brf832Y2MQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 10 Sep 2024 08:00:55 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 9/9] mm: Consolidate common checks in hugetlb_get_unmapped_area
Date: Tue, 10 Sep 2024 10:00:30 +0200
Message-ID: <20240910080030.1272373-10-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910080030.1272373-1-osalvador@suse.de>
References: <20240910080030.1272373-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D57D421A41
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLsw5aryjsbtotqfh5i7tfsykm)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

prepare_hugepage_range() performs almost the same checks for all
architectures that define it, with the exception of mips and loongarch
that also check for overflows.
The rest checks for the addr and len to be properly aligned, so we can
move that to hugetlb_get_unmapped_area() and get rid of a fair amount of
duplicated code.

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
index 5da32c00d483..bf41b024b6a4 100644
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
index b6a619f5a85a..cd49d21e7284 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -181,8 +181,12 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
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
2.46.0


