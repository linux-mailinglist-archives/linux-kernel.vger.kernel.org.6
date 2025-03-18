Return-Path: <linux-kernel+bounces-566320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A361A67656
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3183E189AA60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35F20E003;
	Tue, 18 Mar 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CRyaMmwc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5C20D4FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307747; cv=none; b=AqlFaeHpnL+hyvbvXS95YChKPLCXtgwFILRO1Lr2A/cQA7p1tVCY1OYsufYQThGW6zxwjHphr14wo8ciySJ55Z8NSd02Mu5wkiOwad93QUfvnfaqbOn0mMdwPIjrKwA6EyMM/6cH9D/85RtHnf83jOkIfmCQxDt1c9bPRQ9rPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307747; c=relaxed/simple;
	bh=73nN0j197f6pTnfXPfLn0FzhOjp+DBuhsH+ogA2bt1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbRqZdB9RzJcIVbFiw0LEKelcEItSmkn+cFOWxfe0nccOy9/RjooPx682ajIjxvjZJWLfHO1ZVe7MtPWir1Xq2ah5kXf+mDVOnmOmc06QU8AB8niDX2vcxGsdjAoj2LuUqz79Bi6mfYNw9yPGd/pbyRw+UG7V7qxQVAmdLEJlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CRyaMmwc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso109232335ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742307744; x=1742912544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGpINx731Tmb96Qe0VWFaWPTECmsS+PdS8emXnbhmLs=;
        b=CRyaMmwcbwH0vGnpmrFGljMiXwP7fBwH6GUEwlGbXlXWHIez0/3R9pcvQlHhzWQDsV
         n8PGdhj97wfkeUoMQVLNweZcVmaJY0HIQ9hE0mdzodrP3x9FlHFZ2GeF5md53mHXMhWB
         OL7MRMZIN/hypWAAD8rTg8mZJMS7VuWxjjB9uzcS23x1vwZmUJp2f3zSCIs7gGa/o3W1
         mXreAQEHU8NVAfTUcxDh1YGo7w2G7nv0OUB2++oCqsYHGaG+1NcciwF4Z+PfQ27HEqtE
         m9C6AXuwN45tySbO+7pOs/J01MFVcXkJTmV/5x4vEsvNIbQYO8nDVr6RXFtPzIW31NMK
         9gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307744; x=1742912544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGpINx731Tmb96Qe0VWFaWPTECmsS+PdS8emXnbhmLs=;
        b=wpjOaipRczqUmxpS7N5+XwZJq/OBSsHKLgBOexlQuhUoeqWBp4mxT2FpcRn6UTBR70
         ABdQv79UFyMe4JweHbXYf/tz1UGtQtzD1Zzvj2/4DJaZZ3KOH/PcaHfg9WTATU6s97w8
         a022MERV9+6KMsfIXpZQ8Um+Ze271+/lPKes13lNv6dpJMXzkaNH1N15sih/ht6MaYVX
         CmRGVvOSa72AoYX+F4/l5DNFcknJkCjunGqwTKgP/Hwrb3cO6Z3BfY/dHueHdoX9rziQ
         LCHs6BzMejFy2P3N3fKwEZgYxC/rMhM6yXwXyis3aQyP602nyQmW5cxzI6vGhiKYC7Pu
         gGEw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Tpjw5c4/0XWlhOTLc2pZZ4RiaosEib6cuHf1JkG52ir96daBgGcesE5SVpGA03/qkCrXAMlkBbswLYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0S2M8XhyvXc+yW/J6W13E2ZEcfA1rCvTS7kwXqyPguUR/pvr
	kSpm+jB7Hjuz7wRnVPJBIzbL7ltR/0+ER3hxyFwUzkJymWuaOq7j85zQWI78vEM=
X-Gm-Gg: ASbGncvo8JMMZixHdYfiSohVJJD3SJJ8LT+PrA6ubgNdHgSOk9XPMGQPEhc9X2Iw186
	hUhC8ZsLm3TCmWm5OzNXUQUFDEuPkDUn6M/zbDuOEHnfp0aomp38XEwvkNW982Ey0wzyDMKrwFP
	I2cV7sUDJw38a0nc1nWMk1trrVKrhDRf0CRf+eRCYwqyspTJNQQ1QF6O8+d3Qm3WxhITQUNvXVc
	EfC1iCdwW1zO9PJ8GOc4Yz6eIV47ND9VBy+18LraoRNT711z9wQGz9V50SZ8NGq4rYtuPG+i+7y
	zGb1+HlcH2BTK1gNXSYVAgM5iZdAB78kjN4drUGPXGWrGv/GOggBXpw2sJV0vMFITHCBgyh+TTw
	NFl8kJrHCvPz/lA==
