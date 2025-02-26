Return-Path: <linux-kernel+bounces-533722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B047EA45E18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704FD188B29A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64F221545;
	Wed, 26 Feb 2025 12:01:52 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1121930F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571311; cv=none; b=KJlgwtE0ewCN9Tk/OdXE9LukFfwOwRHE71z9781fq9v/P7R7aNUCAPx2EQg7VD1STVVeJ2GYPMaOCgGJc4UpWJnmZvMYZZHDC29pTx3FvG9Sz1WPIffBH4qlPd8HVtA43iHhFzUosXVivNvyvwgkez+mKT/+AHXsSIp43JSZyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571311; c=relaxed/simple;
	bh=57QHpoysQWEft1sL8T1EAF6ZkRuMw5tGBr6JNeFkqc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gi49ubbzYwYGsow2rC7avwvLItFlEM1mFzbY2UrBsN8cQbYMfiB/oH7A7IOtFnx7qeGa7h9Z9TxHoVwDXNLXm4Di2gXxMtJe9mQKcMGar34eVNypNs+fYV0d0iHbM2XQzCZBxAqo2i3JIWLoL3l2SPEr6EgTY4PeT9TY/8zoS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-f4-67bf02a682ef
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 10/25] mm: introduce APIs to check if the page allocation is tlb shootdownable
Date: Wed, 26 Feb 2025 21:01:17 +0900
Message-Id: <20250226120132.28469-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBnPfG1nMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8bXnplMBT+NK/62GTUwHtfqYuTk
	kBAwkfjz4i4TjH1p41QWEJtNQF3ixo2fzCC2iICZxMHWP+xdjFwczALLmCT2nmhgA3GEBfoY
	JW517wHrYBFQlbjSvQpsEi9Qx/vT/5khpspLrN5wAMzmBIr/2/2bHcQWEkiWaFn/mwVkkITA
	bTaJR6/mskA0SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgWG9rPZP9A7G
	TxeCDzEKcDAq8fA+OLM3XYg1say4MvcQowQHs5IIL2fmnnQh3pTEyqrUovz4otKc1OJDjNIc
	LErivEbfylOEBNITS1KzU1MLUotgskwcnFINjFMWJG+44J3SwMS2UKfY1EPm0Hpd9gwLhetT
	XhYcOJpTkBVV7GJ5q+HqzIeSSyesdl78/dpi63B1vp5Zmxt+qNV1/U6T+Pnrea6yLM/0XxsW
	LDRKuXS88E98/d8QqVUfrnfdeqndONVl3YG70Wv3rrDou9N8KvnGrr8PVQQueppXbF/tfcOx
	W06JpTgj0VCLuag4EQDOqW81ZwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wanfmhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlfO2ZyVTw07ji
	b5tRA+NxrS5GTg4JAROJSxunsoDYbALqEjdu/GQGsUUEzCQOtv5h72Lk4mAWWMYksfdEAxuI
	IyzQxyhxq3sPWAeLgKrEle5VTCA2L1DH+9P/mSGmykus3nAAzOYEiv/b/ZsdxBYSSJZoWf+b
	ZQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBQbqs9s/EHYxfLrsfYhTgYFTi4X1w
	Zm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNL
	UrNTUwtSi2CyTBycUg2MOWfnFsQlbDnOuH9BJB+v7Z+HnmtMQ3mdltbp1F1ZXsy+8IXvu+1b
	X7zLd+I6ejJR4lxPaSuP9Pt/mWezWdl+2pQwVFhtUp1pxDFLL3pCo97GCXUtXqtvWr5k7Jgu
	zPdpFfvVrR89HtYbd954Yf5XSCvff9mOn0X2bFZ/dGamnn14JaHunNUXJZbijERDLeai4kQA
	Fd5EEU4CAAA=
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
index 8ad7e86c1c0e2..bf16482bce2f5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1598,6 +1598,20 @@ static inline void accept_page(struct page *page)
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
index f3930a2a05cd3..f3cb02e36e770 100644
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
index 61366b4570c9a..40de03c8f73be 100644
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


