Return-Path: <linux-kernel+bounces-260716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DA93AD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FB51C21FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634A1304A2;
	Wed, 24 Jul 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uMi1PEu0"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661694F20C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807114; cv=none; b=EAofFbU82vOJ/GrzTaPWzx32Oq7cuQrGJAEc9+vaMeofdlprxWAahVcHodYbJ8In4DA1wfogx3hg9CFn0f1D8BJ0InqKwZlBAaZstDhYvXlF1Babl5WQRnIbJhLcVP44jHoHSG5pevIC02yVj1aH+lcqR60y5Hy2qyJV/q2C9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807114; c=relaxed/simple;
	bh=+FR2hQULrYhvFvdpBkBINj08hvjBi5zK2CHHyfvgaGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQJiIIAV7Gt4+GZpAGdYku2z6uauQL6fJYFNX+jcw+NmMfb1/BByaKK4rp3FMI5suIxG5UfKDE0V1ymQUyhaGF6RoaPtHFesMG3lvQ19aQVzhB40MX9AbJtlUL7wG4nncC6vDmtE9ORMHuoG5DHDkbKrSHl1UBmCGEoL5Cbnf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uMi1PEu0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8ca83e6-78c3-4628-bb83-45f985c10e19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721807107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VMPG8iuL1N930tqnUiE6nL99hrpsa0cwNGG8JxcZmw=;
	b=uMi1PEu0kbcG2dThR1Nx8hicjtRi7qAGloIGBO8iFspUx+pvjCMxQ/qcPw4M8ypg788c43
	q73gUpElnRZnLvbxjwtxbQAEEo5bJ8m76YN1cBkbr8IhQYXcF8zGQBYKsSVCGwCNx/iJ7Y
	BspWAQvj4Mg6kgx2GRqAZzuM1kOOymY=
Date: Wed, 24 Jul 2024 15:45:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] x86: Remove the prefetch() specific implementation on
 x86_64
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240529032059.899347-1-youling.tang@linux.dev>
 <ca6c512a-c9cd-4210-bd71-c72c729c95a9@suse.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <ca6c512a-c9cd-4210-bd71-c72c729c95a9@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

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
Sorry to bother you, but do we still need this patchset? (Do I need to
modify the commit message and send v2 if necessary?)

Thanks,
Youling.

