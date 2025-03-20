Return-Path: <linux-kernel+bounces-569534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2585A6A447
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A33719C3ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D458226193;
	Thu, 20 Mar 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Z/JFWRiH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40262225785
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468109; cv=none; b=ilEkPZtaZ7W+spMG39mieEWJWw23u+INE66M8xTKVlAZJUHWC6mjaaf7bjwYPo9HgzfzLvUOfP4H6AOkajhN2GT6vloYtQ/vkNe9dMRAE7c4rkAqkC/VjPDU+yjhFMxt5FUDRTPgJbLwyEwvKXOMuaeyNgLcDJGl7ONigAqnJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468109; c=relaxed/simple;
	bh=SNG/LOyp5JbGiYnH5vdu0LOohVMA4mhcYhSdT9vuNEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnUxBt21M4hOYYXvsc3XtQQfPLsyiMSvL2N93i3IRgusn1t0YtXxecOyIrz8ajFmYeUl0mhJz9htw8eoVpvMq9OY5B/tZWysccpRrb87UILywxyBpsSB1/LdlBprWA+shmEOqqIw4jfpPwtXKhbfbNs6e/CXwJgIJMcV/PdkZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=Z/JFWRiH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so5563545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1742468105; x=1743072905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqvYuPveixTIa7Mc/61jInJl2Tv6IsJXRJwFjRxAyv4=;
        b=Z/JFWRiHTb85AuySP088aACIcCBJHErTeVluaY5rZ9fBFSLXAplT65d/knnyivhzz0
         a3XCOkBN9CcgOmxYqMBwE4YinSF1BBY/umIE2bLkw9d7JW8vudoLX4nc3qry19kBEqXY
         ik0E85qE7+SzD4VWTXsUcskTJetFcFuUDxeTr5kUzGICXfArHub7/PT3RQclu1yRYrBS
         gstY3NX9iRXrv1xRCL4PObCWbz1O4IjNdFPC7AJfLFY6kCHGQGFsUK9OkwRFrPERiaLi
         Z5dIaep4kSAal5+z5ztEekVOqC5rZD5HXIbn0ypJLrd+NGhFXdtpzrRJ0u2Y9PXKyj6q
         FTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468105; x=1743072905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqvYuPveixTIa7Mc/61jInJl2Tv6IsJXRJwFjRxAyv4=;
        b=Z5wv0qpNlbtdK3SA6SoeB4+BfhHLz3IOQPgwJfj9VcDnuz5ZpgXK7g4t4Kcb1Kj0hD
         kHrlbiOlLRD1qAZ3FNwUpuISvJlnheiqRt4kjU92hQYCeJv3mBkKWCZVLX+27jKhVYlx
         iHVydGfeSPXPOBpN5aPMs+OSuDyv+rCbMe0Nvna2J0nXS6N3yHmVzQHFhCCOTICUjkC1
         tZIc21/ZTbNpSMIqvtfXp0yni/eBOQDnNX/yQU2VDvIP6oUUuEd+lip61ZEldZstNeuj
         MJpcwgGvIYrUFc/DIC40z8KgKyEjD9jRvohUwZCWenwZisDZjpRXF8MjmgrXcqDveyJ7
         2evw==
X-Forwarded-Encrypted: i=1; AJvYcCUAEzH1bGgbYH/S8gObMXJ9w4Vu0yrsoiayShqbwD490ra6NFzmHcqvbAbBjiiXp66G2/h1wWqF/FSf+L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBE3BjikwVmZRUnWUibYQQXNWBKH2q3Ewtpw+aNeF/LbBhN6O
	o1gIZOUwxcgx0KnWRJW2PAXgAXnvvNoK7T0WpIJIcsKjBlDr6nnPzRmykDh/kzE=
X-Gm-Gg: ASbGncvxy9DTs7/Ymi+vjcBZcT1oqOYeEr7ctOUX+qeLS+8osDUjmUYQorNd6Rf3HkK
	ju0Wiv/v8GfQDihDPz21BeBvb8xBNhIguyexdOsbvCmac7x/ZqPJyhGfoQdje1fgPd/TXcGFNDE
	+tCDb8mUhYKNUePHo1ECbti1xITn6om/fjvqeW2q3pSaVhr4+WcwLJmDsDTVPveWSA6MhVO9/Fg
	PZ+smt08mX4oSJmFB4I0Ux6P489kSkaeyQPH8aS9wzviC7V9VzPk6WcP7dMMRf8WFqje8ulXny1
	Cgc7Ud2sz5M1Ln6mZ22HeuWDUmbYVBVxs7HiKaPsNtKLffFYv3SvAPL9ZSQA
