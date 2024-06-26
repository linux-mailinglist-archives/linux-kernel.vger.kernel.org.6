Return-Path: <linux-kernel+bounces-230205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA329179CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BAC1C230A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11315B97E;
	Wed, 26 Jun 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0J0nGrX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9B15B986
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387236; cv=none; b=sZrww66lz3rDmrp16vRJSYNKQDGbHh6bJ4kTOhNngSMIZbUKLkurtYJ3BU7Rdt4LD/Jm4bkgdpkoA95PekXoAkZmZWqSG2pB3fZxua2HJxQmf3nS1CU7iKGITMiPYMfJ+A/9k3jd1deDNSfgb9gu17xJv6XbvRDYEQUkl96VbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387236; c=relaxed/simple;
	bh=xLdCdQzBv/TiZ5lJtJptlSu/LpiIqAEcshJlabVSs64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usXhZYYH/kGSsz5btEwI4V8xds8hhpLqD9nH5BIRkycpp0PTtKsIzxwRsbNReGVR7p6R2yPiU5m9cweDOWCmnRm7PbIndLxN9MLZ4gnkqhFRFAvszBWS8J6WABFRIPUqymJF71GaDPnWNPdt1dWl13pGDNdGunry5oEx7E8wC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0J0nGrX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719387233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIU/f8nuSSgd5Uibiu2hm7EU9SonvvDjpvellDh9LSA=;
	b=C0J0nGrXKVwaPnIaTsZM/hMzF5C4pkc8grh54hq+98I6ChGOo3fgyiUNycslz9ipl6RjZR
	LiUeq+ToWcNpShEHi4JDNOv+TTyPhM/IB/flNzzReIBNYEyx91eC3EjUUMxYfggzo9gHtn
	nTIMVtBckhVhQQT9Q34nfUl8EZSQiYU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-y_MYdf79OKCVgpCDWvSDaw-1; Wed, 26 Jun 2024 03:33:52 -0400
X-MC-Unique: y_MYdf79OKCVgpCDWvSDaw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7c20d5027so1781203a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387231; x=1719992031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIU/f8nuSSgd5Uibiu2hm7EU9SonvvDjpvellDh9LSA=;
        b=RfZSIetK/YEoNxhJVJyscNDJ+DHnUrm3ugagBTwwTmVUpsBWMo0BHLNXpU6AynjstW
         L+2U90E33rEaIPAI4A2meLiUE2kPSnoP4NTxEDr2sxTO9fpYl1hC3JzugWVKlTYs43er
         16e5qa8lkAH2UkwsDug5vG8xRAwykGrJlVXyl3N3Ud6o3Vg7DncERvu40s7o4uqmKSvW
         F8O3u8oOm1QIxEAl2GboADuOnpN8RvX4z9SxAtCJ3C+8H7XQSPn4VXCkp/k89YXgVSas
         gG/H6l4bS/XtbTArWHbOghvjppnvF/LZzaF8ZGu/YARvcY7TqZHXU/dadnlR7ODi/wJB
         AdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNS72wHEeD7EP/WnljEbVv0ThdFqhCcbaLrBkDXAUnrOtWlWgKSbstHMPnpOaB7SxIB6pNWvrzOaOcvB+pc0cj6zvkgw7HqaHyN/0N
X-Gm-Message-State: AOJu0YwUgwZdlbBU2OKDEfPii0uIhYVUBA1zXd+D4pwHqZQaVX4u9pcv
	8+MnhObpV0geuImNikgumrRs3qluclazY2ld9M+E/EHqyaCKcE7s6AmOOmYMfoWm7S1nL6e+KfV
	sQZIoiK3GRAkfN2d5Nz0EgfmydRwmETy6gt8DOrJIY4J9GypbWsfVpYwWaAKWDw==
X-Received: by 2002:a05:6a20:3c94:b0:1bd:289f:2ccb with SMTP id adf61e73a8af0-1bd289f63ecmr2588278637.6.1719387230903;
        Wed, 26 Jun 2024 00:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5xJhZiReur+T6vKl1uy4p88kloJYwrPnEyi/znCBEIkUR6Gm8PlFwhZvceKUizaIo52ITQ==
