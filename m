Return-Path: <linux-kernel+bounces-559165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EAA5F049
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D7E173D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790B26462C;
	Thu, 13 Mar 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Kb7ZDcoN"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4224EF69
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860514; cv=none; b=JWt1FFu8VxrX35XghF5sqWAN/aCLrFlbJf1dK/aKLzIWen3gTdwdtM02I6pxEhS3cyObXF6hQt8RK615sPaFl+FbVdrrm9pwRr7KMf0QmspWCki81qLiesdJwcr7lon/Kiyn6PIyB6B48L2cHJ2mlVs5l51XLrPTUrrPg0hLNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860514; c=relaxed/simple;
	bh=vpxEG15EwyvPFXR27bWvkB95NGTadxdXQ1TcQ6CP3Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG+3+vnRbpvSNQxmNJqSJZfBO+gaJmR491pxaUm2EgeO61RVAXPGKBudiA7VqxZUrODxIsg1MACcjU/sCfj7SvI+4+I89M3eGZ1iKwQjYQruTS+b5nyjlNW43Hq6syX6l/2Iw8OO/WAwukloi0WiTgVhm1O2mWdIKs9hJrkSaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=Kb7ZDcoN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so613717f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1741860511; x=1742465311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kE3JcUtYSd0GRSzqpPo//q/5qu2KjWxCoyea7D1jEY=;
        b=Kb7ZDcoN/cnuGiQ4ANW85e1HH7h+hgaxag3KbRfgkWkSiHenI38lPypAJtfD1DkCCE
         b+bo1Yvn17AWdf0vTBiC7SdXrdCL7NaCBHekhB2X9OP9BWlzLAPq1OeNzZvXb0turVTL
         JqltpfFjIEX55d2KuCw4iDVKYw2siNfuTBIMVlsTgS2dsA/qLwvrPLxhy83Ii2Vt8rKs
         XbMw7VUL/XO0VMPnqfzRpVa6Z7RZsNU3Op8rzQgXDwDQ94I1IPzUIOVcJAYTrzG1mxj9
         8pic//wIlfQaLYObcm93u8ZnI+1JnHxy5i7JYLoUHME6x5oZdDdL7kj+9oqjhJs4h0lW
         nbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860511; x=1742465311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kE3JcUtYSd0GRSzqpPo//q/5qu2KjWxCoyea7D1jEY=;
        b=NLNEUGrvbxHBBkxnFsMLd4DbqeQTSjKCTkVtlnAYhBqfC10DipJhwUkTL1MzMtNYib
         32ZfMqWxQZyipreCFTIj27Wia37feC8P+DV/T60XxIbmR1p5IbLy0cHTMJmfQdM2IW73
         NkI+HY/1iEm3apiqZlplOM5m8V3SYYk0F36MOw7b7zlh10pKRJcd6dRz6J68mcmgXm7x
         2pqYWt3SfTywVctRUOE0V9NRPgpxR2xEBIm+mTMn1GP28KM/3Xuw+XsAfaoZMHzaZYBN
         v4grbMSY6W6q79x6GDgBy6lMcL13k9r7QduzOYBgyqsbiu3TQ+H5AC3KAgS0BOZ5o2sl
         JqZA==
X-Forwarded-Encrypted: i=1; AJvYcCUvS6Cc3ZkP4DF2FFb/QHZdHas+Hi0YOXhy3yB1G6610DnB3kxNaUzIQekz47eWuPMx+fgMCksQZUdWoxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxt4Hvrre9G/GtoF7F/vW/pV5Iac5B83oHPHZiTUlzN/JKks7
	CrSrB0NYs/dqJ4WgR2fhL9+zAVIu6UMbPXH2E5gg7ruztvWbrKHP2/iYSXpB42M=
X-Gm-Gg: ASbGncsE3zWJGMAB+JLM0ltp+AoT1R3CVckFzFcbq4cBY0lnXCfkgYKUc5vZeKLNbKj
	aghmUTs1yf/g1+975VZk8CXmnNdWwz8v3Aj/WyCp9Ku7eYiDeOHNYmdLgHFR6oZolz+yxfERSWV
	KAcdGV8g5AhWYcGpDA+H8ZH4yTwNdWnvlvTWXFo7LKpyhdUdMrzF3KhiWMjv70JGBCMJlb2pgrl
	Hw9fTVEJ0zxpVUdoYLU8m0/OzqeYIb4dsxdOuG001/CCxBGTKdPEoYOYCuydgzgEit1AHPM3ay8
	96wG8zzVGrk9kJxK8XJ71UhG1XkbpX2Rn/Ulp2tNp+35S6AU7VGEojWTOXc0
X-Google-Smtp-Source: AGHT+IE3V8y7/n//oMXFoucT31ml+gNQcei6mxWF6KuYlGXfqkkpPJTUNhIKvZMgXcLp83kxfHPbEQ==
X-Received: by 2002:a05:6000:402a:b0:390:e535:8758 with SMTP id ffacd0b85a97d-39132d2afc2mr17732820f8f.9.1741860510554;
        Thu, 13 Mar 2025 03:08:30 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm1565975f8f.47.2025.03.13.03.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:08:30 -0700 (PDT)
