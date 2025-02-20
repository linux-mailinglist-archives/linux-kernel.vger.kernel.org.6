Return-Path: <linux-kernel+bounces-522998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFDA3D0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90DB16E307
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3241EE00A;
	Thu, 20 Feb 2025 05:36:13 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A851E5734
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029770; cv=none; b=lyplY8ngUS7peizU+prZCRmh8IdBEWRsYTWMCiILbSiquW2XVkNdYciVghaVDeyd6BO0zAoKIWkT4Qk2drfFkHJr3edQjlfMSnLXpYa6cCPlo7faAJ5EicPH26B/DFXdrVJhcLmxMa7nCEVLnkOJztKTUbjiXo3HWrdYY5PuAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029770; c=relaxed/simple;
	bh=sBgFgGiwQ2AQvkC45eUex4ANimKUgDhVvJX/lv+z+54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X9b4l3TQdjVThWn7yIUcM9M/UoC2Be4elVabkjVlFDwUvzjJB3dvrt+H1sgOqjGytNo4eQCPUPq/zkIqODgQu/w8QQJFZQ9c5KQT8GU40BeZ+sOGpiArSZc3tukTmase7x1GrCT4PHf3VeGbpteNdjPvgTsr6iWEUnB0wjGJGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-fe-67b6bba6fd6f
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
Subject: [RFC PATCH v12 16/26] mm: implement LUF(Lazy Unmap Flush) defering tlb flush when folios get unmapped
Date: Thu, 20 Feb 2025 14:20:17 +0900
Message-Id: <20250220052027.58847-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDXbtYLSYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	M7d/YCvovcdYsfrRNuYGxpb1jF2MnBwSAiYSv29NYIex/07oZgOx2QTUJW7c+MkMYosImEkc
	bP0DVsMscJdJ4kA/WI2wQJ7Eq7l/weawCKhKLHmzHqyeF6j+655JzBAz5SVWbzgAZnMCxX/M
	6AXrFRIwlXi34BJTFyMXUM1nNonpzbNYIRokJQ6uuMEygZF3ASPDKkahzLyy3MTMHBO9jMq8
	zAq95PzcTYzA8F9W+yd6B+OnC8GHGAU4GJV4eGe0bksXYk0sK67MPcQowcGsJMLbVr8lXYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVANjbNrfeIH/wVur
	pc61yf6LX2pfu2oX24UPthZxR2sWFN5M+Okp2BwW435KeNuEh3POylbNt/m7SXv6Y6l3txfK
	iU2fU36X+UXT75x78hdm6d0uC6heceLEkwY5nqS+Kn8D1syW317aDPtvS+t92u1ycL+8/hO1
	663/l/od/9X30N2kY29lVeh7JZbijERDLeai4kQAa5ymkHsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0gzk3jS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlTFz+we2gt57jBWrH21jbmBsWc/YxcjJISFgIvF3QjcbiM0moC5x48ZPZhBb
	RMBM4mDrH3YQm1ngLpPEgX6wGmGBPIlXc/+C9bIIqEosebMerJ4XqP7rnknMEDPlJVZvOABm
	cwLFf8zoBesVEjCVeLfgEtMERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAoN5We2f
	iTsYv1x2P8QowMGoxMP74PHWdCHWxLLiytxDjBIczEoivG31W9KFeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGOfxVjBz+5rknE1b3JFoOcXTy8RK8snt
	NTu95hoee3Q9mPXuBLW1Lz8/fZ33pLf1bnLGvI2RX0qk84/c3HdcYuHT2vk6735s1vv7c8P3
	k7O4/a3YGuM+ys5/nCAYffHg0zXMm6bNDdtTrRBslO6Rtmajq86SR6XX8hrL9s68mV/z+fGT
	l19+GLIqsRRnJBpqMRcVJwIANMT5emICAAA=
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

The test environment and the test set are like:

   Machine: bare metal, x86_64, Intel(R) Xeon(R) Gold 6430
   CPU: 1 socket 64 core with hyper thread on
   Numa: 2 nodes (64 CPUs DRAM 42GB, no CPUs CXL expander 98GB)
   Config: swap off, numa balancing tiering on, demotion enabled

   llama.cpp/main -m $(70G_model1) -p "who are you?" -s 1 -t 15 -n 20 &
   llama.cpp/main -m $(70G_model2) -p "who are you?" -s 1 -t 15 -n 20 &
   llama.cpp/main -m $(70G_model3) -p "who are you?" -s 1 -t 15 -n 20 &
   wait

   where,
   -t: nr of threads, -s: seed used to make the runtime stable,
   -n: nr of tokens that determines the runtime, -p: prompt to ask,
   -m: LLM model to use.

