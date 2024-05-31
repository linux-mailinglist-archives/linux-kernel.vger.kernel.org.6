Return-Path: <linux-kernel+bounces-196127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB18D57AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AE6284633
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C66AD7;
	Fri, 31 May 2024 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qYcThanK"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D56AC0
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118250; cv=none; b=bvHZ5+jy/kEW+WST8b0af3oNhRRuzcBxla9H3g+qrLiJENIKlE9Olyqe0S9FJarYXqk1c8SKTvt58hsCwF1OcOw6xkzvkNp6E4h/BwIAnofhHOTrdJEUXgxMWd3xc/q0iFGslEf+cOiKBpNVXHi4xcjApYuyQXgnnEmlu/JVWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118250; c=relaxed/simple;
	bh=6qmwuyMEvvP0Hsm2Rz0a7pueEgM5xbu7B+w3vkN7rYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5VNbezIyYYQiWpPb2sunQ5NcCFwixir09kXeAirsM0QdYwjd0FePwU4QrKYAFA0u2E1IRk4NyhsUjZGNHOut6KATL3qD641j7wjx0NMK9aukgmBKpJho3Gbhye5dgomamy7kOOqQg79BAuUUmoz7XZuVquzSWx0pB/4UeF8GT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qYcThanK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nik.borisov@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717118244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwENAVxxQtEomtor8VVQD99hPDXcx9AWwuArFugb+7Q=;
	b=qYcThanKKIBCctUoEHBCXOtSOk9m3a4y4iTXSLJ3BTaV34TPXSNNftXp2BjVpI5rvYAkNg
	aaHvSU7eZSlE0FjdEIn34NTDhevkwN3IG0AdOazV6x+C/1/7N6DsiJgsIxxmM4yw7K9sKx
	KOM3N0FfqJ5jPZKpmfl903LX0JGcmHQ=
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mjguzik@gmail.com
X-Envelope-To: tangyouling@kylinos.cn
Message-ID: <ac6b2f60-e611-422c-9e22-311701f9d4c0@linux.dev>
Date: Fri, 31 May 2024 09:17:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] x86: Remove the prefetch() specific implementation on
 x86_64
To: Nikolay Borisov <nik.borisov@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Mateusz Guzik <mjguzik@gmail.com>, Youling Tang <tangyouling@kylinos.cn>
References: <20240529032059.899347-1-youling.tang@linux.dev>
 <ca6c512a-c9cd-4210-bd71-c72c729c95a9@suse.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <ca6c512a-c9cd-4210-bd71-c72c729c95a9@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Nikolay
On 30/05/2024 23:26, Nikolay Borisov wrote:
>
>
> On 29.05.24 г. 6:20 ч., Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> After commit ab483570a13b ("x86 & generic: change to 
>> __builtin_prefetch()"),
>> x86_64 directly uses __builtin_prefetch() without the specific 
>> implementation
>> of prefetch(). Also, x86_64 use a generic definition until commit 
>> ae2e15eb3b6c
>> ("x86: unify prefetch operations"). So remove it.
>
>
> So this patch just ensures the x86-specific prefetch() implementation 
> is defined only for 32bit case, otherwise we have it defined for the 
> 64bit case as well but effectively it's not used since 
> ARCH_HAS_PREFETCH is not defined for 64bit, meaning in the 64bit case 
> prefetch() is still defined to __builtint_prefetch in 
> include/linux/prefetch.h.
>
>
> In essence this is a purely cosmetic cleanup , am I right?
Yes, when arch customization and __builtint_prefetch are implemented with
the same instructions, it looks like pure cleaning (without changing the
generated assembly).

Thanks,
Youling.
>
>
> I compiled a file that utilizes prefetch with and without your patch 
> and the generated assembly is identical.
>
>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
>
>
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/x86/include/asm/processor.h | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/processor.h 
>> b/arch/x86/include/asm/processor.h
>> index cb4f6c513c48..44371bdcc59d 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -599,9 +599,6 @@ extern char            ignore_fpu_irq;
>>   #ifdef CONFIG_X86_32
>>   # define BASE_PREFETCH        ""
>>   # define ARCH_HAS_PREFETCH
>> -#else
>> -# define BASE_PREFETCH        "prefetcht0 %1"
>> -#endif
>>     /*
>>    * Prefetch instructions for Pentium III (+) and AMD Athlon (+)
>> @@ -616,6 +613,10 @@ static inline void prefetch(const void *x)
>>                 "m" (*(const char *)x));
>>   }
>>   +#else
>> +# define BASE_PREFETCH        "prefetcht0 %1"
>> +#endif
>> +
>>   /*
>>    * 3dnow prefetch to get an exclusive cache line.
>>    * Useful for spinlocks to avoid one state transition in the

