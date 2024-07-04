Return-Path: <linux-kernel+bounces-240517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16421926E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B25CB251BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98319145A0B;
	Thu,  4 Jul 2024 04:32:26 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB03145347
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067546; cv=none; b=t/0P+V1tpeTem7PbHjDRv1SDI3hm/zIkIDz7bApBWbOvEBJH1vZxPtvsBvSewduZ2oVLNI8bSJrlmpy4O8Lr7FQdPtoSl9xnFvTMcc5txTJLnIayIDPj9Fgkl38FCJiIazpWHfkQYiI2W3odbvie+ypQB3iT6lbIfrMr337mqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067546; c=relaxed/simple;
	bh=tdPuf/5twvbRvm8RjGKcz4r5SkWuHK/Bp9g/YU26wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9zVvzes+thPiMIhUQYzvfbLqaIniXfeje0Z3qhzCnpM5fp2hApwMjCa7EUmj3DDZjJruBEorceeZS3fhyKku2cIbuq4CTSer4mAsmNKztPKQDcMNax+fAteteQHL/ChRm3yowO0SL18WHRrCZkXnmtObfcMKPLVbD51/xSgxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09ECD21180;
	Thu,  4 Jul 2024 04:32:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD1EE13889;
	Thu,  4 Jul 2024 04:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UADILdUlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:21 +0000
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
Subject: [PATCH 26/45] mm/damon: Enable damon_young_pmd_entry to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:13 +0200
Message-ID: <20240704043132.28501-27-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 09ECD21180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

PMD-mapped hugetlb vmas will also reach damon_young_pmd_entry.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/damon/vaddr.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58829baf8b5d..00d32beffe38 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -443,30 +443,35 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct folio *folio;
 	struct damon_young_walk_private *priv = walk->private;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(pmdp_get(pmd))) {
-		pmd_t pmde;
-
-		ptl = pmd_lock(walk->mm, pmd);
-		pmde = pmdp_get(pmd);
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+	ptl = pmd_huge_lock(vma, pmd);
+	if (ptl) {
+		unsigned long pfn;
 
-		if (!pmd_present(pmde)) {
+		if (!pmd_present(*pmd)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (!pmd_trans_huge(pmde)) {
-			spin_unlock(ptl);
-			goto regular_page;
+		pfn = pmd_pfn(*pmd);
+		if (is_vm_hugetlb_page(walk->vma)) {
+			folio = pfn_folio(pfn);
+			if (folio)
+				folio_get(folio);
+		} else {
+			folio = damon_get_folio(pfn);
 		}
-		folio = damon_get_folio(pmd_pfn(pmde));
 		if (!folio)
 			goto huge_out;
 		if (pmd_young(pmde) || !folio_test_idle(folio) ||
 					mmu_notifier_test_young(walk->mm,
 						addr))
 			priv->young = true;
-		*priv->folio_sz = HPAGE_PMD_SIZE;
+
+		if (is_vm_hugetlb_page(walk->vma))
+			*priv->folio_sz = huge_page_size(h);
+		else
+			*priv->folio_sz = HPAGE_PMD_SIZE;
 		folio_put(folio);
 huge_out:
 		spin_unlock(ptl);
@@ -474,7 +479,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}
 
 regular_page:
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif	/* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte) {
-- 
2.26.2


