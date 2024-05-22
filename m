Return-Path: <linux-kernel+bounces-185686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C548CB8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285AB1C21F48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481156444;
	Wed, 22 May 2024 02:16:30 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BA57CB4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344189; cv=none; b=TATd96/hOsk5Rn9mCsf3ynDzV/PZP8/51cA0VEBL14jJDlRiA6yPf5qhDnPStK/3wr0bqo2IzEaChX5dlwlUp0X+wZuLIuecuyM5Tqr85/rNLlc9jiLWFXJW+g5ciIjQyc64e4kIbEyZnLUM69YstdEoZZ+nVXdTDuAWh89M/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344189; c=relaxed/simple;
	bh=BrmtZL/HZcsoMRrjG37birkuJ2klFFvcNZcXSIlc8QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz5ajJi9K3U5R80eakSPVFybzWvjyakDHA77ykDqCEEt6Mool6uPlXPvsU34cSHo3bJTBewDgOqy1o6ptcLJYecEr5yqqtmGlnJhg96JtHhlyBsXrzE3Daw8I3Dbr3FpVjUvhF9ZymFl4YBTL3P5rncZKDRkRwmr4tFgN6IcDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-0b-664d5575b193
Date: Wed, 22 May 2024 11:16:16 +0900
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
Message-ID: <20240522021616.GA34580@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240513014428.GB38851@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513014428.GB38851@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXC9ZZnkW5ZqG+awdIVTBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	Zc9H5oKZ6hX9nwsbGG9IdzFyckgImEj8+vKYrYuRA8z+ecUWJMwioCrx4OQSRhCbTUBd4saN
	n8wgtoiAhsSnhcvZuxi5OJgFnjNJ/H7zmx0kISwQIjHtwxomEJtXwELif9tMRpAiIYEZjBL/
	bjWyQyQEJU7OfMICYjMLaEnc+PeSCWQxs4C0xPJ/HCBhTgFLic3fjoKViAooSxzYdpwJZI6E
	wCZ2iY+nXzJBHC0pcXDFDZYJjAKzkIydhWTsLISxCxiZVzEKZeaV5SZm5pjoZVTmZVboJefn
	bmIExuGy2j/ROxg/XQg+xCjAwajEw7uhzidNiDWxrLgy9xCjBAezkgjvpi2eaUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoY9Wo+ZUucMFk+eelJBckm
	PvkXNW6LgpZvs7HWinnqzvrr+oSFXdZyidd1FTstPvDN/PZD7Vg1j/oksftr9yr2Ba567cRx
	ZO6vTVZJHkLKy4vO/v4jOmGNm8mWpxO3cM+VrwxfHT71WdbB1oSNTxbNORrMtkhti86bklX3
	NAPYw02uhWeFGfE+V2Ipzkg01GIuKk4EAMnsZFa/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC5WfdrFsa6ptmsKPP0GLO+jVsFp83/GOz
	eLGhndHi6/pfzBZPP/WxWByee5LV4vKuOWwW99b8Z7U4v2stq8WOpfuYLC4dWMBkcbz3AJPF
	/Huf2Sw2b5rKbHF8ylRGi98/gIpPzprM4iDo8b21j8Vj56y77B4LNpV6bF6h5bF4z0smj02r
	Otk8Nn2axO7x7tw5do8TM36zeMw7Gejxft9VNo/FLz4weWz9ZefROPUam8fnTXIB/FFcNimp
	OZllqUX6dglcGSt7PjIXzFSv6P9c2MB4Q7qLkYNDQsBE4ucV2y5GTg4WAVWJByeXMILYbALq
	Ejdu/GQGsUUENCQ+LVzO3sXIxcEs8JxJ4veb3+wgCWGBEIlpH9Ywgdi8AhYS/9tmMoIUCQnM
	YJT4d6uRHSIhKHFy5hMWEJtZQEvixr+XTCCLmQWkJZb/4wAJcwpYSmz+dhSsRFRAWeLAtuNM
	Exh5ZyHpnoWkexZC9wJG5lWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBUbWs9s/EHYxfLrsf
	YhTgYFTi4d1Q55MmxJpYVlyZe4hRgoNZSYR30xbPNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGiNsrntYy5z+Mkv1st90he/Kpq88uMEjbPDwsvfEO
	Y7qk4PwTDD/Flk614k5eXTa1Jfjy9TY9Q7b5t1fsXryqf5ZEeDGfAsuLpPwsz6PsF7VPd06b
	qD+9fMmFgojgVZdOu50Pfn54k8aPuulSD7qvMap89GhTUVV/LTev3m+GmbWYbYzHLLFHSizF
	GYmGWsxFxYkA4zCLsaYCAAA=
X-CFilter-Loop: Reflected

