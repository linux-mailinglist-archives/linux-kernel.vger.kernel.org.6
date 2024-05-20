Return-Path: <linux-kernel+bounces-183349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606338C97DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A2E1C21576
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56854208A7;
	Mon, 20 May 2024 02:18:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91817582
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171482; cv=none; b=FRcoG8t9rYlIDjBdYNPjFTQqRy2L6IP1eqCiWu5RhC7wERwon7rcBpPzkggm8/wVux3RvaDExhdc0xuJseKe8WZhuqf+EHuU3+BvhAbTnglEfBWXcwgHrZdg/B/CG2r9goTdLGQ1pWz+TUDQGm/rigVjJ1Hw/cUOch/cfYu6a/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171482; c=relaxed/simple;
	bh=QDy6Q/69jLgOsCJzKYXGtVHNQoTMgPNlJ5uoJnME6j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=maSdKAupu7kyW31bA1m/0C90eCRtiPjzjJMnFUIP6AaVXQG8uk4LCgQ0hmcUPDWgCa2wdequTcy7QG62DfblxPzSmaOlQh1Va5cF9WSZOzX3F9hkiowOb0/XxBGZgY6BQMK2crILYVd14N3aijyRT3pTJrdCTopzEP72HkAl1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-c2-664ab2c9d6f7
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
Subject: [RESEND PATCH v10 09/12] mm: implement LUF(Lazy Unmap Flush) defering tlb flush when folios get unmapped
Date: Mon, 20 May 2024 11:17:31 +0900
Message-Id: <20240520021734.21527-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXC9ZZnoe7JTV5pBgcnCFrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	zZM+shd82sNYcb0xu4Hxdj9jFyMnh4SAicS0FY/YYOy+mz9ZQGw2AXWJGzd+MoPYIgJmEgdb
	/7CD2MwCd5kkDvSD1QsLFEo0T3oMNodFQFWi52IvmM0LVP95y19WiJnyEqs3HACbwwkUn7Fq
	J9h8IQFTiR9HvwLN4QKqec8msaP/GtQRkhIHV9xgmcDIu4CRYRWjUGZeWW5iZo6JXkZlXmaF
	XnJ+7iZGYPAvq/0TvYPx04XgQ4wCHIxKPLw7HnmmCbEmlhVX5h5ilOBgVhLh3bQFKMSbklhZ
	lVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFxWoCObtDe2wX/pzxw
	PXA3VEZa4EZ1SP51xZKkiw3z1j5f9j3/an7NLBVxV4n0b3f+TJh+ZtGn8LS3DN/vGvHf4n+w
	Q+6McbWEENOBnD6x4EfH0rJLt11Q9JzEoW5W2R2e9mG93gJRrbLbZQv5AicetHh3r/HZy6PP
	g14wmxxcWH4r+fHLFr8QJZbijERDLeai4kQAY8dIKXoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC5WfdrHtyk1eawZ13rBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgytg86SN7wac9jBXXG7MbGG/3M3YxcnJICJhI9N38yQJiswmoS9y48ZMZxBYR
	MJM42PqHHcRmFrjLJHGgnw3EFhYolGie9Bisl0VAVaLnYi+YzQtU/3nLX1aImfISqzccAJvD
	CRSfsWon2HwhAVOJH0e/sk1g5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMJSX1f6Z
	uIPxy2X3Q4wCHIxKPLwbbnumCbEmlhVX5h5ilOBgVhLh3bQFKMSbklhZlVqUH19UmpNafIhR
	moNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cB4/tD/m7PrZOS6xZfduhjf7MHuHNzgsWFV
	PEPk/AdVPYtrdnRKK+z21fijmBq/J+0Xr/sH5Yqypxddcrol/WJeLCh/LFXYXik68ct67cvr
	v11/wr+w/Pv7HbJR7vuPP7rPeMK4pVtA3NA0RDcp+8COtVZ911+98Kn4vdNE2ylrpcnWpcsP
	+dxRYinOSDTUYi4qTgQAoksxS2ECAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read-only and were unmapped, since
