Return-Path: <linux-kernel+bounces-533744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7FA45E37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51403A96E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7F2206A6;
	Wed, 26 Feb 2025 12:03:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6E21B192
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571432; cv=none; b=q+UPrTrsAKa6OtcDmnUV3RzMjIkDI7h0MOFAzdwcyTZ9mDIj9llDUKJiEqEA3M7HulG7OpuKM4voM9FQtCjYbzoUbkznRzWBnYmhvfoYLkPdcxwRcPWIisESE9JEgt7AMrT+ZMUNqwJdHZLrFLBoYn+HnMTOUc1fDwFNzZQodes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571432; c=relaxed/simple;
	bh=KQ5kR5KOjuG5TT1NQ9BdZaD9WIwgrogpeFMNlJHIjgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XBUII3FAfHVoUcqe+k+DJpTBJ518K2xB1Q4DRm0csei/Nr4kgcFHP468hm5SinvgXJx1+S1m8U8POfTI2mjy2r097Xznifaoimr20gUwOwMqx7dwbM9xGCGd0Y8ukDwlYKMwDR0gk9B08qBunfxAY50pv5HdVyh2sWUNgLpxBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-1e-67bf032265ed
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
Subject: [RFC PATCH v12 based on v6.14-rc4 09/25] mm: introduce API to perform tlb shootdown on exit from page allocator
Date: Wed, 26 Feb 2025 21:03:20 +0900
Message-Id: <20250226120336.29565-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoa4S8/50g6//9SzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PFldqCR6IVzRd7GRsYZwt1MXJy
	SAiYSHyb+ZAJxt59bwkLiM0moC5x48ZPZhBbRMBM4mDrH/YuRi4OZoFlTBJ7TzSwgSSEBSok
	psx4CtbAIqAqsX3PVkYQm1fAVOJUx1VGiKHyEqs3HAAbxAk06NO0Y2C9QgLJEjt//2ECGSoh
	cJtNoqnnJ1SDpMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZl1mhl5yfu4kRGNTLav9E72D8
	dCH4EKMAB6MSD++DM3vThVgTy4orcw8xSnAwK4nwcmbuSRfiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAyFo79fkXfhsfrtQZre0nLkU9SGi74MpcHvh1
	RmPewXdTRS8zzs8XPHrQ1OlcSfW1VMWFm27IsfAw72q3/PRu/R7289tUw6+weRZmuV5yK7Ns
	bLi7ir/F/JZ+1vF0yWNerTYxBhvSHtXyvq47d8NpD1v2W/fXzn5L+B0msDbJzszY9PXhUx53
	JZbijERDLeai4kQAYsuXG2YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYHu/msWc9WvYLD5v+Mdm
	8XX9L2aLp5/6WCwOzz3JanF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsjjee4DJYv69z2wW
	mzdNZbY4PmUqo8XvH3PYHPg9vrf2sXjsnHWX3WPBplKPzSu0PDat6mTz2PRpErvHu3Pn2D1O
	zPjN4vF+31U2j8UvPjB5bP1l59E49Rqbx+dNcgG8UVw2Kak5mWWpRfp2CVwZK67UFjwSrWi+
	2MvYwDhbqIuRk0NCwERi970lLCA2m4C6xI0bP5lBbBEBM4mDrX/Yuxi5OJgFljFJ7D3RwAaS
	EBaokJgy4ylYA4uAqsT2PVsZQWxeAVOJUx1XGSGGykus3nAAbBAn0KBP046B9QoJJEvs/P2H
	aQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBIbqs9s/EHYxfLrsfYhTgYFTi4X1w
	Zm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNL
	UrNTUwtSi2CyTBycUg2Ms6Jm1iuslbD7+TRqxjqltWF2tS7fb7ros1kcyAje+/sCS1/Vec9H
	68OX3H9psLnN439Cv/Phr7584f+WHD3Zd90y9dXTifZ/VNu/rzomuyBFbYNf2w+5lZ9fZDPI
	e0TfYH67zGb2b09bc/tw1jvuKx5O/M/df6365LWXyW3Jfnas5+cc9WjXVGIpzkg01GIuKk4E
	AHMyoZlNAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
performs tlb shootdown required on exit from page allocator.

This patch introduced a new API rather than making use of existing
try_to_unmap_flush() to avoid repeated and redundant tlb shootdown due
to frequent page allocations during a session of batched unmap flush.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/internal.h         |  4 ++++
 mm/rmap.c             | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d6..86ef426644639 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1401,6 +1401,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index 3333d8d461c2c..b52e14f86c436 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1252,6 +1252,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
+void try_to_unmap_flush_takeoff(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
 void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
 void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
@@ -1262,6 +1263,9 @@ static inline void try_to_unmap_flush(void)
 static inline void try_to_unmap_flush_dirty(void)
 {
 }
+static inline void try_to_unmap_flush_takeoff(void)
+{
+}
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 74fbf6c2fb3a7..72c5e665e59a4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -772,6 +772,26 @@ void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
 	read_unlock_irqrestore(&src->lock, flags);
 }
 
+void try_to_unmap_flush_takeoff(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
+
+	if (!tlb_ubc_takeoff->flush_required)
+		return;
+
+	arch_tlbbatch_flush(&tlb_ubc_takeoff->arch);
+
+	/*
+	 * Now that tlb shootdown of tlb_ubc_takeoff has been performed,
+	 * it's good chance to shrink tlb_ubc if possible.
+	 */
+	if (arch_tlbbatch_done(&tlb_ubc->arch, &tlb_ubc_takeoff->arch))
+		reset_batch(tlb_ubc);
+
+	reset_batch(tlb_ubc_takeoff);
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
-- 
2.17.1


