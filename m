Return-Path: <linux-kernel+bounces-569515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C7A6A40B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A838189E446
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC529224258;
	Thu, 20 Mar 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="bEmaajYy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56E2147F2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467653; cv=none; b=CENAf+e/WPCg8dhRWkgTcRG1iLpiIIzH2ZfBVm28H8vPqh6AQhopVioj/4rQ8svIHojmbwRxScGLTyvkaTpQ0wnqUtB1PDEEh2pDGnlzQFMunGQHmfw6f8VpOTpQ+MwxeX3EGHyqaidtQAA7CVh7R7RF+2aDCoqwBB/mz15Idr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467653; c=relaxed/simple;
	bh=9dLj34jXO3aWy8eeyY3CZQzkprJGU2y+2pU7Y2wkRA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy+XBi5DJ1pt6EBR9wXdHyqQb/8Ib+GCmRc+5Oiu77xrY9h9pS4mk9ECglYnabUks1gHpsVuUktHswnd4HEVvUx1JBly3hDqAl3IxgE+gRskD8nhEuJwoQu1r/0C67qW1xOw9esNv2zeNnRoKSslkLEWHsBIZ69C7BfgC5s2RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=bEmaajYy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so5501785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1742467650; x=1743072450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foGgFo33VLzIkzjoUbfwPOydEMR+xeWsTRE1WEHeQbI=;
        b=bEmaajYyuEAwqsj1lT8XHD82b/XDX7wdgDnk4gAkmWIerawX7CIrbX7sW2qTvqKgy+
         wikI9i6hruJYVLlE7pOiXLnAwGWqb2/6J5D7gtkTe9wVo+cAxhU35STNea7eFyLxEARI
         LHY0+aRc/bJFjbBfpxXUXLCKaztk76T3rDmiIrvLoO2FwZtXHPvuJeZrHq5QX9R7ZHzm
         fipw234hvMWjGW0JLC8h6XZJP+8nB/gBykadkQF6rj4Nmvo2a+dYEGe/Wf3nzC/XnacX
         san9StQbuOWEBP2J7YXIZUDTMTWUIPnesdVg8ukv2sQGshkyvkKJ61wWC91x2MBtJtth
         gYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467650; x=1743072450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foGgFo33VLzIkzjoUbfwPOydEMR+xeWsTRE1WEHeQbI=;
        b=fkRR1eXPbIqmp6SSTTNfEjmJtH/61PJs8Mw5026BdyPsNJSHUecLgiK9+wIthmbAll
         Qn4q55jfoM14669G0uNmeqBZJOlBD/ekQN4STlIg9rK/m/U0uk2fMli+gShlxS8AnAMO
         GGl6dB/ULi9eSDrJCDyWR1W7Cn9Kjwr3f/5x59ZFxbdXreY9EtDVEZqNEKlqLSwxLKe7
         1L9FbLcnPQbBUHZp+YOfGTeq5smebcX5B7yNkkMpkYsyupRfHUx7aCKTulSVFNfUq9Gh
         LyumJFgYGgQ/xaTxLzFvbLVr9bjb6HtnYRUH5YVsVA2T6X76EAjKDcpoJjKpERv4HS1l
         Fuqg==
X-Forwarded-Encrypted: i=1; AJvYcCXutG5gQ/SpGYq4Gwdn3eS8KhyA5/mTsUZonZx3ytnsJwP7q0Yj0Vh+szcYWugd8Am0mshjyLgnJ9h3ljg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yDN0XcjY4JoRX/xf1Wj+g6xOfIp6RRmNClK8+6Kn3g6yZsVs
	F+xJX6PW4/ZDc5gAi80bo63Ay/k2qSLimIdXf3WlZFKgYTEDZ6vKapGqoK+4YLo=
X-Gm-Gg: ASbGncvNwE3hi5XVuoPUZCJSJvhCHGNOtQHsdLhee6a1NlaUd+VfZgpxsX1IX5lf4N7
	Z/9XYCMkrzXVo8G5Rt4zUbTtIu7dXZefaz6AQjDZVyk7/uvMP+SBD2497OzgcjwzjnJQBXX17oc
	1JtV5ZP26jgw/ljXtNV+LHRWI5HO0bk3N3SMRyAOBfVKI/okKSM+btzqXvAGp26OwVVD5Ik7fzU
	EDl9tsSWBRDSDMoH1vQTpp3ssWFWUm+tnwgXOPkcpRZt4Wfv3INhb1PG8jQ5jgWfFZcvyIYA33X
	Cr5ZiUm/0s4dEf0SNfvYHUNWC/rv1B3M7eP4ZphVJxuWTakbWZndVY7g/Cuy
