Return-Path: <linux-kernel+bounces-240514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06573926E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AB91C2383A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC0144D23;
	Thu,  4 Jul 2024 04:32:22 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33291448D2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067542; cv=none; b=dIW5E9Q88mH/BAK4/abKimmOaz+i065YJGGmWFJ3GoFzaDVGUToIR+2aOSu/Iaz+tO4c+RAHmUj2J6o/sxMs2a81fywTY9/dlEpEohtbjZQtwuqXQB6Xz3Z0C890EQMNE4ir/65DrN40LYDWpnRiFH3Em7ZsnWtFX5YKJON+608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067542; c=relaxed/simple;
	bh=n8CwSRarq4ActNGgFQhYTPVt1+MvFBSEx/o9wxAsuUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOeY6lPaZPwL5ZTr3coj5j4UVIgUBjsV4H/z+sfpiEAw1LGaLuBIb12BIwLjO/Iw23E/thA6mcmUVnu8hduCGZ3RmJsKZk0DXBDJMk5FhCOvxCDFc6CQ0i1AiwwH7NIDteOCqUnjattU6AiI0klqbVaORpFSclkEanQcXPdqeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B07D21C0D;
	Thu,  4 Jul 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06B6F13889;
	Thu,  4 Jul 2024 04:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMqbONElhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:17 +0000
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
Subject: [PATCH 23/45] mm/mempolicy: Create queue_folios_pud to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:10 +0200
Message-ID: <20240704043132.28501-24-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 2B07D21C0D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
queue_folios_pud in order to handle PUD-mapped hugetlb vmas.
Also implement is_pud_migration_entry and pud_folio, as they will be used in this patch.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/pgtable.h |  1 +
 include/linux/swapops.h | 12 ++++++++++++
 mm/mempolicy.c          | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 458e3cbc96b2..23d51fec81ac 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -51,6 +51,7 @@
 #endif
 
 #define pmd_folio(pmd) page_folio(pmd_page(pmd))
+#define pud_folio(pud) page_folio(pud_page(pud))
 
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 182957f0d013..a23900961d11 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -542,6 +542,18 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 
 struct page_vma_mapped_walk;
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline int is_pud_migration_entry(pud_t pud)
+{
+	return is_swap_pud(pud) && is_migration_entry(pud_to_swp_entry(pud));
+}
+#else
+static inline int is_pud_migration_entry(pud_t pud)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 extern int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5baf29da198c..93b14090d484 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -501,6 +501,37 @@ static inline bool queue_folio_required(struct folio *folio,
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
 }
 
+static int queue_folios_pud(pud_t *pud, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct vm_area_struct *vma = walk->vma;
+	struct queue_pages *qp = walk->private;
+
+	ptl = pud_huge_lock(pud, vma);
+	if (!ptl)
+		return 0;
+
+	if (unlikely(is_pud_migration_entry(*pud))) {
+		qp->nr_failed++;
+		goto out;
+	}
+	folio = pud_folio(*pud);
+	if (!queue_folio_required(folio, qp))
+		goto out;
+	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
+	    !vma_migratable(walk->vma) ||
+	    !migrate_folio_add(folio, qp->pagelist, qp->flags, walk->vma, false))
+		qp->nr_failed++;
+
+	spin_unlock(ptl);
+out:
+	if (qp->nr_failed && strictly_unmovable(qp->flags))
+		return -EIO;
+	return 0;
+}
+
 static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 {
 	struct folio *folio;
@@ -730,6 +761,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
 	.hugetlb_entry		= queue_folios_hugetlb,
+	.pud_entry		= queue_folios_pud,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 	.walk_lock		= PGWALK_RDLOCK,
-- 
2.26.2


