Return-Path: <linux-kernel+bounces-421651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C039D8DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556A716407B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E46D1C4A07;
	Mon, 25 Nov 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiScKrlD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9D1CD2C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570153; cv=none; b=D2orUsC+23XZBhLjlm8ACs3wWk1i7F5/bpou9/TlOWB73KAvbdF4mf3ErGd/oRwOWoFCBTAy4OVf5sCd7O+e5PZ4Mgfcnpa88mb25D04/P/PvC25nNpph6CxpQhPTbW2FPitp4SRcZ9nNpoNifOeBWRhRZp6K9Au8Cnzp+BRWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570153; c=relaxed/simple;
	bh=pSg4rNoHPqODZ1MJfz4zv7CtK9y4fbinBSVvIYf+Vb4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kn5TMtp5X+2n6+GFnOBayq8dzw0Sx5hJ5pfBWtbTW6NVYFnZZ0Qi7D5/M3fngdJYzCBxKYron7UuBL6JIqwt+9IGGeI2o9ntw63BVZymPUIAoT2ZE1Ow1rM9sUdhPNT3RIdJg3F6lK2/sQ3JWhdrche+w85S1QznVXGo+T1o2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiScKrlD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732570150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhFFHnWie4dgLZsjVCtxVVkJe9Ul6mn98yVpKoL68UY=;
	b=ZiScKrlD4//Sy7T1IIotxOyr3fc206QWwPA+LohSLl0VaQI5Xo9crkUNSC5WN+r2IM8jI2
	pUrjtdgs3uqQtxY8mV8ezYx1gjl3PRfe5dSG6U6QAsOigEqWozCUUmJIBz8GBFkuU/XRIN
	mYILhGSkkRukAEpAcZUQQUJhv2exMTo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-D6mw3iiPP0i4dWyIBtNPZQ-1; Mon, 25 Nov 2024 16:29:09 -0500
X-MC-Unique: D6mw3iiPP0i4dWyIBtNPZQ-1
X-Mimecast-MFC-AGG-ID: D6mw3iiPP0i4dWyIBtNPZQ
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83adc5130e3so521478039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732570148; x=1733174948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhFFHnWie4dgLZsjVCtxVVkJe9Ul6mn98yVpKoL68UY=;
        b=KjTNP4QYFwBt6hHlRd08o9ay67W95HNuV68Ph6HEvEEwBDnuqNkelC8VY51SqlnhXJ
         dH00XXxaK4/T30PLoOuHv7pR6CDiI8D+VIwlfzPOttSflDbhD/pA2qjzKfCJhJkU9KMI
         ZJGgNzbVdKbnEBNiSPB7aCQ7MU38UNsCx7TozEPo07m6F0o4KfybSDgOyBu0sjuivso8
         A/AS7jIQ/rJyn08b91IwS0Gg0C3ZThJeIrpNkCALiO+PuR+cgMe3k8ld7q7bWAZWNfd4
         sVxr+KvPmcYM0CG4AWVltwEa2AcZJ8SCQmzR4DCGeRpx/Y21xFy7zcpMvK/Xsd3tMvuz
         mSfg==
X-Forwarded-Encrypted: i=1; AJvYcCX2G0fgJROpKKrnDu3ugIRTdHoWukRDW0JPCBs/YinpTasvicMcvvi+0+8iMR9NUwJvptq12ryzRZbMjrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wIkq+jenKBtW5Plexbwvk0TV+vYHAdeHkO3z5xQTUPuDTHdF
	AbOq4Gg4cJYfwzsiUcurY9uzmvi6jFqxzpD5xBgL5T6doLIc/L7hu5utKKJGaSx1fiZNmLd7GJH
	QBb+2gpHfJbFubjfBkEs412TXbXMmCi4WOunZxQQbZsGZSSK9iRlsKjTXrHW4JQ==
