Return-Path: <linux-kernel+bounces-196570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0448D5E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AF6B24A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774EE1422C4;
	Fri, 31 May 2024 09:20:30 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3E133987
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147229; cv=none; b=KCm07YFRwGcSpycVgf+9uIFkKZjwqkRBQ01siUQp3O0lSp3iRJeWgAnd/stDidTcmRQ51j+oWL6qr8ecY6HUMMz5wMFxozrReGewekTsy5VAb1uMc593jumoz381s5LZRt0LEGV7CHCLcsTQ3wuIOtDbXwkUc1cwiDOLD5MxOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147229; c=relaxed/simple;
	bh=cul6Pu8ZuMbggKL3N/P0IPTT4jDohaQVP7cjyEyNtPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YnVsEaEQ+AgmZ6OLGj6zaVhzZi6BUFWEYHzMUuBus53+SWRv5MmHjcxvJwvqc6TjedCQmjTdikLcSd0ZCwEUl/f3O0t5Jz5ifibVNadHHkanAyaBWiueqgz+wrLR5A0dUtlMkFE640jZT0njqR9bwc9WDaxbtALWzkITWNN6nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-66-6659964c5b63
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v11 08/12] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Fri, 31 May 2024 18:19:57 +0900
Message-Id: <20240531092001.30428-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g9ZmaYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsjjee4DJYv69z2wW
	mzdNZbY4PmUqo8XvH0DFJ2dNZnEQ8Pje2sfisXPWXXaPBZtKPTav0PJYvOclk8emVZ1sHps+
	TWL3eHfuHLvHiRm/WTzmnQz0eL/vKpvH1l92Ho1Tr7F5fN4kF8AXxWWTkpqTWZZapG+XwJXx
	bfd8poI7shXtxyexNzAekehi5OCQEDCReLiVsYuRE8yctn0VO4jNJqAucePGT2YQW0TATOJg
	6x+wOLPAXSaJA/1sILawQIzEo33bwWwWAVWJntNtYDavgKnE2/s/2SFmykus3nAAbA4n0JwD
	f++A7RICqln0vxfI5gKqec8mcfz+WRaIBkmJgytusExg5F3AyLCKUSgzryw3MTPHRC+jMi+z
	Qi85P3cTIzDwl9X+id7B+OlC8CFGAQ5GJR7egIqINCHWxLLiytxDjBIczEoivL/SgUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYA2Oitgd+2sTw9Jj6
	yuu/Ztw4ue9i7LXgkuCsosUdubeX9v5pVb0+8ea51WLfORzO53z28H5W+L5fsHdrx65/l6bd
	m7mu/6Bnz4oCX8ajRW5XPL6H/Ghmq1ryWDTz76t91949n7qhKuHp94lH15mXLDWPPHZn/7pr
	c83jWF8f8GJ/sF284sj74/OUWIozEg21mIuKEwHsDoh0eAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrOszLTLNYO8tPos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZXzbPZ+p4I5sRfvxSewNjEckuhg5OSQETCSmbV/FDmKzCahL3LjxkxnEFhEw
	kzjY+gcszixwl0niQD8biC0sECPxaN92MJtFQFWi53QbmM0rYCrx9v5PdoiZ8hKrNxwAm8MJ
	NOfA3zuMILYQUM2i/72MExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM5GW1fybu
	YPxy2f0QowAHoxIPb0BFRJoQa2JZcWXuIUYJDmYlEd5f6UAh3pTEyqrUovz4otKc1OJDjNIc
	LErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRrO7b7ayVyxJYmDcwRJy9bDa/64XLV/WhnRt
	eDW7RJpTY97Mn4Wx84zdH5qUa1Z29f1ru1N35fbyk9xranRsOBhWHN5+0rm49C7byptvDuU+
	OpS3xizJUqd8SaGcdpruagkO0xPTritXv7BOXTSx1WtLAeeeQLP/a9adMuWs3xrwbN/8Lx67
	HyqxFGckGmoxFxUnAgB1VFSbYAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
requires to recognize read-only tlb entries and handle them in a
different way.  The newly introduced API in this patch, fold_ubc(), will
be used by luf mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/internal.h         |  4 ++++
 mm/rmap.c             | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ab5a2ed79b88..d9722c014157 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1340,6 +1340,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 	unsigned short int		ugen;
 
 	/* Cache last used pipe for splice(): */
diff --git a/mm/internal.h b/mm/internal.h
index dba6d0eb7b6d..ca6fb5b2a640 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1124,6 +1124,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1134,6 +1135,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index a65a94aada8d..1a246788e867 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -634,6 +634,28 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+
+void fold_ubc(struct tlbflush_unmap_batch *dst,
+	      struct tlbflush_unmap_batch *src)
+{
+	if (!src->flush_required)
+		return;
+
+	/*
+	 * Fold src to dst.
+	 */
+	arch_tlbbatch_fold(&dst->arch, &src->arch);
+	dst->writable = dst->writable || src->writable;
+	dst->flush_required = true;
+
+	/*
+	 * Reset src.
+	 */
+	arch_tlbbatch_clear(&src->arch);
+	src->flush_required = false;
+	src->writable = false;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -643,7 +665,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
+	fold_ubc(tlb_ubc, tlb_ubc_ro);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -657,8 +681,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
-	if (tlb_ubc->writable)
+	if (tlb_ubc->writable || tlb_ubc_ro->writable)
 		try_to_unmap_flush();
 }
 
@@ -675,13 +700,18 @@ void try_to_unmap_flush_dirty(void)
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 				      unsigned long uaddr)
 {
-	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
 	bool writable = pte_dirty(pteval);
 
 	if (!pte_accessible(mm, pteval))
 		return;
 
+	if (pte_write(pteval))
+		tlb_ubc = &current->tlb_ubc;
+	else
+		tlb_ubc = &current->tlb_ubc_ro;
+
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
 
-- 
2.17.1


