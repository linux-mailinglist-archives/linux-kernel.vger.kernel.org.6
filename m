Return-Path: <linux-kernel+bounces-194216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB08D3882
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DA81F26102
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6D1C2AF;
	Wed, 29 May 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsSyNEeV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53431BDDB
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991135; cv=none; b=uYArv4aItOrqYp/UUekyv2OXom+EO7i/lQnq/bkHuNCF0SBL3EUGWdlTOLfHHDONGS1I0B+MEzVaUW2CjgPO8A77TmE897MFdBYzM5JHG/JUcFzju7OqftCVLZRc8kVQZWOUcrnv267eORxAXZ79cnLqDfPziY63xAe0s37xmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991135; c=relaxed/simple;
	bh=NhfLFKimMloJeZdUmF9DWPA/k6EIfjaMNnrCLXzufHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn2yadjMedDhri3zxRasPNp4kvHEWg/ttvc2PNV8E4iwxj223O8M3FqcMZWd2Yt9wXKTorEXu5V0iBLBJyyIj5XbO4Y3WkNu6vg/DHiF4NwWZ8dciPeXwxoP2sNaFP1ZlCHqfHLKtZrtcQRn+7S7wLevmxARjHcF1QRr9/8FviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsSyNEeV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716991132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBUt+81N76m8JjLowWjPyJ/0ry15liDoYiHfRlVMY7c=;
	b=fsSyNEeVUC8G0I3NuHfmpX1fky6cPz480rDEUSPOZ5jVRR0p1BzU0oAi6nOXRhaczlwCz4
	LDqUAh2lhRFAwV04a36Xm14lR1CfR/iWv2WeP5U/gmrL2ruJkza80TdJiqkl7uwNr1r5iq
	5Nre4DpHd+Os6sqXbrJgTYvycaeRcvs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-UEi-BLhVOFC5EjH-t6nUmw-1; Wed, 29 May 2024 09:58:50 -0400
X-MC-Unique: UEi-BLhVOFC5EjH-t6nUmw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab895670easo24418236d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991130; x=1717595930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBUt+81N76m8JjLowWjPyJ/0ry15liDoYiHfRlVMY7c=;
        b=WUk0S6IBSWHK0S6Izs9YZ5xvLZ1f57Uamrs/tZdEXUVdHp4e0PJstk24VB1asoZNK3
         xrETr9OlyhNILBagVMrBw2Geu5/svAka5Wcr0TlBfbPHUh58TwuuGCUZuhTXYKIpuvDD
         SWgsp1mmot84eoOW7DjQHf2/o74cRWCtp8rvUC+LDJZ0TO2hy33i4/4J2yBmQbq71Wb7
         rJSFLyRUBQvVJTCUf8XdjuJdii2lbO1laHxcrAdWWRcecMyvP6p2i+DiVY9xSdxnjeki
         2eYafA77xLBisie9dpcBbbSRMQO3/H3LlRTv0oowDQr7wMDNTRd5CTbNlmyFgIolD6Lc
         c5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVFAQ30x3Ea/ebVwEXG/ECZQ6OKk7zXgXn1/GyZXpaqSUi+q4MfL+RfGCvKK7Pw+3SURQ++hL+mZShOzX1cYo5BI1pNVaTs/jt60hpc
X-Gm-Message-State: AOJu0Yxlp0QH5V7ZznnLUHxX7iSzF9ldb7yevr6cErTcN3W7Bkmq9GRR
	s1rfv6Acn9tRhOvXxy7K5NXcL6iFU2cTqVEjdAE+Eiz3B3PYBjU8F3B8QhEA6b50j6xfsDj+IPI
	0RXvLyQr0Dmk+QgjtkZd6l8GQ1x+DAmAj70Rj4CpIb5l2KTannqiouTnSRwn6gg==
X-Received: by 2002:a05:6214:4805:b0:6ad:8f41:3ca6 with SMTP id 6a1803df08f44-6ad8f413d86mr70083026d6.12.1716991129890;
        Wed, 29 May 2024 06:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhaIWfEuFup0idzv7CTp9i0M0x4ZOM7kMRhbkvTSCSPbnBelYKtRYZKNIDRnw7041mRgi0jg==
X-Received: by 2002:a05:6214:4805:b0:6ad:8f41:3ca6 with SMTP id 6a1803df08f44-6ad8f413d86mr70082816d6.12.1716991129499;
        Wed, 29 May 2024 06:58:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad5b5da00csm51979476d6.92.2024.05.29.06.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:58:49 -0700 (PDT)
Message-ID: <b045f810-eb79-4de6-b149-0d64834d53d4@redhat.com>
Date: Wed, 29 May 2024 15:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] KVM: arm64: rename functions for invariant sys
 regs
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-6-sebott@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514072252.5657-6-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 5/14/24 09:22, Sebastian Ott wrote:
> Invariant system id registers are populated with host values
> at initialization time using their .reset function cb.
get_##reg call read_sysreg(). I don't really understand the above
sentence. Please could you elaborate?

Thanks

Eric
> 
> These are currently called get_* which is usually used by
> the functions implementing the .get_user callback.
> 
> Change their function names to reset_* to reflect what they
> are used for.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 1b6ab483e21e..bae72a4ce72b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3795,8 +3795,8 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
>   */
>  
>  #define FUNCTION_INVARIANT(reg)						\
> -	static u64 get_##reg(struct kvm_vcpu *v,			\
> -			      const struct sys_reg_desc *r)		\
> +	static u64 reset_##reg(struct kvm_vcpu *v,			\
> +			       const struct sys_reg_desc *r)		\
>  	{								\
>  		((struct sys_reg_desc *)r)->val = read_sysreg(reg);	\
>  		return ((struct sys_reg_desc *)r)->val;			\
> @@ -3808,9 +3808,9 @@ FUNCTION_INVARIANT(aidr_el1)
>  
>  /* ->val is filled in by kvm_sys_reg_table_init() */
>  static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
> -	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
> -	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
> -	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
> +	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr_el1 },
> +	{ SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
> +	{ SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
>  };
>  
>  static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)


