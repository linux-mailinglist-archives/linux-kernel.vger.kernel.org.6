Return-Path: <linux-kernel+bounces-543619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D8A4D798
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EAB1883E58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AE1FC7F6;
	Tue,  4 Mar 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4TsWd9d"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58B1FC7EE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079113; cv=none; b=XWsZdww/lFLF2Q7u2X3/RmiEVjiGxiCgKNtTLK6JeMQe2h6GTFBC0ykRJDMS6UJ1vCqeclysBwa/xfAjJ1FJLB+GN7f/wlpo0wzZXySLg0OrLKV2MS58rLn3MAvIZ/PJGb2JN0UFdCdsUtdUT0eQRz79v+byfYytOQiB7E/zaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079113; c=relaxed/simple;
	bh=GrcoTw0YtUZk1ndA0Q6ue9JHWrXqchuWzVN8n1ZG6Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyo5/6PSX3J3YfdxEqw+NHHU69g/m3asJEbbDGuLXdbOziDaDff5vx9l755wBxbr8JeL3WtsFmwZoP4QjJlco8pCDe4sw8VAXNIjOpM1B75tn6HZaZkKghBGP1wG4bXXeW9Ztt6EhqUmaUCbTVhHxVA79IaHxA2sdnqdVl98vBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4TsWd9d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43996e95114so36315065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741079109; x=1741683909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xb9+GQnQ3x1ktQ8IEjtazHwzMTgQ6i/8bTVn9usn+I=;
        b=Q4TsWd9dcVkwLF7FQmQG9ZLx7eTArq6aKJe6KcT2hVKGfwXjdJp1ygH8qAkKyntoLp
         4D92H3JEfqUEbjgGT8X6xQY7Fxpy424GlcJxn21JtR56gk7lW6zbziOC7Oq5KOevMYJE
         59LoeZzsQRVVVAA+RMHwQ7o7jhTFNBuF/133dZqosGkJREdByDbiv4cTUrL+es5JG78x
         1RR1cW4wxLJ+/CIOtPJJFELSHYJ9NQqThjBwwngbRjrAD8I5Hp5Dg7zG6TVmmUF/qvw4
         jRWqyX9HOQrty3O3YswTgtxD+KvTqNSRf5Y9ye8smtojXCcIB966b+eMPRRNtSyTzXMX
         uPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079109; x=1741683909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xb9+GQnQ3x1ktQ8IEjtazHwzMTgQ6i/8bTVn9usn+I=;
        b=EpwfehLjy29uw63TtF+LfvfyemB+nNMz5FdianiOw9IgWDH3APSMG+q6eQpd+WAeMY
         tEfQPhuJB1OczfkMfDy4FtFhxm8eWoZNVe1blS9urVLaa6XU9B+BaL+mbcLQgPp5KLKf
         9IixEMf0TRa2cJW4iLBXC0BglALEGHj5TpJ0ASZ7J34rNfU11RL4Zl3ZOPsrQ9MsrOQ3
         7h7QfEGJnaZD+mFK5XbeAVLHd+/vNWGQP+XqYOZ98TLrK5yodLx56dX+XMPnXoaR7fZp
         PMGQPmUlT2UgDs+vigiz/mr7gIoCnRE+6ChVV/y8BUH4nh8DIW3deAaXi+WgE5NhOdgZ
         oHCw==
X-Forwarded-Encrypted: i=1; AJvYcCUIMvkUEAhB+kVjw6DADfB7lcxNfu8Vhf8XOUm9W3TP6dgsVTNV98vhXuqfLhF/yqsRtWy+QO8HxJ6bKQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFacS4fwVxy0KgbcnxzqV/jwl4IfGBEn1d060r2Xen61u2BxT
	/qsFTo5BsugVyhm7S1DOMDoFybctN/ZURFINTM22SBTLi6UB1ZSK
X-Gm-Gg: ASbGnctug1GysVeKffA4k73OA9ssetmWuxP2wl4Rj+ZVzJUCAUUKO+GLfFacy6BO9FY
	MM6TGva3UkJwsmFOO4x8sDAnrlmgrYzF5bnuG8QgkjWR5z+kz3cG3i3Lyz0KBxU/ORzI8ZtdZBj
	dhOay67yreZrgsvB2rvijL6pgcj0pJvE/6V3262HOgQwBVPX/bpgTzV6SwrTwtm9VCF/Ot0Y+fc
	UFcSRgxD4NBpWd6L6KbvNySE5FwcQly3jREhZJRWM4lXjYTtGkS7cq0eueZxw9DxJXn9rBwHM1A
	wmC/sJsCdzCPtI5agQr2ISWBP96t3oWqZ1GtbomWqjwe72X2c0mmILKTHj8y6j8l8tGFJ4WT3g=
	=
X-Google-Smtp-Source: AGHT+IFLFkBo9xLZBI+Mw0maqjnI5Dp5cRHrb9tzUsxec4lWUzI8CqW0o8hXWCxH5HkIYF+DMkSQMg==
X-Received: by 2002:a05:600c:a48:b0:439:a1c7:7b2d with SMTP id 5b1f17b1804b1-43ba66da31fmr127853845e9.4.1741079108566;
        Tue, 04 Mar 2025 01:05:08 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844514sm17070694f8f.76.2025.03.04.01.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:05:08 -0800 (PST)
