Return-Path: <linux-kernel+bounces-217858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2690B772
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEB8B3C876
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17C6BFAA;
	Mon, 17 Jun 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta5Y4+ko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2310958
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638287; cv=none; b=olmaDd34adfAJTVuabsoljZ1X6rm9xLM3lquMaeDusKsZ2I2P+7o7ufM56OKngR+Z15xkZw4bVdxzDfsNwWlZTqlhFUNWsWzpxtik9TxWVs4p5amdbtoIxacCP4QsMa+xu0gGzAhbjm1ETF2a5JKnt862Fo433PMAcAJB8+jFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638287; c=relaxed/simple;
	bh=Z5ps00j25+f+pCZjGF86QTTkz8HWyZ02cBh3yfxWmhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S23KEsJTtGQnX/qwMUY6HejRrSyMd0BaAih5LgDf/JIt3qCyUmSHkYG7FghtNha2H8VH2H9W0/YAfpCZqctC6kV8I0Pi+5lc6N76rJY4+5hJjvD4fMxoMScoLZXULcGJmWraTcdkwwqSRKDQLzpVADq07F68iI8YsWYSaeH+2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta5Y4+ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5184FC2BD10;
	Mon, 17 Jun 2024 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638287;
	bh=Z5ps00j25+f+pCZjGF86QTTkz8HWyZ02cBh3yfxWmhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ta5Y4+koI5rW+dIlyFdKGImyhjonlrcrk8CoLEmNQdPcxgbDxGx8M0jQA+heQWx5v
	 D2PKsfPOwSwoF2YlxhFTT5iBZ9tcCp0JeDPsEOO2/nvW/q25eIQQaBj9eDNukU2xEh
	 9uA2EJu2sd0h9NZPZsD14QqMBdxTlvnToebZLk2dr47/slInhFCEXXGbRUr7UWZdQG
	 Fx8spvxgPMVQlQABxAUAOs0Q5ex+T+xe7402bCGi7AYjiPxydOZYgyYGM33p2Xi/1r
	 5VXxF6CJ0ca4WqUk6FDcI/L41zv4SONLcosNINgvIFmwOL8C4XYhsWRYHWd4NADscb
	 U/+5oSah9m0nA==
Message-ID: <0ec3c33c-d9ff-41a5-be94-0142f103b815@kernel.org>
Date: Mon, 17 Jun 2024 17:31:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Yosry Ahmed <yosryahmed@google.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Yu Zhao <yuzhao@google.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/06/2024 02.28, Yosry Ahmed wrote:
> On Sat, Jun 15, 2024 at 1:13 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> The Meta prod is seeing large amount of stalls in memcg stats flush
>> from the memcg reclaim code path. At the moment, this specific callsite
>> is doing a synchronous memcg stats flush. The rstat flush is an
>> expensive and time consuming operation, so concurrent relaimers will
>> busywait on the lock potentially for a long time. Actually this issue is
>> not unique to Meta and has been observed by Cloudflare [1] as well. For
>> the Cloudflare case, the stalls were due to contention between kswapd
>> threads running on their 8 numa node machines which does not make sense
>> as rstat flush is global and flush from one kswapd thread should be
>> sufficient for all. Simply replace the synchronous flush with the
>> ratelimited one.
>>

Like Yosry, I don't agree that simply using ratelimited flush here is
the right solution, at-least other options need to be investigated first.

I can confirm that at Cloudflare, we are seeing massive issues due
kswapd and to this specific mem_cgroup_flush_stats() call inlined in
shrink_node, taking the rstat lock. I looked at our 12 numa node
machines, given kswapd have a kthread per NUMA node, and realized the
issue is much worse on these servers, as lock contention on rstat lock
happens more frequently, where 12 CPUs waste cycles on spinning every
time kswapd runs.  We added fleet wide stats (/proc/N/schedstat) for
kthreads, and realized we are on fleet wide average burning 20.000 CPU
cores on kswapd, that primarily spins on rstat lock.

Try to run this command to see kswapd CPU usage spikes:
   $ pidstat -u -C kswapd 1 60

Code wise: when the Per-CPU-Pages (PCP) freelist is empty,
__alloc_pages_slowpath calls wake_all_kswapds(), this cause wakeup calls
to all the kswapdN threads simultaneously. The kswapd thread will invoke
shrink_node, which as explained trigger the cgroup rstat flush operation
as part of its work. Thus, effectively the kernel's own memory
management processes triggers self-inflicted rstat lock contention, by
waking up all kswapd threads simultaneously.

So, we definitely need a solution to this issue!
(... more ideas below inlined as comments to Yosry)

>> One may raise a concern on potentially using 2 sec stale (at worst)
>> stats for heuristics like desirable inactive:active ratio and preferring
>> inactive file pages over anon pages but these specific heuristics do not
>> require very precise stats and also are ignored under severe memory
>> pressure. This patch has been running on Meta fleet for more than a
>> month and we have not observed any issues. Please note that MGLRU is not
>> impacted by this issue at all as it avoids rstat flushing completely.
>>
>> Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org [1]
>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
>>   mm/vmscan.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index c0429fd6c573..bda4f92eba71 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2263,7 +2263,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>>           * Flush the memory cgroup stats, so that we read accurate per-memcg
>>           * lruvec stats for heuristics.
>>           */
>> -       mem_cgroup_flush_stats(sc->target_mem_cgroup);
>> +       mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);
> 
> I think you already know my opinion about this one :) I don't like it
> at all, and I will explain why below. I know it may be a necessary
> evil, but I would like us to make sure there is no other option before
> going forward with this.
> 
I'm signing up to solving this somehow, as this is a real prod issue.

