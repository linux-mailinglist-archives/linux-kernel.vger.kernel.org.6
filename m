Return-Path: <linux-kernel+bounces-378286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0879ACDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3EEB2679C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B91EF0BF;
	Wed, 23 Oct 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3QXyMky"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DC1E8837;
	Wed, 23 Oct 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694631; cv=none; b=tU3yp27qMu9Loyr66WebPjr31jtLKq3F+ahTYXHjAAW5fjYOOcTKfB13cdybXistqAfluM0mA21Y2CotS5QrBuLDHzVB0g4m0017LS3gSTRyQ7YNLls6iwvyVQIH0SeFehiakVs1U9OYFIRNdogoexxRh5d4UKMeTEDC+gMphE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694631; c=relaxed/simple;
	bh=/iigP6/X5LG3wncShhnLmrKx0a90T3hO86bwJp6jxT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkdLN3xcllnVIzdf4Sskj0aYPOOwEP14TJPPEIQHSujsZ075qusxkmUT2eQ1ZH2tznhk/wzcml8J5cYZgh9UHTKO3vvLrjbHmfVTICZo8RZFxyeFb7xFupdInpVoUPM2pHN30FEhHiuDvYGlo5R/z+OcsiHFRJ8l8e1skg+FSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3QXyMky; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so7043855a12.3;
        Wed, 23 Oct 2024 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729694628; x=1730299428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5rYTkHY31+cXuKv/fhTi/vwecjYJXbckDY0ZiVGZng=;
        b=c3QXyMkyXAteepZFxU7afN2aJVLE+RjydpG6iGLpCh+6Kt+AoZZRGm63Ham+5c+/aK
         nTDBm8lydEfjvrS4uj/ECsQ+FSSqScf/jWrvEPFm38GENYHO1XFgIbEkj6PCVb+kcseW
         AKUT9W7uyVJZ0fxBElDodRtu4ihV9IZyZVBraigaAi9Pb0X8j3iiEWgworlca9A9H/Oy
         m60sLJVWx8w9y/32wHtEBrob9RaO19Ud5lF3WgNEf0jFLVD4BydfX5acBdcykHkd5qDX
         LfS543MXQUdbsa2qdyAYvK43nmuigTJVal5AfxiffgBP2l3EFeSCjvf/W6db9HcuwXtU
         vZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694628; x=1730299428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5rYTkHY31+cXuKv/fhTi/vwecjYJXbckDY0ZiVGZng=;
        b=waBd+arb0fBUKy99Et6HNfhL6sW806Aij2jIJCkJ1+6W753trkx955ScuY4WL7iXn0
         tsp3IsZFguM4FZjZoltJnOJFxGokiBPeOG0NOpO+QA/zt0IZVvzf2oSMd4Yku5U655Iz
         svzLP3yLuSxPefM6HNVj5xWfSEly0sgnJbyqbYbEsbStOWT8cLXAjEPABSnez/I9TKs3
         XFzUbd974pYviRtJ5OH2W6oqkS89f6ED59ZhiPL9sOblWF16jn2mK3s6hYfVs5xqv3kT
         LDrFH91eBEzN5eJuxB3N8mOl/j873MsFCi09LsWB0mFWJmLkpts12onDpJY3SxxWzm4e
         rhSA==
X-Forwarded-Encrypted: i=1; AJvYcCUI1bCoiCkL9rsvAcq5gSjKTO4BCO2wHzxDZ/WIJWKb0qB4PM79dZ1ZAdi7Q4bxkyeEvYDZXGBGHE9I@vger.kernel.org, AJvYcCVVxtBcjtLhQaoHnv5yL5PEKwyW6LUdFvUVsa1/JUZiuk1OyCJ8/LS9WMvkkteLd2ZP6ZL+bFM8yH1VIVq2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WwMjUbw4dodSJvFwBDPw0EksrRgNZVbuRoKXJdiSDFr3f5/T
	vLLrz7GSBLpVIUDVL5YymSivhtQ8IziAO0HgsxK78TR0bVXs9Bw7
X-Google-Smtp-Source: AGHT+IHDJbvo8KOhjbBnEUwYt4z0DNUgMPzm4YxcQUEljWBb7Z20ciaU2eAHyabV6G4Hjpki7LKWTA==
X-Received: by 2002:a05:6402:2106:b0:5ca:d9f:9146 with SMTP id 4fb4d7f45d1cf-5cb8acfa78amr2972462a12.17.1729694625893;
        Wed, 23 Oct 2024 07:43:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b68fsm4503334a12.1.2024.10.23.07.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:43:45 -0700 (PDT)
