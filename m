Return-Path: <linux-kernel+bounces-329502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72197921C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903BD1F20627
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F201D017E;
	Sat, 14 Sep 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="irK6unxW"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42E1CA84
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726331990; cv=none; b=mS20+8azXbLFp1ayjyqEetwTZnTxUeHONieQDyT+FQUYms7eJldDRuhiMIlBI0VrbzJQF2+3n/DWGmzJrkqbP9JL77x+tfp1gWCN7qcll2MLP+uFrAGQoFmz+JHDxi34oJO8WTNKL9Gl9ihhXkoJ8PQZs9XsDbh1iHys9kg5gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726331990; c=relaxed/simple;
	bh=Dvxs9j9TLSUzp3z2Nu/7vUqe2yENvwIXyR/MAq3YdDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sG7sKsKqbJZad29bcO+1QCtbAks99NNRorZBc4P/6llkyX05bz7qg5Wz5/UvwTXBUOVpO3g6ecafZYolYYe+5xXepYAFzT1fIlo2eVaJaPfNqOla+fYepnXuhcZpBVVr40lnifMT0DIPtRCStOG7UzJCyVxtossX7XNL+VOW1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=irK6unxW; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso69891939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1726331987; x=1726936787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5jKDPdzf6bQMz9p0N2ObXfh/X3qnIwnwioASvA03Fk=;
        b=irK6unxWWDDZs+1p07uQ9CjvPWKohwM1fWEfZFwARz9eDKi3j+AMDoCImIWZWDEiAT
         gl8qlMObMYT49miO0Yfo9X/utlb9u8L7ORQLJ3EActgE5Ix60eCUEz162XtS+Z15jZJn
         AITvwib87TpGBAwzx6eIKs9P0xys+vZZXZeDACCldH8OzPFsH+tcMSjUgLAm43XbhOKu
         VmcTHII1WKXkkQgtSFEk1hEIEpLoFdoQNS6uZ64NN+E1Fdt/rxkSoSEYLw8FunSg+Rkq
         cYg8j045hCHMUKaW27D8GAx2AbdFEysZQO54lcMDxlCiSkOE57oGNv+00sNFN3kD5sK7
         IrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726331987; x=1726936787;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5jKDPdzf6bQMz9p0N2ObXfh/X3qnIwnwioASvA03Fk=;
        b=BvhcUEkCwpaJSFgeOkAVE7mdBD48NADokuYGV1o81oXZUEUPVs+l0jtybt4zRR3WJr
         2QFlnGEDyLpz2KV1/+wh9+sZd41HTFulYlNHM623sh9D0RnEoUZOJFpzG6XQOZdz/BJi
         GUL023j0nYxKILnBD3oFwOEhk65K/LTEvPurLVk3GXvO9OIUM8zN4/KBDNf7hb5Efrs5
         VCFGDwLxxsc0CPDktaLlfddFTkS1YulhRnojG2OA3XwfkzNb+zvFzKkwL8u4n803cenT
         14r+O22ssjmD3x/KWN3/8w6GyRIgOeZnqCyV/vb9anWU2h3GEbaPzlEDj3UMC2q3bcm8
         zAcA==
X-Forwarded-Encrypted: i=1; AJvYcCVZPrDBhXhSiIbHrjOj32empEQE9AYHrBQSTClVXxapsHiQkooIHHKpC1y2ecUQzMFcTRedsrOf4j/ikVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbqc/Qr2sejcjA93ilajmiNwikUbrcr6RYuPaCipP2dan1wriq
	AIMAtToTgw6fy0VhwtmUU0AGt0S2IhPL+CRAMo3Y+n8hcjXotd8xnVDCjIu3OUo=
X-Google-Smtp-Source: AGHT+IHcYNd/jqeI1uUq39K0wTEEILl56cZmfFM206eoGpPJ7N6EmrgIJr8Kaa/jRja1JuZV67rn6g==
X-Received: by 2002:a05:6602:2cd3:b0:82a:a804:2ec1 with SMTP id ca18e2360f4ac-82d378245b8mr721024639f.12.1726331987542;
        Sat, 14 Sep 2024 09:39:47 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed33fd1sm470270173.122.2024.09.14.09.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 09:39:46 -0700 (PDT)
Message-ID: <d161a6ea-6975-4427-8de8-93d4ee9e80fb@sifive.com>
Date: Sat, 14 Sep 2024 11:39:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Redirect instruction access fault trap to
 guest
To: Anup Patel <anup@brainfault.org>
Cc: Quan Zhou <zhouquan@iscas.ac.cn>, ajones@ventanamicro.com,
 atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org
