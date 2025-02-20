Return-Path: <linux-kernel+bounces-522985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C9A3D0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B246189DC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8FD1E5B7A;
	Thu, 20 Feb 2025 05:36:05 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7B1DF997
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029764; cv=none; b=TjUg2u/ThquYHVynxi21x7HpksEr2EvX2ojsw84e/yJ4djT/xb8pZUQmOXBklWF29ykBNiPDYuUUtc+36RXKFPKTS3WKW5FNOZdb3BLUA1BFHuy0Dqay0Nh1bBSNsbJmc7RQ9g0yvRwlhWV2CKldlV6zRBhDxvKvKXsJ/rT+un8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029764; c=relaxed/simple;
	bh=y5XVKgCHrSpTsWP46u7XmexleWugtspeq10GrrXpqGw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IcqrhEYJrUXbbtooUtVhhj1IIH8DuL66RryjRyG5bHgAttlG/LzNX6xH+wyFIhrPPyorTLXNoVIIR2jiwIIHs3/raj8kDu6vDArGcDY3aqRppgOQlGfLvoJsahpX/v7Ge1o376pPTBmIyFVLuYfhnIZfHJdtOXxEQgbhn0M5gfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-ab-67b6bba67a49
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
Subject: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Thu, 20 Feb 2025 14:20:01 +0900
Message-Id: <20250220052027.58847-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC9ZZnke6y3dvSDS5PErKYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	v/duYyn4tpixouvATtYGxqelXYycHBICJhIX7/Syw9jL9uxgBLHZBNQlbtz4yQxiiwiYSRxs
	/QNWwyxwl0niQD8biC0sECTx6Fk3WD2LgKrE6sWdYPW8AqYSN3fuYIOYKS+xesMBoDgXkH2b
	TWLm28NMEAlJiYMrbrBMYORewMiwilEoM68sNzEzx0QvozIvs0IvOT93EyMwmJfV/onewfjp
	QvAhRgEORiUe3hmt29KFWBPLiitzDzFKcDArifC21W9JF+JNSaysSi3Kjy8qzUktPsQozcGi
	JM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBYu1Y16thDtslOi5T93rY0Vzz8PL8jbcvv0G2z
	OhemH475YKXyJOzYJfe6o7bOM6ZMP/DpOYP7Wg95pbkvXebXB6jYSV5tMzD+dox17/zLfC+t
	Ao9alc4KkxOau/pabbrD3i2r4xev6rrM2BvTPLFfvcxvy+SIv5KmqS9TJzw7sWhj1KOUlQFB
	SizFGYmGWsxFxYkASMKi52ICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g1kbWS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlfF77zaWgm+LGSu6DuxkbWB8WtrFyMkhIWAisWzPDkYQm01AXeLGjZ/MILaI
	gJnEwdY/7CA2s8BdJokD/WwgtrBAkMSjZ91g9SwCqhKrF3eC1fMKmErc3LmDDWKmvMTqDQeY
	JzByLGBkWMUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYmstq/0zcwfjlsvshRgEORiUe3geP
	t6YLsSaWFVfmHmKU4GBWEuFtq9+SLsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEk
	NTs1tSC1CCbLxMEp1cAYrNhS/4vnw6pTbAG7zfnvpT8UeCq1T3Zp8NSE9sUdalOnxuf+Z8kL
	WJmzq2qX/fx5l5c+0X16pXv2OenL7yxZ3PwevTiuYcOrF/NKLDHUy8LUv5P5PpvxiY1eUZNq
	bXKuJTS1bPH5Od/Uj/l58/a5oW4NV4u/lClY9/P8fuW73GN5xuG6NG0lluKMREMt5qLiRAAx
	775nSQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To check luf's stability, I ran a heavy LLM inference workload consuming
210GiB over 7 days on a machine with 140GiB memory, and decided it's
stable enough.

I'm posting the latest version so that anyone can try luf mechanism if
wanted by any chance.  However, I tagged RFC again because there are
still issues that should be resolved to merge to mainline:

   1. Even though system wide total cpu time for TLB shootdown is
      reduced over 95%, page allocation paths should take additional cpu
      time shifted from page reclaim to perform TLB shootdown.

   2. We need luf debug feature to detect when luf goes wrong by any
      chance.  I implemented just a draft version that checks the sanity
      on mkwrite(), kmap(), and so on.  I need to gather better ideas
      to improve the debug feature.

---

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

Changes from v11:

	1. Rebase on akpm/mm.git mm-unstable(5a7056135b) as of Nov 22, 2024.
	2. Very big changes have been applied including refactoring for
	   better reuse and readability, and other features for
	   stability and performance optimization.  It's hard to list up
	   all changes but lemme list up main changes.
	3. Meta data for pending TLB shootdown is kept in struct zone
	   instead of struct page so as to perform pending TLB shootdown
	   when it's needed in batched manner.
	4. Introduce pend_list in strcut free_area so as to keep luf
	   pages separatedly, that need to perform pending TLB shootdown
	   on returning from buddy.
	5. Control the amount of non-luf pages in buddy, that do not
	   need pending TLB shootdown on returning from buddy, so that
	   any atomic contexts can allocate pages without consideration
	   of TLB shootdown.  Try the best to keep non-luf pages as much
	   as WMARK_MIN for now.
	6. Optimzation to reduce lock contention by locks introduced by
	   luf mechanism.
	7. Implement luf debug feature for detecting when luf goes
	   wrong.  It's just a draft version that need to improve much.
	8. Avoid pending TLB shootdown as much as possible e.g. use
	   non-luf pages in buddy within preempt disabled context if
	   the number of non-luf pages in buddy is fair enough.

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

