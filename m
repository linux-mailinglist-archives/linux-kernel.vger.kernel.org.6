Return-Path: <linux-kernel+bounces-196573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0AC8D5E21
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B631C22D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C75156241;
	Fri, 31 May 2024 09:20:34 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403D1411E4
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147232; cv=none; b=o/g8L9p5oToPQu+pqqWN8NDmX79hek67BPjqHkdY0iaZ3SRLKYbq7NoMIVoqGmcJ3LI+nAbFqzN6c72O8TYbm3riH7s8brt7OR3bfOrpdns/Y741uljXTcjE5n7XYAS4ffPjFfFBEclmJadYVQPBjvVrhP4ho6hRc196VIEIJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147232; c=relaxed/simple;
	bh=DVbRzCJo8ceEy1K8ZXu2A5BAQULFw5UEm4VX/wwE8lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WkACTfXTgn+L2+snWAjFFn66++YLXnXcEQwcJvrapCeiJwjsB39yrqoa4+wxCkPIkSk5W4Vk3uRb7i1xlgTpqzs4QQTtcH5C/XQDIn8QUf8jUeQevO1E05XdrOhy8omTwkXuMatQXq329E6jLDRwt5FTHrMvTc7KbWxXn5OFrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-6c-6659964c9a02
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
Subject: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering tlb flush when folios get unmapped
Date: Fri, 31 May 2024 18:19:58 +0900
Message-Id: <20240531092001.30428-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXC9ZZnoa7PtMg0g7VHFSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	1r73zAWnHzNWfJ69kbWBsWcjYxcjJ4eEgInE5t/T2GDsxrMfweJsAuoSN278ZAaxRQTMJA62
	/mEHsZkF7jJJHOgHqufgEBbIkpg5uQ4kzCKgKnF2+XxWEJsXqPzp9BssECPlJVZvOAA2hhMo
	fuDvHbDxQgKmEov+9wLZXEA1n9kkns1+C3WPpMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZ
	l1mhl5yfu4kRGPzLav9E72D8dCH4EKMAB6MSD29ARUSaEGtiWXFl7iFGCQ5mJRHeX+lAId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYy5rUv/fe/aYXx5
	0emDfHyPH05JzWT+ccDN5cRavaWMJx+vMlq+fssMoRy3Wa9En/nMmaKwZXrUjSML+zcutFEL
	eqMouHuynNtTByUH2eMm1fpJSdqKvDquWzkN1Xeb7mqKMyiX/Cz2cpFcfOK5SovmQ5s3VUdW
	/nA+Uz+zRi6vKEOGN2WiCacSS3FGoqEWc1FxIgAutu26egIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC5WfdrOszLTLNoPWUiMWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mrb2vWcuOP2YseLz7I2sDYw9Gxm7GDk5JARMJBrPfgSz2QTUJW7c+MkMYosI
	mEkcbP3DDmIzC9xlkjjQz9bFyMEhLJAlMXNyHUiYRUBV4uzy+awgNi9Q+dPpN1ggRspLrN5w
	AGwMJ1D8wN87YOOFBEwlFv3vZZzAyLWAkWEVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYCgv
	q/0zcQfjl8vuhxgFOBiVeHgDKiLShFgTy4orcw8xSnAwK4nw/koHCvGmJFZWpRblxxeV5qQW
	H2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTCe6zPIMjse4TZLifP4opKgevfOR8LT
	EpI26f13fj2Xc8OF4/d3V9fEmUs3dnccX985M//8IsaXYo6MPWal5hu0H0xeyDn1Zb2PbvBz
	70eSGVkBJ08LuEs9nKY/fePq7Lu3dIsXy/t8POvx0Vl463x5fwbHw8+q0o/VnF64JNC131s9
	bO7fhXVKLMUZiYZazEXFiQCi4bqRYQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read-only and were unmapped, as
long as the contents of the folios don't change while staying in pcp or
buddy so we can still read the data through the stale tlb entries.

tlb flush can be defered when folios get unmapped as long as it
guarantees to perform tlb flush needed, before the folios actually
become used, of course, only if all the corresponding ptes don't have
write permission.  Otherwise, the system will get messed up.

To achieve that, for the folios that map only to non-writable tlb
entries, prevent tlb flush during unmapping but perform it just before
the folios actually become used, out of buddy or pcp.

