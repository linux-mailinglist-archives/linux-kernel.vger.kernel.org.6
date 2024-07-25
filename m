Return-Path: <linux-kernel+bounces-262226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5893C2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D160E1F22172
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A999199EA3;
	Thu, 25 Jul 2024 13:16:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB01990BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913397; cv=none; b=Uj8UUz5q0IF76WtSBweaCJrtOHVvoZfKGNnleYZac2rqf0raSeS1/FnsmZ6FSAlb8DDbztQdv2Jr/qWJTQkIsotURCHtiOFZC+lySao6vlAxAfdPNea4ssjxD/+lEb19D5/Eo+rryIntvIwYqECFzarDxbUNKMEiAkkaIcTy0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913397; c=relaxed/simple;
	bh=No9Ikvyi535j3hZy+Oz/VA8YfIGwVq0eSPfcg14I+bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXhiqAiG8X28e44gopos8B3Nzbyrw87UM0kJhaQo4Y4lm/C8BiG/NeTJakuTwpsPSK8KJi6TKEfGInbAb5KzXCTaprVKZrka9zudULlOKoSdAcSfB0+dh0MAk/cXNFEGZMpqzSRxF99sHyx6NfXPDgdkRTeqVRj4iNL4yufjYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93CD01007;
	Thu, 25 Jul 2024 06:16:59 -0700 (PDT)
Received: from [10.57.93.214] (unknown [10.57.93.214])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 089003F5A1;
	Thu, 25 Jul 2024 06:16:31 -0700 (PDT)
Message-ID: <38a631cf-1f6d-4d68-887a-12c7c5808ebf@arm.com>
Date: Thu, 25 Jul 2024 14:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: Use rq_clock_task() for hw_pressure
To: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20240725114200.375611-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240725114200.375611-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/07/2024 12:42, Chen Yu wrote:
> commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> removed the decay_shift for hw_pressure. While looking at a related
> bug report, it is found that this commit uses the sched_clock_task()
> in sched_tick() while replaces the sched_clock_task() with rq_clock_pelt()
> in __update_blocked_others(). This could bring inconsistence. One possible
> scenario I can think of is in ___update_load_sum():
> 
> u64 delta = now - sa->last_update_time
> 
> 'now' could be calculated by rq_clock_pelt() from
> __update_blocked_others(), and last_update_time was calculated by
> rq_clock_task() previously from sched_tick(). Usually the former chases
> after the latter, it cause a very large 'delta' and brings unexpected
> behavior. Although this should not impact x86 platform in the bug report,
> it should be fixed for other platforms.

I agree with this patch but I'm a bit confused here. May I know what you 
mean by 'should not impact x86 platform in the bug report'? But it 
closes a bug report on qemu x86_64, so it does have an impact?

> 
> Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202407091527.bb0be229-lkp@intel.com
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..cfd4755954fd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>   
>   	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>   		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -		  update_hw_load_avg(now, rq, hw_pressure) |
> +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
>   		  update_irq_load_avg(rq, 0);
>   
>   	if (others_have_blocked(rq))

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

