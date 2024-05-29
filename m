Return-Path: <linux-kernel+bounces-194518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98BA8D3D78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA9B24C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566415CD49;
	Wed, 29 May 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFPj0PE5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D133C0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004140; cv=none; b=l104jBaQC/HWCZNNTcr5jujJfGe7wvOmNa3A/0LEQr35ivin9MeP/C7agDv/exLFv96QOpP8Xn4cYFHMF+qsuIwJmkdNYC4NBtPtE8WKwyWsYcjimgOTC6jatvo+rdUTDdoR8zR6EVSD8yvEPocEvetLcMqReAAhxDkdphe4UBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004140; c=relaxed/simple;
	bh=7qQLkzDYKjrcECLZwdp64idceuhEnjoqg60sDVOwDH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+WcuDqOofGB298OU8Tt/sb0n/NAUbx8AsR5+hg6PUq9L/dz19+Z5VYFJ3c+H8k/WcJtv8N3XSQpQDTxznYpbYywD2jLqJTStrvz+4J/BGqKgb9lVX7YOQMROWUoUMJQjHIMsS9RuRnIFuuSGxINHiHCDNupfWg0H8+LUvXnVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFPj0PE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717004137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGCd40WdtTorkfaaoKKX2Xm/h3qQtjnTG12sTYYmwaE=;
	b=hFPj0PE5zcx2PkkRdoS8Y9FO9JTyU+3C8M9UpsttWPOGbJLKnH9XNGfgK1A1Q0YpFJF1kH
	rbj3TwTbasBtGrIlHo8l9lC/2BJr+DmGGuzpCSXk5e3u4897Iik6NlgvlrMn6BrgnKmox7
	oOR2JgT45/PWtWYxx9s788khTajCtKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-QUqlM9_PP--WJfJQXz847A-1; Wed, 29 May 2024 13:35:36 -0400
X-MC-Unique: QUqlM9_PP--WJfJQXz847A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35507fa2570so1748211f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717004135; x=1717608935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGCd40WdtTorkfaaoKKX2Xm/h3qQtjnTG12sTYYmwaE=;
        b=nitCZd/EmZOMqA1he0ztMABUunZUCreX+QwQqQfVy0AOrOV7IBDN0uYNJTJ69JrQZO
         6FhoChSWYnEMJw23z0TtjOtrvbeKhV1HmGkRipO/rsEdRT8a5rC/Quu37vh+XXqdVpu2
         doAiYK/YOrWIP7Li9v8ApzdHx3A44KIGf8I6KMbVzIWdZ6pSSJXRX5jMdfMO/sr+CnR4
         tUyrLsfGRR/w6oYTt0bTfEcuLJWtADLsdkG9fuCwOZ0wToD2fk0259OdODqzN9pzAI/W
         Uazv+Xp6ngSzDjN/RbklvDKZmMEC/2q+tM7SKREgAm74qZpDpVnpOphQoVuG9fuYZYgg
         RJGw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ9w4BS4TdNGKDomi1tUE62naCeJ9ixG8uOcysTwfc9m4+o6OqUaxZ8mw6wx8eZV85Cw2J7lamSPx83Nh1/PLOkpk6UypIGwggjHa
X-Gm-Message-State: AOJu0YzY6f+XsmIPa7jaKXFvsc6RlYuPlp/6eXZWCxMyIy3349h2NBtZ
	w3eS/NKPg5JIv5cDSc3EpwXcME4XI3lfwd1qYaNevEUq8t1EcINPM34b+fvWP1LsHcaUkQAs2Oi
	i+Ieh0EcdhnhrHVNFcDqW0RH1pPwhRBn/7tK1ou7xN4KIJg5RqFRr4h26wRNHhQ==
X-Received: by 2002:a5d:6c65:0:b0:356:c47a:87d2 with SMTP id ffacd0b85a97d-356c47a8ab8mr10001458f8f.6.1717004135400;
        Wed, 29 May 2024 10:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaxx0+teEcXMNT49ZjEv4m21C3jeDxUtDLzJuChV8/uQgMeO+CZV4KNMcg8G2fe5Szs10sfA==
X-Received: by 2002:a5d:6c65:0:b0:356:c47a:87d2 with SMTP id ffacd0b85a97d-356c47a8ab8mr10001445f8f.6.1717004135016;
        Wed, 29 May 2024 10:35:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35b1d7a496asm5599092f8f.87.2024.05.29.10.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 10:35:34 -0700 (PDT)
Message-ID: <2dcfc174-9384-4746-833d-1442bcfb6d11@redhat.com>
Date: Wed, 29 May 2024 19:35:33 +0200
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
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <90e53cc7-039f-5abc-f94c-cf53a1602a2a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/29/24 17:51, Sebastian Ott wrote:
> Hej Eric,
> 
> On Wed, 29 May 2024, Eric Auger wrote:
>>>  static int set_clidr(struct kvm_vcpu *vcpu, const struct
>>> sys_reg_desc *rd,
>>>                u64 val)
>>>  {
>>> -    u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
>>>      u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) &&
>>> !CLIDR_LOUU(val));
>>> +    u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
>>>
>>>      if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
>>>          return -EINVAL;
>> nit: you may update the function doc comment which the extra handling of
>> CTR_EL0.
> 
> Hm, there's no extra handling of CTR_EL0 it just uses the emulated value.>
>>> @@ -3557,6 +3557,13 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>>>      struct kvm *kvm = vcpu->kvm;
>>>      unsigned long i;
>>>
>>> +    if (!kvm_vcpu_initialized(vcpu))
>> at this stage of the reading, why is the above check needed?
> 
> To make sure that a later call to this function doesn't overwrite
> the value provided by userspace. (See e016333745c "KVM: arm64: Only
> reset vCPU-scoped feature ID regs once").
but isn't it overwritten through the .reset=reset_ctr() that is
populated in next patch?

Eric
> 
> Sebastian
> 


