Return-Path: <linux-kernel+bounces-511561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD146A32C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85411882AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24766253B66;
	Wed, 12 Feb 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXuSXZ+C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A320C49B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379457; cv=none; b=QHgiGcEfIN84whAX1xofgJYdVntwHJoXMzS7uIqrUSFRVvragL0OLieIByHa6N2fhO422gdEMiLTQeXFInf0gJPMnWrnjaNiXt6h7Qx/DlWxbQ/Bf5mK6hBQ8iS+7PTmglvjX86kjTVTHkakh351CdhWKinnHED1xXSDe1r6u3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379457; c=relaxed/simple;
	bh=GMs8PYB880kcpXZ2WUgyEWukCnbaOMZbPmkU/tQbKEs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eJVNel8GvMRCbS2H3gda3Ib/G9IDDT2FYq0bGsiClXeKG4zAd/xOCfGoEpbATl84CbotE1l/5ShxROqauVdRl4S4vO8cMsOblVaarfkWs9Ai8JbyN1eLSLsBB2oeB2g0o4HAwg6I3Q2BdLQZ+wTBf1PtnqXN78Ua2KsOmo90LnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXuSXZ+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739379453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFYuB4nYKmjSwIRVjNdGoef98U/NaR6F7yyw8uBNWDE=;
	b=aXuSXZ+CpPrzapcH7dDV9v7v3UAzjtgZSmDpdVT/+gfcF0lyd/7oObvh3gc9CC947GZJjW
	lMWQxCdoifgBqFHI4tsRNFKR0f6BugUpbRKIoch+PgeW3ihcG0/seqgjbcMxbR3rd4vkrX
	jBpvNRZHLs6gx1I8AvNdiL6o9uCBFy0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-nhk7FQrPMOCxZaI_7Pf8dA-1; Wed, 12 Feb 2025 11:57:32 -0500
X-MC-Unique: nhk7FQrPMOCxZaI_7Pf8dA-1
X-Mimecast-MFC-AGG-ID: nhk7FQrPMOCxZaI_7Pf8dA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e43fb255c4so184649526d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379451; x=1739984251;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFYuB4nYKmjSwIRVjNdGoef98U/NaR6F7yyw8uBNWDE=;
        b=uqbJ0FreIcYUHhLVvkJZTSJ2gqVe7JgPq6Gl3s8bS2MNAvzjIpsegEBNOInpS7HUrJ
         dorSHNZi9dWm1At1xiNFMWY4GkvMjwzwSbNBjk9emFjM5CL98fwcOTPH+MfW4ze6xZ4K
         zieHQPmSQ1UJWprTzRe80gsic/YF+K1iitnIRd26bmZOMlGbxkJ0VwJTC9nprP2aJT8z
         85xfMX5DHlMUvTLqVsuT+piKjw8yv0ohCz+hpSDa2yuLKCmaZf+cDAZ3I+2Y7IudhVkX
         eSwml2UC/tWt7aXL3nfZXMrTq7J/O6IiofL8H2MpVMbnqqw0yD8zn7upei08WCXMLcm0
         IvLg==
X-Forwarded-Encrypted: i=1; AJvYcCX5vnIjSSlnN0e6V9RV3/DIo3/taVCbXJiRRVnoZ34Q2/ZrODkgLdPk26y0+24eKqlnsE8suW2Hs9OVB5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJ3aiKsRSDdYb0cyPmlXKXkjqZ8rvWYHz0rnkizGcvRH6JJKO
	7HtWGL1+IMyvxtlTzoW3bcOD0AL18wnO4UpxVwMnbFPsRjnZJfpkpo0QEmgSk58IroDCjUkXIrp
	Jzlc8LJRdBLlPx7I11bD5JAL+cBpFk4qCS0+tfUmDvV6G42F1A6zxLEqBS2TIVCRinXv4lJbW
X-Gm-Gg: ASbGncuOW3PDluluy7d88n3+5ofd6QzJdYCvl4XrBS1qd75abNMmSJVn38oYafuUqj7
	jkdNKjgOphKeno+4eag7FL2fZuVzkHAnekbuf8bSGGTRPd4Jgpy6KHMjsDsEQb1wdVxwHD3W5lR
	7OTiIg7EE+ztJ9M7vJXW4JrqHUVbpjR2kr4hGAqIfPzPBspRY8DbzTHTB6pO7dhoCU3wJARUupS
	SuOXGPCNhtb39WnINVV7fH5UYqepD/QDcQiJQ5i+omoYYKZ6cb5yXmoTGVIhW5a4FDwjZIZEsdn
	8BlQBmJmD7CSIDeZzsLQEiCI88jJm9v011LRiZjH1YYjFBvV
