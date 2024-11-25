Return-Path: <linux-kernel+bounces-421688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F49D8E93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490AF2837D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B771CCEF8;
	Mon, 25 Nov 2024 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OelOhQ1z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4181C1AA9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574040; cv=none; b=DDAGvHGXvTZKidqGn9DCW9deDx8KUdn1xR+3RxN+xriKAHcoZLZ4+iA5vKelrLInbWXMUf0xvg34PQxqWilN+4sh22w1DOhWtfnRHWj5vj2jzrptm1UE2ke3NafFnGRtaK+qnR9zZLDTCSnka1zbwQSceZDtIW+V/TebSQ3fNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574040; c=relaxed/simple;
	bh=adgyRui2A4t8Aa+g1+2n3f/hHSgZeA3iXYdd1QHol10=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LKU3bUO/Z2DdCG8ejj9G/Ts+DBhA7ckivO6+5K1AMS4ycmEKJYuMukH2laSaU3SQh+Amh/QDzykSwYauYnrDs0LqvEpWCSknjHxqeCrdBWKSgYGobL54Qe53sD34Z4Ck/BD0BTw41jJbWtnfrQmY+6WX264i/eQi02+JY9OD4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OelOhQ1z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732574037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Msze4ierWMuNBzYGEwYpJUYKJXMDVB3/3xNduYebKtM=;
	b=OelOhQ1zoPBQQ6UrPJbJy1RnI1xQxpu+sCdYc+WrsBl/hVNWk7IVkEWZ6FMlH8ze9hOUDp
	mboKCudBoMSR0Ls/c7LDSG1LcPkgyZf+G7n2yPQWEC9DCz9IpJIqrzj0knd8xPXD+4XnLx
	YH80tchqYKEM2yODT2lWU79mIm+xC80=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-2DLQlWQNMWKAxOH7mq_cXQ-1; Mon, 25 Nov 2024 17:33:55 -0500
X-MC-Unique: 2DLQlWQNMWKAxOH7mq_cXQ-1
X-Mimecast-MFC-AGG-ID: 2DLQlWQNMWKAxOH7mq_cXQ
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841a54a66a2so116110039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574035; x=1733178835;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Msze4ierWMuNBzYGEwYpJUYKJXMDVB3/3xNduYebKtM=;
        b=Zxl2pIr2sIrV1tg6rrwaSbUrTAIXurIRmBGEaqiPQ13loxsNhSRcMNjvlkawOCD+Ht
         ceHByoMXI/UCUlfJRhRSiqUCAKuvMi9oVPoLVxi/gJqG9NTwpORisUGSbFirYVz+PXCp
         1HIUAUU299dRSafk6d143Rn8xdrN+bIewCardmbMTwFDzLWeXcGT3vB+1YXZ5LFmfe4n
         uOFmj3JscMrMeZib6ZKpqOjG5UOz0VpdNLIvj2fAtWxcBYS78PHr+TEXS4biNgT0c11X
         kuhWfi258Xat1ukTBVPoSwIPM879YsaD+h6T6kgfNCJcRXGIr3ExW9cxfX/N2gL2Pxua
         jINQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYGsfBAWB3lmMKP8qppNOq16Dz8UB6BwYmfb4Xr5nNDwrychhnLKr1Qfv37KnH4hToC3HaLuJKLfvB4g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+p8IOOKbUzFKVACwrnTqa4Z2rgIKGCMFSuwnSeanGRtJm0I+f
	1LaitY1X5KQDFqUp4ZcG2/KlwZ/6tExdjCnGekHn7YPJa4EILTfSvUnqFnnJqG7i/40Y3voFF7l
	y9Bj6ViYhqbmWDXhlHzHzgpvGw5dHKaGhqFZP9ZQUPwUKTQq8S3aIk+PoZ6qa1Q==
X-Gm-Gg: ASbGncu05XWdEqPtMpUCa6mU6EK6dq1DORdnsykZIOAOjIbxbaECao3ZsatEom74yNC
	BFp4zfhqT9xrH7xsgALF6MF2OSF7pGJ8NgcWqa/tvxTdF/St+FOq9N2LiW7w+amd4vxmbecKC90
	ivwpsIZqUOx4NV0GT89wJbriBNedzcZPXWM+AclTcm6pRx2WxwJAIxwmllz3KboIPqYp9bI4nRI
	3bATxbi5ktCVHfbCoEmmwJ8bmwEXjKxfEFuQR4v7CtrqwbZE/OtQkO/oAi2TH4PJmj6H+AtBA0w
	80lT5RiFagYYduOh1Ta1
