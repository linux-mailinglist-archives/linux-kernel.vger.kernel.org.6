Return-Path: <linux-kernel+bounces-186339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2528CC2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D3B214AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91461411CA;
	Wed, 22 May 2024 14:16:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F481DA24
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387370; cv=none; b=qsuL/zf7db9T716dEEFnBAFR2CxSrlMpF03OAZ9j4LFLdPWpWgEqCZcgRBrdMvIvAnBFztBjEKps7OSMvH7J87ZLzrnP3QCOldsziqJYJAAy/zgVptCO9Ve9b6RMHNxaofyZANkbTJQopvfH+rjhsLAM4PKtR8sNlxzo8aj7Y4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387370; c=relaxed/simple;
	bh=pVBbhZdZ7B+zf1jypm5u3NHYHf+ZywuOwwBzi+C1znw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izr6HSfc3o6iT3Et70EDPDr5lozEvObMFB9NkwpYXNlqo/d2qIou1bsseIYrXk2KgZm9ujIErw1FZ4jMEZ7tApYyt86YDwJs/oS0V/XK+AHdNEpH8113jT02s7IkCHZ4Is83zU4JgrMsY9HCh+r9CHPoStvJH7FRrbuk4HeI8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-16-664dfe21ce86
Date: Wed, 22 May 2024 23:15:55 +0900
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
Message-ID: <20240522141555.GA34201@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240513014428.GB38851@system.software.com>
 <20240522021616.GA34580@system.software.com>
 <87h6eqb8kj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240522102743.GA29930@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522102743.GA29930@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsXC9ZZnka7iP980gynPxC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	rDu72Au+hFd0z9dtYJxr38XIySEhYCKxubmTGcZuffOIHcRmEVCVWNy0iBXEZhNQl7hx4ydY
	jYiAhsSnhcuBarg4mAWeM0n8fvMbrEFYIERi2oc1TCA2r4CFxKM9JxhBioQEVjFJbL9+lR0i
	IShxcuYTFhCbWUBL4sa/l0ANHEC2tMTyfxwgYU4BS4kzv1rBSkQFlCUObDvOBDJHQmAVu8Th
	1e/YIC6VlDi44gbLBEaBWUjGzkIydhbC2AWMzKsYhTLzynITM3NM9DIq8zIr9JLzczcxAiNx
	We2f6B2Mny4EH2IU4GBU4uGN+OybJsSaWFZcmXuIUYKDWUmEN3olUIg3JbGyKrUoP76oNCe1
	+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjs9oTmcDzIcH3hPdekONvdJ7YLcb8
	LvyOT6tG/pK/TQ5/zDZ57L3t+GvNcf0Pac0Rdscf7l/hG7fngu5Khp+6e3kP+67r8Xo7Sbjs
	QHAqP+dZsS8xhSa7A5/6Xb6nburE/2hF3LwTS3xnXLC4FP7sTOdFWdvX+pI+Fyefe5mWWfWu
	e2a/89HtSizFGYmGWsxFxYkAIN3bjsACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXC5WfdrKv4zzfN4M1kJos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZcy6s4u94Et4Rfd83QbGufZdjJwcEgImEq1vHrGD2CwCqhKLmxaxgthsAuoS
	N278ZAaxRQQ0JD4tXA5Uw8XBLPCcSeL3m99gDcICIRLTPqxhArF5BSwkHu05wQhSJCSwikli
	+/Wr7BAJQYmTM5+wgNjMAloSN/69BGrgALKlJZb/4wAJcwpYSpz51QpWIiqgLHFg23GmCYy8
	s5B0z0LSPQuhewEj8ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAuFpW+2fiDsYvl90PMQpw
	MCrx8Cb88k0TYk0sK67MPcQowcGsJMIbvRIoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVB
	SCA9sSQ1OzW1ILUIJsvEwSnVwFjRHyaxvNe3K2m3imnOSXb9pU/VfRqd+OOOWzjVtemfPZRX
	/vdSeMvx3ft3Zlf+OFrzSd+1Z3Om2AoB/VNPXLJFNsWVC9+5fnt13jumJTn7OCK+CK7Kecdb
	b9fB6BRnVrcsRX+BltY8nn2vNWbZrjAWZni0qXa1Ea/G1yNH1OUUev6uvlrVpcRSnJFoqMVc
	VJwIAJ+3JLGnAgAA
