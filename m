Return-Path: <linux-kernel+bounces-538968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83374A49F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614E81899CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B735270041;
	Fri, 28 Feb 2025 16:53:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35200189B84
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761603; cv=none; b=XeeoG7I+ytkt6whAKqV5mRKmIt79t/TPH3jhD8yofIJb9DCT29qUuyHjh4C0mUsJUIYYa4B0J4z9fL2un2cFxmcycPEsjqSGsGZDOXkGaCzYs/JvVbbEwyNH3eqV/ywKSvkFTW3nv5cIiviewZz03ejES3uffSDhqb4/h9cowHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761603; c=relaxed/simple;
	bh=tgmOZUaV5HcyzBER0+xh4TbnFQgsCQx+ORmnNsm9C2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rprbj7krWusEAzOf4tfJwYG68Nfs/Vuw3l0uQ9UztHvY8mLdzKPQ9YfS0NUDByKqbcWamzoFxtw+eAEl+AgZs37hLJzlgVHe3bAuXAzM+nCBiGgS0lldN34ipOICY6f7uEd29nFfBVLTFBukJXNZ1Arl8lDdHXFdGQEYs5qeCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A83EF1515;
	Fri, 28 Feb 2025 08:53:36 -0800 (PST)
Received: from [10.1.36.17] (e122027.cambridge.arm.com [10.1.36.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 535E43F6A8;
	Fri, 28 Feb 2025 08:53:19 -0800 (PST)
Message-ID: <6218ded2-dd8b-4761-b4f3-975107a1f7c4@arm.com>
Date: Fri, 28 Feb 2025 16:53:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/panthor: Replace sleep locks with spinlocks in
 fdinfo path
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250227231628.4048738-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250227231628.4048738-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2025 23:16, Adrián Larumbe wrote:
> Commit 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo
> group samples") introduced an xarray lock to deal with potential
> use-after-free errors when accessing groups fdinfo figures. However, this
> toggles the kernel's atomic context status, so the next nested mutex lock
> will raise a warning when the kernel is compiled with mutex debug options:
> 
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_MUTEXES=y
> 
> Replace Panthor's group fdinfo data mutex with a guarded spinlock.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo group samples")

Missing "Fixes:" prefix

> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Otherwise

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 26 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 1a276db095ff..4d31d1967716 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -9,6 +9,7 @@
>  #include <drm/panthor_drm.h>
>  
>  #include <linux/build_bug.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -631,10 +632,10 @@ struct panthor_group {
>  		struct panthor_gpu_usage data;
>  
>  		/**
> -		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
> -		 * and job post-completion processing function
> +		 * @fdinfo.lock: Spinlock to govern concurrent access from drm file's fdinfo
> +		 * callback and job post-completion processing function
>  		 */
> -		struct mutex lock;
> +		spinlock_t lock;
>  
>  		/** @fdinfo.kbo_sizes: Aggregate size of private kernel BO's held by the group. */
>  		size_t kbo_sizes;
> @@ -910,8 +911,6 @@ static void group_release_work(struct work_struct *work)
>  						   release_work);
>  	u32 i;
>  
> -	mutex_destroy(&group->fdinfo.lock);
> -
>  	for (i = 0; i < group->queue_count; i++)
>  		group_free_queue(group, group->queues[i]);
>  
> @@ -2861,12 +2860,12 @@ static void update_fdinfo_stats(struct panthor_job *job)
>  	struct panthor_job_profiling_data *slots = queue->profiling.slots->kmap;
>  	struct panthor_job_profiling_data *data = &slots[job->profiling.slot];
>  
> -	mutex_lock(&group->fdinfo.lock);
> -	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
> -		fdinfo->cycles += data->cycles.after - data->cycles.before;
> -	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
> -		fdinfo->time += data->time.after - data->time.before;
> -	mutex_unlock(&group->fdinfo.lock);
> +	scoped_guard(spinlock, &group->fdinfo.lock) {
> +		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
> +			fdinfo->cycles += data->cycles.after - data->cycles.before;
> +		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
> +			fdinfo->time += data->time.after - data->time.before;
> +	}
>  }
>  
>  void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
> @@ -2880,12 +2879,11 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
>  
>  	xa_lock(&gpool->xa);
>  	xa_for_each(&gpool->xa, i, group) {
> -		mutex_lock(&group->fdinfo.lock);
> +		guard(spinlock)(&group->fdinfo.lock);
>  		pfile->stats.cycles += group->fdinfo.data.cycles;
>  		pfile->stats.time += group->fdinfo.data.time;
>  		group->fdinfo.data.cycles = 0;
>  		group->fdinfo.data.time = 0;
> -		mutex_unlock(&group->fdinfo.lock);
>  	}
>  	xa_unlock(&gpool->xa);
>  }
> @@ -3537,7 +3535,7 @@ int panthor_group_create(struct panthor_file *pfile,
>  	mutex_unlock(&sched->reset.lock);
>  
>  	add_group_kbo_sizes(group->ptdev, group);
> -	mutex_init(&group->fdinfo.lock);
> +	spin_lock_init(&group->fdinfo.lock);
>  
>  	return gid;
>  


