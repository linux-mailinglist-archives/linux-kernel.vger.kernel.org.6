Return-Path: <linux-kernel+bounces-240503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62A926E60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA54B2329E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9625757E7;
	Thu,  4 Jul 2024 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RIxxEKxG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qELKKw+j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RIxxEKxG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qELKKw+j"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7613B7BC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067528; cv=none; b=QbhvJQ4RobbrM6mzh1RJ1cH1N6hXDinlhI66MOKAuJypcAcR8KwHDg6u1yFdbOhbzVW/DIWDHiJwQTno+drUzpCmFgMy2F4+8lAYZHofZMCRN7yXJPMMv4CMMowhRwKbjX4cipxn6GnGkziQb7qgDJixvBGblfC93LiVgWb5nV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067528; c=relaxed/simple;
	bh=5GkIn/zV+sv8ou4yiI1OchGUrKPM0/dydgHojNwLtfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/ch7Uch8ugvwkbSzyYc0z6YVu9p5Qi+JV7Zj4twQ+bYJlam+9xgBLtJkfeS/e3KmNsCOtuVnuj6bGdAWPj2gFbxhV9r36AXO7W3aX1OZo0y155eGYH+sVzDUJrHPLqRsnLj+aQZLHuK1wMV9Lz/60cUWLOB5vwhIjuTugOi9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RIxxEKxG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qELKKw+j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RIxxEKxG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qELKKw+j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C84641FCFC;
	Thu,  4 Jul 2024 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzRTJDegzctm0o/zod38K6uM5eCrhph5+Nc4qITcL0E=;
	b=RIxxEKxG5cR+JdvOXGvScHx2quxv+jhuEkgOckg4pFfPpwOj9VOZl1vh5qJmR4/JuTNxQ4
	D/UknVe0GOar65hwsjkxTWr72/C44FARudhSihdPho6fBNUUoiPDaqE3fz2zwhDes4iDuP
	OItI5Fg3f+Kf/XMNa7u2ylOqzbGXysA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzRTJDegzctm0o/zod38K6uM5eCrhph5+Nc4qITcL0E=;
	b=qELKKw+j6f1vh0ZBQrKxzDcNKdWTqCngnE0ElYT6ZMBZDJuWGRwB7g2w0Ut5FIQYasv9A8
	JRnzseqZKYp7iOAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzRTJDegzctm0o/zod38K6uM5eCrhph5+Nc4qITcL0E=;
	b=RIxxEKxG5cR+JdvOXGvScHx2quxv+jhuEkgOckg4pFfPpwOj9VOZl1vh5qJmR4/JuTNxQ4
	D/UknVe0GOar65hwsjkxTWr72/C44FARudhSihdPho6fBNUUoiPDaqE3fz2zwhDes4iDuP
	OItI5Fg3f+Kf/XMNa7u2ylOqzbGXysA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzRTJDegzctm0o/zod38K6uM5eCrhph5+Nc4qITcL0E=;
	b=qELKKw+j6f1vh0ZBQrKxzDcNKdWTqCngnE0ElYT6ZMBZDJuWGRwB7g2w0Ut5FIQYasv9A8
	JRnzseqZKYp7iOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BDC913889;
	Thu,  4 Jul 2024 04:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDs9IcMlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:03 +0000
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
Subject: [PATCH 12/45] fs/proc: Enable pagemap_pmd_range to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:30:59 +0200
Message-ID: <20240704043132.28501-13-osalvador@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

PMD-mapped hugetlb vmas will also reach pagemap_pmd_range.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4d94b6ce58dd..ec429d82b921 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1824,9 +1824,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
 	int err = 0;
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 
-	ptl = pmd_trans_huge_lock(pmdp, vma);
+	ptl = pmd_huge_lock(pmdp, vma);
 	if (ptl) {
 		unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
 		u64 flags = 0, frame = 0;
@@ -1848,7 +1848,6 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			if (pm->show_pfn)
 				frame = pmd_pfn(pmd) + idx;
 		}
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		else if (is_swap_pmd(pmd)) {
 			swp_entry_t entry = pmd_to_swp_entry(pmd);
 			unsigned long offset;
@@ -1861,7 +1860,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 				frame = swp_type(entry) |
 					(offset << MAX_SWAPFILES_SHIFT);
 			}
-			flags |= PM_SWAP;
+			if (!is_vm_hugetlb_page(vma))
+				flags |= PM_SWAP;
 			if (pmd_swp_soft_dirty(pmd))
 				flags |= PM_SOFT_DIRTY;
 			if (pmd_swp_uffd_wp(pmd))
@@ -1869,7 +1869,6 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			VM_BUG_ON(!is_pmd_migration_entry(pmd));
 			page = pfn_swap_entry_to_page(entry);
 		}
-#endif
 
 		if (page) {
 			folio = page_folio(page);
@@ -1899,7 +1898,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		spin_unlock(ptl);
 		return err;
 	}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
-- 
2.26.2


