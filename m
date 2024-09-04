Return-Path: <linux-kernel+bounces-315678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46696C5B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92251F25AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292741DFE1A;
	Wed,  4 Sep 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ehwnOzR7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5C1DEFF2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472047; cv=none; b=alcN10kHhYGRtm7nCcgaxTXWgJJfPTcJHiiYgJZ/I7gMwKmZkPzI8Ws5WXXzf1aPO88x+OXFxoafN+4cq+XbG/WlCrKfcjKVjRLqikusZnd+DCfQoAQTbhbdjKVM5c6TpXgUDE8IqyULQTIDFGSrFrTcsS/qsXMwtEWS1QaLfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472047; c=relaxed/simple;
	bh=FrCTyMpDj3SCWGRs519+WiyBPOW5cdUM3QKEcU8omnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZYqm/9kJqQ2Dl5Wy+NrRWaUr0fwrH95nl1t+Du+t7ECcyFCP8n6HXbdmxqEe77mdabuYiXdiPEISMOZWTzuqFSW/HXMTB67Ve7WSUFq2nDHk7KslQDZekQpt/DkqIiamBOfionZbE0m7jMnhbMT/YDwsmvpF6zGNJRhXhH2KmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ehwnOzR7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so49041755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1725472042; x=1726076842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g0+DHUE+OUpJrZw/tw/EuKm9P0V302ne/WHUmgYLGs=;
        b=ehwnOzR7Jle902IdSbU3GjPx6Oicy5WtIc4RnR+WfqyGj3xpYdVIKGSArDwerI4J/C
         ftudHCHp0Mm/kn2ZgSg8vHvkCI1FQe3T48no7IsQ/4ej0QioxgNCy/nUchc7gvwa+xq1
         1EKRt56kmeZsW2lcDkvRYV5R/YVUHLfnCuhA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472042; x=1726076842;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8g0+DHUE+OUpJrZw/tw/EuKm9P0V302ne/WHUmgYLGs=;
        b=nK7uCzk3qD0mM2ZA38YIWdt5w9WJy+aiJoY9bx9epDLUa0mxtfk+e6OjfyuVaEYEAT
         EeghAQZ1RNk0lkte1pF7tNOA31JqNxcaGFT+E3kK3IlG3hiqAwpDHDLdp7veYlYqJvN2
         30nuRzRvY7XI9HDaz3GFSQhoWgnXdAP8SU8egLnrM1s9TJc1U3AlhXcMvK6At+THeFSf
         pSqkQGYbUSB2B8nuZeRYsy5pohX4N1FRCeTcXZc2iMEVifY0VXcMoJ0obfgHBqv9Pq4w
         zLS0/U9lsWs883dxHoKhr/CyWIai4ZoO9cjrRON+7tdMDQFThnDcb09ZUjYYxGaKdJXI
         Ng/g==
X-Forwarded-Encrypted: i=1; AJvYcCXHnUzdi+RX4LYuCov+TtXvMuUvMGM75H8aFgGF32XQoLYXBhveEz84xung4370HMTRQlLM3zQJ7MuFt2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+gJxiz+SLBIa46HI414As9SA28Sw5Sruyl+VsxHkEXZVuIJu
	WDi5+ZIPVPmSa8eA6xwoqkoZCM4Um+GsVMXLh9OIhE+/djbwDTHrL3kgfV5mVNE=
X-Google-Smtp-Source: AGHT+IG9N7mF2lwL90P0lf9F2pLe6fmACORF/uZLvQdUsO9j+qwCmQXHTNh6Ppj1N5/V+kkq7nUj7A==
X-Received: by 2002:adf:e406:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-374c1c54c23mr11008410f8f.32.1725472042097;
        Wed, 04 Sep 2024 10:47:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ce8bbeacsm7686756f8f.92.2024.09.04.10.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:47:21 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:47:19 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: [RFC PATCH] drm/sched: Fix teardown leaks with waitqueue
Message-ID: <ZtidJ8S9THvzkQ-6@phenom.ffwll.local>
Mail-Followup-To: Philipp Stanner <pstanner@redhat.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
References: <20240903094446.29797-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903094446.29797-2-pstanner@redhat.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Tue, Sep 03, 2024 at 11:44:47AM +0200, Philipp Stanner wrote:
> The GPU scheduler currently does not ensure that its pending_list is
> empty before performing various other teardown tasks in
> drm_sched_fini().
> 
> If there are still jobs in the pending_list, this is problematic because
> after scheduler teardown, no one will call backend_ops.free_job()
> anymore. This would, consequently, result in memory leaks.
> 
> One way to solves this is to implement a waitqueue that drm_sched_fini()
> blocks on until the pending_list has become empty.
> 
> Add a waitqueue to struct drm_gpu_scheduler. Wake up waiters once the
> pending_list becomes empty. Wait in drm_sched_fini() for that to happen.
> 
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Hi all,
> 
> since the scheduler has many stake holders, I want this solution
> discussed as an RFC first.
> 
> This version here has IMO the advantage (and disadvantage...) that it
> blocks infinitly if the driver messed up the clean up, so problems
> might become more visible than the refcount solution I proposed in
> parallel.

Very quick comment because I'm heading out for the r4l conference, but
maybe I can discuss this there with Danilo a bit.

Maybe we should do step 0 first, and document the current rules? The
kerneldoc isn't absolute zero anymore, but it's very, very bare-bones.
Then get that acked and merged, which is a very good way to make sure
we're actually standing on common ground.

