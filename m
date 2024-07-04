Return-Path: <linux-kernel+bounces-240513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9CB926E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724C1B24D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50181448FF;
	Thu,  4 Jul 2024 04:32:21 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D1144303
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067541; cv=none; b=lUcvwTPkXUyq89LDlXTVgfm5NFxzlrORcYERI3wzjpF7kW3XQtxGi4byHnFNkFaAgt42kh4EnzQVAXj1215ElJvNWnj6PeiQzhtESTNZ5zzHIRvwBGUg0HJ5hPnhIltbumgW8sDlElpqRyiFTRxI4sYeAvjMfylwbYCmEa2H6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067541; c=relaxed/simple;
	bh=ciNhVhOKdrAaNI83ufvC/pkkbqW7liVHKSpNFuH+6Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXoz1MyqY4x8eV+VXFE4i1st1JqOxSy7rKwbV6MxJCiKCf9HaeqTNzqvT8S9DpXotY/MLF50Y1f476XVxudO1O0HUzOnIb4avPRKi/ez0T+dKoaVivyg3Alb+NwluceIaIUSHZpFBZ9y/mUvO4FBIwyZbkzzsw579tMGY6Ckyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB2C41FCFD;
	Thu,  4 Jul 2024 04:32:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D9D13889;
	Thu,  4 Jul 2024 04:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iBXOKtAlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:16 +0000
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
Subject: [PATCH 22/45] mm/mempolicy: Enable queue_folios_pmd to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:09 +0200
Message-ID: <20240704043132.28501-23-osalvador@suse.de>
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
X-Rspamd-Queue-Id: DB2C41FCFD
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
 include/linux/mm_inline.h |  7 +++++++
 mm/mempolicy.c            | 42 ++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 93e3eb86ef4e..521a001429d2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -591,6 +591,13 @@ static inline bool vma_has_recency(struct vm_area_struct *vma)
 	return true;
 }
 
+static inline bool is_shared_pmd(pmd_t *pmd, struct vm_area_struct *vma)
+{
+	if (!is_vm_hugetlb_page(vma))
+		return false;
+	return hugetlb_pmd_shared((pte_t *)pmd);
+}
+
 static inline spinlock_t *pmd_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f8703feb68b7..5baf29da198c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -455,7 +455,8 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 };
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
-				unsigned long flags);
+				unsigned long flags, struct vm_area_struct *vma,
+				bool shared);
 static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 				pgoff_t ilx, int *nid);
 
@@ -518,7 +519,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma) ||
-	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
+	    !migrate_folio_add(folio, qp->pagelist, qp->flags, walk->vma,
+			       is_shared_pmd(pmd, walk->vma)))
 		qp->nr_failed++;
 }
 
@@ -543,7 +545,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t ptent;
 	spinlock_t *ptl;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_huge_lock(pmd, vma);
 	if (ptl) {
 		queue_folios_pmd(pmd, walk);
 		spin_unlock(ptl);
@@ -598,7 +600,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 		if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 		    !vma_migratable(vma) ||
-		    !migrate_folio_add(folio, qp->pagelist, flags)) {
+		    !migrate_folio_add(folio, qp->pagelist, flags, vma, false)) {
 			qp->nr_failed++;
 			if (strictly_unmovable(flags))
 				break;
@@ -1025,8 +1027,11 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 
 #ifdef CONFIG_MIGRATION
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
-				unsigned long flags)
+			      unsigned long flags, struct vm_area_struct *vma,
+			      bool shared)
 {
+	bool ret = true;
+	bool is_hugetlb = is_vm_hugetlb_page(vma);
 	/*
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
@@ -1034,23 +1039,27 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	 * See folio_likely_mapped_shared() on possible imprecision when we
 	 * cannot easily detect if a folio is shared.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || !folio_likely_mapped_shared(folio)) {
-		if (folio_isolate_lru(folio)) {
-			list_add_tail(&folio->lru, foliolist);
-			node_stat_mod_folio(folio,
-				NR_ISOLATED_ANON + folio_is_file_lru(folio),
-				folio_nr_pages(folio));
-		} else {
+	if ((flags & MPOL_MF_MOVE_ALL) ||
+	    (!folio_likely_mapped_shared(folio) && !shared)) {
+		if (is_hugetlb)
+			return isolate_hugetlb(folio, foliolist);
+
+		ret = folio_isolate_lru(folio);
+		if (!ret)
 			/*
 			 * Non-movable folio may reach here.  And, there may be
 			 * temporary off LRU folios or non-LRU movable folios.
 			 * Treat them as unmovable folios since they can't be
 			 * isolated, so they can't be moved at the moment.
 			 */
-			return false;
-		}
+			return ret;
+
+		list_add_tail(&folio->lru, foliolist);
+		node_stat_mod_folio(folio,
+			NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			folio_nr_pages(folio));
 	}
-	return true;
+	return ret;
 }
 
 /*
@@ -1239,7 +1248,8 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 #else
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
-				unsigned long flags)
+				unsigned long flags, struct vm_area_struct *vma,
+				bool shared)
 {
 	return false;
 }
-- 
2.26.2


