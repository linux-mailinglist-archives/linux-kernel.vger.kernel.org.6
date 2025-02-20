Return-Path: <linux-kernel+bounces-522990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4AAA3D0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5063189E18E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D338C1E9B09;
	Thu, 20 Feb 2025 05:36:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29161E3DD6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029766; cv=none; b=GawVxYK+zR7j+pE8yhWCoOd8TAw+Ow5AFaliT3CPVvEyDAc9G9mG3FK4EcXHk8qagkngujv8XNV79ve2m9NeIHcc80aOaoZF9o30OdkamsDGjWGBBbLV6nbEA/nKHTfVdOn3zsxWOSmairFPrV4b7w+6aMoGRYPWCtHe6MtCh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029766; c=relaxed/simple;
	bh=7z4c/azJKKPHTuQ4rKrS5+vLrWnw7FZpUNSGCSasrMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PvJeLuD+SOU+9QJo4GCd8I7ygqMKB1omfzF+u6rHE45ASRWkfOFeEIURHmcv2BOgZRo7EoEbrtLdf93L5OeJON7WNFTVEOM6XER8MMaU/GkeEw5oXusEdb2q8mFDa79LxHgGF3EzNjVAuWYtt0KJQL8fJQK64+21tYQXIQp9DaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-e0-67b6bba66069
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
Subject: [RFC PATCH v12 10/26] mm: introduce APIs to check if the page allocation is tlb shootdownable
Date: Thu, 20 Feb 2025 14:20:11 +0900
Message-Id: <20250220052027.58847-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6y3dvSDWZ+0bGYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	N57sYin4aVyx6vhV1gbG41pdjJwcEgImEls7G5lg7G2vrjCD2GwC6hI3bvwEs0UEzCQOtv5h
	B7GZBe4ySRzoZwOxhQXSJH7PmMQCYrMIqEq0bJoAZvMC1f9+soAVYqa8xOoNB8DmcALFf8zo
	BesVEjCVeLfgEtBeLqCa92wSs+92Qh0hKXFwxQ2WCYy8CxgZVjEKZeaV5SZm5pjoZVTmZVbo
	JefnbmIEhv6y2j/ROxg/XQg+xCjAwajEwzujdVu6EGtiWXFl7iFGCQ5mJRHetvot6UK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYp9RLvdDJNF78MEbk
	HLP+r1fMKenVZxlEuVUvH3u2XHUG053ERflFFfdlf7Ku+DZPZGrpSecC/n1TA3i0b8V0F8xy
	uKpR7vg5QGLFmrifb+QSz7bPTvG98Gpmcmhd2oOps+IeSQnt7t3rPN2N/d7lgqf3L2v6XL03
	/9fUCPZ7sa6rn5QeE6pVVmIpzkg01GIuKk4EAEnlmJR5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g0VvlCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlXHjyS6Wgp/GFauOX2VtYDyu1cXIySEhYCKx7dUVZhCbTUBd4saNn2C2iICZ
	xMHWP+wgNrPAXSaJA/1sILawQJrE7xmTWEBsFgFViZZNE8BsXqD6308WsELMlJdYveEA2BxO
	oPiPGb1gvUICphLvFlximsDItYCRYRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgIC+r/TNx
	B+OXy+6HGAU4GJV4eB883pouxJpYVlyZe4hRgoNZSYS3rX5LuhBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAOj1Knmcj6lN6yen68f2Rr47sFtX+ubN1pz
	zE0WrGzM0DbZemdqp5+7vuonVyfp+vX8p32yN/1apSYS8kHNzyJY4qd8kv+nTb0pTTJlPBei
	ktwCJzrnXpU4elP9RvCdk6dmSj+72c67naFhdk5QYfvez0++JC/tudS6yfOa+b1bW412lE5R
	f7hMiaU4I9FQi7moOBEAyKhgsmACAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
should indentify if tlb shootdown can be performed on page allocation.

In a context with irq disabled or non-task, tlb shootdown cannot be
performed because of deadlock issue.  Thus, page allocator should work
being aware of whether tlb shootdown can be performed on returning page.

