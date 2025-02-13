Return-Path: <linux-kernel+bounces-513821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C87A34F02
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E53ADC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BCF24A078;
	Thu, 13 Feb 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNXxpDi+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0624A06F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477183; cv=none; b=Jju7zpxZUtk6gHWjjS1I/N5zQ+KOj70pDxIOwx0K/+J0aPvaqU5FlPBa3aKhWgpdGL7pm3yD78d8vBM30NQyXV3taALkixo6YL8+mq9MOzQvemEzVlLKd2Y+eT5SpXAPu/AnFuyhEA84QcigtaYzHCQyz1n740MoUZoO0i47twE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477183; c=relaxed/simple;
	bh=mL2UFlcZKrvmZwgLjUO7qNsIS/++pRjAw1rqWCBaN7U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ruwOLJj6ysn0VT5hWRLmL3vq7V1vA6g0BDxFfquEu15VT7pc5gOEqHUmm3vEF3lw4jGG1D+BtgJJHeMxNEwsOqQ6IvjT1YqQuq86E94MVxqcgrnKSX2RcERZDAhSAKebB4dzJk/jUEXwN3HcdEFWDOepgrDeA/TvsKmWBADIrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNXxpDi+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739477180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs7CBbdif2NtPjYqaugNyMN77mXyI18t95wiVnROh6Y=;
	b=FNXxpDi+7xpbst4jFGQmeHv+zgF+gY/5yLsFeXSz794j39t0+jBgjFZLbXAd4bUeGPMYo5
	sR9QONm002OI+KvBkqQYbjOfsR8MhKX49g0rVkpEteGVON2TR7J9eaYRVRodmhARp/iPct
	rDUM09unshgwY7HAKZrAwE3GcWOg6eg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-NY7laI_bMCaUhBkkm0FYbA-1; Thu, 13 Feb 2025 15:06:18 -0500
X-MC-Unique: NY7laI_bMCaUhBkkm0FYbA-1
X-Mimecast-MFC-AGG-ID: NY7laI_bMCaUhBkkm0FYbA
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c05f4f174cso216784085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477178; x=1740081978;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs7CBbdif2NtPjYqaugNyMN77mXyI18t95wiVnROh6Y=;
        b=M1IJrA6LsYb9Hyue4MfWDS3xyWej/aepovg595nTl6D0cgfo2BD7n6jin2+ISNU4Br
         qisShuAS+dUsIeUh85BHgn4cqhajNNi6qrlV8ZMUtXrued5vvo1iU0b8e7h0+s0uE8Dh
         plpfOE9lHRYjp9u6gdGXXcDUonvSGgOv4os8RzNHNuAVdPrz+OgHWkJkbaOXkz3lq+jQ
         +nCVS3jKSsEg83rJ9QPfWX0XI/IFuCWFEeojae48VaxFXKE4K2P/ht7aPx2sjGM9H4Tv
         1na+pn7Bq8qSwuc67hOtQz8XmiOeiwUsBo/6TjaTEVW8tF3CK8daMEVLdx/MxA6hfWEN
         m0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpMUWgMmVfctG38c8VNZpzPVMsu06Hy3HG5brqUG6ycHYScAVCxw7eJNCeoXHCzcTCgnNDRCIpJkx2JLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbOQRv8a/KsO9WCYhwIgbhGWouxvemottfhkTVG5zhQTI1ZOw
	ka2dQBt7u8WXQ7C6esWVlXXP9ciOQS1EpYTwzx5IzajkHz0p06roBGUiRLg3RNnQDncDwCz5qez
	aG7a3F+TRXYb3RT8MQC8vctvLqkZDNjV7wm5N4XL1SDjDJcgcdugehEZsZDjELw==
