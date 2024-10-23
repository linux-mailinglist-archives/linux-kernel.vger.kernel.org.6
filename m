Return-Path: <linux-kernel+bounces-378344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D59ACEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2348D286407
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A94F1C830E;
	Wed, 23 Oct 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH6M5GLD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC661C726D;
	Wed, 23 Oct 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697067; cv=none; b=W0VzyCRhnSEZL/xVRIPz5r3Qgs1n3AaVUarK3jp3t2WViROpWSPfUCoxZ6RD/Z8QaxJ2jdlBfDweUeIpaG6OdcIgL5Nfcej9HrKwD/JP33q4ky4fXGtRAol4wl/GE1Hz34+clahvrbHU3FUShfquKboX9o2m73e2jxsDVfSBizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697067; c=relaxed/simple;
	bh=yRzFip91Xr2ZV5np80u8yjQpIQR4flidzXUnRUp49Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uscRL6LnTQm5lEZKs7rU0giLi16vnCZRcHTvQteldbmvDFUJuhQ26FM9q5wI5WbV5NZOGD3eZpcJUKKvJhdVIHfHz6rQbpWe8iNmRnWRj1Xvf+vs/1npXXi1wcMw4cxxBBX2YXMlqJo/HT9b7vNwfnKWb04vI2Y5/xsh6cFnD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH6M5GLD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9acafdb745so62735766b.0;
        Wed, 23 Oct 2024 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729697064; x=1730301864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8bsCbuYj3wrkY+HeSAAVlp5CC82l84u/ffkdl8Y/1g=;
        b=aH6M5GLDsycGXsbPOxlYJazYkIzih+BWAA/OOmx6b6dd99ysO5nBUOUxwBccvDHg7s
         selKvdvhJ8u1WNDaddzcnWqvhAsbvCB5S0O2ZXYlmehhKYpTkXeJu6EDLV2aiyPoDvGR
         iBqoYSF5hOXxIixCwNAHse/ShtT6zk6fRMykKOpgomSgVVQllEilu8SPzbC4Tefr8Kse
         e8t1Mp65IQkmvgAjX6+fur0asNmeZQZRV2GppD+k0stS7ZZCAFpaGnIwnKR+tFL+2hXK
         sWa0XFCtS7UNtHv0JJmoFLUhOSyn36UiBNp20fyWMIae0OYEoxYGqPh9+5bBPMpO89O+
         BPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697064; x=1730301864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8bsCbuYj3wrkY+HeSAAVlp5CC82l84u/ffkdl8Y/1g=;
        b=ZBDYZIkmILh4tMW8r7JFeTTxzRAv88UI6Hq5vPixSx0xtVqEsVnIlHzZ7Yw8cbOzbM
         y77kJiFm8mNZSXJmfJedemJbk1VeoStNDZxnu467csrCb4jOqUrYSeNUWariM8iOZIn6
         TDJ2hM4xF56xBrDHCNcd0bY7/GfmdTns49UWpNx3JxB0ZBwA/xMonAbpPq2ghaQOpPil
         hIYI1PiXLNX2wEOZdZb73rqbq0lcutWeMTDSeMdygbLL7QtLMmTaHp9VTDTD4QVGX9CN
         qWXSF9OzPrIcfy+8oH7UBo4dlQQa7Xx0kTx68fQwihkSpvzMQBQ4G/s9Br3NOQpFfkSL
         5BEw==
X-Forwarded-Encrypted: i=1; AJvYcCVCgq05b6QvWjpC8wqyDaAujZ/+Z3BDPWX+jZy/pEmPrWi1ccwV6XQoyOmcomka/isDmUNZin/lPnpy@vger.kernel.org, AJvYcCVumwDRcV5NqZ2f8I0fgJD+YGqeG4h5Y49GkUw3RDfODGXE5P3/Jgj27jKeUzwU539UCZADPuWa7IDJTzbZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4w77CJVi2civDJZXXzkcMg9lEEcUShXWj1Wk6jH8vxZ71hZxp
	S4X31fee1XVnz2OJbg9DaQPhuqAocFndMCYj+YM/nTZeYzFvKqpc
X-Google-Smtp-Source: AGHT+IGLxU7wxiCH3a1b/uHVpe3fD6Af7zQszRgnPFbDSKYaGfHilRmwG2cZ7GC2/X4IxrDdkB/rog==
X-Received: by 2002:a17:907:6d0c:b0:a8d:2281:94d9 with SMTP id a640c23a62f3a-a9aaa620d72mr822955666b.23.1729697063565;
        Wed, 23 Oct 2024 08:24:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559b33sm487702366b.116.2024.10.23.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:24:23 -0700 (PDT)
Message-ID: <237a32b7-e2c9-4db4-9358-918ce54da779@gmail.com>
Date: Wed, 23 Oct 2024 16:24:22 +0100
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
 <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
 <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
 <1e117d65-b454-4d5c-b03a-c3ab3b078093@gmail.com>
 <CAL_JsqJhd0X+eCW6WgXUjCLb-dBqHN4_01vzRRLU07Wz5Q2tLw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqJhd0X+eCW6WgXUjCLb-dBqHN4_01vzRRLU07Wz5Q2tLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/10/2024 16:17, Rob Herring wrote:
