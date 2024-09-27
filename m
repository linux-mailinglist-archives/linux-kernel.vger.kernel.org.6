Return-Path: <linux-kernel+bounces-341216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D9987CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2219D283F25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33542165F0B;
	Fri, 27 Sep 2024 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="agNAQZaB"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633C139D04
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402125; cv=none; b=HJPwrUBeYAB+pfEaJ6vuErVg1GHkjzh6B5wxWwh0UQKVaNjef+k4fPATlGA0qbmDrMKUZV1gOTqLVLDhEjVKDwykgDuGIWp8euy7PUpQTKRWDiZAfzT8ETLCREw6igeszDFt6kH9zrDzSb+daXkivN7YZ+WFX9rytj0JcePdxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402125; c=relaxed/simple;
	bh=cDQruCotEAJyCf0Jm7wbw0ybbpXXugfQ50TotK412aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MReKpCJ+XYayJPKA3pSuKS+aarVvrERhzkopwucsN5h5xWbLDAnWKymfg3bWeASh4VvhWrqBTjMlxsbicQjxEO+x8mpSd/auHR5ZHEDd5l69Uf77USBi2DDYWGNvDDCQRMA0U3aqTxv+ru0qgfNDmcC4klEP9WX9QwY97yWcSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=agNAQZaB; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=gaFJTtBW6PRxpRpTe5zZRej7sGKKz+gU6gH52jzi4sY=;
	b=agNAQZaBMkqaGCj7pL9V7HsvEyVbH9RVlRwqYvEGc6RIQhJprd8+3h5ZjM3NDq
	8UY7BE7jcVSUoL/Wtc9AHdUf7BygRCOIYAX5FCsLUJ8Il0/ihPXlCrj/SvEPuJvF
	kMllwwJqSCBUlZyj8rnKWGnhEcVGSZP6pY4LANwoMhAK4=
Received: from [172.24.140.8] (unknown [111.204.182.99])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3X+xUEPZmLteTDA--.11963S2;
	Fri, 27 Sep 2024 09:54:30 +0800 (CST)
Message-ID: <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
Date: Fri, 27 Sep 2024 09:54:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
To: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Chunxin Zang <zangchunxin@lixiang.com>, linux-kernel@vger.kernel.org,
 Chen Yu <yu.chen.surf@gmail.com>, kernel test robot <oliver.sang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <20240925085440.358138-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X+xUEPZmLteTDA--.11963S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy8Wry5AryxuF4kKF1Dtrb_yoW8tFW3pF
	Z0krWrJr4vg348tw42vwsYqr98t3sxG343Kr4jk3WrXw4Yk3sayr13KFy3ZF4q9r4kCF43
	tF4jvFW2k3Z0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtpnQUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbi2wtnrWb2Bmx5aQAAsw



On 2024/9/25 16:54, Chen Yu wrote:
> Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> introduced a mechanism that a wakee with shorter slice could preempt
> the current running task. It also lower the bar for the current task
> to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> when the current task has ran out of time slice. But there is a scenario
> that is problematic. Say, if there is 1 cfs task and 1 rt task, before
> 85e511df3cec, update_deadline() will not trigger a reschedule, and after
> 85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
> would happen.
> 
> Some workloads (like the hackbench reported by lkp) do not like
> over-scheduling. We can see that the preemption rate has been
> increased by 2.2%:
> 
> 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
> 
> Restore its previous check criterion.
> 
> Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v1->v2:
>      Check cfs_rq->nr_running instead of rq->nr_running(K Prateek Nayak)
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 225b31aaee55..53a351b18740 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>   
>   	account_cfs_rq_runtime(cfs_rq, delta_exec);
>   
> -	if (rq->nr_running == 1)
> +	if (cfs_rq->nr_running == 1)
>   		return;
>  
Hi Yu,

I'm wondering if commit 85e511df3cec wants to give more chances to do 
resched just in case there are 'short slices' tasks ready in the other 
cfs hierarchy. Does something like rq->cfs->nr_running == 1 make more 
sense? But maybe it helps less than 'cfs_rq->nr_running == 1' in this 
hackbench case.


Thanks,
Honglei

>   	if (resched || did_preempt_short(cfs_rq, curr)) {


