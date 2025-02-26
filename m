Return-Path: <linux-kernel+bounces-533746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF02A45E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C589217A2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E9221556;
	Wed, 26 Feb 2025 12:03:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C38921B1BE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571432; cv=none; b=EVsh6C1LWr7RqXSVuwk3MWeShPorNri1uEdtsyqvo4XG2XwOa+JURS3+3xx48jirEH4BaCC/kmKkBNZWWr7+0q5o+1ZDqy5Lcx3rub6J4jPC5s8MMHIw1X0tYc7v7RSCnwoDUeEIkuI5h/RzC+P8X5lXl1Zc1740vuGAUSomios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571432; c=relaxed/simple;
	bh=1zo6F/+409UZLJiSTF/xB1rmKTTBQ/thLwhwg4bLRAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qlwEx5JLLtmgYR9285CI6wiz314HUMkKVkjLzrZmf73JV9Da1ihV9yqS7fQ/c8+nDVUJ2QwSdZMSXcFlS4WCcH3KYWkPAGMRkuBWxLoLK3ZfDpJGilatB2XcLKPfGhZCv6iwoV1ASVpzvoEhDBxio2DB7nGipdqdQZPNTAekKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-23-67bf0322c49c
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
Subject: [RFC PATCH v12 based on v6.14-rc4 10/25] mm: introduce APIs to check if the page allocation is tlb shootdownable
Date: Wed, 26 Feb 2025 21:03:21 +0900
Message-Id: <20250226120336.29565-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50g7UfDSzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK+PG1mNsBT+NK9ZP38bcwHhcq4uR
	k0NCwERi67p/TDD29G8PWEBsNgF1iRs3fjKD2CICZhIHW/+wdzFycTALLGOS2Huiga2LkYND
	WKBSYsfpGJAaFgFViS93TjKC2LxA9Ssfz2ODmCkvsXrDAbA5nEDxT9OOgcWFBJIldv7+wwQy
	U0LgPpvEh85DUEdIShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiBQb2s9k/0
	DsZPF4IPMQpwMCrx8D44szddiDWxrLgy9xCjBAezkggvZ+aedCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MvL/PXT7G8VdX5OZb3reF2/sdtqj2Rl5/
	MHklb7zpdt0NTBf/fLA8sUHTVOSa+BI1N5W9CvFv1i2+n+idoLn7wdF7uee8Qj7ZG/8LPFun
	0H7wgbPrMRe1mGnsJT89Am8zxPeHC81SLRLzfHUv1OvV9McXnvOfrZJznlT5QaqTcUZ29Jtf
	qiFWSizFGYmGWsxFxYkANVSxGmYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4MZ0DYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgybmw9xlbw07hi
	/fRtzA2Mx7W6GDk5JARMJKZ/e8ACYrMJqEvcuPGTGcQWETCTONj6h72LkYuDWWAZk8TeEw1s
	XYwcHMIClRI7TseA1LAIqEp8uXOSEcTmBapf+XgeG8RMeYnVGw6AzeEEin+adgwsLiSQLLHz
	9x+mCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG6LLaPxN3MH657H6IUYCDUYmH
	98GZvelCrIllxZW5hxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJI
	TyxJzU5NLUgtgskycXBKNTA6mb2Z9zROaOuB2cx19w2TS85smnSY58WOj6XfmPgmTbcMED+X
	NvvLsoXrFn9d9OxmQ1HXhL51S9Yq1r69KTy9a+PUBnH3VddqVjTnKPfVs043U/57Ly3jnd1H
	M8O5jz4d5BEXTkpc/LPWwLDkucjWw+YPnP/Nt/kg+Xv/s4mMIbWyrlF3oz55KrEUZyQaajEX
	FScCAO0dzwxNAgAA
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
index 86ef426644639..a3049ea5b3ad3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,6 +1400,11 @@ struct task_struct {
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
index b52e14f86c436..5e67f009d23c6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1580,6 +1580,20 @@ static inline void accept_page(struct page *page)
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
index 27aeee0cfcf8f..a964a98fbad51 100644
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


