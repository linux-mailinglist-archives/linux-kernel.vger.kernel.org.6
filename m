Return-Path: <linux-kernel+bounces-225165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C0912D02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8817FB2851D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F28179206;
	Fri, 21 Jun 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ChL3Ml3U"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629F1662FE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993300; cv=none; b=PtWKoWiheZHH1KMwxlkDkfIARN5WRjCS52+uQcV3YLZIsQWikV6hBzTLLfdlFWwUbefW/Hz2W/pSojQsb4DSMldC7S1G25y62K2ZDs1D2/0zpUcnwgdkCda0C1G764LAh1D5K2zIQ0ZVCIIe07bl1qAy2cK4yZ7TzK0ANOVB2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993300; c=relaxed/simple;
	bh=z4A9knjStunODits2zDpLK5kq5FcerGywbWwLm10rAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9s0THDMMa6d40M+Oigp7mg2iMRrwxo5HFZAM/+fBYOMpn9sdHR2w9uSE29TC2dnzwCO/mVGkwiR5fxWi39ZdV59Orq41sgbOzb09ejR8st4eGDJGf3a+CDWGj5qEpr2vOq0AzkNEqvFRWN3SyLvYZWK9iijaHExmFIO22r0Avc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ChL3Ml3U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9b364faddso20371585ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718993296; x=1719598096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZxed23lWK3xyToPkvhbyN/DYUsl81Hk6n86URYaIK8=;
        b=ChL3Ml3U4RuYr7Q3NUYhZvFyO062Lg4KwouBVV9IQpjOcW9Dfy6CHWuE5PIsZ/H2Ia
         pgLGv7alnBsJcUB3qy8NDTgbRAOWvbJaZ4x04vlDzHFrV6U+/LUi1S4g1wMMrx/8HFLu
         ZoKzEEfr8qpp2Yk+z0NGUE3xWW+KgUn/Zyxkm0UzgPQrySoUnlMq9QPX+RfDbL0Kt6kT
         vcSvOd9QQZqATlTJBOk1Ta2KvV6xsUiYpdA/aEbwekb24g6YaIzV4HmP7hqhxUBVapZU
         kLydZ0REDBuD8YFWMZQ15QP9WbjwKmIHUI1QpvKKDVIqpv9j/b8zrlRmDVgms1Mw1RD4
         wwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993296; x=1719598096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZxed23lWK3xyToPkvhbyN/DYUsl81Hk6n86URYaIK8=;
        b=lzdbgizct53tcV8+iP6OBYqbfU2HgyLkAbtD1Z1ouEWHcyR8/pkuP0OeHGCRDfZCXD
         AGLWHROTpvqoUh3nQ+5q1bwSdUu8Ar3YzRKVWd213WOSDQjH3YibVX8P+wcgeuDCKHjQ
         TY4Usb+F4YA9JNyPY5O+h9nTHI8m9cCEBZn3/Xc9uUuIUzhWg/jC9m9xWO13Yp/KcGa7
         7bKsxxRkw1MNlmY+mIZkjen0H6NwGjExdbxAhxMuCsF6UsZI2cRSBqx7YpAqeeKrFXVh
         f2ovcaAXktm53bLqcuaMv+B86pOhwUI3Nh82f1pwNLbrO5DNcmJOYVd2d8wtFXO8OFA7
         8XkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjOTs1Jzg1+mllJuGoQFBP54peJzpoPu6oJtuyJOJd19YREC/YWv1SbPF/jZyVXK83OT8EUe5wnhrtzlv5B/2f7KwFJzDWasqX+dw4
X-Gm-Message-State: AOJu0Ywt8p608xwP5itYFptP9Eq2FGPVxqwi2aUTrCmTNIH1ToJhdoBb
	DbTHyc8FCkCEDDuC5FNg7GFgJNnLfeItZoKtOaq6acA5an/7PbtV1BGqjyZJhEU=
X-Google-Smtp-Source: AGHT+IHIPg92rOqSXjhse5eDTBW8G59SbiAeZwSOHAEyGQrxlr0R0G7NdOB6xGx014mSNb9HFErLyQ==
X-Received: by 2002:a17:902:dacb:b0:1fa:2d1:105c with SMTP id d9443c01a7336-1fa02d11251mr11269355ad.65.1718993296107;
        Fri, 21 Jun 2024 11:08:16 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5fa9sm16878825ad.206.2024.06.21.11.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 11:08:15 -0700 (PDT)
Message-ID: <8c1167fb-9580-45bd-a798-f7d32477f1bd@rivosinc.com>
Date: Fri, 21 Jun 2024 14:07:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
To: Charlie Jenkins <charlie@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>,
 Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com> <ZnDmRK0ZtKzmWN5S@ghost>
 <ZnDsdzv4o/Xz9kWm@ghost> <e6f7a061-50f0-4a6a-a09b-468502703c20@rivosinc.com>
 <ZnSptpobfqjik3RM@ghost> <20240621-reveler-underfed-37600a9f16d5@wendy>
 <ZnW130PqW56CnZT8@ghost>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <ZnW130PqW56CnZT8@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/21/24 13:18, Charlie Jenkins wrote:
