Return-Path: <linux-kernel+bounces-291879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C5956879
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83AE1F225A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55A165F0C;
	Mon, 19 Aug 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UfLay9HI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DB1607B6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063100; cv=none; b=VDs1k2z+tG8ErRJvMXrmi6VsSPQwfrGAwyNwtYDNo8ColOck7BG/FHRXaL3bP8GGwqYIWlmYP8Qc3YI9Tl05ywW/VL/Yas7Cuc+iA2NxIUErTVv7or2UGlzGgSa2BJJDGDct4VVYc+FkPy/h/HnX6FxeZZQHlW0EBPgJb/uEy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063100; c=relaxed/simple;
	bh=vlGemqzsfU8jHJ8QPcK04ea/pP9wnl2x7ITP8eWXOG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4r+l7djwKKYWWLw0pkQh2Oovma8vSCHF/do3uUUIEYkCmte8+gNRA+2D/K2XWAfdBROqnSrddDHamf1hWIv3oZn7hNVQTYKWQ9oLO76jgT1bgf2fVMWa9ct8Lfsnzy2ZLrwzP3eFHEzcRbwGKumx5obcLviM3eSPSRTPTWVQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UfLay9HI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso48474971fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724063095; x=1724667895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAMCWzw60vhdQM6QcI1aISDsDElEXVXB9p9izZXUTlQ=;
        b=UfLay9HIyfyOlaxKat3yra9Rh4R+olUxRdAl5rtWh3wqB8LZ5DNH+muY0BvF7Tm33q
         BBf398+3S20hbFUvTgkIuqgMXK3y/Q7PQvqhVqW49RWBNq3p/tm0cHHVMNNBfZ6dE4ui
         AGKk4DSWvmIPva4dm3SnSDEwLxOaxZxqEf81Uwr09SDDy8Q1KaijCltWxsGj9NEEzFIt
         F9dWIW1Q2jxIu/0apNHmyOy+G++OSaMm3Wow/RwWSd5lxiUqw7bvsLuqOa5U6ZWvYpDa
         /B7gODZAe8kGrUrN6enHCZQDxTK87zj3It1RfOiZJtUGMNY2MyC/HD/HR39mVhLwYYBp
         0qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063095; x=1724667895;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAMCWzw60vhdQM6QcI1aISDsDElEXVXB9p9izZXUTlQ=;
        b=hQrO6KAY/8KlmAUXYV9wZ15pSnNgetnrc3MyZfO29t3IKbNAaQUHUCJuX781MSazHJ
         fbogIIZ/HkgFDt3DlRfZkECkHrW4aDJaqkAtnzvN8yQS5vqSdc0GiSh/Vxqkc/JXF2rf
         gL881eKwBjSUVNlqLABAB4FizBwxpZ+HmOPrrBoQTAkoWR8bL6ocynrRjc28DpgxZQSe
         Ju1g+mKOLT/64a/tuk+Obq4tN1+dThGvP5qoXxd7h0F0WLb51LLwxly/iQIu85XciBKe
         iV5JkIwmAXmLOf3QAjtM0G+VCXa/k3UkE2QXNA2PliAS2/OF64ZAb7/A7sIyRFqCjKy/
         bjjg==
X-Forwarded-Encrypted: i=1; AJvYcCXGZzvIZ+x+eQ21HAyghpPWVP57Kt0JMtdFKKTwJSro+bcSbUHNfkdqZa2+R2Y0dKa4WTFPj1pLEoHt6/Vm7FQBRxskIq/4wLM+IZXD
X-Gm-Message-State: AOJu0YyRge6JVbuXcl5ky0i1P6gsIeJpTwWSYW6bT/uXRVm3Cf4C07Cw
	Xearmy8V8m75E9amoxuBcMijfEZQ9Kg4X3hUmLgc3WrUqsWklr7t/NcWyvJxGzM=
X-Google-Smtp-Source: AGHT+IF2wdXdu1KfmztZGLqlPneTcOSfrxnJEVygz5UYipbybgJHXJhrqC/84L5GVTtrgbUgXKWybw==
X-Received: by 2002:a05:6512:1087:b0:52c:cc38:592c with SMTP id 2adb3069b0e04-5331c61ced6mr7084552e87.0.1724063094890;
        Mon, 19 Aug 2024 03:24:54 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7717:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7717:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm616209266b.107.2024.08.19.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:24:54 -0700 (PDT)
Message-ID: <d8cc987e-8007-4820-b493-df2364b31774@suse.com>
Date: Mon, 19 Aug 2024 13:24:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] KVM: TDX: Report kvm_tdx_caps in
 KVM_TDX_CAPABILITIES
To: Chao Gao <chao.gao@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-12-rick.p.edgecombe@intel.com>
 <ZrrUanu3xYZyIshY@chao-email>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <ZrrUanu3xYZyIshY@chao-email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.08.24 г. 6:35 ч., Chao Gao wrote:
> On Mon, Aug 12, 2024 at 03:48:06PM -0700, Rick Edgecombe wrote:
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Report raw capabilities of TDX module to userspace isn't so useful
>> and incorrect, because some of the capabilities might not be supported
>> by KVM.
>>
>> Instead, report the KVM capp'ed capbilities to userspace.
>>
>> Removed the supported_gpaw field. Because CPUID.0x80000008.EAX[23:16] of
>> KVM_SUPPORTED_CPUID enumerates the 5 level EPT support, i.e., if GPAW52
>> is supported or not. Note, GPAW48 should be always supported. Thus no
>> need for explicit enumeration.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> ---
>> uAPI breakout v1:
>> - Code change due to previous patches changed to use exported 'struct
>>    tdx_sysinfo' pointer.
>> ---
>> arch/x86/include/uapi/asm/kvm.h | 14 +++----------
>> arch/x86/kvm/vmx/tdx.c          | 36 ++++++++-------------------------
>> 2 files changed, 11 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
>> index c9eb2e2f5559..2e3caa5a58fd 100644
>> --- a/arch/x86/include/uapi/asm/kvm.h
>> +++ b/arch/x86/include/uapi/asm/kvm.h
>> @@ -961,18 +961,10 @@ struct kvm_tdx_cpuid_config {
>> 	__u32 edx;
>> };
>>
>> -/* supported_gpaw */
>> -#define TDX_CAP_GPAW_48	(1 << 0)
>> -#define TDX_CAP_GPAW_52	(1 << 1)
>> -
>> struct kvm_tdx_capabilities {
>> -	__u64 attrs_fixed0;
>> -	__u64 attrs_fixed1;
>> -	__u64 xfam_fixed0;
>> -	__u64 xfam_fixed1;
>> -	__u32 supported_gpaw;
>> -	__u32 padding;
>> -	__u64 reserved[251];
>> +	__u64 supported_attrs;
>> +	__u64 supported_xfam;
>> +	__u64 reserved[254];
> 
> I wonder why this patch and patch 9 weren't squashed together. Many changes
> added by patch 9 are removed here.

As far as I can see this patch depends on the code in patch 10 
(kvm_tdx_caps) so this patch definitely must come after changes 
introduced in patch 10. However, patch 9 seems completely independent of 
patch 10, so I think patch 10 should become patch 9, and patch 9/11 
should be squashed into one and become patch 10.

<snip>