X-Google-Smtp-Source: AGHT+IFEi0TRz0hE3pZlW2uv3/pl5phfAMhd9vaZ7+UlbHxqBQC4Z8iGvu+5+IushiykE4M6pVxcYQ==
X-Received: by 2002:a17:903:40c7:b0:224:191d:8a87 with SMTP id d9443c01a7336-225e0a82f1cmr208441955ad.26.1742307744477;
        Tue, 18 Mar 2025 07:22:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a7f5fsm94698925ad.80.2025.03.18.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:22:23 -0700 (PDT)
Message-ID: <05bdf6c3-9d60-4b1c-add3-79b4f7d25189@rivosinc.com>
Date: Tue, 18 Mar 2025 15:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
To: Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 charlie@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, corbet@lwn.net
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
 <20250318-1b03e58fe508b077e5d38233@orel>
 <c5e174e4-4fce-4c7f-821a-cf3781becab4@ghiti.fr>
 <20250318-18b96818299ef211ef8ca620@orel>
 <d7a04d06-766b-4b43-8c42-2b681629c35d@ghiti.fr>
 <20250318-ec2a990d55378039a863b94b@orel>
 <44304bca-b30a-4c0b-b242-3a54ac021e40@ghiti.fr>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <44304bca-b30a-4c0b-b242-3a54ac021e40@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/03/2025 15:09, Alexandre Ghiti wrote:
> On 18/03/2025 14:04, Andrew Jones wrote:
>> On Tue, Mar 18, 2025 at 01:58:10PM +0100, Alexandre Ghiti wrote:
>>> On 18/03/2025 13:45, Andrew Jones wrote:
>>>> On Tue, Mar 18, 2025 at 01:13:18PM +0100, Alexandre Ghiti wrote:
>>>>> On 18/03/2025 09:48, Andrew Jones wrote:
>>>>>> On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
>>>>>>> Hi Drew,
>>>>>>>
>>>>>>> On 04/03/2025 13:00, Andrew Jones wrote:
>>>>>>>> Allow skipping scalar and vector unaligned access speed tests. This
>>>>>>>> is useful for testing alternative code paths and to skip the
>>>>>>>> tests in
>>>>>>>> environments where they run too slowly. All CPUs must have the same
>>>>>>>> unaligned access speed.
>>>>>>> I'm not a big fan of the command line parameter, this is not
>>>>>>> where we should
>>>>>>> push uarch decisions because there could be many other in the
>>>>>>> future, the
>>>>>>> best solution to me should be in DT/ACPI and since the DT folks,
>>>>>>> according
>>>>>>> to Palmer, shut down this solution, it remains using an extension.
>>>>>>>
>>>>>>> I have been reading a bit about unaligned accesses. Zicclsm was
>>>>>>> described as
>>>>>>> "Even though mandated, misaligned loads and stores might execute
>>>>>>> extremely
>>>>>>> slowly. Standard software distributions should assume their
>>>>>>> existence only
>>>>>>> for correctness, not for performance." in rva20/22 but *not* in
>>>>>>> rva23. So
>>>>>>> what about using this "hole" and consider that a platform that
>>>>>>> *advertises*
>>>>>>> Zicclsm means its unaligned accesses are fast? After internal
>>>>>>> discussion, It
>>>>>>> actually does not make sense to advertise Zicclsm if the platform
>>>>>>> accesses
>>>>>>> are slow right?
>>>>>> This topic pops up every so often, including in yesterday's server
>>>>>> platform TG call. In that call, and, afaict, every other time it has
>>>>>> popped up, the result is to reiterate that ISA extensions never say
>>>>>> anything about performance. So, Zicclsm will never mean fast and we
>>>>>> won't likely be able to add any extension that does.
>>>>> Ok, I should not say "fast". Usually, when an extension is
>>>>> advertised by a
>>>>> platform, we don't question its speed (zicboz, zicbom...etc), we
>>>>> simply use
>>>>> it and it's up to the vendor to benchmark its implementation and act
>>>>> accordingly (i.e. do not set it in the isa string).
>>>>>
>>>>>
>>>>>>> arm64 for example considers that armv8 has fast unaligned
>>>>>>> accesses and can
>>>>>>> then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even
>>>>>>> though some
>>>>>>> uarchs are slow. Distros will very likely use rva23 as baseline
>>>>>>> so they will
>>>>>>> enable Zicclsm which would allow us to take advantage of this
>>>>>>> too, without
>>>>>>> this, we lose a lot of perf improvement in the kernel, see
>>>>>>> https://lore.kernel.org/lkml/20231225044207.3821-1-
>>>>>>> jszhang@kernel.org/.
>>>>>>>
>>>>>>> Or we could have a new named feature for this, even though it's
>>>>>>> weird to
>>>>>>> have a named feature which would basically  mean "Zicclsm is
>>>>>>> fast". We don't
>>>>>>> have, for example, a named feature to say "Zicboz is fast" but
>>>>>>> given the
>>>>>>> vague wording in the profile spec, maybe we can ask for one in
>>>>>>> that case?
>>>>>>>
>>>>>>> Sorry for the late review and for triggering this debate...
>>>>>> No problem, let's try to pick the best option. I'll try listing
>>>>>> all the
>>>>>> options and there pros/cons.
>>>>>>
>>>>>> 1. Leave as is, which is to always probe
>>>>>>       pro: Nothing to do
>>>>>>       con: Not ideal in all environments
>>>>>>
>>>>>> 2. New DT/ACPI description
>>>>>>       pro: Describing whether or not misaligned accesses are
>>>>>> implemented in
>>>>>>            HW (which presumably means fast) is something that
>>>>>> should be done
>>>>>>     in HW descriptions
>>>>>>       con: We'll need to live with probing until we can get the
>>>>>> descriptions
>>>>>>            defined, which may be never if there's too much opposition
>>>>>>
>>>>>> 3. Command line
>>>>>>       pro: Easy and serves its purpose, which is to skip probing
>>>>>> in the
>>>>>>            environments where probing is not desired
>>>>>>       con: Yet another command line option (which we may want to
>>>>>> deprecate
>>>>>>            someday)
>>>>>>
>>>>>> 4. New ISA extension
>>>>>>       pro: Easy to add to HW descriptions
>>>>>>       con: Not likely to get it through ratification
>>>>>>
>>>>>> 5. New SBI FWFT feature
>>>>>>       pro: Probably easier to get through ratification than an ISA
>>>>>> extension
>>>>>>       con: Instead of probing, kernel would have to ask SBI --
>>>>>> would that
>>>>>>            even be faster? Will all the environments that want to
>>>>>> skip
>>>>>>     probing even have a complete SBI?
>>>>>>
>>>>>> 6. ??
>>>>> So what about:
>>>>>
>>>>> 7. New enum value describing the performance as "FORCED" or "HW" (or
>>>>> anything better)
>>>>>       pro: We only use the existing Zicclsm
>>>>>       con: It's not clear that the accesses are fast but it
>>>>> basically says to
>>>>> SW "don't think too much, I'm telling you that you can use it", up
>>>>> to us to
>>>>> describe this correctly for users to understand.
>>>> But Zicclsm doesn't mean misaligned accesses are in HW, it just means
>>>> they're not going to explode.
>>>
>>> They never explode since if they are not supported by the HW, we rely on
>>> S-mode emulation already.
>> Exactly. Zicclsm is just a new name for that behavior. Profiles try to
>> name every behavior, even the ones we take for granted. Unfortunately,
>> like in the case of Zicclsm, we don't necessarily gain anything from
>> the new name. In this case, we don't gain a way to avoid probing.
> 
> 
> I understand your point but given the misaligned traps exist, I can't
> find another meaning to Zicclsm than "I'm telling you to use it".
> Zicclsm can't be used to describe an OS behaviour (ie the emulation of
> misaligned accesses).

