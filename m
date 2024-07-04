Return-Path: <linux-kernel+bounces-240518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87A926E70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A239B20EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF9145B10;
	Thu,  4 Jul 2024 04:32:27 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9F1459E6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067547; cv=none; b=k0PuzpWUDI3SwesMdwVDehaHD3KlH1rFXWEe6nxptwzrNLass+HNMTru3SPnbMO8oWFlL/iBIZoyxU5pn7EM0CeqsFN5Dc2ev69GJKaAC0a6mQXwLEUlGe3UpwgxVvBqbACQ6ylSknVbSunrN4JHdpX0nV31RRUAkqsrL5KjrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067547; c=relaxed/simple;
	bh=DDM1CyCr7sw5ilryaMX/F+7wIWAeswYRZs0JW6CsuOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joUxN9BIxbOel/k6OzjgP5cg/LYTLjC3gmhYzBxoneh7tD/azqw9EnjMbD899Pb9dWN7EYWQZO3Ju0/YpH9iVcQh8zl1FbyDrKaot2/MVbgB771iUSdfrtvpj8WJyCAsLOyAMdJJtbbUr3hH2EBHHNO4hut6Wp5k7rnVeQACe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E2C1FCF8;
	Thu,  4 Jul 2024 04:32:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22FA613889;
	Thu,  4 Jul 2024 04:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YJuNA9clhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:23 +0000
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
Subject: [PATCH 27/45] mm/damon: Create damon_young_pud_entry to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:14 +0200
Message-ID: <20240704043132.28501-28-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 41E2C1FCF8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
damon_young_pud_entry in order to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/damon/vaddr.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 00d32beffe38..2d5ad47b9dae 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -434,6 +434,39 @@ struct damon_young_walk_private {
 	bool young;
 };
 
+static int damon_young_pud_entry(pmd_t *pud, unsigned long addr,
+				 unsigned long next, struct mm_walk *walk)
+{
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct damon_young_walk_private *priv = walk->private;
+
+	ptl = pud_huge_lock(vma, pud);
+	if (!ptl)
+		return 0;
+
+	if (!pud_present(*pud))
+		goto out;
+
+	folio = pfn_folio(pud_pfn(*pud));
+	if (!folio)
+		goto out;
+	folio_get(folio);
+
+	if (pud_young(pmde) || !folio_test_idle(folio) ||
+	    mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = huge_page_size(h);
+	folio_put(folio);
+out:
+	spin_unlock(ptl);
+#endif
+	return 0;
+}
+
+
 static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
@@ -537,6 +570,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static const struct mm_walk_ops damon_young_ops = {
+	.pud_entry = damon_young_pud_entry,
 	.pmd_entry = damon_young_pmd_entry,
 	.hugetlb_entry = damon_young_hugetlb_entry,
 	.walk_lock = PGWALK_RDLOCK,
-- 
2.26.2


