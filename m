Return-Path: <linux-kernel+bounces-185868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE108CBC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BD4B2146A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F197CF1A;
	Wed, 22 May 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jen7BD82"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF363BBC9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363602; cv=none; b=VMxSSzONAmTqk91Z//KH0cmVp/mYMf3eJLuPusI0XObnPx0myuIFO8t/jtPAhkp0pLek2L98aJt72BHyoGASIGmuLcVLLnyaVs5wcNkbX565bisWAZeaPMh0Slphh62EoosNYgoPN0b5scZwDM2FjAY7none2JbzETDIVk9WK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363602; c=relaxed/simple;
	bh=f3Hc/S5iPU1pxS7uFNla+UfZV6h4yjRsbFGxog9sYv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LBCuZnWtZNkQ0Ym4rzKZ4Mg/JPwKtiXxcS6YezsHF27XZE3sgmWG56yP+G+5leLpLUfHc2aDgHX9olOUWGPeoQcio08THgB6sqJ0y20noxnq3+X8mxa3YXS2sI9lrYFi6OxWZHouFKIOtQUSV/bmBDmfybixvCe2X50IwAMiuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jen7BD82; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716363600; x=1747899600;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=f3Hc/S5iPU1pxS7uFNla+UfZV6h4yjRsbFGxog9sYv4=;
  b=jen7BD82iGoyjfvIGNE260ZG3711d/ci8PvNx+bZPhaelK3YERjnnRPF
   YC9jzhxFXv07vib7g5ZdMlh1fU8E3D7YwRIEmIrWuEJn4DjThAzXlv0Hm
   /8hogKyWUSRD8ohPLl+wY1ZCnj+tsFQBNWp9usmraVRjyaq7b7Nzyrl8E
   Hb810lil2cGkM1IrdHZciv2pqTjHruoVhJNKbSWwAsJNOfFQK7TGyv0Je
   pdSsWivl/YTdluciNBvRLo+JQcoGotGD7czbad8/P9GMPXmGP30lBORo0
   e7OKTiPPYQqTbQXXZSSslSn6eg0ZxJ/RGkrybxEko7GzRoaATBVJEyCdf
   g==;
X-CSE-ConnectionGUID: 0kS6kbC8TAevHh9gTM6RsA==
X-CSE-MsgGUID: 8txdXAIVS46T1Dchv/tOGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12443457"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12443457"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:40:00 -0700
X-CSE-ConnectionGUID: 9A4E8CnSSlSCdnuTwJyWTQ==
X-CSE-MsgGUID: OdClcumTQyadA7TS7a61Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="56430458"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:39:56 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kernel_team@skhynix.com>,  <akpm@linux-foundation.org>,
  <vernhao@tencent.com>,  <mgorman@techsingularity.net>,
  <hughd@google.com>,  <willy@infradead.org>,  <david@redhat.com>,
  <peterz@infradead.org>,  <luto@kernel.org>,  <tglx@linutronix.de>,
  <mingo@redhat.com>,  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,
  <rjgolo@gmail.com>
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
In-Reply-To: <20240522021616.GA34580@system.software.com> (Byungchul Park's
	message of "Wed, 22 May 2024 11:16:16 +0900")
References: <20240510065206.76078-1-byungchul@sk.com>
	<87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240513014428.GB38851@system.software.com>
	<20240522021616.GA34580@system.software.com>
Date: Wed, 22 May 2024 15:38:04 +0800
Message-ID: <87h6eqb8kj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Byungchul,

Byungchul Park <byungchul@sk.com> writes:

