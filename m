Return-Path: <linux-kernel+bounces-569512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CCA6A404
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83103189CC30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E05224885;
	Thu, 20 Mar 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Gbhpsk1/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44A7482
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467585; cv=none; b=L1wwqgdj3mfFMFlx7IO1KiT4DD8F1k3m5mNcu7oAwMPQy6O89jfUhdH6yOlHKok4D8HP2ZoBgIOtUXOGDWqz2qivtXeds5ciakj05oCKdsgHeBecALqUlrEXrIGk4/eaWIgaDLJp5b4AHmbjNlszVwEdZPxDsudOnNzPdl46nlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467585; c=relaxed/simple;
	bh=9HhRYmL2wmq4FmkvIuFQ6za0skYeKr8q4AVDZW5+T6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmZcMYDdIcsbs0p8Obqm6uraQVnF+6lqFu2iNTwJF00BPcvS5eUj0pKusxK+P+mDTl7nl42ZunPIFW0amnbNlFrC/9+FQ8dXaCk3SLdEVLw5rFEfanY1wL25vrMBnDiHKXeiosbYko4sUllsS7SwBPK7J0FdX8u1a9brDGhVCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=Gbhpsk1/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so3246615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1742467582; x=1743072382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3cXA/fw5AX+Yiya/bhG01AqbPdp8l/PoT8LT6FJXhM=;
        b=Gbhpsk1/2ErG01XAs/q9CdwEek+YMCE1JBMyA6Ttp8vmyia/ilk4VC2ZzIRJiaRZdT
         JIFnJ0ByprTw8Yd7zb+WnOgcAyYen0qPaujMyvYoKuTHdTvVU4yD13JUgkpsNBq62w2r
         4uA7IN6gTjyUcGOqzkLy4iSoPhkmNe1ueDxkrY1zCin1KEk1tsZVFFtAn78mVVpRBKjt
         DhLVxyETLPbMYZsMXt8wWk0nHgryuPpJN6+plDpYR294/kDbs+vRHFLxF8ekwr45VDoh
         ds1J0jdhudxkpdNS6XM129gHpYrd9bXGjtM3bN37NP6H73JRUPFe9u118LIP5cOlWt/v
         KYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467582; x=1743072382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3cXA/fw5AX+Yiya/bhG01AqbPdp8l/PoT8LT6FJXhM=;
        b=ne7lRbTxN8tsRX8L1WsSFxoabfpAKUY7LalCmu48DaEQYF8LwAt2fYihTj+/De4m/X
         X+7oEZQfKWmFIVEWBhhoHd7zrh0RzoUcG9g4jV2Xau93VVOQcKwmFU2tTvyvL25/iZ/W
         tVvNzRIcS2HMlC5vuSFCC43wxstDpImjIXBZvz9giZfe6n+DIhe/6efrPXQGdjpRnFNv
         3zkuVePJz0XHaItk4gwp0dpezVsmlAVvyUq6eFYSJPE/rcEr35ZjFXPOCRuPrrkDwFo+
         47ijRtC4wgisH49FwMvXEgjxz4uztAtHLcK0gLRJrymzfAJPuTA62Hnqv8a/43GW/gHF
         n/QA==
X-Forwarded-Encrypted: i=1; AJvYcCUyUfkdH5GWeIt9S2faCzmmrUEoFp6iuZmyn+ZiwZQVhd6Lu6vOWtcl2PbEFlcVhiMNiH1ylVooSg3yCtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQZ98IDODp8ez6bC41BWGy+/kKYDs7pNN/z7IHkCCNdMJSwPI
	ALDXmR5621e83bEAo5fpEVlgRMuIO/6fjxafMCSTrlEeFKLh4sMlcK1M1HpVxjk=
X-Gm-Gg: ASbGncuOEBYsw6hdpvxokYUK0ROoDYcm1kqk+AhFpAJFT4Zwf76XbrTNa+BZ5xdYk6m
	36GzeqcX4U0AODIR5dwiPNcNrXd1l6v3LB8mjSqGZZI7xfyhIeebbBWrES6HDKBomjIJx9UyuHd
	fK0ePsj9oDjGSXc7lsqgluzfrjHfDSyjxAFKOBP9ha+aZO2FeNM3r0e/qqJ5NB5SOSiPAUKNLJF
	pLu42bxyMycN2aQNzQM1MxcInIo+e18wD+KeBaOHiu2AAWnmlB4h/aZ+MqGJMS6Cy2WbNmE4Y5Y
	kugpz3uwi78H0ghk7bIgENyYuYVqfJgOirVHnuFYLinNDajhdAT13trqXPEoYWEq9xIv+D8=
X-Google-Smtp-Source: AGHT+IFzjv7gOhxIlYKzki//MDgxLr1bbaSAQ8+4rCN5g/EX04DUqqsl6qwUqnLiDJXhDadlRoad7Q==
X-Received: by 2002:a05:600c:4f86:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-43d4378b1bbmr53529905e9.8.1742467581376;
        Thu, 20 Mar 2025 03:46:21 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47c60sm44302855e9.13.2025.03.20.03.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:46:20 -0700 (PDT)