X-Google-Smtp-Source: AGHT+IG2azrJs8WibAf9eloXv01LZZg39dzbr3gZdWduFqbzEvQ1pfo/Z+f6c6/FqCh/fHysDRwipA==
X-Received: by 2002:a05:600c:1c19:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43d4378219bmr57196425e9.3.1742468105243;
        Thu, 20 Mar 2025 03:55:05 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f58ab6sm44756905e9.23.2025.03.20.03.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:55:04 -0700 (PDT)
Message-ID: <2967c6b6-4f90-4ed6-9751-df4846602d5e@ursulin.net>
Date: Thu, 20 Mar 2025 10:55:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] drm: get rid of drm_sched_job::id
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tvrtko Ursulin <tursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250320095818.40622-1-pierre-eric.pelloux-prayer@amd.com>
 <20250320095818.40622-10-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250320095818.40622-10-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/2025 09:58, Pierre-Eric Pelloux-Prayer wrote:
> Its only purpose was for trace events, but jobs can already be
> uniquely identified using their fence.
> 
> The downside of using the fence is that it's only available
> after 'drm_sched_job_arm' was called which is true for all trace
> events that used job.id so they can safely switch to using it.

Perhaps it would make more sense to pull in this patch to before the one 
declaring tracpoints stable ABI.

Also note that patched declared job->id as stable and this one forgot to 
remove that.

The rest LGTM.

Regards,

Tvrtko