X-Gm-Gg: ASbGnctDoc9rFKzJJVPOK9zCGr2Qf3IPEAumfJBWmjyP6NI8YiyZ9kNsALqbrM4ngIm
	LDLivIxEk4kEsimSAwHzntGhs6zvN/7mai42gB0wyXM5UE4+ynfue0+BHaqeOjhykR1ulFYMeRp
	84AjMogUfFoUywRNAts85jgwQNFDo2hwXkN2hMOwicch0K3bx6WZA7/r0kqFxo5ktY3OR6VMkXD
	LD11pijaU+y6Ksrzy+lMaoVCkan+f2o53ccO5+3nYFBUMr7U8dbS1vkRN5/go7E3TvlgAH/ZOiL
	R80PHfvQ+kcw8q5Vmd2s
X-Received: by 2002:a05:6602:6d8c:b0:82c:eeaa:b1e0 with SMTP id ca18e2360f4ac-83ecdcf2cecmr1347906839f.11.1732570148583;
        Mon, 25 Nov 2024 13:29:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbYxsMJgOCXTkrnEg7b2nY8gFA/PB349SqvWvV8xNHUvGqLbL877fPS8MOIyYS7Zzm56b4IA==
X-Received: by 2002:a05:6602:6d8c:b0:82c:eeaa:b1e0 with SMTP id ca18e2360f4ac-83ecdcf2cecmr1347905039f.11.1732570148251;
        Mon, 25 Nov 2024 13:29:08 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-841a6dd1a08sm41970039f.34.2024.11.25.13.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 13:29:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <42effdc0-bfe7-49a5-a872-21a6f665fff3@redhat.com>
Date: Mon, 25 Nov 2024 16:29:06 -0500
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
Content-Language: en-US
In-Reply-To: <b0e13a75-d068-4ad3-b0d7-4834ccec3d5a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 4:25 PM, Guenter Roeck wrote:
> On 11/25/24 12:54, Waiman Long wrote:
>>
>> On 11/25/24 3:23 PM, Guenter Roeck wrote:
>>> On 11/25/24 12:06, Guenter Roeck wrote:
>>>> On 11/25/24 11:33, Waiman Long wrote:
>>>> [ ... ]
>>>>>> Fixing that finally gives me a clean run. Nevertheless, that 
>>>>>> makes me wonder:
>>>>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc 
>>>>>> runtime tests ?
>>>>>
>>>>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose 
>>>>> you could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
>>>>>
>>>>
>>>> SGTM. I'll do that unless someone gives me a good reason to keep it 
>>>> enabled.
>>>>
>>>
>>> Actually it can not be disabled with a configuration flag. It is
>>> automatically enabled. I'll have to disable PROVE_LOCKING to disable 
>>> it.
>>>
>>> config PROVE_RAW_LOCK_NESTING
>>>         bool                    <---- no longer user configurable
>>>         depends on PROVE_LOCKING
>>>         default y
>>>         help
>>>          Enable the raw_spinlock vs. spinlock nesting checks which 
>>> ensure
>>>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>>>          not violated.
>>>
>>> I don't really like that, and I don't understand the logic behind it,
>>> but it is what it is.
>>>
>>> FWIW, the description of commit 560af5dc839 is misleading. It says 
>>> "Enable
>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not 
>>> what the
>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if 
>>> PROVE_LOCKING is
>>> enabled. It is all or nothing.
>>>
>> I think we can relax it by
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 5d9eca035d47..bfdbd3fa2d29 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>   config PROVE_RAW_LOCK_NESTING
>>          bool
>>          depends on PROVE_LOCKING
>> -       default y
>> +       default y if ARCH_SUPPORTS_RT
>>          help
>>           Enable the raw_spinlock vs. spinlock nesting checks which 
>> ensure
>>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>>
>> Sebastian, what do you think?
>>
>
>     depends on PROVE_LOCKING && ARCH_SUPPORTS_RT
>
> seems to make more sense to me.

That will work too, but that will enforce that arches with no 
ARCH_SUPPORTS_RT will not be able to enable PROVE_RAW_LOCK_NESTING even 
if people want to try it out.

Cheers,
Longman


