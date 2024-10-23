Return-Path: <linux-kernel+bounces-377787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428789AC6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6409B1C21DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0AF19AD71;
	Wed, 23 Oct 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7i0A1kT"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D118453E;
	Wed, 23 Oct 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676285; cv=none; b=u753p0G8B139Xpfydey7Bl7dOW0a3tKz4eD0Xj/sTqwQJ21Wgs7Eg8S8YVvA5ahSHQ6JqpRK4Ro2KeVdBIxzPJVMWTl4QonCYkT6zhBGJ+g3qgyOg8gV+Dth3iepaSHuUbu5ZRs7fx8y6yerppOxR3xDvKoYjzwo+N4E8G/+20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676285; c=relaxed/simple;
	bh=7Kb3Nw75NWOQRzJOM7ozrR+/g9HKnI6A65qcjTowy7o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AIozwuRzctM6WgO/BXfHrBBifjWGYEHQjMrszzzsZO9YmukWuJo7ucRNz6tdehDehxkelRipPJx7xBx00ILWpPywFsmAh/0Bb5aoPtbOu63q7HM8PLGbA0F/tsW0NqNuR6S4qey+iuP/Roo6tI8DnlZ/jYVnEhljK5RHCoLsNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7i0A1kT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso955614066b.1;
        Wed, 23 Oct 2024 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729676282; x=1730281082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xi//lmY3CDXLB22ZA8QT8BrT/DH2hEHxXLSW2RSdvf4=;
        b=F7i0A1kTWx2GXYi0CNSgNw5CqUdENB3lVBg7cj9p3s1Arnc7M55pzarKT+WoUnTQBg
         XRWNq/J8JUfKtw4YcXrWdqEW+QzR2efFpRCRlBSnDNNTha5Lb1/QSqLS0H7YpDI0Ixz+
         E9jowmufuUpsFqvQduZnSRiQ6kQ0th6UPv9dF0CyysrWBPQ4hp496UF+UrkJAA0K0LZZ
         iVBQCZMmvqHSrgj2d8jxF5X6iyKVgVTS5qAy6k1gNxrSIogDEjgFKEZ1G7FtzeqzU7rm
         GhjSRxQUcYsR7Cq0iGliMPrnoLAxAqs+WShLbKAOInCrWgNTiAejJ2+2tOn771vp0Fki
         UnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676282; x=1730281082;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi//lmY3CDXLB22ZA8QT8BrT/DH2hEHxXLSW2RSdvf4=;
        b=I7cG3yx96F7el9ZOOaTzg5jrvUtzizDKSyibYeE36zYumyB/IHAM3X/ffOjOWIlM55
         xXpoG854afRhjP5VTzekPc3p9WjCLDh65qeOgbPbYKgTatVN9tRPDAJZho0u8JmPLu9b
         WgIa4Jp5o0X71srrQTNo/YY5WRN8TESLdDpgoFKOEkV6hZPKPNG3thJrA0YlVujL05Lo
         LVNzUrTyn+7HljCn+Je+1RB1ish/sIOupjRkclHsByIqK1OTPic4BRRf5ZzjhEAbeCs/
         ioEgIqhPFp14haZi8LGqghe/ZuwaMDU3tw8WHbHui8AoHxlS4n9UeRXcYT33C/uiY2me
         GwSg==
X-Forwarded-Encrypted: i=1; AJvYcCVLj301hbo79uLGbNnkrIHLn+CO5s7fFrSMF7DsxqG6tZi9iTS7I4Jr5QbDvRadW9xQRWW24yyLFLqWV6tr@vger.kernel.org, AJvYcCWUeBdnVe0BYXB2YbYbKNxaPKdctuIurnonNEOxs39MvrEHGecTFbOxFUEcxwHFOuvBkaUpm4k6uIer@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfeMqrA1edb6VpEI1BCk8nMxMbH9W6l/LiWvqYrJMgMKu41hN
	GgU5H4dwPbxnSlTGUg7fM9/6uDNB3oE8rD0e9EEWubkleu2ja/R/