Then maybe step 0.5 would be to add runtime asserts to enforce the rules,
like if you tear down the scheduler and there's stuff in flight, you splat
on a WARN_ON.

With that foundation there should be a lot clearer basis to discuss
whether there is an issue, and what a better design could look like. The
little pondering I've done I've come up with a few more ideas along
similar lines.

One comment below, kinda unrelated.

> 
> Cheers,
> P.
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 40 ++++++++++++++++++++++++++
>  include/drm/gpu_scheduler.h            |  4 +++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 7e90c9f95611..200fa932f289 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -564,6 +564,13 @@ static void drm_sched_job_timedout(struct work_struct *work)
>  		 * is parked at which point it's safe.
>  		 */
>  		list_del_init(&job->list);
> +
> +		/*
> +		 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
> +		 */
> +		if (list_empty(&sched->pending_list))
> +			wake_up(&sched->job_list_waitque);
> +
>  		spin_unlock(&sched->job_list_lock);
>  
>  		status = job->sched->ops->timedout_job(job);
> @@ -584,6 +591,15 @@ static void drm_sched_job_timedout(struct work_struct *work)
>  		drm_sched_start_timeout_unlocked(sched);
>  }
>  
> +static bool drm_sched_no_jobs_pending(struct drm_gpu_scheduler *sched)
> +{
> +	/*
> +	 * For list_empty() to work without a lock.
> +	 */

So this is pretty far from the gold standard for documenting memory
barrier semantics in lockless code. Ideally we have a comment for both
sides of the barrier (you always need two, or there's no function
barrier), pointing at each another, and explaining exactly what's being
synchronized against what and how.

I did years ago add a few missing barriers with that approach, see
b0a5303d4e14 ("drm/sched: Barriers are needed for
entity->last_scheduled"). Reading that patch again it feels a bit on the
terse side of things (plus I noticed spelling issues now too, oops).

Cheers, Sima

> +	rmb();
> +	return list_empty(&sched->pending_list);
> +}
> +
>  /**
>   * drm_sched_stop - stop the scheduler
>   *
> @@ -659,6 +675,12 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
>  		}
>  	}
>  
> +	/*
> +	 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
> +	 */
> +	if (drm_sched_no_jobs_pending(sched))
> +		wake_up(&sched->job_list_waitque);
> +
>  	/*
>  	 * Stop pending timer in flight as we rearm it in  drm_sched_start. This
>  	 * avoids the pending timeout work in progress to fire right away after
> @@ -1085,6 +1107,12 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
>  		/* remove job from pending_list */
>  		list_del_init(&job->list);
>  
> +		/*
> +		 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
> +		 */
> +		if (list_empty(&sched->pending_list))
> +			wake_up(&sched->job_list_waitque);
> +
>  		/* cancel this job's TO timer */
>  		cancel_delayed_work(&sched->work_tdr);
>  		/* make the scheduled timestamp more accurate */
> @@ -1303,6 +1331,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>  	init_waitqueue_head(&sched->job_scheduled);
>  	INIT_LIST_HEAD(&sched->pending_list);
>  	spin_lock_init(&sched->job_list_lock);
> +	init_waitqueue_head(&sched->job_list_waitque);
>  	atomic_set(&sched->credit_count, 0);
>  	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
>  	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
> @@ -1333,12 +1362,23 @@ EXPORT_SYMBOL(drm_sched_init);
>   * @sched: scheduler instance
>   *
>   * Tears down and cleans up the scheduler.
> + *
> + * Note that this function blocks until the fences returned by
> + * backend_ops.run_job() have been signalled.
>   */
>  void drm_sched_fini(struct drm_gpu_scheduler *sched)
>  {
>  	struct drm_sched_entity *s_entity;
>  	int i;
>  
> +	/*
> +	 * Jobs that have neither been scheduled or which have timed out are
> +	 * gone by now, but jobs that have been submitted through
> +	 * backend_ops.run_job() and have not yet terminated are still pending.
> +	 *
> +	 * Wait for the pending_list to become empty to avoid leaking those jobs.
> +	 */
> +	wait_event(sched->job_list_waitque, drm_sched_no_jobs_pending(sched));
>  	drm_sched_wqueue_stop(sched);
>  
>  	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 5acc64954a88..bff092784405 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -29,6 +29,7 @@
>  #include <linux/completion.h>
>  #include <linux/xarray.h>
>  #include <linux/workqueue.h>
> +#include <linux/wait.h>
>  
>  #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
>  
> @@ -503,6 +504,8 @@ struct drm_sched_backend_ops {
>   *            timeout interval is over.
>   * @pending_list: the list of jobs which are currently in the job queue.
>   * @job_list_lock: lock to protect the pending_list.
> + * @job_list_waitque: a waitqueue for drm_sched_fini() to block on until all
> + *		      pending jobs have been finished.
>   * @hang_limit: once the hangs by a job crosses this limit then it is marked
>   *              guilty and it will no longer be considered for scheduling.
>   * @score: score to help loadbalancer pick a idle sched
> @@ -532,6 +535,7 @@ struct drm_gpu_scheduler {
>  	struct delayed_work		work_tdr;
>  	struct list_head		pending_list;
>  	spinlock_t			job_list_lock;
> +	wait_queue_head_t		job_list_waitque;
>  	int				hang_limit;
>  	atomic_t                        *score;
>  	atomic_t                        _score;
> -- 
> 2.46.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

