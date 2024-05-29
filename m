Return-Path: <linux-kernel+bounces-194388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB538D3B69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CC1C2244F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D10181CF7;
	Wed, 29 May 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsMm92V+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28F181B9D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997867; cv=none; b=AViuLndmwSIG+yqypHMOUFtqTNuJWiIE/Afp8BENzl3wOGW/1eDnY/lLbNZRWKwxRTh5y6uKjSH+X9y9A5Atikt1lQFgfKEmNUp3TbtuJV5A+3wqOmd1VmTex42ubbUMSbUqJ0NeskZqc6OUxxNWz/DugJAt7KAEfYADrkqssAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997867; c=relaxed/simple;
	bh=nPh/k750oWFllKMqo44WmSkl8MopO1VSvwnk7Titii8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b6ledbN9Q49g4mU1FJnrZ5lLNpPVTdLxgnPD0Bv5nDwaly2uubuXYLx/9WOmynhwU7BA9RUp7ampxOyJCZY0R1OE/9fOeuoLc5WDKNj7zdxGtAnWjkp1oHyZLo0WKTPCg+y2/HHTUyKTiG3poaac+sL5wVREUPD72FUNZ8SWge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsMm92V+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716997865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wj1aC4UtCyPUM4QTC8xzhgQZJugAFw5/FZACWc0ZVRo=;
	b=YsMm92V+hZG3ZXTbisjAsykub4E/PsNiXP7FM4e1N/HLIIj8SaquO2FWHi+7X37+Y/tsL7
	1WtXIK+J4WTnrDRWVbfJD2wZPEXOfb4Y8LMbQCwPSJRr+goahqRllo3i9G5iYq3er6nHAt
	I4GrhvMMDQqstSCFZL6/P5HzsrwElg0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-5-ZFWizYPKCQXy2u-HOhCw-1; Wed, 29 May 2024 11:51:03 -0400
X-MC-Unique: 5-ZFWizYPKCQXy2u-HOhCw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42111702b3bso16656905e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997862; x=1717602662;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj1aC4UtCyPUM4QTC8xzhgQZJugAFw5/FZACWc0ZVRo=;
        b=MlJSYZj0wVN1VrvljsqLtuM18XHiUJ7daRfnHajlqujNPG5Tx4x8NEF0MlkERK5ir/
         DAYel3DrvOEI1bBLmvyIhqb+Fo8DatX6C3hqpw+JS5Xd081FiD4byVht2Fy/AMesGlcm
         sBKO5YldrFNi2uNU9Zjw1UBdsq5s0/Mb6RjrCa0jEMPRjtKBj0F/zdZB2woAstoWmyIb
         5dZi0VJxRLQIVKw80pX0cThKWY0dTFvkx1/biSW0KyERMq6ei03YniPMWntS5cQpARpZ
         gTINbw9PrTvGUKao3gB5R6S35CYfZCTyZYB99HcDENP9c6lDnHfwc6n/mefbjxM4Qxre
         y7TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW42upUjxF+gQbsLzQ00Ixx0biji4Dh6F9n5soIRNRJ34riesv4BTX4pJFsVFDLaens07JdIGElBreDXM0uXzc6Lu96OpqRddNU5X+
X-Gm-Message-State: AOJu0YyHfV7CNqv58Yu8PNmW9UMMwVhbLydKL7XdIGbCuJ/MfCJ69Hc9
	4WzX+yjIMIfwol+lTWYTMwHnE7Hk89iLyR7RW3BdCCSzBT1NE2CxuIw+rGsfh9RUr2qmzwInXmF
	dAffTSm19XhKgZ+rfS4QPz3oo9ay0UShszP/ta6JhH30daSsG4a4tEctORK1JCg==
X-Received: by 2002:a05:600c:4506:b0:421:205f:52de with SMTP id 5b1f17b1804b1-421205f543bmr41308805e9.26.1716997862739;
        Wed, 29 May 2024 08:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnxWP0k/VdlV2yzLTOufK9dfVKQxMD5gYEbM+NMCUK0CifwlvRGzVwfVWIWgQnenP9G0xAbw==
X-Received: by 2002:a05:600c:4506:b0:421:205f:52de with SMTP id 5b1f17b1804b1-421205f543bmr41308605e9.26.1716997862342;
        Wed, 29 May 2024 08:51:02 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f14436sm216520275e9.17.2024.05.29.08.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:51:02 -0700 (PDT)
Date: Wed, 29 May 2024 17:51:01 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/6] KVM: arm64: maintain per VM value for CTR_EL0
In-Reply-To: <edbe3039-ed42-432e-8309-5a0a46cc2d5c@redhat.com>
Message-ID: <90e53cc7-039f-5abc-f94c-cf53a1602a2a@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com> <20240514072252.5657-3-sebott@redhat.com> <edbe3039-ed42-432e-8309-5a0a46cc2d5c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hej Eric,

On Wed, 29 May 2024, Eric Auger wrote:
>>  static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>>  		      u64 val)
>>  {
>> -	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
>>  	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
>> +	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
>>
>>  	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
>>  		return -EINVAL;
> nit: you may update the function doc comment which the extra handling of
> CTR_EL0.

Hm, there's no extra handling of CTR_EL0 it just uses the emulated value.

>> @@ -3557,6 +3557,13 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>>  	struct kvm *kvm = vcpu->kvm;
>>  	unsigned long i;
>>
>> +	if (!kvm_vcpu_initialized(vcpu))
> at this stage of the reading, why is the above check needed?

To make sure that a later call to this function doesn't overwrite
the value provided by userspace. (See e016333745c "KVM: arm64: Only
reset vCPU-scoped feature ID regs once").

Sebastian


