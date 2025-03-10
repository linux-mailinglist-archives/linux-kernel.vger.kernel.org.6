Return-Path: <linux-kernel+bounces-553907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC93A59079
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562AC3A65F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56428224B08;
	Mon, 10 Mar 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCJFFEjr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95872225A24
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600601; cv=none; b=lK1PQrPkgYph81QgZBmImkKzfLyJ8MPXKk1Cg7bxe1eLacvqC/YlfdlIcJTLVGkvtTsxgduRRbj57E4cojhDVpYdPmfbU/UcotP2rhL/BfjJVX3YCcYBZd44QBlzL94u6ie6os/bJyh9GqG5rGFsFUTbSnpbDV52t8QO6K9YSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600601; c=relaxed/simple;
	bh=JRpyEvr7MUqbtGBW99bQ7FDSIZNDOh1irH+KfGTPSm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XE4u12f5VGKF8F2epZXtJh20o9FqRdbbz+iJhoQ8dLqYKcGvDPjXRpZ1CJ3UFdek8tu74GovQfKw8YN61rbWHMg8rj2/YVQmhG+Gch8wxhaE+bz0aVKRiPSYGenDe+tkI/8PoEogM1aUNFq5SlMzYAxnwd4G17O4q4mB7X+Sw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCJFFEjr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f403edb4eso2132481f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741600598; x=1742205398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vID61GIkIDMW8pPTgroYzl1dfmYmLe/cwdAmJLdVfrc=;
        b=ZCJFFEjrTkC1/0Qt3QE3nnj3df+te4DZJnkkqR/Yeo6PddRBdZ3ToiCydiJIv80Gdr
         CuGbSJ/TQ0qvaWWBqHDjaxc/t/g5xk6TNfZEV+2zqTCb/Ixacik1n9O9++UytLE82Nzu
         hMXQ8beCLPrBTZCTbqBfi4bziIdOyaq8ePEcQuaOVr6C5mi1X/8mFhZjf4nViJ13bt1J
         qNk3u36iYJaHM5++A4glnGnuexCHujpFZV3PSGBhtlwIk10ZmKUsI4fZxzb0bBn3Ep6+
         xxv4spEdBjvomJ7/eccSildv559FTpPdj0B9h7vVPrbaOk0JrRET5uzuUJolTgcAfoCN
         OfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600598; x=1742205398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vID61GIkIDMW8pPTgroYzl1dfmYmLe/cwdAmJLdVfrc=;
        b=NzZOEvIgEYmP5LRTkbJPlBsclx3f1KXIQkoaw3zp055xhT4zij+YN0REQu07f4Ebpy
         7mjzSO5snuS91NHqnyWVz4MfQrpnxcK0PK07QIsklD4Xc6wJ56tKB+ZogYJFEKYyR8zO
         Iw3WCalnSadzUoZN5mqx/U5IZXerlWRTsMwiBA/4uncOIEE6ki9yvTGIvOTIOCoEOnqE
         tC4OA27/iWo+jBDl8Cat69Dxqw6pH3XYIANGFPDrNe74qCurEsvyDoV62NBYB+0zMsyI
         JbUOQkp4R5kpHUsiUADlpIet4guLgCBGjq0J1hLGEWooUrm0Y3XUhLf3Ct/HF4z4nEvc
         f0tw==
X-Forwarded-Encrypted: i=1; AJvYcCUi96JkadCGMKh2Kg9zxwDpjkPquf48bqVU4Bd23vAUTUHwEpZ36hwOQyn8123wKeXBNTO1ZOWt4QeofVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lyTAR1jjPfYN1GDVGM4NUW/OzyDnfZ56vW9aZ7GKo/tf8Mwk
	FaNsVsYhCb4ft2S4jhmc2y6E91wsvN+/9elkpLg0Zi4eRYTCP2MJ
X-Gm-Gg: ASbGnctLIfQrgFcwCQlX63WTXL9cbRh3SoskRp+jK+k2Mcw7RgsHDo3bT7RjTPQ5Wc1
	8tQtBHQMTsxmTAEZxVgrXfV0ZOdQ2snmYXjsaZq8VohEZ5BBWa3gTxl1PvTdvBY2Bw71iu6Kf90
	kQ+GtlD8p0gS47bc4+R4/Ib6QyhxFEQsqWg/LoXUvdxtl+4skAN6lDOzEqpQa5SWVd2tcL5KY/+
	yloOM+RtgXDvD04Wae3wWcAXb9WczvmefBM83xlqqKM8dEuKLp+N0STz3j2t4WYhu2TMG6DljYc
	rex1UymD7XUD1x9QGK0tlyeuL88aLkPPyBvUyCuZeOfBUk/8ky2mMfZ2YY5jjx3CWz/2e3+JNA=
	=
X-Google-Smtp-Source: AGHT+IF1YNcz5yu7cikYuEyUTudT7kaZPD/iwTorPAEsnp+8VhcciviAqxqQhGNErUbrhAMDho5OoA==
X-Received: by 2002:a5d:5f89:0:b0:391:253b:4046 with SMTP id ffacd0b85a97d-39132d3331bmr9845300f8f.16.1741600597614;
        Mon, 10 Mar 2025 02:56:37 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm78351955e9.1.2025.03.10.02.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:56:37 -0700 (PDT)
