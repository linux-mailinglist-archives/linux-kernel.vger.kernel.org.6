Return-Path: <linux-kernel+bounces-240516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB10D926E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88162289000
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3E145346;
	Thu,  4 Jul 2024 04:32:25 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A008145321
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067544; cv=none; b=se85nRSlXCcCatiV407qPoRrrb6skKxT2N2STrQgQbC1MUkVWJ97MbsUX5qWGPHN3FPalbL/2PI3kBj9U2dKsEqQcw1wDDwbh93KTyObJqQBgyLZqB3uDlvAE6FBuFsOzdFjyFhFEKNxUJ/dxJSB8uykjCQtK3UepvFk65dFP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067544; c=relaxed/simple;
	bh=bGPa2HcHFWxQQ0CcFTQOgWln/PaFjOUQol7Z0orXRkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSNnjYVc2x3ozlUeg7PPdN41uuikUg4LfqF1MOSSbSAXEEvEHjcXtEQNU4yuvfhmOqoxMsidPVDd3vJ9X7R46JX4KXnhiCx05vlJix5i5YraCqPVVXj8wURky6dEXVBI6RlMS29df73jcOUly13r+dTX4+UeqtJZcUMuV7yXi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABF721FD00;
	Thu,  4 Jul 2024 04:32:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D48513889;
	Thu,  4 Jul 2024 04:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sKv0HdQlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:20 +0000
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
Subject: [PATCH 25/45] mm/memory-failure: Create check_hwpoisoned_pud_entry to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:12 +0200
Message-ID: <20240704043132.28501-26-osalvador@suse.de>
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
X-Rspamd-Queue-Id: ABF721FD00
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
check_hwpoisoned_pud_entry in order to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8cae95e36365..622862c4c300 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -771,6 +771,43 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 	return 1;
 }
 
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+static int hwpoison_pud_range(pud_t *pudp, unsigned long addr,
+			      unsigned long end, struct mm_walk *walk)
+{
+	int ret = 0;
+	spinlock_t *ptl;
+	pud_t pud = *pudp;
+	unsigned long pfn;
+	struct hwpoison_walk *hwp = walk->private;
+
+	ptl = pud_huge_lock(pudp, walk->vma);
+	if (!ptl)
+		return 0;
+
+	if (pud_present(pud)) {
+		pfn = pud_pfn(pud);
+	} else {
+		swp_entry_t swp = pud_to_swp_entry(pud);
+
+		if (!is_hwpoison_entry(swp))
+			goto out_unlock;
+		pfn = swp_offset_pfn(swp);
+	}
+
+	if (!pfn || pfn != hwp->pfn)
+		goto out_unlock;
+
+	set_to_kill(&hwp->tk, addr, huge_page_shift(hstate_vma(walk->vma)));
+	ret = 1;
+out_unlock:
+	spin_unlock(ptl);
+	return ret;
+}
+#else
+hwpoison_pud_range NULL
+#endif
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
 				      struct hwpoison_walk *hwp,
@@ -862,6 +899,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #endif
 
 static const struct mm_walk_ops hwpoison_walk_ops = {
+	.pud_entry = hwpoison_pud_range,
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
 	.walk_lock = PGWALK_RDLOCK,
-- 
2.26.2


