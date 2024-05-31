Return-Path: <linux-kernel+bounces-196563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049508D5E15
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2840D1C216D8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A381AC3;
	Fri, 31 May 2024 09:20:24 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325947C6DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147223; cv=none; b=AXmFl8tjE4JTeG/rG+0qB2t4bofUp6iZocAQoAKJx8S/vBn0Xyf3HmPUqwRLboietDV3X4l9wWpX9GTd06ycyHF8QIazcgt2NR5hYX0t9zSwCtrNL0JL5d5czQG/6WBSXGLlauXgIR3D271ALBOz5u8F5J4vPxzK2r4dqDHR1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147223; c=relaxed/simple;
	bh=9tOvCluYonXhtE+kwGGj08F4By14EQrJrN9xzxITSaM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EbLdzSPlAFTJt3PdVXen+h6XNty95hYbsj3Ljzb2SJTpSdgSNhbRMwUdjFOY1iVuYWcxPmOSnRXj8JrW/L/jGRY7wsqAGCNZt4omKTGUnNUZvp8tu5z8nkhoelpil7Gj2JPzQG5Qgl6MmFspdcQ3jTWOd0y7KxdaxTPs08pYdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-41-6659964bca7a
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
Subject: [PATCH v11 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Fri, 31 May 2024 18:19:49 +0900
Message-Id: <20240531092001.30428-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnoa7PtMg0g20bmSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAldG
	z9SjbAWr6isevdjI2MA4J66LkZNDQsBEomPdGTYYe9ulg4wgNpuAusSNGz+ZQWwRATOJg61/
	2EFsZoG7TBIH+oHqOTiEBfwk7l+LAgmzCKhKnHg9nREkzCtgKvH3hAzERHmJ1RsOAE3hArJv
	s0n87VjGDpGQlDi44gbLBEbuBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECw3hZ7Z/oHYyf
	LgQfYhTgYFTi4Q2oiEgTYk0sK67MPcQowcGsJML7Kx0oxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgbHstmhH6NynS2esz5rnbnhGmXfFjTOh6r1639O3
	KdyO/nStiemZ1IJ3wqFVe3f628gIVbyp3OXxd4On1ak/gjddjvNPmWrpfuiR+45V6yLyTFad
	3fqkIT5+U+OpYv5rpTc3vz9QEc9XeGr1OVmfukdFaYu+bJHSDl6QmLHusNq8y791RCXdPJqU
	WIozEg21mIuKEwFAAw5rXwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC5WfdrOs9LTLNYHqHocWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4MnqmHmUrWFVf8ejFRsYGxjlxXYycHBICJhLbLh1kBLHZBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONDP1sXIwSEs4Cdx/1oUSJhFQFXixOvpjCBhXgFTib8nZCAmykus3nCA
	eQIjxwJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBQbms9s/EHYxfLrsfYhTgYFTi4Q2o
	iEgTYk0sK67MPcQowcGsJML7Kx0oxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1
	OzW1ILUIJsvEwSnVwCieuzLx1A7f169mXguXatzB7LU1JtKd8dbt5i0P3xXqC7gslvndzPN3
	9o8Dzoc3qwbvdnR9dv7VtAleZTcZvk8/n7TzUdN0FfXFRtcvd/nyudqsNGpYcTXpGXdc7K5p
	xuGbmeTzf2jOMV3R0nvs1A6xpDdTo6rihLeeaEh2yPixKXq6V0KY9j4lluKMREMt5qLiRACD
	aSXrRgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi everyone,

While I'm working with a tiered memory system e.g. CXL memory, I have
been facing migration overhead esp. tlb shootdown on promotion or
demotion between different tiers.  Yeah..  most tlb shootdowns on
migration through hinting fault can be avoided thanks to Huang Ying's
work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
is inaccessible").

However, it's only for migration through hinting fault.  I thought it'd
be much better if we have a general mechanism to reduce all the tlb
numbers that we can apply to any unmap code, that we normally believe
tlb flush should be followed.

I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
flush until folios that have been unmapped and freed, eventually get
allocated again.  It's safe for folios that had been mapped read-only
and were unmapped, as long as the contents of the folios don't change
while staying in pcp or buddy so we can still read the data through the
stale tlb entries.

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

---

Changes from v10:

	1. Rebase on akpm/mm.git mm-unstable as of May 28, 2024.
	2. Cancel LUF on file_end_write() when updating a file.
	   (feedbacked by Dave Hansen)
	3. Cancel LUF after every update_mmu_tlb*() in fault handler if
	   it's going to set the pte to writable.
	4. Cancel LUF on freeing pages if kasan needs poisoning.
	   (feedbacked by David Hildenbrand)
	5. Cancel LUF on freeing pages if want_init_on_free().
	   (feedbacked by David Hildenbrand)
	6. Change test iteration from 10 times to 5 times.
	7. Not include perf result. (I will add it if needed.)
	8. Trivial optimization.	

Changes from v9:

	1. Expand the candidate to apply this mechanism:
	   BEFORE - The souce folios at any type of migration.
	   AFTER  - Any folios that have been unmapped and freed.
	2. Change the workload for test:
	   BEFORE - XSBench
	   AFTER  - llama.cpp (one of the most popluar real workload)
	3. Change the test environment:
	   BEFORE - qemu machine, too small DRAM(1GB), large remote mem
	   AFTER  - bare metal, real CXL memory, practical memory size
	4. Rename the mechanism from MIGRC(Migration Read Copy) to
	   LUF(Lazy Unmap Flush) to reflect the current version of the
	   mechanism can be applied not only to unmap during migration
	   but any unmap code e.g. unmap in shrink_folio_list().
	5. Fix build error for riscv. (feedbacked by kernel test bot)
	6. Supplement commit messages to describe what this mechanism is
	   for, especially in the patches for arch code. (feedbacked by
	   Thomas Gleixner)
	7. Clean up some trivial things.

Changes from v8:

	1. Rebase on akpm/mm.git mm-unstable as of April 18, 2024.
	2. Supplement comments and commit message.
	3. Change the candidate to apply migrc mechanism:
	   BEFORE - The source folios at demotion and promotion.
	   AFTER  - The souce folios at any type of migration.
	4. Change how migrc mechanism works:
	   BEFORE - Reduce tlb flushes by deferring folio_free() for
	            source folios during demotion and promotion.
	   AFTER  - Reduce tlb flushes by deferring tlb flush until they
	            actually become used, out of pcp or buddy. The
		    current version of migrc does *not* defer calling
	            folio_free() but let it go as it is as the same as
		    vanilla kernel, with the folios marked kind of 'need
		    to tlb flush'. And then handle the flush when the
		    page exits from pcp or buddy so as to prevent
		    changing vm stats e.g. free pages.

Changes from v7:

	1. Rewrite cover letter to explain what 'migrc' mechasism is.
	   (feedbacked by Andrew Morton)
	2. Supplement the commit message of a patch 'mm: Add APIs to
	   free a folio directly to the buddy bypassing pcp'.
	   (feedbacked by Andrew Morton)

Changes from v6:

	1. Fix build errors in case of
	   CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH disabled by moving
	   migrc_flush_{start,end}() calls from arch code to
	   try_to_unmap_flush() in mm/rmap.c.

Changes from v5:

	1. Fix build errors in case of CONFIG_MIGRATION disabled or
	   CONFIG_HWPOISON_INJECT moduled. (feedbacked by kernel test
	   bot and Raymond Jay Golo)
	2. Organize migrc code with two kconfigs, CONFIG_MIGRATION and
	   CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH.

Changes from v4:

	1. Rebase on v6.7.
	2. Fix build errors in arm64 that is doing nothing for tlb flush
	   but has CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH. (reported
	   by kernel test robot)
	3. Don't use any page flag. So the system would give up migrc
	   mechanism more often but it's okay. The final improvement is
	   good enough.
	4. Instead, optimize full tlb flush(arch_tlbbatch_flush()) by
	   avoiding redundant CPUs from tlb flush.

Changes from v3:

	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
	   migrc_enable. (feedbacked by Nadav)
	2. Remove the optimization skipping CPUs that have already
	   performed tlb flushes needed by any reason when performing
	   tlb flushes by migrc because I can't tell the performance
	   difference between w/ the optimization and w/o that.
	   (feedbacked by Nadav)
	3. Minimize arch-specific code. While at it, move all the migrc
           declarations and inline functions from include/linux/mm.h to
           mm/internal.h (feedbacked by Dave Hansen, Nadav)
	4. Separate a part making migrc paused when the system is in
	   high memory pressure to another patch. (feedbacked by Nadav)
	5. Rename:
	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
	      b. tlb_ubc_nowr to tlb_ubc_ro,
	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
	      d. migrc_stop to migrc_pause.
	   (feedbacked by Nadav)
	6. Use ->lru list_head instead of introducing a new llist_head.
	   (feedbacked by Nadav)
	7. Use non-atomic operations of page-flag when it's safe.
	   (feedbacked by Nadav)
	8. Use stack instead of keeping a pointer of 'struct migrc_req'
	   in struct task, which is for manipulating it locally.
	   (feedbacked by Nadav)
	9. Replace a lot of simple functions to inline functions placed
	   in a header, mm/internal.h. (feedbacked by Nadav)
	10. Add additional sufficient comments. (feedbacked by Nadav)
	11. Remove a lot of wrapper functions. (feedbacked by Nadav)

Changes from RFC v2:

	1. Remove additional occupation in struct page. To do that,
	   unioned with lru field for migrc's list and added a page
	   flag. I know page flag is a thing that we don't like to add
	   but no choice because migrc should distinguish folios under
	   migrc's control from others. Instead, I force migrc to be
	   used only on 64 bit system to mitigate you guys from getting
	   angry.
	2. Remove meaningless internal object allocator that I
	   introduced to minimize impact onto the system. However, a ton
	   of tests showed there was no difference.
	3. Stop migrc from working when the system is in high memory
	   pressure like about to perform direct reclaim. At the
	   condition where the swap mechanism is heavily used, I found
	   the system suffered from regression without this control.
	4. Exclude folios that pte_dirty() == true from migrc's interest
	   so that migrc can work simpler.
	5. Combine several patches that work tightly coupled to one.
	6. Add sufficient comments for better review.
	7. Manage migrc's request in per-node manner (from globally).
	8. Add tlb miss improvement in commit message.
	9. Test with more CPUs(4 -> 16) to see bigger improvement.

Changes from RFC:

	1. Fix a bug triggered when a destination folio at the previous
	   migration becomes a source folio at the next migration,
	   before the folio gets handled properly so that the folio can
	   play with another migration. There was inconsistency in the
	   folio's state. Fixed it.
	2. Split the patch set into more pieces so that the folks can
	   review better. (Feedbacked by Nadav Amit)
	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
	   (Feedbacked by Nadav Amit)
	4. Tried to add sufficient comments to explain the patch set
	   better. (Feedbacked by Nadav Amit)

Byungchul Park (12):
  x86/tlb: add APIs manipulating tlb batch's arch data
  arm64: tlbflush: add APIs manipulating tlb batch's arch data
  riscv, tlb: add APIs manipulating tlb batch's arch data
  x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of
    arch_tlbbatch_flush()
  mm: buddy: make room for a new variable, ugen, in struct page
  mm: add folio_put_ugen() to deliver unmap generation number to pcp or
    buddy
  mm: add a parameter, unmap generation number, to free_unref_folios()
  mm/rmap: recognize read-only tlb entries during batched tlb flush
  mm: implement LUF(Lazy Unmap Flush) defering tlb flush when folios get
    unmapped
  mm: separate move/undo parts from migrate_pages_batch()
  mm, migrate: apply luf mechanism to unmapping during migration
  mm, vmscan: apply luf mechanism to unmapping during folio reclaim

 arch/arm64/include/asm/tlbflush.h |  18 ++
 arch/riscv/include/asm/tlbflush.h |  21 ++
 arch/riscv/mm/tlbflush.c          |   1 -
 arch/x86/include/asm/tlbflush.h   |  18 ++
 arch/x86/mm/tlb.c                 |   2 -
 include/linux/fs.h                |   6 +
 include/linux/mm.h                |  22 ++
 include/linux/mm_types.h          |  48 +++-
 include/linux/rmap.h              |   7 +-
 include/linux/sched.h             |  11 +
 mm/compaction.c                   |  12 +-
 mm/internal.h                     | 115 +++++++++-
 mm/memory.c                       |  39 +++-
 mm/migrate.c                      | 184 ++++++++++------
 mm/page_alloc.c                   | 174 ++++++++++++---
 mm/page_isolation.c               |   6 +
 mm/page_reporting.c               |  10 +
 mm/rmap.c                         | 352 +++++++++++++++++++++++++++++-
 mm/swap.c                         |  18 +-
 mm/vmscan.c                       |  29 ++-
 20 files changed, 959 insertions(+), 134 deletions(-)


base-commit: b610f75d19a34b488021b9a4d2e3bd1cf34fc200
-- 
2.17.1


