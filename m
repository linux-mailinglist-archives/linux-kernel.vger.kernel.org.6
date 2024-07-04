Return-Path: <linux-kernel+bounces-240509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C70926E65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A46D1C235A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE014386D;
	Thu,  4 Jul 2024 04:32:16 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68698142E9D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067536; cv=none; b=pkHRRWekrEAkYaHr7g3hAzGIFScIk+Mq4lmLgqDmt5RhYG8o9rYkAwcXpRRBp96r7p0rDmn7Kc2T4OhacvotLBY13AYz11lv3KV97xfpZPj72bZm+LnrKYY9h4hcWZDGjRhX+nCAzDA6c8sLFCpA2BMQyyJ/QobISMVEVEWeHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067536; c=relaxed/simple;
	bh=VjG0ahYT9ZkoRgpfIDg2JJhLkIe9bwBPt86aq3YnsiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihoHwKlgM+t7GrZveX2NOu3DwzATLv9wbLNYVdXNkUmxDv5xkK9St4yTxsTxHk4WDpT06pFgn+46j4je5oYR5ClMM49NlJ9q1BcUxOmQCm4BkYAsJu8+G3v3ZX87WehKWN/tm8wymBnBfPEey1Fi8N8hRQ9YRF2wKc7QS7UBw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB4731FCFA;
	Thu,  4 Jul 2024 04:32:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9738313889;
	Thu,  4 Jul 2024 04:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gC+BH8slhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:11 +0000
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
Subject: [PATCH 18/45] fs/proc: Create pagemap_scan_pud_entry to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:05 +0200
Message-ID: <20240704043132.28501-19-osalvador@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: BB4731FCFA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Normal THP cannot be PUD-mapped (besides devmap) but hugetlb can,
so create pagemap_scan_pud_entry in order to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 104 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index df649f69ea2c..3785a44b97fa 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1925,7 +1925,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return err;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static int pagemap_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
 			     struct mm_walk *walk)
 {
@@ -2324,6 +2324,59 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+static unsigned long pagemap_pud_category(struct pagemap_scan_private *p,
+					  struct vm_area_struct *vma,
+					  unsigned long addr, pud_t pud)
+{
+	unsigned long categories = PAGE_IS_HUGE;
+
+	if (pud_present(pud)) {
+		struct page *page;
+
+		categories |= PAGE_IS_PRESENT;
+		if (!pud_uffd_wp(pud))
+			categories |= PAGE_IS_WRITTEN;
+
+		if (p->masks_of_interest & PAGE_IS_FILE) {
+			page = vm_normal_page_pud(vma, addr, pud);
+			if (page && !PageAnon(page))
+				categories |= PAGE_IS_FILE;
+		}
+
+		if (is_zero_pfn(pud_pfn(pud)))
+			categories |= PAGE_IS_PFNZERO;
+		if (pud_soft_dirty(pud))
+			categories |= PAGE_IS_SOFT_DIRTY;
+	} else if (is_swap_pud(pud)) {
+		swp_entry_t swp;
+
+		categories |= PAGE_IS_SWAPPED;
+		if (!pud_swp_uffd_wp(pud))
+			categories |= PAGE_IS_WRITTEN;
+		if (pud_swp_soft_dirty(pud))
+			categories |= PAGE_IS_SOFT_DIRTY;
+	}
+
+	return categories;
+}
+
+static void make_uffd_wp_pud(struct vm_area_struct *vma,
+			     unsigned long addr, pud_t *pudp)
+{
+	pud_t old, pud = *pudp;
+
+	if (pud_present(pud)) {
+		old = pudp_invalidate_ad(vma, addr, pudp);
+		pud = pud_mkuffd_wp(old);
+		set_pud_at(vma->vm_mm, addr, pudp, pud);
+	} else if (is_migration_entry(pud_to_swp_entry(pud))) {
+		pud = pud_swp_mkuffd_wp(pud);
+		set_pud_at(vma->vm_mm, addr, pudp, pud);
+	}
+}
+#endif /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
+
 #ifdef CONFIG_HUGETLB_PAGE
 static unsigned long pagemap_hugetlb_category(pte_t pte)
 {
@@ -2685,6 +2738,54 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 	return ret;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int pagemap_scan_pud_entry(pud_t *pud, unsigned long start,
+				  unsigned long end, struct mm_walk *walk)
+{
+	int ret = 0;
+	spinlock_t *ptl;
+	unsigned long categories;
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemap_scan_private *p = walk->private;
+
+	/* Only PUD-mapped hugetlb can reach here at this moment */
+	ptl = pud_huge_lock(pud, vma);
+	if (!ptl)
+		return 0;
+
+	categories = p->cur_vma_category |
+		     pagemap_pud_category(p, vma, start, *pud);
+
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		goto out_unlock;
+
+	ret = pagemap_scan_output(categories, p, start, &end);
+	if (start == end)
+		goto out_unlock;
+
+	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
+		goto out_unlock;
+	if (~categories & PAGE_IS_WRITTEN)
+		goto out_unlock;
+
+	if (end != start + PUD_SIZE) {
+		ret = 0;
+		pagemap_scan_backout_range(p, start, end);
+		p->arg.walk_end = start;
+		goto out_unlock;
+	}
+
+	make_uffd_wp_pud(vma, start, pud);
+	flush_hugetlb_tlb_range(vma, start, end);
+
+out_unlock:
+	spin_unlock(ptl);
+	return ret;
+}
+#else
+#define pagemap_scan_pud_entry	NULL
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE
 static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 				      unsigned long start, unsigned long end,
@@ -2772,6 +2873,7 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
 
 static const struct mm_walk_ops pagemap_scan_ops = {
 	.test_walk = pagemap_scan_test_walk,
+	.pud_entry = pagemap_scan_pud_entry,
 	.pmd_entry = pagemap_scan_pmd_entry,
 	.pte_hole = pagemap_scan_pte_hole,
 	.hugetlb_entry = pagemap_scan_hugetlb_entry,
-- 
2.26.2


