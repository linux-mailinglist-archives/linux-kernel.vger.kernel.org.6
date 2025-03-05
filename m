Return-Path: <linux-kernel+bounces-547987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC2AA53E82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55DE16CF18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A561207A14;
	Wed,  5 Mar 2025 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvOS3Qpq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBD207A10
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217532; cv=none; b=fV4MSC+JLFKTI1JRu8OYgZD55h/GjiypxvPrDImg39UafZT1Y53UP8vpAVS1t9D9sd1lD3tMDgWJz8ej286kjxQuA2PjBCCkZoR7ZA8ovr2PAubJvl5YnmniJ/hMUqXYBn3+cbPnMiwrRR2QUGp2KYoHvfQvaoWB5BgdBbughrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217532; c=relaxed/simple;
	bh=REQ/IfjD8heLKs2fU0174gHx+56fArKa2gF2nY/f/EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ+Eu+NjWvTpqw0V/bRuP5UU/9N8PNSmtNSkWqQwE3PjkSm5W0rPs/3lp+mdtudwSn2bRTAsB7ty5AosobPByes2d8YXzpo6FrMbt5RaH0mWp24vFOQHvx83akrhR4pYB7uG+hwVb/7RgUoxTWIQ11O9ekHQJcOdsyFXJazCu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvOS3Qpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741217530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFCm6qFAyYGc4VFf2sS3vwJnAyvK+30pL4l8MO3Di54=;
	b=hvOS3Qpqg69Bo0rWgfYx9imbaxGQ1Zu5j4ekTDapb6ojOgdAIuj5hcE2ULYYDg7HFap9tN
	+13WPCYXJiDVEPYZlaLYd2R8+WOo7EoD3+M9P5VyiFV+Zt9it9A+gQjBffmcCtApMI+drF
	3nqnaoQUtvylmZ6cWpSmXfHZnORlbAU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-i6_bvazVNYep-dGwz6NXMQ-1; Wed, 05 Mar 2025 18:31:54 -0500
X-MC-Unique: i6_bvazVNYep-dGwz6NXMQ-1
X-Mimecast-MFC-AGG-ID: i6_bvazVNYep-dGwz6NXMQ_1741217513
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22380c707d3so244405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217513; x=1741822313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFCm6qFAyYGc4VFf2sS3vwJnAyvK+30pL4l8MO3Di54=;
        b=CpWrH5DHRFAtFWA2k7l0AyOHIC0pPLVkmGUAs6REzB5akn1CsmFmlmFKci6ji3WsXz
         RgDimE2UqL/45gt+gLgDKQ5B+cO+BlRX64pCRKgBJGCOMhwH6z5c9RdHO8XSiooxW0VU
         oInnYBOUyBxciZ7S9S36pEkiGYOQ9JIPK/bjebTCnQbNv96PXQNKKgdipwbzqagEivMh
         08JeJ3N5xyc878jeCAED+9lyTwbywQ+EOTrqbJ7w5DRTSBvbfUEodwBQ9Lm/RmoVRQBK
         95+ImmBmP3RJIjFeZpkXDleqQXAIuEN3DB9XovfhGO3Tw/w/eUkyPchZliXPizZHpWsf
         Y4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Z8FC42limciAzm4M1r1l2ullI7hTZwJaIf3Cp2n9SJE0iE0BOCU/xFfKPxxQpH1cvwGQpNSUsvi+YbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxipvomgT8R0NtmUlAiI3ofiAxk1xCdEh3RmOZoGugvI/gOBLgR
	TQMsu1okHpZ9QbDobdyWDPP7wNE7OJhjOe+k6b/TbLpYmcKDReZitrUv6SYWZwct3KNVVacsC/u
	5Nqeve6awY/FmhrASEAMUSzKWpFSb47HmgGg1Vj2YbBmq+KihukpFA60mMWxtdQ==
X-Gm-Gg: ASbGncsGPy7564IMUCjcWbBbWGHFpUdtiml0+sm+Hn4H/1CpiKYjRMWMA/RWiUCuG8Q
	cTTxupyplYIKpahBXb48JznM7MI0ZhMz/XI0xAMUWyp6kr7ggOCaaNMi2eK06LdyDm97NyQavyz
	raTn1n4skEfPE/Zr1A4r2r2828/hN1yqhUJ3Xjf/RBUU1n39GmkQckysZ6tKZFrYGZEMx/uKFle
	2qiyFaJinU+1JMVVnnlQBka8m1XUX7cQWmMaqSX+AO1y7m7bikt0+LKgI5Lr70VhLSgdJAqz5fx
	gA6Fxi5yFaRS9Do=
X-Received: by 2002:a05:6a00:856:b0:736:51a6:78b1 with SMTP id d2e1a72fcca58-73682bdf13fmr5864406b3a.11.1741217512909;
        Wed, 05 Mar 2025 15:31:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr5llQOo8uwX2X7Rw/daISqoaMPhAadKna3dfRjuli6+dA3NfteMRLNkx9LXdBAsG0P/3xwA==
X-Received: by 2002:a05:6a00:856:b0:736:51a6:78b1 with SMTP id d2e1a72fcca58-73682bdf13fmr5864388b3a.11.1741217512567;
        Wed, 05 Mar 2025 15:31:52 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a00400a0sm13952388b3a.140.2025.03.05.15.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 15:31:51 -0800 (PST)
