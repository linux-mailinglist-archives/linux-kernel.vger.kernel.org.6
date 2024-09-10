Return-Path: <linux-kernel+bounces-323611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C6974024
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3931F235D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1071A7061;
	Tue, 10 Sep 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbgbHVi7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB11A3BB4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989234; cv=none; b=QPrhx7IHwdzKpg5FxCNMtdY7QzPmVqsucjC/lHekO93ol0ILUw9FOWqwJ5SbTLTx6I2YkLU2pSvBYiu/UOK6etndBGP08pjvUBOYch3PdSPrBZMEXZ370putjiCqngwzyQxZUPiYGAebO5HqAQr3YasSOqfcUhyHSM0XEhNrw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989234; c=relaxed/simple;
	bh=LLCTb+zfOQiGHS5Whq0m2eyQsHOGSwwyjPOK3SwxRl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2WfcEjq4oztm0Rx6NIGRyLE/YgPRzVh5QqQh3AFvTaqOsz+xj14BfctNYZ7FDOBJqqMilfMxIr9uRMByW3r4DCJlmkrdJ55UOKPaEeOPQ1GPno30EeE4LFYd26lePqUFok4Y0Zp8n8xCRXywQ/nugsDad9TTzgha5G/4meaI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbgbHVi7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725989231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kCwDyyZj39SWKNb0kwxDwGc+PKolIBbjScL3NYTWV/k=;
	b=KbgbHVi7RA3bxAoaYJKJH7qFicqNBy6NT376uC6P14MpuPAk0U4T4G2GwDi9kZFnPHi78K
	3So7EMH+axZPWqjkuG27XoPyoirDGhmTrz54jjlI2zRhhsqCIi5Wy7kYWCIlnx98zNFXSE
	Pn5vvTvNHq/K98OsNQ9QdpYsejZsKbI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-q-gFeNgfOt2WPTb0QP7JIQ-1; Tue, 10 Sep 2024 13:27:10 -0400
X-MC-Unique: q-gFeNgfOt2WPTb0QP7JIQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374aef640a4so2322168f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989229; x=1726594029;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCwDyyZj39SWKNb0kwxDwGc+PKolIBbjScL3NYTWV/k=;
        b=dd3sNA6KDXG2+aNm8caQdB58fvNdeX7/3sdJV1YmbZVNuH0QgZxzpkFIakT51f+MfP
         ArhZsBb3HWeSBcyFwsTamMe4HzUJLQukVVfEV0Hh2jwQFS6ofwXCvWXwDpAk3akaf0Eu
         BrzvBsstnXo5NKNSQzCPc+2lSnTuXhG2oQMbPbV/gcs9RE+JwXqQY4joDHr82B0AvDj/
         M09j2mKLFIWxiviuI3QClIPGPsptj7uzxEK0Am52DfF8qTM/1GVo8R0CqL/xPNvTCxGH
         C5u/oBigX2Bcs42AlaJJ06pK4UOS2exSBjfY1HUPFUWExxu1W1WZwWMvG9IzJ6PVJ/6M
         OJ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWLmNcy2Pboo8pTvJt22HwHema2oXvQCYkDRzvhzyviLaRFQKArNI93qxgTZXUxjOpu/W5f/UL6+vWUKZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6841XhuBc6BPLCbdMJCN/o/gGD8ROqiogn4UeLPkK9bCtBXc
	0oOWq/ZkfhaEIxrJp9OB+IOaBWppvnQVofC93Z3WVO4im/jQ7/x4Uo77/Tl99CGOA/8Ycpe8+d8
	mLL4M+Q+GXrO+1hhm2SAqqIJAsiElwO5MuPf0aVIvjL26yD+5Pi/uXwFJfA42eg==
X-Received: by 2002:a05:6000:10e:b0:376:df1f:1245 with SMTP id ffacd0b85a97d-37892703f37mr7401484f8f.39.1725989228915;
        Tue, 10 Sep 2024 10:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+4dW4e+GsJPOYchUZDzTvrIqb2PdGMgLa4A1jfBU7WI1E4/RSil2Cc/w2TIE6faKjXana4g==
X-Received: by 2002:a05:6000:10e:b0:376:df1f:1245 with SMTP id ffacd0b85a97d-37892703f37mr7401474f8f.39.1725989228350;
        Tue, 10 Sep 2024 10:27:08 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378956d374fsm9501660f8f.86.2024.09.10.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:27:07 -0700 (PDT)
Message-ID: <b71e8410-c73b-45a3-a1a3-e13911a078dc@redhat.com>
Date: Tue, 10 Sep 2024 19:27:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/25] KVM: x86: Introduce KVM_TDX_GET_CPUID
To: Tony Lindgren <tony.lindgren@linux.intel.com>,
 Tao Su <tao1.su@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org, kai.huang@intel.com, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-22-rick.p.edgecombe@intel.com>
 <ZsK1JRf1amTEAW6q@linux.bj.intel.com> <Ztaq7YKVHSwfAzvJ@tlindgre-MOBL1>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Ztaq7YKVHSwfAzvJ@tlindgre-MOBL1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 08:21, Tony Lindgren wrote:
> On Mon, Aug 19, 2024 at 10:59:49AM +0800, Tao Su wrote:
>> On Mon, Aug 12, 2024 at 03:48:16PM -0700, Rick Edgecombe wrote:
>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>> +		/*
>>> +		 * Work around missing support on old TDX modules, fetch
>>> +		 * guest maxpa from gfn_direct_bits.
>>> +		 */
>>> +		if (output_e->function == 0x80000008) {
>>> +			gpa_t gpa_bits = gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));
>>> +			unsigned int g_maxpa = __ffs(gpa_bits) + 1;
>>> +
>>> +			output_e->eax &= ~0x00ff0000;
>>> +			output_e->eax |= g_maxpa << 16;
>>> +		}
>>
>> I suggest putting all guest_phys_bits related WA in a WA-only patch, which will
>> be clearer.
> 
> The 80000008 workaround needs to be tidied up for sure, it's hard to follow.

I think it's okay if you just add a separate 
tdx_get_guest_phys_addr_bits(struct kvm *kvm).

>>> --- a/arch/x86/kvm/vmx/tdx.h
>>> +++ b/arch/x86/kvm/vmx/tdx.h
>>> @@ -25,6 +25,11 @@ struct kvm_tdx {
>>>   	bool finalized;
>>>   
>>>   	u64 tsc_offset;
>>> +
>>> +	/* For KVM_MAP_MEMORY and KVM_TDX_INIT_MEM_REGION. */
>>> +	atomic64_t nr_premapped;
>>
>> I don't see it is used in this patch set.
> 
> Yes that should have been in a later patch.

Yes, it's used in the MMU prep part 2 series.

Paolo