X-CFilter-Loop: Reflected

On Wed, May 22, 2024 at 07:27:44PM +0900, Byungchul Park wrote:
> On Wed, May 22, 2024 at 03:38:04PM +0800, Huang, Ying wrote:
> > Hi, Byungchul,
> > 
> > Byungchul Park <byungchul@sk.com> writes:
> > 
> > > On Mon, May 13, 2024 at 10:44:29AM +0900, Byungchul Park wrote:
> > >> On Sat, May 11, 2024 at 03:15:01PM +0800, Huang, Ying wrote:
> > >> > Byungchul Park <byungchul@sk.com> writes:
> > >> > 
> > >> > > Hi everyone,
> > >> > >
> > >> > > While I'm working with a tiered memory system e.g. CXL memory, I have
> > >> > > been facing migration overhead esp. tlb shootdown on promotion or
> > >> > > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > >> > > migration through hinting fault can be avoided thanks to Huang Ying's
> > >> > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > >> > > is inaccessible").  See the following link for more information:
> > >> > >
> > >> > > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> > >> > 
> > >> > And, I still have interest of the performance impact of commit
> > >> > 7e12beb8ca2a ("migrate_pages: batch flushing TLB").  In the email above,
> > >> > you said that the performance of v6.5-rc5 + 7e12beb8ca2a reverted has
> > >> > better performance than v6.5-rc5.  Can you provide more details?  For
> > >> > example, the number of TLB flushing IPI for two kernels?
> > >> 
> > >> Okay.  I will test and share the result with what you asked me now once
> > >> I get available for the test.
> > >
> > > I should admit that the test using qemu is so unstable.  While using
> > > qemu for the test, kernel with 7e12beb8ca2a applied gave better results
> > > sometimes and worse ones sometimes.  I should've used a bare metal from
> > > the beginning.  Sorry for making you confused with the unstable result.
> > >
> > > Since I thought you asked me for the test with the same environment in
> > > the link above, I used qemu to reproduce the similar result but changed
> > > the number of threads for the test from 16 to 14 to get rid of noise
> > > that might be introduced by other than the intended test just in case.
> > >
> > > As expected, the stats are better with your work:
> > >
> > >    ------------------------------------------
> > >    v6.6-rc5 with 7e12beb8ca2a commit reverted
> > >    ------------------------------------------
> > >
> > >    1) from output of XSBench
> > >
> > >    Threads:     14              
> > >    Runtime:     1127.043 seconds
> > >    Lookups:     1,700,000,000   
> > >    Lookups/s:   1,508,371       
> > >
> > >    2) from /proc/vmstat
> > >
> > >    numa_hit 15580171                      
> > >    numa_miss 1034233                      
> > >    numa_foreign 1034233                   
> > >    numa_interleave 773                    
> > >    numa_local 7927442                     
> > >    numa_other 8686962                     
> > >    numa_pte_updates 24068923              
> > >    numa_hint_faults 24061125              
> > >    numa_hint_faults_local 0               
> > >    numa_pages_migrated 7426480            
> > >    pgmigrate_success 15407375             
> > >    pgmigrate_fail 1849                    
> > >    compact_migrate_scanned 4445414        
> > >    compact_daemon_migrate_scanned 4445414 
> > >    pgdemote_kswapd 7651061                
> > >    pgdemote_direct 0                      
> > >    nr_tlb_remote_flush 8080092            
> > >    nr_tlb_remote_flush_received 109915713 
> > >    nr_tlb_local_flush_all 53800           
> > >    nr_tlb_local_flush_one 770466                                                   
> > >    
> > >    3) from /proc/interrupts
> > >
> > >    TLB: 8022927    7840769     123588    7837008    7835967    7839837
> > >    	7838332    7839886    7837610    7837221    7834524     407260
> > >    	7430090    7835696    7839081    7712568    TLB shootdowns  
> > >    
> > >    4) from 'perf stat -a'
> > >
> > >    222371217		itlb.itlb_flush      
> > >    919832520		tlb_flush.dtlb_thread
> > >    372223809		tlb_flush.stlb_any   
> > >    120210808042		dTLB-load-misses     
> > >    979352769		dTLB-store-misses    
> > >    3650767665		iTLB-load-misses     
> > >
> > >    -----------------------------------------
> > >    v6.6-rc5 with 7e12beb8ca2a commit applied
> > >    -----------------------------------------
> > >
> > >    1) from output of XSBench
> > >
> > >    Threads:     14
> > >    Runtime:     1105.521 seconds
> > >    Lookups:     1,700,000,000
> > >    Lookups/s:   1,537,737
> > >
> > >    2) from /proc/vmstat
> > >
> > >    numa_hit 24148399
> > >    numa_miss 797483
> > >    numa_foreign 797483
> > >    numa_interleave 772
> > >    numa_local 12214575
> > >    numa_other 12731307
> > >    numa_pte_updates 24250278
> > >    numa_hint_faults 24199756
> > >    numa_hint_faults_local 0
> > >    numa_pages_migrated 11476195
> > >    pgmigrate_success 23634639
> > >    pgmigrate_fail 1391
> > >    compact_migrate_scanned 3760803
> > >    compact_daemon_migrate_scanned 3760803
> > >    pgdemote_kswapd 11932217
> > >    pgdemote_direct 0
> > >    nr_tlb_remote_flush 2151945
> > >    nr_tlb_remote_flush_received 29672808
> > >    nr_tlb_local_flush_all 124006
> > >    nr_tlb_local_flush_one 741165
> > >    
> > >    3) from /proc/interrupts
> > >
> > >    TLB: 2130784    2120142    2117571     844962    2071766     114675
> > >    	2117258    2119596    2116816    1205446    2119176    2119209
> > >    	2116792    2118763    2118773    2117762    TLB shootdowns
> > >
> > >    4) from 'perf stat -a'
> > >
> > >    60851902		itlb.itlb_flush
> > >    334068491		tlb_flush.dtlb_thread
> > >    223732916		tlb_flush.stlb_any
> > >    120207083382		dTLB-load-misses
> > >    446823059		dTLB-store-misses
> > >    1926669373		iTLB-load-misses
> > >
> > 
> > Thanks a lot for test results!
> > 
> > >From your test results, the TLB shootdown IPI can be reduced effectively
> > with commit 7e12beb8ca2a.  So that the benchmark score improved a
> > little.
> > 
> > And, your changes will reduce the TLB shootdown IPI further, right?  Do
> 
> Yes, right. LUF(Lazy Unmap Flush) reduces TLB shootdown IPI further.
> 
> > you have the number?
> 
> You can find the number obtained from llama.cpp in this cover letter:
> 
>    https://lore.kernel.org/lkml/20240520021734.21527-1-byungchul@sk.com/
> 
> If you meant the number from the same test above, XSBench + qemu, I will
> re-test with mm-unstable branch of mm tree and share the result shortly.

