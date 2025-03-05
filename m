Return-Path: <linux-kernel+bounces-547029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B917A501F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670403B33BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DA24C076;
	Wed,  5 Mar 2025 14:27:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728B24C090
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184833; cv=none; b=WvxUWoZ5VaQUEOk71u4EMKuxEExcSIcGAJQmW05qXfyI2TIe9ShcMvvyN3P1GOww/ohRlCESWdtYwwANeL8hjXZ1vJ7dtO7gOQIU12M2Z6cyfcYTGHkrTrKkb/a+r2Thn0BtdlWQ8vvSgVZhHuY1PTFQEtyNYTMpKByCslKgScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184833; c=relaxed/simple;
	bh=qsV1jF6K5hiE7+KrHJQTWePl6f9rItAJ9q6KZSRbczs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+MTCMhNr6JLiSAeo8MMFDQATY8FX22flFed2GBG+yT0vWBsp4SzOl5gpC+6Ss5/2LhjbMCibZ7MDZbEGzsUmQol1LCFPZi7gqbbCumZhgx9JWYh9lnxZtl5oMaCvL8O4CJ1hUj0eEj1nqkppx2A5+lf+17miB0qKIPA9Onh954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 359251007;
	Wed,  5 Mar 2025 06:27:23 -0800 (PST)
Received: from [10.57.67.16] (unknown [10.57.67.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC11A3F673;
	Wed,  5 Mar 2025 06:27:07 -0800 (PST)
Message-ID: <bfd3f7eb-1ff3-4417-86ad-3cede437f8b3@arm.com>
Date: Wed, 5 Mar 2025 14:27:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/panthor: Replace sleep locks with spinlocks in
 fdinfo path
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250303190923.1639985-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250303190923.1639985-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/03/2025 19:08, Adrián Larumbe wrote:
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
> Fixes: 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo group samples")
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Pushed to drm-misc-next.

Note I fixed up the "Fixes" line in patch 2 to refer to the upstream
commit (434e5ca5b5d7)

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