> On Wed, Oct 23, 2024 at 9:43 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 23/10/2024 14:40, Rob Herring wrote:
>>> On Mon, Oct 7, 2024 at 10:30 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 07/10/2024 15:39, Rob Herring wrote:
>>>>> On Mon, Oct 7, 2024 at 9:06 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 04/10/2024 01:03, Rob Herring wrote:
>>>>>>> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>>>>>>>>  __pa() is only intended to be used for linear map addresses and using
>>>>>>>> it for initial_boot_params which is in fixmap for arm64 will give an
>>>>>>>> incorrect value. Hence stash the physical address when it is known at
>>>>>>>> boot time and use it at kexec time instead of converting the virtual
>>>>>>>> address using __pa().
>>>>>>>>
>>>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>>>>>>>> ---
>>>>>>>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>>>>>>>  drivers/of/fdt.c          | 6 ++++++
>>>>>>>>  drivers/of/kexec.c        | 8 ++++++--
>>>>>>>>  include/linux/of_fdt.h    | 2 ++
>>>>>>>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>>>>>> index b22d28ec8028..a4d96f5e2e05 100644
>>>>>>>> --- a/arch/arm64/kernel/setup.c
>>>>>>>> +++ b/arch/arm64/kernel/setup.c
>>>>>>>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>>>>>>>      /* Early fixups are done, map the FDT as read-only now */
>>>>>>>>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>>>>>>>
>>>>>>>> +    /*
>>>>>>>> +     * Save dt_phys address so that it can be used later for kexec. This
>>>>>>>> +     * is done as __pa() is only intended to be used for linear map addresses
>>>>>>>> +     * and using it for initial_boot_params which is in fixmap will give an
>>>>>>>> +     * incorrect value.
>>>>>>>> +     */
>>>>>>>> +    set_initial_boot_params_pa(dt_phys);
>>>>>>>
>>>>>>> No new arch->dt functions please. If we need to save off the PA, then do
>>>>>>> that when we set initial_boot_params.
>>>>>>>
>>>>>>> Rob
>>>>>>
>>>>>>
>>>>>> initial_boot_params is set in early_init_dt_verify, called by early_init_dt_scan.
>>>>>> This is done in setup_machine_fdt in arm64 where the PA is available,
>>>>>> but in other functions in other architectures, where the PA is not available.
>>>>>
>>>>> Doesn't __pa() work for all the other architectures? That's what your
>>>>> patch indicates.
>>>>>
>>>>
>>>> Yes, __pa() works for all other architectures.
>>>>
>>>> But we would need to add initial_boot_params_pa of type phys_addr_t
>>>> as an argument for early_init_dt_scan, which is called by all other archs,
>>>> and we technically cant use 0 as an invalid value.
>>>>
>>>> We could convert initial_boot_params_pa to void *, and pass NULL for all
>>>> other archs. But again, I don't really think we should be changing the
>>>> early_init_dt_scan(dt_virt) call in all other archs to
>>>> early_init_dt_scan(dt_virt, NULL) just to save initial_boot_params_pa
>>>> in arm64?
>>>>
>>>>>> So it makes it quite messy to set it in the same place as initial_boot_params.
>>>>>> Its only needed for arm64 and making a change in all archs probably isnt a good idea?
>>>>>>
>>>>>> Any reason to not add a new function to make arch -> of/fdt call?
>>>>>
>>>>> Yes. It is the opposite direction I have reworked the interfaces to.
>>>>> We don't want each arch calling various early DT functions at random
>>>>> times and order. That's fragile when the DT functions make assumptions
>>>>> about when they are called or what's been initialized already.
>>>>>
>>>>> Another option is to make arm64 copy the DT as some arches do.
>>>>>
>>>>> Rob
>>>>
>>>> Ah maybe I didn't understand this properly, but isnt early_init_dt_scan an
>>>> arch -> of/fdt interfaces. set_initial_boot_params_pa is a similar interface
>>>> to early_init_dt_scan?
>>>
>>> Yes, and I don't want more APIs if they can be avoided. When is
>>> set_initial_boot_params_pa() supposed to be called? Is it before or
>>> after early_init_dt_scan()?
>>
>> Its only needed in arm64, and can be either before or after, as long as its
>> somewhere in setup_machine_fdt, where dt_phys is available.
> 
> Maybe only arm64 today. What happens when riscv decides they too want
> to support the DT anywhere in memory including outside the linear
> address map and then they need the same thing.
> 
>>> Can subsequent OF functions assume the PA
>>> is valid?
>>
>> After set_initial_boot_params_pa has been called, yes.
> 
> How do I know it has been called? Do I have to go wade thru every arch
> to see? You could document the requirement to be immediately after
> early_init_dt_scan(), but then how do you enforce that? You can't
> unless you design the interface to just avoid the problem in the first
> place.
> 
>>> If an arch doesn't call set_initial_boot_params_pa() is
>>> __pa() valid or did they just forget to call it?
>>
>> Only arm64 seems to do the fixmap as discussed in
>> https://lore.kernel.org/all/1ea5538f-7e96-4034-9af9-e2d5fd72e069@gmail.com/,
>> so __pa should work in others.
>>
>> Requiring the PA to
>>> be set at the same time as initial_boot_params avoids all those issues
>>> with any period of time having the PA incorrect.
>>>
>>
>> Are you recommending I send a patch which changes all archs to call
>> early_init_dt_scan(dt_virt, NULL)?
>> or maybe early_init_dt_scan(dt_virt, __pa(dt_virt))?
>> and arm to call early_init_dt_scan(dt_virt, dt_phys).
> 
> I believe that's what I suggested already, so yes. Whether NULL or
> __pa(dt_virt))? __pa() would be better because then the arch has to
> think about whether that is right or not.


Sounds good! Will send a v2 with the change.

Thanks
> 
>> Happy to do send a v2 with that if its the way forward, although I feel
>> set_initial_boot_params_pa() in just one arch might be better than
>> changing this for all archs.
> 
> We don't work around kernel APIs if they don't meet changing needs. We
> change them.
> 
> Rob