Message-ID: <945d134f-8790-4aa9-a33f-61aee0ed1a4a@ursulin.net>
Date: Thu, 13 Mar 2025 10:08:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/sched: Fix outdated comments referencing
 thread
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250305155326.153596-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250305155326.153596-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/03/2025 15:53, Philipp Stanner wrote:
> The GPU scheduler's comments refer to a "thread" at various places.
> Those are leftovers from commit a6149f039369 ("drm/sched: Convert drm
> scheduler to use a work queue rather than kthread").
> 
> Replace all references to kthreads.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes in v2:
>    - Speak consistently about work items. (Danilo)
>    - Remove Fixes: tags. (Danilo)
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c |  8 ++++----
>   drivers/gpu/drm/scheduler/sched_main.c   | 24 +++++++++++++-----------
>   include/drm/gpu_scheduler.h              | 10 +++++-----
>   3 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 87f88259ddf6..f9811420c787 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -538,10 +538,10 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>   		return;
>   
>   	/*
> -	 * Only when the queue is empty are we guaranteed that the scheduler
> -	 * thread cannot change ->last_scheduled. To enforce ordering we need
> -	 * a read barrier here. See drm_sched_entity_pop_job() for the other
> -	 * side.
> +	 * Only when the queue is empty are we guaranteed that
> +	 * drm_sched_run_job_work() cannot change entity->last_scheduled. To
> +	 * enforce ordering we need a read barrier here. See
> +	 * drm_sched_entity_pop_job() for the other side.
>   	 */
>   	smp_rmb();
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index c634993f1346..c97655aa7ab4 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -389,7 +389,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
>    * drm_sched_job_done - complete a job
>    * @s_job: pointer to the job which is done
>    *
> - * Finish the job's fence and wake up the worker thread.
> + * Finish the job's fence and resubmit the work items.
>    */
>   static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
>   {
> @@ -549,9 +549,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
>   
>   	if (job) {
>   		/*
> -		 * Remove the bad job so it cannot be freed by concurrent
> -		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
> -		 * is parked at which point it's safe.
> +		 * Remove the bad job so it cannot be freed by a concurrent
> +		 * &struct drm_sched_backend_ops.free_job. It will be
> +		 * reinserted after the scheduler's work items have been
> +		 * cancelled, at which point it's safe.
>   		 */
>   		list_del_init(&job->list);
>   		spin_unlock(&sched->job_list_lock);
> @@ -597,10 +598,10 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
>   
>   	/*
>   	 * Reinsert back the bad job here - now it's safe as
> -	 * drm_sched_get_finished_job cannot race against us and release the
> +	 * drm_sched_get_finished_job() cannot race against us and release the
>   	 * bad job at this point - we parked (waited for) any in progress
> -	 * (earlier) cleanups and drm_sched_get_finished_job will not be called
> -	 * now until the scheduler thread is unparked.
> +	 * (earlier) cleanups and drm_sched_get_finished_job() will not be
> +	 * called now until the scheduler's work items are submitted again.
>   	 */
>   	if (bad && bad->sched == sched)
>   		/*
> @@ -613,7 +614,8 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
>   	 * Iterate the job list from later to  earlier one and either deactive
>   	 * their HW callbacks or remove them from pending list if they already
>   	 * signaled.
> -	 * This iteration is thread safe as sched thread is stopped.
> +	 * This iteration is thread safe as the scheduler's work items have been
> +	 * cancelled.
>   	 */
>   	list_for_each_entry_safe_reverse(s_job, tmp, &sched->pending_list,
>   					 list) {
> @@ -678,9 +680,9 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
>   	struct drm_sched_job *s_job, *tmp;
>   
>   	/*
> -	 * Locking the list is not required here as the sched thread is parked
> -	 * so no new jobs are being inserted or removed. Also concurrent
> -	 * GPU recovers can't run in parallel.
> +	 * Locking the list is not required here as the scheduler's work items
> +	 * are currently not running, so no new jobs are being inserted or
> +	 * removed. Also concurrent GPU recovers can't run in parallel.
>   	 */
>   	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
>   		struct dma_fence *fence = s_job->s_fence->parent;
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 50928a7ae98e..d8bfd46c1117 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -192,7 +192,7 @@ struct drm_sched_entity {
>   	 * @last_scheduled:
>   	 *
>   	 * Points to the finished fence of the last scheduled job. Only written
> -	 * by the scheduler thread, can be accessed locklessly from
> +	 * by drm_sched_entity_pop_job(). Can be accessed locklessly from
>   	 * drm_sched_job_arm() if the queue is empty.
>   	 */
>   	struct dma_fence __rcu		*last_scheduled;
> @@ -426,14 +426,14 @@ struct drm_sched_backend_ops {
>   	 * Drivers typically issue a reset to recover from GPU hangs, and this
>   	 * procedure usually follows the following workflow:
>   	 *
> -	 * 1. Stop the scheduler using drm_sched_stop(). This will park the
> -	 *    scheduler thread and cancel the timeout work, guaranteeing that
> -	 *    nothing is queued while we reset the hardware queue
> +	 * 1. Stop the scheduler using drm_sched_stop(). This will cancel the
> +	 *    scheduler's work items, guaranteeing that nothing is queued while
> +	 *    we reset the hardware queue.
>   	 * 2. Try to gracefully stop non-faulty jobs (optional)
>   	 * 3. Issue a GPU reset (driver-specific)
>   	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
>   	 * 5. Restart the scheduler using drm_sched_start(). At that point, new
> -	 *    jobs can be queued, and the scheduler thread is unblocked
> +	 *    jobs can be queued, and the scheduler's work items are resubmitted.
>   	 *
>   	 * Note that some GPUs have distinct hardware queues but need to reset
>   	 * the GPU globally, which requires extra synchronization between the

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


