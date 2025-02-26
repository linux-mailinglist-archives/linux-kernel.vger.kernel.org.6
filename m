Return-Path: <linux-kernel+bounces-533745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC5A45E38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD963AC6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA422154A;
	Wed, 26 Feb 2025 12:03:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4421B183
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571432; cv=none; b=NFxbCo0GdrGGIS8MMucCGyrqj3XWiAyQnXEDyUpG4dorjIBsYB/myl4PaBa9rxUJqZTYAZ88f1a8+ImJOHLr4PQAK+0HJizqvRFL8sjZDWCLGGzVhKbTcAkPPjnMHqpM1XdOkbLHpdVPjfRXuuitdR0VdfMUYRFVGe+kK3t/er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571432; c=relaxed/simple;
	bh=hsK6YG3lkSKEqSmTHltgcR83SgST+t2UMQg+o+HBxrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KDKsjtjCVH5bPEZyNxZafyYWRVuhOSEKSr9UT3UOG5/ivCYQCqf1Sf9+KvBfKiNAGNQT2MPqZ+LEJlgXHhxx4+3NCVNWd9I4IB2aH/syn7d3gFhWAN2Bc9d8Jikj+XyXLCzv6jTYGm/wmle2tFEMDAGckQBw3DzN/2q2QYq2AUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-19-67bf03225d34
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
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
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 08/25] mm: introduce luf_batch to be used as hash table to store luf meta data
Date: Wed, 26 Feb 2025 21:03:19 +0900
Message-Id: <20250226120336.29565-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50g4lrtSzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK6Nt2hHWgi0GFa92d7I1MB5S72Lk
	5JAQMJG4svgmI4z95cZsNhCbTUBd4saNn8wgtoiAmcTB1j/sXYxcHMwCy5gk9p5oACsSFqiU
	2DC5AayIRUBV4n7rPbBBvAKmEgeO/WWBGCovsXrDAbAaTqBBn6YdA+sVEkiW2Pn7DxPIUAmB
	22wSU3+uZINokJQ4uOIGywRG3gWMDKsYhTLzynITM3NM9DIq8zIr9JLzczcxAsN6We2f6B2M
	ny4EH2IU4GBU4uF9cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGFn5veMu7Jo9v9hj8YPDmY+aBYXmr42M5Hl/
	mmNa6VmLZGW5my1rFm2N1uwJehh3vm6a9a4sY5acl/u/esxin/rTn/e3+47n3y7V96/Jmf76
	5IrP9e5BH5pC5d1mVbx3+c6w8w2Dr6dsY6XUdsZohR0TP7IWx2U3VJrdfPLlqHixYEj4rAkf
	9iixFGckGmoxFxUnAgCGMxFcZwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4P5pRYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgy2qYdYS3YYlDx
	ancnWwPjIfUuRk4OCQETiS83ZrOB2GwC6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFljGJLH3RANY
	kbBApcSGyQ1gRSwCqhL3W+8xgti8AqYSB479ZYEYKi+xesMBsBpOoEGfph0D6xUSSJbY+fsP
	0wRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECg3RZ7Z+JOxi/XHY/xCjAwajEw/vg
	zN50IdbEsuLK3EOMEhzMSiK8nJl70oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeW
	pGanphakFsFkmTg4pRoYnZVb1h3Trokzf3zIhynw8//k806zfs20vsVzJEfno8nbb5sWdsgp
	W/fq8yXbF1nNOfO0Ze++bPlHFo/OiruVnq47YxJy+9qRD8VTczz/inf3zjqtdlXtesezdH+R
	p7MORsmdFvt/V13uD5v1AXEzY7X6x36VSy4/vlQ0keULZw5nbsmeqoNdSizFGYmGWsxFxYkA
	dXrYUU4CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
needs to keep luf meta data per page while staying in pcp or buddy
allocator.  The meta data includes cpumask for tlb shootdown and luf's
request generation number.

Since struct page doesn't have enough room to store luf meta data, this
patch introduces a hash table to store them and makes each page keep its
hash key instead.