However, we should cancel the pending by LUF and perform the deferred
TLB flush right away when:

   1. a writable pte is newly set through fault handler
   2. a file is updated
   3. kasan needs poisoning on free
   4. the kernel wants to init pages on free

No matter what type of workload is used for performance evaluation, the
result would be positive thanks to the unconditional reduction of tlb
flushes, tlb misses and interrupts.  For the test, I picked up one of
the most popular and heavy workload, llama.cpp that is a
LLM(Large Language Model) inference engine.

The result would depend on memory latency and how often reclaim runs,
which implies tlb miss overhead and how many times unmapping happens.
In my system, the result shows:

   1. tlb shootdown interrupts are reduced about 97%.
   2. The test program runtime is reduced about 4.5%.

The test environment and the result is like:

   Machine: bare metal, x86_64, Intel(R) Xeon(R) Gold 6430
   CPU: 1 socket 64 core with hyper thread on
   Numa: 2 nodes (64 CPUs DRAM 42GB, no CPUs CXL expander 98GB)
   Config: swap off, numa balancing tiering on, demotion enabled

   The test set:

      llama.cpp/main -m $(70G_model1) -p "who are you?" -s 1 -t 15 -n 20 &
      llama.cpp/main -m $(70G_model2) -p "who are you?" -s 1 -t 15 -n 20 &
      llama.cpp/main -m $(70G_model3) -p "who are you?" -s 1 -t 15 -n 20 &
      wait

      where -t: nr of threads, -s: seed used to make the runtime stable,
      -n: nr of tokens that determines the runtime, -p: prompt to ask,
      -m: LLM model to use.

   Run the test set 5 times successively with caches dropped every run
   via 'echo 3 > /proc/sys/vm/drop_caches'.  Each inference prints its
   runtime at the end of each.

   1. Runtime from the output of llama.cpp:

   BEFORE
   ------
   llama_print_timings:       total time =  883450.54 ms /    24 tokens
   llama_print_timings:       total time =  861665.91 ms /    24 tokens
   llama_print_timings:       total time =  898079.02 ms /    24 tokens
   llama_print_timings:       total time =  879897.69 ms /    24 tokens
   llama_print_timings:       total time =  892360.75 ms /    24 tokens
   llama_print_timings:       total time =  884587.85 ms /    24 tokens
   llama_print_timings:       total time =  861023.19 ms /    24 tokens
   llama_print_timings:       total time =  900022.18 ms /    24 tokens
   llama_print_timings:       total time =  878771.88 ms /    24 tokens
   llama_print_timings:       total time =  889027.98 ms /    24 tokens
   llama_print_timings:       total time =  880783.90 ms /    24 tokens
   llama_print_timings:       total time =  856475.29 ms /    24 tokens
   llama_print_timings:       total time =  896842.21 ms /    24 tokens
   llama_print_timings:       total time =  878883.53 ms /    24 tokens
   llama_print_timings:       total time =  890122.10 ms /    24 tokens

   AFTER
   -----
   llama_print_timings:       total time =  871060.86 ms /    24 tokens
   llama_print_timings:       total time =  825609.53 ms /    24 tokens
   llama_print_timings:       total time =  836854.81 ms /    24 tokens
   llama_print_timings:       total time =  843147.99 ms /    24 tokens
   llama_print_timings:       total time =  831426.65 ms /    24 tokens
   llama_print_timings:       total time =  873939.23 ms /    24 tokens
   llama_print_timings:       total time =  826127.69 ms /    24 tokens
   llama_print_timings:       total time =  835489.26 ms /    24 tokens
   llama_print_timings:       total time =  842589.62 ms /    24 tokens
   llama_print_timings:       total time =  833700.66 ms /    24 tokens
   llama_print_timings:       total time =  875996.19 ms /    24 tokens
   llama_print_timings:       total time =  826401.73 ms /    24 tokens
   llama_print_timings:       total time =  839341.28 ms /    24 tokens
   llama_print_timings:       total time =  841075.10 ms /    24 tokens
   llama_print_timings:       total time =  835136.41 ms /    24 tokens

   2. tlb shootdowns from 'cat /proc/interrupts':

   BEFORE
   ------
   TLB:
    80911532   93691786  100296251  111062810  109769109  109862429
   108968588  119175230  115779676  118377498  119325266  120300143
   124514185  116697222  121068466  118031913  122660681  117494403
   121819907  116960596  120936335  117217061  118630217  122322724
   119595577  111693298  119232201  120030377  115334687  113179982
   118808254  116353592  140987367  137095516  131724276  139742240
   136501150  130428761  127585535  132483981  133430250  133756207
   131786710  126365824  129812539  133850040  131742690  125142213
   128572830  132234350  131945922  128417707  133355434  129972846
   126331823  134050849  133991626  121129038  124637283  132830916
   126875507  122322440  125776487  124340278   TLB shootdowns

   AFTER
   -----
   TLB:
     2121206    2615108    2983494    2911950    3055086    3092672
     3204894    3346082    3286744    3307310    3357296    3315940
     3428034    3112596    3143325    3185551    3186493    3322314
     3330523    3339663    3156064    3272070    3296309    3198962
     3332662    3315870    3234467    3353240    3281234    3300666
     3345452    3173097    4009196    3932215    3898735    3726531
     3717982    3671726    3728788    3724613    3799147    3691764
     3620630    3684655    3666688    3393974    3448651    3487593
     3446357    3618418    3671920    3712949    3575264    3715385
     3641513    3630897    3691047    3630690    3504933    3662647
     3629926    3443044    3832970    3548813   TLB shootdowns

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/fs.h       |   6 +
 include/linux/mm_types.h |   8 +
 include/linux/sched.h    |   9 ++
 mm/compaction.c          |   2 +-
 mm/internal.h            |  42 +++++-
 mm/memory.c              |  39 ++++-
 mm/page_alloc.c          |  17 ++-
 mm/rmap.c                | 315 ++++++++++++++++++++++++++++++++++++++-
 8 files changed, 420 insertions(+), 18 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..03683bf66031 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2872,6 +2872,12 @@ static inline void file_end_write(struct file *file)
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
 	sb_end_write(file_inode(file)->i_sb);
