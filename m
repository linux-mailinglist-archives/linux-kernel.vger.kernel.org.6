Return-Path: <linux-kernel+bounces-175356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67258C1E77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0510E1C22025
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D381635A9;
	Fri, 10 May 2024 06:52:35 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD6515FA73
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323954; cv=none; b=D10KLdUjRXORWqBhiF3nqCkTzmgYH1kpQPKseKCWAytw2nh88PB22Xh9Lmzyzz1Wjf1YvReQlXQa4GYdpefimk1AFkKflKS0nkL7JBrLLWfIvLNIG+UiNHYLhq8XkLck/j71fC8xORu1ylyAH1MN2yqtKfOOWlxgUndvx2uETt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323954; c=relaxed/simple;
	bh=F8iBaXPfyAs8+pBArnftJrFJRE6eOJaC+K3wXJHYEbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jJ7nzcsgbXlxcv2eNmatGzM9bNZP/DUBPrypD+ku4Tw6lpSZ2Vt9FVsKryyjVGl/yDomHp7v44q3L1wYP6dP/LCiERJuGu98kuinUA9GpziIFgWL+bEMnBUdNfTi6rHBHHW55th4/y7WWXNcVnjb2f8ScWl8sOpD0li3RU/pbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e7-663dc421aa7f
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
Subject: [PATCH v10 08/12] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Fri, 10 May 2024 15:52:02 +0900
Message-Id: <20240510065206.76078-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoa7iEds0g4MTtSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAldG
	w7tH7AV3ZCsu7p7B1sB4RKKLkZNDQsBE4u/ucyww9vU3G5hBbDYBdYkbN36C2SICZhIHW/+w
	g9jMAneZJA70s3UxcnAIC8RINCyyAQmzCKhKXD19kg3E5hUwldhw/QATxEh5idUbDoCN4QQa
	82HZDLC4EFBNx4OJjF2MXEA1n9kk3vZPY4ZokJQ4uOIGywRG3gWMDKsYhTLzynITM3NM9DIq
	8zIr9JLzczcxAgN/We2f6B2Mny4EH2IU4GBU4uHdsdkmTYg1say4MvcQowQHs5IIb1WNdZoQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxpDXRTu2PZZ/
	Y+T9YXruc02NV6vONXfnaXVHOd4UbpguYpJR3xsm2MPL4XlC+aNP4VvD9F3ma/wETkzvWsR6
	6RvXYYeX3O1/+3TW6tTquxYWLmwo74yv9Mtp6rdzTEwukSx/nV9V73XSPVGkdBPz2f6PDd4s
	Loed1ir+5k1i1mztUKza+l6JpTgj0VCLuag4EQBNYvAHeAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbNYNUHBYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZTS8e8RecEe24uLuGWwNjEckuhg5OSQETCSuv9nADGKzCahL3LjxE8wWETCT
	ONj6hx3EZha4yyRxoJ+ti5GDQ1ggRqJhkQ1ImEVAVeLq6ZNsIDavgKnEhusHmCBGykus3nAA
	bAwn0JgPy2aAxYWAajoeTGScwMi1gJFhFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmAYL6v9
	M3EH45fL7ocYBTgYlXh4d2y2SRNiTSwrrsw9xCjBwawkwltVY50mxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwOjyVOdO4urdb9Y9eTd7wWrpJXo2rY0a
	GUlbY+YZsrA07VppI2Qtk//9542Sg04fKvsKeyK8S28vnXqxN/nXhD2Kgl9DWG7d0JENNjzc
	l65yz+fbCbt3YYHLyquu98y13cCxfmpJWq+uaL/tZb5//W/7TzAcWv3g+XEGSwkbEzsPlruX
	Qqd/l1FiKc5INNRiLipOBADOpyuuXwIAAA==
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
index 2aa48adad226..0915390b1b5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1339,6 +1339,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 	unsigned short int		ugen;
 
 	/* Cache last used pipe for splice(): */
diff --git a/mm/internal.h b/mm/internal.h
index 0d4c74e76de6..805f0e6ecab4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1100,6 +1100,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1110,6 +1111,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index cf8a99a49aef..328b5e2217e6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -635,6 +635,28 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
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
@@ -644,7 +666,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
+	fold_ubc(tlb_ubc, tlb_ubc_ro);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -658,8 +682,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
-	if (tlb_ubc->writable)
+	if (tlb_ubc->writable || tlb_ubc_ro->writable)
 		try_to_unmap_flush();
 }
 
@@ -676,13 +701,18 @@ void try_to_unmap_flush_dirty(void)
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


