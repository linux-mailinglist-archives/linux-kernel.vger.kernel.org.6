Return-Path: <linux-kernel+bounces-549634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6AA554D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2242B3A3A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B326E167;
	Thu,  6 Mar 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnVlRsr3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAF255E54
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285157; cv=none; b=WVotdUNcgwlWpIn9m4rFeYp6hQZBkOCHuXudB8T+Kt3jA8HK17Nb6B6/hLsyT7a7sEWQ2u7+dpYVtaxWu+O9AoTaMpkgLpyOS8m+cB8Y0YCJ+IF4wJPif0LhLO4kT1nC2FJw2rpQN5N9+Ox/TsONnzOCl/Uvust0GVG8VsoynYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285157; c=relaxed/simple;
	bh=FXq9VutgHbih6VL+4daHo/jo/HskVzVXgPD8GPDnC5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpdvYyizUDBbT0mtVoYORWXXTf6DewHn1Up0b1jWFn2g2MoPBm2dSR5U1WoyiVh6urzCzEd8HBJuRxCV+GAf2YgoFlYOiKDUiw6hAoGT1q4G4MM3JjfH27PQb1zrN23RsXkzomFGKY2pnGmK9yzc53gYicTxMvzYtvz40xsSgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnVlRsr3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741285153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6jRuAqwxJQpBm7YfQoMi6ev65+OsKERmq486j5awJXM=;
	b=CnVlRsr3oEGy9vWGUknCge0Ezawc0nvwrkbZMuyTjU8o0DfsCUnd56XzC9OFaJiGEqqb6j
	MuevoFEmems49kp/An7q2eR/vKVoZ3CX5fXrqA+/erOP1608aflIbBnKL2r/P53Ify0Ioe
	jObtOn4nj0MR/HK4D11647GtAZo+LjA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-mWdcDGtuNhWKTCinDjsBIQ-1; Thu, 06 Mar 2025 13:19:11 -0500
X-MC-Unique: mWdcDGtuNhWKTCinDjsBIQ-1
X-Mimecast-MFC-AGG-ID: mWdcDGtuNhWKTCinDjsBIQ_1741285151
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac22704d52aso88777166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285151; x=1741889951;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jRuAqwxJQpBm7YfQoMi6ev65+OsKERmq486j5awJXM=;
        b=ipKV5zdGw7ZsTRvhDy60a/JaF32UTPGSq7NnGk7uqftRFpXdberN8Nj6SvRIyJjRoH
         rCFWi8b8+nhV352HCPHsawPYqB5Rgbzj8qvKUF2hBLFL4fsh3eL9AHXxQ4CWBVlPWt5h
         eN75nq2mxvQyrTALpICPMKoVNo8+iV6vhpAS17T8briKojoA3nsxs3/IdF2pJbkCbBzZ
         3AZ5DvRrcfRvkjZ+DFCTKLh6vstesM+Hlb4QBOxYnQxY/uaPscNkbc2KSyYAlJ5Gz6xv
         A/Iw1Nty87pQL3TsPUYrFfdMW8qpfhNZtVHsm5mfVV6/USQezlnGgf5sCs8+viNNtUUb
         /qpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCFsrquSDh+QF/BiJKj98nRFqtGll4wz45unB/n8fneeMLd8e6huWAjrYFXuG7gLOuk7eCS+xXJ2MeD58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHv4jGLuqZAdoh2WAkX4zbFZ5jzwqHFIUH9w+0UrIqnxqv1fpW
	NH4q0E0r5JQDM5jrY5rSS0c9g7eQZC5RfuhUWHrbP4hxC3Iiu3yt7fxE9cKRNeDlybvtSYFE1OK
	KMEDqSn80hlJGC93NCnsmG78W45Ed6UNN/TyDy1cnYtQchVlyyXC0p2nrpN0U1w==
X-Gm-Gg: ASbGncs71vVPK/qCZ2x+1ocHYhFiZQXr4400yIFLUdVgpOgYxU/MoTrJFYL4E2LqpHp
	Z6p+FQLa0hc8kib84vLd0KKLQGNMHK5Ka0mBjBYcp3jvgiRfKZ8UQKHII/RY6icCJx/Nv+88tPX
	cXyobpKxr/Ic9y05VWZLe5GFT5DAF0g9Px37jkA2wXxCIggNlG3AQBf6qB3+R8StZWKGxYjHTO+
	RKPkJ/1gkKdrLM2ki5RqmS+KUgMG6EXGJFa0suUQvgXlpyMpJKLXiFOWlMQPxjUMTIYBRXfZ6MV
	HYnRdwCGHZ/OICYinA==
X-Received: by 2002:a17:907:3e82:b0:abf:74e1:cfc0 with SMTP id a640c23a62f3a-ac2525e03f3mr8858766b.7.1741285150497;
        Thu, 06 Mar 2025 10:19:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN+o9is5w1JfJMbrFgww09160gc/alBQQgiqGe4a9qzYyNyB/NZp0L7mrMG7+bQLWMumjkIg==
X-Received: by 2002:a17:907:3e82:b0:abf:74e1:cfc0 with SMTP id a640c23a62f3a-ac2525e03f3mr8854866b.7.1741285150062;
        Thu, 06 Mar 2025 10:19:10 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac239488be1sm134167066b.74.2025.03.06.10.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:19:09 -0800 (PST)