X-Received: by 2002:a05:6a20:3c94:b0:1bd:289f:2ccb with SMTP id adf61e73a8af0-1bd289f63ecmr2588265637.6.1719387230446;
        Wed, 26 Jun 2024 00:33:50 -0700 (PDT)
Received: from [10.72.116.72] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70696a49ff9sm2854783b3a.164.2024.06.26.00.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 00:33:50 -0700 (PDT)
Message-ID: <6935be08-f29e-4dd1-9fe7-3d51d3f97509@redhat.com>
Date: Wed, 26 Jun 2024 15:33:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] KVM: arm64: Allow userspace to change
 ID_AA64PFR1_EL1
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240618063808.1040085-1-shahuang@redhat.com>
 <20240618063808.1040085-2-shahuang@redhat.com> <86ed8uk8cr.wl-maz@kernel.org>
 <f73cabc6-8c48-4c12-9d60-269e50df41f3@redhat.com>
 <861q4qk9z7.wl-maz@kernel.org>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <861q4qk9z7.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 6/21/24 15:53, Marc Zyngier wrote:
> On Fri, 21 Jun 2024 07:17:57 +0100,
> Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> Hi Marc,
>>
>> On 6/18/24 15:39, Marc Zyngier wrote:
>>> On Tue, 18 Jun 2024 07:38:06 +0100,
>>> Shaoqin Huang <shahuang@redhat.com> wrote:
>>>>
>>>> Allow userspace to change the guest-visible value of the register with
>>>> some severe limitation:
>>>>
>>>>     - No changes to features not virtualized by KVM (MPAM_frac, RAS_frac)
>>>> ---
>>>>    arch/arm64/kvm/sys_regs.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>>> index 22b45a15d068..bead81867bce 100644
>>>> --- a/arch/arm64/kvm/sys_regs.c
>>>> +++ b/arch/arm64/kvm/sys_regs.c
>>>> @@ -2306,7 +2306,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>>>    		   ID_AA64PFR0_EL1_GIC |
>>>>    		   ID_AA64PFR0_EL1_AdvSIMD |
>>>>    		   ID_AA64PFR0_EL1_FP), },
>>>> -	ID_SANITISED(ID_AA64PFR1_EL1),
>>>> +	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_RAS_frac |
>>>> +				       ID_AA64PFR1_EL1_MPAM_frac)),
>>>>    	ID_UNALLOCATED(4,2),
>>>>    	ID_UNALLOCATED(4,3),
>>>>    	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
>>>
>>> This isn't a valid patch.
>>>
>>> Furthermore, how about all the other features that may or may not be
>>> currently handled by KVM? Please see [1] and make sure that all
>>> existing fields have a known behaviour (a combination of masked,
>>> preserved, capped, writable or read-only).
>>>
>>> I can at least see problems with MTE_frac and MTEX, plus all the other
>>> things that KVM doesn't know how to save/restore (THE, GCS, NMI...).
>>>
>>> What I asked you to handle the whole register, I really meant it.
>>
>> I currently only found the BT and SSBS fields can be written without
>> any unknown behavior.
> 
> I can only assume you haven't looked hard enough.
> 
>>
>> All other fields in the ID_AA64PFR1_EL1 are either not supported by
>> KVM or the field involved with other register and KVM don't know how
>> to handle them.
> 
> Why can't CSV2_frac be writable? Why can't most of the other fields be
> hidden depending on the VM configuration, as pointed out above?

I looked at the "struct arm64_ftr_bits ftr_id_aa64pfr1[]" in the 
kernel/cpufeature.c, I don't see the CSV2_frac has been supported on ARM 
bare-mental. In this situation, can we first support it in KVM? If so, 
how can we do that, I don't understand that, could you give me some 
hints about that.

Other fields are same with CSV2_frac I think. The KVM don't know the 
configuration about them. Why we should allow them writable and hidden 
them right now? Instead of just make them still unwrittable?

Thanks,
Shaoqin

> 
> 	M.
> 

-- 
Shaoqin


