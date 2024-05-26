Return-Path: <linux-kernel+bounces-189893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BA8CF693
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCE3281779
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1493313A3E9;
	Sun, 26 May 2024 22:53:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751C13A3E1
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716763988; cv=none; b=WHD7rjPGKwnW0ZiDIvFwL93N7r/DnsvHeI+Fxw46Y0YLlb3lIWltIo1CP0O7Pj/wXFsyE2K3M8ESJOgfHzuYISmyPmrWGzTtQpofRbMHBfxV0Ge1wLqcBRcIWC4TDBZ1ItUeC7hUapDw+MxMx+OALG7CIy6tEb6l0vExgjuG3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716763988; c=relaxed/simple;
	bh=tOQSs2IjrzjIz5U96bfsXT4UjIsm2cCIB+R7zVNbU10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWbcvHBlAuD75ci5mfJDoh/H+XqCoPjFOpCP2Rq9yn1gelNIIVz7Fnev1DvAGudR+qgFfHHZno47aKRhuf4/VFQxgzXR0iuijVnsosGM43u4oxx/SpDVV6Wrnk2mHRbTPxYLlAGE3L2IZdT9dR4YIQz3ims0/6Ko2Y/ND3N0iU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5693339;
	Sun, 26 May 2024 15:53:30 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411AD3F641;
	Sun, 26 May 2024 15:53:04 -0700 (PDT)
Message-ID: <e308fbfc-d016-4362-998e-e4810321b53a@arm.com>
Date: Mon, 27 May 2024 00:53:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/6] Propagate negative bias
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <f60a29ac1af5098e0d37d426aec27db05d5d43e1.1715082714.git.hongyan.xia2@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <f60a29ac1af5098e0d37d426aec27db05d5d43e1.1715082714.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 14:50, Hongyan Xia wrote:
> Negative bias is interesting, because dequeuing such a task will
> actually increase utilization.
> 
> Solve by applying PELT decay to negative biases as well. This in fact
> can be implemented easily with some math tricks.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
> ---
>  kernel/sched/fair.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0177d7e8f364..7259a61e9ae5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4863,6 +4863,45 @@ static inline unsigned long task_util_est_uclamp(struct task_struct *p)
>  {
>  	return max(task_util_uclamp(p), _task_util_est_uclamp(p));
>  }
> +
> +/*
> + * Negative biases are tricky. If we remove them right away then dequeuing a
> + * uclamp_max task has the interesting effect that dequeuing results in a higher
> + * rq utilization. Solve this by applying PELT decay to the bias itself.
> + *
> + * Keeping track of a PELT-decayed negative bias is extra overhead. However, we
> + * observe this interesting math property, where y is the decay factor and p is
> + * the number of periods elapsed:
> + *
> + *	util_new = util_old * y^p - neg_bias * y^p
> + *		 = (util_old - neg_bias) * y^p
> + *
> + * Therefore, we simply subtract the negative bias from util_avg the moment we
> + * dequeue, then the PELT signal itself is the total of util_avg and the decayed
> + * negative bias, and we no longer need to track the decayed bias separately.
> + */
> +static void propagate_negative_bias(struct task_struct *p)
> +{
> +	if (task_util_bias(p) < 0 && !task_on_rq_migrating(p)) {
> +		unsigned long neg_bias = -task_util_bias(p);
> +		struct sched_entity *se = &p->se;
> +		struct cfs_rq *cfs_rq;
> +
> +		p->se.avg.util_avg_bias = 0;
> +
> +		for_each_sched_entity(se) {
> +			u32 divider, neg_sum;
> +
> +			cfs_rq = cfs_rq_of(se);
> +			divider = get_pelt_divider(&cfs_rq->avg);
> +			neg_sum = neg_bias * divider;
> +			sub_positive(&se->avg.util_avg, neg_bias);
> +			sub_positive(&se->avg.util_sum, neg_sum);
> +			sub_positive(&cfs_rq->avg.util_avg, neg_bias);
> +			sub_positive(&cfs_rq->avg.util_sum, neg_sum);
> +		}
> +	}

So you remove the 'task bias = clamp(util_avg, uclamp_min, uclamp_max) -
util_avg' from the se and cfs_rq util_avg' in case it's negative. I.e.
if the task is capped hard.

Looks like this is the old issue that PELT has blocked contribution
whereas uclamp does not (runnable only).

What's the rationale behind this? Is it because the task didn't get the
runtime it needed so we can remove this (artificially accrued) util_avg?

Normally we wouldn't remove blocked util_avg and let it rather decay
periodically for cfs_rq's and at wakeup for tasks.

[...]