I retested the same test but based on a recent mm-unstable branch of mm
tree instead of v6.6-rc5.  The result changed because of the different
base, from v6.6-rc5 to a recent mm-unstable branch of mm tree.

   ----------------------------------------------------
   mm-unstable branch with 7e12beb8ca2a commit reverted
   ----------------------------------------------------

   1) from output of XSBench

   Threads:     14
   Runtime:     1067.771 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,592,101

   2) from /proc/vmstat

   numa_hit 11502876
   numa_miss 1130877
   numa_foreign 1130877
   numa_interleave 115
   numa_local 5879006
   numa_other 6754747
   numa_pte_updates 19390661
   numa_hint_faults 19319467
   numa_hint_faults_local 0
   numa_pages_migrated 5472749
   pgmigrate_success 11593079
   pgmigrate_fail 549666
   compact_migrate_scanned 5408404
   compact_daemon_migrate_scanned 5408404
   pgdemote_kswapd 5610705
   pgdemote_direct 0
   nr_tlb_remote_flush 6200106
   nr_tlb_remote_flush_received 84362539
   nr_tlb_local_flush_all 39202
   nr_tlb_local_flush_one 760046

   3) from /proc/interrupts

   TLB: 3812782    3840646    4806989    5235846    5127512    5048603
	6012100    6022642    5088907    5212207    4076329    6014857
	6017060    6014964    6009362    6018368    TLB shootdowns

   4) from 'perf stat -a'

   180449546		itlb.itlb_flush
   768913454		tlb_flush.dtlb_thread
   304745973		tlb_flush.stlb_any
   119589742349		dTLB-load-misses
   826525376		dTLB-store-misses
   2950724801		iTLB-load-misses

   ---------------------------------------------------
   mm-unstable branch with 7e12beb8ca2a commit applied
   ---------------------------------------------------

   1) from output of XSBench

   Threads:     14
   Runtime:     1043.972 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,628,395

   2) from /proc/vmstat

   numa_hit 16865880
   numa_miss 1129958
   numa_foreign 1129958
   numa_interleave 115
   numa_local 8565072
   numa_other 9430766
   numa_pte_updates 19240583
   numa_hint_faults 19239948
   numa_hint_faults_local 0
   numa_pages_migrated 8159078
   pgmigrate_success 17000781
   pgmigrate_fail 1410437
   compact_migrate_scanned 5075605
   compact_daemon_migrate_scanned 5075605
   pgdemote_kswapd 8297460
   pgdemote_direct 0
   nr_tlb_remote_flush 1516807
   nr_tlb_remote_flush_received 20938785
   nr_tlb_local_flush_all 95801
   nr_tlb_local_flush_one 740597

   3) from /proc/interrupts

   TLB:  927080     567584     840684    1484285    1495859    1408641
	1496227    1493909    1359465    1227623    1265431    1496361
	1392337    1489451    1495799    1494700    TLB shootdowns

   4) from 'perf stat -a'

   43564429		itlb.itlb_flush
   272921880		tlb_flush.dtlb_thread
   175495467		tlb_flush.stlb_any
   119602211976		dTLB-load-misses
   355190881		dTLB-store-misses
   1539926469		iTLB-load-misses

   ---------------------------------------------------------
   mm-unstable branch with 7e12beb8ca2a commit applied + LUF
   ---------------------------------------------------------

   1) from output of XSBench

   Threads:     14
   Runtime:     1033.973 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,644,144

   2) from /proc/vmstat

   numa_hit 18617127
   numa_miss 1075467
   numa_foreign 1075467
   numa_interleave 115
   numa_local 9440134
   numa_other 10252460
   numa_pte_updates 19473883
   numa_hint_faults 19470143
   numa_hint_faults_local 0
   numa_pages_migrated 8978959
   pgmigrate_success 18675500
   pgmigrate_fail 1577460
   compact_migrate_scanned 5465414
   compact_daemon_migrate_scanned 5465414
   pgdemote_kswapd 9172431
   pgdemote_direct 0
   nr_tlb_remote_flush 85818
   nr_tlb_remote_flush_received 1036316
   nr_tlb_local_flush_all 34674
   nr_tlb_local_flush_one 740870

   3) from /proc/interrupts

   TLB: 55328      31254      44449      72887      73407      73775
	73353      73658      35802      68184      70998      73504
	74072      64700      73718      73862      TLB shootdowns

   4) from 'perf stat -a'

   2054390		itlb.itlb_flush
   150073902		tlb_flush.dtlb_thread
   135630767		tlb_flush.stlb_any
   117880065362		dTLB-load-misses
   217521760		dTLB-store-misses
   908338035		iTLB-load-misses

---

The result looks incredible.  You can also see the result if you try to
test a workload triggering reclaim or migration with LUF.

	Byungchul