Hi Alex,

Some SBI implementation might decide not to delegate the misaligned trap
and not emulate it or partially emulate it. IMHO, Zicclsm should
actually be advertised by SBI to actually tell the OS that misaligned
accesses are supported (even though they are slow) since Zicclsm is a
profile extension (at least in its first definition). I think we can not
rely on Zicclsm to determine that accesses are fast. Moreover, it seems
like its definition evolved over time and lacks clarity to be reliable.

> 
> I'm also insisting because we need a compile-time hint which allows us
> to enable HAVE_EFFICIENT_UNALIGNED_ACCESS in the kernel and Zicclsm is
> great since it is required in RVA23. if that's not Zicclsm, that must be
> another named feature/extension.

As said in the other thread, I think we might have to enable
HAVE_EFFICIENT_UNALIGNED_ACCESS as a default (or whatever option selects
that CONFIG). HW without misaligned access support implementation would
suffer from that choice but would still work (although poorly) thanks to
S-mode emulation. If one wants to run the kernel more efficiently on
some smaller chip without any hardware support for it, then it should
disable that config. I think that we can not accommodate both world
without hurting one side or the other, a choice needs to be made.

Thanks,

Clément

> 
> What do you suggest to make progress here?
> 
> Thanks,
> 
> Alex
> 
> 
>>
>> Thanks,
>> drew
>>
>>>
>>>> We'd still need the probing to find out
>>>> if the accesses are emulated (slow) or hw (fast). We at least want to
>>>> know the answer to that question because we advertise it to userspace
>>>> through hwprobe.
>>>>
>>>> (BTW, another pro of the command line is that it can be used to test
>>>> both slow and fast paths without recompiling.)
>>>>
>>>> Thanks,
>>>> drew
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


