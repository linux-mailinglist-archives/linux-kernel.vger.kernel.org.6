Return-Path: <linux-kernel+bounces-256145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDE9349CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A9B285C67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DBE77F12;
	Thu, 18 Jul 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz6fQwU/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DF1EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290913; cv=none; b=nnSISmxbagWGYJ92MxLp6mF5xypdnAh8gUyAPs6wzyz2+JBFW/NuspAHbvt14Zta1CR+Dmc3mIgkYvNrEymPDuMZyVhqmfn1DeM4152g4/J6+knKC0do5k2LUvqXm8N+twX0LX83EZH1pvQRziC0EY4lQ0BpyaQf4B5H15skS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290913; c=relaxed/simple;
	bh=s8LaxNAYfmh3IeeZ0xeQdL3fh6VK7F/6mJqBXqfB5sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3j6LTMpUc9iQVvs0GDl1p8iFLvDx54XQk+aaVF7ekdJWsquxoFb9Qvx39lKJ0PUpHK2vnzgJdxNDfSMPD/onT0hVBNeGbGYVkGJerqZwiR40lyp165C/1Tw6Cd9cNqlHaSXnuxBw6DzxpjYI0nyDb8T2Se+wbRDxRyPJIIiVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vz6fQwU/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721290910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EG5X2jNXo44yPLi4gfIK72Jy2eQX46mdLlCCJwEgEGw=;
	b=Vz6fQwU/mgwXs8HVz0oFX+6sfgBwEjMXaNku18ENOWHiHaMQTotbJhdWITVtIRwgeEnso3
	wI2lT5hHQ4n+MkfnFLCCGNOXf8wgxNqP1PL/GgUClmgvuW9aTQukPtkKJfCxZJQQJzElMj
	bayGbC9oi39q+SogCLXF+JiEzGpK/QI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-iQnJW3UEPkGK3XT5T1Fzcg-1; Thu, 18 Jul 2024 04:21:49 -0400
X-MC-Unique: iQnJW3UEPkGK3XT5T1Fzcg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7651e748b49so128353a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290908; x=1721895708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EG5X2jNXo44yPLi4gfIK72Jy2eQX46mdLlCCJwEgEGw=;
        b=DIoIoYTksR+4axFzPQpoI0RxoOo8CssM4f/JIINYdhOx32V5cz/mcJRsOKsA2MK1Is
         Jlio1pFuWasuoNGCma+ot+iDb2GSzqZWAHWPF4tPquTaqKOTgXF5+mjjY26+Ec0SEp4B
         3u1pnuWBvHOX/w86TFcR8qq2mavK/2ClOsyM9h7fyfgLxVYy/0oW0sF8oX1xAycPrebf
         WiDiCShMvIBRc+gR+GBskoLRh/J+Ef/m9h+qUvDR1ASiddi8Wk7MZwvAGFh2B4Mgi7Vk
         027zG0o62bZ8I92vo/ZuIAfIESavHHN3RLlj9BnAX0cw97M9EnRBjOXAx5NR4Hc2/Le3
         0Qfg==
X-Forwarded-Encrypted: i=1; AJvYcCWCj4nrXRdZW2ecQuFvCUDsQMYAwBIUfznB0x47TZVS/Kh9/fR6+BCgPPdCR8jAdRPL4Gbxj6McXQbIxBJw34jONbNZXcumcrcVQeuc
X-Gm-Message-State: AOJu0Ywhb7GB/mbcGpSK8YRec53Ox7kqPTeBJ9wOzjRcZiEl55/Y0yXz
	nCLvdvDikfLYjZHcjBtxz2MSU8QFIHG0FOcwK+UIhiVGJ34qOwo0QK+5MW3JXeMo0X7iV29MTeT
	a7P1iX8hlw+vB3LbDjzNpWl0baYxTXSvW3vwo5bLR3MXvDeGHZ+B48/1EsCl/HQ==
X-Received: by 2002:a17:902:db06:b0:1fc:6028:b028 with SMTP id d9443c01a7336-1fc6028b1f4mr7517945ad.9.1721290908086;
        Thu, 18 Jul 2024 01:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVCsM1BT5kQcMnEYC3j/H0GU4TuMnoheFVj1xqeFGH2ijUZ24HklGKePCFjzvCcGO+Wj2ItQ==