+
+	/*
+	 * XXX: If needed, can be optimized by avoiding luf_flush() if
+	 * the address space of the file has never been involved by luf.
+	 */
+	luf_flush();
 }
 
 /**
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 37eb3000267c..cd52c996e8aa 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1223,6 +1223,14 @@ static inline unsigned int mm_cid_size(void)
 }
 #endif /* CONFIG_SCHED_MM_CID */
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+void check_luf_flush(unsigned short int ugen);
+void luf_flush(void);
+#else
+static inline void check_luf_flush(unsigned short int ugen) {}
+static inline void luf_flush(void) {}
+#endif
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d9722c014157..613ed175e5f2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1341,8 +1341,17 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
+	struct tlbflush_unmap_batch	tlb_ubc_luf;
 	unsigned short int		ugen;
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+	/*
+	 * whether all the mappings of a folio during unmap are read-only
+	 * so that luf can work on the folio
+	 */
+	bool				can_luf;
+#endif
+
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 13799fbb2a9a..4a75c56af0b0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1925,7 +1925,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
 	struct page *page = &dst->page;
 
 	if (folio_put_testzero(dst)) {
-		free_pages_prepare(page, order);
+		free_pages_prepare(page, order, NULL);
 		list_add(&dst->lru, &cc->freepages[order]);
 		cc->nr_freepages += 1 << order;
 	}
diff --git a/mm/internal.h b/mm/internal.h
index ca6fb5b2a640..b3d7a5e5f7e3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -657,7 +657,8 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
-extern bool free_pages_prepare(struct page *page, unsigned int order);
+extern bool free_pages_prepare(struct page *page, unsigned int order,
+					unsigned short int *ugen);
 
 extern int user_min_free_kbytes;
 
