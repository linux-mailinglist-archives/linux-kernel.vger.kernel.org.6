Return-Path: <linux-kernel+bounces-240505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7451926E62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B44B2333C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3F913D2BC;
	Thu,  4 Jul 2024 04:32:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920F13C9DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067530; cv=none; b=b4DmDS1OKdYmZUM1tw1cszEj0BVn8A/zbSLFiAK9avS40iCNPYrShvV8ly9oWzSikutx1LM5rBn2rUs4iBvkBEsLF3TM0z8dZwoIeDEAc+Z/r1nu17JN1QJrrcybUICVpj8BxC9vv1uhlpeoXF1Bwau8d8YI5zADNCAYtMgnA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067530; c=relaxed/simple;
	bh=6i0AByUNPycn/ZqdJjY0fr8AnD7wB3gAtGhx/AMwE5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaSeI2EherWVMzkPd9dJBcf/VI1ztBIbkCM0udI7Cq6oEk4bKgtWBNMxqK/OTLSzZ4DkRjQdYRzui5sGWFuPcXJGsHsJht1PddcY3gcXJxQSmrb7MxSAKNd5NElCEIzQ6/VxAGctRNa+sZOIm9COOx+0lfS6Jk4BZWyTi3qptPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 820001FCF7;
	Thu,  4 Jul 2024 04:32:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5043013889;
	Thu,  4 Jul 2024 04:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPLADsYlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:06 +0000
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
Subject: [PATCH 14/45] fs/proc: Create pagemap_pud_range to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:01 +0200
Message-ID: <20240704043132.28501-15-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 820001FCF7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Normal THP cannot be PUD-mapped (besides devmap) but hugetlb can,
so create pagemap_pud_range in order to handle PUD-mapped hugetlb vmas

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ec429d82b921..5965a074467e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1924,6 +1924,65 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return err;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int pagemap_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	pud_t pud;
+	int err = 0;
+	spinlock_t *ptl;
+	u64 flags = 0, frame = 0;
+	struct pagemapread *pm = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	ptl = pud_huge_lock(pudp, vma);
+	if (!ptl)
+		return err;
+
+	pud = *pudp;
+
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
+	if (pud_present(pud)) {
+		struct folio *folio = page_folio(pud_page(pud));
+
+		flags |= PM_PRESENT;
+		if (!folio_test_anon(folio))
+			flags |= PM_FILE;
+
+		if (!folio_likely_mapped_shared(folio))
+			flags |= PM_MMAP_EXCLUSIVE;
+
+		if (pud_soft_dirty(pud))
+			flags |= PM_SOFT_DIRTY;
+		if (pud_uffd_wp(pud))
+			flags |= PM_UFFD_WP;
+		if (pm->show_pfn)
+			frame = pud_pfn(pud) +
+				((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	} else if (pud_swp_uffd_wp(pud)) {
+		/* Only hugetlb can have swap entries at PUD level*/
+		flags |= PM_UFFD_WP;
+	}
+
+	for (; addr != end; addr += PAGE_SIZE) {
+		pagemap_entry_t pme = make_pme(frame, flags);
+
+		err = add_to_pagemap(&pme, pm);
+		if (err)
+			return err;
+		if (pm->show_pfn && (flags & PM_PRESENT))
+			frame++;
+	}
+	spin_unlock(ptl);
+
+	cond_resched();
+	return err;
+}
+#else
+#define pagemap_pud_range NULL
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
 static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
@@ -1980,6 +2039,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #endif /* HUGETLB_PAGE */
 
 static const struct mm_walk_ops pagemap_ops = {
+	.pud_entry      = pagemap_pud_range,
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
 	.hugetlb_entry	= pagemap_hugetlb_range,
-- 
2.26.2


