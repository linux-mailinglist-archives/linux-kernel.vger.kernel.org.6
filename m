Return-Path: <linux-kernel+bounces-268200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817994218A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0351F24C90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187618DF60;
	Tue, 30 Jul 2024 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqVcwQgG"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90891662F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371079; cv=none; b=uCODaDt9yFK0/0ssZ6uzqK7TVwY2gF96F+tzkH7n4CnmLfK7lQ5rmX8qGy4zltSP4s+udhRHIDJxwYmBfWHBZ3rqX2Bt9o+TehEHjov4CR7EMpSWCBMRyF8EkEenu4cvUtGC83gk6my09uMfEY5t7gxRDqBii++RWZ8M8Zu7G38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371079; c=relaxed/simple;
	bh=lXLuuhneqm7q4nKURDCY+bkhu9jApKTZe9n5kkph4H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfD7Aj5LRf7tROnZ3EfNR9YCrHZVT9f7J9xO8YFmnoZHrMQC5U4odzB6buBhCf252MlWCtS4VDAQ+UoMwRG9JC/SsURU1XiDIFMMFZ963Yj38VSzZoh/xKzF6w2HbiZlPbrGp6uKdPerF1zRjR8SO8QAImaQlBxC3BVctYpA4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqVcwQgG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d1d6369acso210581b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722371077; x=1722975877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Io7izSHkDWxab79KsnyI4ZVB8345kpqJJ1JWotLwAO0=;
        b=lqVcwQgGGadJ0LerkXqawGxQ5gVYQPquycEUgT15mbicCFp85Izt9MVcdVh08KU7dK
         IK6OVIxJEctvEfRmnld52GY9XwAWgW6nfs/Os+qb4o6roNVSDbIZ/1Aq17ZNnXYfTp8M
         F8nneK5536ejrSuraIRYYDcgAlAHThUzqfHkM3zy1g3zUEYtbPL6RXuh954UhnJOw30N
         2oL3lrPx1fvJQSo7pQOe++hFiqz89uof3NlLyXqN48tKcUtCGoUUJ6syTAnLgkZZY5sk
         CSBBwkCY28OlQzW+kyNk+6iJsdvSrO3NfyINcmL2MwrfJqKeHl/k6tcv1Qo3ADPuxIvr
         e9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722371077; x=1722975877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io7izSHkDWxab79KsnyI4ZVB8345kpqJJ1JWotLwAO0=;
        b=kgcUzs/vNBK7bmacSfmDAV33kD+f9z8PJ+xSxs7xa76NCjRyudIuaeYTDvZm6NEdUu
         iS1Cfza+ulNYqYkI7jRDbNdxLUAPheK5JmexFSNTLyFpqpIx13l1KD7ZbJ0Ndisd98Js
         h9u8s3H/Cm2/YjftvE4rX1I9jR2ppI+lX+RuqpSzRmnC+WQ0mvCQZVnQF6OOJh0ph8WF
         TXMaDdGuq/21/QYET/IGJ1l7wXzyiSAUxgFbDVtL95YooI+NNDFB9moQ56cN2/wxPFeF
         5KJdNTRNjHOgyUftEoc2VGqwJn4D1bTJJ4uOP7yK13KCfyY93Zhg3Vz9Qyigpfft1lEk
         eESA==
X-Forwarded-Encrypted: i=1; AJvYcCW6dB7Zg6FEv6LoRryy+k5PhWIdisUvKe9LCuMrisN4qCo3zwb3fXCu2P+rk2gra2ibJAWNvlSDKc5wKjlxI2GIF8M6lOwBjzNJeG2G
X-Gm-Message-State: AOJu0Yxd70yf5kppPKxJS4/dhhwdYeedRJ+m1F9N3FSYVXCrtsPI/RDt
	mU2muDN5ysch4AUKtKtWQBFeHdNLtm6pYi+HCvGKeOn4vIcc4nVZ
X-Google-Smtp-Source: AGHT+IF1ojZnM6QjAU/eKbNxdTPAlqmTChuXr1iPCScAV+y5hT54KBIK9wA2JkjLNEaYPtHnjyQmww==
X-Received: by 2002:a17:90a:a00d:b0:2cb:5fe6:8a1d with SMTP id 98e67ed59e1d1-2cfcaade6afmr5218900a91.9.1722371076951;
        Tue, 30 Jul 2024 13:24:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28ca3b75sm11153913a91.25.2024.07.30.13.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:24:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
Date: Tue, 30 Jul 2024 13:24:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240730193841.GS33588@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 12:38, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 01:31:18PM -0600, Jens Axboe wrote:
>> On 7/30/24 1:22 PM, Peter Zijlstra wrote:
>>> On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:
>>>
>>>> Which makes me think it's asm_exc_int3 just recursively failing.
>>>
>>> Sounds like text_poke() going sideways, there's a jump_label fail out
>>> there:
>>>
>>>   https://lkml.kernel.org/r/20240730132626.GV26599@noisy.programming.kicks-ass.net
>>
>> No change with this applied...
>>
>> Also not sure if you read my link, but a few things to note:
>>
>> - It only happens with gcc-11 here. I tried 12/13/14 and those
>>    are fine, don't have anything older
> 
> One of my test boxes has 4.4 4.6 4.8 4.9 5 6 8 9 10 11 12 13
> 
> (now I gotta go figure out wth 7 went :-) And yeah, we don't support
> most of those version anymore (phew).
> 
> So if its easy to setup, I could try older GCCs.
> 
>> - It only happens with KFENCE enabled.
> 
> I missed the KFENCE bit. Happen to have the .config handy, I couldn't
> make much sense of Gunther's website in a hurry.
> 

An interesting bit of information: The problem is seen with many,
but not all CPUs. For example, I don't see it with athlon, n270, Dhyana,
or EPYC. qemu32 is affected, but qemu64 is fine. But on the other side
both kvm32 and kvm64 are affected.

Guenter