X-Received: by 2002:a17:902:db06:b0:1fc:6028:b028 with SMTP id d9443c01a7336-1fc6028b1f4mr7517745ad.9.1721290907686;
        Thu, 18 Jul 2024 01:21:47 -0700 (PDT)
Received: from [10.72.116.35] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2712csm87732395ad.176.2024.07.18.01.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:21:47 -0700 (PDT)
Message-ID: <c8fd114a-1b9d-402a-b883-bfa1952d91fd@redhat.com>
Date: Thu, 18 Jul 2024 16:21:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] KVM: arm64: Allow userspace to change
 ID_AA64PFR1_EL1
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Mark Brown <broonie@kernel.org>, Eric Auger <eauger@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240718035017.434996-1-shahuang@redhat.com>
 <20240718035017.434996-3-shahuang@redhat.com> <Zpi3vjxLQ37Q_8OV@linux.dev>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <Zpi3vjxLQ37Q_8OV@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 7/18/24 14:35, Oliver Upton wrote:
> On Wed, Jul 17, 2024 at 11:50:15PM -0400, Shaoqin Huang wrote:
>> Allow userspace to change the guest-visible value of the register with
>> different way of handling:
>>
>>    - Since the RAS and MPAM is not writable in the ID_AA64PFR0_EL1
>>      register, RAS_frac and MPAM_frac are also not writable in the
>>      ID_AA64PFR1_EL1 register.
>>
>>    - The MTE is controlled by an internal flag (KVM_ARCH_FLAG_MTE_ENABLED),
>>      so it's not writable.
> 
> The flag isn't the relevant part, what's important about MTE is that it
> already has a separate UAPI for controlling it (KVM_CAP_ARM_MTE).

I'm not quite understand why KVM_ARCH_FLAG_MTE_ENABLED isn't the 
relevant part. I see this capability, when enable the KVM_CAP_ARM_MTE, 
it set the KVM_ARCH_FLAG_MTE_ENABLED in the kvm->arch.flags.

And do you mean we should update it like "The MTE is controlled by a 
UAPI (KVM_CAP_ARM_MTE)"?

> 
>>    - For those fields which KVM doesn't know how to handle, they have
>>      are not exposed to the guest (being disabled in the register read
>>      accessor), those fields value will always be 0. Allow those fields
>>      writable is fine, since the userspace can only write 0 into those
>>      fields. Maybe in the future KVM know how to handle some of the
>>      fields, then they can be written into other value.
>>      So let them writable.
>>      Those fields include SME, RNDR_trap, NMI, GCS, THE, DF2, PFAR,
>>      MTE_frac, MTEX.
> 
> This doesn't seem right. We're committing to a UAPI behavior the moment
> these fields are advertised to userspace, which is rather difficult to
> do for features that we don't even implement.
> 
> Please only advertise the fields known to KVM and leave the others
> unadvertised.

Thanks a lot for pointing this out. Now I get the point, for those not 
implemented feature, they should not writable, so they're not advertised 
to userspace.

> 
>>    - The BT, SSBS, CSV2_frac don't introduce any new registers which KVM
>>      doesn't know how to handle, they can be written without ill effect.
>>      So let them writable.
> 
> I think the handling of ARM_SMCCC_ARCH_WORKAROUND_2 needs to be updated
> to consider the presence of FEAT_SSBS in the guest's ID registers.
> Otherwise we'll wind up returning NOT_SUPPORTED and the guest will
> conclude it is in a vulnerable state.

I see that line of code, in the case ARM_SMCCC_ARCH_WORKAROUND_2:

if (cpus_have_final_cap(ARM64_SSBS))
	break;

I guess we should update it with something like

if (SYS_FIELD_GET(ID_AA64PFR1_EL1, SSBS, IDREG(kvm,
     SYS_ID_AA64PFR1_EL1)) != 0)

Oliver, Is there any proper function or macro implement the checking 
like above? I don't find the similar checking in the code.

Thanks,
Shaoqin

> 

-- 
Shaoqin