Since all the pages in pcp or buddy share the hash table, confliction is
inevitable so care must be taken when reading or updating its entry.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h |  10 ++++
 mm/internal.h            |   8 +++
 mm/rmap.c                | 122 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7d78a285e52ca..4bfe8d072b0ea 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -32,6 +32,16 @@
 struct address_space;
 struct mem_cgroup;
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+struct luf_batch {
+	struct tlbflush_unmap_batch batch;
+	unsigned long ugen;
+	rwlock_t lock;
+};
+#else
+struct luf_batch {};
+#endif
+
 /*
  * Each physical page in the system has a struct page associated with
  * it to keep track of whatever it is we are using the page for at the
diff --git a/mm/internal.h b/mm/internal.h
index 4c8ed93a792ec..3333d8d461c2c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1253,6 +1253,8 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
+void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1263,6 +1265,12 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset)
+{
+}
+static inline void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index ed345503e4f88..74fbf6c2fb3a7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -641,7 +641,7 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
  * function, ugen_before(), should be used to evaluate the temporal
  * sequence of events because the number is designed to wraparound.
  */
-static atomic_long_t __maybe_unused luf_ugen = ATOMIC_LONG_INIT(LUF_UGEN_INIT);
+static atomic_long_t luf_ugen = ATOMIC_LONG_INIT(LUF_UGEN_INIT);
 
 /*
  * Don't return invalid luf_ugen, zero.
@@ -656,6 +656,122 @@ static unsigned long __maybe_unused new_luf_ugen(void)
 	return ugen;
 }
 
+static void reset_batch(struct tlbflush_unmap_batch *batch)
+{
+	arch_tlbbatch_clear(&batch->arch);
+	batch->flush_required = false;
+	batch->writable = false;
+}
+
+void fold_batch(struct tlbflush_unmap_batch *dst,
+		struct tlbflush_unmap_batch *src, bool reset)
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
+	if (!reset)
+		return;
+
+	/*
+	 * Reset src.
+	 */
+	reset_batch(src);
+}
+
+/*
+ * The range that luf_key covers, which is 'unsigned short' type.
+ */
+#define NR_LUF_BATCH (1 << (sizeof(short) * 8))
+
+/*
+ * Use 0th entry as accumulated batch.
+ */
+static struct luf_batch luf_batch[NR_LUF_BATCH];
+
+static void luf_batch_init(struct luf_batch *lb)
+{
+	rwlock_init(&lb->lock);
+	reset_batch(&lb->batch);
+	lb->ugen = atomic_long_read(&luf_ugen) - 1;
+}
+
+static int __init luf_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_LUF_BATCH; i++)
+		luf_batch_init(&luf_batch[i]);
+
+	return 0;
+}
+early_initcall(luf_init);
+
+/*
+ * key to point an entry of the luf_batch array
+ *
+ * note: zero means invalid key
+ */
+static atomic_t luf_kgen = ATOMIC_INIT(1);
+
+/*
+ * Don't return invalid luf_key, zero.
+ */
+static unsigned short __maybe_unused new_luf_key(void)
+{
+	unsigned short luf_key = atomic_inc_return(&luf_kgen);
+
+	if (!luf_key)
+		luf_key = atomic_inc_return(&luf_kgen);
+
+	return luf_key;
+}
+
+static void __fold_luf_batch(struct luf_batch *dst_lb,
+		struct tlbflush_unmap_batch *src_batch,
+		unsigned long src_ugen)
+{
+	/*
+	 * dst_lb->ugen represents one that requires tlb shootdown for
+	 * it, that is, sort of request number.  The newer it is, the
+	 * more tlb shootdown might be needed to fulfill the newer
+	 * request.  Conservertively keep the newer one.
+	 */
+	if (!dst_lb->ugen || ugen_before(dst_lb->ugen, src_ugen))
+		dst_lb->ugen = src_ugen;
+	fold_batch(&dst_lb->batch, src_batch, false);
+}
+
+void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
+{
+	unsigned long flags;
+
+	/*
+	 * Exactly same.  Nothing to fold.
+	 */
+	if (dst == src)
+		return;
+
+	if (&src->lock < &dst->lock) {
+		read_lock_irqsave(&src->lock, flags);
+		write_lock(&dst->lock);
+	} else {
+		write_lock_irqsave(&dst->lock, flags);
+		read_lock(&src->lock);
+	}
+
+	__fold_luf_batch(dst, &src->batch, src->ugen);
+
+	write_unlock(&dst->lock);
+	read_unlock_irqrestore(&src->lock, flags);
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -670,9 +786,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
-	arch_tlbbatch_clear(&tlb_ubc->arch);
-	tlb_ubc->flush_required = false;
-	tlb_ubc->writable = false;
+	reset_batch(tlb_ubc);
 }
 
 /* Flush iff there are potentially writable TLB entries that can race with IO */
-- 
2.17.1


