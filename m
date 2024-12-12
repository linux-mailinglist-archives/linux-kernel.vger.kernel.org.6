Return-Path: <linux-kernel+bounces-443443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013049EF035
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4458828AD18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D023F9F0;
	Thu, 12 Dec 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm+blYb8"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27854229691;
	Thu, 12 Dec 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020103; cv=none; b=pSCFq6dhbAJdp9OXj4jsRcqm6TLVSugqgRrQyyUboblgm9iNuMnaV8INH0uxkIwA1Nc2U4duzHTm4TgjvTjJHCBGGkbXDa+ErSbgQwTXGyWCXDAeIUNOsrZMDUPREodOICFepNUF3el3ivo+a0xqAxEbU6Zg/wFIZY9c18oVBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020103; c=relaxed/simple;
	bh=xvm8WTEVJbtjV35JOyw/OnGZ2/zRrgpJ7ldAlziPeTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS2npu6jHzJgAllDUkeRSgvJPtxR9fnDY4cadD4LvPYgiISDLamGaNX0aMCmfRVy1poEJU2jCtqxLgcXaPHv5eb9KcqWKEZDLPk9KzrY+Cc9Ocda0//X48R3RjNVZGEtZ2YwGlFfvinB134B+C1lRhEA+U1zM7eFojoOLV3uZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm+blYb8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso1438069a12.1;
        Thu, 12 Dec 2024 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020099; x=1734624899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMUdVIB3AtcFCaaGIkOJI69lVFENlEwSIjeKiRPfszE=;
        b=nm+blYb84QMeZSn0Z1iyVpDs0S+7EK15bXvAPctVpYISNCQlth5tLSo//eEweTvUib
         g/W00d9SUt9d5BT7oRxhiepjHld8RIsT8KO3Vjd4fQV8PKvQC4fP+XuvIupTBMrnoBVO
         FjYKOjxq2EwNdwW8aWm2HSsyox7A7AcxE91OoaWu9ZnS1DK7vF+Zol+Q+j8hlDTH5Ipe
         IpBh8t0+Ukfjwl3okYuhFMgc+3g8FtgCKY/GFuiv1EczlBMqIU8l26SgeLBZtcLSWaCb
         byOi76PDzMBXj5tgirkRuPhQ8KddyWQThPtCpG0ZODqWKsXXe3IEPR5D3NEY4QgIxcoq
         ZlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020099; x=1734624899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMUdVIB3AtcFCaaGIkOJI69lVFENlEwSIjeKiRPfszE=;
        b=qZiEC3FFCaXuQpL4NT981IsgUd9W5f+r+EnneP7VCjbnOeJsXw6Vr1E8W+2eKRn1j9
         iAi6SOXxS/gpwR1lzlGAKWcQrwbTCvbnpHuQlDfb7C4xhmGNtAlVk0GyVia7NZTAG9PN
         XDPF0WMFEb6Rom8LAecW4pZ9+UuMZvbmPzNYydWTKXPwDGIz4ttzI53U1L27fIhm9qg+
         m0zT8XjYooZ8xL6CDXycnn+HOurfdMAVo0o4rT9j0yCh0i7AQFk0y2Ut7LMDJwABEL4c
         laEZrudNtir62sHFUuunvS3O+612ZMCYKzcEDvzMt+Z2el168FDjC8SfAtD+CaXBnxEX
         YmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVK23UfWfS731Xj4jHKa9aH7HvffdvDqpNZmOipOs5Rt5MFF5OxvoD7q5YeQRocpR1LMlbikdUGViSmBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPbqHvk24dzW0HX5kYihdT9vV5zvAaaonS3QTbuifHfXk0aXq
	azFhno9Z/auQUZ4tIKajsM29fassT1ui79YLzBKHANyJqH8lTsS4
