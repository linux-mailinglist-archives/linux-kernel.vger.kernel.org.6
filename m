Return-Path: <linux-kernel+bounces-329065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81224978CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051F91F26339
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B3134B2;
	Sat, 14 Sep 2024 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="O7/l4jf6"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8211078F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282333; cv=none; b=X6itvYxAfYvvRw9RM6QT4XSqzc4PqfOzCf45dYz4UbOD5zOP82B6Y6QTPzxf4GpSQPSQ53YpzQHukLcqVKWzNwO4KfRusDk5hXai5arFijy69lpjDeMcTB9LWIn/I6Botbh6KWBwEMlY8PIq8tmHrBSHLqYVUXcmWfYiLXx9Tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282333; c=relaxed/simple;
	bh=1Gr5pJH9pMrNB4Z2ewdxf3KB031tjCazkwMcq3AHEks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRkzwidtA+Hv4sVgqKkq9ZgCISVM4hC7qMFBe+/KwMKQaH22gJbpLf1IJ1H2zi5mJPu0JXOhvMQNYWEg4MqIzJPagm7P+2nrkkj1wTvtepKDg870mOifv1suU0EvkrejsMvczW7H4mLuBsbKxXybuoJWZS8/o0HCR1dbV9P7/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=O7/l4jf6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a046d4c465so9595985ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1726282330; x=1726887130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcgocvC07KwdgYkvDV/qMfScM5+LqmPejCCEAA1uMJI=;
        b=O7/l4jf6WeHi3/qunfph2cyQj94ZPUkAtgNgcMFvigFIzUCCXx9Q8kuFw1Tz52eyiu
         a04cS3mJ/OeBbfxXrrPIUX7kyjTrTFROQOjL9Llx9Wta/I3kBvM0W4pksc/l+4T4N7nt
         3yGauRwmLcCCWBNBkyJH0tWFKKylkcrNMFOVeJKzC2KY6xiSsMXMNLZ5SkKGHMDqkFT6
         /wVMqYk09lis4/r83VD3lDgyWWnNUimTOGCHGnefVRETqy1K2lUDtZzOEzc5nBBZRDy2
         jzVbx480MMm8rlllzyUMm9bcQvnCJlEhjwZ5AV9SzG2FbQCdxcdRIjcP5SyaypbVHhq/
         VevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726282330; x=1726887130;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcgocvC07KwdgYkvDV/qMfScM5+LqmPejCCEAA1uMJI=;
        b=GWPlHyONMKh1bfa9CtE107OvKpbHMRftyGZw8ysGx7dTIL6DgYDKf7DS93zOz2G3OK
         2ciOmVP1UGEtZkiJwY7tkzuvtkwm1f3WKu7NCU+x4L6mm5LEc/Uk0BIZKv1LpdPznA3E
         PGS8q3QEyWwGsAX/QCUxebCxb5XcB8+deKFoh5SxYMZ8IVNnEtnUIM0R12gZRwUxTV4v
         U0rT6pWH8SA5gIF8tsFCkCyHWmUun3c6639RbB4Wkz+3O74qO595YsQnALzAFNSoK7Q3
         luOV8G5o/JhEqN/2M2ZlyuWGCHoZTTPn8J3xCkL8LNvi6neLLdyU1yDl9qHkGEk9S9Y1
         1KDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxIGHJDICQIV5kA2Yb/E+tdA73nzT7oM4KXthOpSW9AA0bFg0EUKzBbKQ1A9ApUxMnA70yZOX7ra2u2Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/dDunWLXKJQ3+ohgxLUTAgj9JQDrzDzylNcbqoxd2XkbcFWh
	EMme1/YflCOo0L6PgrR54C7z4mkD5rYG7soMTLhDkzKO8HIWBXIiCGT6LTEA1Cw=
X-Google-Smtp-Source: AGHT+IEaD4v+a/RKnKmId+r+Iz4R86fNRYyVeVXynZnVMTjpM3fXydjExpGYdtf8Iye3kIi/wgX9bQ==
X-Received: by 2002:a05:6e02:5ad:b0:3a0:8dae:8b06 with SMTP id e9e14a558f8ab-3a08dae8c99mr24837465ab.9.1726282330175;
        Fri, 13 Sep 2024 19:52:10 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092dfe1d8sm1609685ab.13.2024.09.13.19.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 19:52:09 -0700 (PDT)