On Mon, May 13, 2024 at 10:44:29AM +0900, Byungchul Park wrote:
> On Sat, May 11, 2024 at 03:15:01PM +0800, Huang, Ying wrote:
> > Byungchul Park <byungchul@sk.com> writes:
> > 
> > > Hi everyone,
> > >
> > > While I'm working with a tiered memory system e.g. CXL memory, I have
> > > been facing migration overhead esp. tlb shootdown on promotion or
> > > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > > migration through hinting fault can be avoided thanks to Huang Ying's
> > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > > is inaccessible").  See the following link for more information:
> > >
> > > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> > 
> > And, I still have interest of the performance impact of commit
> > 7e12beb8ca2a ("migrate_pages: batch flushing TLB").  In the email above,
> > you said that the performance of v6.5-rc5 + 7e12beb8ca2a reverted has
> > better performance than v6.5-rc5.  Can you provide more details?  For
> > example, the number of TLB flushing IPI for two kernels?
> 
> Okay.  I will test and share the result with what you asked me now once
> I get available for the test.

I should admit that the test using qemu is so unstable.  While using
qemu for the test, kernel with 7e12beb8ca2a applied gave better results
sometimes and worse ones sometimes.  I should've used a bare metal from
the beginning.  Sorry for making you confused with the unstable result.

Since I thought you asked me for the test with the same environment in
the link above, I used qemu to reproduce the similar result but changed
the number of threads for the test from 16 to 14 to get rid of noise
that might be introduced by other than the intended test just in case.

As expected, the stats are better with your work:

   ------------------------------------------
   v6.6-rc5 with 7e12beb8ca2a commit reverted
   ------------------------------------------

   1) from output of XSBench

   Threads:     14              
   Runtime:     1127.043 seconds
   Lookups:     1,700,000,000   
   Lookups/s:   1,508,371       

   2) from /proc/vmstat

   numa_hit 15580171                      
   numa_miss 1034233                      
   numa_foreign 1034233                   
   numa_interleave 773                    
   numa_local 7927442                     
   numa_other 8686962                     
   numa_pte_updates 24068923              
   numa_hint_faults 24061125              
   numa_hint_faults_local 0               
   numa_pages_migrated 7426480            
   pgmigrate_success 15407375             
   pgmigrate_fail 1849                    
   compact_migrate_scanned 4445414        
   compact_daemon_migrate_scanned 4445414 
   pgdemote_kswapd 7651061                
   pgdemote_direct 0                      
   nr_tlb_remote_flush 8080092            
   nr_tlb_remote_flush_received 109915713 
   nr_tlb_local_flush_all 53800           
   nr_tlb_local_flush_one 770466                                                   
   
   3) from /proc/interrupts

   TLB: 8022927    7840769     123588    7837008    7835967    7839837
   	7838332    7839886    7837610    7837221    7834524     407260
   	7430090    7835696    7839081    7712568    TLB shootdowns  
   
   4) from 'perf stat -a'

   222371217		itlb.itlb_flush      
   919832520		tlb_flush.dtlb_thread
   372223809		tlb_flush.stlb_any   
   120210808042		dTLB-load-misses     
   979352769		dTLB-store-misses    
   3650767665		iTLB-load-misses     

   -----------------------------------------
   v6.6-rc5 with 7e12beb8ca2a commit applied
   -----------------------------------------

   1) from output of XSBench

   Threads:     14
   Runtime:     1105.521 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,537,737

   2) from /proc/vmstat

   numa_hit 24148399
   numa_miss 797483
   numa_foreign 797483
   numa_interleave 772
   numa_local 12214575
   numa_other 12731307
   numa_pte_updates 24250278
   numa_hint_faults 24199756
   numa_hint_faults_local 0
   numa_pages_migrated 11476195
   pgmigrate_success 23634639
   pgmigrate_fail 1391
   compact_migrate_scanned 3760803
   compact_daemon_migrate_scanned 3760803
   pgdemote_kswapd 11932217
   pgdemote_direct 0
   nr_tlb_remote_flush 2151945
   nr_tlb_remote_flush_received 29672808
   nr_tlb_local_flush_all 124006
   nr_tlb_local_flush_one 741165
   
   3) from /proc/interrupts

   TLB: 2130784    2120142    2117571     844962    2071766     114675
   	2117258    2119596    2116816    1205446    2119176    2119209
   	2116792    2118763    2118773    2117762    TLB shootdowns

   4) from 'perf stat -a'

   60851902		itlb.itlb_flush
   334068491		tlb_flush.dtlb_thread
   223732916		tlb_flush.stlb_any
   120207083382		dTLB-load-misses
   446823059		dTLB-store-misses
   1926669373		iTLB-load-misses

---

	Byungchul