X-Gm-Gg: ASbGncsqTqQFa5Z2RwSB6A2l3ej9dv++DwzDkF3wdKcTxDJX3dT/w74ZGRhuw4huPfU
	S3xuiPqlFpOVJ3fsDs8YOriaL6vmi4auj9WREa5b68s7WF3JgW9qfcz60Bx90E+BhUa5tL65KUy
	gQ7SC+sM+n+mmIZUhCRT8YO0S6iduR6LT3gQtqb36HAD51wkhq9c2h7vhSm7UyW9dtoOhqxUx2n
	FBBLFnQjsKMMAzsirsTwlHj2T7zzAC+xkkkQKjDmH39mipn5tDH3TzzkYgcZCIkBoFEgft7Qpr5
	W0DZ5GWlegYhc8p+l9V3CynmJfDkq00o9w==
X-Google-Smtp-Source: AGHT+IHM6XB+NK/56Od2+MsZ/v5P1u5lWdb4RkRk+r1oDjsBuk6MSDLp9BjCs7i6WF3LHC+MEEMX8A==
X-Received: by 2002:a05:6402:3709:b0:5d3:d2d0:12c9 with SMTP id 4fb4d7f45d1cf-5d635791f35mr991927a12.8.1734020098890;
        Thu, 12 Dec 2024 08:14:58 -0800 (PST)
Received: from [192.168.1.17] (host-87-20-169-101.retail.telecomitalia.it. [87.20.169.101])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e86c14ffsm7401135a12.84.2024.12.12.08.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 08:14:58 -0800 (PST)
Message-ID: <de6cfac6-84a0-4160-b279-c23e10f96872@gmail.com>
Date: Thu, 12 Dec 2024 17:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/msm: Add UABI to request perfcntr usage
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, Rob Clark
 <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 open list <linux-kernel@vger.kernel.org>
References: <20241205165419.54080-1-robdclark@gmail.com>
 <eca60b8e-8a8a-41c4-816a-d084822646f1@quicinc.com>
Content-Language: en-US
From: Antonino Maniscalco <antomani103@gmail.com>
In-Reply-To: <eca60b8e-8a8a-41c4-816a-d084822646f1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 4:58 PM, Akhil P Oommen wrote:
> On 12/5/2024 10:24 PM, Rob Clark wrote:
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Performance counter usage falls into two categories:
>>
>> 1. Local usage, where the counter configuration, start, and end read
>>     happen within (locally to) a single SUBMIT.  In this case, there is
>>     no dependency on counter configuration or values between submits, and
>>     in fact counters are normally cleared on context switches, making it
>>     impossible to rely on cross-submit state.
>>
>> 2. Global usage, where a single privilaged daemon/process is sampling
>>     counter values across all processes for profiling.
>>
>> The two categories are mutually exclusive.  While you can have many
>> processes making local counter usage, you cannot combine global and
>> local usage without the two stepping on each others feet (by changing
>> counter configuration).
>>
>> For global counter usage, there is already a SYSPROF param (since global
>> counter usage requires disabling counter clearing on context switch).
>> This patch adds a REQ_CNTRS param to request local counter usage.  If
>> one or more processes has requested counter usage, then a SYSPROF
>> request will fail with -EBUSY.  And if SYSPROF is active, then REQ_CNTRS
>> will fail with -EBUSY, maintaining the mutual exclusivity.
>>
>> This is purely an advisory interface to help coordinate userspace.
>> There is no real means of enforcement, but the worst that can happen if
>> userspace ignores a REQ_CNTRS failure is that you'll get nonsense
>> profiling data.
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>> kgsl takes a different approach, which involves a lot more UABI for
>> assigning counters to different processes.  But I think by taking
>> advantage of the fact that mesa (freedreno+turnip) reconfigure the
>> counters they need in each SUBMIT, for their respective gl/vk perf-
>> counter extensions, we can take this simpler approach.
> 
> KGSL's approach is preemption and ifpc safe (also whatever HW changes
> that will come up in future generations). How will we ensure that here?
> 
> I have plans to bring up IFPC support in near future. Also, I brought up
> this point during preemption series. But from the responses, I felt that
> profiling was not considered a serious usecase. Still I wonder how the
> perfcounter extensions work accurately with preemption.

So back then I implemented the postamble IB to clear perf counters and 
that gets disabled when sysprof (so global usage) is happening. The 
kernel is oblivious to "Local isage" of profiling but in that case 
really what we want to do is disable preemption which in my 
understanding can be done from userspace with a PKT. In my understanding 
this had us covered for all usecases.

