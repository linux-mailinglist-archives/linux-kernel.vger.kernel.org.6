Return-Path: <linux-kernel+bounces-203609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34C8FDDDE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D181F25502
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33745241E7;
	Thu,  6 Jun 2024 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="extDQOVZ"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8C17579
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649230; cv=none; b=gFrgLemfWnJwaLuayFkK6fSFh/yQBAi0yF7q4AXNBC8VtJIMHcADYKGQNxxfZ0hSsISp7oVEkyEFtMx+2T61UJ9QkSq8O47QZ/IMCFavsICGSPABtmdgOOWG4FFzlbNM6K9zXonqJnSlfhEntYdP0W3j/xCUotsw/RqiLRHy7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649230; c=relaxed/simple;
	bh=nW0O3F7QzckCStslnCVqG21lZcJ5C46Mg9S7qdrjcjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz7hRRVwMbpmJkeX5UEocy3i+fZBG2H9omY7zTOKScUubqyTS3yfUUcJElm0rB3xOZIcHHiQEB7uWovIt2EnAVG4+pOPeJPr2pvUoEdbo0OVVmKiYDXQqaD1tyyNRNToaEq498JLjbCxZ9YkkGni9Hlz8dlLH5M+tYCi84wuMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=extDQOVZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717649225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nLB6EbYrbegnA9wITWnbt4aOb9qcGFKJTII1fSGomQ=;
	b=extDQOVZpl/9ARNAyQKxODmd+M/hxCklhwtcl03lSAtLo3ObGUxnuJu4xHv3SSORnPVTuR
	D1J+k3cp5F5p3tT/nL1cT4al7bC5E174jbetvR3Qxjs72hGS1q983xDoLCI2v9A1yzKoG2
	H0Fq2bYQG0OTrdJUvHrcs6TbdEoBw8A=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: erhard_f@mailbox.org
X-Envelope-To: yuzhao@google.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: minchan@kernel.org
X-Envelope-To: vbabka@kernel.org
Message-ID: <6335c05d-9493-4b03-85a7-f2dd91db9451@linux.dev>
Date: Thu, 6 Jun 2024 12:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Erhard Furtner
 <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Minchan Kim <minchan@kernel.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
References: <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>
 <20240606043156.GC11718@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240606043156.GC11718@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/6 12:31, Sergey Senozhatsky wrote:
> On (24/06/06 10:49), Chengming Zhou wrote:
>>> Thanks for trying this out. This is interesting, so even two zpools is
>>> too much fragmentation for your use case.
>>>
>>> I think there are multiple ways to go forward here:
>>> (a) Make the number of zpools a config option, leave the default as
>>> 32, but allow special use cases to set it to 1 or similar. This is
>>> probably not preferable because it is not clear to users how to set
>>> it, but the idea is that no one will have to set it except special use
>>> cases such as Erhard's (who will want to set it to 1 in this case).
>>>
>>> (b) Make the number of zpools scale linearly with the number of CPUs.
>>> Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
>>> approach is that with a large number of CPUs, too many zpools will
>>> start having diminishing returns. Fragmentation will keep increasing,
>>> while the scalability/concurrency gains will diminish.
>>>
>>> (c) Make the number of zpools scale logarithmically with the number of
>>> CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
>>> of zpools from increasing too much and close to the status quo. The
>>> problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
>>> will actually give a nr_zpools > nr_cpus. So we will need to come up
>>> with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
>>>
>>> (d) Make the number of zpools scale linearly with memory. This makes
>>> more sense than scaling with CPUs because increasing the number of
>>> zpools increases fragmentation, so it makes sense to limit it by the
>>> available memory. This is also more consistent with other magic
>>> numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).
>>>
>>> The problem is that unlike zswap trees, the zswap pool is not
>>> connected to the swapfile size, so we don't have an indication for how
>>> much memory will be in the zswap pool. We can scale the number of
>>> zpools with the entire memory on the machine during boot, but this
>>> seems like it would be difficult to figure out, and will not take into
>>> consideration memory hotplugging and the zswap global limit changing.
>>>
>>> (e) A creative mix of the above.
>>>
>>> (f) Something else (probably simpler).
>>>
>>> I am personally leaning toward (c), but I want to hear the opinions of
>>> other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?
>>>
>>> In the long-term, I think we may want to address the lock contention
>>> in zsmalloc itself instead of zswap spawning multiple zpools.
> 
> Sorry, I'm sure I'm not following this discussion closely enough,
> has the lock contention been demonstrated/proved somehow? lock-stats?

Yosry has some stats in his commit b8cf32dc6e8c ("mm: zswap: multiple zpools support"),
and I have also seen some locking contention when using zram to test kernel building,
since zram still has only one pool.

> 
>> Agree, I think we should try to improve locking scalability of zsmalloc.
>> I have some thoughts to share, no code or test data yet:
>>
>> 1. First, we can change the pool global lock to per-class lock, which
>>    is more fine-grained.
> 
> Commit c0547d0b6a4b6 "zsmalloc: consolidate zs_pool's migrate_lock
> and size_class's locks" [1] claimed no significant difference
> between class->lock and pool->lock.

Ok, I haven't looked into the history much, that seems preparation of trying
to introduce reclaim in the zsmalloc? Not sure. But now with the reclaim code
in zsmalloc has gone, should we change back to the per-class lock? Which is
obviously more fine-grained than the pool lock. Actually, I have just done it,
will test to get some data later.

Thanks.

> 
> [1] https://lkml.kernel.org/r/20221128191616.1261026-4-nphamcs@gmail.com

