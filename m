Return-Path: <linux-kernel+bounces-341799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756E988664
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F632842E8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C25419DFB5;
	Fri, 27 Sep 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UWRC3DH9"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0F19C568
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444430; cv=none; b=AmZgBsI+dgdAYjBgKPr7g9j19gyxwyLhWSz7qVWeQXtdL4jXpkT5CCZHsqphDiEk8NW2fKFtn4xLIEpVxgT7Vz/z9VXUn7ntTMfGsJvxMnyUTWXF/b5sOHDztZ2xpNuMr/d0FsA2ldltvnvgd+H1rRB3IlweYD4r+HsP9ZhWd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444430; c=relaxed/simple;
	bh=5N3zChM869NvJAsIrI91Dn38areF+e2H75HhEtbDorc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6NUVWenB+ZOm0j/HX87Ulu9rhMYFeI2wirssH3I1IctUh5yjT1kRR5WVaxKSdGMEUcLN8vHTxeLjsrLqqmnbWCxANWQl3sGxhsbX3dFMtc0ZHspBFbY0nNluTXJlc98n3nuhD70+d3rlra+In63gQ3qaqSSE1iQ+LSXadN6PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UWRC3DH9; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Jzvc4wv0RcQPXQZW1rO8xT4cvgwpAtrQ8ewq6EfC3p8=;
	b=UWRC3DH9Xx55pRTrgCkvOIAx/Cu5oj6aYJHLwzdokhjKdWvK7LZfmD/IrbDafx
	4jxOqu8xx0N4E4VPVGWKRi06SlgMX3467aZRvAnmcULXaFdvTneFs2ghyYzGdeAi
	G/29p6+LNxGvNytU14L21CMKdoyeRoSs6cnPvmmQc4iMw=
Received: from [192.168.2.139] (unknown [222.131.123.228])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v99ttfZmUD4rAA--.13412S2;
	Fri, 27 Sep 2024 21:38:55 +0800 (CST)
Message-ID: <c15e2f07-5a0d-4e48-b7f4-83e4689f9299@126.com>
Date: Fri, 27 Sep 2024 21:38:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Chunxin Zang <zangchunxin@lixiang.com>, linux-kernel@vger.kernel.org,
 Chen Yu <yu.chen.surf@gmail.com>, kernel test robot <oliver.sang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
 <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v99ttfZmUD4rAA--.13412S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF47tF4kJFW7ZF47CFW3ZFb_yoW5KryUpr
	Z8KFyrtr4vg34Ivw12vws3X3W5t343J343Xr4jkF1rJ390g345tr13Kry5uF1q9rs7CFWS
	vF40qrW2kws0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrSdgUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBRnrWb2krD2NwAAsN



On 2024/9/27 14:56, Chen Yu wrote:
> Hello Honglei,
> 
> On 2024-09-27 at 09:54:28 +0800, Honglei Wang wrote:
>>
>>
>> On 2024/9/25 16:54, Chen Yu wrote:
>>> Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
>>> introduced a mechanism that a wakee with shorter slice could preempt
>>> the current running task. It also lower the bar for the current task
>>> to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
>>> when the current task has ran out of time slice. But there is a scenario
>>> that is problematic. Say, if there is 1 cfs task and 1 rt task, before
>>> 85e511df3cec, update_deadline() will not trigger a reschedule, and after
>>> 85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
>>> would happen.
>>>
>>> Some workloads (like the hackbench reported by lkp) do not like
>>> over-scheduling. We can see that the preemption rate has been
>>> increased by 2.2%:
>>>
>>> 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
>>>
>>> Restore its previous check criterion.
>>>
>>> Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
>>> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>> ---
>>> v1->v2:
>>>       Check cfs_rq->nr_running instead of rq->nr_running(K Prateek Nayak)
>>> ---
>>>    kernel/sched/fair.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 225b31aaee55..53a351b18740 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>>    	account_cfs_rq_runtime(cfs_rq, delta_exec);
>>> -	if (rq->nr_running == 1)
>>> +	if (cfs_rq->nr_running == 1)
>>>    		return;
>> Hi Yu,
>>
>> I'm wondering if commit 85e511df3cec wants to give more chances to do
>> resched just in case there are 'short slices' tasks ready in the other cfs
>> hierarchy.
>> Does something like rq->cfs->nr_running == 1 make more sense? But
>> maybe it helps less than 'cfs_rq->nr_running == 1' in this hackbench case.
>>
> 
> Thanks for taking a look.
> 
> It could be possible that Peter wanted the short tasks to preempt other quickly.
> If I understand correctly, when we say preemption, we usually consider two
> tasks which are in the same cfs_rq(level). For example, check_preempt_wakeup_fair()
> iterates the hierarchy from down-up until the current task and the wakee are in the
> same level via find_matching_se(&se, &pse), then check if the wakee can preempt the
> current. This should be consistent with the tick preemption in update_curr(). And
> whether the short task should preempt the current is checked by
> update_curr() -> did_preempt_short(), rather than checking the cfs_rq->nr_running/nr_h_running
> I suppose.
> 
Hi Yu,

Yep, I understand the preemption should happen in the same cfs level. 
Just not sure the purpose of the 'nr_running check' stuff. Perhaps its 
role is just to judge whether it’s necessary to do the preemption check. 
If there is at least one more ready (cfs) task in the rq and current is 
not eligible, we take care of the waiting tasks. Thoughts?

Thanks,
Honglei

> Thanks,
> Chenyu