Message-ID: <688b5665-496d-470d-9835-0c6eadfa5569@gmail.com>
Date: Tue, 4 Mar 2025 10:05:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/sched: Adjust outdated docu for run_job()
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, phasta@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250220112813.87992-2-phasta@kernel.org>
 <20250220112813.87992-4-phasta@kernel.org>
 <12c53d41-21c4-443d-a572-fd22c3cc56ad@igalia.com>
 <1457e985f88e02cd04b2152d2468a65b7a513e63.camel@mailbox.org>
 <cfef8bd7-f335-4796-9d4f-93197bb3fc2d@igalia.com>
 <Z7yFpZMCFINhEht7@cassiopeiae> <Z7ydaE4JmNcvzjJw@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <Z7ydaE4JmNcvzjJw@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 24.02.25 um 17:25 schrieb Matthew Brost:
> On Mon, Feb 24, 2025 at 03:43:49PM +0100, Danilo Krummrich wrote:
>> On Mon, Feb 24, 2025 at 10:29:26AM -0300, Maíra Canal wrote:
>>> On 20/02/25 12:28, Philipp Stanner wrote:
>>>> On Thu, 2025-02-20 at 10:28 -0300, Maíra Canal wrote:
>>>>> Would it be possible to add a comment that `run_job()` must check if
>>>>> `s_fence->finished.error` is different than 0? If you increase the
>>>>> karma
>>>>> of a job and don't check for `s_fence->finished.error`, you might run
>>>>> a
>>>>> cancelled job.
>>>> s_fence->finished is only signaled and its error set once the hardware
>>>> fence got signaled; or when the entity is killed.
>>> If you have a timeout, increase the karma of that job with
>>> `drm_sched_increase_karma()` and call `drm_sched_resubmit_jobs()`, the
>>> latter will flag an error in the dma fence. If you don't check for it in
>>> `run_job()`, you will run the guilty job again.
>> Considering that drm_sched_resubmit_jobs() is deprecated I don't think we need
>> to add this hint to the documentation; the drivers that are still using the API
>> hopefully got it right.
>>
>>> I'm still talking about `drm_sched_resubmit_jobs()`, because I'm
>>> currently fixing an issue in V3D with the GPU reset and we still use
>>> `drm_sched_resubmit_jobs()`. I read the documentation of `run_job()` and
>>> `timeout_job()` and the information I commented here (which was crucial
>>> to fix the bug) wasn't available there.
>> Well, hopefully... :-)
>>
>>> `drm_sched_resubmit_jobs()` was deprecated in 2022, but Xe introduced a
>>> new use in 2023
>> Yeah, that's a bit odd, since Xe relies on a firmware scheduler and uses a 1:1
>> scheduler - entity setup. I'm a bit surprised Xe does use this function.
>>
> To clarify Xe's usage. We use this function to resubmit jobs after
> device reset for queues which had nothing to do with the device reset.
> In practice, a device should never occur as we have per-queue resets in
> our harwdare. If a per-queue reset occurs, we ban the queue rather than
> doing a resubmit.

That's still invalid usage. Re-submitting jobs by the scheduler is a completely broken concept in general.

What you can do is to re-create the queue content after device reset inside your driver, but *never* use drm_sched_resubmit_jobs() for that.

>
> Matt  
>
>>> for example. The commit that deprecated it just
>>> mentions AMD's case, but do we know if the function works as expected
>>> for the other users?
>> I read the comment [1] you're referring to differently. It says that
>> "Re-submitting jobs was a concept AMD came up as cheap way to implement recovery
>> after a job timeout".
>>
>> It further explains that "there are many problem with the dma_fence
>> implementation and requirements. Either the implementation is risking deadlocks
>> with core memory management or violating documented implementation details of
>> the dma_fence object", which doesn't give any hint to me that the conceptual
>> issues are limited to amdgpu.
>>
>>> For V3D, it does. Also, we need to make it clear which
>>> are the dma fence requirements that the functions violates.
>> This I fully agree with, unfortunately the comment does not explain what's the
>> issue at all.
>>
>> While I do think I have a vague idea of what's the potential issue with this
>> approach, I think it would be way better to get Christian, as the expert for DMA
>> fence rules to comment on this.
>>
>> @Christian: Can you please shed some light on this?
>>
>>> If we shouldn't use `drm_sched_resubmit_jobs()`, would it be possible to
>>> provide a common interface for job resubmission?
>> I wonder why this question did not come up when drm_sched_resubmit_jobs() was
>> deprecated two years ago, did it?

Exactly that's the point why drm_sched_resubmit_jobs() was deprecated.

It is not possible to provide a common interface to re-submit jobs (with switching of hardware dma_fences) without breaking dma_fence rules.

The idea behind the scheduler is that you pack your submission state into a job object which as soon as it is picked up is converted into a hardware dma_fence for execution. This hardware dma_fence is then the object which represents execution of the submission on the hardware.

So on re-submission you either use the same dma_fence multiple times which results in a *horrible* kref_init() on an already initialized reference (It's a wonder that this doesn't crashes all the time in amdgpu). Or you do things like starting to allocate memory while the memory management potentially waits for the reset to complete.

What we could do is to provide a helper for the device drivers in the form of an iterator which gives you all the hardware fences the scheduler is waiting for, but in general device drivers should have this information by themselves.

>>
>> Anyway, let's shed some light on the difficulties with drm_sched_resubmit_jobs()
>> and then we can figure out how we can do better.
>>
>> I think it would also be interesting to know how amdgpu handles job from
>> unrelated entities being discarded by not re-submitting them when a job from
>> another entitiy hangs the HW ring.

Quite simple this case never happens in the first place.

When you have individual queues for each process (e.g. like Xe and upcomming amdgpu HW generation) you should always be able to reset the device without loosing everything.

Otherwise things like userspace queues also doesn't work at all because then neither the kernel nor the DRM scheduler is involved in the submission any more.

Regards,
Christian.

>>
>> [1] https://patchwork.freedesktop.org/patch/msgid/20221109095010.141189-5-christian.koenig@amd.com