X-Google-Smtp-Source: AGHT+IEvHPoPXyg7rfkgM3Y97xOpECmfVdCIe7gAm9tgP99dIaDKMLf19aoDb9oOuJzL8kX1SocWRw==
X-Received: by 2002:a05:600c:5008:b0:43c:f87c:24d3 with SMTP id 5b1f17b1804b1-43d4381b4b9mr64371575e9.20.1742467649457;
        Thu, 20 Mar 2025 03:47:29 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35f7sm23678038f8f.13.2025.03.20.03.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:47:29 -0700 (PDT)
Message-ID: <d4ef3a3b-eed1-4c15-827b-4a34a8a47dc1@ursulin.net>
Date: Thu, 20 Mar 2025 10:47:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/10] drm/sched: trace dependencies for gpu jobs
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20250320095818.40622-1-pierre-eric.pelloux-prayer@amd.com>
 <20250320095818.40622-6-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250320095818.40622-6-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/2025 09:58, Pierre-Eric Pelloux-Prayer wrote:
> We can't trace dependencies from drm_sched_job_add_dependency
> because when it's called the job's fence is not available yet.
> 
> So instead each dependency is traced individually when
> drm_sched_entity_push_job is used.
> 
> Tracing the dependencies allows tools to analyze the dependencies
> between the jobs (previously it was only possible for fences
> traced by drm_sched_job_wait_dep).
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   .../gpu/drm/scheduler/gpu_scheduler_trace.h   | 24 ++++++++++++++++++-
>   drivers/gpu/drm/scheduler/sched_entity.c      |  8 +++++++
>   2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index 21a85ee59066..5d9992ad47d3 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -54,7 +54,6 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   			   __assign_str(dev);
>   			   __entry->fence_context = sched_job->s_fence->finished.context;
>   			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> -
>   			   ),
>   	    TP_printk("dev=%s, id=%llu, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d",
>   		      __get_str(dev), __entry->id,
> @@ -88,6 +87,29 @@ TRACE_EVENT(drm_sched_process_job,
>   		      __entry->fence_context, __entry->fence_seqno)
>   );
>   
> +TRACE_EVENT(drm_sched_job_add_dep,
> +	TP_PROTO(struct drm_sched_job *sched_job, struct dma_fence *fence),
> +	TP_ARGS(sched_job, fence),
> +	TP_STRUCT__entry(
> +		    __field(u64, fence_context)
> +		    __field(u64, fence_seqno)
> +		    __field(u64, id)
> +		    __field(u64, ctx)
> +		    __field(u64, seqno)
> +		    ),
> +
> +	TP_fast_assign(
> +		    __entry->fence_context = sched_job->s_fence->finished.context;
> +		    __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> +		    __entry->id = sched_job->id;
> +		    __entry->ctx = fence->context;
> +		    __entry->seqno = fence->seqno;
> +		    ),
> +	TP_printk("fence=%llu:%llu, id=%llu depends on fence=%llu:%llu",
> +		  __entry->fence_context, __entry->fence_seqno, __entry->id,
> +		  __entry->ctx, __entry->seqno)
> +);
> +
>   TRACE_EVENT(drm_sched_job_wait_dep,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct dma_fence *fence),
>   	    TP_ARGS(sched_job, fence),
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index a6d2a4722d82..047e42cfb129 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -580,6 +580,14 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   	ktime_t submit_ts;
>   
>   	trace_drm_sched_job(sched_job, entity);
> +
> +	if (trace_drm_sched_job_add_dep_enabled()) {
> +		struct dma_fence *entry;
> +		unsigned long index;
> +
> +		xa_for_each(&sched_job->dependencies, index, entry)
> +			trace_drm_sched_job_add_dep(sched_job, entry);
> +	}
>   	atomic_inc(entity->rq->sched->score);
>   	WRITE_ONCE(entity->last_user, current->group_leader);
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