@@ -1541,6 +1542,36 @@ void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+unsigned short int try_to_unmap_luf(void);
+
+/*
+ * Reset the indicator indicating there are no writable mappings at the
+ * beginning of every rmap traverse for unmap.  luf can work only when
+ * all the mappings are read-only.
+ */
+static inline void can_luf_init(void)
+{
+	current->can_luf = true;
+}
+
+/*
+ * Mark the folio is not applicable to luf once it found a writble or
+ * dirty pte during rmap traverse for unmap.
+ */
+static inline void can_luf_fail(void)
+{
+	current->can_luf = false;
+}
+
+/*
+ * Check if all the mappings are read-only and read-only mappings even
+ * exist.
+ */
+static inline bool can_luf_test(void)
+{
+	return current->can_luf && current->tlb_ubc_ro.flush_required;
+}
+
 static inline unsigned short int ugen_latest(unsigned short int a, unsigned short int b)
 {
 	if (!a || !b)
@@ -1570,10 +1601,7 @@ static inline unsigned short int hand_over_task_ugen(void)
 
 static inline void check_flush_task_ugen(void)
 {
-	/*
-	 * XXX: luf mechanism will handle this. For now, do nothing but
-	 * reset current's ugen to finalize this turn.
-	 */
+	check_luf_flush(current->ugen);
 	current->ugen = 0;
 }
 
@@ -1602,6 +1630,10 @@ static inline bool can_luf_folio(struct folio *f)
 	return can_luf;
 }
 #else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static inline unsigned short int try_to_unmap_luf(void) { return 0; }
+static inline void can_luf_init(void) {}
+static inline void can_luf_fail(void) {}
+static inline bool can_luf_test(void) { return false; }
 static inline unsigned short int ugen_latest(unsigned short int a, unsigned short int b) { return 0; }
 static inline void update_task_ugen(unsigned short int ugen) {}
 static inline unsigned short int hand_over_task_ugen(void) { return 0; }
diff --git a/mm/memory.c b/mm/memory.c
index 100f54fc9e6c..12c9e87e489d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3011,6 +3011,15 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	return same;
 }
 
+static bool need_luf_flush(struct vm_fault *vmf)
+{
+	if ((vmf->flags & FAULT_FLAG_ORIG_PTE_VALID) &&
+	    pte_write(vmf->orig_pte))
+		return false;
+
+	return pte_write(ptep_get(vmf->pte));
+}
+
 /*
  * Return:
  *	0:		copied succeeded
@@ -3026,6 +3035,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr = vmf->address;
+	bool luf = false;
 
 	if (likely(src)) {
 		if (copy_mc_user_highpage(dst, src, addr, vma)) {
@@ -3059,8 +3069,10 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 			 * Other thread has already handled the fault
 			 * and update local tlb only
 			 */
-			if (vmf->pte)
+			if (vmf->pte) {
 				update_mmu_tlb(vma, addr, vmf->pte);
+				luf = need_luf_flush(vmf);
+			}
 			ret = -EAGAIN;
 			goto pte_unlock;
 		}
@@ -3084,8 +3096,10 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
 		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
-			if (vmf->pte)
+			if (vmf->pte) {
 				update_mmu_tlb(vma, addr, vmf->pte);
+				luf = need_luf_flush(vmf);
+			}
 			ret = -EAGAIN;
 			goto pte_unlock;
 		}
@@ -3112,6 +3126,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	pagefault_enable();
 	kunmap_local(kaddr);
+	if (luf)
+		luf_flush();
 	flush_dcache_page(dst);
 
 	return ret;
@@ -3446,6 +3462,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	} else if (vmf->pte) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (need_luf_flush(vmf))
+			luf_flush();
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
@@ -3501,6 +3519,8 @@ static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio
 	if (!pte_same(ptep_get(vmf->pte), vmf->orig_pte)) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (need_luf_flush(vmf))
+			luf_flush();
 		return VM_FAULT_NOPAGE;
 	}
 	wp_page_reuse(vmf, folio);
@@ -4469,6 +4489,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int nr_pages = 1;
 	pte_t entry;
+	bool luf = false;
 
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
@@ -4492,6 +4513,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			goto unlock;
 		if (vmf_pte_changed(vmf)) {
 			update_mmu_tlb(vma, vmf->address, vmf->pte);
+			luf = need_luf_flush(vmf);
 			goto unlock;
 		}
 		ret = check_stable_address_space(vma->vm_mm);
@@ -4536,9 +4558,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		goto release;
 	if (nr_pages == 1 && vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, addr, vmf->pte);
+		luf = need_luf_flush(vmf);
 		goto release;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
 		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
+		luf = need_luf_flush(vmf);
 		goto release;
 	}
 
@@ -4570,6 +4594,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (luf)
+		luf_flush();
 	return ret;
 release:
 	folio_put(folio);
@@ -4796,6 +4822,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
+	bool luf = false;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -4841,10 +4868,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = 0;
 	} else {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
+		luf = need_luf_flush(vmf);
 		ret = VM_FAULT_NOPAGE;
 	}
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	if (luf)
+		luf_flush();
 	return ret;
 }
 
