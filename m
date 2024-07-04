Return-Path: <linux-kernel+bounces-240512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D20926E69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B251F2415E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805913BBCC;
	Thu,  4 Jul 2024 04:32:20 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EC143C6A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067540; cv=none; b=kGbNlHsQ004bGOeEzWvJVDTPr4M5jYqew2ujTRAm1LPYAG7/Z8GNKfVY5D8Ayk7wQNXeAXTgY1g62nfyEpCMDfg3mFZf9OKWLy5Lw52vlxtLEd8BKDAxvnKW8Lhh9V1Ov90V4dzS6Y4HITMzkwzAZ6maOoTsHSd22rjkt11KRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067540; c=relaxed/simple;
	bh=BwkWUXeKM8j1YJaQTaCDSmN0oO/MPcXx5cwB7kNu+5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyqggYfDZDSYxB9b4ml2KE1xVhSNzZTvTqymVVYD4aLSkfuY7ppu920Ux8VLabLzAqs5C+jO7HdznBD/7ZIaLaSzCYxmfxODoOvs45AzBi4wVc52oaIoII0CBJxq8kOtm9jVmgEhwveCLuXPUxokqxqkk16Ajq7kX8VJArGjXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8ED61FCF7;
	Thu,  4 Jul 2024 04:32:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D23B13889;
	Thu,  4 Jul 2024 04:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KYBFs8lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:15 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 21/45] fs/proc: Create gather_pud_stats to handle PUD-mapped hugetlb pages
Date: Thu,  4 Jul 2024 06:31:08 +0200
Message-ID: <20240704043132.28501-22-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A8ED61FCF7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
gather_pud_stats in order to handle PUD-mapped hugetlb vmas.
Also implement can_gather_numa_stats_pud which is the pud version of
can_gather_numa_stats_pmd.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/include/asm/pgtable.h |  1 +
 fs/proc/task_mmu.c               | 56 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5e26e63b1012..1a6b8be2f0d0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -590,6 +590,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
+#define pud_dirty(pud)		pte_dirty(pud_pte(pud))
 #define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 98dd03c26e68..5df17b7cfe6c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3141,6 +3141,61 @@ static struct page *can_gather_numa_stats(pte_t pte, struct vm_area_struct *vma,
 	return page;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static struct page *can_gather_numa_stats_pud(pud_t pud,
+					      struct vm_area_struct *vma,
+					      unsigned long addr)
+{
+	struct page *page;
+	int nid;
+
+	if (!pud_present(pud))
+		return NULL;
+
+	page = pud_page(pud);
+	if (!page)
+		return NULL;
+
+	if (PageReserved(page))
+		return NULL;
+
+	nid = page_to_nid(page);
+	if (!node_isset(nid, node_states[N_MEMORY]))
+		return NULL;
+
+	return page;
+}
+
+static int gather_pud_stats(pud_t *pud, unsigned long addr,
+			    unsigned long end, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct page *page;
+	unsigned long nr_pages;
+	struct numa_maps *md = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	ptl = pud_huge_lock(pud, vma);
+	if (!ptl)
+		return 0;
+
+	if (is_vm_hugetlb_page(vma))
+		nr_pages = 1;
+	else
+		nr_pages = HPAGE_PUD_SIZE / PAGE_SIZE;
+
+	page = can_gather_numa_stats_pud(*pud, vma, addr);
+	if (page)
+		gather_stats(page, md, pud_dirty(*pud),
+			     nr_pages);
+
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define gather_pud_stats	NULL
+#endif
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 					      struct vm_area_struct *vma,
@@ -3245,6 +3300,7 @@ static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 
 static const struct mm_walk_ops show_numa_ops = {
 	.hugetlb_entry = gather_hugetlb_stats,
+	.pud_entry = gather_pud_stats,
 	.pmd_entry = gather_pte_stats,
 	.walk_lock = PGWALK_RDLOCK,
 };
-- 
2.26.2