Message-ID: <8e474b14-e963-4d3e-8240-37f662e7bd8a@sifive.com>
Date: Fri, 13 Sep 2024 21:52:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions
 for guests
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
 kasan-dev@googlegroups.com, Atish Patra <atishp@atishpatra.org>,
 Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 kvm-riscv@lists.infradead.org
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-10-samuel.holland@sifive.com>
 <CAK9=C2WjraWjuQCeU2Y4Jhr-gKkOcP42Sza7wVp0FgeGaD923g@mail.gmail.com>
 <b6de8769-7e4e-4a19-b239-a39fd424e0c8@sifive.com>
 <CAAhSdy08SoDoZCii9R--BK7_NKLnRciW7V3mo2aQRKW1dbOgNg@mail.gmail.com>
 <20ab0fa2-d5dd-446d-9fff-a3ef82e8db35@sifive.com>
 <CAAhSdy1pZcEfajg3OZUCaFf9JMYcMzpRVogCT5VL2FHx__vDdA@mail.gmail.com>
 <4c010cb1-b57c-427e-a241-1dd3ab15f2ce@sifive.com>
 <CAAhSdy0kYUdgX8NUKuOdQa-69ET=cscduJvyz3z31kVeB-JaNw@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAAhSdy0kYUdgX8NUKuOdQa-69ET=cscduJvyz3z31kVeB-JaNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anup,

