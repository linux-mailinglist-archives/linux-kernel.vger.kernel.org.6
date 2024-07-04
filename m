Return-Path: <linux-kernel+bounces-240501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F0926E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9AB23AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631A13A3ED;
	Thu,  4 Jul 2024 04:32:05 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B413698E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067525; cv=none; b=om1ONVPrZeGxzVQ02bVKn1Vpygw40rBb3lNb5Jf4KyVaIj47BNJtntrucT745TK+XUgX0lG2U10Ux+dk3atp+r0U9hECuuhSQNgfhDBJRj0y8thpj5WFHfpzPDZbPP/7XgtGrDdwTKivRw51GJ2VrUhZtwR1DPZMDs/turP6NJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067525; c=relaxed/simple;
	bh=7J11hfigJ61V9ZKKSCxcuGfKdKkC/8ZzJ7ODULGmkWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6Jc7eM00EpXrnDqA9xGqMeoulsooj3y9T5cu64BlqPHriKtzyn4KP3TVbFML1H/LXRx/cDddm6sntDSBoRWHCrb78HK4EoPVtMiTt3JrSgcB914XBZs/itni5Z+aHPjoWBGjBirudp83/UBZdorsOetYTEv44ZgMusQVPsNAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26D7421C0D;
	Thu,  4 Jul 2024 04:32:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01D7013889;
	Thu,  4 Jul 2024 04:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MCZPN8AlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:00 +0000
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
Subject: [PATCH 10/45] fs/proc: Create smaps_pud_range to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:30:57 +0200
Message-ID: <20240704043132.28501-11-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 26D7421C0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
smaps_pud_range in order to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 78d84d7e2353..3f3460ff03b0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -912,6 +912,40 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int smaps_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
+			   struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct vm_area_struct *vma = walk->vma;
+	struct mem_size_stats *mss = walk->private;
+
+	ptl = pud_huge_lock(pudp, vma);
+	if (!ptl)
+		return 0;
+
+	if (pud_present(*pudp)) {
+		folio = vm_normal_folio_pud(vma, addr, *pudp);
+	} else if (is_swap_pud(*pudp)) {
+		/* PUD-hugetlbs can have swap entries */
+		swp_entry_t swpent = pud_to_swp_entry(*pudp);
+
+		if (is_pfn_swap_entry(swpent))
+			folio = pfn_swap_entry_folio(swpent);
+	}
+
+	if (folio)
+		/* Only for now hugetlb pages can end up here */
+		mss_hugetlb_update(mss, folio, vma, (pte_t *)pudp);
+
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define smaps_pud_range NULL
+#endif
+
 static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			   struct mm_walk *walk)
 {
@@ -1061,12 +1095,14 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 #endif /* HUGETLB_PAGE */
 
 static const struct mm_walk_ops smaps_walk_ops = {
+	.pud_entry              = smaps_pud_range,
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static const struct mm_walk_ops smaps_shmem_walk_ops = {
+	.pud_entry              = smaps_pud_range,
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 	.pte_hole		= smaps_pte_hole,
-- 
2.26.2