X-Gm-Gg: ASbGncuqUnF0TUWibF/MEunrFTBXKGv0EqxkhviXEpOaiztqhL/CoNlrBnE4o3UFZ9k
	Wcy8mxPz6ImpGaYP2YmrIG1I5RtErDCBlMBudx9ca9CPcLdy6DYqv7aeoU90c74HEkfSmtQG4x4
	u5DcQuWlK/tuOCgdFIduYjBxtOBlXfat2AvsAdy7BdB+W1RGHRvgbxDJSFEPw/1C0QbZGB/ImL3
	PGSBKxhJ7+s5Y37ze6IwkqwqrvSdIfhxKItFv63Azyo5r2rhjvv5R+4fXP+EOw+nreDJTLCHubh
	C/JGXlZSYFiAhMfAbzsjzulXNavhNUoR9EISY+/kV0ErMCBk
X-Received: by 2002:a05:620a:2493:b0:7b6:d5b2:e58 with SMTP id af79cd13be357-7c07a9c2860mr709728385a.18.1739477178369;
        Thu, 13 Feb 2025 12:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIniP7aG237dI6O8ho7k7Na1Hc4s86ZN7C84g/fVD5VmeWoHXp6ymNWU1aZRbAL8iVxDcRgA==
X-Received: by 2002:a05:620a:2493:b0:7b6:d5b2:e58 with SMTP id af79cd13be357-7c07a9c2860mr709724785a.18.1739477178033;
        Thu, 13 Feb 2025 12:06:18 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f3730sm129390585a.20.2025.02.13.12.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:06:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <45f90875-d4b0-4cea-b857-752bc93fd48b@redhat.com>
Date: Thu, 13 Feb 2025 15:06:16 -0500
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
 <a6993bbd-ec8a-40e1-9ef2-74f920642188@redhat.com>