On 2024-09-05 12:18 AM, Anup Patel wrote:
> On Wed, Sep 4, 2024 at 9:25 PM Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> On 2024-09-04 10:20 AM, Anup Patel wrote:
>>> On Wed, Sep 4, 2024 at 8:27 PM Samuel Holland <samuel.holland@sifive.com> wrote:
>>>>
>>>> Hi Anup,
>>>>
>>>> On 2024-09-04 9:45 AM, Anup Patel wrote:
>>>>> On Wed, Sep 4, 2024 at 8:01 PM Samuel Holland <samuel.holland@sifive.com> wrote:
>>>>>> On 2024-09-04 7:17 AM, Anup Patel wrote:
>>>>>>> On Thu, Aug 29, 2024 at 6:32 AM Samuel Holland
>>>>>>> <samuel.holland@sifive.com> wrote:
>>>>>>>>
>>>>>>>> The interface for controlling pointer masking in VS-mode is henvcfg.PMM,
>>>>>>>> which is part of the Ssnpm extension, even though pointer masking in
>>>>>>>> HS-mode is provided by the Smnpm extension. As a result, emulating Smnpm
>>>>>>>> in the guest requires (only) Ssnpm on the host.
>>>>>>>>
>>>>>>>> Since the guest configures Smnpm through the SBI Firmware Features
>>>>>>>> interface, the extension can be disabled by failing the SBI call. Ssnpm
>>>>>>>> cannot be disabled without intercepting writes to the senvcfg CSR.
>>>>>>>>
>>>>>>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> (no changes since v2)
>>>>>>>>
>>>>>>>> Changes in v2:
>>>>>>>>  - New patch for v2
>>>>>>>>
>>>>>>>>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>>>>>>>>  arch/riscv/kvm/vcpu_onereg.c      | 3 +++
>>>>>>>>  2 files changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
>>>>>>>> index e97db3296456..4f24201376b1 100644
>>>>>>>> --- a/arch/riscv/include/uapi/asm/kvm.h
>>>>>>>> +++ b/arch/riscv/include/uapi/asm/kvm.h
>>>>>>>> @@ -175,6 +175,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>>>>>>>>         KVM_RISCV_ISA_EXT_ZCF,
>>>>>>>>         KVM_RISCV_ISA_EXT_ZCMOP,
>>>>>>>>         KVM_RISCV_ISA_EXT_ZAWRS,
>>>>>>>> +       KVM_RISCV_ISA_EXT_SMNPM,
>>>>>>>> +       KVM_RISCV_ISA_EXT_SSNPM,
>>>>>>>>         KVM_RISCV_ISA_EXT_MAX,
>>>>>>>>  };
>>>>>>>>
>>>>>>>> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
>>>>>>>> index b319c4c13c54..6f833ec2344a 100644
>>>>>>>> --- a/arch/riscv/kvm/vcpu_onereg.c
>>>>>>>> +++ b/arch/riscv/kvm/vcpu_onereg.c
>>>>>>>> @@ -34,9 +34,11 @@ static const unsigned long kvm_isa_ext_arr[] = {
>>>>>>>>         [KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
>>>>>>>>         [KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
>>>>>>>>         /* Multi letter extensions (alphabetically sorted) */
>>>>>>>> +       [KVM_RISCV_ISA_EXT_SMNPM] = RISCV_ISA_EXT_SSNPM,
>>>>>>>
>>>>>>> Why not use KVM_ISA_EXT_ARR() macro here ?
>>>>>>
>>>>>> Because the extension name in the host does not match the extension name in the
>>>>>> guest. Pointer masking for HS mode is provided by Smnpm. Pointer masking for VS
>>>>>> mode is provided by Ssnpm at the hardware level, but this needs to appear to the
>>>>>> guest as if Smnpm was implemented, since the guest thinks it is running on bare
>>>>>> metal.
>>>>>
>>>>> Okay, makes sense.
>>>>>
>>>>>>
>>>>>>>>         KVM_ISA_EXT_ARR(SMSTATEEN),
>>>>>>>>         KVM_ISA_EXT_ARR(SSAIA),
>>>>>>>>         KVM_ISA_EXT_ARR(SSCOFPMF),
>>>>>>>> +       KVM_ISA_EXT_ARR(SSNPM),
>>>>>>>>         KVM_ISA_EXT_ARR(SSTC),
>>>>>>>>         KVM_ISA_EXT_ARR(SVINVAL),
>>>>>>>>         KVM_ISA_EXT_ARR(SVNAPOT),
>>>>>>>> @@ -129,6 +131,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>>>>>>>>         case KVM_RISCV_ISA_EXT_M:
>>>>>>>>         /* There is not architectural config bit to disable sscofpmf completely */
>>>>>>>>         case KVM_RISCV_ISA_EXT_SSCOFPMF:
>>>>>>>> +       case KVM_RISCV_ISA_EXT_SSNPM:
>>>>>>>
>>>>>>> Why not add KVM_RISCV_ISA_EXT_SMNPM here ?
>>>>>>>
>>>>>>> Disabling Smnpm from KVM user space is very different from
>>>>>>> disabling Smnpm from Guest using SBI FWFT extension.
>>>>>>
>>>>>> Until a successful SBI FWFT call to KVM to enable pointer masking for VS mode,
>>>>>> the existence of Smnpm has no visible effect on the guest. So failing the SBI
>>>>>> call is sufficient to pretend that the hardware does not support Smnpm.
>>>>>>
>>>>>>> The KVM user space should always add Smnpm in the
>>>>>>> Guest ISA string whenever the Host ISA string has it.
>>>>>>
>>>>>> I disagree. Allowing userspace to disable extensions is useful for testing and
>>>>>> to support migration to hosts which do not support those extensions. So I would
>>>>>> only add extensions to this list if there is no possible way to disable them.
>>>>>
>>>>> I am not saying to disallow KVM user space disabling Smnpm.
>>>>
>>>> Then I'm confused. This is the "return false;" switch case inside
>>>> kvm_riscv_vcpu_isa_disable_allowed(). If I add KVM_RISCV_ISA_EXT_SMNPM here,
>>>> then (unless I am misreading the code) I am disallowing KVM userspace from
>>>> disabling Smnpm in the guest (i.e. preventing KVM userspace from removing Smnpm
>>>> from the guest ISA string). If that is not desired, then why do you suggest I
>>>> add KVM_RISCV_ISA_EXT_SMNPM here?
>>>
>>> Yes, adding KVM_RISCV_ISA_EXT_SMNPM here means KVM
>>> user space can't disable it using ONE_REG interface but KVM user
>>> space can certainly not add it in the Guest ISA string.
>>
>> Is there a problem with allowing KVM userspace to disable the ISA extension with
>> the ONE_REG interface?
>>
>> If KVM userspace removes Smnpm from the ISA string without the host kernel's
>> knowledge, that doesn't actually prevent the guest from successfully calling
>> sbi_fwft_set(POINTER_MASKING_PMLEN, ...), so it doesn't guarantee that the VM
>> can be migrated to a host without pointer masking support. So the ONE_REG
>> interface still has value. (And that's my answer to your original question "Why
>> not add KVM_RISCV_ISA_EXT_SMNPM here ?")
> 
> Currently, disabling KVM_RISCV_ISA_EXT_SMNPM via ONE_REG
> will only clear the corresponding bit in VCPU isa bitmap. Basically, the
> KVM user space disabling KVM_RISCV_ISA_EXT_SMNPM for Guest
> changes nothing for the Guest/VM.
> 
> On other hand, disabling KVM_RISCV_ISA_EXT_SVPBMT via
> ONE_REG will not only clear it from VCPU isa bitmap but also
> disable Svpmbt from henvcfg CSR for the Guest/VM.
> 
> In other words, if disabling an ISA extension is allowed by the
> kvm_riscv_vcpu_isa_disable_allowed() then the Guest/VM must
> see a different behaviour when the ISA extension is disabled by
> KVM user space.
> 
>>
>>>>> The presence of Smnpm in ISA only means that it is present in HW
>>>>> but it needs to be explicitly configured/enabled using SBI FWFT.
>>>>>
>>>>> KVM user space can certainly disable extensions by not adding it to
>>>>> ISA string based on the KVMTOOL/QEMU-KVM command line option.
>>>>> Additionally, when SBI FWFT is added to KVM RISC-V. It will have its
>>>>> own way to explicitly disable firmware features from KVM user space.
>>>>
>>>> I think we agree on this, but your explanation here appears to conflict with
>>>> your suggested code change. Apologies if I'm missing something.
>>>
>>> I think the confusion is about what does it mean when Smnpm is present
>>> in the ISA string. We have two approaches:
>>>
>>> 1) Presence of Smnpm in ISA string only means it is present in HW but
>>>     says nothing about its enable/disable state. To configure/enable
>>>     Smnpm, the supervisor must use SBI FWFT.
>>>
>>> 2) Presence of Smnpm in ISA string means it is present in HW and
>>>     enabled at boot-time. To re-configure/disable Smnpm, the supervisor
>>>     must use SBI FWFT.
>>>
>>> I am suggesting approach #1 but I am guessing you are leaning towards
>>> approach #2 ?
>>>
>>> For approach #2, additional hencfg.PMM configuration is required in
>>> this patch based on the state of KVM_RISCV_ISA_EXT_SMNPM.
>>
>> No, I am definitely suggesting only approach #1. My proposal for adding pointer
>> masking to the SBI FWFT extension[1] specifies the feature as disabled by
>> default, and this would apply both inside and ouside a VM.
>>
>> But I am also suggesting that the ONE_REG interface is a useful way to
>> completely hide the extension from the guest, like we do for other extensions
>> such as Svpbmt. The only difference between something like Svpbmt and Smnpm is
>> that instead of clearing a bit in henvcfg to hide the extension from the guest,
>> we reject calls to sbi_fwft_set(POINTER_MASKING_PMLEN, ...) when the ISA
>> extension is hidden from the guest.
> 
> I think we are converging towards the same thing.
> 
> How about this ?
> 
> For this series, lets add KVM_RISCV_ISA_EXT_SMNPM to
> kvm_riscv_vcpu_isa_disable_allowed() so that for the time
> being KVM user space can't disable Smnpm.
> 
> In the future, a separate series which adds SBI FWFT to
> KVM RISC-V will remove KVM_RISCV_ISA_EXT_SMNPM
> from the kvm_riscv_vcpu_isa_disable_allowed() because
> disabling Smnpm from KVM user space would mean that
> the POINTER_MASKING_PMLEN firmware feature is
> not available to the Guest/VM.
> 
> This means in the future (after SBI FWFT is implemented in
> KVM RISC-V), Guest with Smnpm disabled can be migrated
> to a host without pointer masking.

OK, that is a reasonable compromise. I'll do that for v5.

Regards,
Samuel


