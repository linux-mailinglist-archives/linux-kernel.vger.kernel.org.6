Return-Path: <linux-kernel+bounces-240515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A215926E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03FFB23831
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E6145343;
	Thu,  4 Jul 2024 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZZlPRFX8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DZydrxp6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZZlPRFX8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DZydrxp6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32747144D15
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067543; cv=none; b=leO7vEf4Ljb7X5acrfZrrUVvMDfBqbSGiyNsWfuZVioBCysOS8ja35P9cvKOZ4lQkaY/hBQGTPV17chlJhff5e2xcEG/n30ckrFqocAJxJE++/fQMMzo7Oe5ra3kl5MgLUOYMdIiEJ32c6q1YiJ6YqB+M4gWtpgh0SPAoS9XM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067543; c=relaxed/simple;
	bh=EXDhJ09O2OJ9GtxQDINsaKUIPFQVmSM1oh/3/rS4he4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKEZuhScsS5tVplstysaP1qBX1D3z+XMfz1IaZhEzg14Ij7OTHVbpns2qNP0N33EsaJ79jCRjcrvjkJuGbFq9YZEIfNDcJzGhKQ2mRso5RHQFaW7CIPx5+r+nNcl4/ebgwDr/FcJ+7Ta0pfPijQj+bDRm/iuGjUlcUhNZzSCGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZZlPRFX8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DZydrxp6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZZlPRFX8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DZydrxp6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CA131FCFE;
	Thu,  4 Jul 2024 04:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbU3NixA+ORa4pbwAalk6/qaoqPhUeSqtYDCOzcSsu0=;
	b=ZZlPRFX8HPVeyLyltxoPjntrB3vyrMGorhnSIvawEhprDCtQiJ8kvY1aBNeBJMEnFNoka7
	zEhX5cg2k/xkhsjTOrqeSfEe1lZe8CG3PQEh3+8UdhDAt9ff/QXS9LBS82y+sKrbT8fyYn
	t7/3YM8I8df36X7okK3RGPJBJuuuMoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbU3NixA+ORa4pbwAalk6/qaoqPhUeSqtYDCOzcSsu0=;
	b=DZydrxp6It5HlKS3mNh//5MUdSN05oCnIEplA26v4hntyU+xxNFeMDdkBpvi66dQmJHnJM
	/gkrpKtXKANlwKBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbU3NixA+ORa4pbwAalk6/qaoqPhUeSqtYDCOzcSsu0=;
	b=ZZlPRFX8HPVeyLyltxoPjntrB3vyrMGorhnSIvawEhprDCtQiJ8kvY1aBNeBJMEnFNoka7
	zEhX5cg2k/xkhsjTOrqeSfEe1lZe8CG3PQEh3+8UdhDAt9ff/QXS9LBS82y+sKrbT8fyYn
	t7/3YM8I8df36X7okK3RGPJBJuuuMoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbU3NixA+ORa4pbwAalk6/qaoqPhUeSqtYDCOzcSsu0=;
	b=DZydrxp6It5HlKS3mNh//5MUdSN05oCnIEplA26v4hntyU+xxNFeMDdkBpvi66dQmJHnJM
	/gkrpKtXKANlwKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5045F13889;
	Thu,  4 Jul 2024 04:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +B4rDtMlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:19 +0000
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
Subject: [PATCH 24/45] mm/memory_failure: Enable check_hwpoisoned_pmd_entry to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:11 +0200
Message-ID: <20240704043132.28501-25-osalvador@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

PMD-mapped hugetlb vmas will also check_hwpoisoned_pmd_entry.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0cb1b7bea9a5..8cae95e36365 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -771,27 +771,43 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 	return 1;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
-				      struct hwpoison_walk *hwp)
+				      struct hwpoison_walk *hwp,
+				      struct vm_area_struct *vma)
 {
 	pmd_t pmd = *pmdp;
 	unsigned long pfn;
-	unsigned long hwpoison_vaddr;
+	unsigned short shift;
+	unsigned long hwpoison_vaddr = addr;
 
-	if (!pmd_present(pmd))
-		return 0;
-	pfn = pmd_pfn(pmd);
-	if (pfn <= hwp->pfn && hwp->pfn < pfn + HPAGE_PMD_NR) {
-		hwpoison_vaddr = addr + ((hwp->pfn - pfn) << PAGE_SHIFT);
-		set_to_kill(&hwp->tk, hwpoison_vaddr, PAGE_SHIFT);
-		return 1;
+	if (pmd_present(pmd)) {
+		pfn = pmd_pfn(pmd);
+	} else {
+		swp_entry_t swp = pmd_to_swp_entry(pmd);
+
+		if (!is_hwpoison_entry(swp))
+			return 0;
+		pfn = swp_offset_pfn(swp);
 	}
-	return 0;
+
+	shift = is_vm_hugetlb_page(vma) ? huge_page_shift(hstate_vma(vma))
+					: PAGE_SHIFT;
+
+	if (pfn > hwp->pfn || hwp->pfn > pfn + HPAGE_PMD_NR)
+		return 0;
+
+	if (!is_vm_hugetlb_page(vma))
+		hwpoison_vaddr += (hwp->pfn - pfn) << PAGE_SHIFT;
+
+	set_to_kill(&hwp->tk, hwpoison_vaddr, shift);
+
+	return 1;
 }
 #else
 static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
-				      struct hwpoison_walk *hwp)
+				      struct hwpoison_walk *hwp,
+				      struct vm_area_struct *vma)
 {
 	return 0;
 }
@@ -805,9 +821,9 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	pte_t *ptep, *mapped_pte;
 	spinlock_t *ptl;
 
-	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
+	ptl = pmd_huge_lock(pmdp, walk->vma);
 	if (ptl) {
-		ret = check_hwpoisoned_pmd_entry(pmdp, addr, hwp);
+		ret = check_hwpoisoned_pmd_entry(pmdp, addr, hwp, walk->vma);
 		spin_unlock(ptl);
 		goto out;
 	}
-- 
2.26.2


