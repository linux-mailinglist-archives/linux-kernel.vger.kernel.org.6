Return-Path: <linux-kernel+bounces-311437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884D968921
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11147284506
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1D20FA8B;
	Mon,  2 Sep 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDWHnr+k"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747319C540
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284881; cv=none; b=u5eR1Ea2+X9TwKVAuUP2Q5Bd4gq50JAHKhiEeOOo3UtnGTjvZYuk8kIRpGDFM8YPvlSJ3vsD/ElCIQsWx/ybxtd8f9AYe8P5QDbVv821M12A43MMpI56df9Ccht4d58o8aHgZuJsUtVfGUt3xbQWCwOzNLS7NkljzgRHD4jjKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284881; c=relaxed/simple;
	bh=XzUZVGSWz2CmVQuA4szIiURNmFScqfS4kljTIENt6rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og1V8oghaItIicC0AxhKitSyClMiWAYQmnvJ2xhLKYUcc/HHW5zAqgnVShKsp1xeIWUpHSdo4aJ1rSObC1txTcht3xDjfqDgLqArpkquYNmJWSoWwbiZxOKQ2srcV+aJJqjeQkhAow4OCcL4OgF8WorRAB7BuIBECrmcQML7cWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDWHnr+k; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7176645e440so223573b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725284879; x=1725889679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mFbcvxA99b70OoT97h9fG14hu9y3TlWvc94IbvGyYls=;
        b=JDWHnr+kTfcf4gkz1KbBzMpV6hBNCz7aBec23A5clLtSmpyVuJz2mBhFbo24o6mG1Y
         3fHNBFPbap3BT4LP2C9QAxe+d8SIVx8ia+6QXOtRgV1hqNJJ/ye/hzSXNZY+iSNpKRrj
         cdqf/5gueqn4eM22hZ2Vj94gGEkLlDNKR+zWkWaAD3Jkf1fEIHuODQABZNiifiT7c7JJ
         ixdiBqa3OkJ4Yc6HAaurVYXoLsE277jJvzfL1qH24lwBT3k+4X44IxrVfdfGyq+RMkV+
         ShszNkuHNvYaYZI96373SoqDn9NtlIq/ggrq0OfNCr1vE+aWWuiVdBCSMJj9QEpS5S+0
         Yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284879; x=1725889679;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFbcvxA99b70OoT97h9fG14hu9y3TlWvc94IbvGyYls=;
        b=T3YRPwvx/pPdfUjbR/flBa6ExRW91dwRUaQxetwkVJ/vTd98OC26vqrVcsykGThZi+
         rAKs2gnX8v8EPz5U3I5FpyjPaQBxra8ULufiTwNg1eRkCig2E0QDIbuNjIczI5+7oItM
         06sTJK/ZfK8lH8ekU2HM9+TqOP+SnX6XsqLo+AYxY+6g8YNWffbl7QvEYRlN8MBUUsAI
         RvpGYZIA0HSl7eypIJYGyn0NNjN5UlmlsItFQ+vTVA92a8FEglG6hqTJyuSAYjF9It5t
         K4T/xNdAoXsdj2888hxdyasWmIX6rgG9rgXuu2h8n1A07t8WKS8U5xzOWETpfptYDfxZ
         Ju/w==
X-Forwarded-Encrypted: i=1; AJvYcCUj9ijKolfP66yqlxdmudJ5VuC9ixktc2VtzEwMvkaZLDW913TRLJMG8hH57Dfo/7uffT5/1RCnv7Lmbl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29XnqTeanpasnfhqzHHkzSOdEiuqpYFvR0ux2SndG1ZQs+bsX
	YEJ/p5tUnz0ZC1j5psDm2gp5qeEo6wSDPxjfqxvO4mBJQks3b9OoIn97emYH4NU=