Run the test set 5 times successively with caches dropped every run via
'echo 3 > /proc/sys/vm/drop_caches'.  Each inference prints its runtime
at the end of each.  The results are like:

   1. Runtime from the output of llama.cpp

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

   2. tlb shootdowns from 'cat /proc/interrupts'

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
 include/asm-generic/tlb.h |   5 ++
 include/linux/fs.h        |  12 +++-
 include/linux/mm_types.h  |   6 ++
 include/linux/sched.h     |   9 +++
 kernel/sched/core.c       |   1 +
 mm/internal.h             |  94 ++++++++++++++++++++++++-
 mm/memory.c               |  15 ++++
 mm/pgtable-generic.c      |   2 +
 mm/rmap.c                 | 141 +++++++++++++++++++++++++++++++++++---
 mm/truncate.c             |  55 +++++++++++++--
 mm/vmscan.c               |  12 +++-
 11 files changed, 333 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b756..4a99351be111e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -549,6 +549,11 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
 
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
+	/*
+	 * Don't leave stale tlb entries for this vma.
+	 */
+	luf_flush(0);
+
 	if (tlb->fullmm)
 		return;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bfd8aaeb78bb8..ec88270221bfe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -499,8 +499,18 @@ static inline int mapping_write_begin(struct file *file,
 				loff_t pos, unsigned len,
 				struct folio **foliop, void **fsdata)
 {
-	return mapping->a_ops->write_begin(file, mapping, pos, len, foliop,
+	int ret;
+
+	ret = mapping->a_ops->write_begin(file, mapping, pos, len, foliop,
 			fsdata);
+
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	if (!ret)
+		luf_flush(0);
+
+	return ret;
 }
 
 static inline int mapping_write_end(struct file *file,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 39a6b5124b01f..b3eb5a4e45efb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1270,6 +1270,12 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+void luf_flush(unsigned short luf_key);
+#else
+static inline void luf_flush(unsigned short luf_key) {}
+#endif
+
 struct vm_fault;
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a217d6011fdfe..94321d51b91e8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1382,6 +1382,15 @@ struct task_struct {
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
+	struct tlbflush_unmap_batch	tlb_ubc_luf;
+
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+	/*
+	 * whether all the mappings of a folio during unmap are read-only
+	 * so that luf can work on the folio
+	 */
+	bool				can_luf;
+#endif
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 719e0ed1e9761..aea08d8a9e258 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5225,6 +5225,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop_lazy_tlb_sched(mm);
+		luf_flush(0);
 	}
 
 	if (unlikely(prev_state == TASK_DEAD)) {
diff --git a/mm/internal.h b/mm/internal.h
index 0dc374553f9b5..fe4a1c174895f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1604,13 +1604,105 @@ static inline bool non_luf_pages_ok(struct zone *zone)
 
 	return nr_free - nr_luf_pages > min_wm;
 }
-#else
+
+unsigned short fold_unmap_luf(void);
+
+/*
+ * Reset the indicator indicating there are no writable mappings at the
+ * beginning of every rmap traverse for unmap.  luf can work only when
+ * all the mappings are read-only.
+ */
+static inline void can_luf_init(struct folio *f)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_PAGEALLOC))
+		current->can_luf = false;
+	/*
+	 * Pages might get updated inside buddy.
+	 */
+	else if (want_init_on_free())
+		current->can_luf = false;
+	/*
+	 * Pages might get updated inside buddy.
+	 */
+	else if (!should_skip_kasan_poison(folio_page(f, 0)))
+		current->can_luf = false;
+	/*
+	 * XXX: Remove the constraint once luf handles zone device folio.
+	 */
+	else if (unlikely(folio_is_zone_device(f)))
+		current->can_luf = false;
+	/*
+	 * XXX: Remove the constraint once luf handles hugetlb folio.
+	 */
+	else if (unlikely(folio_test_hugetlb(f)))
+		current->can_luf = false;
+	/*
+	 * XXX: Remove the constraint once luf handles large folio.
+	 */
+	else if (unlikely(folio_test_large(f)))
+		current->can_luf = false;
+	/*
+	 * Can track write of anon folios through fault handler.
+	 */
+	else if (folio_test_anon(f))
+		current->can_luf = true;
+	/*
+	 * Can track write of file folios through page cache or truncation.
+	 */
+	else if (folio_mapping(f))
+		current->can_luf = true;
+	/*
+	 * For niehter anon nor file folios, do not apply luf.
+	 */
+	else
+		current->can_luf = false;
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
+ * Check if all the mappings are read-only.
+ */
+static inline bool can_luf_test(void)
+{
+	return current->can_luf;
+}
+
+static inline bool can_luf_vma(struct vm_area_struct *vma)
+{
+	/*
+	 * Shared region requires a medium like file to keep all the
+	 * associated mm_struct.  luf makes use of strcut address_space
+	 * for that purpose.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		return !!vma->vm_file;
+
+	/*
+	 * Private region can be handled through its mm_struct.
+	 */
+	return true;
+}
+#else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 static inline bool luf_takeoff_start(void) { return false; }
 static inline void luf_takeoff_end(void) {}
 static inline bool luf_takeoff_no_shootdown(void) { return true; }
 static inline bool luf_takeoff_check(struct page *page) { return true; }
 static inline bool luf_takeoff_check_and_fold(struct page *page) { return true; }
 static inline bool non_luf_pages_ok(struct zone *zone) { return true; }