Message-ID: <1e117d65-b454-4d5c-b03a-c3ab3b078093@gmail.com>
Date: Wed, 23 Oct 2024 15:43:44 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/10/2024 14:40, Rob Herring wrote:
> On Mon, Oct 7, 2024 at 10:30 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 07/10/2024 15:39, Rob Herring wrote:
>>> On Mon, Oct 7, 2024 at 9:06 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 04/10/2024 01:03, Rob Herring wrote:
>>>>> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>>>>>>  __pa() is only intended to be used for linear map addresses and using
>>>>>> it for initial_boot_params which is in fixmap for arm64 will give an
>>>>>> incorrect value. Hence stash the physical address when it is known at
>>>>>> boot time and use it at kexec time instead of converting the virtual
>>>>>> address using __pa().
>>>>>>
>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>>>>>> ---
>>>>>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>>>>>  drivers/of/fdt.c          | 6 ++++++
>>>>>>  drivers/of/kexec.c        | 8 ++++++--
>>>>>>  include/linux/of_fdt.h    | 2 ++
>>>>>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>>>> index b22d28ec8028..a4d96f5e2e05 100644
>>>>>> --- a/arch/arm64/kernel/setup.c
>>>>>> +++ b/arch/arm64/kernel/setup.c
>>>>>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>>>>>      /* Early fixups are done, map the FDT as read-only now */
>>>>>>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>>>>>
>>>>>> +    /*
>>>>>> +     * Save dt_phys address so that it can be used later for kexec. This
>>>>>> +     * is done as __pa() is only intended to be used for linear map addresses
>>>>>> +     * and using it for initial_boot_params which is in fixmap will give an
>>>>>> +     * incorrect value.
>>>>>> +     */
>>>>>> +    set_initial_boot_params_pa(dt_phys);
>>>>>
>>>>> No new arch->dt functions please. If we need to save off the PA, then do
>>>>> that when we set initial_boot_params.
>>>>>
>>>>> Rob
>>>>
>>>>
>>>> initial_boot_params is set in early_init_dt_verify, called by early_init_dt_scan.
>>>> This is done in setup_machine_fdt in arm64 where the PA is available,
>>>> but in other functions in other architectures, where the PA is not available.
>>>
>>> Doesn't __pa() work for all the other architectures? That's what your
>>> patch indicates.
>>>
>>
>> Yes, __pa() works for all other architectures.
>>
>> But we would need to add initial_boot_params_pa of type phys_addr_t
>> as an argument for early_init_dt_scan, which is called by all other archs,
>> and we technically cant use 0 as an invalid value.
>>
>> We could convert initial_boot_params_pa to void *, and pass NULL for all
>> other archs. But again, I don't really think we should be changing the
>> early_init_dt_scan(dt_virt) call in all other archs to
>> early_init_dt_scan(dt_virt, NULL) just to save initial_boot_params_pa
>> in arm64?
>>
>>>> So it makes it quite messy to set it in the same place as initial_boot_params.
>>>> Its only needed for arm64 and making a change in all archs probably isnt a good idea?
>>>>
>>>> Any reason to not add a new function to make arch -> of/fdt call?
>>>
>>> Yes. It is the opposite direction I have reworked the interfaces to.
>>> We don't want each arch calling various early DT functions at random
>>> times and order. That's fragile when the DT functions make assumptions
>>> about when they are called or what's been initialized already.
>>>
>>> Another option is to make arm64 copy the DT as some arches do.
>>>
>>> Rob
>>
>> Ah maybe I didn't understand this properly, but isnt early_init_dt_scan an
>> arch -> of/fdt interfaces. set_initial_boot_params_pa is a similar interface
>> to early_init_dt_scan?
> 
> Yes, and I don't want more APIs if they can be avoided. When is
> set_initial_boot_params_pa() supposed to be called? Is it before or
> after early_init_dt_scan()? 

Its only needed in arm64, and can be either before or after, as long as its
somewhere in setup_machine_fdt, where dt_phys is available.

> Can subsequent OF functions assume the PA
> is valid?

After set_initial_boot_params_pa has been called, yes.

> If an arch doesn't call set_initial_boot_params_pa() is
> __pa() valid or did they just forget to call it? 

Only arm64 seems to do the fixmap as discussed in
https://lore.kernel.org/all/1ea5538f-7e96-4034-9af9-e2d5fd72e069@gmail.com/,
so __pa should work in others.

Requiring the PA to
> be set at the same time as initial_boot_params avoids all those issues
> with any period of time having the PA incorrect.
> 

Are you recommending I send a patch which changes all archs to call
early_init_dt_scan(dt_virt, NULL)?
or maybe early_init_dt_scan(dt_virt, __pa(dt_virt))?
and arm to call early_init_dt_scan(dt_virt, dt_phys).

Happy to do send a v2 with that if its the way forward, although I feel
set_initial_boot_params_pa() in just one arch might be better than
changing this for all archs.

Thanks
Usama

> Rob


