Return-Path: <linux-kernel+bounces-542193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB38A4C6C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DB717271B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258A248166;
	Mon,  3 Mar 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC13Q6O/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758C214A8F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018311; cv=none; b=mG1eQBzwkp/QUjGTx9n+NmqOlu4a+3SyymRVkiLlv09Jhdf8M2tOaP2ROUfRpQFwuHwPKLSR6fFXBE5Jh9wbno8+wpWsdO/5DHvWVlUMo/K/iOwB+B8SGAZmheCvuW7Qs07uXGxS63scGJ85/CnrdmJdvDndC2XjhVdQM7YWWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018311; c=relaxed/simple;
	bh=e9ZKaBFXZ4rx4mLbacml2+h2XK5R5AhP1uLRLKbse0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZFXlNcJRDIYMPBFaeRa75Szuwy4WMettxkg1mlSIKQD79KjqNqb1uw+lN8nYLxKH+p2EYKv2ptZFH+UBDL1VEmrocnw00K76IQ63S2XEqx0KuolcV4ji7DDXvbaSdbDT/EKb4hXvkTPeyY1RV/2a6SPgUkBX8BywHydmBKlAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC13Q6O/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UK++ok7eznBr4HbeaXcZUWnmH5R9dI4DMZDcxpgCjlA=;
	b=AC13Q6O/IUkhd213hsNVvFE2j+lfubom/2Pq8m3HEiXVqLpGjKqSBeTtW0zdMz5MzwOqCZ
	CJb0p6nSPV11lJYMzyZ4cVFk73IDerz4vb4r10tWnJeL8mKLgMGBinxE7vhu3nFrU63/Q5
	BD/3pVqbJf5psbBmGjaaT50dBEZ7NMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-QGudTHqUOAiqigzhCnCTkQ-1; Mon, 03 Mar 2025 11:11:37 -0500
X-MC-Unique: QGudTHqUOAiqigzhCnCTkQ-1
X-Mimecast-MFC-AGG-ID: QGudTHqUOAiqigzhCnCTkQ_1741018296
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so20753455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018294; x=1741623094;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK++ok7eznBr4HbeaXcZUWnmH5R9dI4DMZDcxpgCjlA=;
        b=xC0BabarDqhwZ3lpmaNj7trAsqzFyeXMvyfCcqvzQ3UURYfQcb+W2lx+BZ35yDHM47
         zSg0xz4k87GvE2Kw/jVdtUqnkGd1n/YZ098gerlKKzo4uGMkTBM7/jeZ8x0XwfxF4eq0
         F3LlcVYhnIZZvOXMNJkLhKpHkxD8dZ0eLzhZ4dfwe2tCUqQKwzv0ROjgsv4tO3k2vsVa
         51fpjK8+fnZRAXVnx0ZXrU5kIVAM+qhLExmm23cZtzQkBKHgiU2YcLgt7euS8RAJ8OzH
         hVFqdwfH6EzwZ3TPAKrKo5frRHJsG/wc4/RdkLnZX9Iff0DLMFqGc01ukZ1e5s/F9vcj
         /AKA==
X-Gm-Message-State: AOJu0YxPcTwIs/jtRKAxcnd+O7+6EKbkem/j8+MEFXLn8mxup7GnhMs9
	ublZahcmNH4BNAwGut44x1HwJ/D5VR/ET7dJvYoJRClqtIxPVZdLgoCrLFEQdiDgyutkcBnPN4A
	fpWOrVonGC30IwXm9Nd3ymCz3oYxVGARgpNxifKBCo1gFg+0tPbxkPJw1HhyNBCArFnLQ18oS
X-Gm-Gg: ASbGnctfBmvYD3XyifO7PxubiB7vpQBodWdNrRksQFW4mFszIxM19krziPN4dkymxtM
	Ik8n3RhGlK5GyZ0KCGC0FOD/r8HwHfjVuF27LdW/nastbZ3ME0M6KwEqKomzY2YFB8R5GyXJlAN
	2JBk9L7VO/oSAfBvBIDgigXxjlqzJnYNSQi+Nz1dTizN94BFb8+pMxc8jmvwN9MuSg0giQkFvV8
	4mCqgRSczKQN/CBXKlDPRytzkzjksA0OyJ5ChNHkc2RwGvdczkJzLA1/yRdyE1Njc6/2xMKQdOG
	DdOV7agIsqEjeC3gJxw=
X-Received: by 2002:a05:600c:a01:b0:439:8a44:1e65 with SMTP id 5b1f17b1804b1-43ba66e67b6mr121549955e9.7.1741018294491;
        Mon, 03 Mar 2025 08:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVkwTV0pN68fkjhH/8vWMXh4kcuPS1c7rU0g3KWqUiBrZrQdy2QSnDEzxsZm74VBAI5x5WsQ==
X-Received: by 2002:a05:600c:a01:b0:439:8a44:1e65 with SMTP id 5b1f17b1804b1-43ba66e67b6mr121549725e9.7.1741018294065;
        Mon, 03 Mar 2025 08:11:34 -0800 (PST)