X-Google-Smtp-Source: AGHT+IGQgntCas+rvTGbOnnGvb1gygf7PDeQbGFLiYqEfBuHvrvUliR98wM2P9ZNiv3xf128KkBT2g==
X-Received: by 2002:a05:6a21:348b:b0:1cc:d5d1:fe64 with SMTP id adf61e73a8af0-1ccee7ceba6mr18478823637.14.1725284878884;
        Mon, 02 Sep 2024 06:47:58 -0700 (PDT)
Received: from [192.168.15.10] (201-92-186-18.dsl.telesp.net.br. [201.92.186.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef15sm6840873b3a.105.2024.09.02.06.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 06:47:58 -0700 (PDT)
Message-ID: <e8e8e73b-99b1-41b1-b574-0feb907c1eae@linaro.org>
Date: Mon, 2 Sep 2024 10:47:54 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>,
 ardb@kernel.org
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
 <963afe11-fd48-4fe9-be70-2e202f836e34@linaro.org>
 <ZtW5meR5iLrkKErJ@zx2c4.com>
 <8390ac81-7774-4e67-9739-c2b98813d6da@csgroup.eu>
 <ZtW8zh8ED-oePxnw@zx2c4.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <ZtW8zh8ED-oePxnw@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/09/24 10:25, Jason A. Donenfeld wrote:
> On Mon, Sep 02, 2024 at 03:19:56PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 02/09/2024 à 15:11, Jason A. Donenfeld a écrit :
>>> Hey Christophe (for header logic) & Will (for arm64 stuff),
>>>
>>> On Fri, Aug 30, 2024 at 09:28:29AM -0300, Adhemerval Zanella Netto wrote:
>>>>>> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
>>>>>> index 938ca539aaa6..7c9711248d9b 100644
>>>>>> --- a/lib/vdso/getrandom.c
>>>>>> +++ b/lib/vdso/getrandom.c
>>>>>> @@ -5,6 +5,7 @@
>>>>>>   
>>>>>>   #include <linux/array_size.h>
>>>>>>   #include <linux/minmax.h>
>>>>>> +#include <linux/mm.h>
>>>>>>   #include <vdso/datapage.h>
>>>>>>   #include <vdso/getrandom.h>
>>>>>>   #include <vdso/unaligned.h>
>>>>>
>>>>> Looks like this should be a separate change?
>>>>
>>>>
>>>> It is required so arm64 can use  c-getrandom-y, otherwise vgetrandom.o build
>>>> fails:
>>>>
>>>> CC      arch/arm64/kernel/vdso/vgetrandom.o
>>>> In file included from ./include/uapi/linux/mman.h:5,
>>>>                   from /mnt/projects/linux/linux-git/lib/vdso/getrandom.c:13,
>>>>                   from <command-line>:
>>>> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_prot_bits’:
>>>> ./arch/arm64/include/asm/mman.h:14:13: error: implicit declaration of function ‘system_supports_bti’ [-Werror=implicit-function-declaration]
>>>>     14 |         if (system_supports_bti() && (prot & PROT_BTI))
>>>>        |             ^~~~~~~~~~~~~~~~~~~
>>>> ./arch/arm64/include/asm/mman.h:15:24: error: ‘VM_ARM64_BTI’ undeclared (first use in this function); did you mean ‘ARM64_BTI’?
>>>>     15 |                 ret |= VM_ARM64_BTI;
>>>>        |                        ^~~~~~~~~~~~
>>>>        |                        ARM64_BTI
>>>> ./arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier is reported only once for each function it appears in
>>>> ./arch/arm64/include/asm/mman.h:17:13: error: implicit declaration of function ‘system_supports_mte’ [-Werror=implicit-function-declaration]
>>>>     17 |         if (system_supports_mte() && (prot & PROT_MTE))
>>>>        |             ^~~~~~~~~~~~~~~~~~~
>>>> ./arch/arm64/include/asm/mman.h:18:24: error: ‘VM_MTE’ undeclared (first use in this function)
>>>>     18 |                 ret |= VM_MTE;
>>>>        |                        ^~~~~~
>>>> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_flag_bits’:
>>>> ./arch/arm64/include/asm/mman.h:32:24: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
>>>>     32 |                 return VM_MTE_ALLOWED;
>>>>        |                        ^~~~~~~~~~~~~~
>>>> ./arch/arm64/include/asm/mman.h: In function ‘arch_validate_flags’:
>>>> ./arch/arm64/include/asm/mman.h:59:29: error: ‘VM_MTE’ undeclared (first use in this function)
>>>>     59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>>>>        |                             ^~~~~~
>>>> ./arch/arm64/include/asm/mman.h:59:52: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
>>>>     59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>>>>        |                                                    ^~~~~~~~~~~~~~
>>>> arch/arm64/kernel/vdso/vgetrandom.c: In function ‘__kernel_getrandom’:
>>>> arch/arm64/kernel/vdso/vgetrandom.c:18:25: error: ‘ENOSYS’ undeclared (first use in this function); did you mean ‘ENOSPC’?
>>>>     18 |                 return -ENOSYS;
>>>>        |                         ^~~~~~
>>>>        |                         ENOSPC
>>>> cc1: some warnings being treated as errors
>>>>
>>>> I can move to a different patch, but this is really tied to this patch.
>>>
>>> Adhemerval kept this change in this patch for v3, which, if it's
>>> necessary, is fine with me. But I was looking to see if there was
>>> another way of doing it, because including linux/mm.h inside of vdso
>>> code is kind of contrary to your project with e379299fe0b3 ("random:
>>> vDSO: minimize and simplify header includes").
>>>
>>> getrandom.c includes uapi/linux/mman.h for the mmap constants. That
>>> seems fine; it's userspace code after all. But then uapi/linux/mman.h
>>> has this:
>>>
>>>     #include <asm/mman.h>
>>>     #include <asm-generic/hugetlb_encode.h>
>>>     #include <linux/types.h>
>>>
>>> The asm-generic/ one resolves to uapi/asm-generic. But the asm/ one
>>> resolves to arch code, which is where we then get in trouble on ARM,
>>> where arch/arm64/include/asm/mman.h has all sorts of kernel code in it.
>>>
>>> Maybe, instead, it should resolve to arch/arm64/include/uapi/asm/mman.h,
>>> which is the header that userspace actually uses in normal user code?
>>>
>>> Is this a makefile problem? What's going on here? Seems like this is
>>> something worth sorting out. Or I can take Adhemerval's v3 as-is and
>>> we'll grit our teeth and work it out later, as you prefer. But I thought
>>> I should mention it.
>>
>> That's a tricky problem, I also have it on powerpc, see patch 5, I 
>> solved it that way:
>>
>> In the Makefile:
>> -ccflags-y := -fno-common -fno-builtin
>> +ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
>>
>> In arch/powerpc/include/asm/mman.h:
>>
>> diff --git a/arch/powerpc/include/asm/mman.h 
>> b/arch/powerpc/include/asm/mman.h
>> index 17a77d47ed6d..42a51a993d94 100644
>> --- a/arch/powerpc/include/asm/mman.h
>> +++ b/arch/powerpc/include/asm/mman.h
>> @@ -6,7 +6,7 @@
>>
>>   #include <uapi/asm/mman.h>
>>
>> -#ifdef CONFIG_PPC64
>> +#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)
>>
>>   #include <asm/cputable.h>
>>   #include <linux/mm.h>
>>
>> So that the only thing that remains in arch/powerpc/include/asm/mman.h 
>> when building a VDSO is #include <uapi/asm/mman.h>
>>
>> I got the idea from ARM64, they use something similar in their 
>> arch/arm64/include/asm/rwonce.h
> 
> That seems reasonable enough. Adhemerval - do you want to incorporate
> this solution for your v+1? And Will, is it okay to keep that as one
> patch, as Christophe has done, rather than splitting it, so the whole
> change is hermetic?

Sure, I will do it for v4.