Message-ID: <3190c4b0-4826-4d9b-9b12-8063acff57fa@redhat.com>
Date: Thu, 6 Mar 2025 09:31:43 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/45] kvm: arm64: Expose debug HW register numbers for
 Realm
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-10-steven.price@arm.com>
 <cec600f2-2ddc-4c71-9bab-0a0403132b43@redhat.com>
 <ea9bb982-cf31-4079-8fea-dc39e91a975b@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ea9bb982-cf31-4079-8fea-dc39e91a975b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steven,

On 3/6/25 2:25 AM, Steven Price wrote:
> On 03/03/2025 04:48, Gavin Shan wrote:
>> On 2/14/25 2:13 AM, Steven Price wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> Expose VM specific Debug HW register numbers.
> 
> Looking at this now, this patch description is garbage. Probably the
> patch has changed over time - so I suspect it's my fault not Suzuki's.
> We're not exposing anything new here. This is purely about telling the
> VMM that a realm cannot (currently) be debugged. Something like the
> below would be more accurate:
> 
> """
> kvm: arm64: Don't expose debug capabilities for realm guests
> 
> RMM v1.0 provides no mechanism for the host to perform debug operations
> on the guest. So don't expose KVM_CAP_SET_GUEST_DEBUG and report 0
> breakpoints and 0 watch points.
> """
> 

Yes, the improved change log looks good to me.

>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>    arch/arm64/kvm/arm.c | 24 +++++++++++++++++++++---
>>>    1 file changed, 21 insertions(+), 3 deletions(-)
>>>
>>
>> Documentation/virt/kvm/api.rst needs to be updated accordingly.
> 
> I don't think (with the above clarification) there's anything to update
> in the API documentation. There's nothing new being added, just
> capabilities being hidden where the functionality isn't available.
> 
> And eventually we hope to add support for this (in a later RMM spec) - I
> don't yet know exactly what form this will take, but I hope to keep the
> interfaces as close as possible to what we already have so that existing
> tooling can be used.
> 

Ok.

>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>> index b8fa82be251c..df6eb5e9ca96 100644
>>> --- a/arch/arm64/kvm/arm.c
>>> +++ b/arch/arm64/kvm/arm.c
>>> @@ -78,6 +78,22 @@ bool is_kvm_arm_initialised(void)
>>>        return kvm_arm_initialised;
>>>    }
>>>    +static u32 kvm_arm_get_num_brps(struct kvm *kvm)
>>> +{
>>> +    if (!kvm_is_realm(kvm))
>>> +        return get_num_brps();
>>> +    /* Realm guest is not debuggable. */
>>> +    return 0;
>>> +}
>>> +
>>> +static u32 kvm_arm_get_num_wrps(struct kvm *kvm)
>>> +{
>>> +    if (!kvm_is_realm(kvm))
>>> +        return get_num_wrps();
>>> +    /* Realm guest is not debuggable. */
>>> +    return 0;
>>> +}
>>> +
>>
>> The above two comments "Realm guest is not debuggable." can be dropped
>> since
>> the code is self-explanatory, and those two functions are unnecessary to be
>> kept in that way, for example:
>>
>>      case KVM_CAP_GUEST_DEBUG_HW_BPS:
>>          return kvm_is_realm(kvm) ? 0 : get_num_brps();
>>      case KVM_CAP_GUEST_DEBUG_HW_WRPS:
>>          return kvm_is_realm(kvm) ? 0 : get_num_wrps();
>>
>>
>>>    int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>>>    {
>>>        return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
>>> @@ -323,7 +339,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,
>>> long ext)
>>>        case KVM_CAP_ARM_IRQ_LINE_LAYOUT_2:
>>>        case KVM_CAP_ARM_NISV_TO_USER:
>>>        case KVM_CAP_ARM_INJECT_EXT_DABT:
>>> -    case KVM_CAP_SET_GUEST_DEBUG:
>>>        case KVM_CAP_VCPU_ATTRIBUTES:
>>>        case KVM_CAP_PTP_KVM:
>>>        case KVM_CAP_ARM_SYSTEM_SUSPEND:
>>> @@ -331,6 +346,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,
>>> long ext)
>>>        case KVM_CAP_COUNTER_OFFSET:
>>>            r = 1;
>>>            break;
>>> +    case KVM_CAP_SET_GUEST_DEBUG:
>>> +        r = !kvm_is_realm(kvm);
>>> +        break;
>>>        case KVM_CAP_SET_GUEST_DEBUG2:
>>>            return KVM_GUESTDBG_VALID_MASK;
>>>        case KVM_CAP_ARM_SET_DEVICE_ADDR:
>>> @@ -376,10 +394,10 @@ int kvm_vm_ioctl_check_extension(struct kvm
>>> *kvm, long ext)
>>>            r = cpus_have_final_cap(ARM64_HAS_32BIT_EL1);
>>>            break;
>>>        case KVM_CAP_GUEST_DEBUG_HW_BPS:
>>> -        r = get_num_brps();
>>> +        r = kvm_arm_get_num_brps(kvm);
>>>            break;
>>>        case KVM_CAP_GUEST_DEBUG_HW_WPS:
>>> -        r = get_num_wrps();
>>> +        r = kvm_arm_get_num_wrps(kvm);
>>>            break;
>>>        case KVM_CAP_ARM_PMU_V3:
>>>            r = kvm_arm_support_pmu_v3();
>>

Thanks,
Gavin