> On Mon, May 13, 2024 at 10:44:29AM +0900, Byungchul Park wrote:
>> On Sat, May 11, 2024 at 03:15:01PM +0800, Huang, Ying wrote:
>> > Byungchul Park <byungchul@sk.com> writes:
>> > 
>> > > Hi everyone,
>> > >
>> > > While I'm working with a tiered memory system e.g. CXL memory, I have
>> > > been facing migration overhead esp. tlb shootdown on promotion or
>> > > demotion between different tiers.  Yeah..  most tlb shootdowns on
>> > > migration through hinting fault can be avoided thanks to Huang Ying's
>> > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
>> > > is inaccessible").  See the following link for more information:
>> > >
>> > > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
>> > 
>> > And, I still have interest of the performance impact of commit
>> > 7e12beb8ca2a ("migrate_pages: batch flushing TLB").  In the email above,
>> > you said that the performance of v6.5-rc5 + 7e12beb8ca2a reverted has
>> > better performance than v6.5-rc5.  Can you provide more details?  For
>> > example, the number of TLB flushing IPI for two kernels?
>> 
>> Okay.  I will test and share the result with what you asked me now once
>> I get available for the test.
>
> I should admit that the test using qemu is so unstable.  While using
> qemu for the test, kernel with 7e12beb8ca2a applied gave better results
> sometimes and worse ones sometimes.  I should've used a bare metal from
> the beginning.  Sorry for making you confused with the unstable result.
>
> Since I thought you asked me for the test with the same environment in
> the link above, I used qemu to reproduce the similar result but changed
> the number of threads for the test from 16 to 14 to get rid of noise
> that might be introduced by other than the intended test just in case.
>
> As expected, the stats are better with your work:
>
>    ------------------------------------------
>    v6.6-rc5 with 7e12beb8ca2a commit reverted
>    ------------------------------------------
>
>    1) from output of XSBench
>
>    Threads:     14              
>    Runtime:     1127.043 seconds
>    Lookups:     1,700,000,000   
>    Lookups/s:   1,508,371       
>
>    2) from /proc/vmstat
>
>    numa_hit 15580171                      
>    numa_miss 1034233                      
>    numa_foreign 1034233                   
>    numa_interleave 773                    
>    numa_local 7927442                     
>    numa_other 8686962                     
>    numa_pte_updates 24068923              
>    numa_hint_faults 24061125              
>    numa_hint_faults_local 0               
>    numa_pages_migrated 7426480            
>    pgmigrate_success 15407375             
>    pgmigrate_fail 1849                    
>    compact_migrate_scanned 4445414        
>    compact_daemon_migrate_scanned 4445414 
>    pgdemote_kswapd 7651061                
>    pgdemote_direct 0                      
>    nr_tlb_remote_flush 8080092            
>    nr_tlb_remote_flush_received 109915713 
>    nr_tlb_local_flush_all 53800           
>    nr_tlb_local_flush_one 770466                                                   
>    
>    3) from /proc/interrupts
>
>    TLB: 8022927    7840769     123588    7837008    7835967    7839837
>    	7838332    7839886    7837610    7837221    7834524     407260
>    	7430090    7835696    7839081    7712568    TLB shootdowns  
>    
>    4) from 'perf stat -a'
>
>    222371217		itlb.itlb_flush      
>    919832520		tlb_flush.dtlb_thread
>    372223809		tlb_flush.stlb_any   
>    120210808042		dTLB-load-misses     
>    979352769		dTLB-store-misses    
>    3650767665		iTLB-load-misses     
>
>    -----------------------------------------
>    v6.6-rc5 with 7e12beb8ca2a commit applied
>    -----------------------------------------
>
>    1) from output of XSBench
>
>    Threads:     14
>    Runtime:     1105.521 seconds
>    Lookups:     1,700,000,000
>    Lookups/s:   1,537,737
>
>    2) from /proc/vmstat
>
>    numa_hit 24148399
>    numa_miss 797483
>    numa_foreign 797483
>    numa_interleave 772
>    numa_local 12214575
>    numa_other 12731307
>    numa_pte_updates 24250278
>    numa_hint_faults 24199756
>    numa_hint_faults_local 0
>    numa_pages_migrated 11476195
>    pgmigrate_success 23634639
>    pgmigrate_fail 1391
>    compact_migrate_scanned 3760803
>    compact_daemon_migrate_scanned 3760803
>    pgdemote_kswapd 11932217
>    pgdemote_direct 0
>    nr_tlb_remote_flush 2151945
>    nr_tlb_remote_flush_received 29672808
>    nr_tlb_local_flush_all 124006
>    nr_tlb_local_flush_one 741165
>    
>    3) from /proc/interrupts
>
>    TLB: 2130784    2120142    2117571     844962    2071766     114675
>    	2117258    2119596    2116816    1205446    2119176    2119209
>    	2116792    2118763    2118773    2117762    TLB shootdowns
>
>    4) from 'perf stat -a'
>
>    60851902		itlb.itlb_flush
>    334068491		tlb_flush.dtlb_thread
>    223732916		tlb_flush.stlb_any
>    120207083382		dTLB-load-misses
>    446823059		dTLB-store-misses
>    1926669373		iTLB-load-misses
>

Thanks a lot for test results!

From your test results, the TLB shootdown IPI can be reduced effectively
with commit 7e12beb8ca2a.  So that the benchmark score improved a
little.

And, your changes will reduce the TLB shootdown IPI further, right?  Do
you have the number?

--
Best Regards,
Huang, Ying

