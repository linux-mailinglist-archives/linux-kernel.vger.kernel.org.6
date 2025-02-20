Return-Path: <linux-kernel+bounces-522987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9056FA3D0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A61717AC33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73091E8823;
	Thu, 20 Feb 2025 05:36:06 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D062A1E0DCC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029764; cv=none; b=N6WsZVA8ZFCgQkt6FWVmI53MrobuJKe3qXlAauNX/WLlZOAG/0IAnePvlLHBNVPxBBy3gq78bMBa1MZtn0qamVsZsE7Tvf1WUBqEVc/SwpmTyyfqa59o8Jc4w/JyXRMW6IU9eCKj0LH7x0zEcw6Toc/OnB1rhDQyvIb/K4L59Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029764; c=relaxed/simple;
	bh=ahuFuxCzircgBSA0c34wTy2uB97+fb9p8uYSFhRjrgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=djb3jh4JJi1hk7/xKJi3sSFTpCFU6TA6Q7XJZIzxuz29iD1PI6JYybAXJKGFX8UXV+6cgprZ3tk/Q5J/k4tk0XUbBXX3tmSHKRWSMTAkXk79qS98HuWMBydm/bIjVXen21m2pINItNNpI1ryZm+UdyvRYveZjIdUM69slgqV9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-d5-67b6bba6e98b
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
Subject: [RFC PATCH v12 08/26] mm: introduce luf_batch to be used as hash table to store luf meta data
Date: Thu, 20 Feb 2025 14:20:09 +0900
Message-Id: <20250220052027.58847-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDe4f1rCYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	XzoWshVsMaho2NDO1sB4SL2LkZNDQsBEom/RBRYY+0zjQzYQm01AXeLGjZ/MILaIgJnEwdY/
	7CA2s8BdJokD/WA1wgJpEle2XwazWQRUJWZPPMcIYvMKmEr0z7vKBDFTXmL1hgNgcziB5vyY
	0QtWLwRU827BJaAaLqCa92wSDZ+ns0E0SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgaG/rPZP9A7GTxeCDzEKcDAq8fDOaN2WLsSaWFZcmXuIUYKDWUmEt61+S7oQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxlY1HU9Rh223vj46
	pv4+4Wr7Njc1rffTUz+eLbNqeyV0S3/7Q/V3mbdtll8z8bvBdtGx/sz2b0uSvjTtXS65VlL3
	peyshw+2ijR3LbfqWtl5bJHFTTYVbnGtY2vqHB5vSrqy3Dms5Eji3lX8uxyahaLyT+g7ysRm
	+6hwCdnvXFkX3Oar+DivTYmlOCPRUIu5qDgRAGvyUlB5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g+trpS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlfGlYyFbwRaDioYN7WwNjIfUuxg5OSQETCTOND5kA7HZBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONAPViMskCZxZftlMJtFQFVi9sRzjCA2r4CpRP+8q0wQM+UlVm84ADaH
	E2jOjxm9YPVCQDXvFlximsDItYCRYRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgIC+r/TNx
	B+OXy+6HGAU4GJV4eB883pouxJpYVlyZe4hRgoNZSYS3rX5LuhBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAOjfqX8x5vquXsLZnGpK+5u0PXZdvR7R0D9
	qTyvKexFop1y2qXm1ut16+PWvbnu6HnY86bbomPlJ3pea/yrzP2X/KRv/va6JxsW7d68IZPN
	c8J5qZhLjyzL1zWw1RnGRDaEnfpgY5txdl36zvVa+Rrr9zwv3KBTsdulubEh6tp9ppxpBz9p
	vNynxFKckWioxVxUnAgAi7hxFGACAAA=
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
index 20d85c4e609de..39a6b5124b01f 100644
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
index e3084d32272e3..b38a9ae9d6993 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1240,6 +1240,8 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
+void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1250,6 +1252,12 @@ static inline void try_to_unmap_flush_dirty(void)
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


