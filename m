Return-Path: <linux-kernel+bounces-533789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F51A45E91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD05188C19F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E22288C0;
	Wed, 26 Feb 2025 12:09:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CB21B9E1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571739; cv=none; b=oBiQwnNDa3RQSdmLoHIyvm7GmTPXXhSFOONcqlCs45E8wR+vZ2Mvzav3dNTmyUar76dyYH/Vvp5+2MMVW6ORcPp2snjk+3EWaFof0OxmjwagjAz6P7UWpdyyEsv6KQ8Pk4Tmbt74qF4xmK7PbiqAfouR+MnkRGt7Fwfsq4O2dNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571739; c=relaxed/simple;
	bh=NJogZQsV79ZR1bAaJz2rw3liqj943VjUyvDPHcuOrIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAiHEuDTo+Qbrkx/ZEoRt2rQOphFI4uWegis8dM2fI4MCdbCm6nvtRj8KtlIMu+XzXSiXNVyCxWO+7SEM+i1phA12v73dbZonyWZdAYnu+5DNn/62wwnLizfpF/JT7I4YDEFMxTnL3Be2oajiCcc3GuS8gh/lp7g6T3cs9kzEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D9313D5;
	Wed, 26 Feb 2025 04:09:13 -0800 (PST)
Received: from [10.1.31.40] (e127648.arm.com [10.1.31.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCFA53F5A1;
	Wed, 26 Feb 2025 04:08:53 -0800 (PST)
Message-ID: <7e3b656e-ea65-4441-b08f-062eb0501355@arm.com>
Date: Wed, 26 Feb 2025 12:08:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Prevent from cpufreq not being updated
 when delayed-task is iowait
To: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, Hongyan Xia <Hongyan.Xia2@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Luis Machado <luis.machado@arm.com>
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ke.wang@unisoc.com, di.shen@unisoc.com,
 xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
References: <20250226114301.4900-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250226114301.4900-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:43, Xuewen Yan wrote:
> Because the sched-delayed task maybe in io-wait state,
> so we should place the requeue_delayed_entity() after the
> cpufreq_update_util(), to prevent not boosting iowait cpufreq
> before return.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d6d5582c3e9..040674734128 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6931,11 +6931,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>  		util_est_enqueue(&rq->cfs, p);
>  
> -	if (flags & ENQUEUE_DELAYED) {
> -		requeue_delayed_entity(se);
> -		return;
> -	}
> -
>  	/*
>  	 * If in_iowait is set, the code below may not trigger any cpufreq
>  	 * utilization updates, so do it here explicitly with the IOWAIT flag
> @@ -6944,6 +6939,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (p->in_iowait)
>  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>  
> +	if (flags & ENQUEUE_DELAYED) {
> +		requeue_delayed_entity(se);
> +		return;
> +	}
> +
>  	if (task_new && se->sched_delayed)
>  		h_nr_runnable = 0;
>  

I understand that iowait cpufreq update isn't happening now (and that's a bug),
but if we reorder we may call cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT)
followed by the cpufreq_update_util() in update_load_avg() of 
requeue_delayed_entity()
	update_load_avg()
		cpufreq_update_util()

and the latter will likely be dropped by the governor, so the update
won't include util of the (re)-enqueuing task, right?

I'll give it some more thought.

