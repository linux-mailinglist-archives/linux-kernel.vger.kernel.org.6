Return-Path: <linux-kernel+bounces-186054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6E8CBF42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B08E1F2339D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CDA823D9;
	Wed, 22 May 2024 10:28:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404767E572
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373683; cv=none; b=RzWHNj9S7msv60TqRufwx4m+scXCIwO/rQGGdTJpcTOqhIpr3CGO449p4x8YeAo0zmer3Fp58V3IlaTtMZt4qQls6xyG6Zd8NKxzjszLDkqHcrBz3gy2sR3HmLmKC4MV1CyYugwhZHl3B5ZwmtEJjWgpxtV3jFfgbIylpU3cU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373683; c=relaxed/simple;
	bh=GSjBcDsQDh/+GmviWbWd8QTlVPycEwxUcVerDaAeh3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvfHi0THfOoRdUeMxWJ3NWcQFQGO6JKdh2J9Q/uRRQ79iH6CO8QMZXhPInMrTe9qXaddDS2pJrM+96zNMFtuEpMilD1DniS+YSkPAHNOmN8hAovkBp0DQTAa1+zuNqIliGhVq0mmTokfmXs0tRgc6q/+pHvVKppKKUKKcb4QOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6e-664dc8a5e49f
Date: Wed, 22 May 2024 19:27:44 +0900
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
Message-ID: <20240522102743.GA29930@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240513014428.GB38851@system.software.com>
 <20240522021616.GA34580@system.software.com>
 <87h6eqb8kj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6eqb8kj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsXC9ZZnoe7SE75pBs8bFCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	hoYutoLVhhUP/sxna2B8qtTFyMkhIWAiMX1bAyOMfWv5DDCbRUBV4uWL+ewgNpuAusSNGz+Z
	QWwRAQ2JTwuXA8W5OJgFnjNJ/H7zG6xIWCBEYtqHNUwgNq+AhUTXoWNsIEVCAr8ZJRY8W8UI
	kRCUODnzCQuIzSygJXHj30ugBg4gW1pi+T8OkDCngJ3E+f9zwOaICihLHNh2nAlkjoTAJnaJ
	ZaeXsEFcKilxcMUNlgmMArOQjJ2FZOwshLELGJlXMQpl5pXlJmbmmOhlVOZlVugl5+duYgTG
	4rLaP9E7GD9dCD7EKMDBqMTDu6HOJ02INbGsuDL3EKMEB7OSCG/0St80Id6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYxTdEq82Y+8D5q3KGbNasndXiwp
	LEf3FXBMc7Bz37DnpL6uwm6HVn3fj2Ule4R/zGX8zrjxr7bVhaDAnVfOsr98c1fxZLapptCq
	qBPXVysfdec45a52cnP4Ni/d8jdCB4PLt073Wsohwn6yZrmlcAljV9WsOZOrfs+fXGW/farc
	mkfz90g/j3JWYinOSDTUYi4qTgQAtL/F3sECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXC5WfdrLv0hG+awdIvvBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgytjQ0MVWsNqw4sGf+WwNjE+Vuhg5OSQETCRuLZ/BCGKzCKhKvHwxnx3EZhNQ
	l7hx4ycziC0ioCHxaeFyoDgXB7PAcyaJ329+gxUJC4RITPuwhgnE5hWwkOg6dIwNpEhI4Dej
	xIJnqxghEoISJ2c+YQGxmQW0JG78ewnUwAFkS0ss/8cBEuYUsJM4/38O2BxRAWWJA9uOM01g
	5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBEbWsto/E3cwfrnsfohR
	gINRiYd3Q51PmhBrYllxZe4hRgkOZiUR3uiVvmlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3C
	UxOEBNITS1KzU1MLUotgskwcnFINjDLbRD+/Ouy8M3vigV0/BP+YuUVeSn2/qG/qraU1cprG
	fzc8rOblfntAUvjpjRyh/Iz8Z/9u/89oNK3J3rtZ5a/nnKdiz+ZvnKl9SL6aKUbr57Sim37L
	Xtr27rHIrbu8dq+JS1fYk9DtgSuf9Sbs9gpnkeh5sTRZYNeE4F/pzcazqybff3OvzU2JpTgj
	0VCLuag4EQAaLStcqAIAAA==
X-CFilter-Loop: Reflected

