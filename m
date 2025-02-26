Return-Path: <linux-kernel+bounces-533720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECEA45E17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE833AE8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625921D59A;
	Wed, 26 Feb 2025 12:01:51 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC021885C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571310; cv=none; b=B8lVIE26j+zo5kiD1XL/AqZ5UnG39p9cgZaaRRL1F2m0qLolHitmkdEXpBlAfB03wFCz6wZ/EgE8v78zVoZn093qUdU0m9ibR532SoSD6+ZOyVkDy7BC2vrzaEx09HJ08SCMy/XZC2mw1YtatEXvIYfRUelXEPLkuUleO4n4TXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571310; c=relaxed/simple;
	bh=l6pm0F2IKJ6x1NnSC4LDYN7bOKgyx4ofV6NyPnzuM1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b178XXVV1ajNnzbNyK4XTudeWD24hodXOsn1+oe/aRr3GF3vaXgryInB3GeNk7X0hHz3O6gnSKGS50VpdBG951fScDU9aF0VO0e3Y9nPN1VuHRM0cpIo4gztW9JAUMxFhNkQ7ww+8Ws4U02zkSXWGk47baI5vw6rPxIflEXq1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-ea-67bf02a672e4
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 08/25] mm: introduce luf_batch to be used as hash table to store luf meta data
Date: Wed, 26 Feb 2025 21:01:15 +0900
Message-Id: <20250226120132.28469-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBrc/aVrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV0bz2UVsBVsMKj6v8W5gPKTexcjJ
	ISFgInH0exMTjP38x0pWEJtNQF3ixo2fzCC2iICZxMHWP+xdjFwczALLmCT2nmhgA3GEBfoY
	Jfbd/MwCUsUioCqxf30D2CReAVOJ/k/dzBBT5SVWbzgAZnMCTfq3+zc7iC0kkCzRsv43C8gg
	CYH7bBLLN15mhGiQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECw3pZ7Z/o
	HYyfLgQfYhTgYFTi4X1wZm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYm2ZuM/neMukL98y7H28Jsp61co+rktNt
	ZJ5wdafIcT1bnqN8WyaYR622+TNR+8kMyeM2T4zWNkUd59bRPrLIOFC+6cmeqF9FSomLBS+y
	vxcPj+znEfhY3yDUHXbQ/+Q/lTMPA07x9Wpde7Dp76ybsswXm1c8CdeasNhLJNmxk5n3SEDS
	QbFsJZbijERDLeai4kQAcBTgV2cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wZ5rChZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlNJ9dxFawxaDi
	8xrvBsZD6l2MnBwSAiYSz3+sZAWx2QTUJW7c+MkMYosImEkcbP3D3sXIxcEssIxJYu+JBjYQ
	R1igj1Fi383PLCBVLAKqEvvXNzCB2LwCphL9n7qZIabKS6zecADM5gSa9G/3b3YQW0ggWaJl
	/W+WCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG6bLaPxN3MH657H6IUYCDUYmH
	98GZvelCrIllxZW5hxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJI
	TyxJzU5NLUgtgskycXBKNTCGn3L/VtX9jfd+98w1O6SLw4+JH/bRMGnxkzFRZH/dyLnkfdq0
	KTe87z/4I7SqpjLKaN6GrOYb38TVpQzOGffeLbka8rCmSmhbx5NjH/55n+va3MhnsDrt2DGN
	jUYiSq3xb2Jr280EJpYkuXYEvH7refj1prufbxVtfzpppbvlzoSpq90cJkgpsRRnJBpqMRcV
	JwIA2UEK004CAAA=
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
index 7b15efbe9f529..f52d4e49e8736 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -33,6 +33,16 @@
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
index ee8af97c39f59..8ade04255dba3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1270,6 +1270,8 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
+void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1280,6 +1282,12 @@ static inline void try_to_unmap_flush_dirty(void)
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
index 8439dbb194c8c..ac450a45257f6 100644
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


