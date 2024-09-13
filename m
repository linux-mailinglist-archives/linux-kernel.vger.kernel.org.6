Return-Path: <linux-kernel+bounces-328263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE83978130
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309951F25F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9961D6C7A;
	Fri, 13 Sep 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="GXjW7jju"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC858AC4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234231; cv=none; b=kSXxVYREE0tgEuwEjYEEpj2z1noF/1u8m9D4sV5uCU0tjZyzRSp9xX5CMtDn70a6Q6rD5/6nA+fdbeuvyYE5rAfWTyE84k+8mRbGEf2EpsWU+DkHT7YA8n9wM9i5FkFhsIvsEoeR5K0Ql93xF1Uo0OAMvKOAxHOvXZipLmEPS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234231; c=relaxed/simple;
	bh=fIs2+cnFMBR0qKSDkATWAKwWJxVpi8399WV2MLGyKCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHpdqR2OuwtcR5V3mjnifFkUJtfgRR72aajRV10PkokOIDexm+IsE3hvKNFj5euVcTMuRNl5RxwXd0BDxDiQ7XUadVVScFLPk/CXnuNqmMmKyNmeW2zZ35fy5qj2DsYw06bQJCKZUs/C6cK1aG1TWH4/ytMRHgQUxlBTKu69YkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=GXjW7jju; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so20589445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1726234228; x=1726839028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyIkZw92zTMIkoyZjfpro72dWOk2ZO3xCBNd/rMb+Ds=;
        b=GXjW7jjui6ndj9WAZmN0e5wfo+xR1m156MVc25Z09s5cLMVJrrclk9HafHk/9GlzRz
         KQvkMfqcg/9tA28a/G9YrZvJBAC1vOBHFwhIKEKBp5zcLdScXhIsz6jfxRgpARgBH74w
         QvqvyxQbHUEIsJlyGNWtEKw2sYU9vBeF3byNl7iJl5vu6R1vBPSunIMduqJCxsSqnjsN
         jvU9qcyXzggFiTnyQqYhZ1MOGKBSOuqkUwgf1XejMfLEPpXBK0XpKZkX9ALoSQJdojp8
         MElgS4oC499Bg9BcxCHWBEuQD8YTf3zlgvc9iZ+wv4gzZ8Nk/h0B46sYBCqQwLdckqbW
         0J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234228; x=1726839028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyIkZw92zTMIkoyZjfpro72dWOk2ZO3xCBNd/rMb+Ds=;
        b=tPwKuvAr4+unrqOiv16XO2TVHuoJX3slLSkqto57EC+RN3LywbZchR8AcjKJygP4EV
         4op1IksfAgcBjzH2RqajZEBFwx9j+eLbOqt7+jRhR0xgwFxrtHQHYFep8BDJwgGERAzF
         EG81Z7PAmAv6N7f1vpUpwMYnyRJbiK/jMPA7FGVsWGCONe/Hy7jsPZa4ss+iURby0sMX
         K5yMgbQG1tAqymUFsSHz0SbEbGIwkGsZ8wEiOtM0IrnXEHCuITqwRmDxhlnIRiZfEL3l
         /IUYdJBMoFj8v8GPIny5uzDXYlrK/jvms4wxBkAd59I4lIvgj/GedEV/weRrFwWgtCgO
         RpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXldTn9SVhxgDgAd/7SkrDDGClbv/eHwlWcDKILeRHsvUKgD7wRx8InBtNe9tI5QoxQAgBUCrO7GPIBajM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHlcYUebSIEpADWS6u2SKzziezmRBQxmGf36G50cEn3tBJ4S7d
	kTz+671Iz1E5egB4sHTn79igTFV3l8savr4oSpi8byiM3SZmQh1FH30B4rdp9jE=
X-Google-Smtp-Source: AGHT+IFhJkrssEnzOwpYwkNWJeWce4Ib+xlm8U5jxaEgbK9Q8mguLyDlO/IQjvSYcnm+Q2dcvQjURQ==
X-Received: by 2002:a05:600c:46c5:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-42cdb538cb5mr45488105e9.4.1726234227242;
        Fri, 13 Sep 2024 06:30:27 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b002a9asm27503875e9.0.2024.09.13.06.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 06:30:26 -0700 (PDT)
Message-ID: <5404888b-3727-409d-90fe-530fbb8db24f@ursulin.net>
Date: Fri, 13 Sep 2024 14:30:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
To: Philipp Stanner <pstanner@redhat.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240828094133.17402-2-pstanner@redhat.com>
 <92a123f1-73c9-45a1-8e0a-af72dd0a70e7@ursulin.net>
 <8a646b5c871fe454d6f194a54fa65d67f3ae5366.camel@redhat.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <8a646b5c871fe454d6f194a54fa65d67f3ae5366.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/09/2024 13:30, Philipp Stanner wrote:
