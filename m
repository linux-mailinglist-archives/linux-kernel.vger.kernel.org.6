Return-Path: <linux-kernel+bounces-183347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449C8C97D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6EB282C57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E031C2A3;
	Mon, 20 May 2024 02:18:01 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D8134B2
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171481; cv=none; b=KJIGvglkhsSTxo1zU/Gn8QqBy/rKHZN7ZY8E3wdWW99XS0PxKNwN7J1q8icuqoLCTC1yf/TMOk9jFv7bblaG6el0jzYNZv5lAnYjCHkAOIa87aCMEUKyc/otLMHvnXAc4KwlTSCXYmQ1VrAMqLxy3rdKYQyVu4389Emsx6n84UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171481; c=relaxed/simple;
	bh=F8iBaXPfyAs8+pBArnftJrFJRE6eOJaC+K3wXJHYEbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Xo6dhiin9XxJBXokfUof/8s0vA6QlIohjkT+z3PI2kxtUCkCM3Dje+IzYJgBKgEuoTARiVtR5X/kF/2Q5HU8r0PukUe88FwYM6UGhpmxCMybhygNrwB9oV7/NJZf70yqosFv0jtJq4h6rMBG4wKkrbCn+xngvyz6KRggfwI9Xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-bd-664ab2c98c0d
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
Subject: [RESEND PATCH v10 08/12] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Mon, 20 May 2024 11:17:30 +0900
Message-Id: <20240520021734.21527-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnoe7JTV5pBpdn8FjMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	hneP2AvuyFZc3D2DrYHxiEQXIzuHhICJRJN1FyMnmDX10XUWEJtNQF3ixo2fzCC2iICZxMHW
	P+wgNrPAXSaJA/1sILawQLLEm12bwWwWAVWJhqk3GEFsXgFTie6lxxghZspLrN5wAGwOJ9Cc
	Gat2gs0XAqr5cfQrG0TNezaJQ+eg6iUlDq64wTKBkXcBI8MqRqHMvLLcxMwcE72MyrzMCr3k
	/NxNjMCgX1b7J3oH46cLwYcYBTgYlXh4dzzyTBNiTSwrrsw9xCjBwawkwrtpC1CINyWxsiq1
	KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo33CvvkfvWWC/1u2sf6X
	qVe/d67ljMDSQ8++v375uFD2BJcQz8aZ+n6+KelGDTpGZ3nueLq5SBz/1NAarSfMYMR70fOm
	nWdFb7NfOkPGEqnSzKLflxkfOHkZ69oEJLzdGOk+w6Qm6btJeCcL85OzOueWcufOmziJh1n6
	0wndI0p1yuINb1qVWIozEg21mIuKEwHfpzXxdgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrHtyk1eawf3jTBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgymh494i94I5sxcXdM9gaGI9IdDFyckgImEhMfXSdBcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/G4gtLJAs8WbXZjCbRUBVomHqDUYQm1fAVKJ76TFGiJnyEqs3HACb
	wwk0Z8aqnWDzhYBqfhz9yjaBkWsBI8MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwEBeVvtn
	4g7GL5fdDzEKcDAq8fBuuO2ZJsSaWFZcmXuIUYKDWUmEd9MWoBBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAPjGuXpyvuCa4Wu5Zi71sTNiF1o+txDyetj
	bdGGb6fOL2szUmfOtvJ1uPO4b07X67ieDfWPcibJpix8tp39xuLE1jwZR4ZNZ8L+7JNhkDz8
	veLy73xfa6sPltFa618dPjm1tlJ53Rq+oJvr3nw7Grs30Fxn8hOBf8+2ZLpMqrH5F1H9fnMK
	Z890JZbijERDLeai4kQA4J+2GmACAAA=
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