Byungchul Park (26):
  x86/tlb: add APIs manipulating tlb batch's arch data
  arm64/tlbflush: add APIs manipulating tlb batch's arch data
  riscv/tlb: add APIs manipulating tlb batch's arch data
  x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of
    arch_tlbbatch_flush()
  mm/buddy: make room for a new variable, luf_key, in struct page
  mm: move should_skip_kasan_poison() to mm/internal.h
  mm: introduce luf_ugen to be used as a global timestamp
  mm: introduce luf_batch to be used as hash table to store luf meta
    data
  mm: introduce API to perform tlb shootdown on exit from page allocator
  mm: introduce APIs to check if the page allocation is tlb
    shootdownable
  mm: deliver luf_key to pcp or buddy on free after unmapping
  mm: delimit critical sections to take off pages from pcp or buddy
    alloctor
  mm: introduce pend_list in struct free_area to track luf'd pages
  mm/rmap: recognize read-only tlb entries during batched tlb flush
  fs, filemap: refactor to gather the scattered ->write_{begin,end}()
    calls
  mm: implement LUF(Lazy Unmap Flush) defering tlb flush when folios get
    unmapped
  x86/tlb, riscv/tlb, arm64/tlbflush, mm: remove cpus from tlb shootdown
    that already have been done
  mm/page_alloc: retry 3 times to take pcp pages on luf check failure
  mm: skip luf tlb flush for luf'd mm that already has been done
  mm, fs: skip tlb flushes for luf'd filemap that already has been done
  mm: perform luf tlb shootdown per zone in batched manner
  mm/page_alloc: not allow to tlb shootdown if !preemptable() &&
    non_luf_pages_ok()
  mm: separate move/undo parts from migrate_pages_batch()
  mm/migrate: apply luf mechanism to unmapping during migration
  mm/vmscan: apply luf mechanism to unmapping during folio reclaim
  mm/luf: implement luf debug feature

 arch/arm64/include/asm/tlbflush.h         |  53 ++
 arch/riscv/include/asm/tlbflush.h         |  35 +
 arch/riscv/mm/tlbflush.c                  | 142 +++-
 arch/x86/include/asm/pgtable.h            |  10 +
 arch/x86/include/asm/tlbflush.h           |  31 +
 arch/x86/mm/pgtable.c                     |  10 +
 arch/x86/mm/tlb.c                         | 143 +++-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  11 +-
 fs/affs/file.c                            |   4 +-
 fs/buffer.c                               |  14 +-
 fs/exfat/file.c                           |   5 +-
 fs/ext4/verity.c                          |   5 +-
 fs/f2fs/super.c                           |   5 +-
 fs/f2fs/verity.c                          |   5 +-
 fs/inode.c                                |   1 +
 fs/namei.c                                |   5 +-
 include/asm-generic/tlb.h                 |   5 +
 include/linux/fs.h                        |  30 +
 include/linux/highmem-internal.h          |   5 +
 include/linux/mm.h                        |  94 ++-
 include/linux/mm_types.h                  |  70 +-
 include/linux/mm_types_task.h             |  16 +
 include/linux/mmzone.h                    |  12 +
 include/linux/rmap.h                      |   7 +-
 include/linux/sched.h                     |  24 +
 kernel/fork.c                             |   1 +
 kernel/power/snapshot.c                   |  14 +
 kernel/sched/core.c                       |   1 +
 kernel/vmcore_info.c                      |   2 +
 mm/compaction.c                           |  61 +-
 mm/filemap.c                              |   5 +-
 mm/highmem.c                              |   1 +
 mm/internal.h                             | 196 +++++-
 mm/memory.c                               |  43 ++
 mm/migrate.c                              | 193 ++++--
 mm/mm_init.c                              |   7 +
 mm/page_alloc.c                           | 798 +++++++++++++++++++---
 mm/page_ext.c                             |   3 +
 mm/page_isolation.c                       |  10 +-
 mm/page_reporting.c                       |  45 +-
 mm/pgtable-generic.c                      |   2 +
 mm/rmap.c                                 | 684 ++++++++++++++++++-
 mm/swap.c                                 |   6 +-
 mm/truncate.c                             |  55 +-
 mm/vmscan.c                               |  55 +-
 mm/vmstat.c                               |  15 +
 46 files changed, 2680 insertions(+), 259 deletions(-)


base-commit: 5a7056135bb69da2ce0a42eb8c07968c1331777b
-- 
2.17.1