Content-Language: en-US
In-Reply-To: <a6993bbd-ec8a-40e1-9ef2-74f920642188@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/25 11:57 AM, Waiman Long wrote:
> On 2/12/25 6:30 AM, Marco Elver wrote:
>> On Wed, 12 Feb 2025 at 06:57, Boqun Feng <boqun.feng@gmail.com> wrote:
>>> [Cc KASAN]
>>>
>>> A Reviewed-by or Acked-by from KASAN would be nice, thanks!
>>>
>>> Regards,
>>> Boqun
>>>
>>> On Sun, Feb 09, 2025 at 11:26:12PM -0500, Waiman Long wrote:
>>>> Both KASAN and LOCKDEP are commonly enabled in building a debug 
>>>> kernel.
>>>> Each of them can significantly slow down the speed of a debug kernel.
>>>> Enabling KASAN instrumentation of the LOCKDEP code will further slow
>>>> thing down.
>>>>
>>>> Since LOCKDEP is a high overhead debugging tool, it will never get
>>>> enabled in a production kernel. The LOCKDEP code is also pretty mature
>>>> and is unlikely to get major changes. There is also a possibility of
>>>> recursion similar to KCSAN.
>>>>
>>>> To evaluate the performance impact of disabling KASAN instrumentation
>>>> of lockdep.c, the time to do a parallel build of the Linux defconfig
>>>> kernel was used as the benchmark. Two x86-64 systems (Skylake & Zen 2)
>>>> and an arm64 system were used as test beds. Two sets of non-RT and RT
>>>> kernels with similar configurations except mainly CONFIG_PREEMPT_RT
>>>> were used for evaulation.
>>>>
>>>> For the Skylake system:
>>>>
>>>>    Kernel                      Run time            Sys time
>>>>    ------                      --------            --------
>>>>    Non-debug kernel (baseline) 0m47.642s 4m19.811s
>>>>    Debug kernel                        2m11.108s (x2.8) 38m20.467s 
>>>> (x8.9)
>>>>    Debug kernel (patched)      1m49.602s (x2.3) 31m28.501s (x7.3)
>>>>    Debug kernel
>>>>    (patched + mitigations=off)         1m30.988s (x1.9) 26m41.993s 
>>>> (x6.2)
>>>>
>>>>    RT kernel (baseline)                0m54.871s 7m15.340s
>>>>    RT debug kernel             6m07.151s (x6.7) 135m47.428s (x18.7)
>>>>    RT debug kernel (patched)   3m42.434s (x4.1) 74m51.636s (x10.3)
>>>>    RT debug kernel
>>>>    (patched + mitigations=off)         2m40.383s (x2.9) 57m54.369s 
>>>> (x8.0)
>>>>
>>>> For the Zen 2 system:
>>>>
>>>>    Kernel                      Run time            Sys time
>>>>    ------                      --------            --------
>>>>    Non-debug kernel (baseline) 1m42.806s 39m48.714s
>>>>    Debug kernel                        4m04.524s (x2.4) 125m35.904s 
>>>> (x3.2)
>>>>    Debug kernel (patched)      3m56.241s (x2.3) 127m22.378s (x3.2)
>>>>    Debug kernel
>>>>    (patched + mitigations=off)         2m38.157s (x1.5) 92m35.680s 
>>>> (x2.3)
>>>>
>>>>    RT kernel (baseline)                 1m51.500s 14m56.322s
>>>>    RT debug kernel             16m04.962s (x8.7) 244m36.463s (x16.4)
>>>>    RT debug kernel (patched)    9m09.073s (x4.9) 129m28.439s (x8.7)
>>>>    RT debug kernel
>>>>    (patched + mitigations=off)          3m31.662s (x1.9) 51m01.391s 
>>>> (x3.4)
>>>>
>>>> For the arm64 system:
>>>>
>>>>    Kernel                      Run time            Sys time
>>>>    ------                      --------            --------
>>>>    Non-debug kernel (baseline) 1m56.844s 8m47.150s
>>>>    Debug kernel                        3m54.774s (x2.0) 92m30.098s 
>>>> (x10.5)
>>>>    Debug kernel (patched)      3m32.429s (x1.8) 77m40.779s (x8.8)
>>>>
>>>>    RT kernel (baseline)                 4m01.641s 18m16.777s
>>>>    RT debug kernel             19m32.977s (x4.9) 304m23.965s (x16.7)
>>>>    RT debug kernel (patched)   16m28.354s (x4.1) 234m18.149s (x12.8)
>>>>
>>>> Turning the mitigations off doesn't seems to have any noticeable 
>>>> impact
>>>> on the performance of the arm64 system. So the mitigation=off entries
>>>> aren't included.
>>>>
>>>> For the x86 CPUs, cpu mitigations has a much bigger impact on
>>>> performance, especially the RT debug kernel. The SRSO mitigation in
>>>> Zen 2 has an especially big impact on the debug kernel. It is also the
>>>> majority of the slowdown with mitigations on. It is because the 
>>>> patched
>>>> ret instruction slows down function returns. A lot of helper functions
>>>> that are normally compiled out or inlined may become real function
>>>> calls in the debug kernel. The KASAN instrumentation inserts a lot
>>>> of __asan_loadX*() and __kasan_check_read() function calls to memory
>>>> access portion of the code. The lockdep's __lock_acquire() function,
>>>> for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
>>>> added with KASAN instrumentation. Of course, the actual numbers may 
>>>> vary
>>>> depending on the compiler used and the exact version of the lockdep 
>>>> code.
>> For completeness-sake, we'd also have to compare with
>> CONFIG_KASAN_INLINE=y, which gets rid of the __asan_ calls (not the
>> explicit __kasan_ checks). But I leave it up to you - I'm aware it
>> results in slow-downs, too. ;-)

That is not correct. Setting CONFIG_KASAN_INLINE=y does have an effect 
in lockdep.c to reduce the number of __asan_* calls. I have posted the 
v4 series with the updated test results. I have also added a new patch 
to KASAN checking in lock_acquire().

Cheers,
Longman