Message-ID: <f3670689-8b10-4665-aa1a-e54e1503b54e@ursulin.net>
Date: Thu, 20 Mar 2025 10:46:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] drm/sched: cleanup gpu_scheduler trace events
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
 <20250320095818.40622-5-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250320095818.40622-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/2025 09:58, Pierre-Eric Pelloux-Prayer wrote:
> A fence uniquely identify a job, so this commits updates the places
> where a kernel pointer was used as an identifier by:
> 
>     "fence=%llu:%llu"
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   .../gpu/drm/scheduler/gpu_scheduler_trace.h   | 45 ++++++++++---------
>   1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index 713df3516a17..21a85ee59066 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -36,28 +36,29 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
>   	    TP_ARGS(sched_job, entity),
>   	    TP_STRUCT__entry(
> -			     __field(struct drm_sched_entity *, entity)
> -			     __field(struct dma_fence *, fence)
> -			     __string(name, sched_job->sched->name)
>   			     __field(uint64_t, id)
> +			     __string(name, sched_job->sched->name)
>   			     __field(u32, job_count)
>   			     __field(int, hw_job_count)
>   			     __string(dev, dev_name(sched_job->sched->dev))
> +			     __field(u64, fence_context)
> +			     __field(u64, fence_seqno)
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->entity = entity;
>   			   __entry->id = sched_job->id;
> -			   __entry->fence = &sched_job->s_fence->finished;
>   			   __assign_str(name);
>   			   __entry->job_count = spsc_queue_count(&entity->job_queue);
>   			   __entry->hw_job_count = atomic_read(
>   				   &sched_job->sched->credit_count);
>   			   __assign_str(dev);
> +			   __entry->fence_context = sched_job->s_fence->finished.context;
> +			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> +

You add this blank line only to remove in the following patch.

Otherwise LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>   			   ),
> -	    TP_printk("dev=%s, entity=%p, id=%llu, fence=%p, ring=%s, job count:%u, hw job count:%d",
> -		      __get_str(dev), __entry->entity, __entry->id,
> -		      __entry->fence, __get_str(name),
> +	    TP_printk("dev=%s, id=%llu, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d",
> +		      __get_str(dev), __entry->id,
> +		      __entry->fence_context, __entry->fence_seqno, __get_str(name),
>   		      __entry->job_count, __entry->hw_job_count)
>   );
>   
> @@ -75,37 +76,39 @@ TRACE_EVENT(drm_sched_process_job,
>   	    TP_PROTO(struct drm_sched_fence *fence),
>   	    TP_ARGS(fence),
>   	    TP_STRUCT__entry(
> -		    __field(struct dma_fence *, fence)
> +		    __field(u64, fence_context)
> +		    __field(u64, fence_seqno)
>   		    ),
>   
>   	    TP_fast_assign(
> -		    __entry->fence = &fence->finished;
> +		    __entry->fence_context = fence->finished.context;
> +		    __entry->fence_seqno = fence->finished.seqno;
>   		    ),
> -	    TP_printk("fence=%p signaled", __entry->fence)
> +	    TP_printk("fence=%llu:%llu signaled",
> +		      __entry->fence_context, __entry->fence_seqno)
>   );
>   
>   TRACE_EVENT(drm_sched_job_wait_dep,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct dma_fence *fence),
>   	    TP_ARGS(sched_job, fence),
>   	    TP_STRUCT__entry(
> -			     __string(name, sched_job->sched->name)
> +			     __field(u64, fence_context)
> +			     __field(u64, fence_seqno)
>   			     __field(uint64_t, id)
> -			     __field(struct dma_fence *, fence)
> -			     __field(uint64_t, ctx)
> -			     __field(unsigned, seqno)
> +			     __field(u64, ctx)
> +			     __field(u64, seqno)
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __assign_str(name);
> +			   __entry->fence_context = sched_job->s_fence->finished.context;
> +			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
>   			   __entry->id = sched_job->id;
> -			   __entry->fence = fence;
>   			   __entry->ctx = fence->context;
>   			   __entry->seqno = fence->seqno;
>   			   ),
> -	    TP_printk("job ring=%s, id=%llu, depends fence=%p, context=%llu, seq=%u",
> -		      __get_str(name), __entry->id,
> -		      __entry->fence, __entry->ctx,
> -		      __entry->seqno)
> +	    TP_printk("fence=%llu:%llu, id=%llu depends on unsignalled fence=%llu:%llu",
> +		      __entry->fence_context, __entry->fence_seqno, __entry->id,
> +		      __entry->ctx, __entry->seqno)
>   );
>   
>   #endif /* _GPU_SCHED_TRACE_H_ */


