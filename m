Return-Path: <linux-kernel+bounces-240507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490D926E64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137CE1C234F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60007381C7;
	Thu,  4 Jul 2024 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GTzwuWvk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jvDVW3J6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GTzwuWvk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jvDVW3J6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030231422CC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067533; cv=none; b=V5FXSgYyJgm9dwirVUVAPQoCZvYDSyVbOOXa6q14fMtXnwbMVkd+sFELNu7bypdGn/FqmwjWzRkoljwoZ4hKfghsBdfBTjyuYsNce8Jz+VGBfmVomzG5UudgSjGxYIXw4ftg78/yl9WG1ilccruYO6f37Wd9wUASJz2Px9moI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067533; c=relaxed/simple;
	bh=JplJGugUueYsKXtwReqO01y88Jur3wKRsdxtgS9HNfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIvkKJthlcERjdJdDP1WtvPQaU4OJD6tKa/vGqeQ/FRBCTgYMi4HyKdG1N+G6OzlKUP+X9KTXKwaxSMOTg8kfZq+q4h3HUF2QOM+sz6XXvwW9PJFnaAjI63jycypsf3UoZNUGrHDxzN6ewLEHPZOjJSJJRwJxjqvitLBIl+QA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GTzwuWvk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jvDVW3J6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GTzwuWvk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jvDVW3J6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A18B21180;
	Thu,  4 Jul 2024 04:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywx5qYincblCns1hUo2a7V32kYl58scbVMBY9LF3T58=;
	b=GTzwuWvkW4352FKSC60QDraIO7eJOmAixIJz5RFRrudJmWfKJkpiuKZHVlx8nO0wQbcFzt
	qLNYDqW+shNAbNnPmhFgaxr/xkRqxsQJ9oLNgCTLnZXKEUR5ZknhTrQbnFUU6RkjXXQiol
	jNr+qp+D+BH1yGYXIesILMJvxw273IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywx5qYincblCns1hUo2a7V32kYl58scbVMBY9LF3T58=;
	b=jvDVW3J69xcP45jkzhmWbnnV1lDl4uY2pXNQ4DMnh1no9iNhknQuhbQaJO2boD0G3/hFKq
	b91zyh46S6CvurBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywx5qYincblCns1hUo2a7V32kYl58scbVMBY9LF3T58=;
	b=GTzwuWvkW4352FKSC60QDraIO7eJOmAixIJz5RFRrudJmWfKJkpiuKZHVlx8nO0wQbcFzt
	qLNYDqW+shNAbNnPmhFgaxr/xkRqxsQJ9oLNgCTLnZXKEUR5ZknhTrQbnFUU6RkjXXQiol
	jNr+qp+D+BH1yGYXIesILMJvxw273IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywx5qYincblCns1hUo2a7V32kYl58scbVMBY9LF3T58=;
	b=jvDVW3J69xcP45jkzhmWbnnV1lDl4uY2pXNQ4DMnh1no9iNhknQuhbQaJO2boD0G3/hFKq
	b91zyh46S6CvurBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1083C13889;
	Thu,  4 Jul 2024 04:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QIUEO8glhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:08 +0000
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
Subject: [PATCH 16/45] fs/proc: Enable pagemap_scan_pmd_entry to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:03 +0200
Message-ID: <20240704043132.28501-17-osalvador@suse.de>
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

PMD-mapped hugetlb vmas will also reach pagemap_scan_pmd_entry.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22200018371d..df649f69ea2c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2263,8 +2263,8 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 	}
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+static unsigned long pagemap_pmd_category(struct pagemap_scan_private *p,
 					  struct vm_area_struct *vma,
 					  unsigned long addr, pmd_t pmd)
 {
@@ -2296,7 +2296,8 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		if (pmd_swp_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
 
-		if (p->masks_of_interest & PAGE_IS_FILE) {
+		if ((p->masks_of_interest & PAGE_IS_FILE) &&
+		    !is_vm_hugetlb_page(vma)) {
 			swp = pmd_to_swp_entry(pmd);
 			if (is_pfn_swap_entry(swp) &&
 			    !folio_test_anon(pfn_swap_entry_folio(swp)))
@@ -2321,7 +2322,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
 #ifdef CONFIG_HUGETLB_PAGE
 static unsigned long pagemap_hugetlb_category(pte_t pte)
@@ -2522,22 +2523,22 @@ static int pagemap_scan_output(unsigned long categories,
 	return ret;
 }
 
-static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
+static int pagemap_scan_huge_entry(pmd_t *pmd, unsigned long start,
 				  unsigned long end, struct mm_walk *walk)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	unsigned long categories;
 	spinlock_t *ptl;
 	int ret = 0;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_huge_lock(pmd, vma);
 	if (!ptl)
 		return -ENOENT;
 
 	categories = p->cur_vma_category |
-		     pagemap_thp_category(p, vma, start, *pmd);
+		     pagemap_pmd_category(p, vma, start, *pmd);
 
 	if (!pagemap_scan_is_interesting_page(categories, p))
 		goto out_unlock;
@@ -2556,19 +2557,29 @@ static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
 	 * needs to be performed on a portion of the huge page.
 	 */
 	if (end != start + HPAGE_SIZE) {
-		spin_unlock(ptl);
-		split_huge_pmd(vma, pmd, start);
 		pagemap_scan_backout_range(p, start, end);
-		/* Report as if there was no THP */
-		return -ENOENT;
+		if (!is_vm_hugetlb_page(vma)) {
+			/* Report as if there was no THP */
+			spin_unlock(ptl);
+			split_huge_pmd(vma, pmd, start);
+			ret = -ENOENT;
+			goto out;
+		}
+		ret = 0;
+		p->arg.walk_end = start;
+		goto out_unlock;
 	}
 
 	make_uffd_wp_pmd(vma, start, pmd);
-	flush_tlb_range(vma, start, end);
+	if (is_vm_hugetlb_page(vma))
+		flush_hugetlb_tlb_range(vma, start, end);
+	else
+		flush_tlb_range(vma, start, end);
 out_unlock:
 	spin_unlock(ptl);
+out:
 	return ret;
-#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+#else /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 	return -ENOENT;
 #endif
 }
@@ -2585,7 +2596,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 
 	arch_enter_lazy_mmu_mode();
 
-	ret = pagemap_scan_thp_entry(pmd, start, end, walk);
+	ret = pagemap_scan_huge_entry(pmd, start, end, walk);
 	if (ret != -ENOENT) {
 		arch_leave_lazy_mmu_mode();
 		return ret;
-- 
2.26.2


