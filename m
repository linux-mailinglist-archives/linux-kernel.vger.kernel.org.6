Return-Path: <linux-kernel+bounces-530512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4EBA4348A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4606172023
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F38254AF6;
	Tue, 25 Feb 2025 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE26V3mf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB223322A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461317; cv=none; b=mCOJq3c1bYRqZR89acXPej/WIysqQtHvrSNS3sGKSzzNXOZPIRoXJMBNyR4R/MH64I1GGS3ayeywE3uKKEUIa9snkBz8x+Er+J4Hd2JySpenNcCbNj1Uv9gJbcJ9cxsKrrZZYkWXS9/90X1T6OGvoSu30o104aLLDb+eGP3wGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461317; c=relaxed/simple;
	bh=d0pNxPyFO+IzMKyIpFDsBRs3vBA1pbmFQp0icnqlUD0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HMaIKJxaH1A1vfHJ+bd+8aGbNSsKhDhA3WdflyU+V1bCLH5R7wZzPLQrA/S6okYOhpfqWKzuEeb8RvJHgeesrYV4cC6AJRsGbB6acY7fMJOlADSjglJMMKBvSBY58mdNxLERw8sBAEiNpJR5osEmWEndTB/bFsGXx5l6+IY179E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KE26V3mf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740461314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NUjSEYdYicw0eBxTkoq1tdaPZmsum3sTHbVvspj4iI=;
	b=KE26V3mffyNeGagP4e/WL84f5DiNbSIBFth83YDWjS2AEzA2dxxsfFa9pbdmJ6cpu2znuY
	r/LnbmhZ434eign4Zwt7ddu1Jru+ZIpp41q+c//Iwq3AwsJbJSGx//3iqQXSCrNwaHyvz2
	srid+AiD0mlX9724YTlMzLZmU6rrsQc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-22xNRPGSPGuAPNz2gE9sag-1; Tue, 25 Feb 2025 00:28:32 -0500
X-MC-Unique: 22xNRPGSPGuAPNz2gE9sag-1
X-Mimecast-MFC-AGG-ID: 22xNRPGSPGuAPNz2gE9sag_1740461311
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220bf94cb40so80228135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461311; x=1741066111;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NUjSEYdYicw0eBxTkoq1tdaPZmsum3sTHbVvspj4iI=;
        b=vDKu5MM/X5Il+c3kIbgitv/tLTCQRrMTWNDqvX1lLssk5hLK6LTjxo7gdl9J7rj1gm
         QyAGNACnkAcUUYPlACdVi1hnz45qnzp6n2TVwHU8ZZybSeMJ2dniYusp99rgKZL51YWf
         XirnTwfUh7HRKMVfukMqxabEz3WtbZnQZAKfuVYvPKroODVLguls5Wy9Z4G335jVwNf+
         Y9zdQjSMppY4ykqlRa3qLhkD9bNmD37KVW9eWOb+y8hZb3bcvhWDlfS8MFPKRejHHC9H
         434IshD8I5eWJXn5xuZ+jzOXTryW2waOoCSxJKiXJxQlfqW1AoFeOVifaNNQaLh/Hper
         s7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2aIQCE6BpeHvXo/jkZQ+Xx8bbGarF2YgEx7+hfwjNB/tXPJ/KqTOdGr7N5vFdmxjdKdjedVqEtYh8DD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNdkP+3CeYGrg6bivfq8vAoiMtRkiH4Z0pHxnkASpgOyoeE0B
	/LuBwAmXPnnBV6vnnwcZo6FlhSSd4XKQrbc8LB6w27DFKwZmHM6mIwvVXWIU5XJOFDdNiIpoYdO
	rcnbQJggkj27CVfPh4isPk81/D3uHCqzbc4uZvWT14BUX4xTp0NmIXxL2BW0Wxg==
X-Gm-Gg: ASbGncsiJ/ZZyuMBl4ktGw6iFkBCT6924/f/jvWSqN7totLYWTx3rxajpHT/kgVsoFJ
	P6DdNkeSoB3jz2rRsJKZt3Yeh0+GpAUhCv9Nk4acg+FSMy4ZpsIrmzSW10d0uDxz4X+m1ZDK8MB
	nnoXqXF73XzbN3yTKyjqppSxC7ZADVBxKfyaCydxMN5UPhZwTpbPyyz2fVD+CMYnePYBRax7fdi
	XL6+c9nb5jnLMWRS+SSPYxPRdL9dVBtaV4C64mF3wgMkSihGW4iLcLiuEgp4VTcAPF1pWB6XjQ5
	OU8pIJKRnpXkgNNSHg==