> On Fri, 2024-09-13 at 12:56 +0100, Tvrtko Ursulin wrote:
>>
>> Hi,
>>
>> On 28/08/2024 10:41, Philipp Stanner wrote:
>>> drm_sched_job_init() has no control over how users allocate struct
>>> drm_sched_job. Unfortunately, the function can also not set some
>>> struct
>>> members such as job->sched.
>>
>> job->sched usage from within looks like a bug. But not related to the
>> memset you add.
>>
>> For this one something like this looks easiest for a start:
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index ab53ab486fe6..877113b01af2 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -788,7 +788,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>>                    * or worse--a blank screen--leave a trail in the
>>                    * logs, so this can be debugged easier.
>>                    */
>> -               drm_err(job->sched, "%s: entity has no rq!\n",
>> __func__);
>> +               pr_err("%s: entity has no rq!\n", __func__);
>>                   return -ENOENT;
>>           }
>>
>> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to
>> variable
>> number of run-queues")
>> Cc: <stable@vger.kernel.org> # v6.7+
> 
> Danilo and I already solved that:
> 
> https://lore.kernel.org/all/20240827074521.12828-2-pstanner@redhat.com/

Ah.. I saw the link to this in your maintainership thread and 
superficially assumed it is among the pending stuff. All good.

>>
>>> This could theoretically lead to UB by users dereferencing the
>>> struct's
>>> pointer members too early.
>>
>> Hmm if drm_sched_job_init returned an error callers should not
>> dereference anything. What was actually the issue you were debugging?
> 
> I was learning about the scheduler, wrote a dummy driver and had
> awkward behavior. Turned out it was this pointer not being initialized.
> I would have seen it immediately if it were NULL.
> 
> The actual issue was and is IMO that a function called
> drm_sched_job_init() initializes the job. But it doesn't, it only
> partially initializes it. Only after drm_sched_job_arm() ran you're
> actually ready to go.

In my experience one good approach when developing stuff is to have the 
various kernel debugging aids enabled. Lockdep, SLAB debugging, memory 
poisoning, kfence.. Then if you were allocating your job without 
GFP_ZERO, _and_ dereferencing something too early out of 
misunderstanding of the API, you would get something obvious in the oops 
and not a random pointer.

Which also applies to various CI systems, such as the Intel's one which 
already runs a debug kernel and a lot of these mistakes are caught 
instantly.

>> Adding a memset is I think not the best solution since it is very
>> likely
>> redundant to someone doing a kzalloc in the first place.
> 
> It is redundant in most cases, but it is effectively for free. I
> measured the runtime with 1e6 jobs with and without memset and there
> was no difference.

I guess if kzalloc and drm_sched_job_init() are close enough in time so 
that cachelines stays put, and depending how you measure, it may be hard 
to see but cost if still there.

For instance 
https://lore.kernel.org/amd-gfx/20240813140310.82706-1-tursulin@igalia.com/ 
I can see with perf that both memsets are hotspots even when testing 
with glxgears and vsync off.

But I don't feel too strongly about this and there definitely is sense 
in initializing everything. Perhaps even instead of a memset we should 
use correct methods per field? Since in there we have spcs_node, 
atomic_t, ktime_t, dma_fence_cb (even in an annoying union), 
drm_sched_priority.. In an ideal world all those would have their 
initializers. But some don't so meh.

Regards,

Tvrtko

>>> It is easier to debug such issues if these pointers are initialized
>>> to
>>> NULL, so dereferencing them causes a NULL pointer exception.
>>> Accordingly, drm_sched_entity_init() does precisely that and
>>> initializes
>>> its struct with memset().
>>>
>>> Initialize parameter "job" to 0 in drm_sched_job_init().
>>>
>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>>> ---
>>> No changes in v2.
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 356c30fa24a8..b0c8ad10b419 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -806,6 +806,14 @@ int drm_sched_job_init(struct drm_sched_job
>>> *job,
>>>    		return -EINVAL;
>>>    	}
>>>    
>>> +	/*
>>> +	 * We don't know for sure how the user has allocated.
>>> Thus, zero the
>>> +	 * struct so that unallowed (i.e., too early) usage of
>>> pointers that
>>> +	 * this function does not set is guaranteed to lead to a
>>> NULL pointer
>>> +	 * exception instead of UB.
>>> +	 */
>>> +	memset(job, 0, sizeof(*job));
>>> +
>>>    	job->entity = entity;
>>>    	job->credits = credits;
>>>    	job->s_fence = drm_sched_fence_alloc(entity, owner);
>>
> 

