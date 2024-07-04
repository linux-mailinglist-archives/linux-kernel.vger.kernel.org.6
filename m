Return-Path: <linux-kernel+bounces-240519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BB926E72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821DE1F237D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30079145B3F;
	Thu,  4 Jul 2024 04:32:29 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BE145B01
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067548; cv=none; b=emcTr2karXgXeuZ6ugx4Kt9F3k3N39loN7MsTXrny2uJid4tWETfMs4ppUnSOgiVkno/SWkVZATzpcu82guRqIFNAMoXp23KzAeu0cNsbfDQpFlIBgxbKhnZFgrlHJSRAzTiBqrm2QPmAFso8ctRh4KUSKUY2xkGIiZNH0GUbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067548; c=relaxed/simple;
	bh=IjVgFFhoVqDdp8QfTsBGLnFIesfrSQbxw+JNIYiTa5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7cwLkmE+7YykkxZ5MWryZMc3VoQAQi4nKp0p+/eeBuX2SVBh36Lv0b4OdEYMYc7HvKMzp0COZAvrmHf0kM9AfcAENH2MwffesJXhLjadCe1ZRYdwOpv2sReAirQNJ1cm2PevgDqQ4zAhlPbOMCbxKSNAdYEU9tQ+eFrc/+07EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94F3A21C10;
	Thu,  4 Jul 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6893D13889;
	Thu,  4 Jul 2024 04:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EK8YFNglhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:24 +0000
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
Subject: [PATCH 28/45] mm/damon: Enable damon_mkold_pmd_entry to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:15 +0200
Message-ID: <20240704043132.28501-29-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 94F3A21C10
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

PMD-mapped hugetlb vmas will also reach damon_mkold_pmd_entry.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/damon/ops-common.c | 21 ++++++++++++++++-----
 mm/damon/vaddr.c      | 15 +++++----------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2b..6727658a3ef5 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -53,18 +53,29 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+	struct folio *folio;
+	unsigned long size;
+
+	if (is_vm_hugetlb_page(vma)) {
+		folio = pfn_folio(pdm_pfn(*pmd))
+		folio_get(folio);
+		size = huge_page_size(hstate_vma(vma));
+	} else {
+		folio = damon_get_folio(pmd_pfn(*pmd));
+		size = PMD_SIZE;
+	}
 
 	if (!folio)
-		return;
+		return 0;
 
-	if (pmdp_clear_young_notify(vma, addr, pmd))
+	if (pmdp_test_and_clear_young(vma, addr, pmd) ||
+	    mmu_notifier_clear_young(mm, addr, addr + size))
 		folio_set_young(folio);
 
 	folio_set_idle(folio);
 	folio_put(folio);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /*CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 }
 
 #define DAMON_MAX_SUBSCORE	(100)
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2d5ad47b9dae..47c84cdda32c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -304,21 +304,16 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmde;
 	spinlock_t *ptl;
 
-	if (pmd_trans_huge(pmdp_get(pmd))) {
-		ptl = pmd_lock(walk->mm, pmd);
-		pmde = pmdp_get(pmd);
-
-		if (!pmd_present(pmde)) {
+	ptl = pmd_huge_lock(walk->vma, pmd);
+	if (ptl) {
+		if (!pmd_present(*pmd)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (pmd_trans_huge(pmde)) {
-			damon_pmdp_mkold(pmd, walk->vma, addr);
-			spin_unlock(ptl);
-			return 0;
-		}
+		damon_pmdp_mkold(pmd, walk->vma, addr);
 		spin_unlock(ptl);
+		return 0;
 	}
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-- 
2.26.2