+static inline unsigned short fold_unmap_luf(void) { return 0; }
+
+static inline void can_luf_init(struct folio *f) {}
+static inline void can_luf_fail(void) {}
+static inline bool can_luf_test(void) { return false; }
+static inline bool can_luf_vma(struct vm_area_struct *vma) { return false; }
 #endif
 
 /* pagewalk.c */
diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f7..0e85c49bc5028 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6081,6 +6081,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 	bool is_droppable;
+	bool flush = false;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -6106,6 +6107,14 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_enter_fault(vma);
 
+	/*
+	 * Any potential cases that make pte writable even forcely
+	 * should be considered.
+	 */
+	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE) ||
+			flags & FAULT_FLAG_WRITE)
+		flush = true;
+
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
@@ -6137,6 +6146,12 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 out:
 	mm_account_fault(mm, regs, address, flags, ret);
 
+	/*
+	 * Ensure to clean stale tlb entries for this vma.
+	 */
+	if (flush)
+		luf_flush(0);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5297dcc38c37a..215d8d93560fd 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -99,6 +99,8 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pte = ptep_get_and_clear(mm, address, ptep);
 	if (pte_accessible(mm, pte))
 		flush_tlb_page(vma, address);
+	else
+		luf_flush(0);
 	return pte;
 }
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index 3ed6234dd777e..0aaf02b1b34c3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -646,7 +646,7 @@ static atomic_long_t luf_ugen = ATOMIC_LONG_INIT(LUF_UGEN_INIT);
 /*
  * Don't return invalid luf_ugen, zero.
  */
-static unsigned long __maybe_unused new_luf_ugen(void)
+static unsigned long new_luf_ugen(void)
 {
 	unsigned long ugen = atomic_long_inc_return(&luf_ugen);
 
@@ -723,7 +723,7 @@ static atomic_t luf_kgen = ATOMIC_INIT(1);
 /*
  * Don't return invalid luf_key, zero.
  */
-static unsigned short __maybe_unused new_luf_key(void)
+static unsigned short new_luf_key(void)
 {
 	unsigned short luf_key = atomic_inc_return(&luf_kgen);
 
@@ -776,6 +776,7 @@ void try_to_unmap_flush_takeoff(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
 
 	if (!tlb_ubc_takeoff->flush_required)
@@ -793,9 +794,72 @@ void try_to_unmap_flush_takeoff(void)
 	if (arch_tlbbatch_done(&tlb_ubc_ro->arch, &tlb_ubc_takeoff->arch))
 		reset_batch(tlb_ubc_ro);
 
+	if (arch_tlbbatch_done(&tlb_ubc_luf->arch, &tlb_ubc_takeoff->arch))
+		reset_batch(tlb_ubc_luf);
+
 	reset_batch(tlb_ubc_takeoff);
 }
 
+/*
+ * Should be called just before try_to_unmap_flush() to optimize the tlb
+ * shootdown using arch_tlbbatch_done().
+ */
+unsigned short fold_unmap_luf(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	struct luf_batch *lb;
+	unsigned long new_ugen;
+	unsigned short new_key;
+	unsigned long flags;
+
+	if (!tlb_ubc_luf->flush_required)
+		return 0;
+
+	/*
+	 * fold_unmap_luf() is always followed by try_to_unmap_flush().
+	 */
+	if (arch_tlbbatch_done(&tlb_ubc_luf->arch, &tlb_ubc->arch)) {
+		tlb_ubc_luf->flush_required = false;
+		tlb_ubc_luf->writable = false;
+	}
+
+	/*
+	 * Check again after shrinking.
+	 */
+	if (!tlb_ubc_luf->flush_required)
+		return 0;
+
+	new_ugen = new_luf_ugen();
+	new_key = new_luf_key();
+
+	/*
+	 * Update the next entry of luf_batch table, that is the oldest
+	 * entry among the candidate, hopefully tlb flushes have been
+	 * done for all of the CPUs.
+	 */
+	lb = &luf_batch[new_key];
+	write_lock_irqsave(&lb->lock, flags);
+	__fold_luf_batch(lb, tlb_ubc_luf, new_ugen);
+	write_unlock_irqrestore(&lb->lock, flags);
+
+	reset_batch(tlb_ubc_luf);
+	return new_key;
+}
+
+void luf_flush(unsigned short luf_key)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct luf_batch *lb = &luf_batch[luf_key];
+	unsigned long flags;
+
+	read_lock_irqsave(&lb->lock, flags);
+	fold_batch(tlb_ubc, &lb->batch, false);
+	read_unlock_irqrestore(&lb->lock, flags);
+	try_to_unmap_flush();
+}
+EXPORT_SYMBOL(luf_flush);
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -806,8 +870,10 @@ void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 
 	fold_batch(tlb_ubc, tlb_ubc_ro, true);
+	fold_batch(tlb_ubc, tlb_ubc_luf, true);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -820,8 +886,9 @@ void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 
-	if (tlb_ubc->writable || tlb_ubc_ro->writable)
+	if (tlb_ubc->writable || tlb_ubc_ro->writable || tlb_ubc_luf->writable)
 		try_to_unmap_flush();
 }
 
