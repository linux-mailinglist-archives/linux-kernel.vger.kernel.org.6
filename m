Return-Path: <linux-kernel+bounces-358722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907399982D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8231281E28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF81BE86F;
	Thu, 10 Oct 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="N99B/jmO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550621BD515
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553855; cv=none; b=nsOV98Y4nt++4Ko6JUyqFNo0UKnMDfQ3Yna/FKCdvrDjM3NJMV5oqxEZcmcRwT9B2EkgOJz51uNrGU+q3nI+KclCpoD6j4SwskQSoB7l/SA6blNT/25TRr6xu1uwZT6my1IvBH/Mv2zXVZPdQE9xfGku+d1JcyByesPkDd0LeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553855; c=relaxed/simple;
	bh=RatYakUmtGu/I9hrRyo88mbnBtt3WqMWaQ2Zg0QiGnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApokcGeh8dHwj8Lskbd3kwOZuLiVDwMMmA6df8wxcdxEz1rsvV62ggS2FGZA0u5y5xd0d8rHZrfqCUdvcF6OKdNcHufRZG5KV9MRIdcTyQK2+qeD0F0hOOlRocpy5qfxvv8jKFXCyCa/Kua4aeLzK9I/6rgpM0O7ksqPu/ltv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=N99B/jmO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430576ff251so6218065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1728553850; x=1729158650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBHunO+Zz8TdiQTG9vtmDBYUCelVKI0y/eeya9uFaOU=;
        b=N99B/jmOmOaCd7Js4R7Ksag1UJAJTX9VvJc8WJvvVcG1Ft2/loVjygpk8WoTL5WtDh
         COIhvM4t58HnMNtemJJFtLUtTfUMpynxchePsJpOh4FPwCIWle5TLiSAkpMTfHibExtP
         kifHvowGp3GHBM6/TfBmttIaeLhoZLhFS4z09+q4w12ek8HIAh5jXHYuWlLFH7pNlUHt
         T1qC1n1OREg/wBRLz3bvXfl1o+QFouyREV8Lpv3MFZURaFvmPvxIJmJBBIZdNc/W+1Xg
         P/IpySmkWGrA35ENWqZi1fC/d4kCZpObYj8njVYff0GOdmaJo5SOAWpLixAA5fGJBwjW
         Xpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553850; x=1729158650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBHunO+Zz8TdiQTG9vtmDBYUCelVKI0y/eeya9uFaOU=;
        b=D/SjxO6G1UL2OHUAZnbO9QdhkzIDjyXTyov+l71qSq5SQt6yObjyet6VfNxNxWfePb
         yxJasrfzdr7IN43rDNmiJecClQcBLHx6hfvkC/c+V70tjLrWWmoxafM51JMNJw1OrypQ
         eHmlQc3Ut6soVUtjrWYd84kKJxu3xYQSjOUPhrTu6jsFPHPrG7sVJjO22BkMWTphLybm
         Xlpw9bjXVWFk2gAjGWFoE7aU80QCDvpsjSyzsjQvpALllfsjA0MlT1VZbw9LlxMSPM8P
         uId6F/lh9urIupq3VR8mKgzKitrBq/M48pE4dS8nQRoBJsVqcy7uBZPJNaHAu2zOdtxm
         /F2A==
X-Forwarded-Encrypted: i=1; AJvYcCVCXyw0FaYvAOhiGJFrkdE4FHlHfafhCJjXnIOGV66jH9GXMHfaowQgDG65RJt3DkPq9zqwnqE379aoS90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTA7aOGNU828D1bOlsPEoHb/AW58KKOIYF84GNl2VxO5msd+n/
	vRe6jnd/8Sc0qIT0Jwe2yyKUMvx5L95voVKDzr1MluU1d5J26F7NeS/H+a9/Jb4=
X-Google-Smtp-Source: AGHT+IFbMglBOaa77JYEQSIkwOuvW3U8Pg8Eka/aETTOJlI14e6FrPvdON50DpF1jbrure9vikjykw==
X-Received: by 2002:a05:600c:a00a:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-431157e55acmr27493495e9.26.1728553850511;
        Thu, 10 Oct 2024 02:50:50 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffc75sm10971435e9.17.2024.10.10.02.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:50:50 -0700 (PDT)
