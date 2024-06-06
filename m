Return-Path: <linux-kernel+bounces-203549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC38FDCFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61923285B16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081231DFE4;
	Thu,  6 Jun 2024 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b15hR+TW"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3881DA21
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642188; cv=none; b=ATS3HYS4fZizJgJVmmgdRJeSceYCV0nfzJprtAGnsuU+PtmFVRsVE4XqQThzWJOT/vvpTc3cD2QMzQkFpVLyMxMu/Hw5CSkjb6Hqio8N8g/PX/IlvJMptK5WeZMv2n067Q62k4F+uZuEdQMGxvIEYEf7VVh2OFPpDwqwj607FRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642188; c=relaxed/simple;
	bh=CsMmXvFWKWeEOEYDFtkrA2Y7PcHkLJp/c2+0scuW1/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXyHX8Yqj+SEgStZ8pEmtOk9L3PKQstogZsgAOmlpourmNDEJBVG3Ok0spZE8jb8fW90otJYjhllzsAuY/y7LDfMeBEdahz/pbsTOQXa/D9f3/IS69MhbCsOKCX2csDqiZ0lSBSW5A+zauWBTEOQUPnoYub0mI5QA6wYBsXbwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b15hR+TW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717642183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TRIXdZH0MFsDrtAUMxWXmV78YJWERsVBogU5sB6ock=;
	b=b15hR+TWR7d88Ppv7+DQY4gI99mEhGw5y7HNfof+KNldn8mCJBaHtegIi55tjR8gLi7Fvh
	LzjNotdZuArhnxmgbjP0qzxxvOOs2urIoOC9W/bzm/+ieKLjcNz5xptVOgnI8jeg+7zGhh
	r3/nehoX5EfkUhFIM6+BkpxU1JkFNF4=
X-Envelope-To: erhard_f@mailbox.org
X-Envelope-To: yuzhao@google.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: vbabka@kernel.org
Message-ID: <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>
Date: Thu, 6 Jun 2024 10:49:14 +0800
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
To: Yosry Ahmed <yosryahmed@google.com>, Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea>
 <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/6 07:41, Yosry Ahmed wrote:
> On Wed, Jun 5, 2024 at 4:04 PM Erhard Furtner <erhard_f@mailbox.org> wrote:
>>
>> On Tue, 4 Jun 2024 20:03:27 -0700
>> Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>>> Could you check if the attached patch helps? It basically changes the
>>> number of zpools from 32 to min(32, nr_cpus).
>>
>> Thanks! The patch does not fix the issue but it helps.
>>
>> Means I still get to see the 'kswapd0: page allocation failure' in the dmesg, a 'stress-ng-vm: page allocation failure' later on, another kswapd0 error later on, etc. _but_ the machine keeps running the workload, stays usable via VNC and I get no hard crash any longer.
>>
>> Without patch kswapd0 error and hard crash (need to power-cycle) <3min. With patch several kswapd0 errors but running for 2 hrs now. I double checked this to be sure.
> 
> Thanks for trying this out. This is interesting, so even two zpools is
> too much fragmentation for your use case.
> 
> I think there are multiple ways to go forward here:
> (a) Make the number of zpools a config option, leave the default as
> 32, but allow special use cases to set it to 1 or similar. This is
> probably not preferable because it is not clear to users how to set
> it, but the idea is that no one will have to set it except special use
> cases such as Erhard's (who will want to set it to 1 in this case).
> 
> (b) Make the number of zpools scale linearly with the number of CPUs.
> Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> approach is that with a large number of CPUs, too many zpools will
> start having diminishing returns. Fragmentation will keep increasing,
> while the scalability/concurrency gains will diminish.
> 
> (c) Make the number of zpools scale logarithmically with the number of
> CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> of zpools from increasing too much and close to the status quo. The
> problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> will actually give a nr_zpools > nr_cpus. So we will need to come up
> with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> 
> (d) Make the number of zpools scale linearly with memory. This makes
> more sense than scaling with CPUs because increasing the number of
> zpools increases fragmentation, so it makes sense to limit it by the
> available memory. This is also more consistent with other magic
> numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).
> 
> The problem is that unlike zswap trees, the zswap pool is not
> connected to the swapfile size, so we don't have an indication for how
> much memory will be in the zswap pool. We can scale the number of
> zpools with the entire memory on the machine during boot, but this
> seems like it would be difficult to figure out, and will not take into
> consideration memory hotplugging and the zswap global limit changing.
> 
> (e) A creative mix of the above.
> 
> (f) Something else (probably simpler).
> 
> I am personally leaning toward (c), but I want to hear the opinions of
> other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?
> 
> In the long-term, I think we may want to address the lock contention
> in zsmalloc itself instead of zswap spawning multiple zpools.
> 

Agree, I think we should try to improve locking scalability of zsmalloc.
I have some thoughts to share, no code or test data yet:

1. First, we can change the pool global lock to per-class lock, which
   is more fine-grained.
2. Actually, we only need to take per-zspage lock when malloc/free,
   only need to take class lock when its fullness changed.
3. If this is not enough, we can have fewer fullness groups, so the
   need to take class lock becomes fewer. (will need some test data)

More comments are welcome. Thanks!

