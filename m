Return-Path: <linux-kernel+bounces-266998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A4940B01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A436F1C20F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707F192B8E;
	Tue, 30 Jul 2024 08:12:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8C1922C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327158; cv=none; b=GzcAq9SmQV78ZaxHq0+U+vp/4GmpclLTIb8wg73UQiCUO8hwbJGGKX6aVhe1mDeWjBBtS9PRdJIDKtT2ys99vyQdF1pvJIz98yzPuP5C6UZ73wY1l31M0zr5MxGdmxMK4+a1yNTY1mgO+tBbiJLHlzVVN1JOJ1M7PxmWSEsNgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327158; c=relaxed/simple;
	bh=q1+Lmg/USbN0t9mKGi9oS5CpuYJJ06W9U0ZYh7bQCIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2BEHAG3HXx8CSHRJLwX1R2Fxf9fxE5beZoLwgi1MGTx7sRc/oY51dd0NSU7F82trx3lHbu8FiGKUwwue0VP/i/5Ekm7uT0qtvDI3EL7+6yl06POEhol3J1EefbDbfc6kdFN0PZeSZpxTV7EHDWsexFlsKYoCvneK4jPCFuV1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F9A51007;
	Tue, 30 Jul 2024 01:13:00 -0700 (PDT)
Received: from [10.57.78.186] (unknown [10.57.78.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A0393F766;
	Tue, 30 Jul 2024 01:12:31 -0700 (PDT)
Message-ID: <ab1f7e18-c52e-4b48-9eec-90c6c71c826c@arm.com>
Date: Tue, 30 Jul 2024 09:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
 minchan@kernel.org, nphamcs@gmail.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, xiang@kernel.org, yosryahmed@google.com,
 Chuanhua Han <hanchuanhua@oppo.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org>
 <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
 <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>
 <ZqePwtX4b18wiubO@casper.infradead.org>
 <CAGsJ_4zXfYT4KxBnLx1F8tpK-5s6PX3PQ7wf7tteuzEyKS+ZPQ@mail.gmail.com>
 <ZqexmNIc00Xlwy2c@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZqexmNIc00Xlwy2c@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2024 16:13, Matthew Wilcox wrote:
> On Tue, Jul 30, 2024 at 01:11:31AM +1200, Barry Song wrote:
>> for this zRAM case, it is a new allocated large folio, only
>> while all conditions are met, we will allocate and map
>> the whole folio. you can check can_swapin_thp() and
>> thp_swap_suitable_orders().
> 
> YOU ARE DOING THIS WRONGLY!

I've only scanned the preceeding thread, but I think you're talking about the
design descision to only allocate large folios that are naturally aligned in
virtual address space, and you're arguing to remove that restriction? The main
reason we gave ourselves that constraint for anon mTHP was because allowing it
would create the possibility of wandering off the end of the PTE table and add
significant complexity to manage neighbouring PTE tables and their respective PTLs.

If the proposal is to start doing this, then I don't agree with that approach.

> 
> All of you anonymous memory people are utterly fixated on TLBs AND THIS
> IS WRONG.  Yes, TLB performance is important, particularly with crappy
> ARM designs, which I know a lot of you are paid to work on.  But you
> seem to think this is the only consideration, and you're making bad
> design choices as a result.  It's overly complicated, and you're leaving
> performance on the table.
> 
> Look back at the results Ryan showed in the early days of working on
> large anonymous folios.  Half of the performance win on his system came
> from using larger TLBs.  But the other half came from _reduced software
> overhead_. 

I would just point out that I think the results you are referring to are for the
kernel compilation workload, and yes this is indeed what I observed. But kernel
compilation is a bit of an outlier since it does a huge amount of fork/exec so
the kernel spends a lot of time fiddling with page tables and faulting. The vast
majority of the reduced sw overhead is due to significantly reducing the number
of faults because we map more pages per fault. But in my experience this
workload is a bit of an outlier; most workloads that I've tested with at least
tend to set up their memory at the start and its static forever more, which
means that those workloads benefit mostly from the TLB benefits - there are very
few existing SW overheads to actually reduce.

> The LRU lock is a huge problem, and using large folios cuts
> the length of the LRU list, hence LRU lock hold time.

I'm sure this is true and you have lots more experience and data than me. And it
makes intuitive sense. But I've never personally seen this in any of the
workloads that I've benchmarked.

Thanks,
Ryan

> 
> Your _own_ data on how hard it is to get hold of a large folio due to
> fragmentation should be enough to convince you that the more large folios
> in the system, the better the whole system runs.  We should not decline to
> allocate large folios just because they can't be mapped with a single TLB!
> 