Received: from [192.168.10.27] ([151.95.119.44])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43bc11e1c8esm43677065e9.32.2025.03.03.08.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:11:32 -0800 (PST)
Message-ID: <4a2d487b-aabd-4854-a8df-214423b8c390@redhat.com>
Date: Mon, 3 Mar 2025 17:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] KVM: x86: Introduce supported_quirks to block
 disabling quirks
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com
References: <20250301073428.2435768-1-pbonzini@redhat.com>
 <20250301073428.2435768-3-pbonzini@redhat.com>
 <Z8UEmKhnP9w1qII9@yzhao56-desk.sh.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8UEmKhnP9w1qII9@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 02:23, Yan Zhao wrote:
> On Sat, Mar 01, 2025 at 02:34:26AM -0500, Paolo Bonzini wrote:
>> From: Yan Zhao <yan.y.zhao@intel.com>
>>
>> Introduce supported_quirks in kvm_caps to store platform-specific force-enabled
>> quirks.  Any quirk removed from kvm_caps.supported_quirks will never be
>> included in kvm->arch.disabled_quirks, and will cause the ioctl to fail if
>> passed to KVM_ENABLE_CAP(KVM_CAP_DISABLE_QUIRKS2).
>>
>> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>> Message-ID: <20250224070832.31394-1-yan.y.zhao@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/kvm/x86.c | 7 ++++---
>>   arch/x86/kvm/x86.h | 2 ++
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fd0a44e59314..a97e58916b6a 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -4782,7 +4782,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
>>   		break;
>>   	case KVM_CAP_DISABLE_QUIRKS2:
>> -		r = KVM_X86_VALID_QUIRKS;
>> +		r = kvm_caps.supported_quirks;
>
> As the concern raised in [1], it's confusing for
> KVM_X86_QUIRK_EPT_IGNORE_GUEST_PAT to be present on AMD's platforms while not
> present on Intel's non-self-snoop platforms.

To make it less confusing, let's rename it to 
KVM_X86_QUIRK_IGNORE_GUEST_PAT.  So if userspace wants to say "I don't 
want KVM to ignore guest's PAT!", it can do so easily:

- it can check unconditionally that the quirk is included in 
KVM_CAP_DISABLE_QUIRKS2, and it will pass on both Intel with self-snoop 
with AMD;

- it can pass it unconditionally to KVM_X86_QUIRK_IGNORE_GUEST_PAT, 
knowing that PAT will be honored.

But KVM_CHECK_EXTENSION(KVM_CAP_DISABLE_QUIRKS2) will *not* include the 
quirk on Intel without self-snoop, which lets userspace detect the 
condition and raise an error.  This is better than introducing a new 
case in the API "the bit is returned by KVM_CHECK_EXTENSION, but 
rejected by KVM_ENABLE_CAP".  Such a new case would inevitably lead to 
KVM_CAP_DISABLE_QUIRKS3. :)

> Or what about introduce kvm_caps.force_enabled_quirk?
>
> if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
>          kvm_caps.force_enabled_quirks |= KVM_X86_QUIRK_EPT_IGNORE_GUEST_PAT;

That would also make it harder for userspace to understand what's going on.

> [1] https://lore.kernel.org/all/Z8UBpC76CyxCIRiU@yzhao56-desk.sh.intel.com/
>>   		break;
>>   	case KVM_CAP_X86_NOTIFY_VMEXIT:
>>   		r = kvm_caps.has_notify_vmexit;
>> @@ -6521,11 +6521,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>   	switch (cap->cap) {
>>   	case KVM_CAP_DISABLE_QUIRKS2:
>>   		r = -EINVAL;
>> -		if (cap->args[0] & ~KVM_X86_VALID_QUIRKS)
>> +		if (cap->args[0] & ~kvm_caps.supported_quirks)
>>   			break;
>>   		fallthrough;
>>   	case KVM_CAP_DISABLE_QUIRKS:
>> -		kvm->arch.disabled_quirks = cap->args[0];
>> +		kvm->arch.disabled_quirks = cap->args[0] & kvm_caps.supported_quirks;
>
> Will this break the uapi of KVM_CAP_DISABLE_QUIRKS?
> My understanding is that only KVM_CAP_DISABLE_QUIRKS2 filters out invalid
> quirks.

The difference between KVM_CAP_DISABLE_QUIRKS and 
KVM_CAP_DISABLE_QUIRKS2 is only that invalid values do not cause an 
error; but userspace cannot know what is in kvm->arch.disabled_quirks, 
so KVM can change the value that is stored there.

Paolo


>>   		r = 0;
>>   		break;
>>   	case KVM_CAP_SPLIT_IRQCHIP: {
>> @@ -9775,6 +9775,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>>   		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>>   		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
>>   	}
>> +	kvm_caps.supported_quirks = KVM_X86_VALID_QUIRKS;
>>   	kvm_caps.inapplicable_quirks = 0;
>>   
>>   	rdmsrl_safe(MSR_EFER, &kvm_host.efer);
>> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
>> index 9af199c8e5c8..f2672b14388c 100644
>> --- a/arch/x86/kvm/x86.h
>> +++ b/arch/x86/kvm/x86.h
>> @@ -34,6 +34,8 @@ struct kvm_caps {
>>   	u64 supported_xcr0;
>>   	u64 supported_xss;
>>   	u64 supported_perf_cap;
>> +
>> +	u64 supported_quirks;
>>   	u64 inapplicable_quirks;
>>   };
>>   
>> -- 
>> 2.43.5
>>
>>
> 