the contents of the folios don't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

tlb flush can be defered when folios get unmapped as long as it
guarantees to perform tlb flush needed, before the folios actually
become used, of course, only if all the corresponding ptes don't have
write permission.  Otherwise, the system will get messed up.

To achieve that:

   1. For the folios that map only to non-writable tlb entries, prevent
      tlb flush during unmapping but perform it just before the folios
      actually become used, out of buddy or pcp.

   2. When any non-writable ptes change to writable e.g. through fault
      handler, give up luf mechanism and perform tlb flush required
      right away.

   3. When a writable mapping is created e.g. through mmap(), give up
      luf mechanism and perform tlb flush required right away.

No matter what type of workload is used for performance evaluation, the
result would be positive thanks to the unconditional reduction of tlb
flushes, tlb misses and interrupts.  For the test, I picked up one of
the most popular and heavy workload, llama.cpp that is a
LLM(Large Language Model) inference engine.

The result would depend on memory latency and how often reclaim runs,
which implies tlb miss overhead and how many times unmapping happens.
In my system, the result shows:

   1. tlb flushes are reduced about 95%.
   2. tlb misses(itlb) are reduced about 80%.
   3. tlb misses(dtlb store) are reduced about 57%.
   4. tlb misses(dtlb load) are reduced about 24%.
   5. tlb shootdown interrupts are reduced about 95%.
   6. The test program runtime is reduced about 5%.

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

   Run the test set 10 times successively with caches dropped every run
   via 'echo 3 > /proc/sys/vm/drop_caches'.  Each inference prints its
   runtime at the end of each.

   1. Runtime from the output of llama.cpp:

   BEFORE
   ------
   llama_print_timings:       total time = 1002461.95 ms /    24 tokens
   llama_print_timings:       total time = 1044978.38 ms /    24 tokens
   llama_print_timings:       total time = 1000653.09 ms /    24 tokens
   llama_print_timings:       total time = 1047104.80 ms /    24 tokens
   llama_print_timings:       total time = 1069430.36 ms /    24 tokens
   llama_print_timings:       total time = 1068201.16 ms /    24 tokens
   llama_print_timings:       total time = 1078092.59 ms /    24 tokens
   llama_print_timings:       total time = 1073200.45 ms /    24 tokens
   llama_print_timings:       total time = 1067136.00 ms /    24 tokens
   llama_print_timings:       total time = 1076442.56 ms /    24 tokens
   llama_print_timings:       total time = 1004142.64 ms /    24 tokens
   llama_print_timings:       total time = 1042942.65 ms /    24 tokens
   llama_print_timings:       total time =  999933.76 ms /    24 tokens
   llama_print_timings:       total time = 1046548.83 ms /    24 tokens
   llama_print_timings:       total time = 1068671.48 ms /    24 tokens
   llama_print_timings:       total time = 1068285.76 ms /    24 tokens
   llama_print_timings:       total time = 1077789.63 ms /    24 tokens
   llama_print_timings:       total time = 1071558.93 ms /    24 tokens
   llama_print_timings:       total time = 1066181.55 ms /    24 tokens
   llama_print_timings:       total time = 1076767.53 ms /    24 tokens
   llama_print_timings:       total time = 1004065.63 ms /    24 tokens
   llama_print_timings:       total time = 1044522.13 ms /    24 tokens
   llama_print_timings:       total time =  999725.33 ms /    24 tokens
   llama_print_timings:       total time = 1047510.77 ms /    24 tokens
   llama_print_timings:       total time = 1068010.27 ms /    24 tokens
   llama_print_timings:       total time = 1068999.31 ms /    24 tokens
   llama_print_timings:       total time = 1077648.05 ms /    24 tokens
   llama_print_timings:       total time = 1071378.96 ms /    24 tokens
   llama_print_timings:       total time = 1066326.32 ms /    24 tokens
   llama_print_timings:       total time = 1077088.92 ms /    24 tokens

   AFTER
   -----
   llama_print_timings:       total time =  988522.03 ms /    24 tokens
   llama_print_timings:       total time =  997204.52 ms /    24 tokens
   llama_print_timings:       total time =  996605.86 ms /    24 tokens
   llama_print_timings:       total time =  991985.50 ms /    24 tokens
   llama_print_timings:       total time = 1035143.31 ms /    24 tokens
   llama_print_timings:       total time =  993660.18 ms /    24 tokens
   llama_print_timings:       total time =  983082.14 ms /    24 tokens
   llama_print_timings:       total time =  990431.36 ms /    24 tokens
   llama_print_timings:       total time =  992707.09 ms /    24 tokens
   llama_print_timings:       total time =  992673.27 ms /    24 tokens
   llama_print_timings:       total time =  989285.43 ms /    24 tokens
   llama_print_timings:       total time =  996710.06 ms /    24 tokens
   llama_print_timings:       total time =  996534.64 ms /    24 tokens
   llama_print_timings:       total time =  991344.17 ms /    24 tokens
   llama_print_timings:       total time = 1035210.84 ms /    24 tokens
   llama_print_timings:       total time =  994714.13 ms /    24 tokens
   llama_print_timings:       total time =  984184.15 ms /    24 tokens
   llama_print_timings:       total time =  990909.45 ms /    24 tokens
   llama_print_timings:       total time =  991881.48 ms /    24 tokens
   llama_print_timings:       total time =  993918.03 ms /    24 tokens
   llama_print_timings:       total time =  990061.34 ms /    24 tokens
   llama_print_timings:       total time =  998076.69 ms /    24 tokens
   llama_print_timings:       total time =  997082.59 ms /    24 tokens
   llama_print_timings:       total time =  990677.58 ms /    24 tokens
   llama_print_timings:       total time = 1036054.94 ms /    24 tokens
   llama_print_timings:       total time =  994125.93 ms /    24 tokens
   llama_print_timings:       total time =  982467.01 ms /    24 tokens
   llama_print_timings:       total time =  990191.60 ms /    24 tokens
   llama_print_timings:       total time =  993319.24 ms /    24 tokens
   llama_print_timings:       total time =  992540.57 ms /    24 tokens

   2. tlb shootdowns from 'cat /proc/interrupts':

   BEFORE
   ------
   TLB:
   125553646  141418810  161932620  176853972  186655697  190399283
   192143823  196414038  192872439  193313658  193395617  192521416
   190788161  195067598  198016061  193607347  194293972  190786732
   191545637  194856822  191801931  189634535  190399803  196365922
   195268398  190115840  188050050  193194908  195317617  190820190
   190164820  185556071  226797214  229592631  216112464  209909495
   205575979  205950252  204948111  197999795  198892232  205287952
   199344631  195015158  195869844  198858745  195692876  200961904
   203463252  205921722  199850838  206145986  199613202  199961345
   200129577  203020521  207873649  203697671  197093386  204243803
   205993323  200934664  204193128  194435376  TLB shootdowns

   AFTER
   -----
   TLB:
     5648092    6610142    7032849    7882308    8088518    8352310
     8656536    8705136    8647426    8905583    8985408    8704522
     8884344    9026261    8929974    8869066    8877575    8810096
     8770984    8754503    8801694    8865925    8787524    8656432
     8755912    8682034    8773935    8832925    8797997    8515777
     8481240    8891258   10595243   10285973    9756935    9573681
     9398968    9069244    9242984    8899009    9310690    9029095
     9069758    9105825    9092703    9270202    9460287    9258546
     9180415    9232723    9270611    9175020    9490420    9360316
     9420818    9057663    9525631    9310152    9152242    8654483
     9181804    9050847    8919916    8883856  TLB shootdowns

   3. tlb numbers from 'perf stat' per test set:

   BEFORE
   ------
   3163679332	dTLB-load-misses
   2017751856	dTLB-store-misses
   327092903	iTLB-load-misses
   1357543886	tlb:tlb_flush

   AFTER
   -----
   2394694609	dTLB-load-misses
   861144167	dTLB-store-misses
   64055579	iTLB-load-misses
   69175002	tlb:tlb_flush

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |   9 ++
 mm/internal.h         |  43 +++++-
 mm/memory.c           |   8 ++
 mm/mmap.c             |   8 ++
 mm/rmap.c             | 308 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 366 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0915390b1b5e..6f83703ec284 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1340,8 +1340,17 @@ struct task_struct {
 
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
 
diff --git a/mm/internal.h b/mm/internal.h
index 805f0e6ecab4..2a44194f5d39 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1517,6 +1517,38 @@ void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+unsigned short int try_to_unmap_luf(void);
+void check_luf_flush(unsigned short int ugen);
+void luf_flush(void);
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
@@ -1546,10 +1578,7 @@ static inline unsigned short int hand_over_task_ugen(void)
 
 static inline void check_flush_task_ugen(void)
 {
-	/*
-	 * XXX: luf mechanism will handle this. For now, do nothing but
-	 * reset current's ugen to finalize this turn.
-	 */
+	check_luf_flush(current->ugen);
 	current->ugen = 0;
 }
 
@@ -1578,6 +1607,12 @@ static inline bool can_luf_folio(struct folio *f)
 	return can_luf;
 }
 #else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static inline unsigned short int try_to_unmap_luf(void) { return 0; }
