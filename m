Return-Path: <linux-kernel+bounces-240499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8056926E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64698283538
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575743B782;
	Thu,  4 Jul 2024 04:32:03 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770F6DD0D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067522; cv=none; b=olfN9O35vIM/rVB6kn2ZqCL7RW/aubssWC0PfdLrhuqeSceNnubW1VE2N6XOJlK3Fv931dg85zAaaTVGDuRrAMfSUnMV/C2RNifUZsG5U3t7U7ceqkh8pqiAczqMo+4IW5++PEXm0wJkuIHdwwWfWzBAHs+loPNdz2/0ASMRcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067522; c=relaxed/simple;
	bh=y25WqAsEYH7fwKRx+uFvYqGe8nKyVWi2BDSC44TtPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl5JI8jDfBqTtZiCTWwfgMXLPJSFQ4kSGBv4vJrsRQROGdzsAPF7VZmCYs3Qh/BSvlgiLrCKtCaT7kiuCPyig3kCV5cXukDk5h9pQddTiYZPXsIBcyyn8tuYDdyBHaldZFYCKp4AFE6Z2FXlzWdpjRFBEVJC4MaUgOF1sB8X1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 824D71FCF7;
	Thu,  4 Jul 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F5B113889;
	Thu,  4 Jul 2024 04:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AKLwEr4lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:58 +0000
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
Subject: [PATCH 08/45] fs/proc: Enable smaps_pmd_entry to handle PMD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:30:55 +0200
Message-ID: <20240704043132.28501-9-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 824D71FCF7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

PMD-mapped hugetlb vmas will also reach smaps_pmd_entry.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 775a2e8d600c..78d84d7e2353 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -804,6 +804,18 @@ static void smaps_pte_hole_lookup(unsigned long addr, struct mm_walk *walk)
 #endif
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static void mss_hugetlb_update(struct mem_size_stats *mss, struct folio *folio,
+			       struct vm_area_struct *vma, pte_t *pte)
+{
+	if (folio_likely_mapped_shared(folio) ||
+	    hugetlb_pmd_shared(pte))
+		mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
+	else
+		mss->private_hugetlb += huge_page_size(hstate_vma(vma));
+}
+#endif
+
 static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		struct mm_walk *walk)
 {
@@ -851,12 +863,13 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	smaps_account(mss, page, false, young, dirty, locked, present);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		struct mm_walk *walk)
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool hugetlb = is_vm_hugetlb_page(vma);
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
 	bool present = false;
@@ -865,7 +878,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
-	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+	} else if (is_swap_pmd(*pmd)) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
 		if (is_pfn_swap_entry(entry))
@@ -874,6 +887,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (IS_ERR_OR_NULL(page))
 		return;
 	folio = page_folio(page);
+
+	if (hugetlb) {
+		mss_hugetlb_update(mss, folio, vma, (pte_t *)pmd);
+		return;
+	}
+
 	if (folio_test_anon(folio))
 		mss->anonymous_thp += HPAGE_PMD_SIZE;
 	else if (folio_test_swapbacked(folio))
@@ -900,7 +919,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_huge_lock(pmd, vma);
 	if (ptl) {
 		smaps_pmd_entry(pmd, addr, walk);
 		spin_unlock(ptl);
-- 
2.26.2