X-Received: by 2002:a17:902:d4d0:b0:21f:8453:7484 with SMTP id d9443c01a7336-2219ff61d6fmr262644025ad.30.1740461311414;
        Mon, 24 Feb 2025 21:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWEKWTJ+abF91IxGYeto7bQIpOErHP0Z2jKXfqBhYv9SfzPfkcFZPuQ+Nc/9Vvo9lQFQO3wg==
X-Received: by 2002:a17:902:d4d0:b0:21f:8453:7484 with SMTP id d9443c01a7336-2219ff61d6fmr262643665ad.30.1740461311082;
        Mon, 24 Feb 2025 21:28:31 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a798asm5232455ad.189.2025.02.24.21.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 21:28:30 -0800 (PST)
Message-ID: <308f8a08-a6f8-403e-a130-18c7d3db2e23@redhat.com>
Date: Tue, 25 Feb 2025 15:28:24 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
From: Gavin Shan <gshan@redhat.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
 robin.murphy@arm.com, catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-4-suzuki.poulose@arm.com>
 <c710a9d6-bd1b-4867-bdc9-b3a79e577d0e@redhat.com>
Content-Language: en-US
In-Reply-To: <c710a9d6-bd1b-4867-bdc9-b3a79e577d0e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/25 3:24 PM, Gavin Shan wrote: 
> On 2/20/25 8:07 AM, Suzuki K Poulose wrote:
>> When a device performs DMA to a shared buffer using physical addresses,
>> (without Stage1 translation), the device must use the "{I}PA address" with the
>> top bit set in Realm. This is to make sure that a trusted device will be able
>> to write to shared buffers as well as the protected buffers. Thus, a Realm must
>> always program the full address including the "protection" bit, like AMD SME
>> encryption bits.
>>
>> Enable this by providing arm64 specific dma_{encrypted,decrypted,clear_encryption}
>> helpers for Realms. Please note that the VMM needs to similarly make sure that
>> the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
>> unprotected alias.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
>> index f8f78f622dd2..aeda3bba255e 100644
>> --- a/arch/arm64/include/asm/mem_encrypt.h
>> +++ b/arch/arm64/include/asm/mem_encrypt.h
>> @@ -21,4 +21,26 @@ static inline bool force_dma_unencrypted(struct device *dev)
>>       return is_realm_world();
>>   }
>> +static inline dma_addr_t dma_decrypted(dma_addr_t daddr)
>> +{
>> +    if (is_realm_world())
>> +        daddr |= prot_ns_shared;
>> +    return daddr;
>> +}
>> +#define dma_decrypted dma_decrypted
>> +
> 
> There is an existing macro (PROT_NS_SHARED), which is preferred to return
> prot_ns_shared or 0 depending on the availability of the realm capability.
> However, that macro needs to be improved a bit so that it can be used here.
> We need to return 0UL to match with the type of prot_ns_shared (unsigned long)
> 
> -#define PROT_NS_SHARED         (is_realm_world() ? prot_ns_shared : 0)
> +#define PROT_NS_SHARED         (is_realm_world() ? prot_ns_shared : 0UL)
> 
> After that, the chunk of code can be as below.
> 
>      return daddr | PROT_NS_SHARED;
> 
>> +static inline dma_addr_t dma_encrypted(dma_addr_t daddr)
>> +{
>> +    if (is_realm_world())
>> +        daddr &= prot_ns_shared - 1;
>> +    return daddr;
>> +}
>> +#define dma_encrypted dma_encrypted
>> +
> 
> With PROT_NS_SHARED, it can become something like below. (PROT_NS_SHARED - 1)
> is equivalent to -1UL, 'daddr & -1UL' should be fine since it does nothing.
> 

I meant (PROT_NS_SHARED - 1) is equivalent to -1UL when no realm capability
is around :)

>      return daddr & (PROT_NS_SHARED - 1);
> 
>> +static inline dma_addr_t dma_clear_encryption(dma_addr_t daddr)
>> +{
>> +    return dma_encrypted(daddr);
>> +}
>> +#define dma_clear_encryption dma_clear_encryption
>> +
>>   #endif    /* __ASM_MEM_ENCRYPT_H */

Thanks,
Gavin


