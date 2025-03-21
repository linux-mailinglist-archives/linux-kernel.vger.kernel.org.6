Return-Path: <linux-kernel+bounces-571564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6BA6BECF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48D41883810
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D622D4E1;
	Fri, 21 Mar 2025 15:52:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233622B8D0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572373; cv=none; b=bgxg0In0VSMcGZBBZN7dF5k5QOxbhfcHNAlOror7AaV9Ihk2l6beBRcvLG39oxhXsteYpKsvwfcwaEX3TvDjlXoRlaoz31IXwpuIUPtoZIMAoKEg5Bvl9CwXn4erlUjHqkKbpcsZPi5AcoknhA4QK0VWjLvfxynLoFZ0QZPbKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572373; c=relaxed/simple;
	bh=S2Lexy7iweDC3nyAxWBUtLbH/6qyyAH3IcFe5+vb0dU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9qn0CLzLXkb9mKBYsCtPGxgXeSFPy4AxI7utU331pQUcjsR5h4oI7ukrVVqNOT1dKdW1unDmWK9Vhc+RdIOrVgth8Ap7CBAp3Gzeq0LbJl1iSTclS6mlljP2sAuu0qfQ0BdbYDLx0pl5N9D2IjgzE1dxA+4legqtM1n/3LWTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK6KK5w52z6L55F;
	Fri, 21 Mar 2025 23:47:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CFF414080C;
	Fri, 21 Mar 2025 23:52:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 16:52:45 +0100
Date: Fri, 21 Mar 2025 15:52:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
Message-ID: <20250321155244.00006338@huawei.com>
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Mar 2025 19:30:15 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Introduction:
> =============
> In the current hot page promotion, all the activities including the
> process address space scanning, NUMA hint fault handling and page
> migration is performed in the process context. i.e., scanning overhead is
> borne by applications.
> 
> This is RFC V1 patch series to do (slow tier) CXL page promotion.
> The approach in this patchset assists/addresses the issue by adding PTE
> Accessed bit scanning.
> 
> Scanning is done by a global kernel thread which routinely scans all
> the processes' address spaces and checks for accesses by reading the
> PTE A bit. 
> 
> A separate migration thread migrates/promotes the pages to the toptier
> node based on a simple heuristic that uses toptier scan/access information
> of the mm.
> 
> Additionally based on the feedback for RFC V0 [4], a prctl knob with
> a scalar value is provided to control per task scanning.
> 
> Initial results show promising number on a microbenchmark. Soon
> will get numbers with real benchmarks and findings (tunings). 
> 
> Experiment:
> ============
> Abench microbenchmark,
> - Allocates 8GB/16GB/32GB/64GB of memory on CXL node
> - 64 threads created, and each thread randomly accesses pages in 4K
>   granularity.

So if I'm reading this right, this is a flat distribution and any
estimate of what is hot is noise?

That will put a positive spin on costs of migration as we will
be moving something that isn't really all that hot and so is moderately
unlikely to be accessed whilst migration is going on.  Or is the point that
the rest of the memory is also mapped but not being accessed?

I'm not entirely sure I follow what this is bound by. Is it bandwidth
bound?


> - 512 iterations with a delay of 1 us between two successive iterations.
> 
> SUT: 512 CPU, 2 node 256GB, AMD EPYC.
> 
> 3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>
> 
> Calculates how much time is taken to complete the task, lower is better.
> Expectation is CXL node memory is expected to be migrated as fast as
> possible.

> 
> Base case: 6.14-rc6    w/ numab mode = 2 (hot page promotion is enabled).
> patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
> we expect daemon to do page promotion.
> 
> Result:
> ========
>          base NUMAB2                    patched NUMAB1
>          time in sec  (%stdev)   time in sec  (%stdev)     %gain
>  8GB     134.33       ( 0.19 )        120.52  ( 0.21 )     10.28
> 16GB     292.24       ( 0.60 )        275.97  ( 0.18 )      5.56
> 32GB     585.06       ( 0.24 )        546.49  ( 0.35 )      6.59
> 64GB    1278.98       ( 0.27 )       1205.20  ( 2.29 )      5.76
> 
> Base case: 6.14-rc6    w/ numab mode = 1 (numa balancing is enabled).
> patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>          base NUMAB1                    patched NUMAB1
>          time in sec  (%stdev)   time in sec  (%stdev)     %gain
>  8GB     186.71       ( 0.99 )        120.52  ( 0.21 )     35.45 
> 16GB     376.09       ( 0.46 )        275.97  ( 0.18 )     26.62 
> 32GB     744.37       ( 0.71 )        546.49  ( 0.35 )     26.58 
> 64GB    1534.49       ( 0.09 )       1205.20  ( 2.29 )     21.45

Nice numbers, but maybe some more details on what they are showing?
At what point in the workload has all the memory migrated to the
fast node or does that never happen?

I'm confused :(

Jonathan



