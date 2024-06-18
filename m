Return-Path: <linux-kernel+bounces-219802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A965090D7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8468528523D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23E524B4;
	Tue, 18 Jun 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvJYn+g/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68C4D9FB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725991; cv=none; b=lDks7QTFbZGXqfRQIMpTL7Tbvu/SnRrGQiTqEdgubiQxgVq78/gwzhxLgVR9vvIS6COcEj6SR8abM3UsVh0VVcFYNu8XMqeBczNRQ5JKXs2CHuNd19qEi8/sVT/S7MQMc1lGKnRLPfku2KvDEfbOkxRxX9XNFPI62im9rGX/wz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725991; c=relaxed/simple;
	bh=noV/t16q3ShzIWiG9+8kEBkRm2nEsjjbET+T9hmHC1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaior+JJyD1f0i4TqvT+6LPEE7YVyK0P5LSdluq7TMnt2SCsR+Ndd6AWiXUJMOIvSxlFSXG0sRQRRP7Mo7WfInhywkTB0UjT77ErZnTJinehK+Qbfmpfby87z7ASlwXvOc24LPh1m+MmEKnNC+LA9ZPKLbHOPSMmLCKk+vS6Mic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvJYn+g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033EAC3277B;
	Tue, 18 Jun 2024 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725990;
	bh=noV/t16q3ShzIWiG9+8kEBkRm2nEsjjbET+T9hmHC1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YvJYn+g/2QmHr39iPERPD/2+j/QM7uUgcwSOzzKr4dymfTAqFQxplC3dbm9+M1jfQ
	 mQz+7Fi4yGFLj0lZ8zzElvh82+iZVBnjTO2PS/S9L+7e41RSnoJp7mrCfpyg6Rsqdx
	 hDbMtuIl0lhHMPvedayAuZSfNGUS24GWT5cUUFHJwFBorw8Px969fY0AGAM39doVxm
	 lCAFRflY/gvgX4XQ/yU8dMkDthDmV3hmf9p9BpbevQn3FPh7W4OLDVFL8OnT97aSYX
	 8QEd8TViEnlC4oBzRK0s7xGyDo4om35SfI5xCYCRluXteppDwFtIqrPOpGzAO/LtEN
	 HmDn/lcr0X+Ew==
Message-ID: <c0fb8c2d-433d-4f8a-a06d-e6ca578ebbf0@kernel.org>
Date: Tue, 18 Jun 2024 17:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Yu Zhao <yuzhao@google.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <0ec3c33c-d9ff-41a5-be94-0142f103b815@kernel.org>
 <rhvafiag6fjkj66ohex3eamoqpsw62bxmwbvd7shsa72rqcile@fvo4nsggjpwg>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <rhvafiag6fjkj66ohex3eamoqpsw62bxmwbvd7shsa72rqcile@fvo4nsggjpwg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/06/2024 20.01, Shakeel Butt wrote:
> On Mon, Jun 17, 2024 at 05:31:21PM GMT, Jesper Dangaard Brouer wrote:
>>
>>
>> On 16/06/2024 02.28, Yosry Ahmed wrote:
>>> On Sat, Jun 15, 2024 at 1:13 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>>
>>>> The Meta prod is seeing large amount of stalls in memcg stats flush
>>>> from the memcg reclaim code path. At the moment, this specific callsite
>>>> is doing a synchronous memcg stats flush. The rstat flush is an
>>>> expensive and time consuming operation, so concurrent relaimers will
>>>> busywait on the lock potentially for a long time. Actually this issue is
>>>> not unique to Meta and has been observed by Cloudflare [1] as well. For
>>>> the Cloudflare case, the stalls were due to contention between kswapd
>>>> threads running on their 8 numa node machines which does not make sense
>>>> as rstat flush is global and flush from one kswapd thread should be
>>>> sufficient for all. Simply replace the synchronous flush with the
>>>> ratelimited one.
>>>>
>>
>> Like Yosry, I don't agree that simply using ratelimited flush here is
>> the right solution, at-least other options need to be investigated first.
> 
> I added more detail in my reply to Yosry on why using ratelimited flush
> for this specific case is fine.
> 
> [...]
>>>
>>> I think you already know my opinion about this one :) I don't like it
>>> at all, and I will explain why below. I know it may be a necessary
>>> evil, but I would like us to make sure there is no other option before
>>> going forward with this.
>>>
>> I'm signing up to solving this somehow, as this is a real prod issue.
>>
>> An easy way to solve the kswapd issue, would be to reintroduce
>> "stats_flush_ongoing" concept, that was reverted in 7d7ef0a4686a ("mm:
>> memcg: restore subtree stats flushing") (Author: Yosry Ahmed), and
>> introduced in 3cd9992b9302 ("memcg: replace stats_flush_lock with an
>> atomic") (Author: Yosry Ahmed).
>>
> 
> The skipping flush for "stats_flush_ongoing" was there from the start.
> 
>> The concept is: If there is an ongoing rstat flush, this time limited to
>> the root cgroup, then don't perform the flush.  We can only do this for
>> the root cgroup tree, as flushing can be done for subtrees, but kswapd
>> is always for root tree, so it is good enough to solve the kswapd
>> thundering herd problem.  We might want to generalize this beyond memcg.
>>
> 
> No objection from me for this skipping root memcg flush idea.
> 

Okay, looking into coding this up then.

>>
> [...]
>>
>>> - With the added thresholding code, a flush is only done if there is a
>>> significant number of pending updates in the relevant subtree.
>>> Choosing the ratelimited approach is intentionally ignoring a
>>> significant change in stats (although arguably it could be irrelevant
>>> stats).
>>>
>>
>> My production observations are that the thresholding code isn't limiting
>> the flushing in practice.
>>
> 
> Here we need more production data. I remember you mentioned MEMCG_KMEM
> being used for most of the updates. Is it possible to get top 5 (or 10)
> most updated stats for your production environment?
> 

Do you have a method for obtaining these stats?

Last time I used eBPF + bpftrace to extract these stats.  The high rate
these updates occur, it caused production overload situations that SRE
noticed.  So, I have to be careful when producing these stats for you.

Also could you be more specific what code lines you want stats for?


>>
>>> - Reclaim code is an iterative process, so not updating the stats on
>>> every retry is very counterintuitive. We are retrying reclaim using
>>> the same stats and heuristics used by a previous iteration,
>>> essentially dismissing the effects of those previous iterations.
>>>
>>> - Indeterministic behavior like this one is very difficult to debug if
>>> it causes problems. The missing updates in the last 2s (or whatever
>>> period) could be of any magnitude. We may be ignoring GBs of
>>> free/allocated memory. What's worse is, if it causes any problems,
>>> tracing it back to this flush will be extremely difficult.
>>>
>>
>> The 2 sec seems like a long period for me.
>>
>>> What can we do?
>>>
>>> - Try to make more fundamental improvements to the flushing code (for
>>> memcgs or cgroups in general). The per-memcg flushing thresholding is
>>> an example of this. For example, if flushing is taking too long
>>> because we are flushing all subsystems, it may make sense to have
>>> separate rstat trees for separate subsystems.
>>>
>>> One other thing we can try is add a mutex in the memcg flushing path.
>>> I had initially had this in my subtree flushing series [1], but I
>>> dropped it as we thought it's not very useful.
>>
>> I'm running an experimental kernel with rstat lock converted to mutex on
>> a number of production servers, and we have not observed any regressions.
>> The kswapd thundering herd problem also happen on these machines, but as
>> these are sleep-able background threads, it is fine to sleep on the mutex.
>>
> 
> Sorry but a global mutex which can be taken by userspace applications
> and is needed by node controller (to read stats) is a no from me. On a
> multi-tenant systems, global locks causing priority inversion is a real
> issue.
> 

The situation we have *today* with a global IRQ-disabling spin_lock is
precisely causing a priority-inversion situation always by design.
Userspace applications (reading stat file) and kswapd background
processes are currently getting higher priority than both hardware and
software interrupts. This is causing actual production issues, which is
why I'm working on this.

I do understand that changing this to a global mutex creates the
theoretical *possibility* for priority-inversion between processes with
different configured priorities.  IMHO this is better than always taking
the "big" bottom-half-lock [LWN].  I still want to lower the potential
priority-inversion issue with the mutex lock, by (1) working on lowering
the pressure on the lock (e.g. exit if flush is ongoing on root, and
e.g. add time limit on how often flush can run on sub-trees), and (2) we
will collect production metrics for lock contention and hold time (with
appropriate alerts).


[LWN] https://lwn.net/SubscriberLink/978189/5f50cab8478fac45/


>>
> [...]
>>
>> My pipe dream is that kernel can avoiding the cost of maintain the
>> cgroup threshold stats for flushing, and instead rely on a dynamic time
>> based threshold (in ms area) that have no fast-path overhead :-P
>>
> 
> Please do expand on what you mean by dynamic time based threshold.

I proposed a fixed 50 ms flush rate limiting in [2].  But I don't want
this to be a static value as it will vary on different configs and
hardware. I propose making this dynamic via measuring the time it takes
to flush the cgroup root.  This makes sense in a queuing theory context,
because this corresponds to the (longest) service time, and theory say
"a queue is formed when customers arrive faster than they can get
served". Thus, this should lower the pressure/contention on the lock,
while still allowing frequent flushing.  Hope it makes sense.

--Jesper


[2] 
https://lore.kernel.org/all/171328990014.3930751.10674097155895405137.stgit@firesoul/