Message-ID: <d3f83243-5526-4196-956c-de349bebd81f@redhat.com>
Date: Thu, 6 Mar 2025 19:19:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/12] KVM: TDX: Implement TDX vcpu enter/exit path
To: Adrian Hunter <adrian.hunter@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com,
 reinette.chatre@intel.com, tony.lindgren@linux.intel.com,
 binbin.wu@linux.intel.com, dmatlack@google.com, isaku.yamahata@intel.com,
 nik.borisov@suse.com, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com,
 chao.gao@intel.com, weijiang.yang@intel.com
References: <20250129095902.16391-1-adrian.hunter@intel.com>
 <20250129095902.16391-6-adrian.hunter@intel.com>
 <06c73413-d751-45bf-bde9-cdb4f56f95b0@intel.com>
 <632ea548-0e64-4a62-8126-120e42f4cd64@intel.com>
 <d9924ccd-7322-48aa-93be-82620f72791c@intel.com>
 <3e64b29e-34eb-4f9e-b7d1-a7803665ca55@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <3e64b29e-34eb-4f9e-b7d1-a7803665ca55@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/25 19:37, Adrian Hunter wrote:
> On 25/02/25 08:15, Xiaoyao Li wrote:
>> On 2/24/2025 8:27 PM, Adrian Hunter wrote:
>>> On 20/02/25 15:16, Xiaoyao Li wrote:
>>>> On 1/29/2025 5:58 PM, Adrian Hunter wrote:
>>>>> +#define TDX_REGS_UNSUPPORTED_SET    (BIT(VCPU_EXREG_RFLAGS) |    \
>>>>> +                     BIT(VCPU_EXREG_SEGMENTS))
>>>>> +
>>>>> +fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
>>>>> +{
>>>>> +    /*
>>>>> +     * force_immediate_exit requires vCPU entering for events injection with
>>>>> +     * an immediately exit followed. But The TDX module doesn't guarantee
>>>>> +     * entry, it's already possible for KVM to_think_ it completely entry
>>>>> +     * to the guest without actually having done so.
>>>>> +     * Since KVM never needs to force an immediate exit for TDX, and can't
>>>>> +     * do direct injection, just warn on force_immediate_exit.
>>>>> +     */
>>>>> +    WARN_ON_ONCE(force_immediate_exit);
>>>>> +
>>>>> +    trace_kvm_entry(vcpu, force_immediate_exit);
>>>>> +
>>>>> +    tdx_vcpu_enter_exit(vcpu);
>>>>> +
>>>>> +    vcpu->arch.regs_avail &= ~TDX_REGS_UNSUPPORTED_SET;
>>>>
>>>> I don't understand this. Why only clear RFLAGS and SEGMENTS?
>>>>
>>>> When creating the vcpu, vcpu->arch.regs_avail = ~0 in kvm_arch_vcpu_create().
>>>>
>>>> now it only clears RFLAGS and SEGMENTS for TDX vcpu, which leaves other bits set. But I don't see any code that syncs the guest value of into vcpu->arch.regs[reg].
>>>
>>> TDX guest registers are generally not known but
>>> values are placed into vcpu->arch.regs when needed
>>> to work with common code.
>>>
>>> We used to use ~VMX_REGS_LAZY_LOAD_SET and tdx_cache_reg()
>>> which has since been removed.
>>>
>>> tdx_cache_reg() did not support RFLAGS, SEGMENTS,
>>> EXIT_INFO_1/EXIT_INFO_2 but EXIT_INFO_1/EXIT_INFO_2 became
>>> needed, so that just left RFLAGS, SEGMENTS.
>>
>> Quote what Sean said [1]
>>
>>    “I'm also not convinced letting KVM read garbage for RIP, RSP, CR3, or
>>    PDPTRs is at all reasonable.  CR3 and PDPTRs should be unreachable,
>>    and I gotta imagine the same holds true for RSP.  Allow reads/writes
>>    to RIP is fine, in that it probably simplifies the overall code.”
>>
>> We need to justify why to let KVM read "garbage" of VCPU_REGS_RIP,
>> VCPU_EXREG_PDPTR, VCPU_EXREG_CR0, VCPU_EXREG_CR3, VCPU_EXREG_CR4,
>> VCPU_EXREG_EXIT_INFO_1, and VCPU_EXREG_EXIT_INFO_2 are neeed.
>>
>> The changelog justify nothing for it.
> 
> Could add VCPU_REGS_RIP, VCPU_REGS_RSP, VCPU_EXREG_CR3, VCPU_EXREG_PDPTR.
> But not VCPU_EXREG_CR0 nor VCPU_EXREG_CR4 since we started using them.

Hi Adrian,

how is CR0 used? And CR4 is only used other than for loading the XSAVE 
state, I think?

I will change this to a list of specific available registers instead of 
using "&= ~", and it would be even better if CR0/CR4 are not on the list.

Paolo

>> btw, how EXIT_INFO_1/EXIT_INFO_2 became needed? It seems I cannot find any TDX code use them.
> 
> vmx_get_exit_qual() / vmx_get_intr_info() are now used by TDX.
> 
>>
>> [1] https://lore.kernel.org/all/Z2GiQS_RmYeHU09L@google.com/
>>
>>>>
>>>>> +    trace_kvm_exit(vcpu, KVM_ISA_VMX);
>>>>> +
>>>>> +    return EXIT_FASTPATH_NONE;
>>>>> +}
>>>>
>>>
>>
> 
> 


