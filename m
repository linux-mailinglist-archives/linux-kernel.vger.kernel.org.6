Return-Path: <linux-kernel+bounces-521961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E25CA3C459
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E9A170ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F731FCCF5;
	Wed, 19 Feb 2025 15:59:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF01F8AE5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980779; cv=none; b=AE3lgYpnN+CK+TcNoul6aL8Pf5vrEXC7tyFzQniuo3PZX778snuMCLcV9ccKojoRONmYghYW5Xfr38Gv+qW4P+FD01v3Xc9qnj46h26Ra8pnQnDeFX/am12FTzg1qZJmfQ05tebtqtPexrtUT6usKxY27z7KuSDNo7n7o5csT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980779; c=relaxed/simple;
	bh=EytW1lFPKATO0gNl3E/Jw87TvBaSDCpj51b4vRxBcCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJCWV0da4C/K6qSiTibmyi1HWikVU4CPlNwZKjRO56n5n/QrFoEizyLOz39rXNqJ8yxS1I8bOBFwJKe+lEEBzGcVA6Y6f9rhT/nqrzIp+A/rsaEPLpIvpEgt1NKN9BZUlUHdDW8xlEp0SIygdAlOtAhct0DetuVqitWRJWygNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3291682;
	Wed, 19 Feb 2025 07:59:54 -0800 (PST)
Received: from [10.1.35.44] (e127648.arm.com [10.1.35.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0893B3F6A8;
	Wed, 19 Feb 2025 07:59:32 -0800 (PST)
Message-ID: <5ff60151-cb77-46b7-ad52-813981c99d26@arm.com>
Date: Wed, 19 Feb 2025 15:59:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, hongyan.xia2@arm.com,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250219093747.2612-1-xuewen.yan@unisoc.com>
 <20250219093747.2612-2-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250219093747.2612-2-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 09:37, Xuewen Yan wrote:
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and this operation would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.
> And to make the code more concise, add a helper function to encapsulate
> this and use it everywhere we enable sched_uclamp_used.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> V2:
> - change some commit message;
> - Add a helper function and use it everywhere when enable uclamp (Vincent)
> ---
> ---
>  kernel/sched/core.c     |  6 +++---
>  kernel/sched/sched.h    | 14 ++++++++++++++
>  kernel/sched/syscalls.c |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 38a7192bfc19..0466a2f61b99 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1942,12 +1942,12 @@ static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
>  	}
>  
>  	if (update_root_tg) {
> -		static_branch_enable(&sched_uclamp_used);
> +		sched_uclamp_enable();
>  		uclamp_update_root_tg();
>  	}
>  
>  	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
> -		static_branch_enable(&sched_uclamp_used);
> +		sched_uclamp_enable();
>  		uclamp_sync_util_min_rt_default();
>  	}
>  
> @@ -9295,7 +9295,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>  	if (req.ret)
>  		return req.ret;
>  
> -	static_branch_enable(&sched_uclamp_used);
> +	sched_uclamp_enable();
>  
>  	guard(mutex)(&uclamp_mutex);
>  	guard(rcu)();
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3624fdce5536..bd22af347d0b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3407,6 +3407,18 @@ static inline bool uclamp_is_used(void)
>  	return static_branch_likely(&sched_uclamp_used);
>  }
>  
> +/*
> + * Enabling static branches would get the cpus_read_lock(),
> + * check whether uclamp_is_used before enable it to avoid always
> + * calling cpus_read_lock(). Because we never disable this
> + * static key once enable it.
> + */
> +static inline void sched_uclamp_enable(void)
> +{
> +	if (!uclamp_is_used())
> +		static_branch_enable(&sched_uclamp_used);
> +}
> +
Reviewed-by 
>  static inline unsigned long uclamp_rq_get(struct rq *rq,
>  					  enum uclamp_id clamp_id)
>  {
> @@ -3486,6 +3498,8 @@ static inline bool uclamp_is_used(void)
>  	return false;
>  }
>  
> +static inline void sched_uclamp_enable(void) {}
> +
>  static inline unsigned long
>  uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
>  {
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 456d339be98f..9100a77e9d79 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -368,7 +368,7 @@ static int uclamp_validate(struct task_struct *p,
>  	 * blocking operation which obviously cannot be done while holding
>  	 * scheduler locks.
>  	 */
> -	static_branch_enable(&sched_uclamp_used);
> +	sched_uclamp_enable();
>  
>  	return 0;
>  }

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