@@ -5397,6 +5428,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
+	bool luf = false;
 
 	if (unlikely(pmd_none(*vmf->pmd))) {
 		/*
@@ -5440,6 +5472,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
+		luf = need_luf_flush(vmf);
 		goto unlock;
 	}
 	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
@@ -5469,6 +5502,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (luf)
+		luf_flush();
 	return 0;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c9acb4da91e0..4007c9757c3f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1048,7 +1048,7 @@ void kernel_init_pages(struct page *page, int numpages)
 }
 
 __always_inline bool free_pages_prepare(struct page *page,
-			unsigned int order)
+			unsigned int order, unsigned short int *ugen)
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
@@ -1062,6 +1062,15 @@ __always_inline bool free_pages_prepare(struct page *page,
 	 */
 	set_page_private(page, 0);
 
+	/*
+	 * The contents of the pages will be updated for some reasons.
+	 * So we should give up luf.
+	 */
+	if ((!skip_kasan_poison || init) && ugen && *ugen) {
+		check_luf_flush(*ugen);
+		*ugen = 0;
+	}
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
@@ -1236,7 +1245,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (!free_pages_prepare(page, order))
+	if (!free_pages_prepare(page, order, NULL))
 		return;
 
 	free_one_page(zone, page, pfn, order, fpi_flags, 0);
@@ -2664,7 +2673,7 @@ void free_unref_page(struct page *page, unsigned int order,
 		return;
 	}
 
-	if (!free_pages_prepare(page, order))
+	if (!free_pages_prepare(page, order, &ugen))
 		return;
 
 	/*
@@ -2712,7 +2721,7 @@ void free_unref_folios(struct folio_batch *folios, unsigned short int ugen)
 		unsigned int order = folio_order(folio);
 
 		folio_undo_large_rmappable(folio);
-		if (!free_pages_prepare(&folio->page, order))
+		if (!free_pages_prepare(&folio->page, order, &ugen))
 			continue;
 		/*
 		 * Free orders not handled on the PCP directly to the
diff --git a/mm/rmap.c b/mm/rmap.c
index 1a246788e867..459d4d1631f0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -634,6 +634,274 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+static struct tlbflush_unmap_batch luf_ubc;
+static DEFINE_SPINLOCK(luf_lock);
+
+/*
+ * Don't be zero to distinguish from invalid ugen, 0.
+ */
+static unsigned short int ugen_next(unsigned short int a)
+{
+	return a + 1 ?: a + 2;
+}
+
+static bool ugen_before(unsigned short int a, unsigned short int b)
+{
+	return (short int)(a - b) < 0;
+}
+
+/*
+ * Need to synchronize between tlb flush and managing pending CPUs in
+ * luf_ubc.  Take a look at the following scenario, where CPU0 is in
+ * try_to_unmap_flush() and CPU1 is in migrate_pages_batch():
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	tlb flush
+ *				unmap folios (needing tlb flush)
+ *				add pending CPUs to luf_ubc
+ *				<-- not performed tlb flush needed by
+ *				    the unmap above yet but the request
+ *				    will be cleared by CPU0 shortly. bug!
+ *	clear the CPUs from luf_ubc
+ *
+ * The pending CPUs added in CPU1 should not be cleared from luf_ubc
+ * in CPU0 because the tlb flush for luf_ubc added in CPU1 has not
+ * been performed this turn.  To avoid this, using 'on_flushing'
+ * variable, prevent adding pending CPUs to luf_ubc and give up luf
+ * mechanism if someone is in the middle of tlb flush, like:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	on_flushing++
+ *	tlb flush
+ *				unmap folios (needing tlb flush)
+ *				if on_flushing == 0:
+ *				   add pending CPUs to luf_ubc
+ *				else: <-- hit
+ *				   give up luf mechanism
+ *	clear the CPUs from luf_ubc
+ *	on_flushing--
+ *
+ * Only the following case would be allowed for luf mechanism to work:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *				unmap folios (needing tlb flush)
+ *				if on_flushing == 0: <-- hit
+ *				   add pending CPUs to luf_ubc
+ *				else:
+ *				   give up luf mechanism
+ *	on_flushing++
+ *	tlb flush
+ *	clear the CPUs from luf_ubc
+ *	on_flushing--
+ */
+static int on_flushing;
+
+/*
+ * When more than one thread enter check_luf_flush() at the same
+ * time, each should wait for the request on progress to be done to
+ * avoid the following scenario, where the both CPUs are in
+ * check_luf_flush():
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	if !luf_ubc.flush_required:
+ *	   return
+ *	luf_ubc.flush_required = false
+ *				if !luf_ubc.flush_requied: <-- hit
+ *				   return <-- not performed tlb flush
+ *				              needed yet but return. bug!
+ *				luf_ubc.flush_required = false
+ *				try_to_unmap_flush()
+ *				finalize
+ *	try_to_unmap_flush() <-- performs tlb flush needed
+ *	finalize
+ *
+ * So it should be handled:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	atomically execute {
+ *	   if luf_on_flushing:
+ *	      wait for the completion
+ *	      return
+ *	   if !luf_ubc.flush_required:
+ *	      return
+ *	   luf_ubc.flush_required = false
+ *	   luf_on_flushing = true
+ *	}
+ *				atomically execute {
+ *				   if luf_on_flushing: <-- hit
+ *				      wait for the completion
+ *				      return <-- tlb flush needed is done
+ *				   if !luf_ubc.flush_requied:
+ *				      return
+ *				   luf_ubc.flush_required = false
+ *				   luf_on_flushing = true
+ *				}
+ *
+ *				try_to_unmap_flush()
+ *				luf_on_flushing = false
+ *				finalize
+ *	try_to_unmap_flush() <-- performs tlb flush needed
+ *	luf_on_flushing = false
+ *	finalize
+ */
+static bool luf_on_flushing;
+
+/*
+ * Generation number for the current request of deferred tlb flush.
+ */
+static unsigned short int luf_gen;
+
+/*
+ * Generation number for the next request.
+ */
+static unsigned short int luf_gen_next = 1;
+
+/*
+ * Generation number for the latest request handled.
+ */
+static unsigned short int luf_gen_done;
+
+unsigned short int try_to_unmap_luf(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	unsigned long flags;
+	unsigned short int ugen;
+
+	if (!spin_trylock_irqsave(&luf_lock, flags)) {
+		/*
+		 * Give up luf mechanism.  Just let tlb flush needed
+		 * handled by try_to_unmap_flush() at the caller side.
+		 */
+		fold_ubc(tlb_ubc, tlb_ubc_luf);
+		return 0;
+	}
+
+	if (on_flushing || luf_on_flushing) {
+		spin_unlock_irqrestore(&luf_lock, flags);
+
+		/*
+		 * Give up luf mechanism.  Just let tlb flush needed
+		 * handled by try_to_unmap_flush() at the caller side.
+		 */
+		fold_ubc(tlb_ubc, tlb_ubc_luf);
+		return 0;
+	}
+
+	fold_ubc(&luf_ubc, tlb_ubc_luf);
+	ugen = luf_gen = luf_gen_next;
+	spin_unlock_irqrestore(&luf_lock, flags);
+
+	return ugen;
+}
+
+static bool rmap_flush_start(void)
+{
+	unsigned long flags;
+
+	if (!spin_trylock_irqsave(&luf_lock, flags))
+		return false;
+
+	on_flushing++;
+	spin_unlock_irqrestore(&luf_lock, flags);
+	return true;
+}
+
+static void rmap_flush_end(struct tlbflush_unmap_batch *batch)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&luf_lock, flags);
+	if (arch_tlbbatch_done(&luf_ubc.arch, &batch->arch)) {
+		luf_ubc.flush_required = false;
+		luf_ubc.writable = false;
+	}
+	on_flushing--;
+	spin_unlock_irqrestore(&luf_lock, flags);
+}
+
+/*
+ * It must be guaranteed to have completed tlb flush requested on return.
+ */
+void check_luf_flush(unsigned short int ugen)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	unsigned long flags;
+
+	/*
+	 * Nothing has been requested.  We are done.
+	 */
+	if (!ugen)
+		return;
+retry:
+	/*
+	 * We can see a larger value than or equal to luf_gen_done,
+	 * which means the tlb flush we need has been done.
+	 */
+	if (!ugen_before(READ_ONCE(luf_gen_done), ugen))
+		return;
+
+	spin_lock_irqsave(&luf_lock, flags);
+
+	/*
+	 * With luf_lock held, we might read luf_gen_done updated.
+	 */
+	if (ugen_next(luf_gen_done) != ugen) {
+		spin_unlock_irqrestore(&luf_lock, flags);
+		return;
+	}
+
+	/*
+	 * Others are already working for us.
+	 */
+	if (luf_on_flushing) {
+		spin_unlock_irqrestore(&luf_lock, flags);
+		goto retry;
+	}
+
+	if (!luf_ubc.flush_required) {
+		spin_unlock_irqrestore(&luf_lock, flags);
+		return;
+	}
+
+	fold_ubc(tlb_ubc, &luf_ubc);
+	luf_gen_next = ugen_next(luf_gen);
+	luf_on_flushing = true;
+	spin_unlock_irqrestore(&luf_lock, flags);
+
+	try_to_unmap_flush();
+
+	spin_lock_irqsave(&luf_lock, flags);
+	luf_on_flushing = false;
+
+	/*
+	 * luf_gen_done can be read by another with luf_lock not
+	 * held so use WRITE_ONCE() to prevent tearing.
+	 */
+	WRITE_ONCE(luf_gen_done, ugen);
+	spin_unlock_irqrestore(&luf_lock, flags);
+}
+
+void luf_flush(void)
+{
+	unsigned long flags;
+	unsigned short int ugen;
+
+	/*
+	 * Obtain the latest ugen number.
+	 */
+	spin_lock_irqsave(&luf_lock, flags);
+	ugen = luf_gen;
+	spin_unlock_irqrestore(&luf_lock, flags);
+
+	check_luf_flush(ugen);
+}
+EXPORT_SYMBOL(luf_flush);
 
 void fold_ubc(struct tlbflush_unmap_batch *dst,
 	      struct tlbflush_unmap_batch *src)
