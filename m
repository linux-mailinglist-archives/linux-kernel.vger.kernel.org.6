Return-Path: <linux-kernel+bounces-515392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7667A36442
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8DD16944F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F8267B60;
	Fri, 14 Feb 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBstxonc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284917555
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553539; cv=none; b=dOuJtw1bh2LJQ+a29OPaZL9xeoOMhiB7tt7htaZkBVfvAaLrXk+Q1y48XKn3RdMrmmgfNSfujyYKRMM8e2hZ9PUPlpHcmLdQxJcSnC/en/5et8dD0JbeVMf1wZn9CBKJMqdj955s4n1+lxM1bV0jp67e55X747zgD0Lu3jMAJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553539; c=relaxed/simple;
	bh=/I38Q9Bw0MunQfrRYRJbIDx6UvLRm1cdDZaMWvcP7r0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HsDoc9xqrZovK83Rb5xC+3Uvkj2dIMptt5uWc3mqW8J7lf/qvqeovz2z0pC62VBx3EXn4zcoxHWw0mBj1KLHtsVSrHvk9D17h7F/pbCpoHJsz8ItKqTy9AhqcQSxq7yrCqdX6bwE5/J8BMY/a1DOxZbXrYHWU8FWlQ7TF9v/YGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBstxonc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739553536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miJRz0qz2+SDHVCWyn+86rl9+qDF1PxK6piRfHk43rg=;
	b=gBstxoncUouVGawCH2ZpEwazDGKtH35VdvjvKZe3vPejqqwvK7U0LBg7MKdRxXNGKcKurQ
	dbO2xDmWHuyV9Ud/jZHjgNmrBzG9mMtmkRGAHMjAdJt/snIFozD3pSGjFEvRibN7hIjoY/
	DXgvz7TOcKnmHOoAe9rE/PNiIuKie0Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-RaSo34A_M3WJHL1TZc0BWQ-1; Fri, 14 Feb 2025 12:18:54 -0500
X-MC-Unique: RaSo34A_M3WJHL1TZc0BWQ-1
X-Mimecast-MFC-AGG-ID: RaSo34A_M3WJHL1TZc0BWQ_1739553534
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c07903c49fso391809685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553534; x=1740158334;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miJRz0qz2+SDHVCWyn+86rl9+qDF1PxK6piRfHk43rg=;
        b=DDHEnys6iJR/qcSiN1tFP6Mi5yiXJgi5R1RGDwpxfQ1vps9GSbnmuB9rAsgyOrMbev
         tjbFozt0wyiFour2iHVOL1XXrYYD3Xj7qWQ8IHX/6peaaP2IrSH8Cpcouz5vqx03yYS5
         jup0UfV88M9K1FFJwiMjiLhjXLy3pbj1nLYTIz0SMj57dEHFdVMf4U1lQaIw4PRgP0vy
         e+Cng7XpcCShInWmCOe/fq09MI8+MLIGp9zN56HV1VVt/XD/jrxmRpgSmqY2ID0OQzYc
         rnH6QwilXJXorI7T6aD2rGeDy68qP2a+bcSUQrSOlMcox6in/uRw/wjjtJgLUlFLA3p8
         XQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVenBf/BlfbeP85zXAXJVQzPsYpMVJsJc8BPGIW0hWXmDE9ui9e1a6Y38HkbJSfyOXB+GGNnCbF2Vt3s5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zIej5ubIvVolA/n2f/BtBBFvdFonv7rRn9EshImV+3j8O5j5
	aPrKsECSqZiGnQ2kthUozmVnJqC4lt8L52cRUzRYc2unjnKEml3hF4uzsBMcQ6kj4Pk9uANVMVu
	rO3qg94EIvwO2sJjcO8Lx2HHfkc1TOc5HEvu2JuwxYRS9+UExp2ShNFSZk3lCQg==
X-Gm-Gg: ASbGnctahvJBHiES+QgsKJFByN1AKnjvMaksa22ete/FmFkcpXHd4s7Pw7eidtCK+6c
	Z+HG5iACgNcbQRE6rVZNFk0jzv0SBFb0AXSgtnpeiW6Br/Li9gScBjqa8x9vHygABVEzEYUlHsg
	8DgCUG7rcS0I2eHmeW8y42zvgyPWxPT8LXcmPk/brVYQ8r/EHhiKknaQQ5djqhyoxSWE5Ym6coI
	+qy2CKBmEufadKwKrmahFW5U3PIz5v6b0LTywrUiWt4JnvDPxcNSSWHUbbfEVZ6lTU0f3X5t/or
	uMBfjUEoMlGdxsClGskdY3q66eI77xwdYwsCRl2hl1HE7uOG
X-Received: by 2002:a05:620a:4808:b0:7c0:78ec:1ee3 with SMTP id af79cd13be357-7c08a9e6125mr23709985a.28.1739553534414;
        Fri, 14 Feb 2025 09:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg3OPf9yCqwG+NVcFb4NgZaGGP5owssZdMyHObD9wHrF+fa1majqAq0amORnPskLcjwENXQw==
