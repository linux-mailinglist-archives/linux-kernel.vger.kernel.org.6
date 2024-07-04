Return-Path: <linux-kernel+bounces-240502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E365926E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6242855C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CD13C669;
	Thu,  4 Jul 2024 04:32:06 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACC13958F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067526; cv=none; b=TNONC98AKPJl8TfHs5IQWEXp3y9wAUycqBtv/KV5izKL4+2umTXBqLMnjJDkG+N7I2wIVWxvNpWzOIG5lu4PXeXfXsjq8LkDiE6TNyhxjvUp9A4aupybikjLzQhwZHaoRvnTiLOdVL0i+3huZSqdkWHsoy9uAlqAEToMC64JRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067526; c=relaxed/simple;
	bh=tGhPdhSralDuwi+M9bpSezY1Kw7wQDFoR77boM1eqjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBacm6j4tOsKs1m8sn7g8/qr4FvAZ19chNTo23pzg3ftn2v4sdqGYuZ1buLutot4nF1p4xhHt1tfmZ9Fk7CynIFqHMqW/qQiCbquqpq5dezH88uS1+GSYTZFSgm+iLY6POrAekqUWDXi9av6aPuricW32lexCYtHXZY898MXefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 770A51FCFD;
	Thu,  4 Jul 2024 04:32:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9D013889;
	Thu,  4 Jul 2024 04:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IPAUDcIlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:02 +0000
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
Subject: [PATCH 11/45] fs/proc: Enable smaps_pte_entry to handle cont-pte mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:30:58 +0200
Message-ID: <20240704043132.28501-12-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 770A51FCFD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

HugeTLB pages can be cont-pte mapped, so teach smaps_pte_entry to handle
them.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c      | 19 +++++++++++++------
 include/linux/pgtable.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f3460ff03b0..4d94b6ce58dd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -825,6 +825,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	struct page *page = NULL;
 	bool present = false, young = false, dirty = false;
 	pte_t ptent = ptep_get(pte);
+	unsigned long size = pte_cont(ptent) ? PAGE_SIZE * CONT_PTES : PAGE_SIZE;
 
 	if (pte_present(ptent)) {
 		page = vm_normal_page(vma, addr, ptent);
@@ -834,18 +835,18 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
-		if (!non_swap_entry(swpent)) {
+		if (!is_vm_hugetlb_page(vma) && !non_swap_entry(swpent)) {
 			int mapcount;
 
-			mss->swap += PAGE_SIZE;
+			mss->swap += size;
 			mapcount = swp_swapcount(swpent);
 			if (mapcount >= 2) {
-				u64 pss_delta = (u64)PAGE_SIZE << PSS_SHIFT;
+				u64 pss_delta = (u64)size << PSS_SHIFT;
 
 				do_div(pss_delta, mapcount);
 				mss->swap_pss += pss_delta;
 			} else {
-				mss->swap_pss += (u64)PAGE_SIZE << PSS_SHIFT;
+				mss->swap_pss += (u64)size << PSS_SHIFT;
 			}
 		} else if (is_pfn_swap_entry(swpent)) {
 			if (is_device_private_entry(swpent))
@@ -860,7 +861,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, young, dirty, locked, present);
+	if (is_vm_hugetlb_page(vma))
+		mss_hugetlb_update(mss, page_folio(page), vma, pte);
+	else
+		smaps_account(mss, page, false, young, dirty, locked, present);
 }
 
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
@@ -952,6 +956,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long size, cont_ptes;
 
 	ptl = pmd_huge_lock(pmd, vma);
 	if (ptl) {
@@ -965,7 +970,9 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
-	for (; addr != end; pte++, addr += PAGE_SIZE)
+	size = pte_cont(ptep_get(pte)) ? PAGE_SIZE * CONT_PTES : PAGE_SIZE;
+	cont_ptes = pte_cont(ptep_get(pte)) ? CONT_PTES : 1;
+	for (; addr != end; pte += cont_ptes, addr += size)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
 out:
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a9edeb86b7fe..991137dab87e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1926,6 +1926,18 @@ typedef unsigned int pgtbl_mod_mask;
 #define CONT_PMDS 0
 #endif
 
+#ifndef pte_cont
+#define pte_cont(x) false
+#endif
+
+#ifndef CONT_PTE_SIZE
+#define CONT_PTE_SIZE 0
+#endif
+
+#ifndef CONT_PTES
+#define CONT_PTES 0
+#endif
+
 /*
  * We always define pmd_pfn for all archs as it's used in lots of generic
  * code.  Now it happens too for pud_pfn (and can happen for larger
-- 
2.26.2