X-Received: by 2002:a05:6602:164c:b0:82d:129f:acb6 with SMTP id ca18e2360f4ac-83ecdd3a4acmr1400824639f.14.1732574035055;
        Mon, 25 Nov 2024 14:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5kiqJDkqBCBfHrXKZVwZjB+U39K7Io0NV43Xa9HO3Z1whr1biVbTicDSfDUi4as1q2vKhlw==
X-Received: by 2002:a05:6602:164c:b0:82d:129f:acb6 with SMTP id ca18e2360f4ac-83ecdd3a4acmr1400822039f.14.1732574034716;
        Mon, 25 Nov 2024 14:33:54 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1fdab893bsm967695173.70.2024.11.25.14.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 14:33:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bfcb530d-10e4-4ec7-b216-0b54d5089bfc@redhat.com>
Date: Mon, 25 Nov 2024 17:33:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Guenter Roeck <linux@roeck-us.net>, Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
 <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <b0e13a75-d068-4ad3-b0d7-4834ccec3d5a@roeck-us.net>
 <42effdc0-bfe7-49a5-a872-21a6f665fff3@redhat.com>
 <55e2fcb8-dd06-42e4-b5de-4a0b46057571@roeck-us.net>
Content-Language: en-US
In-Reply-To: <55e2fcb8-dd06-42e4-b5de-4a0b46057571@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 4:54 PM, Guenter Roeck wrote:
> On 11/25/24 13:29, Waiman Long wrote:
>>
>> On 11/25/24 4:25 PM, Guenter Roeck wrote:
>>> On 11/25/24 12:54, Waiman Long wrote:
>>>>
>>>> On 11/25/24 3:23 PM, Guenter Roeck wrote:
>>>>> On 11/25/24 12:06, Guenter Roeck wrote:
>>>>>> On 11/25/24 11:33, Waiman Long wrote:
>>>>>> [ ... ]
>>>>>>>> Fixing that finally gives me a clean run. Nevertheless, that 
>>>>>>>> makes me wonder:
>>>>>>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc 
>>>>>>>> runtime tests ?
>>>>>>>
>>>>>>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose 
>>>>>>> you could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the 
>>>>>>> trouble.
>>>>>>>
>>>>>>
>>>>>> SGTM. I'll do that unless someone gives me a good reason to keep 
>>>>>> it enabled.
>>>>>>
>>>>>
>>>>> Actually it can not be disabled with a configuration flag. It is
>>>>> automatically enabled. I'll have to disable PROVE_LOCKING to 
>>>>> disable it.
>>>>>
>>>>> config PROVE_RAW_LOCK_NESTING
>>>>>         bool                    <---- no longer user configurable
>>>>>         depends on PROVE_LOCKING
>>>>>         default y
>>>>>         help
>>>>>          Enable the raw_spinlock vs. spinlock nesting checks which 
>>>>> ensure
>>>>>          that the lock nesting rules for PREEMPT_RT enabled 
>>>>> kernels are
>>>>>          not violated.
>>>>>
>>>>> I don't really like that, and I don't understand the logic behind it,
>>>>> but it is what it is.
>>>>>
>>>>> FWIW, the description of commit 560af5dc839 is misleading. It says 
>>>>> "Enable
>>>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not 
>>>>> what the
>>>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if 
>>>>> PROVE_LOCKING is
>>>>> enabled. It is all or nothing.
>>>>>
>>>> I think we can relax it by
>>>>
>>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>>> index 5d9eca035d47..bfdbd3fa2d29 100644
>>>> --- a/lib/Kconfig.debug
>>>> +++ b/lib/Kconfig.debug
>>>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>>>   config PROVE_RAW_LOCK_NESTING
>>>>          bool
>>>>          depends on PROVE_LOCKING
>>>> -       default y
>>>> +       default y if ARCH_SUPPORTS_RT
>>>>          help
>>>>           Enable the raw_spinlock vs. spinlock nesting checks which 
>>>> ensure
>>>>           that the lock nesting rules for PREEMPT_RT enabled 
>>>> kernels are
>>>>
>>>> Sebastian, what do you think?
>>>>
>>>
>>>     depends on PROVE_LOCKING && ARCH_SUPPORTS_RT
>>>
>>> seems to make more sense to me.
>>
>> That will work too, but that will enforce that arches with no 
>> ARCH_SUPPORTS_RT will not be able to enable PROVE_RAW_LOCK_NESTING 
>> even if people want to try it out.
>>
>
> No architecture will be able to enable anything because "bool" has no
> string associated with it. As mentioned before, it is all or nothing.
> Otherwise I could just configure "CONFIG_PROVE_RAW_LOCK_NESTING=n"
> for sparc and be done.

Yes, you are right.

Cheers,
Longman


