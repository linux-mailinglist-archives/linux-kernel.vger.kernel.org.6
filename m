Return-Path: <linux-kernel+bounces-443121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A3A9EE79B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09E51887C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548F2144AD;
	Thu, 12 Dec 2024 13:24:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0F8460;
	Thu, 12 Dec 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009889; cv=none; b=claHMtEWlr4m8V7xMZ+vDD1NmTVLl1tJFGdufCHcfvTmAiSE9N2lNIWv5wJ34uKbvo6VcGEEji82pCcik/0yLIh3q2pStFAL+tI0zvtjDha/HahLheWSHQXWDD0CFqQVPBhSM/hevpsZkGhiNEpBHNhtV9YaQMW3QmeZ2x4YIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009889; c=relaxed/simple;
	bh=AwF2HAFLChPof7herRsaFKUAK8o/hg6wRJj4JqspYgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAM+odCWof1Ek6GH3MPJ0rdGFLVobk7yChldVijZ42V7CkrdaXeYnFp/MofmOJRYod4gbA+lnVdnfMCEsdIsmIDxE+EuOXa22Wx+8d2NQ51yJjI39TDd/luiDMukvBpEar+nGt2OCtCh5RsXSJ+Uvp7bo4bpirY+RiiKLTxyfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2027153B;
	Thu, 12 Dec 2024 05:25:13 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2FD73F58B;
	Thu, 12 Dec 2024 05:24:42 -0800 (PST)
Message-ID: <79448239-86df-43ef-9a4f-717802d2c70a@arm.com>
Date: Thu, 12 Dec 2024 13:24:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by
 need_freq_update
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241212015734.41241-2-sultan@kerneltoast.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 01:57, Sultan Alsawaf wrote:
> From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> 
> A redundant frequency update is only truly needed when there is a policy
> limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> 
> In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
> frequency update _all the time_, not just for a policy limits change,
> because need_freq_update is never cleared.
> 
> Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
> to a redundant frequency update, regardless of whether or not the driver
> specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
> same as the current one.
> 
> Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> when there's a policy limits change, and clearing need_freq_update when a
> requisite redundant update occurs.
> 
> This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
> and instead setting need_freq_update to false in sugov_update_next_freq().
>

Good catch!
Fixes:
600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change")


> Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 28c77904ea74..e51d5ce730be 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  
>  	if (unlikely(sg_policy->limits_changed)) {
>  		sg_policy->limits_changed = false;
> -		sg_policy->need_freq_update = true;
> +		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);>  		return true;
>  	}
>  
> @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
>  	if (sg_policy->need_freq_update)
> -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +		sg_policy->need_freq_update = false;
>  	else if (sg_policy->next_freq == next_freq)
>  		return false;

I guess you could rewrite this into just one if like

---

	if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update))
		return false;

	sg_policy->need_freq_update = false
	sg_policy->next_freq = next_freq;
	sg_policy->last_freq_update_time = time;

