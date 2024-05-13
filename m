Return-Path: <linux-kernel+bounces-177083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544EF8C39E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD2C2815CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 01:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51A12B72;
	Mon, 13 May 2024 01:42:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B2D304
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564534; cv=none; b=NgoGi5/ya9Ao8lIDYUnsSvBujfsGUmHQeI3TH6VUBEtWlshUaE3t6rCAXWwq1ML7lVBY3OggMNKDCJWxUlhyeNo3HbwZKLZLNPFkDIP4qN3VGwcRA+RUDqoiWliwyydb/LmfpCIrIq59ZGEAlw5IOicBqB4wh2i/RC/yELMRFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564534; c=relaxed/simple;
	bh=JYf6Cjq/buLZsbjjxkQXM4x1YWr0ZBBiHAyb6TEKcAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKNpN6fxPCyjYPBzkgfdU9J8eAYGXn4C6m3vOOB0k+MX17Uz6MZkhZ6pNMKPwPK5+xCZE7KX2CbMcM2SumifwYbObgkHWbz6qLMyzwqJBqUhft8QwblI9a+PfJejTSrOL9a27yPQqfXa9S1EtHzc5MBkn5FByXeyEinydGINmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-fd-66416fe7e2df
Date: Mon, 13 May 2024 10:41:54 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240513014154.GA38851@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <87ikzkg7no.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikzkg7no.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXC9ZZnoe7zfMc0g4lbLCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	7Y+zWAt2LmGs+H5rOVMD48GyLkZODgkBE4nvC+6ww9irbpxmArFZBFQl1j7cwgZiswmoS9y4
	8ZMZxBYR0JD4tHA5UD0XB7PAcyaJ329+gzULC4RITPuwBqyZV8BC4sOWFpYuRg4OIYFMienf
	FSHCghInZz5hAbGZBbQkbvx7yQRSwiwgLbH8HweIySlgJ3FmOyNIhaiAssSBbceZQDZJCGxi
	l/h/4DUzxJmSEgdX3GCZwCgwC8nUWUimzkKYuoCReRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZG
	YBwuq/0TvYPx04XgQ4wCHIxKPLwJpx3ShFgTy4orcw8xSnAwK4nwOhTapwnxpiRWVqUW5ccX
	leakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpg5P+7wVpWVkHg/NF4nZTev8E+
	vaIqNvsYXbnnCYdb/FPmdZcNquZTXcJb32HYVJ2R9a/gYwPPFv2z4R1aJ9YvMjxQH3I84fyq
	HRz7lOvKY4OuJryTnP2g/Zbc1xQLy4JJl5ZMcTmipapWc6Ly3eqbJrpms+OeNkXGf3tUvO6u
	u/q5lBkNWxSUWIozEg21mIuKEwH+1nyHvwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC5WfdrPs83zHN4PpNdYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZdz+OIu1YOcSxorvt5YzNTAeLOti5OSQEDCRWHXjNBOIzSKgKrH24RY2EJtN
	QF3ixo2fzCC2iICGxKeFy9m7GLk4mAWeM0n8fvObHSQhLBAiMe3DGrBmXgELiQ9bWli6GDk4
	hAQyJaZ/V4QIC0qcnPmEBcRmFtCSuPHvJRNICbOAtMTyfxwgJqeAncSZ7YwgFaICyhIHth1n
	msDIOwtJ8ywkzbMQmhcwMq9iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIjKpltX8m7mD8ctn9
	EKMAB6MSD2/CaYc0IdbEsuLK3EOMEhzMSiK8DoX2aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MTfyCby9MS+Fo5Dd+8Fua12bevdwgx3qJAtei1sCF
	ArVWuar+TpUG37S2K7ROLLKRvl20g/1FgUTLnbfzlvnNWyhgI8G0ZyvbFP9a3s+RG0TVVk4r
	jK+LXewV+ubxDJstjN1HFnokVM7SSF50WXHWln8KJ49ly1Rz7ZeQ/1YWeeeL9dn7j3crsRRn
	JBpqMRcVJwIA5VvaH6YCAAA=
X-CFilter-Loop: Reflected