This patch introduced APIs that pcp or buddy page allocator can use to
delimit the critical sections taking off pages and indentify whether
tlb shootdown can be performed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |   5 ++
 mm/internal.h         |  14 ++++
 mm/page_alloc.c       | 159 ++++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c             |   2 +-
 4 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8e6e7a83332cf..c4ff83e1d5953 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1374,6 +1374,11 @@ struct task_struct {
 	struct callback_head		cid_work;
 #endif
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+	int luf_no_shootdown;
+	int luf_takeoff_started;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
 
diff --git a/mm/internal.h b/mm/internal.h
index cbdebf8a02437..55bc8ca0d6118 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1583,6 +1583,20 @@ static inline void accept_page(struct page *page)
 {
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+extern struct luf_batch luf_batch[];
+bool luf_takeoff_start(void);
+void luf_takeoff_end(void);
+bool luf_takeoff_no_shootdown(void);
+bool luf_takeoff_check(struct page *page);
+bool luf_takeoff_check_and_fold(struct page *page);
+#else
+static inline bool luf_takeoff_start(void) { return false; }
+static inline void luf_takeoff_end(void) {}
+static inline bool luf_takeoff_no_shootdown(void) { return true; }
+static inline bool luf_takeoff_check(struct page *page) { return true; }
+static inline bool luf_takeoff_check_and_fold(struct page *page) { return true; }
+#endif
 
 /* pagewalk.c */
 int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 244cb30496be5..cac2c95ca2430 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -622,6 +622,165 @@ compaction_capture(struct capture_control *capc, struct page *page,
 }
 #endif /* CONFIG_COMPACTION */
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+static bool no_shootdown_context(void)
+{
+	/*
+	 * If it performs with irq disabled, that might cause a deadlock.
+	 * Avoid tlb shootdown in this case.
+	 */
+	return !(!irqs_disabled() && in_task());
+}
+
+/*
+ * Can be called with zone lock released and irq enabled.
+ */
+bool luf_takeoff_start(void)
+{
+	unsigned long flags;
+	bool no_shootdown = no_shootdown_context();
+
+	local_irq_save(flags);
+
+	/*
+	 * It's the outmost luf_takeoff_start().
+	 */
+	if (!current->luf_takeoff_started)
+		VM_WARN_ON(current->luf_no_shootdown);
+
+	/*
+	 * current->luf_no_shootdown > 0 doesn't mean tlb shootdown is
+	 * not allowed at all.  However, it guarantees tlb shootdown is
+	 * possible once current->luf_no_shootdown == 0.  It might look
+	 * too conservative but for now do this way for simplity.
+	 */
+	if (no_shootdown || current->luf_no_shootdown)
+		current->luf_no_shootdown++;
+
+	current->luf_takeoff_started++;
+	local_irq_restore(flags);
+
+	return !no_shootdown;
+}
+
+/*
+ * Should be called within the same context of luf_takeoff_start().
+ */
+void luf_takeoff_end(void)
+{
+	unsigned long flags;
+	bool no_shootdown;
+	bool outmost = false;
+
+	local_irq_save(flags);
+	VM_WARN_ON(!current->luf_takeoff_started);
+
+	/*
+	 * Assume the context and irq flags are same as those at
+	 * luf_takeoff_start().
+	 */
+	if (current->luf_no_shootdown)
+		current->luf_no_shootdown--;
+
+	no_shootdown = !!current->luf_no_shootdown;
+
+	current->luf_takeoff_started--;
+
+	/*
+	 * It's the outmost luf_takeoff_end().
+	 */
+	if (!current->luf_takeoff_started)
+		outmost = true;
+
+	local_irq_restore(flags);
+
+	if (no_shootdown)
+		goto out;
+
+	try_to_unmap_flush_takeoff();
+out:
+	if (outmost)
+		VM_WARN_ON(current->luf_no_shootdown);
+}
+
+/*
+ * Can be called with zone lock released and irq enabled.
+ */
+bool luf_takeoff_no_shootdown(void)
+{
+	bool no_shootdown = true;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/*
+	 * No way.  Delimit using luf_takeoff_{start,end}().
+	 */
+	if (unlikely(!current->luf_takeoff_started)) {
+		VM_WARN_ON(1);
+		goto out;
+	}
+	no_shootdown = current->luf_no_shootdown;
+out:
+	local_irq_restore(flags);
+	return no_shootdown;
+}
+
+/*
+ * Should be called with either zone lock held and irq disabled or pcp
+ * lock held.
+ */
+bool luf_takeoff_check(struct page *page)
+{
+	unsigned short luf_key = page_luf_key(page);
+
+	/*
+	 * No way.  Delimit using luf_takeoff_{start,end}().
+	 */
+	if (unlikely(!current->luf_takeoff_started)) {
+		VM_WARN_ON(1);
+		return false;
+	}
+
+	if (!luf_key)
+		return true;
+
+	return !current->luf_no_shootdown;
+}
+
+/*
+ * Should be called with either zone lock held and irq disabled or pcp
+ * lock held.
+ */
+bool luf_takeoff_check_and_fold(struct page *page)
+{
+	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
+	unsigned short luf_key = page_luf_key(page);
+	struct luf_batch *lb;
+	unsigned long flags;
+
+	/*
+	 * No way.  Delimit using luf_takeoff_{start,end}().
+	 */
+	if (unlikely(!current->luf_takeoff_started)) {
+		VM_WARN_ON(1);
+		return false;
+	}
+
+	if (!luf_key)
+		return true;
+
+	if (current->luf_no_shootdown)
+		return false;
+
+	lb = &luf_batch[luf_key];
+	read_lock_irqsave(&lb->lock, flags);
+	fold_batch(tlb_ubc_takeoff, &lb->batch, false);
+	read_unlock_irqrestore(&lb->lock, flags);
+	return true;
+}
+#endif
+
 static inline void account_freepages(struct zone *zone, int nr_pages,
 				     int migratetype)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 72c5e665e59a4..1581b1a00f974 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -693,7 +693,7 @@ void fold_batch(struct tlbflush_unmap_batch *dst,
 /*
  * Use 0th entry as accumulated batch.
  */
-static struct luf_batch luf_batch[NR_LUF_BATCH];
+struct luf_batch luf_batch[NR_LUF_BATCH];
 
 static void luf_batch_init(struct luf_batch *lb)
 {
-- 
2.17.1


