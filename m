Return-Path: <linux-kernel+bounces-183340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C6F8C97D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA32280F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB6D52E;
	Mon, 20 May 2024 02:17:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E83FC2FD
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171476; cv=none; b=dvrfrOiwlUGS6reZucHL4cw0nqB3IJtipWZH5VBSGXZQBassNtXpQus+9Fs4U216iX4LBU7jpQnO/zp1GENMtHUkKeKWCmNayNPeoqkIhMf6DrTqWhqJGOJJsn7k0PoK4kX7topkGRT7ci1eKrX7Y86pkUf8NtwFoYwKzpWNetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171476; c=relaxed/simple;
	bh=QJmJAn9T6fj1xBTxwSS8IUITFXhbj571jqpIZLhKgnw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SIBm6OifLgKftEX/dqzqME3PMRcSPxcn4+u3YMZOqy3Mo0s522eQWNaq/TE6/r8TRoAGiPISKb+jHQFT00+6SxcbuAHiXEGlqwEKeeS/seeFr8Q8mBrEsjKT85AoKyZiIZnobMElCBHDJ6J6ZR9Sd7/dK+2c7NAmY7s9agjPKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-95-664ab2c81899
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
Subject: [RESEND PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Mon, 20 May 2024 11:17:22 +0900
Message-Id: <20240520021734.21527-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnoe6JTV5pBu/bLC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAldG
	9wOpgnkTGSt+tW9gbWA8mNXFyMkhIWAicaF/CyuM/f/nDkYQm01AXeLGjZ/MILaIgJnEwdY/
	7CA2s8BdJokD/WwgtrBAqMTZCz+B4hwcLAKqEq13rUFMXgFTiYYflhAT5SVWbzgANIULyL7N
	JnHyRRfUKkmJgytusExg5F7AyLCKUSgzryw3MTPHRC+jMi+zQi85P3cTIzCMl9X+id7B+OlC
	8CFGAQ5GJR7eHY8804RYE8uKK3MPMUpwMCuJ8G7aAhTiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	a/StPEVIID2xJDU7NbUgtQgmy8TBKdXAKB97+LP380lLZ2sc1l1h6Cf4w8O0ZdJVD48LO1Rn
	BS8O+upptXhbz6yqvXVHHOPlzpYuFQt4wvtkStbXjZ+K/zh81DZm3pUXvHXuxzqXnXMM+I5p
	N36c0mNQvtpUfdHKH28DZ+da/p77vfv+kt3mMd6syhzCKpsaVps3e+aJSi6KVH65KK31jxJL
	cUaioRZzUXEiAE0TyEhfAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC5WfdrHtik1eawYRFWhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyuh+IFUwbyJjxa/2DawNjAezuhg5OSQETCT+/9zBCGKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFgiVOHvhJ1Ccg4NFQFWi9a41iMkrYCrR8MMSYqK8xOoNB5gn
	MHIsYGRYxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERiUy2r/TNzB+OWy+yFGAQ5GJR7eDbc9
	04RYE8uKK3MPMUpwMCuJ8G7aAhTiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5Ykpqd
	mlqQWgSTZeLglGpg7Ji7089/jV92wDKxO5OFb8T9LPJJfpAsvOlw0wVG4Sn7BT+uDzpyeV/P
	/EunfxQ6n7i1KEqX58R59XfhZa/0J8UFzLqW63DUbu+2Wx67H1s0Xj3zaUuV+9lFp6zZy7nO
	C2jt0ZeJr56X8CLvqFXi039nMtkK9/3NLtkddvXgRkaPea9CJJZ9r1ZiKc5INNRiLipOBACV
	zy0MRgIAAA==
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
is inaccessible").  See the following link for more information:

https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/

However, it's only for migration through hinting fault.  I thought it'd
be much better if we have a general mechanism to reduce all the tlb
numbers that we can apply to any unmap code, that we normally believe
tlb flush should be followed.

I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), defers tlb flush
until folios that have been unmapped and freed, eventually get allocated
again.  It's safe for folios that had been mapped read-only and were
unmapped, since the contents of the folios don't change while staying in
pcp or buddy so we can still read the data through the stale tlb entries.

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

---

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
 include/linux/mm.h                |  22 ++
 include/linux/mm_types.h          |  40 +++-
 include/linux/rmap.h              |   7 +-
 include/linux/sched.h             |  11 +
 mm/compaction.c                   |  10 +
 mm/internal.h                     | 115 +++++++++-
 mm/memory.c                       |   8 +
 mm/migrate.c                      | 184 ++++++++++------
 mm/mmap.c                         |   8 +
 mm/page_alloc.c                   | 157 +++++++++++---
 mm/page_isolation.c               |   6 +
 mm/page_reporting.c               |  10 +
 mm/rmap.c                         | 345 +++++++++++++++++++++++++++++-
 mm/swap.c                         |  18 +-
 mm/vmscan.c                       |  29 ++-
 20 files changed, 904 insertions(+), 126 deletions(-)


base-commit: f52bcd4a9f6058704a6f6b6b50418f579defd4fe
-- 
2.17.1


