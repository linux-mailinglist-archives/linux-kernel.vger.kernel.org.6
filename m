Return-Path: <linux-kernel+bounces-189351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C928CEEE8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12D1281BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B76642AB1;
	Sat, 25 May 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UqGtx/cg"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14CDF62
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716640824; cv=none; b=pOtxyIy3uekRvxnlGmo33RqtoYv/InyN+lM+iayIm2L9ShhdEwHx7WF0Q7lCb3FhDpESgkJVtrZIz5CwlE9BmA4XzbF1WPHH8MzsU66RHmq0Wt8E5mDDX5z5e61utKZfzR3nPIRCQv6Emqoq/VBm1nk/JF2w3OnqANIgCpUnrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716640824; c=relaxed/simple;
	bh=A+cFVrSlICg/+z9CZOZCE5hgVYBP/iMvRY8rbyXaEho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu5g1TcotNnuhxZW+NYK3mHXPconscH5icRA6CbAdB3w0CGbFukf7EXxJ607SAiGAnuVaAGE/mrgWZoS/LLyf8KDP/1f3Pha5LqR45uf35OzK3vVKM/LmNmrbGKD7FWun5GpduFJLOVdapA6D1Y5FrpUPrdOpkpaX1ydjG278QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UqGtx/cg; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=iIMDKrGJPpakASKV0xTj448v7VktgiX7xzeNOCg5R3E=;
	b=UqGtx/cg8aJ5LwwAThnKrdZkLKMK2/qvGMJ9fW7GbAv5cTsvsL3Tdtl/JOVask
	IRCmUe26ZBJ4MJTiPhZp42l5oceydVb/5cKje216hUD74UuFQ/26WXwhF7Lzsul0
	d3pbqJghwRIijJ5SAhnKiPqF+PMonX1Vbbj/WWj1w5sVk=
Received: from [192.168.2.139] (unknown [222.131.123.30])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3X8kR0FFmCt8yAg--.14269S2;
	Sat, 25 May 2024 19:48:35 +0800 (CST)
Message-ID: <572bef0a-727c-4922-93e9-ad29c385120e@126.com>
Date: Sat, 25 May 2024 19:48:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, yu.c.chen@intel.com, yangchen11@lixiang.com,
 zhouchunhua@lixiang.com, zangchunxin@lixiang.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
References: <20240524134011.270861-1-spring.cxz@gmail.com>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <20240524134011.270861-1-spring.cxz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X8kR0FFmCt8yAg--.14269S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1fWr15Zr1rWF1kuFyfZwb_yoWrGrWfpr
	Waq34IvFWkKw1UJ3yIyw4xuF15WF4fAa4kWF1kAFySqFsxKw15try3KFWjkrW09r4F9r4a
	qr4qg3sFk3s0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZ189UUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbi2wzprWVLaNMj2AACs-



On 2024/5/24 21:40, Chunxin Zang wrote:
> I found that some tasks have been running for a long enough time and
> have become illegal, but they are still not releasing the CPU. This
> will increase the scheduling delay of other processes. Therefore, I
> tried checking the current process in wakeup_preempt and entity_tick,
> and if it is illegal, reschedule that cfs queue.
> 
> The modification can reduce the scheduling delay by about 30% when
> RUN_TO_PARITY is enabled.
> So far, it has been running well in my test environment, and I have
> pasted some test results below.
> 
> I isolated four cores for testing. I ran Hackbench in the background
> and observed the test results of cyclictest.
> 
> hackbench -g 4 -l 100000000 &
> cyclictest --mlockall -D 5m -q
> 
>                                   EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY
> 
>                  # Min Latencies: 00006      00006      00006      00006
>    LNICE(-19)    # Avg Latencies: 00191      00122      00089      00066
>                  # Max Latencies: 15442      07648      14133      07713
> 
>                  # Min Latencies: 00006      00010      00006      00006
>    LNICE(0)      # Avg Latencies: 00466      00277      00289      00257
>                  # Max Latencies: 38917      32391      32665      17710
> 
>                  # Min Latencies: 00019      00053      00010      00013
>    LNICE(19)     # Avg Latencies: 37151      31045      18293      23035
>                  # Max Latencies: 2688299    7031295    426196     425708
> 
> I'm actually a bit hesitant about placing this modification under the
> NO_PARITY feature. This is because the modification conflicts with the
> semantics of RUN_TO_PARITY. So, I captured and compared the number of
> resched occurrences in wakeup_preempt to see if it introduced any
> additional overhead.
> 
> Similarly, hackbench is used to stress the utilization of four cores to
> 100%, and the method for capturing the number of PREEMPT occurrences is
> referenced from [1].
> 
> schedstats                          EEVDF       PATCH   EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
> stats.check_preempt_count          5053054     5057286    5003806    5018589    5031908
> stats.patch_cause_preempt_count    -------     858044     -------    765726     -------
> stats.need_preempt_count           570520      858684     3380513    3426977    1140821
> 
>  From the above test results, there is a slight increase in the number of
> resched occurrences in wakeup_preempt. However, the results vary with each
> test, and sometimes the difference is not that significant. But overall,
> the count of reschedules remains lower than that of CFS and is much less
> than that of NO_PARITY.
> 
> [1]: https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kicks-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
> 
> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
> ---
>   kernel/sched/fair.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..a0005d240db5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>   			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>   		return;
>   #endif
> +
> +	if (!entity_eligible(cfs_rq, curr))
> +		resched_curr(rq_of(cfs_rq));
>   }
>   
>   
> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>   	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>   		return;
>   
> +	if (!entity_eligible(cfs_rq, se))
> +		goto preempt;
> +
>   	find_matching_se(&se, &pse);
>   	WARN_ON_ONCE(!pse);
>   
Hi Chunxin,

Did you run a comparative test to see which modification is more helpful 
on improve the latency? Modification at tick point makes more sense to 
me. But, seems just resched arbitrarily in wakeup might introduce too 
much preemption (and maybe more context switch?) in complex environment 
such as cgroup hierarchy.

Thanks,
Honglei