Message-ID: <3d770f3e-9600-41a0-86c4-84700f7cc8f5@gmail.com>
Date: Mon, 10 Mar 2025 10:56:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: revert "drm_sched_job_cleanup(): correct false
 doc"
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org,
 matthew.brost@intel.com, dakr@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250310074414.2129157-1-christian.koenig@amd.com>
 <cb3745c15e5e2c3a2b03e47a56d2e4db555664b5.camel@mailbox.org>
 <37a58172-c2fa-4942-bafa-d96be85cd26f@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <37a58172-c2fa-4942-bafa-d96be85cd26f@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 10.03.25 um 10:30 schrieb Tvrtko Ursulin:
>
> On 10/03/2025 08:41, Philipp Stanner wrote:
>> On Mon, 2025-03-10 at 08:44 +0100, Christian König wrote:
>>> This reverts commit 44d2f310f008613c1dbe5e234c2cf2be90cbbfab.
>>>
>>> Sorry for the delayed response, I only stumbled over this now while
>>> going
>>> over old mails and then re-thinking my reviewed by for this change.
>>>
>>> The function drm_sched_job_arm() is indeed the point of no return.
>>
>> So would you say that the comment in the function's body,
>> "drm_sched_job_arm() has been called" actually means / should mean "job
>> had been submitted with drm_sched_entity_push_job()"?

Yes, probably. The problem is simply that we need to guarantee correct order of signaling for the dma_fence.

Otherwise functions like dma_fence_is_later()/dma_fence_later() start to blow up and we run into potential use after free problems.

>>
>>> The
>>> background is that it is nearly impossible for the driver to
>>> correctly
>>> retract the fence and signal it in the order enforced by the
>>> dma_fence
>>> framework.
>>>
>>> The code in drm_sched_job_cleanup() is for the purpose to cleanup
>>> after
>>> the job was armed through drm_sched_job_arm() *and* processed by the
>>> scheduler.
>>>
>>> The correct approach for error handling in this situation is to set
>>> the
>>> error on the fences and then push to the entity anyway.
>>
>> You expect the driver to set an error on scheduled and finished fence?

Ideally we would avoid that as well. In general drivers should be coded so that after calling drm_sched_job_arm() nothing can go wrong any more.

Setting an error on either the scheduler or the finished fence is basically just the last resort if we can't really avoid any error handling.

>> I think this would be very likely to explode. AFAICS the scheduler code
>> has no awareness for anyone else having touched those fences.

Yeah that is probably not well handled today.

>>
>> If at all, if this is really a problem, we should tell the driver that
>> it must enforce that there will be no failure between
>> drm_sched_job_arm() and drm_sched_job_entity_push_job(). That's how
>> Nouveau does it.
>
> On top of Philipp's questions - I just want to raise that amdgpu_cs_submit then also needs explaining. I always take amdgpu as kind of almost reference, since that is where scheduler originated from. And in there there is definitely the path of drm_sched_job_cleanup() called after drm_sched_job_arm() when adding gang dependencies fails.

Oh shit, yeah that doesn't work correctly at all. The user pages handling is completely broken as well.

Thanks for pointing that out.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>
>> Let's set our understanding straight before reverting. What
>> drm_sched_job_arm() does is:
>>
>>     1. Pick scheduler, rq and priority for the job
>>     2. Atomically increment the job_id_count and assign to job
>>     3. Call drm_sched_fence_init() and therefore:
>>     4. Set the fence's scheduler
>>     5. Set the fences seq nr atomically
>>     6. Initialize scheduled and finished fence
>>
>> What of the above precisely is the problem?
>>
>> You say the driver cannot "correctly retract the fence and signal it in
>> the order enforced by the dma_fence framework". You mean that the
>> finished_fences have to be signalled in an order only the scheduler
>> knows? I assume you're referring to set dependencies?
>>
>> P.
>>
>>> We can certainly
>>> improve the documentation, but removing the warning is clearly not a
>>> good
>>> idea.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/sched_main.c | 12 +++++-------
>>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 53e6aec37b46..4d4219fbe49d 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -1015,13 +1015,11 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>>>    * Cleans up the resources allocated with drm_sched_job_init().
>>>    *
>>>    * Drivers should call this from their error unwind code if @job is
>>> aborted
>>> - * before it was submitted to an entity with
>>> drm_sched_entity_push_job().
>>> + * before drm_sched_job_arm() is called.
>>>    *
>>> - * Since calling drm_sched_job_arm() causes the job's fences to be
>>> initialized,
>>> - * it is up to the driver to ensure that fences that were exposed to
>>> external
>>> - * parties get signaled. drm_sched_job_cleanup() does not ensure
>>> this.
>>> - *
>>> - * This function must also be called in &struct
>>> drm_sched_backend_ops.free_job
>>> + * After that point of no return @job is committed to be executed by
>>> the
>>> + * scheduler, and this function should be called from the
>>> + * &drm_sched_backend_ops.free_job callback.
>>>    */
>>>   void drm_sched_job_cleanup(struct drm_sched_job *job)
>>>   {
>>> @@ -1032,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job
>>> *job)
>>>    /* drm_sched_job_arm() has been called */
>>>    dma_fence_put(&job->s_fence->finished);
>>>    } else {
>>> - /* aborted job before arming */
>>> + /* aborted job before committing to run it */
>>>    drm_sched_fence_free(job->s_fence);
>>>    }
>>>   
>>
>