An easy way to solve the kswapd issue, would be to reintroduce
"stats_flush_ongoing" concept, that was reverted in 7d7ef0a4686a ("mm:
memcg: restore subtree stats flushing") (Author: Yosry Ahmed), and
introduced in 3cd9992b9302 ("memcg: replace stats_flush_lock with an
atomic") (Author: Yosry Ahmed).

The concept is: If there is an ongoing rstat flush, this time limited to
the root cgroup, then don't perform the flush.  We can only do this for
the root cgroup tree, as flushing can be done for subtrees, but kswapd
is always for root tree, so it is good enough to solve the kswapd
thundering herd problem.  We might want to generalize this beyond memcg.


> Unfortunately, I am travelling this week, so I probably won't be able
> to follow up on this for a week or so, but I will try to lay down my
> thoughts as much as I can.
> 
> Why don't I like this?
> 
> - From a high level, I don't like the approach of replacing
> problematic flushing calls with the ratelimited version. It strikes me
> as a whac-a-mole approach that is mitigating symptoms of a larger
> problem.
> 

This also looks like a whac-a-mole approach to me.

I'm not directly against rate-limited flushing, but I do think the 2 sec
interval is too long. IMHO we should be able to have a smaller bound in
the ms area.

Like I proposed 50 ms flush rate limiting in [2]
  [2] 
https://lore.kernel.org/all/171328990014.3930751.10674097155895405137.stgit@firesoul/


> - With the added thresholding code, a flush is only done if there is a
> significant number of pending updates in the relevant subtree.
> Choosing the ratelimited approach is intentionally ignoring a
> significant change in stats (although arguably it could be irrelevant
> stats).
> 

My production observations are that the thresholding code isn't limiting
the flushing in practice.


> - Reclaim code is an iterative process, so not updating the stats on
> every retry is very counterintuitive. We are retrying reclaim using
> the same stats and heuristics used by a previous iteration,
> essentially dismissing the effects of those previous iterations.
> 
> - Indeterministic behavior like this one is very difficult to debug if
> it causes problems. The missing updates in the last 2s (or whatever
> period) could be of any magnitude. We may be ignoring GBs of
> free/allocated memory. What's worse is, if it causes any problems,
> tracing it back to this flush will be extremely difficult.
> 

The 2 sec seems like a long period for me.

> What can we do?
> 
> - Try to make more fundamental improvements to the flushing code (for
> memcgs or cgroups in general). The per-memcg flushing thresholding is
> an example of this. For example, if flushing is taking too long
> because we are flushing all subsystems, it may make sense to have
> separate rstat trees for separate subsystems.
> 
> One other thing we can try is add a mutex in the memcg flushing path.
> I had initially had this in my subtree flushing series [1], but I
> dropped it as we thought it's not very useful. 

I'm running an experimental kernel with rstat lock converted to mutex on
a number of production servers, and we have not observed any regressions.
The kswapd thundering herd problem also happen on these machines, but as
these are sleep-able background threads, it is fine to sleep on the mutex.


> Currently in
> mem_cgroup_flush_stats(), we check if there are enough pending updates
> to flush, then we call cgroup_flush_stats() and spin on the lock. It
> is possible that while we spin, those pending updates we observed have
> been flushed. If we add back the mutex like in [1], then once we
> acquire the mutex we check again to make sure there are still enough
> stats to flush.
> 

It is a good point to re-check after obtaining the lock, as things could
have changed in the intermediate period when waiting for the lock. This
is also done (for time) in my 50 ms flush rate limit patch [1] ;-)


> [1]https://lore.kernel.org/all/20231010032117.1577496-6-yosryahmed@google.com/
> 
> - Try to avoid the need for flushing in this path. I am not sure what
> approach MGLRU uses to avoid the flush, but if we can do something
> similar for classic LRUs that would be preferable. I am guessing MGLRU
> may be maintaining its own stats outside of the rstat framework.
> 
> - Try to figure out if one (or a few) update paths are regressing all
> flushers. If one specific stat or stats update path is causing most of
> the updates, we can try to fix that instead. Especially if it's a
> counter that is continuously being increased and decreases (so the net
> change is not as high as we think).
> 
> At the end of the day, all of the above may not work, and we may have
> to live with just using the ratelimited approach. But I *really* hope
> we could actually go the other way. Fix things on a more fundamental
> level and eventually drop the ratelimited variants completely.
>

My pipe dream is that kernel can avoiding the cost of maintain the
cgroup threshold stats for flushing, and instead rely on a dynamic time
based threshold (in ms area) that have no fast-path overhead :-P


> Just my 2c. Sorry for the long email :)

Appreciate your input a lot! :-)

--Jesper