References: <83c2234d582b7e823ce9ac9b73a6bbcf63971a29.1724911120.git.zhouquan@iscas.ac.cn>
 <b5128162-278a-4284-8271-b2b91dc446e1@iscas.ac.cn>
 <380f4da9-50e9-4632-bdc8-b1723eb19ca5@sifive.com>
 <CAAhSdy1zSTWuTW1KohUDXr9UXUx-QL1A30AUkTGoL7W2L7JWLQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAAhSdy1zSTWuTW1KohUDXr9UXUx-QL1A30AUkTGoL7W2L7JWLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anup,

On 2024-09-12 11:32 PM, Anup Patel wrote:
> On Fri, Sep 13, 2024 at 6:09 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> On 2024-09-12 4:03 AM, Quan Zhou wrote:
>>>
>>> On 2024/8/29 14:20, zhouquan@iscas.ac.cn wrote:
>>>> From: Quan Zhou <zhouquan@iscas.ac.cn>
>>>>
>>>> The M-mode redirects an unhandled instruction access
>>>> fault trap back to S-mode when not delegating it to
>>>> VS-mode(hedeleg). However, KVM running in HS-mode
>>>> terminates the VS-mode software when back from M-mode.
>>>>
>>>> The KVM should redirect the trap back to VS-mode, and
>>>> let VS-mode trap handler decide the next step.
>>>>
>>>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>>> ---
>>>>   arch/riscv/kvm/vcpu_exit.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
>>>> index fa98e5c024b2..696b62850d0b 100644
>>>> --- a/arch/riscv/kvm/vcpu_exit.c
>>>> +++ b/arch/riscv/kvm/vcpu_exit.c
>>>> @@ -182,6 +182,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct
>>>> kvm_run *run,
>>>>       ret = -EFAULT;
>>>>       run->exit_reason = KVM_EXIT_UNKNOWN;
>>>>       switch (trap->scause) {
>>>> +    case EXC_INST_ACCESS:
>>>
>>> A gentle ping, the instruction access fault should be redirected to
>>> VS-mode for handling, is my understanding correct?
>>
>> Yes, this looks correct. However, I believe it would be equivalent (and more
>> efficient) to add EXC_INST_ACCESS to KVM_HEDELEG_DEFAULT in asm/kvm_host.h.
>>
>> I don't understand why some exceptions are delegated with hedeleg and others are
>> caught and redirected here with no further processing. Maybe someone thought
>> that it wasn't valid to set a bit in hedeleg if the corresponding bit was
>> cleared in medeleg? But this doesn't make sense, as S-mode cannot know which
>> bits are set in medeleg (maybe none are!).
>>
>> So the hypervisor must either:
>>  1) assume M-mode firmware checks hedeleg and redirects exceptions to VS-mode
>>     regardless of medeleg, in which case all four of these exceptions can be
>>     moved to KVM_HEDELEG_DEFAULT and removed from this switch statement, or
>>
>>  2) assume M-mode might not check hedeleg and redirect exceptions to VS-mode,
>>     and since no bits are guaranteed to be set in medeleg, any bit set in
>>     hedeleg must _also_ be handled in the switch case here.
>>
>> Anup, Atish, thoughts?
> 
> Any exception delegated to VS-mode via hedeleg means it is directly delivered
> to VS-mode without any intervention of HS-mode. This aligns with the RISC-V
> priv specification and there is no alternate semantics assumed by KVM RISC-V.
> 
> At the moment, for KVM RISC-V we are converging towards the following
> approach:
> 
> 1) Only delegate "supervisor expected" traps to VS-mode via hedeleg
> which supervisor software is generally expected to directly handle such
> as breakpoint, user syscall, inst page fault, load page fault, and store
> page fault.
> 
> 2) Other "supervisor unexpected" traps are redirected to VS-mode via
> software in HS-mode because these are not typically expected by supervisor
> software and KVM RISC-V should at least gather some stats for such traps.

Can you point me to where we collect stats for these traps? I don't see any code
in kvm_riscv_vcpu_exit() that does this.

> Previously, we were redirecting such unexpect traps to KVM user space
> where the KVM user space tool will simply dump the VCPU state and kill
> the Guest/VM.

Currently we have 5 exception types that go through software in HS-mode but
never kill the guest: EXC_INST_ILLEGAL, EXC_LOAD_MISALIGNED,
EXC_STORE_MISALIGNED, EXC_LOAD_ACCESS, and EXC_STORE_ACCESS. Are those
considered "expected" or "unexpected"?

> The inst misaligned trap was historically always set in hedeleg but we
> should update it based on the above approach.

What are the criteria for determining if a trap is "supervisor expected" or
"supervisor unexpected"? Certainly any trap that can be triggered by misbehaved
software in VU-mode should not kill the guest. Similarly, any trap that can be
triggered by a misbehaved nested VS-mode guest should not kill the outer guest
either.

So the only reason I see for not delegating them is to collect stats, but I
wonder if that is worth the performance cost. I would rather make misaligned
loads/stores (for example) faster in the guest than have a count of them at the
hypervisor level.

Regards,
Samuel