> On Fri, Jun 21, 2024 at 11:06:31AM +0100, Conor Dooley wrote:
>> On Thu, Jun 20, 2024 at 03:14:14PM -0700, Charlie Jenkins wrote:
>>> On Thu, Jun 20, 2024 at 05:31:28PM -0400, Jesse Taube wrote:
>>>>
>>>>
>>>> On 6/17/24 22:09, Charlie Jenkins wrote:
>>>>> On Mon, Jun 17, 2024 at 06:43:32PM -0700, Charlie Jenkins wrote:
>>>>>> On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
>>>>>>> Run a unaligned vector access to test if the system supports
>>>>>>> vector unaligned access. Add the result to a new key in hwprobe.
>>>>>>> This is useful for usermode to know if vector misaligned accesses are
>>>>>>> supported and if they are faster or slower than equivalent byte accesses.
>>>>>>>
>>>>>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>>>>>> ---
>>>>>>> V1 -> V2:
>>>>>>>    - Add Kconfig options
>>>>>>>    - Add insn_is_vector
>>>>>>>    - Add handle_vector_misaligned_load
>>>>>>>    - Fix build
>>>>>>>    - Seperate vector from scalar misaligned access
>>>>>>>    - This patch was almost completely rewritten
>>>>>>> ---
>>>>>>>    arch/riscv/Kconfig                         |  41 +++++++
>>>>>>>    arch/riscv/include/asm/cpufeature.h        |   7 +-
>>>>>>>    arch/riscv/include/asm/entry-common.h      |  11 --
>>>>>>>    arch/riscv/include/asm/hwprobe.h           |   2 +-
>>>>>>>    arch/riscv/include/asm/vector.h            |   1 +
>>>>>>>    arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
>>>>>>>    arch/riscv/kernel/Makefile                 |   4 +-
>>>>>>>    arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
>>>>>>>    arch/riscv/kernel/traps_misaligned.c       | 119 ++++++++++++++++++++-
>>>>>>>    arch/riscv/kernel/unaligned_access_speed.c |   9 +-
>>>>>>>    arch/riscv/kernel/vector.c                 |   2 +-
>>>>>>>    11 files changed, 221 insertions(+), 21 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>>>> index b94176e25be1..f12df0ca6c18 100644
>>>>>>> --- a/arch/riscv/Kconfig
>>>>>>> +++ b/arch/riscv/Kconfig
>>>>>>> @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
>>>>>>>    	help
>>>>>>>    	  Embed support for emulating misaligned loads and stores.
>>>>>>> +config RISCV_VECTOR_MISALIGNED
>>>>>>> +	bool
>>>>>>> +	depends on RISCV_ISA_V
>>>>>>> +	help
>>>>>>> +	  Enable detecting support for vector misaligned loads and stores.
>>>>>>> +
>>>>>>>    choice
>>>>>>>    	prompt "Unaligned Accesses Support"
>>>>>>>    	default RISCV_PROBE_UNALIGNED_ACCESS
>>>>>>> @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
>>>>>>>    endchoice
>>>>>>> +choice
>>>>>>> +	prompt "Vector unaligned Accesses Support"
>>>>>>> +	depends on RISCV_ISA_V
>>>>>>> +	default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>>>>>>> +	help
>>>>>>> +	  This determines the level of support for vector unaligned accesses. This
>>>>>>> +	  information is used by the kernel to perform optimizations.
>>
>> I haven't actually checked the patchset, but is it actually used by the
>> kernel to perform optimisations?
> 
> No ;)
> 
> Right now this patch is just providing the information to userspace
> through hwprobe and doesn't optimize anything in the kernel.
> 
>>
>>>>>>> It is also
>>>>>>> +	  exposed to user space via the hwprobe syscall. The hardware will be
>>>>>>> +	  probed at boot by default.
>>>>>>> +
>>>>>>> +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
>>>>>>
>>>>>> This is not used anywhere, what is the reason for including it?
>>>>
>>>> This is so that we can check if they are supported or not, but not check the
>>>> speed of them. Similar to RISCV_EMULATED_UNALIGNED_ACCESS.
>>>
>>> What do you mean? It isn't used anywhere so this "check if they are
>>> supported or not" is not guarded by this config.
>>>
>>>>
>>>>>>
>>>>>>> +	bool "Detect support for vector unaligned accesses"
>>>>>>> +	select RISCV_VECTOR_MISALIGNED
>>>>>>> +	help
>>>>>>> +	  During boot, the kernel will detect if the system supports vector
>>>>>>> +	  unaligned accesses.
>>>>>>> +
>>>>>>> +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>>>>>>> +	bool "Probe speed of vector unaligned accesses"
>>>>>>> +	select RISCV_VECTOR_MISALIGNED
>>>>>>> +	help
>>>>>>> +	  During boot, the kernel will run a series of tests to determine the
>>>>>>> +	  speed of vector unaligned accesses if they are supported. This probing
>>>>>>> +	  will dynamically determine the speed of vector unaligned accesses on
>>>>>>> +	  the underlying system if they are supported.
>>>>>>> +
>>>>>>> +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
>>>>>>
>>>>>> This should not be prefixed with CONFIG and does not include VECTOR in
>>>>>> the name.
>>>>
>>>> Huh thought it would warn fixed though
>>>
>>> What do you mean by "warn fixed"?
>>>
>>>>
>>>>> I assume you meant to put
>>>>>> "RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED" here?
>>>>
>>>> This is to leave a faster path like SLOW or FAST to say that unaligned
>>>> access arent suported.
>>>
>>> I am not sure what you are responding to. This comment seems to be
>>> responding to my correction of
>>> CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED->RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
>>> so I don't see how that ties into SLOW/FAST.
>>>
>>>>
>>>>>>
>>>>>> This was also intentionally left out on the scalar side [1]. The
>>>>>> implication here is that having this config will cause people to compile
>>>>>> kernels without unaligned access support which really shouldn't be
>>>>>> something we are explicitly supporting.
>>>>>>
>>>>>> If somebody does want to support hardware that does not handle vector
>>>>>> unaligned accesses, the solution should be to add emulation support to
>>>>>> the kernel.
>>>>
>>>> Yes but we dont have emulation support yet so I do think its a good idea.
>>>
>>> I am hesitant because it is very likely that somebody will add support
>>> for unaligned vector emulation. When there is emulation support, this
>>> config option should not exist to be consistent with scalar. However if
>>> we add this option in now, we must expect a user to enable this config,
>>> and then
>>
>> I dunno, I think there could be value in having the option here. For
>> scalar, we couldn't have an option that would break the uABI, so the
>> unsupported option wasn't okay. That's not a constraint that we have for
>> vector.
>>
>> For vector, if you have a system that doesn't support misaligned access,
>> you probably don't want to emulate the accesses either, since that's
>> likely remove any performance gains you get from using vector in the
>> first place, so I can see benefit in the option.
> 
> We have the RISCV_MISALIGNED option that disables the scalar emulation,
> but doesn't break the UABI because it's not saying that misaligned
> scalar is not supported, but just that the kernel doesn't emulate.
> Having an UNSUPPORTED option explicitly breaks the UABI which doesn't
> seem like something that the kernel should support. If we are okay with
> having options that break the UABI then this is fine, but I was under
> the impression that we did our best to avoid that.
> 
> There definitely is value in having an option like this for hardware
> that never wants to run misaligned code, but since we decided with the
> scalar accesses that we should not break the UABI I think vector should
> do the same.

