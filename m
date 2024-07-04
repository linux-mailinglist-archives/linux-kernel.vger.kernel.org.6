Return-Path: <linux-kernel+bounces-240523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B1926E76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F38F289C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B91465BF;
	Thu,  4 Jul 2024 04:32:35 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415D146A60
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067554; cv=none; b=A9nintOcaeqiBaZDG1nmkCmchdnnY644KtjCG31ySJWShtj5gqywfA6BGmxLEkoMH1+XlwEB+PvzfvEmLH7JO3OBmt/Q9ILo5Nr5zytouopdjEQY0615FyI8ge1Iw9+zPti7+Tv0pPKD1X/qVdd1IBL4doZWYJNCDTtGC9P1E2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067554; c=relaxed/simple;
	bh=r9CxWPDak7WYAGHDmIZDqEsshTEdomdt6C4UzsZPCIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSuHXjmLRHigsRYoQC8+lMz7vHXNOqoqgb2bgBbOek8F7XVZas59ce2SNsD4garDI6tOfpGAEP2PmBZWcfBF8pXmGXGqhC7UuqJghtRfO8fH2FLo5cs5fiaTzyvoFqpTpjo2FV/I9HFDUxtDKWCPHGHx2nSK5QobqyRJ8MWT9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B3D621180;
	Thu,  4 Jul 2024 04:32:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7235D13889;
	Thu,  4 Jul 2024 04:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0HweF90lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:29 +0000
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
Subject: [PATCH 32/45] mm/hmm: Enable hmm_vma_walk_pmd, to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:19 +0200
Message-ID: <20240704043132.28501-33-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 8B3D621180
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

PMD-mapped hugetlb vmas will also reach hmm_vma_walk_pmd.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hmm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229ae4a5a..fbee08973544 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -183,7 +183,7 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 	       hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, unsigned long hmm_pfns[],
 			      pmd_t pmd)
@@ -206,11 +206,11 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		hmm_pfns[i] = pfn | cpu_flags;
 	return 0;
 }
-#else /* CONFIG_TRANSPARENT_HUGEPAGE */
+#else /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 /* stub to allow the code below to compile */
 int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		unsigned long end, unsigned long hmm_pfns[], pmd_t pmd);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
 static inline unsigned long pte_to_hmm_pfn_flags(struct hmm_range *range,
 						 pte_t pte)
@@ -336,7 +336,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
-	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
+	if (is_pmd_migration_entry(pmd)) {
 		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
 			hmm_vma_walk->last = addr;
 			pmd_migration_entry_wait(walk->mm, pmdp);
@@ -351,7 +351,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_devmap(pmd) || pmd_leaf(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
-- 
2.26.2