> 
> Suggested-by: Tvrtko Ursulin <tursulin@igalia.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h      | 18 ++++++------------
>   .../gpu/drm/scheduler/gpu_scheduler_trace.h    | 18 ++++++------------
>   drivers/gpu/drm/scheduler/sched_main.c         |  1 -
>   include/drm/gpu_scheduler.h                    |  3 ---
>   4 files changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 383fce40d4dd..a4f394d827bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -167,7 +167,6 @@ TRACE_EVENT(amdgpu_cs_ioctl,
>   	    TP_PROTO(struct amdgpu_job *job),
>   	    TP_ARGS(job),
>   	    TP_STRUCT__entry(
> -			     __field(uint64_t, sched_job_id)
>   			     __string(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))
>   			     __field(unsigned int, context)
>   			     __field(unsigned int, seqno)
> @@ -177,15 +176,14 @@ TRACE_EVENT(amdgpu_cs_ioctl,
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->sched_job_id = job->base.id;
>   			   __assign_str(timeline);
>   			   __entry->context = job->base.s_fence->finished.context;
>   			   __entry->seqno = job->base.s_fence->finished.seqno;
>   			   __assign_str(ring);
>   			   __entry->num_ibs = job->num_ibs;
>   			   ),
> -	    TP_printk("sched_job=%llu, timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> -		      __entry->sched_job_id, __get_str(timeline), __entry->context,
> +	    TP_printk("timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> +		      __get_str(timeline), __entry->context,
>   		      __entry->seqno, __get_str(ring), __entry->num_ibs)
>   );
>   
> @@ -193,7 +191,6 @@ TRACE_EVENT(amdgpu_sched_run_job,
>   	    TP_PROTO(struct amdgpu_job *job),
>   	    TP_ARGS(job),
>   	    TP_STRUCT__entry(
> -			     __field(uint64_t, sched_job_id)
>   			     __string(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))
>   			     __field(unsigned int, context)
>   			     __field(unsigned int, seqno)
> @@ -202,15 +199,14 @@ TRACE_EVENT(amdgpu_sched_run_job,
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->sched_job_id = job->base.id;
>   			   __assign_str(timeline);
>   			   __entry->context = job->base.s_fence->finished.context;
>   			   __entry->seqno = job->base.s_fence->finished.seqno;
>   			   __assign_str(ring);
>   			   __entry->num_ibs = job->num_ibs;
>   			   ),
> -	    TP_printk("sched_job=%llu, timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> -		      __entry->sched_job_id, __get_str(timeline), __entry->context,
> +	    TP_printk("timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> +		      __get_str(timeline), __entry->context,
>   		      __entry->seqno, __get_str(ring), __entry->num_ibs)
>   );
>   
> @@ -519,7 +515,6 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   	    TP_ARGS(sched_job, fence),
>   	    TP_STRUCT__entry(
>   			     __string(ring, sched_job->base.sched->name)
> -			     __field(uint64_t, id)
>   			     __field(struct dma_fence *, fence)
>   			     __field(uint64_t, ctx)
>   			     __field(unsigned, seqno)
> @@ -527,13 +522,12 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   
>   	    TP_fast_assign(
>   			   __assign_str(ring);
> -			   __entry->id = sched_job->base.id;
>   			   __entry->fence = fence;
>   			   __entry->ctx = fence->context;
>   			   __entry->seqno = fence->seqno;
>   			   ),
> -	    TP_printk("job ring=%s, id=%llu, need pipe sync to fence=%p, context=%llu, seq=%u",
> -		      __get_str(ring), __entry->id,
> +	    TP_printk("job ring=%s need pipe sync to fence=%p, context=%llu, seq=%u",
> +		      __get_str(ring),
>   		      __entry->fence, __entry->ctx,
>   		      __entry->seqno)
>   );
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index 3c7f6a39cf91..ad03240b2f03 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -58,7 +58,6 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
>   	    TP_ARGS(sched_job, entity),
>   	    TP_STRUCT__entry(
> -			     __field(uint64_t, id)
>   			     __string(name, sched_job->sched->name)
>   			     __field(u32, job_count)
>   			     __field(int, hw_job_count)
> @@ -69,7 +68,6 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->id = sched_job->id;
>   			   __assign_str(name);
>   			   __entry->job_count = spsc_queue_count(&entity->job_queue);
>   			   __entry->hw_job_count = atomic_read(
> @@ -79,8 +77,8 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
>   			   __entry->client_id = sched_job->s_fence->drm_client_id;
>   			   ),
> -	    TP_printk("dev=%s, id=%llu, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d, client_id:%llu",
> -		      __get_str(dev), __entry->id,
> +	    TP_printk("dev=%s, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d, client_id:%llu",
> +		      __get_str(dev),
>   		      __entry->fence_context, __entry->fence_seqno, __get_str(name),
>   		      __entry->job_count, __entry->hw_job_count, __entry->client_id)
>   );
> @@ -117,7 +115,6 @@ TRACE_EVENT(drm_sched_job_add_dep,
>   	TP_STRUCT__entry(
>   		    __field(u64, fence_context)
>   		    __field(u64, fence_seqno)
> -		    __field(u64, id)
>   		    __field(u64, ctx)
>   		    __field(u64, seqno)
>   		    ),
> @@ -125,12 +122,11 @@ TRACE_EVENT(drm_sched_job_add_dep,
>   	TP_fast_assign(
>   		    __entry->fence_context = sched_job->s_fence->finished.context;
>   		    __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> -		    __entry->id = sched_job->id;
>   		    __entry->ctx = fence->context;
>   		    __entry->seqno = fence->seqno;
>   		    ),
> -	TP_printk("fence=%llu:%llu, id=%llu depends on fence=%llu:%llu",
> -		  __entry->fence_context, __entry->fence_seqno, __entry->id,
> +	TP_printk("fence=%llu:%llu depends on fence=%llu:%llu",
> +		  __entry->fence_context, __entry->fence_seqno,
>   		  __entry->ctx, __entry->seqno)
>   );
>   
> @@ -140,7 +136,6 @@ TRACE_EVENT(drm_sched_job_unschedulable,
>   	    TP_STRUCT__entry(
>   			     __field(u64, fence_context)
>   			     __field(u64, fence_seqno)
> -			     __field(uint64_t, id)
>   			     __field(u64, ctx)
>   			     __field(u64, seqno)
>   			     ),
> @@ -148,12 +143,11 @@ TRACE_EVENT(drm_sched_job_unschedulable,
>   	    TP_fast_assign(
>   			   __entry->fence_context = sched_job->s_fence->finished.context;
>   			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> -			   __entry->id = sched_job->id;
>   			   __entry->ctx = fence->context;
>   			   __entry->seqno = fence->seqno;
>   			   ),
> -	    TP_printk("fence=%llu:%llu, id=%llu depends on unsignalled fence=%llu:%llu",
> -		      __entry->fence_context, __entry->fence_seqno, __entry->id,
> +	    TP_printk("fence=%llu:%llu depends on unsignalled fence=%llu:%llu",
> +		      __entry->fence_context, __entry->fence_seqno,
>   		      __entry->ctx, __entry->seqno)
>   );
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 85c2111e5500..85e0ba850746 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -848,7 +848,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>   
>   	job->sched = sched;
>   	job->s_priority = entity->priority;
> -	job->id = atomic64_inc_return(&sched->job_id_count);
>   
>   	drm_sched_fence_init(job->s_fence, job->entity);
>   }
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 032214a49138..ddc24512c281 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -326,7 +326,6 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>    * @finish_cb: the callback for the finished fence.
>    * @credits: the number of credits this job contributes to the scheduler
>    * @work: Helper to reschedule job kill to different context.
> - * @id: a unique id assigned to each job scheduled on the scheduler.
>    * @karma: increment on every hang caused by this job. If this exceeds the hang
>    *         limit of the scheduler then the job is marked guilty and will not
>    *         be scheduled further.
> @@ -339,8 +338,6 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>    * to schedule the job.
>    */
>   struct drm_sched_job {
> -	u64				id;
> -
>   	/**
>   	 * @submit_ts:
>   	 *