X-Received: by 2002:a05:620a:4808:b0:7c0:78ec:1ee3 with SMTP id af79cd13be357-7c08a9e6125mr23707385a.28.1739553534104;
        Fri, 14 Feb 2025 09:18:54 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c86131esm223681585a.68.2025.02.14.09.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:18:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dfe06175-1c19-407d-9583-43576ab9b588@redhat.com>
Date: Fri, 14 Feb 2025 12:18:51 -0500
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
 <f2f006e8-3987-4aa2-b4f5-114b4e869e86@redhat.com>
 <CANpmjNPYFjv4TTCG+t0zyr2efCtjPKV7zQQu-ccsgX5XtGtDLg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNPYFjv4TTCG+t0zyr2efCtjPKV7zQQu-ccsgX5XtGtDLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 11:43 AM, Marco Elver wrote:
> On Fri, 14 Feb 2025 at 17:18, Waiman Long <llong@redhat.com> wrote:
>> On 2/14/25 9:44 AM, Marco Elver wrote:
>>> On Fri, 14 Feb 2025 at 15:09, Waiman Long <llong@redhat.com> wrote:
>>>> On 2/14/25 5:44 AM, Marco Elver wrote:
>>>>> On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
>>>>>> KASAN instrumentation of lockdep has been disabled as we don't need
>>>>>> KASAN to check the validity of lockdep internal data structures and
>>>>>> incur unnecessary performance overhead. However, the lockdep_map pointer
>>>>>> passed in externally may not be valid (e.g. use-after-free) and we run
>>>>>> the risk of using garbage data resulting in false lockdep reports. Add
>>>>>> kasan_check_byte() call in lock_acquire() for non kernel core data
>>>>>> object to catch invalid lockdep_map and abort lockdep processing if
>>>>>> input data isn't valid.
>>>>>>
>>>>>> Suggested-by: Marco Elver <elver@google.com>
>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> Reviewed-by: Marco Elver <elver@google.com>
>>>>>
>>>>> but double-check if the below can be simplified.
>>>>>
>>>>>> ---
>>>>>>     kernel/locking/lock_events_list.h |  1 +
>>>>>>     kernel/locking/lockdep.c          | 14 ++++++++++++++
>>>>>>     2 files changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
>>>>>> index 9ef9850aeebe..bed59b2195c7 100644
>>>>>> --- a/kernel/locking/lock_events_list.h
>>>>>> +++ b/kernel/locking/lock_events_list.h
>>>>>> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
>>>>>>     LOCK_EVENT(lockdep_acquire)
>>>>>>     LOCK_EVENT(lockdep_lock)
>>>>>>     LOCK_EVENT(lockdep_nocheck)
>>>>>> +LOCK_EVENT(lockdep_kasan_fail)
>>>>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>>>>> index 8436f017c74d..98dd0455d4be 100644
>>>>>> --- a/kernel/locking/lockdep.c
>>>>>> +++ b/kernel/locking/lockdep.c
>>>>>> @@ -57,6 +57,7 @@
>>>>>>     #include <linux/lockdep.h>
>>>>>>     #include <linux/context_tracking.h>
>>>>>>     #include <linux/console.h>
>>>>>> +#include <linux/kasan.h>
>>>>>>
>>>>>>     #include <asm/sections.h>
>>>>>>
>>>>>> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>>>>>>            if (!debug_locks)
>>>>>>                    return;
>>>>>>
>>>>>> +       /*
>>>>>> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
>>>>>> +        * the first lockdep call when a task tries to acquire a lock, add
>>>>>> +        * kasan_check_byte() here to check for use-after-free of non kernel
>>>>>> +        * core lockdep_map data to avoid referencing garbage data.
>>>>>> +        */
>>>>>> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
>>>>> This is not needed - kasan_check_byte() will always return true if
>>>>> KASAN is disabled or not compiled in.
>>>> I added this check because of the is_kernel_core_data() call.
>>>>>> +                    !is_kernel_core_data((unsigned long)lock) &&
>>>>> Why use !is_kernel_core_data()? Is it to improve performance?
>>>> Not exactly. In my testing, just using kasan_check_byte() doesn't quite
>>>> work out. It seems to return false positive in some cases causing
>>>> lockdep splat. I didn't look into exactly why this happens and I added
>>>> the is_kernel_core_data() call to work around that.
>>> Globals should have their shadow memory unpoisoned by default, so
>>> that's definitely odd.
>>>
>>> Out of curiosity, do you have such a false positive splat? Wondering
>>> which data it's accessing. Maybe that'll tell us more about what's
>>> wrong.
>> The kasan_check_byte() failure happens very early in the boot cycle.
>> There is no KASAN report, but the API returns false. I inserted a
>> WARN_ON(1) to dump out the stack.
> I see - I suspect this is before ctors had a chance to run, which is
> the way globals are registered with KASAN.
>
> I think it'd be fair to just remove the lockdep_kasan_fail event,
> given KASAN would produce its own report on a real error anyway.
>
> I.e. just do the kasan_check_byte(), and don't bail even if it returns
> false. The KASAN report would appear before everything else (incl. a
> bad lockdep report due to possible corrupted memory) and I think
> that's all we need to be able to debug a real bug.

Fair, will update the patch.

Cheers,
Longman

>