On Sat, May 11, 2024 at 02:54:51PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Hi everyone,
> >
> > While I'm working with a tiered memory system e.g. CXL memory, I have
> > been facing migration overhead esp. tlb shootdown on promotion or
> > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > migration through hinting fault can be avoided thanks to Huang Ying's
> > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > is inaccessible").  See the following link for more information:
> >
> > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> >
> > However, it's only for migration through hinting fault.  I thought it'd
> > be much better if we have a general mechanism to reduce all the tlb
> > numbers that we can apply to any unmap code, that we normally believe
> > tlb flush should be followed.
> >
> > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), defers tlb flush
> > until folios that have been unmapped and freed, eventually get allocated
> > again.  It's safe for folios that had been mapped read-only and were
> > unmapped, since the contents of the folios don't change while staying in
> > pcp or buddy so we can still read the data through the stale tlb entries.
> >
> > tlb flush can be defered when folios get unmapped as long as it
> > guarantees to perform tlb flush needed, before the folios actually
> > become used, of course, only if all the corresponding ptes don't have
> > write permission.  Otherwise, the system will get messed up.
> >
> > To achieve that:
> >
> >    1. For the folios that map only to non-writable tlb entries, prevent
> >       tlb flush during unmapping but perform it just before the folios
> >       actually become used, out of buddy or pcp.
> >
> >    2. When any non-writable ptes change to writable e.g. through fault
> >       handler, give up luf mechanism and perform tlb flush required
> >       right away.
> >
> >    3. When a writable mapping is created e.g. through mmap(), give up
> >       luf mechanism and perform tlb flush required right away.
> >
> > No matter what type of workload is used for performance evaluation, the
> > result would be positive thanks to the unconditional reduction of tlb
> > flushes, tlb misses and interrupts.
> 
> Are there any downsides of the optimization?  Will it cause regression
> for workloads with almost no read-only mappings?  Will it cause

IMHO, no.  LUF does almost nothing for folios writable mapped.

> regression for page allocation?

TLB flush might be added in prep_new_page() if pended, however, that
should have been already performed anyway.  It's not additional overhead.

The TLB flush even can be skipped by the batched work.

> > For the test, I picked up one of
> > the most popular and heavy workload, llama.cpp that is a
> > LLM(Large Language Model) inference engine.
> 
> IIUC, llama.cpp is a workload with huge read-only mapping.

Right.  LUF works on read-only mapping.  So the more read-only mappings
are used, the better LUF works.  Fortunately, such a workload with huge
read-only mappings that is normal in a light weight inference engine, is
quite popular these days in the era of LLM.

	Byungchul