X-Google-Smtp-Source: AGHT+IF2xpNDAMd7ETMVHrq0usZAhIAETenBmMVdyqyf3MuQ2dWpqhGHoIm9pnhbGW/M9Gz++KBoVA==
X-Received: by 2002:a17:906:c107:b0:a99:4261:e9f7 with SMTP id a640c23a62f3a-a9abf8d83damr180688066b.39.1729676282124;
        Wed, 23 Oct 2024 02:38:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598f29sm451110266b.190.2024.10.23.02.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:38:01 -0700 (PDT)
Message-ID: <6ff25181-3df7-4edd-b55b-021b74c3b624@gmail.com>
Date: Wed, 23 Oct 2024 10:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
From: Usama Arif <usamaarif642@gmail.com>
To: Rob Herring <robh@kernel.org>, mark.rutland@arm.com, will@kernel.org
Cc: leitao@debian.org, catalin.marinas@arm.com, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org>
 <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
 <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
Content-Language: en-US
In-Reply-To: <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/10/2024 16:30, Usama Arif wrote:
> 
> 
> On 07/10/2024 15:39, Rob Herring wrote:
>> On Mon, Oct 7, 2024 at 9:06 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 04/10/2024 01:03, Rob Herring wrote:
>>>> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>>>>>  __pa() is only intended to be used for linear map addresses and using
>>>>> it for initial_boot_params which is in fixmap for arm64 will give an
>>>>> incorrect value. Hence stash the physical address when it is known at
>>>>> boot time and use it at kexec time instead of converting the virtual
>>>>> address using __pa().
>>>>>
>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>>>>> ---
>>>>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>>>>  drivers/of/fdt.c          | 6 ++++++
>>>>>  drivers/of/kexec.c        | 8 ++++++--
>>>>>  include/linux/of_fdt.h    | 2 ++
>>>>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>>> index b22d28ec8028..a4d96f5e2e05 100644
>>>>> --- a/arch/arm64/kernel/setup.c
>>>>> +++ b/arch/arm64/kernel/setup.c
>>>>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>>>>      /* Early fixups are done, map the FDT as read-only now */
>>>>>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>>>>
>>>>> +    /*
>>>>> +     * Save dt_phys address so that it can be used later for kexec. This
>>>>> +     * is done as __pa() is only intended to be used for linear map addresses
>>>>> +     * and using it for initial_boot_params which is in fixmap will give an
>>>>> +     * incorrect value.
>>>>> +     */
>>>>> +    set_initial_boot_params_pa(dt_phys);
>>>>
>>>> No new arch->dt functions please. If we need to save off the PA, then do
>>>> that when we set initial_boot_params.
>>>>
>>>> Rob
>>>
>>>
>>> initial_boot_params is set in early_init_dt_verify, called by early_init_dt_scan.
>>> This is done in setup_machine_fdt in arm64 where the PA is available,
>>> but in other functions in other architectures, where the PA is not available.
>>
>> Doesn't __pa() work for all the other architectures? That's what your
>> patch indicates.
>>
> 
> Yes, __pa() works for all other architectures.
> 
> But we would need to add initial_boot_params_pa of type phys_addr_t
> as an argument for early_init_dt_scan, which is called by all other archs,
> and we technically cant use 0 as an invalid value.
> 
> We could convert initial_boot_params_pa to void *, and pass NULL for all
> other archs. But again, I don't really think we should be changing the
> early_init_dt_scan(dt_virt) call in all other archs to
> early_init_dt_scan(dt_virt, NULL) just to save initial_boot_params_pa
> in arm64?
> 
>>> So it makes it quite messy to set it in the same place as initial_boot_params.
>>> Its only needed for arm64 and making a change in all archs probably isnt a good idea?
>>>
>>> Any reason to not add a new function to make arch -> of/fdt call?
>>
>> Yes. It is the opposite direction I have reworked the interfaces to.
>> We don't want each arch calling various early DT functions at random
>> times and order. That's fragile when the DT functions make assumptions
>> about when they are called or what's been initialized already.
>>
>> Another option is to make arm64 copy the DT as some arches do.
>>
>> Rob
> 
> Ah maybe I didn't understand this properly, but isnt early_init_dt_scan an
> arch -> of/fdt interfaces. set_initial_boot_params_pa is a similar interface
> to early_init_dt_scan?

Hi,

Just wanted to check in on above. I feel what I am doing here is similar to
early_init_dt_scan so should be ok? There is just a small comment from Saravana
that I need to address which I can in v2, but wanted to check on above before
sending it.

Thanks,
Usama