So what would you expect instead we should do kernel side to make 
profiling preemption safe?

> 
> -Akhil
> 
>>
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 +
>>   drivers/gpu/drm/msm/msm_drv.c           |  5 ++-
>>   drivers/gpu/drm/msm/msm_gpu.c           |  1 +
>>   drivers/gpu/drm/msm/msm_gpu.h           | 29 +++++++++++++-
>>   drivers/gpu/drm/msm/msm_submitqueue.c   | 52 ++++++++++++++++++++++++-
>>   include/uapi/drm/msm_drm.h              |  1 +
>>   6 files changed, 85 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> index 31bbf2c83de4..f688e37059b8 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> @@ -441,6 +441,8 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>>   		if (!capable(CAP_SYS_ADMIN))
>>   			return UERR(EPERM, drm, "invalid permissions");
>>   		return msm_file_private_set_sysprof(ctx, gpu, value);
>> +	case MSM_PARAM_REQ_CNTRS:
>> +		return msm_file_private_request_counters(ctx, gpu, value);
>>   	default:
>>   		return UERR(EINVAL, drm, "%s: invalid param: %u", gpu->name, param);
>>   	}
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>> index 6416d2cb4efc..bf8314ff4a25 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -377,9 +377,12 @@ static void msm_postclose(struct drm_device *dev, struct drm_file *file)
>>   	 * It is not possible to set sysprof param to non-zero if gpu
>>   	 * is not initialized:
>>   	 */
>> -	if (priv->gpu)
>> +	if (ctx->sysprof)
>>   		msm_file_private_set_sysprof(ctx, priv->gpu, 0);
>>   
>> +	if (ctx->counters_requested)
>> +		msm_file_private_request_counters(ctx, priv->gpu, 0);
>> +
>>   	context_close(ctx);
>>   }
>>   
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 82f204f3bb8f..013b59ca3bb1 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -991,6 +991,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>   	gpu->nr_rings = nr_rings;
>>   
>>   	refcount_set(&gpu->sysprof_active, 1);
>> +	refcount_set(&gpu->local_counters_active, 1);
>>   
>>   	return 0;
>>   
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
>> index e25009150579..83c61e523b1b 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.h
>> +++ b/drivers/gpu/drm/msm/msm_gpu.h
>> @@ -195,12 +195,28 @@ struct msm_gpu {
>>   	int nr_rings;
>>   
>>   	/**
>> -	 * sysprof_active:
>> +	 * @sysprof_active:
>>   	 *
>> -	 * The count of contexts that have enabled system profiling.
>> +	 * The count of contexts that have enabled system profiling plus one.
>> +	 *
>> +	 * Note: refcount_t does not like 0->1 transitions.. we want to keep
>> +	 * the under/overflow checks that refcount_t provides, but allow
>> +	 * multiple on/off transitions so we track the logical value plus one.)
>>   	 */
>>   	refcount_t sysprof_active;
>>   
>> +	/**
>> +	 * @local_counters_active:
>> +	 *
>> +	 * The count of contexts that have requested local (intra-submit)
>> +	 * performance counter usage plus one.
>> +	 *
>> +	 * Note: refcount_t does not like 0->1 transitions.. we want to keep
>> +	 * the under/overflow checks that refcount_t provides, but allow
>> +	 * multiple on/off transitions so we track the logical value plus one.)
>> +	 */
>> +	refcount_t local_counters_active;
>> +
>>   	/**
>>   	 * lock:
>>   	 *
>> @@ -383,6 +399,13 @@ struct msm_file_private {
>>   	 */
>>   	int sysprof;
>>   
>> +	/**
>> +	 * @counters_requested:
>> +	 *
>> +	 * Has the context requested local perfcntr usage.
>> +	 */
>> +	bool counters_requested;
>> +
>>   	/**
>>   	 * comm: Overridden task comm, see MSM_PARAM_COMM
>>   	 *
>> @@ -626,6 +649,8 @@ void msm_submitqueue_destroy(struct kref *kref);
>>   
>>   int msm_file_private_set_sysprof(struct msm_file_private *ctx,
>>   				 struct msm_gpu *gpu, int sysprof);
>> +int msm_file_private_request_counters(struct msm_file_private *ctx,
>> +				      struct msm_gpu *gpu, int reqcntrs);
>>   void __msm_file_private_destroy(struct kref *kref);
>>   
>>   static inline void msm_file_private_put(struct msm_file_private *ctx)
>> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
>> index 7fed1de63b5d..1e1e21e6f7ae 100644
>> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
>> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
>> @@ -10,6 +10,15 @@
>>   int msm_file_private_set_sysprof(struct msm_file_private *ctx,
>>   				 struct msm_gpu *gpu, int sysprof)
>>   {
>> +	int ret = 0;
>> +
>> +	mutex_lock(&gpu->lock);
>> +
>> +	if (sysprof && (refcount_read(&gpu->local_counters_active) > 1)) {
>> +		ret = UERR(EBUSY, gpu->dev, "Local counter usage active");
>> +		goto out_unlock;
>> +	}
>> +
>>   	/*
>>   	 * Since pm_runtime and sysprof_active are both refcounts, we
>>   	 * call apply the new value first, and then unwind the previous
>> @@ -18,7 +27,8 @@ int msm_file_private_set_sysprof(struct msm_file_private *ctx,
>>   
>>   	switch (sysprof) {
>>   	default:
>> -		return UERR(EINVAL, gpu->dev, "Invalid sysprof: %d", sysprof);
>> +		ret = UERR(EINVAL, gpu->dev, "Invalid sysprof: %d", sysprof);
>> +		goto out_unlock;
>>   	case 2:
>>   		pm_runtime_get_sync(&gpu->pdev->dev);
>>   		fallthrough;
>> @@ -43,7 +53,45 @@ int msm_file_private_set_sysprof(struct msm_file_private *ctx,
>>   
>>   	ctx->sysprof = sysprof;
>>   
>> -	return 0;
>> +out_unlock:
>> +	mutex_unlock(&gpu->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +int msm_file_private_request_counters(struct msm_file_private *ctx,
>> +				      struct msm_gpu *gpu, int reqctrs)
>> +{
>> +	int ret = 0;
>> +
>> +	mutex_lock(&gpu->lock);
>> +
>> +	if (reqctrs && (refcount_read(&gpu->sysprof_active) > 1)) {
>> +		ret = UERR(EBUSY, gpu->dev, "System profiling active");
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (reqctrs) {
>> +		if (ctx->counters_requested) {
>> +			ret = UERR(EINVAL, gpu->dev, "Already requested");
>> +			goto out_unlock;
>> +		}
>> +
>> +		ctx->counters_requested = true;
>> +		refcount_inc(&gpu->local_counters_active);
>> +	} else {
>> +		if (!ctx->counters_requested) {
>> +			ret = UERR(EINVAL, gpu->dev, "Not requested");
>> +			goto out_unlock;
>> +		}
>> +		refcount_dec(&gpu->local_counters_active);
>> +		ctx->counters_requested = false;
>> +	}
>> +
>> +out_unlock:
>> +	mutex_unlock(&gpu->lock);
>> +
>> +	return ret;
>>   }
>>   
>>   void __msm_file_private_destroy(struct kref *kref)
>> diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
>> index 2342cb90857e..ae7fb355e4a1 100644
>> --- a/include/uapi/drm/msm_drm.h
>> +++ b/include/uapi/drm/msm_drm.h
>> @@ -91,6 +91,7 @@ struct drm_msm_timespec {
>>   #define MSM_PARAM_UBWC_SWIZZLE 0x12 /* RO */
>>   #define MSM_PARAM_MACROTILE_MODE 0x13 /* RO */
>>   #define MSM_PARAM_UCHE_TRAP_BASE 0x14 /* RO */
>> +#define MSM_PARAM_REQ_CNTRS  0x15 /* WO: request "local" (intra-submit) perfcntr usage  */
>>   
>>   /* For backwards compat.  The original support for preemption was based on
>>    * a single ring per priority level so # of priority levels equals the #
> 


Best regards,
-- 
Antonino Maniscalco <antomani103@gmail.com>