The rational for scalar accesses was slightly different as
The base ISA spec said/says: ". The base ISA supports misaligned 
accesses, but these might run extremely slowly depending on the 
implementation."

Section: 2.6 Load and Store Instructions. Available: 
https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf

> 
>> Enabling the probing is going to end up with same outcome for userspace
>> as having this option on such a system, so it comes down to whether you
>> want to allow people to skip the probing if they know their system has
>> this problem.
>>
>>> we will have to get rid of it later. Users are not always happy
>>> when config options are removed.
>>
>> I dunno, I don't think that adding emulation requires that we remove
>> this unsupported option.
> 
> I am probably being too paranoid about this but I am hesistant to cause
> vector and scalar misaligned access implemenations to diverge. It is
> inconsistent to allow an unsupported option for vector but not for
> scalar when both support emulation. The probing is very fast as it just
> checks if a misaligned access causes a trap and then sets the access
> speed to unsupported if it does trap.

Charlie is right about probing for support being fast. There is
RISCV_DETECT_VECTOR_UNALIGNED_ACCESS to only detect support not the 
speed. I thought it might be a good idea to add this config option, but
I'll just drop it to shorten this thread.

> 
>>
>> Additionally, what are we doing in the kernel if we detect that
>> misaligned stuff isn't supported? Are we going to mandate that kernel
>> code is aligned only

As of now yes.

>> disable in-kernel vector or some other mechanism
>> to make sure that things like crypto code don't have/introduce code
>> that'll not run on these systems?

I'm not too familiar with the uses of unaligned vector accesses, but if
it significantly improves performance then I think there should be a 
faster unaligned access pathway, and a aligned access pathway, so both 
are supported. This also ties into your first question.

Thanks,
Jesse Taube

> UNSUPPORTED will still be set by the quick probe so it would be possible
> for the kernel/userspace to avoid running misaligned vector when it's
> unsupported. Any kernel methods would probably want to always run
> aligned vector unless misaligned support was determined to be FAST
> anyway, I am doubtful that code will have different optimizations for
> FAST, SLOW, and UNSUPPORTED but it is possible.
> 
> I would prefer consistency between scalar and vector misaligned support,
> but this is not a deal breaker for this patch. I am not convinced it is
> the best choice, but I am okay with leaving this option in the kernel.
> 
> - Charlie
> 
>>
>> Cheers,
>> Conor.
> 
> 

