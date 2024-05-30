Return-Path: <linux-kernel+bounces-195728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F08D50E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F404D283F20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482F45BF0;
	Thu, 30 May 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLUdF27X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274745949
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089661; cv=none; b=tNRy5ziE8NmvdMaU0JRGYkvMt8beaajUbYBAW9KovCxclGj50r5evBsrUX4VJ5vF+wJO2jXANqxzTOu3g79wZ5nRkK1bhE6WFRDA/cehW8YtPh3Fz5xn7PKlUb3UMIvB9LdVIqnk9jLHNKNo1Sib+VMDVyPxQOJO1N+CopAYN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089661; c=relaxed/simple;
	bh=Ab40fFziNTCR3bIRbRFkfjAS+VLoC1PKr4P45quh/K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6CuylEU7A0JlAuWtNd2k9Bi1uNtGU1YtI3BpLj0Dze3O49vVvwcw3+kqtGV1eL44Rge3ahQLhUs5L5U61D1v/44+PA1X9dh+T8qprZ/QZdrgCnoHjfutDbrpsRFrgp9WYvDxuSfkKOH3td1XS1A7lU9GDQxltjFw3Snzn2u+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLUdF27X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KuYwrlXvy2N8LV4iq+ZSNoKmsKOKbU0DyIuxTd5sy0=;
	b=VLUdF27XabqdqvanMzgimYCBz8kA5WKwBBZ0BpPj13rqNbHTC1ug2+yI39rWh+i0LSbXrS
	wRrTvlWY+Akfb/vJNnkrof5UYzEIVmFN7149qEm9cPiVfWiZc6udMCiOnbQewo7sX4KflA
	xqhobmE9c8KqK2HC6RHa5QntEor2MeQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-hWhbH8Q-Ox2OJZoEpe_A_g-1; Thu, 30 May 2024 13:20:57 -0400
X-MC-Unique: hWhbH8Q-Ox2OJZoEpe_A_g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-358f9dffbedso628359f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717089656; x=1717694456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KuYwrlXvy2N8LV4iq+ZSNoKmsKOKbU0DyIuxTd5sy0=;
        b=Vcd4QRohfYaOaf5D4+OqPB4fgmFQip90NWQbT6GNp05RCVyp/J9OvbWzKrILhGHxBm
         /rmZPvOmaUYChBXJK3BK01cj9avBLSN/19q7dy6hc1jSqycdO3xAnm3YeOwvPWL1lCQt
         JCIoqDWjm/ZeqQn65+fNU3lar4jL0iXaSMgYoQNw1lhSHAwJY2R6SG2Ze083pJin30UT
         6tqRWG9MHxlIxVMFgTaAU6slwzX/6x0QrmHCBGX5H+s0cvrTQxG3IRVho4CPj43FQXwO
         eTNeaVPFaf2Kzcu0YRDYPwdpJ0ablg3gkM1AULvazPe9jhymaeItNlbywkc33kNDjnRo
         y1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ70DQLHh1T5gcTakC7ePbDrQjQGam8ii+fF2YqfqrN1GDgOkvTAY7rgXaP/FZhOlL8JOZMwO/bSJYGoiaruJYjHxxAxpnCo+viJ25
X-Gm-Message-State: AOJu0YyOqDtmLOwAdoFsOyMK5YCSTmAxyIv4e2wS5EUZ7vFZn2sLXkxx
	+3qJqU6BP0tdV3OCEZ3yQiPBKTP7uctNQf/FF6/KsTANqYicxjfNdoXuV4k8HsJpxSTCRnujE9N
	lRO8J69ssn3zLl0zhcpwJXlL6ryl2zgX7qEIKLCSwpNt4jV382uwsiBbb0Ejfnw==
X-Received: by 2002:adf:ef50:0:b0:354:f44d:a020 with SMTP id ffacd0b85a97d-35dc00bf084mr2986437f8f.48.1717089655813;
        Thu, 30 May 2024 10:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBHht46/0aHH98H3F2Btkvz/+IBrdTIlSs6v8sQAHIKqk2hS+lTqMGvUepjWfHpzCCT8C1Fg==
X-Received: by 2002:adf:ef50:0:b0:354:f44d:a020 with SMTP id ffacd0b85a97d-35dc00bf084mr2986414f8f.48.1717089655287;
        Thu, 30 May 2024 10:20:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d94e6sm17916f8f.51.2024.05.30.10.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:20:54 -0700 (PDT)
Message-ID: <b8ecf0c6-b936-4c33-9bd5-1a0c4660ddce@redhat.com>
Date: Thu, 30 May 2024 19:20:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] KVM: arm64: add emulation for CTR_EL0 register
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-4-sebott@redhat.com>
 <312fd3cf-2eb9-4a38-8c50-e3b7639c3cbc@redhat.com>
 <c62a1fd5-54e6-4727-d457-1b2d19b0af35@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <c62a1fd5-54e6-4727-d457-1b2d19b0af35@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/30/24 14:56, Sebastian Ott wrote:
> Hej Eric,
> 
> On Wed, 29 May 2024, Eric Auger wrote:
>> On 5/14/24 09:22, Sebastian Ott wrote:
>>> +static int validate_clidr_el1(u64 clidr_el1, u64 ctr_el0)
>>> +{
>>> +    u64 idc = !CLIDR_LOC(clidr_el1) ||
>>> +          (!CLIDR_LOUIS(clidr_el1) && !CLIDR_LOUU(clidr_el1));
>> This actually computes:
>> CLIDR_EL1.LoC == 0b000 or (CLIDR_EL1.LoUIS == 0b000 &&
>> CLIDR_EL1.LoUU == 0b000)
>>
>> refering to ARM ARM
>> Terminology for Clean, Invalidate, and Clean and Invalidate instructions
>>
>> 1) If the LoC field value is 0x0, this means that no levels of cache
>> need to cleaned or invalidated
>> when cleaning or invalidating to the Point of Coherency.
>>
>> 2) If the LoUU field value is 0x0, this means that no levels of data
>> cache need to be cleaned or
>> invalidated when cleaning or invalidating to the Point of Unification.
>>
>> 3) If the LoUIS field value is 0x0, this means that no levels of data or
>> unified cache need to
>> cleaned or invalidated when cleaning or invalidating to the Point of
>> Unification for the Inner Shareable shareability domain.
>>
>> so to me if above computation is true this means who have no level of
>> cache to take care of, so although CTR_EL0.IDC = 0 would normally mean
>> you must "Data cache clean to the Point of Unification" that is not
>> needed in that case.
>>
>> But the spec does not really state that IDC=0 and
>> no_level_of_cache_to_clean_inv are incompatible as far as I see
> 
> This is just existing code moved to a helper..
agreed this comment/question is not related to your patch

> 
>>> +    if ((clidr_el1 & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) &&
>>> idc))> +        return -EINVAL;
>>
>> Isn't (clidr_el1 & CLIDR_EL1_RES0) already checked by
>>
>>        { SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
>>          .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
>>
> 
> Nope, that would only be the case when arm64_check_features()
> is used (by having set_id_reg() for the .set_user callback).
OK
> 
>>> +static int validate_cache_top(struct kvm_vcpu *vcpu, u64 ctr_el0)
>> s/top/topology?
> 
> Hm, that name is already quiet long.
yes but top does not mean much
> 
>>> +{
>>> +    const struct sys_reg_desc *clidr_el1;
>>> +    unsigned int i;
>>> +    int ret;
>>> +
>>> +    clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
>>> +    if (!clidr_el1)
>>> +        return -ENOENT;
>>> +
>>> +    ret = validate_clidr_el1(__vcpu_sys_reg(vcpu, clidr_el1->reg),
>>> ctr_el0);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (!vcpu->arch.ccsidr)
>>> +        return 0;
>>> +
>> worth to add a comment about what this does as this is not
>> straighforward ;-)
> 
> Hm, "check for validity of the cache topology" - that's kinda the
> functions name, so no added value. "Make sure the cache line size
> per level obeys the minimum cache line setting" - would this help?
> Can't think of smth else right now, sry. Suggestions?
yes the latter is fine to me
> 
>>> +    for (i = 0; i < CSSELR_MAX; i++) {
>>> +        if ((FIELD_GET(CCSIDR_EL1_LineSize, get_ccsidr(vcpu, i)) + 4)
>> maybe use a local variable such as log2_cache_bytes
>>> +            < __get_min_cache_line_size(ctr_el0, i & CSSELR_EL1_InD))
>> I don't get i & CSSELR_EL1_InD, please can you explain?
> 
> It flags the cache at this level as a data or instruction cache (see also
> get_ccsidr()).
OK I understand the principle now. thank you
> 
>>> +static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc
>>> *rd,
>>> +           u64 val)
>>> +{
>> don't you need to take the config_lock earlier as in set_id_reg()? isn't
>> it racy versus has_ran_once?
> 
> I was about to write that this is not the case since that's an rcu
> accessed pointer not guarded by the config lock but I confused this
> with the vcpu_has_run_once() .... again :-(
> 
> I'm not a 100% sure we really need that but I'll just move the lock up -
> it definitely doesn't hurt.
yup

Eric
> 
>>> +    u64 ctr = vcpu->kvm->arch.ctr_el0;
>>> +    u64 writable_mask = rd->val;
>>> +    int ret;
>>> +
>>> +    if (val == ctr)
>>> +        return 0;
>>> +
>>> +    if (kvm_vm_has_ran_once(vcpu->kvm))> +        return -EBUSY;> +
>>> +    if ((ctr & ~writable_mask) != (val & ~writable_mask))
>>> +        return -EINVAL;
>>> +
>>> +    if (((ctr & CTR_EL0_DIC_MASK) < (val & CTR_EL0_DIC_MASK)) ||
>>> +        ((ctr & CTR_EL0_IDC_MASK) < (val & CTR_EL0_IDC_MASK)) ||
>>> +        ((ctr & CTR_EL0_DminLine_MASK) < (val &
>>> CTR_EL0_DminLine_MASK)) ||
>>> +        ((ctr & CTR_EL0_IminLine_MASK) < (val &
>>> CTR_EL0_IminLine_MASK))) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    mutex_lock(&vcpu->kvm->arch.config_lock);
>>> +    ret = validate_cache_top(vcpu, val);
>>> +    if (ret) {
>>> +        mutex_unlock(&vcpu->kvm->arch.config_lock);
>>> +        return ret;
>> nit use a goto out
> 
> Thanks,
> Sebastian
> 