> > The result would depend on memory latency and how often reclaim runs,
> > which implies tlb miss overhead and how many times unmapping happens.
> > In my system, the result shows:
> >
> >    1. tlb flushes are reduced about 95%.
> >    2. tlb misses(itlb) are reduced about 80%.
> >    3. tlb misses(dtlb store) are reduced about 57%.
> >    4. tlb misses(dtlb load) are reduced about 24%.
> >    5. tlb shootdown interrupts are reduced about 95%.
> >    6. The test program runtime is reduced about 5%.
> >
> > The test environment and the result is like:
> >
> >    Machine: bare metal, x86_64, Intel(R) Xeon(R) Gold 6430
> >    CPU: 1 socket 64 core with hyper thread on
> >    Numa: 2 nodes (64 CPUs DRAM 42GB, no CPUs CXL expander 98GB)
> >    Config: swap off, numa balancing tiering on, demotion enabled
> >
> >    The test set:
> >
> >       llama.cpp/main -m $(70G_model1) -p "who are you?" -s 1 -t 15 -n 20 &
> >       llama.cpp/main -m $(70G_model2) -p "who are you?" -s 1 -t 15 -n 20 &
> >       llama.cpp/main -m $(70G_model3) -p "who are you?" -s 1 -t 15 -n 20 &
> >       wait
> >
> >       where -t: nr of threads, -s: seed used to make the runtime stable,
> >       -n: nr of tokens that determines the runtime, -p: prompt to ask,
> >       -m: LLM model to use.
> >
> >    Run the test set 10 times successively with caches dropped every run
> >    via 'echo 3 > /proc/sys/vm/drop_caches'.  Each inference prints its
> >    runtime at the end of each.
> >
> >    1. Runtime from the output of llama.cpp:
> >
> >    BEFORE
> >    ------
> >    llama_print_timings:       total time = 1002461.95 ms /    24 tokens
> >    llama_print_timings:       total time = 1044978.38 ms /    24 tokens
> >    llama_print_timings:       total time = 1000653.09 ms /    24 tokens
> >    llama_print_timings:       total time = 1047104.80 ms /    24 tokens
> >    llama_print_timings:       total time = 1069430.36 ms /    24 tokens
> >    llama_print_timings:       total time = 1068201.16 ms /    24 tokens
> >    llama_print_timings:       total time = 1078092.59 ms /    24 tokens
> >    llama_print_timings:       total time = 1073200.45 ms /    24 tokens
> >    llama_print_timings:       total time = 1067136.00 ms /    24 tokens
> >    llama_print_timings:       total time = 1076442.56 ms /    24 tokens
> >    llama_print_timings:       total time = 1004142.64 ms /    24 tokens
> >    llama_print_timings:       total time = 1042942.65 ms /    24 tokens
> >    llama_print_timings:       total time =  999933.76 ms /    24 tokens
> >    llama_print_timings:       total time = 1046548.83 ms /    24 tokens
> >    llama_print_timings:       total time = 1068671.48 ms /    24 tokens
> >    llama_print_timings:       total time = 1068285.76 ms /    24 tokens
> >    llama_print_timings:       total time = 1077789.63 ms /    24 tokens
> >    llama_print_timings:       total time = 1071558.93 ms /    24 tokens
> >    llama_print_timings:       total time = 1066181.55 ms /    24 tokens
> >    llama_print_timings:       total time = 1076767.53 ms /    24 tokens
> >    llama_print_timings:       total time = 1004065.63 ms /    24 tokens
> >    llama_print_timings:       total time = 1044522.13 ms /    24 tokens
> >    llama_print_timings:       total time =  999725.33 ms /    24 tokens
> >    llama_print_timings:       total time = 1047510.77 ms /    24 tokens
> >    llama_print_timings:       total time = 1068010.27 ms /    24 tokens
> >    llama_print_timings:       total time = 1068999.31 ms /    24 tokens
> >    llama_print_timings:       total time = 1077648.05 ms /    24 tokens
> >    llama_print_timings:       total time = 1071378.96 ms /    24 tokens
> >    llama_print_timings:       total time = 1066326.32 ms /    24 tokens
> >    llama_print_timings:       total time = 1077088.92 ms /    24 tokens
> >
> >    AFTER
> >    -----
> >    llama_print_timings:       total time =  988522.03 ms /    24 tokens
> >    llama_print_timings:       total time =  997204.52 ms /    24 tokens
> >    llama_print_timings:       total time =  996605.86 ms /    24 tokens
> >    llama_print_timings:       total time =  991985.50 ms /    24 tokens
> >    llama_print_timings:       total time = 1035143.31 ms /    24 tokens
> >    llama_print_timings:       total time =  993660.18 ms /    24 tokens
> >    llama_print_timings:       total time =  983082.14 ms /    24 tokens
> >    llama_print_timings:       total time =  990431.36 ms /    24 tokens
> >    llama_print_timings:       total time =  992707.09 ms /    24 tokens
> >    llama_print_timings:       total time =  992673.27 ms /    24 tokens
> >    llama_print_timings:       total time =  989285.43 ms /    24 tokens
> >    llama_print_timings:       total time =  996710.06 ms /    24 tokens
> >    llama_print_timings:       total time =  996534.64 ms /    24 tokens
> >    llama_print_timings:       total time =  991344.17 ms /    24 tokens
> >    llama_print_timings:       total time = 1035210.84 ms /    24 tokens
> >    llama_print_timings:       total time =  994714.13 ms /    24 tokens
> >    llama_print_timings:       total time =  984184.15 ms /    24 tokens
> >    llama_print_timings:       total time =  990909.45 ms /    24 tokens
> >    llama_print_timings:       total time =  991881.48 ms /    24 tokens
> >    llama_print_timings:       total time =  993918.03 ms /    24 tokens
> >    llama_print_timings:       total time =  990061.34 ms /    24 tokens
> >    llama_print_timings:       total time =  998076.69 ms /    24 tokens
> >    llama_print_timings:       total time =  997082.59 ms /    24 tokens
> >    llama_print_timings:       total time =  990677.58 ms /    24 tokens
> >    llama_print_timings:       total time = 1036054.94 ms /    24 tokens
> >    llama_print_timings:       total time =  994125.93 ms /    24 tokens
> >    llama_print_timings:       total time =  982467.01 ms /    24 tokens
> >    llama_print_timings:       total time =  990191.60 ms /    24 tokens
> >    llama_print_timings:       total time =  993319.24 ms /    24 tokens
> >    llama_print_timings:       total time =  992540.57 ms /    24 tokens
> >
> >    2. tlb shootdowns from 'cat /proc/interrupts':
> >
> >    BEFORE
> >    ------
> >    TLB:
> >    125553646  141418810  161932620  176853972  186655697  190399283
> >    192143823  196414038  192872439  193313658  193395617  192521416
> >    190788161  195067598  198016061  193607347  194293972  190786732
> >    191545637  194856822  191801931  189634535  190399803  196365922
> >    195268398  190115840  188050050  193194908  195317617  190820190
> >    190164820  185556071  226797214  229592631  216112464  209909495
> >    205575979  205950252  204948111  197999795  198892232  205287952
> >    199344631  195015158  195869844  198858745  195692876  200961904
> >    203463252  205921722  199850838  206145986  199613202  199961345
> >    200129577  203020521  207873649  203697671  197093386  204243803
> >    205993323  200934664  204193128  194435376  TLB shootdowns
> >
> >    AFTER
> >    -----
> >    TLB:
> >      5648092    6610142    7032849    7882308    8088518    8352310
> >      8656536    8705136    8647426    8905583    8985408    8704522
> >      8884344    9026261    8929974    8869066    8877575    8810096
> >      8770984    8754503    8801694    8865925    8787524    8656432
> >      8755912    8682034    8773935    8832925    8797997    8515777
> >      8481240    8891258   10595243   10285973    9756935    9573681
> >      9398968    9069244    9242984    8899009    9310690    9029095
> >      9069758    9105825    9092703    9270202    9460287    9258546
> >      9180415    9232723    9270611    9175020    9490420    9360316
> >      9420818    9057663    9525631    9310152    9152242    8654483
> >      9181804    9050847    8919916    8883856  TLB shootdowns
> >
> >    3. tlb numbers from 'perf stat' per test set:
> >
> >    BEFORE
> >    ------
> >    3163679332	dTLB-load-misses
> >    2017751856	dTLB-store-misses
> >    327092903	iTLB-load-misses
> >    1357543886	tlb:tlb_flush
> >
> >    AFTER
> >    -----
> >    2394694609	dTLB-load-misses
> >    861144167	dTLB-store-misses
> >    64055579	iTLB-load-misses
> >    69175002	tlb:tlb_flush
> >
> > ---
> >
> > Changes from v9:
> >
> > 	1. Expand the candidate to apply this mechanism:
> >
> > 	   BEFORE - The souce folios at any type of migration.
> > 	   AFTER  - Any folios that have been unmapped and freed.
> >
> > 	2. Change the workload for test:
> >
> > 	   BEFORE - XSBench
> > 	   AFTER  - llama.cpp (one of the most popluar real workload)
> >
> > 	3. Change the test environment:
> >
> > 	   BEFORE - qemu machine, too small DRAM(1GB), large remote mem
> > 	   AFTER  - bare metal, real CXL memory, practical memory size
> >
> > 	4. Rename the mechanism from MIGRC(Migration Read Copy) to
> > 	   LUF(Lazy Unmap Flush) to reflect the current version of the
> > 	   mechanism can be applied not only to unmap during migration
> > 	   but any unmap code e.g. unmap in shrink_folio_list().
> >
> > 	5. Fix build error for riscv. (feedbacked by kernel test bot)
> >
> > 	6. Supplement commit messages to describe what this mechanism is
> > 	   for, especially in the patches for arch code. (feedbacked by
> > 	   Thomas Gleixner)
> >
> > 	7. Clean up some trivial things.
> >
> > Changes from v8:
> >
> > 	1. Rebase on akpm/mm.git mm-unstable as of April 18, 2024.
> > 	2. Supplement comments and commit message.
> > 	3. Change the candidate to apply migrc mechanism:
> >
> > 	   BEFORE - The source folios at demotion and promotion.
> > 	   AFTER  - The souce folios at any type of migration.
> >
> > 	4. Change how migrc mechanism works:
> >
> > 	   BEFORE - Reduce tlb flushes by deferring folio_free() for
> > 	            source folios during demotion and promotion.
> > 	   AFTER  - Reduce tlb flushes by deferring tlb flush until they
> > 	            actually become used, out of pcp or buddy. The
> > 		    current version of migrc does *not* defer calling
> > 	            folio_free() but let it go as it is as the same as
> > 		    vanilla kernel, with the folios marked kind of 'need
> > 		    to tlb flush'. And then handle the flush when the
> > 		    page exits from pcp or buddy so as to prevent
> > 		    changing vm stats e.g. free pages.
> >
> > Changes from v7:
> >
> > 	1. Rewrite cover letter to explain what 'migrc' mechasism is.
> > 	   (feedbacked by Andrew Morton)
> > 	2. Supplement the commit message of a patch 'mm: Add APIs to
> > 	   free a folio directly to the buddy bypassing pcp'.
> > 	   (feedbacked by Andrew Morton)
> >
> > Changes from v6:
> >
> > 	1. Fix build errors in case of
> > 	   CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH disabled by moving
> > 	   migrc_flush_{start,end}() calls from arch code to
> > 	   try_to_unmap_flush() in mm/rmap.c.
> >
> > Changes from v5:
> >
> > 	1. Fix build errors in case of CONFIG_MIGRATION disabled or
> > 	   CONFIG_HWPOISON_INJECT moduled. (feedbacked by kernel test
> > 	   bot and Raymond Jay Golo)
> > 	2. Organize migrc code with two kconfigs, CONFIG_MIGRATION and
> > 	   CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH.
> >
> > Changes from v4:
> >
> > 	1. Rebase on v6.7.
> > 	2. Fix build errors in arm64 that is doing nothing for tlb flush
> > 	   but has CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH. (reported
> > 	   by kernel test robot)
> > 	3. Don't use any page flag. So the system would give up migrc
> > 	   mechanism more often but it's okay. The final improvement is
> > 	   good enough.
> > 	4. Instead, optimize full tlb flush(arch_tlbbatch_flush()) by
> > 	   avoiding redundant CPUs from tlb flush.
> >
> > Changes from v3:
> >
> > 	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
> > 	   migrc_enable. (feedbacked by Nadav)
> > 	2. Remove the optimization skipping CPUs that have already
> > 	   performed tlb flushes needed by any reason when performing
> > 	   tlb flushes by migrc because I can't tell the performance
> > 	   difference between w/ the optimization and w/o that.
> > 	   (feedbacked by Nadav)
> > 	3. Minimize arch-specific code. While at it, move all the migrc
> >            declarations and inline functions from include/linux/mm.h to
> >            mm/internal.h (feedbacked by Dave Hansen, Nadav)
> > 	4. Separate a part making migrc paused when the system is in
> > 	   high memory pressure to another patch. (feedbacked by Nadav)
> > 	5. Rename:
> > 	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
> > 	      b. tlb_ubc_nowr to tlb_ubc_ro,
> > 	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
> > 	      d. migrc_stop to migrc_pause.
> > 	   (feedbacked by Nadav)
> > 	6. Use ->lru list_head instead of introducing a new llist_head.
> > 	   (feedbacked by Nadav)
> > 	7. Use non-atomic operations of page-flag when it's safe.
> > 	   (feedbacked by Nadav)
> > 	8. Use stack instead of keeping a pointer of 'struct migrc_req'
> > 	   in struct task, which is for manipulating it locally.
> > 	   (feedbacked by Nadav)
> > 	9. Replace a lot of simple functions to inline functions placed
> > 	   in a header, mm/internal.h. (feedbacked by Nadav)
> > 	10. Add additional sufficient comments. (feedbacked by Nadav)
> > 	11. Remove a lot of wrapper functions. (feedbacked by Nadav)
> >
> > Changes from RFC v2:
> >
> > 	1. Remove additional occupation in struct page. To do that,
> > 	   unioned with lru field for migrc's list and added a page
> > 	   flag. I know page flag is a thing that we don't like to add
> > 	   but no choice because migrc should distinguish folios under
> > 	   migrc's control from others. Instead, I force migrc to be
> > 	   used only on 64 bit system to mitigate you guys from getting
> > 	   angry.
> > 	2. Remove meaningless internal object allocator that I
> > 	   introduced to minimize impact onto the system. However, a ton
> > 	   of tests showed there was no difference.
> > 	3. Stop migrc from working when the system is in high memory
> > 	   pressure like about to perform direct reclaim. At the
> > 	   condition where the swap mechanism is heavily used, I found
> > 	   the system suffered from regression without this control.
> > 	4. Exclude folios that pte_dirty() == true from migrc's interest
> > 	   so that migrc can work simpler.
> > 	5. Combine several patches that work tightly coupled to one.
> > 	6. Add sufficient comments for better review.
> > 	7. Manage migrc's request in per-node manner (from globally).
> > 	8. Add tlb miss improvement in commit message.
> > 	9. Test with more CPUs(4 -> 16) to see bigger improvement.
> >
> > Changes from RFC:
> >
> > 	1. Fix a bug triggered when a destination folio at the previous
> > 	   migration becomes a source folio at the next migration,
> > 	   before the folio gets handled properly so that the folio can
> > 	   play with another migration. There was inconsistency in the
> > 	   folio's state. Fixed it.
> > 	2. Split the patch set into more pieces so that the folks can
> > 	   review better. (Feedbacked by Nadav Amit)
> > 	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
> > 	   (Feedbacked by Nadav Amit)
> > 	4. Tried to add sufficient comments to explain the patch set
> > 	   better. (Feedbacked by Nadav Amit)
> >
> > Byungchul Park (12):
> >   x86/tlb: add APIs manipulating tlb batch's arch data
> >   arm64: tlbflush: add APIs manipulating tlb batch's arch data
> >   riscv, tlb: add APIs manipulating tlb batch's arch data
> >   x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of
> >     arch_tlbbatch_flush()
> >   mm: buddy: make room for a new variable, ugen, in struct page
> >   mm: add folio_put_ugen() to deliver unmap generation number to pcp or
> >     buddy
> >   mm: add a parameter, unmap generation number, to free_unref_folios()
> >   mm/rmap: recognize read-only tlb entries during batched tlb flush
> >   mm: implement LUF(Lazy Unmap Flush) defering tlb flush when folios get
> >     unmapped
> >   mm: separate move/undo parts from migrate_pages_batch()
> >   mm, migrate: apply luf mechanism to unmapping during migration
> >   mm, vmscan: apply luf mechanism to unmapping during folio reclaim
> >
> >  arch/arm64/include/asm/tlbflush.h |  18 ++
> >  arch/riscv/include/asm/tlbflush.h |  21 ++
> >  arch/riscv/mm/tlbflush.c          |   1 -
> >  arch/x86/include/asm/tlbflush.h   |  18 ++
> >  arch/x86/mm/tlb.c                 |   2 -
> >  include/linux/mm.h                |  22 ++
> >  include/linux/mm_types.h          |  40 +++-
> >  include/linux/rmap.h              |   7 +-
> >  include/linux/sched.h             |  11 +
> >  mm/compaction.c                   |  10 +
> >  mm/internal.h                     | 115 +++++++++-
> >  mm/memory.c                       |   8 +
> >  mm/migrate.c                      | 184 ++++++++++------
> >  mm/mmap.c                         |   8 +
> >  mm/page_alloc.c                   | 157 +++++++++++---
> >  mm/page_isolation.c               |   6 +
> >  mm/page_reporting.c               |  10 +
> >  mm/rmap.c                         | 345 +++++++++++++++++++++++++++++-
> >  mm/swap.c                         |  18 +-
> >  mm/vmscan.c                       |  29 ++-
> >  20 files changed, 904 insertions(+), 126 deletions(-)
> >
> >
> > base-commit: f52bcd4a9f6058704a6f6b6b50418f579defd4fe
> 
> --
> Best Regards,
> Huang, Ying

