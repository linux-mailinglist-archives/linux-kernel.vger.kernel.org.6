Return-Path: <linux-kernel+bounces-209542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C2903778
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FF2888AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7D17624C;
	Tue, 11 Jun 2024 09:08:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D3173321
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096916; cv=none; b=rmQeQ/bfmr3mxXTtd5j8m5sNxXFSX0xqmq0ss9yIkADwJfMq1f1YGlj4M1FDzh1wbe8sB/2rSrSkeduJhfqaWsd7fdiPO7006igVsmMVEwswIFAuHION/0m4XR0BlpqlOWyY8aYSLG+o2DueBfcS+vwRIgYQ64ZHMzKrD1zWjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096916; c=relaxed/simple;
	bh=OVLQFBwi4QgYdNDaYc2IozUgZCW8XhCxwm2z4IDdB44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frNH4xlK1h1D33zxwYl+6jjFJ54T0r+qiY7eeXPebWlC6iFyR8uzdAhYJ6fm+NEq1Oq93b00N94h1VdEjTZJiJ5m5yh/376qZ0e5wZzMsUW7YTqeR+gVl+OWOvfJmWA7EPLQih5VtT6sFuVXNBMz2XtdPJ4ngvgXQcGVJ6LWaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B79411424;
	Tue, 11 Jun 2024 02:08:58 -0700 (PDT)
Received: from [10.1.32.59] (e127648.arm.com [10.1.32.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16823F5A1;
	Tue, 11 Jun 2024 02:08:30 -0700 (PDT)
Message-ID: <6b909593-ffc2-4fbb-b49a-143ef1fb42d7@arm.com>
Date: Tue, 11 Jun 2024 10:08:28 +0100
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
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
 qyousef@layalina.io, ke.wang@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240606070645.3295-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 08:06, Xuewen Yan wrote:
> Because the effective_cpu_util() would return a util which
> maybe bigger than the actual_cpu_capacity, this could cause
> the pd_busy_time calculation errors.
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

I can reproduce the issue and the fix, so
Tested-by: Christian Loehle <christian.loehle@arm.com>
(@Qais, this is on a non-overutilized system).
I'm unsure about the other callers of effective_cpu_util(), or rather sched_cpu_util()
in particular which includes thermal and powercap, they should be off too.
Anyway I'll try to reproduce for them too.

Kind Regards,
Christian

