Return-Path: <linux-kernel+bounces-195350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1438D4B62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B1B240CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661541C8FA7;
	Thu, 30 May 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoAwMDxV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6E1C0DE6
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071463; cv=none; b=TEJ2XIz4KQb4URymOv9RyzqHLSwVXNfZSEmpAiE9aseBGg+mHp/3EBwlcLwK0XhBBAVO5wo19XQDa753fXfQYoWEpH8fLTwYjenFeRFvRiM9nmm/2zXoC+8YUjEgbAGNbzcpdkK1jR3tzN353y70rlGiG95bf5Kbhmjh322tDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071463; c=relaxed/simple;
	bh=V5hI7KMkzgVk/ALuPDZUKKRsX7oat0m5/GaY+dT+YqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIMq4a53N3sNnB0qhWZJatcBdL6DrVW6bvc21/zvfWTgJKvMO9miwnftrvYAnDsABh7x/RHgwv3xCnofXfpIzeRBB7pW3/x1IMxBbAPVneJyqTQ0/iv30+uXk7OTCnEm8Hzr41OuaTsZoUP0wI7lhAFLIZEDJgqnKmFIWR8S8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoAwMDxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717071460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMT67zC+fbo2iQB9ZfpmsekE+SDPWB6XReNKWdjTg/c=;
	b=LoAwMDxVHuQKj/WF4jyOSj/tx2lnxHbSKNZT0LpG5s9N1EiAeaBjln1b4wsQlZvraXCwhx
	9X9vMLJQ45ZOSNG+OvBSb7FdaR+Y/wf79kRCymuJguZwMwdo8CwIKAtIHAquEIaD/Agd8I
	8l0Fiwbvh8zaf1o1GfDy2BbOOaNowxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-E5N7WMQENl2LN2lpIVVX-A-1; Thu, 30 May 2024 08:17:37 -0400
X-MC-Unique: E5N7WMQENl2LN2lpIVVX-A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcbb5c163so284336f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071456; x=1717676256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMT67zC+fbo2iQB9ZfpmsekE+SDPWB6XReNKWdjTg/c=;
        b=wOGHtgjSQvb5PhE86RYqDoKSu6fEqcNqYclVg3SxGJPBWOQsoPxHlv2S7N3rKr7weP
         x6kONSY5vpGr4Ib/v/XYClRwG0kh4sxXvqxUOzJj1zUR4iduTN3YDKz3bUy1J5Vx0bZR
         EKMaymdN3GfovNQXu6o7BNQQfZ2AUiGHFinN6l+Aq4aWAWp4C/qIOhK29vT0ylr/pD5z
         PqzXsVjXcD2f3Cg7ta1muRrRZyEh0onCUgNS192hmaXYdFy6IM4Uzo2ADwKVBzqsPEBL
         TUJLb8ge02lvUIKuT9KHEVsXR1iUuE8duSAJsV+0IM1m+qw4rtNCT+53idzpib4RXlmO
         VFKw==
X-Forwarded-Encrypted: i=1; AJvYcCURWJ5cmkWFxLPm4N6+SELJorpZs3Vt2DDs5BgkICOXwCV6OxFSpj4dxv69hqIbpZtX8KtN14fsnP50hlVsneO/V+Xt7+D0Y/BVzpIM
X-Gm-Message-State: AOJu0YwFuIKttrjgmR+RcC5siDzd+4FiK3iFGUxU6NuiffCOvelbaz86
	0WXUmSMddnV+s8LAvoux6wBCxdY+i+i+A3ozhJ7Y8Z69N2NTQGuxWmhqb7JXWLI+rkC3DWng4JZ
	aXsJAO5sA+VuQV4hEB5wd05wKjaKf9Henk+J/dPx1AHfNBsOR1K5r9u3Dk+9R9Q==
X-Received: by 2002:adf:f989:0:b0:354:f90c:63dd with SMTP id ffacd0b85a97d-35dc00369c3mr1370856f8f.0.1717071456028;
        Thu, 30 May 2024 05:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCeaFufh+CD65vlqUrpverwcUO7ViCXf3RbM0I0lK+Q3pHJBTo8PrCVYwi3ANZO5WJqWE20A==
X-Received: by 2002:adf:f989:0:b0:354:f90c:63dd with SMTP id ffacd0b85a97d-35dc00369c3mr1370836f8f.0.1717071455558;
        Thu, 30 May 2024 05:17:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dca3dbee6sm1356852f8f.53.2024.05.30.05.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 05:17:35 -0700 (PDT)
Message-ID: <897ea2fa-838a-4b33-8434-dba5dddaf9ca@redhat.com>
Date: Thu, 30 May 2024 14:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] KVM: arm64: maintain per VM value for CTR_EL0
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-3-sebott@redhat.com>
 <edbe3039-ed42-432e-8309-5a0a46cc2d5c@redhat.com>
 <90e53cc7-039f-5abc-f94c-cf53a1602a2a@redhat.com>
 <2dcfc174-9384-4746-833d-1442bcfb6d11@redhat.com>
 <a0295969-eff9-5330-cd1f-1e41b8f43eee@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <a0295969-eff9-5330-cd1f-1e41b8f43eee@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/30/24 13:24, Sebastian Ott wrote:
> On Wed, 29 May 2024, Eric Auger wrote:
>> On 5/29/24 17:51, Sebastian Ott wrote:
>>> On Wed, 29 May 2024, Eric Auger wrote:
>>>>> @@ -3557,6 +3557,13 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>>>>>      struct kvm *kvm = vcpu->kvm;
>>>>>      unsigned long i;
>>>>>
>>>>> +    if (!kvm_vcpu_initialized(vcpu))
>>>> at this stage of the reading, why is the above check needed?
>>>
>>> To make sure that a later call to this function doesn't overwrite
>>> the value provided by userspace. (See e016333745c "KVM: arm64: Only
>>> reset vCPU-scoped feature ID regs once").
>> but isn't it overwritten through the .reset=reset_ctr() that is
>> populated in next patch?
> 
> No, this is done via reset_vcpu_ftr_id_reg() and also guarded by
> kvm_vcpu_initialized().

OK thanks.

Eric
> 
> Sebastian


