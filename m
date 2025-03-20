Return-Path: <linux-kernel+bounces-569518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E6A6A414
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037D53BD9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740D224885;
	Thu, 20 Mar 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="ogp739E6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F022080D9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467787; cv=none; b=C6240YBvKSMTlFl7qU5iLGhRB16xtUcL3F4RuMEAQK5+3cUVq5yRtV0Igyu5x6ixO9ZkWncTixf8Zeajjg26HfYjpkCBu7pmrKD29aSi3tiBg9mmDK/yhVqWZgo5tu4iubD/Q2WrePEEHWGkP2pg8pL4nW1mweUBZWDAarR2Zlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467787; c=relaxed/simple;
	bh=Y6/yzZwSwrYy+AHACk9EwPjH71vlojFvnvdFM/cDRBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTiU0MHVtS06ph8POQ2NoPNpMdUtclK/9yQgTIY4uh4cfCJhsLRHZp5UkJX09kWO7FJPpUXV7fQDhRpHgK8BMPPXiLHoRwJsOnj5n4Fh9Jje+N3xluMMIuf/woVqfak1iJ45OIuXE3+V93Rv+fBlb7B2Ka7pIHPqN13e3LWGl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=ogp739E6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so339023f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1742467783; x=1743072583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbL7ptMHboU5raC7wJPf694evtUl0i0LartgtD6KB7M=;
        b=ogp739E6qWBc7XxBbABEhfQWUHQoL2d/9bwAhJDOMuknEOMgibu+11XggkCytzhR4p
         JntJtu3AOHEo0VazmwOQUvBUtBbh2OOBX8/GeXicqHkETVND0aqe/k2rUU3ObKGvahas
         BZD0/zLJGNvLGRbr4JrH7TF12BGZOPH0JQM9txtKBv1pNzTa8cp32noTAyVhgXgqSZ/L
         VMlaukKmByNFPG8GXA0KDQMIIaHnyuBzbForVfuNg/Vp2X96K9yZDvGd38Ovb6DJ1HLD
         XNkzhAKr+04R1o8xF8FF4w1s+iiBHOYgZ/9tk9vEaSRALQhRMsnf22LjbjvAicpoehS+
         NViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467783; x=1743072583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbL7ptMHboU5raC7wJPf694evtUl0i0LartgtD6KB7M=;
        b=VVUZCfUCMDCsqPHtkMQHZqWyyWJE2Be1YT6N9g/wHtVmghmW5/nz8HDgoXrAI5ZwCz
         7hQDpODbDl7avruCS0UDU2sj/ttI5W3mU2VT6gDNUMSC28yMs5NXMK4JrqmD2v6p7R5x
         x2zgAKP4aeNsPgRTzFjFcEqTmREXV5AlEPcC5dPTeX1dZUT74B2l0mnMhSmbalzzHjvH
         zuZkkvslBvAKZsZyyxf5Bzy6gKqTQvnbiK10GyC4nqEhLA0dTylUm5WyC2ssBqY8YkGm
         UQ/hjW0ZWUzEdkBu08GtGyNqMmvTOWaf5B4mdxIYgKTw9xod3JcUbbpjWm7tzvwP7u2e
         685A==
X-Forwarded-Encrypted: i=1; AJvYcCUmzCPR+jS7x5KIlrP2/0geAwW/UQV3HYOspeUrJ+JKlWC9FhoVfkyYuScUR7ruCXZC5dY8GPpj75nACv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Zbcu/pDaYT5PbgCzlZfjJm4nR/yKh6/7LX0NFbl6juKgW3x0
	C30KaO3BcszPJD1c5bFknjEDxFxTPQzpnFCons02TkmHi8UZZSvqJtdazFAgFsc=
X-Gm-Gg: ASbGnct8PYIX+505F7ZDV79JZr6xhggTTS9tAI464w/82xFzWT43eAAxpCLCixbZz6i
	IwMvh27xo6pB0C6OnIAMUFRMBDDSwo5QdBWTJTm1dtb8TEvIjHaByCGmRqSddIBZzW0KHcnUIpG
	Sw7WOigL+0BDgT/1MC66zijHrIXqMlWyeosbUQciEl/wxNl+wCFZBSHeEdKMOtz6VymXXTyRceS
	J+ntO8R8g65gbBPdt4KLA25rXh1qP5Q0ho6Ob3taPJYaKsAjJWbko1oGCCMnxlwWNsGh6elVUop
	uvL3FLYGvLXqEJBEzF7gjTRic+zrwWeBBL4uOr8G/exSyU0j1puBWHN2K1s2