@@ -836,7 +903,8 @@ void try_to_unmap_flush_dirty(void)
 	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
 
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
-				      unsigned long uaddr)
+				      unsigned long uaddr,
+				      struct vm_area_struct *vma)
 {
 	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
@@ -845,7 +913,16 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	if (!pte_accessible(mm, pteval))
 		return;
 
-	if (pte_write(pteval))
+	if (can_luf_test()) {
+		/*
+		 * luf cannot work with the folio once it found a
+		 * writable or dirty mapping on it.
+		 */
+		if (pte_write(pteval) || !can_luf_vma(vma))
+			can_luf_fail();
+	}
+
+	if (!can_luf_test())
 		tlb_ubc = &current->tlb_ubc;
 	else
 		tlb_ubc = &current->tlb_ubc_ro;
@@ -853,6 +930,21 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
 
+	if (can_luf_test()) {
+		struct luf_batch *lb;
+		unsigned long flags;
+
+		/*
+		 * Accumulate to the 0th entry right away so that
+		 * luf_flush(0) can be uesed to properly perform pending
+		 * TLB flush once this unmapping is observed.
+		 */
+		lb = &luf_batch[0];
+		write_lock_irqsave(&lb->lock, flags);
+		__fold_luf_batch(lb, tlb_ubc, new_luf_ugen());
+		write_unlock_irqrestore(&lb->lock, flags);
+	}
+
 	/*
 	 * Ensure compiler does not re-order the setting of tlb_flush_batched
 	 * before the PTE is cleared.
@@ -907,6 +999,8 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  * This must be called under the PTL so that an access to tlb_flush_batched
  * that is potentially a "reclaim vs mprotect/munmap/etc" race will synchronise
  * via the PTL.
+ *
+ * LUF(Lazy Unmap Flush) also relies on this for mprotect/munmap/etc.
  */
 void flush_tlb_batched_pending(struct mm_struct *mm)
 {
@@ -916,6 +1010,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 
 	if (pending != flushed) {
 		arch_flush_tlb_batched_pending(mm);
+
 		/*
 		 * If the new TLB flushing is pending during flushing, leave
 		 * mm->tlb_flush_batched as is, to avoid losing flushing.
@@ -926,7 +1021,8 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 }
 #else
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
-				      unsigned long uaddr)
+				      unsigned long uaddr,
+				      struct vm_area_struct *vma)
 {
 }
 
@@ -1292,6 +1388,11 @@ int folio_mkclean(struct folio *folio)
 
 	rmap_walk(folio, &rwc);
 
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
+
 	return cleaned;
 }
 EXPORT_SYMBOL_GPL(folio_mkclean);
@@ -1961,7 +2062,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address);
+				set_tlb_ubc_flush_pending(mm, pteval, address, vma);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -2132,6 +2233,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	if (!ret)
+		can_luf_fail();
 	return ret;
 }
 
@@ -2164,11 +2267,21 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+
+	can_luf_init(folio);
 
 	if (flags & TTU_RMAP_LOCKED)
 		rmap_walk_locked(folio, &rwc);
 	else
 		rmap_walk(folio, &rwc);
+
+	if (can_luf_test())
+		fold_batch(tlb_ubc_luf, tlb_ubc_ro, true);
+	else
+		fold_batch(tlb_ubc, tlb_ubc_ro, true);
 }
 
 /*
@@ -2338,7 +2451,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address);
+				set_tlb_ubc_flush_pending(mm, pteval, address, vma);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -2494,6 +2607,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	if (!ret)
+		can_luf_fail();
 	return ret;
 }
 
@@ -2513,6 +2628,9 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 
 	/*
 	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
@@ -2537,10 +2655,17 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	if (!folio_test_ksm(folio) && folio_test_anon(folio))
 		rwc.invalid_vma = invalid_migration_vma;
 
+	can_luf_init(folio);
+
 	if (flags & TTU_RMAP_LOCKED)
 		rmap_walk_locked(folio, &rwc);
 	else
 		rmap_walk(folio, &rwc);
+
+	if (can_luf_test())
+		fold_batch(tlb_ubc_luf, tlb_ubc_ro, true);
+	else
+		fold_batch(tlb_ubc, tlb_ubc_ro, true);
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
diff --git a/mm/truncate.c b/mm/truncate.c
index e5151703ba04a..14618c53f1910 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -124,6 +124,11 @@ void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 
 	if (aops->invalidate_folio)
 		aops->invalidate_folio(folio, offset, length);
+
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
 }
 EXPORT_SYMBOL_GPL(folio_invalidate);
 
@@ -161,6 +166,11 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 
 	truncate_cleanup_folio(folio);
 	filemap_remove_folio(folio);
+
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
 	return 0;
 }
 
@@ -206,6 +216,12 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 
 	if (folio_needs_release(folio))
 		folio_invalidate(folio, offset, length);
+
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
+
 	if (!folio_test_large(folio))
 		return true;
 	if (split_folio(folio) == 0)
@@ -247,19 +263,28 @@ EXPORT_SYMBOL(generic_error_remove_folio);
  */
 long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
 {
+	long ret = 0;
+
 	/* The page may have been truncated before it was locked */
 	if (!mapping)
-		return 0;
+		goto out;
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
-		return 0;
+		goto out;
 	/* The refcount will be elevated if any page in the folio is mapped */
 	if (folio_ref_count(folio) >
 			folio_nr_pages(folio) + folio_has_private(folio) + 1)
-		return 0;
+		goto out;
 	if (!filemap_release_folio(folio, 0))
-		return 0;
+		goto out;
 
-	return remove_mapping(mapping, folio);
+	ret = remove_mapping(mapping, folio);
+out:
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
+
+	return ret;
 }
 
 /**
@@ -299,7 +324,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	bool		same_folio;
 
 	if (mapping_empty(mapping))
-		return;
+		goto out;
 
 	/*
 	 * 'start' and 'end' always covers the range of pages to be fully
@@ -387,6 +412,12 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		folio_batch_release(&fbatch);
 	}
+
+out:
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
@@ -502,6 +533,11 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
+
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
 	return count;
 }
 
@@ -594,7 +630,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int did_range_unmap = 0;
 
 	if (mapping_empty(mapping))
-		return 0;
+		goto out;
 
 	folio_batch_init(&fbatch);
 	index = start;
@@ -664,6 +700,11 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	if (dax_mapping(mapping)) {
 		unmap_mapping_pages(mapping, start, end - start + 1, false);
 	}
+out:
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2970a8f35d3d3..ffc4a48710f1d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -821,6 +821,8 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
  */
 long remove_mapping(struct address_space *mapping, struct folio *folio)
 {
+	long ret = 0;
+
 	if (__remove_mapping(mapping, folio, false, NULL)) {
 		/*
 		 * Unfreezing the refcount with 1 effectively
@@ -828,9 +830,15 @@ long remove_mapping(struct address_space *mapping, struct folio *folio)
 		 * atomic operation.
 		 */
 		folio_ref_unfreeze(folio, 1);
-		return folio_nr_pages(folio);
+		ret = folio_nr_pages(folio);
 	}
-	return 0;
+
+	/*
+	 * Ensure to clean stale tlb entries for this mapping.
+	 */
+	luf_flush(0);
+
+	return ret;
 }
 
 /**
-- 
2.17.1