On Wed, May 22, 2024 at 03:38:04PM +0800, Huang, Ying wrote:
> Hi, Byungchul,
> 
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Mon, May 13, 2024 at 10:44:29AM +0900, Byungchul Park wrote:
> >> On Sat, May 11, 2024 at 03:15:01PM +0800, Huang, Ying wrote:
> >> > Byungchul Park <byungchul@sk.com> writes:
> >> > 
> >> > > Hi everyone,
> >> > >
> >> > > While I'm working with a tiered memory system e.g. CXL memory, I have
> >> > > been facing migration overhead esp. tlb shootdown on promotion or
> >> > > demotion between different tiers.  Yeah..  most tlb shootdowns on
> >> > > migration through hinting fault can be avoided thanks to Huang Ying's
> >> > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> >> > > is inaccessible").  See the following link for more information:
> >> > >
> >> > > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> >> > 
> >> > And, I still have interest of the performance impact of commit
> >> > 7e12beb8ca2a ("migrate_pages: batch flushing TLB").  In the email above,
> >> > you said that the performance of v6.5-rc5 + 7e12beb8ca2a reverted has
> >> > better performance than v6.5-rc5.  Can you provide more details?  For
> >> > example, the number of TLB flushing IPI for two kernels?
> >> 
> >> Okay.  I will test and share the result with what you asked me now once
> >> I get available for the test.
> >
> > I should admit that the test using qemu is so unstable.  While using
> > qemu for the test, kernel with 7e12beb8ca2a applied gave better results
> > sometimes and worse ones sometimes.  I should've used a bare metal from
> > the beginning.  Sorry for making you confused with the unstable result.
> >
> > Since I thought you asked me for the test with the same environment in
> > the link above, I used qemu to reproduce the similar result but changed
> > the number of threads for the test from 16 to 14 to get rid of noise
> > that might be introduced by other than the intended test just in case.
> >
> > As expected, the stats are better with your work:
> >
> >    ------------------------------------------
> >    v6.6-rc5 with 7e12beb8ca2a commit reverted
> >    ------------------------------------------
> >
> >    1) from output of XSBench
> >
> >    Threads:     14              
> >    Runtime:     1127.043 seconds
> >    Lookups:     1,700,000,000   
> >    Lookups/s:   1,508,371       
> >
> >    2) from /proc/vmstat
> >
> >    numa_hit 15580171                      
> >    numa_miss 1034233                      
> >    numa_foreign 1034233                   
> >    numa_interleave 773                    
> >    numa_local 7927442                     
> >    numa_other 8686962                     
> >    numa_pte_updates 24068923              
> >    numa_hint_faults 24061125              
> >    numa_hint_faults_local 0               
> >    numa_pages_migrated 7426480            
> >    pgmigrate_success 15407375             
> >    pgmigrate_fail 1849                    
> >    compact_migrate_scanned 4445414        
> >    compact_daemon_migrate_scanned 4445414 
> >    pgdemote_kswapd 7651061                
> >    pgdemote_direct 0                      
> >    nr_tlb_remote_flush 8080092            
> >    nr_tlb_remote_flush_received 109915713 
> >    nr_tlb_local_flush_all 53800           
> >    nr_tlb_local_flush_one 770466                                                   
> >    
> >    3) from /proc/interrupts
> >
> >    TLB: 8022927    7840769     123588    7837008    7835967    7839837
> >    	7838332    7839886    7837610    7837221    7834524     407260
> >    	7430090    7835696    7839081    7712568    TLB shootdowns  
> >    
> >    4) from 'perf stat -a'
> >
> >    222371217		itlb.itlb_flush      
> >    919832520		tlb_flush.dtlb_thread
> >    372223809		tlb_flush.stlb_any   
> >    120210808042		dTLB-load-misses     
> >    979352769		dTLB-store-misses    
> >    3650767665		iTLB-load-misses     
> >
> >    -----------------------------------------
> >    v6.6-rc5 with 7e12beb8ca2a commit applied
> >    -----------------------------------------
> >
> >    1) from output of XSBench
> >
> >    Threads:     14
> >    Runtime:     1105.521 seconds
> >    Lookups:     1,700,000,000
> >    Lookups/s:   1,537,737
> >
> >    2) from /proc/vmstat
> >
> >    numa_hit 24148399
> >    numa_miss 797483
> >    numa_foreign 797483
> >    numa_interleave 772
> >    numa_local 12214575
> >    numa_other 12731307
> >    numa_pte_updates 24250278
> >    numa_hint_faults 24199756
> >    numa_hint_faults_local 0
> >    numa_pages_migrated 11476195
> >    pgmigrate_success 23634639
> >    pgmigrate_fail 1391
> >    compact_migrate_scanned 3760803
> >    compact_daemon_migrate_scanned 3760803
> >    pgdemote_kswapd 11932217
> >    pgdemote_direct 0
> >    nr_tlb_remote_flush 2151945
> >    nr_tlb_remote_flush_received 29672808
> >    nr_tlb_local_flush_all 124006
> >    nr_tlb_local_flush_one 741165
> >    
> >    3) from /proc/interrupts
> >
> >    TLB: 2130784    2120142    2117571     844962    2071766     114675
> >    	2117258    2119596    2116816    1205446    2119176    2119209
> >    	2116792    2118763    2118773    2117762    TLB shootdowns
> >
> >    4) from 'perf stat -a'
> >
> >    60851902		itlb.itlb_flush
> >    334068491		tlb_flush.dtlb_thread
> >    223732916		tlb_flush.stlb_any
> >    120207083382		dTLB-load-misses
> >    446823059		dTLB-store-misses
> >    1926669373		iTLB-load-misses
> >
> 
> Thanks a lot for test results!
> 
> >From your test results, the TLB shootdown IPI can be reduced effectively
> with commit 7e12beb8ca2a.  So that the benchmark score improved a
> little.
> 
> And, your changes will reduce the TLB shootdown IPI further, right?  Do

Yes, right. LUF(Lazy Unmap Flush) reduces TLB shootdown IPI further.

> you have the number?

You can find the number obtained from llama.cpp in this cover letter:

   https://lore.kernel.org/lkml/20240520021734.21527-1-byungchul@sk.com/

If you meant the number from the same test above, XSBench + qemu, I will
re-test with mm-unstable branch of mm tree and share the result shortly.

	Byungchul