X-Google-Smtp-Source: AGHT+IEnd/XYyPpHLCbPZRoXCgp4GXYzB0emXATpl/Q2SPWPwd/46wT5KAZg21WIOJ+niGjQcFthDw==
X-Received: by 2002:a5d:5982:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-399739c1524mr6566540f8f.14.1742467782662;
        Thu, 20 Mar 2025 03:49:42 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm23605824f8f.62.2025.03.20.03.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:49:42 -0700 (PDT)
Message-ID: <c6d5c64b-11ea-453a-b7fe-4071dd11d7ea@ursulin.net>
Date: Thu, 20 Mar 2025 10:49:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/10] drm/sched: cleanup event names
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250320095818.40622-1-pierre-eric.pelloux-prayer@amd.com>
 <20250320095818.40622-8-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250320095818.40622-8-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/2025 09:58, Pierre-Eric Pelloux-Prayer wrote:
> All events now start with the same prefix (drm_sched_job_).
> 
> drm_sched_job_wait_dep was misleading because it wasn't waiting
> at all. It's now replaced by trace_drm_sched_job_unschedulable,
> which is only traced if the job cannot be scheduled.
> For moot dependencies, nothing is traced.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 8 ++++----
>   drivers/gpu/drm/scheduler/sched_entity.c        | 8 ++++----
>   drivers/gpu/drm/scheduler/sched_main.c          | 4 ++--
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index 38cdd659a286..4ce53e493fef 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -63,17 +63,17 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   		      __entry->job_count, __entry->hw_job_count, __entry->client_id)
>   );
>   
> -DEFINE_EVENT(drm_sched_job, drm_sched_job,
> +DEFINE_EVENT(drm_sched_job, drm_sched_job_queue,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
>   	    TP_ARGS(sched_job, entity)
>   );
>   
> -DEFINE_EVENT(drm_sched_job, drm_run_job,
> +DEFINE_EVENT(drm_sched_job, drm_sched_job_run,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
>   	    TP_ARGS(sched_job, entity)
>   );
>   
> -TRACE_EVENT(drm_sched_process_job,
> +TRACE_EVENT(drm_sched_job_done,
>   	    TP_PROTO(struct drm_sched_fence *fence),
>   	    TP_ARGS(fence),
>   	    TP_STRUCT__entry(
> @@ -112,7 +112,7 @@ TRACE_EVENT(drm_sched_job_add_dep,
>   		  __entry->ctx, __entry->seqno)
>   );
>   
> -TRACE_EVENT(drm_sched_job_wait_dep,
> +TRACE_EVENT(drm_sched_job_unschedulable,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct dma_fence *fence),
>   	    TP_ARGS(sched_job, fence),
>   	    TP_STRUCT__entry(
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 047e42cfb129..0bad247f783e 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -470,10 +470,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>   
>   	while ((entity->dependency =
>   			drm_sched_job_dependency(sched_job, entity))) {
> -		trace_drm_sched_job_wait_dep(sched_job, entity->dependency);
> -
> -		if (drm_sched_entity_add_dependency_cb(entity))
> +		if (drm_sched_entity_add_dependency_cb(entity)) {
> +			trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
>   			return NULL;
> +		}
>   	}
>   
>   	/* skip jobs from entity that marked guilty */
> @@ -579,7 +579,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   	bool first;
>   	ktime_t submit_ts;
>   
> -	trace_drm_sched_job(sched_job, entity);
> +	trace_drm_sched_job_queue(sched_job, entity);
>   
>   	if (trace_drm_sched_job_add_dep_enabled()) {
>   		struct dma_fence *entry;
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 501eae13acb3..85c2111e5500 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -401,7 +401,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
>   	atomic_sub(s_job->credits, &sched->credit_count);
>   	atomic_dec(sched->score);
>   
> -	trace_drm_sched_process_job(s_fence);
> +	trace_drm_sched_job_done(s_fence);
>   
>   	dma_fence_get(&s_fence->finished);
>   	drm_sched_fence_finished(s_fence, result);
> @@ -1221,7 +1221,7 @@ static void drm_sched_run_job_work(struct work_struct *w)
>   	atomic_add(sched_job->credits, &sched->credit_count);
>   	drm_sched_job_begin(sched_job);
>   
> -	trace_drm_run_job(sched_job, entity);
> +	trace_drm_sched_job_run(sched_job, entity);
>   	fence = sched->ops->run_job(sched_job);
>   	complete_all(&entity->entity_idle);
>   	drm_sched_fence_scheduled(s_fence, fence);

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


