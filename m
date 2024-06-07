Return-Path: <linux-kernel+bounces-205520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A08FFD06
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD9A1F21847
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62515533E;
	Fri,  7 Jun 2024 07:19:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0215532A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744792; cv=none; b=owNQoFnw7H28HJw7PfptdFyOT/KEGNcnB42N+KoEVG6FI1LZzCGd0gN0WuzWP1mJ69Fii5laNp/r3rci6+bBs02jys3ZqtY2tSIQQNdeergi1Li+fh2AhrJ1i66AhT/nQwvNouZFpdV/upLeNobNGXQeclk2jYD/iLi/su0eBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744792; c=relaxed/simple;
	bh=Bw9UUvxhS1g2UGbV4n+unEYX2JfCdBqvgj+B5kXs/XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1avCJ2O6TNJU2gyoRA2zUVMW28s6UC/4kKubjoRpadKqfjxRO9O2JC+GOrcImdg9HyHj9zzTrSBXqPgVri5FJdIrugK+Xyo/MBxOM6aayqQv3bnVoi7oMdQ9drfLa9tsYNroYx8Iuz8AyRJDfq0gUo+wZF9EnWCOA9QC9mCJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DE42F4;
	Fri,  7 Jun 2024 00:20:07 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26AEE3F762;
	Fri,  7 Jun 2024 00:19:41 -0700 (PDT)
Message-ID: <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
Date: Fri, 7 Jun 2024 09:19:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
To: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
 qyousef@layalina.io, ke.wang@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240606070645.3295-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 09:06, Xuewen Yan wrote:
> Because the effective_cpu_util() would return a util which
> maybe bigger than the actual_cpu_capacity, this could cause
> the pd_busy_time calculation errors.

Doesn't return effective_cpu_util() either scale or min(scale, util)
with scale = arch_scale_cpu_capacity(cpu)? So the util sum over the PD
cannot exceed eenv->cpu_cap?
Looks like this was the case with 3e8c6c9aac42 already.

> So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> the actual_cpu_capacity.
> 
> Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 4 +++- 
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..8939d725023a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7870,7 +7870,9 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>  	for_each_cpu(cpu, pd_cpus) {
>  		unsigned long util = cpu_util(cpu, p, -1, 0);
>  
> -		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
> +		util = effective_cpu_util(cpu, util, NULL, NULL);
> +		util = min(eenv->cpu_cap, util);
> +		busy_time += util;
>  	}
>  
>  	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);