Message-ID: <87a21c19-8fd2-492a-a620-243cd9c642dc@ursulin.net>
Date: Thu, 10 Oct 2024 10:50:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/drm_file: Add display of driver's internal
 memory size
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20241002234531.3113431-1-adrian.larumbe@collabora.com>
 <20241002234531.3113431-2-adrian.larumbe@collabora.com>
 <6657b080-f41e-4c95-8895-e474f1ca5d57@ursulin.net>
 <p72rfjerzsg4wsp6rgfcoo5fmlu77jmzdynosflj2hlos63pql@mnetv3t66wsc>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <p72rfjerzsg4wsp6rgfcoo5fmlu77jmzdynosflj2hlos63pql@mnetv3t66wsc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/10/2024 23:55, Adrián Larumbe wrote:
> Hi Tvrtko,
> 
> On 04.10.2024 14:41, Tvrtko Ursulin wrote:
>>
>> Hi Adrian,
>>
>> On 03/10/2024 00:45, Adrián Larumbe wrote:
>>> Some drivers must allocate a considerable amount of memory for bookkeeping
>>> structures and GPU's MCU-kernel shared communication regions. These are
>>> often created as a result of the invocation of the driver's ioctl()
>>> interface functions, so it is sensible to consider them as being owned by
>>> the render context associated with an open drm file.
>>>
>>> However, at the moment drm_show_memory_stats only traverses the UM-exposed
>>> drm objects for which a handle exists. Private driver objects and memory
>>> regions, though connected to a render context, are unaccounted for in their
>>> fdinfo numbers.
>>>
>>> Add a new drm_memory_stats 'internal' memory category.
>>>
>>> Because deciding what constitutes an 'internal' object and where to find
>>> these are driver-dependent, calculation of this size must be done through a
>>> driver-provided function pointer, which becomes the third argument of
>>> drm_show_memory_stats. Drivers which have no interest in exposing the size
>>> of internal memory objects can keep passing NULL for unaltered behaviour.
>>>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> Cc: Rob Clark <robdclark@gmail.com>
>>> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>>    drivers/gpu/drm/drm_file.c              | 6 +++++-
>>>    drivers/gpu/drm/msm/msm_drv.c           | 2 +-
>>>    drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>>>    drivers/gpu/drm/v3d/v3d_drv.c           | 2 +-
>>>    include/drm/drm_file.h                  | 7 ++++++-
>>>    5 files changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>>> index ad1dc638c83b..937471339c9a 100644
>>> --- a/drivers/gpu/drm/drm_file.c
>>> +++ b/drivers/gpu/drm/drm_file.c
>>> @@ -856,6 +856,7 @@ void drm_print_memory_stats(struct drm_printer *p,
>>>    	print_size(p, "total", region, stats->private + stats->shared);
>>>    	print_size(p, "shared", region, stats->shared);
>>>    	print_size(p, "active", region, stats->active);
>>> +	print_size(p, "internal", region, stats->internal);
>>>    	if (supported_status & DRM_GEM_OBJECT_RESIDENT)
>>>    		print_size(p, "resident", region, stats->resident);
>>> @@ -873,7 +874,7 @@ EXPORT_SYMBOL(drm_print_memory_stats);
>>>     * Helper to iterate over GEM objects with a handle allocated in the specified
>>>     * file.
>>>     */
>>> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>>> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file, internal_bos func)
>>>    {
>>>    	struct drm_gem_object *obj;
>>>    	struct drm_memory_stats status = {};
>>> @@ -919,6 +920,9 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>>>    	}
>>>    	spin_unlock(&file->table_lock);
>>> +	if (func)
>>> +		func(&status, file);
>>> +
>>>    	drm_print_memory_stats(p, &status, supported_status, "memory");
>>>    }
>>>    EXPORT_SYMBOL(drm_show_memory_stats);
>>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>>> index edbc1ab0fbc8..2b3feb79afc4 100644
>>> --- a/drivers/gpu/drm/msm/msm_drv.c
>>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>>> @@ -880,7 +880,7 @@ static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>>>    	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
>>> -	drm_show_memory_stats(p, file);
>>> +	drm_show_memory_stats(p, file, NULL);
>>>    }
>>>    static const struct file_operations fops = {
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> index 04d615df5259..aaa8602bf00d 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> @@ -609,7 +609,7 @@ static void panfrost_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>>>    	panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
>>> -	drm_show_memory_stats(p, file);
>>> +	drm_show_memory_stats(p, file, NULL);
>>>    }
>>>    static const struct file_operations panfrost_drm_driver_fops = {
>>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
>>> index fb35c5c3f1a7..314e77c67972 100644
>>> --- a/drivers/gpu/drm/v3d/v3d_drv.c
>>> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
>>> @@ -195,7 +195,7 @@ static void v3d_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>>>    			   v3d_queue_to_string(queue), jobs_completed);
>>>    	}
>>> -	drm_show_memory_stats(p, file);
>>> +	drm_show_memory_stats(p, file, NULL);
>>>    }
>>>    static const struct file_operations v3d_drm_fops = {
>>> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
>>> index 8c0030c77308..661d00d5350e 100644
>>> --- a/include/drm/drm_file.h
>>> +++ b/include/drm/drm_file.h
>>> @@ -469,6 +469,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
>>>     * @resident: Total size of GEM objects backing pages
>>>     * @purgeable: Total size of GEM objects that can be purged (resident and not active)
>>>     * @active: Total size of GEM objects active on one or more engines
>>> + * @internal: Total size of GEM objects that aren't exposed to user space
>>>     *
>>>     * Used by drm_print_memory_stats()
>>>     */
>>> @@ -478,16 +479,20 @@ struct drm_memory_stats {
>>>    	u64 resident;
>>>    	u64 purgeable;
>>>    	u64 active;
>>> +	u64 internal;
>>
>> So equally as in the last round of discussion back in June, internal in my
>> mind still does not fit alongside the categories.
>>
>> Reason is that in some drivers, at least such as i915, "internal" can be:
>>
>> a) Backed by either system memory or device memory - so this does not provice
>> that visibility;
>>
>> b) They can also be resident or not, active or not, etc - so from that angle
>> it also does not fit.
>>
>> Do you lose anything if you add the internal objects into their respective
>> regions and under the existing categories? Like do you have an use case in
>> mind which needs to be able to distinguish between userspace and internal, or
>> the problem simply is internal are unaccounted for?
> 
> The main use case we have in mind is exposing the size of driver buffer
> allocations that are triggered in respone to an ioctl(), and so linked to an

