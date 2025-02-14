Return-Path: <linux-kernel+bounces-515208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C518A361B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E2516E98D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8826656D;
	Fri, 14 Feb 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOFFspyy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD51A9B23
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547027; cv=none; b=rpxptLInS/4SnneNPOAb8NcuYfnOYsB4H0povcJfmIhOJ4cMh3G0m4c9cUCkI0k5hiSSiMHDqGFPfBBYikpwuqWVCARxJx/BANMAzRkPxwLuY+tVPa9znQoEdC51Sv1YmMPFCZ65GL041dZc9zI+36AWdHxBHPWfK6vt3gVNiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547027; c=relaxed/simple;
	bh=trc/PjZtrAlsdm0o33LqTrP99ME7jL98bi6yfk6Y/b0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZLmiKfPyotpb9GzrCz+o2Up5M/IfvzBuDN4SlPVH+nKg8LjKzw5CNfF6tfZ+O3eT7XlltSQw9eVrGg1yReiU1u3LT81NVxf7SJ+t5TybcO19KwdZQooMxh1Nq18uF5Jm2xf2sUd66jfjaQPtzoAf7ue/lInj6QRcyiGKIrQNkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOFFspyy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739547024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o20OYWODIVHTwZatDY+hi4cXur9nivP5VYl+8yx8ZgQ=;
	b=WOFFspyy9TdJqOcFQ3uHy+PF069Bl9v9bYw1zcB5WJLfJ6l+ZnoWaQOg9mEZwnnHO1INTQ
	4K0ZWb/1t5YVePWYUgI2Lwdf9Xx/+icxvLTSAHZxeTTpvUM8dQ392IEf7NU79MKttqRuVi
	3ZQm9V+8DKNT/FA98nToFB9ZAEjnHXo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-6-MBn1Y5Msu_ANqYNHgaEw-1; Fri, 14 Feb 2025 10:30:21 -0500
X-MC-Unique: 6-MBn1Y5Msu_ANqYNHgaEw-1
X-Mimecast-MFC-AGG-ID: 6-MBn1Y5Msu_ANqYNHgaEw_1739547021
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471bb28454cso36708651cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547021; x=1740151821;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o20OYWODIVHTwZatDY+hi4cXur9nivP5VYl+8yx8ZgQ=;
        b=w3JD2rHjYccwRR6ZH/6PrDO0lwxpfCOPfHGhQO43pNxKaw3A1x93rrNZvOVfQ/rm4Q
         cpqA36GeroCskvcv7kfbqpMw5x7pl510CUOMLcXQYY9oJlQ1q8jBulbLy1RyC/n+Dvfh
         bmLCG6fHJ0eUi7umOCcXLGxV4X8zsi/WiE+n5i0IXqe5P4KW7bif0DJLlBB+RATVUqvU
         Yvt7a14C/6lRyDBgFIBENYYjsntNNuWaHlBYyjaGVCFS7N//wT14U/I0+FWrRsXUR6en
         dHSsoq5JP9TwkRBOiLL7sSSpJJu3FV2pYvpbM5GWeco+IaOx1StzbG+TqUt3mVKXhjCM
         hJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq99cojPbWNLquBHitBbjoYUUCNfGLO7kuH3v4OwpqGbaTh1QJ352vDIFUdsSUgFtdoWHwOIniUcfZMLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFiSQFsksP9+QGqqEUZpUNtiDFRB3teeV4joex36xKGomSJmN
	lapnOiViHUfxZ45vYSx+7NolyT8mZQZJOliEBf6ckPW0iGqgMBTLcksn5iXrNg8HqHMpW3R7xcX
	ClvTh18IvME+epAZ4S0/c35suIy0lxe5QUaznOl/TbzzxO+kZFago7/IRgNt3OQ==
X-Gm-Gg: ASbGncvHE7ppv3qGQeHWRUkXjF6ZTKA8pNnDZzBUa8ckUKJjmw/4G2ovmHPXfVcHCSD
	nRCdXOuhBrRhTz5I/8wwa2P0FhIGThVTlLs3/WwFcieHL6d4/g8S/LyKsMgm51zsdbnzc6swxX1
	F4QM7dCYNXGshypuTtVK8F0xuKBARY2d87/8Zym7Xm/hDjc1dK565M42hP+nCRDtUcjjQeZqdNj
	lpgEkt+9UNYk91p0T7unIHknwhTor9w1Qu4GZsibCzChVYXW8ZrYjSFrqff04uhNN0Ox8YsEi1P
	x+UzXnlGlRhBJONEdOeMdhkE49sNFmIgq7HPQawvFoAcET82