X-Received: by 2002:ad4:5c4d:0:b0:6d8:e5f4:b969 with SMTP id 6a1803df08f44-6e65bf45437mr4032206d6.10.1739379450706;
        Wed, 12 Feb 2025 08:57:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEquvgVlG7Lqjdc9E2Pc1ZgHRNnJh2Hve+v+1s0CZFkAvK/FwwISRKusccY6ip7emw9VMBr6Q==
X-Received: by 2002:ad4:5c4d:0:b0:6d8:e5f4:b969 with SMTP id 6a1803df08f44-6e65bf45437mr4031716d6.10.1739379450296;
        Wed, 12 Feb 2025 08:57:30 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44da75f46sm66264716d6.58.2025.02.12.08.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:57:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a6993bbd-ec8a-40e1-9ef2-74f920642188@redhat.com>
Date: Wed, 12 Feb 2025 11:57:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] locking/lockdep: Disable KASAN instrumentation of
 lockdep.c
To: Marco Elver <elver@google.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com
References: <20250210042612.978247-1-longman@redhat.com>
 <20250210042612.978247-4-longman@redhat.com> <Z6w4UlCQa_g1OHlN@Mac.home>
 <CANpmjNNDArwBVcxAAAytw-KjJ0NazCPAUM0qBzjsu4bR6Kv1QA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNNDArwBVcxAAAytw-KjJ0NazCPAUM0qBzjsu4bR6Kv1QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/25 6:30 AM, Marco Elver wrote:
> On Wed, 12 Feb 2025 at 06:57, Boqun Feng <boqun.feng@gmail.com> wrote:
>> [Cc KASAN]
>>
>> A Reviewed-by or Acked-by from KASAN would be nice, thanks!
>>
>> Regards,
>> Boqun
>>
>> On Sun, Feb 09, 2025 at 11:26:12PM -0500, Waiman Long wrote:
>>> Both KASAN and LOCKDEP are commonly enabled in building a debug kernel.
>>> Each of them can significantly slow down the speed of a debug kernel.
>>> Enabling KASAN instrumentation of the LOCKDEP code will further slow
>>> thing down.
>>>
>>> Since LOCKDEP is a high overhead debugging tool, it will never get
>>> enabled in a production kernel. The LOCKDEP code is also pretty mature
>>> and is unlikely to get major changes. There is also a possibility of
>>> recursion similar to KCSAN.
>>>
>>> To evaluate the performance impact of disabling KASAN instrumentation
>>> of lockdep.c, the time to do a parallel build of the Linux defconfig
>>> kernel was used as the benchmark. Two x86-64 systems (Skylake & Zen 2)
>>> and an arm64 system were used as test beds. Two sets of non-RT and RT
>>> kernels with similar configurations except mainly CONFIG_PREEMPT_RT
>>> were used for evaulation.
>>>
>>> For the Skylake system:
>>>
>>>    Kernel                      Run time            Sys time
>>>    ------                      --------            --------
>>>    Non-debug kernel (baseline) 0m47.642s             4m19.811s
>>>    Debug kernel                        2m11.108s (x2.8)     38m20.467s (x8.9)
>>>    Debug kernel (patched)      1m49.602s (x2.3)     31m28.501s (x7.3)
>>>    Debug kernel
>>>    (patched + mitigations=off)         1m30.988s (x1.9)     26m41.993s (x6.2)
>>>
>>>    RT kernel (baseline)                0m54.871s             7m15.340s
>>>    RT debug kernel             6m07.151s (x6.7)    135m47.428s (x18.7)
>>>    RT debug kernel (patched)   3m42.434s (x4.1)     74m51.636s (x10.3)
>>>    RT debug kernel
>>>    (patched + mitigations=off)         2m40.383s (x2.9)     57m54.369s (x8.0)
>>>
>>> For the Zen 2 system:
>>>
>>>    Kernel                      Run time            Sys time
>>>    ------                      --------            --------
>>>    Non-debug kernel (baseline) 1m42.806s            39m48.714s
>>>    Debug kernel                        4m04.524s (x2.4)    125m35.904s (x3.2)
>>>    Debug kernel (patched)      3m56.241s (x2.3)    127m22.378s (x3.2)
>>>    Debug kernel
>>>    (patched + mitigations=off)         2m38.157s (x1.5)     92m35.680s (x2.3)
>>>
>>>    RT kernel (baseline)                 1m51.500s           14m56.322s
>>>    RT debug kernel             16m04.962s (x8.7)   244m36.463s (x16.4)
>>>    RT debug kernel (patched)    9m09.073s (x4.9)   129m28.439s (x8.7)
>>>    RT debug kernel
>>>    (patched + mitigations=off)          3m31.662s (x1.9)    51m01.391s (x3.4)
>>>
>>> For the arm64 system:
>>>
>>>    Kernel                      Run time            Sys time
>>>    ------                      --------            --------
>>>    Non-debug kernel (baseline) 1m56.844s             8m47.150s
>>>    Debug kernel                        3m54.774s (x2.0)     92m30.098s (x10.5)
>>>    Debug kernel (patched)      3m32.429s (x1.8)     77m40.779s (x8.8)
>>>
>>>    RT kernel (baseline)                 4m01.641s           18m16.777s
>>>    RT debug kernel             19m32.977s (x4.9)   304m23.965s (x16.7)
>>>    RT debug kernel (patched)   16m28.354s (x4.1)   234m18.149s (x12.8)
>>>
>>> Turning the mitigations off doesn't seems to have any noticeable impact
>>> on the performance of the arm64 system. So the mitigation=off entries
>>> aren't included.
>>>
>>> For the x86 CPUs, cpu mitigations has a much bigger impact on
>>> performance, especially the RT debug kernel. The SRSO mitigation in
>>> Zen 2 has an especially big impact on the debug kernel. It is also the
>>> majority of the slowdown with mitigations on. It is because the patched
>>> ret instruction slows down function returns. A lot of helper functions
>>> that are normally compiled out or inlined may become real function
>>> calls in the debug kernel. The KASAN instrumentation inserts a lot
>>> of __asan_loadX*() and __kasan_check_read() function calls to memory
>>> access portion of the code. The lockdep's __lock_acquire() function,
>>> for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
>>> added with KASAN instrumentation. Of course, the actual numbers may vary
>>> depending on the compiler used and the exact version of the lockdep code.
> For completeness-sake, we'd also have to compare with
> CONFIG_KASAN_INLINE=y, which gets rid of the __asan_ calls (not the
> explicit __kasan_ checks). But I leave it up to you - I'm aware it
> results in slow-downs, too. ;-)
I just realize that my config file for non-RT debug kernel does have 
CONFIG_KASAN_INLINE=y set, though the RT debug kernel does not have 
this. For the non-RT debug kernel, the _asan_report_load* functions are 
still being called because lockdep.c is very big (> 6k lines of code). 
So "call_threshold := 10000" in scripts/Makefile.kasan is probably not 
enough for lockdep.c.
>
>>> With the newly added rtmutex and lockdep lock events, the relevant
>>> event counts for the test runs with the Skylake system were:
>>>
>>>    Event type          Debug kernel    RT debug kernel
>>>    ----------          ------------    ---------------
>>>    lockdep_acquire     1,968,663,277   5,425,313,953
>>>    rtlock_slowlock          -            401,701,156
>>>    rtmutex_slowlock         -                139,672
>>>
>>> The __lock_acquire() calls in the RT debug kernel are x2.8 times of the
>>> non-RT debug kernel with the same workload. Since the __lock_acquire()
>>> function is a big hitter in term of performance slowdown, this makes
>>> the RT debug kernel much slower than the non-RT one. The average lock
>>> nesting depth is likely to be higher in the RT debug kernel too leading
>>> to longer execution time in the __lock_acquire() function.
>>>
>>> As the small advantage of enabling KASAN instrumentation to catch
>>> potential memory access error in the lockdep debugging tool is probably
>>> not worth the drawback of further slowing down a debug kernel, disable
>>> KASAN instrumentation in the lockdep code to allow the debug kernels
>>> to regain some performance back, especially for the RT debug kernels.
> It's not about catching a bug in the lockdep code, but rather guard
> against bugs in code that allocated the storage for some
> synchronization object. Since lockdep state is embedded in each
> synchronization object, lockdep checking code may be passed a
> reference to garbage data, e.g. on use-after-free (or even
> out-of-bounds if there's an array of sync objects). In that case, all
> bets are off and lockdep may produce random false reports. Sure the
> system is already in a bad state at that point, but it's going to make
> debugging much harder.
>
> Our approach has always been to ensure that as soon as there's an
> error state detected it's reported as soon as we can, before it
> results in random failure as execution continues (e.g. bad lock
> reports).
>
> To guard against that, I would propose adding carefully placed
> kasan_check_byte() in lockdep code.

Will take a look at that.

Cheers,
Longman