@@ -665,13 +933,18 @@ void fold_ubc(struct tlbflush_unmap_batch *dst,
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
-	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	bool started;
 
-	fold_ubc(tlb_ubc, tlb_ubc_ro);
+	fold_ubc(tlb_ubc, tlb_ubc_luf);
 	if (!tlb_ubc->flush_required)
 		return;
 
+	started = rmap_flush_start();
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	if (started)
+		rmap_flush_end(tlb_ubc);
+
 	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
@@ -681,9 +954,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
-	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 
-	if (tlb_ubc->writable || tlb_ubc_ro->writable)
+	if (tlb_ubc->writable || tlb_ubc_luf->writable)
 		try_to_unmap_flush();
 }
 
@@ -707,9 +980,15 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	if (!pte_accessible(mm, pteval))
 		return;
 
-	if (pte_write(pteval))
+	if (pte_write(pteval)) {
 		tlb_ubc = &current->tlb_ubc;
-	else
+
+		/*
+		 * luf cannot work with the folio once it found a
+		 * writable or dirty mapping on it.
+		 */
+		can_luf_fail();
+	} else
 		tlb_ubc = &current->tlb_ubc_ro;
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
@@ -2004,11 +2283,23 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	bool can_luf;
+
+	can_luf_init();
 
 	if (flags & TTU_RMAP_LOCKED)
 		rmap_walk_locked(folio, &rwc);
 	else
 		rmap_walk(folio, &rwc);
+
+	can_luf = can_luf_folio(folio) && can_luf_test();
+	if (can_luf)
+		fold_ubc(tlb_ubc_luf, tlb_ubc_ro);
+	else
+		fold_ubc(tlb_ubc, tlb_ubc_ro);
 }
 
 /*
@@ -2353,6 +2644,10 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	bool can_luf;
 
 	/*
 	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
@@ -2377,10 +2672,18 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	if (!folio_test_ksm(folio) && folio_test_anon(folio))
 		rwc.invalid_vma = invalid_migration_vma;
 
+	can_luf_init();
+
 	if (flags & TTU_RMAP_LOCKED)
 		rmap_walk_locked(folio, &rwc);
 	else
 		rmap_walk(folio, &rwc);
+
+	can_luf = can_luf_folio(folio) && can_luf_test();
+	if (can_luf)
+		fold_ubc(tlb_ubc_luf, tlb_ubc_ro);
+	else
+		fold_ubc(tlb_ubc, tlb_ubc_ro);
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
-- 
2.17.1