X-Received: by 2002:a05:622a:6a42:b0:471:bd5e:d5da with SMTP id d75a77b69052e-471c02791bamr82414461cf.0.1739547021165;
        Fri, 14 Feb 2025 07:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ6uGRNmddTEVHzmFUnUBRzoNurXGdhXESRka7OCjnHBSaLFIf1D7GovJSEzavyhEdb2S00Q==
X-Received: by 2002:a05:622a:6a42:b0:471:bd5e:d5da with SMTP id d75a77b69052e-471c02791bamr82414111cf.0.1739547020777;
        Fri, 14 Feb 2025 07:30:20 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b06532sm18535991cf.79.2025.02.14.07.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:30:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <12563ec0-90ef-4613-9931-319b2a2bfceb@redhat.com>
Date: Fri, 14 Feb 2025 10:30:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in
 lock_acquire()
To: Marco Elver <elver@google.com>, Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20250213200228.1993588-1-longman@redhat.com>
 <20250213200228.1993588-5-longman@redhat.com>
 <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com>
 <3d069c26-4971-415a-9751-a28d207feb43@redhat.com>
 <CANpmjNNLn9=UA+cai=rL+6zsEQyppf6-4_YL4GAFi+dLt+4oSA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNNLn9=UA+cai=rL+6zsEQyppf6-4_YL4GAFi+dLt+4oSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/25 9:44 AM, Marco Elver wrote:
> On Fri, 14 Feb 2025 at 15:09, Waiman Long <llong@redhat.com> wrote:
>> On 2/14/25 5:44 AM, Marco Elver wrote:
>>> On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
>>>> KASAN instrumentation of lockdep has been disabled as we don't need
>>>> KASAN to check the validity of lockdep internal data structures and
>>>> incur unnecessary performance overhead. However, the lockdep_map pointer
>>>> passed in externally may not be valid (e.g. use-after-free) and we run
>>>> the risk of using garbage data resulting in false lockdep reports. Add
>>>> kasan_check_byte() call in lock_acquire() for non kernel core data
>>>> object to catch invalid lockdep_map and abort lockdep processing if
>>>> input data isn't valid.
>>>>
>>>> Suggested-by: Marco Elver <elver@google.com>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Reviewed-by: Marco Elver <elver@google.com>
>>>
>>> but double-check if the below can be simplified.
>>>
>>>> ---
>>>>    kernel/locking/lock_events_list.h |  1 +
>>>>    kernel/locking/lockdep.c          | 14 ++++++++++++++
>>>>    2 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
>>>> index 9ef9850aeebe..bed59b2195c7 100644
>>>> --- a/kernel/locking/lock_events_list.h
>>>> +++ b/kernel/locking/lock_events_list.h
>>>> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
>>>>    LOCK_EVENT(lockdep_acquire)
>>>>    LOCK_EVENT(lockdep_lock)
>>>>    LOCK_EVENT(lockdep_nocheck)
>>>> +LOCK_EVENT(lockdep_kasan_fail)
>>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>>> index 8436f017c74d..98dd0455d4be 100644
>>>> --- a/kernel/locking/lockdep.c
>>>> +++ b/kernel/locking/lockdep.c
>>>> @@ -57,6 +57,7 @@
>>>>    #include <linux/lockdep.h>
>>>>    #include <linux/context_tracking.h>
>>>>    #include <linux/console.h>
>>>> +#include <linux/kasan.h>
>>>>
>>>>    #include <asm/sections.h>
>>>>
>>>> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>>>>           if (!debug_locks)
>>>>                   return;
>>>>
>>>> +       /*
>>>> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
>>>> +        * the first lockdep call when a task tries to acquire a lock, add
>>>> +        * kasan_check_byte() here to check for use-after-free of non kernel
>>>> +        * core lockdep_map data to avoid referencing garbage data.
>>>> +        */
>>>> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
>>> This is not needed - kasan_check_byte() will always return true if
>>> KASAN is disabled or not compiled in.
>> I added this check because of the is_kernel_core_data() call.
>>>> +                    !is_kernel_core_data((unsigned long)lock) &&
>>> Why use !is_kernel_core_data()? Is it to improve performance?
>> Not exactly. In my testing, just using kasan_check_byte() doesn't quite
>> work out. It seems to return false positive in some cases causing
>> lockdep splat. I didn't look into exactly why this happens and I added
>> the is_kernel_core_data() call to work around that.
> Globals should have their shadow memory unpoisoned by default, so
> that's definitely odd.
>
> Out of curiosity, do you have such a false positive splat? Wondering
> which data it's accessing. Maybe that'll tell us more about what's
> wrong.

Will do more investigation about this and let you know the result.

Cheers,
Longman

>


