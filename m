Return-Path: <linux-kernel+bounces-353693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DE993133
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D767283123
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F01D90D7;
	Mon,  7 Oct 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzhngAvp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2331D2B2F;
	Mon,  7 Oct 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315025; cv=none; b=m5Of0A92DY/aVFuheD950JDtovZB6T9uv0nCQWjcHaF0DGfwtql56KHzDsCuWpfdIyUUhZaG5NiAHIr2ayzYyxaLJ2HxWMIRTU45jYkMKZJL+hDtl+2WqOc20YGCgrMbcuNaKHbTSx1M6HzGXVlizhKeA3GPiIxdLY527JIdw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315025; c=relaxed/simple;
	bh=Xs/hTm7xFv57sh+NihMg2g8xkqVuy3CQwYYKKP/ImGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY/LlwIn5BO1M3hFPiJoUireJv7rnIgE2R0GcnK2b7COs/q0ljs8yZIFpWlHOCxXgYDtlooC8qZf9yUfIDY1CIrWpg4u3T1hutM/yqn59ZxWA8/3E7Hfy3K4sz3zG1L4W6jkSMkCGTfWXWv6KmOZEWoRXUFo+RMNmlXDeTa9N3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzhngAvp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so5653939e87.1;
        Mon, 07 Oct 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315022; x=1728919822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXLByxgQO38tEiqRKfkJDtPyksE44EY2/93lJNbxUPM=;
        b=UzhngAvp3i/0ZmmQRY2+iAXgxGPrsxQsES1k9sgX911RfXlu4GF3TfB8zPd4RmzIWg
         gJmkZRipmCmvqzdVzLRH06KwKQC4GJ/y/oYJ5oFpSm4hiXUsSA+aJrFqJxUWizmCtIv8
         6OD84nQtwANjMSMhDsmEpIh6qep9mjzbsfk8tw8mS69Ce8JDHWnmw/ScajO9ZuS0IzCL
         W8ul+ZMhENy6T+lxEFFDJrdcnD3RpDWzmDU8VbwOf+ZRNbTjs6wJ+2Xea+GKjJgNqW7G
         boDToTXHHJmzcrkuJ+h+GsXFri6jM6HOPDrIdIXfL+RQkkVcqUnB4Lmbq3QntnVAY92C
         x97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315022; x=1728919822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXLByxgQO38tEiqRKfkJDtPyksE44EY2/93lJNbxUPM=;
        b=iQgyJiKND7t7bwEwqfcBf7kOXqK7LkAVjm9hmKIPahSFAGP2ndFcdTNidoDAkf+19p
         6ph/vd8GkkpoLtN7DrHyiHX5h2UhD4AZ7iYxbIPqgBvJXJbJWwgSZsKJxAGCaN1Nlymu
         Q60YgAmyoLPklRvAxZbTvu24yVgtEHIQ+fXHvIYCJKm6y0FzK8ArUO0xbSVbmzfABeq9
         8oXG+hQ2Kddka4QMKfrCLEoEL8sMpBHVzgmYTrVZVdDN06Ff9A6xizQzDklJnyYhxZzP
         l0c5wWN2C4j17ycESfHIHAUdgrfN7vfMM4YYfmfQsfA+IfRrxYAiaxpdm7OAuRHUKuVk
         Itdw==
X-Forwarded-Encrypted: i=1; AJvYcCUDfGzuF9NSfMzLXD2AaYXzwR/VM6Re39a7cMOqxAc1+U0Pc+WbySKqmyalYgZ2Y9OQqXoHYVukac4yw9el@vger.kernel.org, AJvYcCVPg1r9Y32UUep3uAJIYhn0DM+WwuIV0H5R72B/JjEe3/attGQkyGzv6dhjvKpJEeQdib82VOtOxGFz@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwlmnhw8IRBYbwxGlLNmg1fag/FJr8dL6pe/14+0cmrKa8NWy
	N9s9oKm0qCu1V3mk6v40rDLFb7TTXDHfex8jmBzBlVZQvShxB50TGkz5yg==