Most of this and below is old and clear - but to this specific point - 
so you do have an use case which specifically wants to know about the 
internal allocations separately from the rest? Could you describe what 
it is?

> open file. I gave a summary of what these could be in the patch description, but
> in Panthor's case all these allocations are done with drm shmem functions
> because it makes it easier to retrieve the sgtable that gives us their system
> memory layout so that we can more easily map them onto the MMU's address space
> for a Pantor VM. These BO's, though managed by the drm shmem API, are never
> added to the open file list of user-exposed drm objects but we would still like
> to tell UM how much memory they take up.
> 
> In the case of Panthor, they all add into the resident tally because all these
> internal BO's are immediately pinned so that they can also be accessed by the
> HW, but it doesn't have to be so for other drivers which might also keep track
> of similar allocations.
> 
> I think maybe naming that tag as 'internal' is a bit of a misnomer and I could
> pick one that more accurately represents its meaning? Something like 'file-internal'
> or else 'file-private'.
> 
> Regarding a), I don't think where the allocations happen (system or device memory)
> is relevant in this case, just that the allocations are tied to an open file, but
> not exposed to UM through a DRM buffer object handle.

On this last paragraph - right.. I possibly got confused on a). Which is 
why I always say it is good to include example output at least in the 
cover letter, if not the commit message.

How would it look on this driver?

drm-total-$what: ..
drm-resident-$what: ..
drm-internal-$what: ...

b) still stands though in that internal can be resident or not, 
purgeable or not.. Which is why I would like to know about the use case.

Also if you add drm-internal for any driver calling 
drm_print_memory_stats I think you "break" at least i915. There internal 
objects are already accounted in the existing categories. And printing 
out internal with zero would be very misleading.

Regards,

Tvrtko

> 
> Regards,
> Adrian
> 
>> Regards,
>>
>> Tvrtko
>>
>>>    };
>>>    enum drm_gem_object_status;
>>> +typedef void (*internal_bos)(struct drm_memory_stats *status,
>>> +			     struct drm_file *file);
>>> +
>>>    void drm_print_memory_stats(struct drm_printer *p,
>>>    			    const struct drm_memory_stats *stats,
>>>    			    enum drm_gem_object_status supported_status,
>>>    			    const char *region);
>>> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file);
>>> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file, internal_bos func);
>>>    void drm_show_fdinfo(struct seq_file *m, struct file *f);
>>>    struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);