+static inline void check_luf_flush(unsigned short int ugen) {}
+static inline void luf_flush(void) {}
+static inline void can_luf_init(void) {}
+static inline void can_luf_fail(void) {}
+static inline bool can_luf_test(void) { return false; }
 static inline unsigned short int ugen_latest(unsigned short int a, unsigned short int b) { return 0; }
 static inline void update_task_ugen(unsigned short int ugen) {}
 static inline unsigned short int hand_over_task_ugen(void) { return 0; }
diff --git a/mm/memory.c b/mm/memory.c
index 33d87b64d15d..f218c275d307 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3617,6 +3617,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vmf->page)
 		folio = page_folio(vmf->page);
 
+	/*
+	 * The folio may or may not be one that is under luf's control
+	 * and might be about to change its permission to writable.
+	 * Conservatively give up deferring tlb flush just in case.
+	 */
+	if (folio)
+		luf_flush();
+
 	/*
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
diff --git a/mm/mmap.c b/mm/mmap.c
index 47363e7f7ea2..3b3bece4b079 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1271,6 +1271,14 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			pkey = 0;
 	}
 
+	/*
+	 * This mmap may or may not be mapping to ones that is under
+	 * luf's control.  However, conservatively give up deferring tlb
+	 * flush just in case.
+	 */
+	if (prot & PROT_WRITE)
+		luf_flush();
+
 	/* Do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
diff --git a/mm/rmap.c b/mm/rmap.c
index 328b5e2217e6..e42783c02114 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -635,6 +635,270 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
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
+static void rmap_flush_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&luf_lock, flags);
+	on_flushing++;
+	spin_unlock_irqrestore(&luf_lock, flags);
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
 
 void fold_ubc(struct tlbflush_unmap_batch *dst,
 	      struct tlbflush_unmap_batch *src)
@@ -666,13 +930,15 @@ void fold_ubc(struct tlbflush_unmap_batch *dst,
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
-	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 
-	fold_ubc(tlb_ubc, tlb_ubc_ro);
+	fold_ubc(tlb_ubc, tlb_ubc_luf);
 	if (!tlb_ubc->flush_required)
 		return;
 
+	rmap_flush_start();
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	rmap_flush_end(tlb_ubc);
 	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
@@ -682,9 +948,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
-	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
 
-	if (tlb_ubc->writable || tlb_ubc_ro->writable)
+	if (tlb_ubc->writable || tlb_ubc_luf->writable)
 		try_to_unmap_flush();
 }
 
@@ -708,9 +974,15 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
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
@@ -1976,11 +2248,23 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
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
@@ -2325,6 +2609,10 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	struct tlbflush_unmap_batch *tlb_ubc_luf = &current->tlb_ubc_luf;
+	bool can_luf;
 
 	/*
 	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
@@ -2349,10 +2637,18 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
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