X-Google-Smtp-Source: AGHT+IFzFcHLeJlu8dAi5eLHYzBkuPCqoVEGXKOk00hKW7JHJg1u6N9K9qAJKE3PQff6BeCe5jf0bg==
X-Received: by 2002:a05:6402:13cd:b0:5c4:a6f:9be7 with SMTP id 4fb4d7f45d1cf-5c8d2e397c1mr12425589a12.8.1728315009552;
        Mon, 07 Oct 2024 08:30:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:3232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb5ebsm3426058a12.65.2024.10.07.08.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 08:30:09 -0700 (PDT)
Message-ID: <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
Date: Mon, 7 Oct 2024 16:30:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org>
 <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/10/2024 15:39, Rob Herring wrote:
> On Mon, Oct 7, 2024 at 9:06 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 04/10/2024 01:03, Rob Herring wrote:
>>> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>>>>  __pa() is only intended to be used for linear map addresses and using
>>>> it for initial_boot_params which is in fixmap for arm64 will give an
>>>> incorrect value. Hence stash the physical address when it is known at
>>>> boot time and use it at kexec time instead of converting the virtual
>>>> address using __pa().
>>>>
>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>>>> ---
>>>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>>>  drivers/of/fdt.c          | 6 ++++++
>>>>  drivers/of/kexec.c        | 8 ++++++--
>>>>  include/linux/of_fdt.h    | 2 ++
>>>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>> index b22d28ec8028..a4d96f5e2e05 100644
>>>> --- a/arch/arm64/kernel/setup.c
>>>> +++ b/arch/arm64/kernel/setup.c
>>>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>>>      /* Early fixups are done, map the FDT as read-only now */
>>>>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>>>
>>>> +    /*
>>>> +     * Save dt_phys address so that it can be used later for kexec. This
>>>> +     * is done as __pa() is only intended to be used for linear map addresses
>>>> +     * and using it for initial_boot_params which is in fixmap will give an
>>>> +     * incorrect value.
>>>> +     */
>>>> +    set_initial_boot_params_pa(dt_phys);
>>>
>>> No new arch->dt functions please. If we need to save off the PA, then do
>>> that when we set initial_boot_params.
>>>
>>> Rob
>>
>>
>> initial_boot_params is set in early_init_dt_verify, called by early_init_dt_scan.
>> This is done in setup_machine_fdt in arm64 where the PA is available,
>> but in other functions in other architectures, where the PA is not available.
> 
> Doesn't __pa() work for all the other architectures? That's what your
> patch indicates.
> 

Yes, __pa() works for all other architectures.

But we would need to add initial_boot_params_pa of type phys_addr_t
as an argument for early_init_dt_scan, which is called by all other archs,
and we technically cant use 0 as an invalid value.

We could convert initial_boot_params_pa to void *, and pass NULL for all
other archs. But again, I don't really think we should be changing the
early_init_dt_scan(dt_virt) call in all other archs to
early_init_dt_scan(dt_virt, NULL) just to save initial_boot_params_pa
in arm64?

>> So it makes it quite messy to set it in the same place as initial_boot_params.
>> Its only needed for arm64 and making a change in all archs probably isnt a good idea?
>>
>> Any reason to not add a new function to make arch -> of/fdt call?
> 
> Yes. It is the opposite direction I have reworked the interfaces to.
> We don't want each arch calling various early DT functions at random
> times and order. That's fragile when the DT functions make assumptions
> about when they are called or what's been initialized already.
> 
> Another option is to make arm64 copy the DT as some arches do.
> 
> Rob

Ah maybe I didn't understand this properly, but isnt early_init_dt_scan an
arch -> of/fdt interfaces. set_initial_boot_params_pa is a similar interface
to early_init_dt_scan?

