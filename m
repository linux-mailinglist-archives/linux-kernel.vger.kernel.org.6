Return-Path: <linux-kernel+bounces-530511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63706A43487
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5916847D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B77255E22;
	Tue, 25 Feb 2025 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhuMMqAd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A388494
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461094; cv=none; b=mhlslcDm5SA06P9KSyRupOOqPtdH1PY4oKJNtBUfaefImo+926kcKFTJaeGbFAEIa9fU3L2VOIAINmCqK68CFSCnAD5cbh3XouPOIN7mnHvbUb5d+/ufCQ6IcMfQg3y8w2LoZuE9/X+K61IW9lIRkEhEnYThTx1nK4vFgf4PmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461094; c=relaxed/simple;
	bh=guLry1pi1ZkTqZ2TiegNkCSc9mBc5/e/kWLfaBhIoRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRPbKpNJH6ziEc4+icWcwqyp3Lqyc6bq2I+77spWUhphVKr7soqfG8njCPkZqncIF9jmhhyemv5T3/oDZWxo5k7D/FMp845pYVJvm6Fc8dJe1zE0wlCLWjTQVZ9/JtgqcYS7C+8gF7kVrlBh2uSz31BfWhmaMPK6mXab1ygZp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhuMMqAd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740461090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euk2fmZv2LNbLice/Z0x6Rljhq6arGIlFTmkqCQAlc0=;
	b=GhuMMqAd15MJgLedDtIxTyNI/ZtB2C4i9YK6HXJf2ZybhYdLam+L4c02YAGwCmtZFdHv/l
	8u+1xvosKT1pj/s66h0x7Drcr5qh1UkpIOqxiNOZWpbX0FfXl08SqaTloBsWt3J6LIM8JG
	AkWu0LYy6XmNTAoPhqLgkyWvjv6t5Cg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-9uI2LMKcPfayw8BL8D27Bg-1; Tue, 25 Feb 2025 00:24:47 -0500
X-MC-Unique: 9uI2LMKcPfayw8BL8D27Bg-1
X-Mimecast-MFC-AGG-ID: 9uI2LMKcPfayw8BL8D27Bg_1740461087
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so14679865a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461087; x=1741065887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euk2fmZv2LNbLice/Z0x6Rljhq6arGIlFTmkqCQAlc0=;
        b=DIUYxcnMQVQaHvMHkL1GZHwhbZTUOkQmsyB7NZC77p6xKY4PzAat/HZSgm+UHdCuMD
         YEGu11/A9Z538F7YWn9r++ig2WxAP+BQOvM5Sdht1zEGG+5raOrkS2gLW1D4IvhWxPBg
         JPO4Nh2l0vhbm0bhQJpKhSCt2RYs0BSZOzaLNsIBpcnTsVzKn410nswto9fso3XmkRpL
         Vs/QuyJNhpBqUlokdH4A4eJWps+v1EAu8CjWiP9Pt0Un+58zN6+mcRHW6ROMfMdgsFuK
         pQ8gKxq3yEEaaHzvvZiKjg1d/X0BRGyc7L+ALiphWdpoiS7UnsnFP4QTaLWmI9r6JTpI
         6lfw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5+Kul3uXeDpcYcLeqzyr5z71pUMU1byYwh+u6+JxRa1Y1a5mcdlhNxFJLI1OjQzuzQiO/X2UXWyY8aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTUaSF8nh7B1iz1ffYLK7SAAM45oLK2V2D6C/TdKUbWNI+Qhb
	XvVrIv0YmthoLf+0gKfLb0Un4ubfAtEbAXi9I9q4Hf9BiDap/4ZNkh+18eStsC9Xox/m7u2gmYK
	LnJd39g8+LCeG+0Ja60+EAoPpsSOUZAN7DtsH5dRyT7i1TAsyH2fwGqn4MtJF2g==
X-Gm-Gg: ASbGnctZzbMAvjEnxSbCvBPkKVcr5oUULphX6SHhY3MCsr4XiL/QMmTeEhkBVhkTGnq
	z+fSwv993zcmO5OXzxl/isYkzOqa6o1OdBEzLrE+CEOxPDSZ3nUB+W/lNaFNYTuHrlfKw+KqCVe
	3g2JUsxwNUD07RYEKVI8T/2VzEN1M3dfxhXZVeMRlf8FYh1/RP0/Qm9kG4jEW0XlXieA2V933wt
	hfLW+QJxnk4cS+p+kNpw9kiM7FIURDu9RfpFIVsVJQU3JU/vzbwMtYBjYhQ/OEu1RJ0YCETBQd5
	9nTujcD7YxfxunRIwg==
X-Received: by 2002:a17:90b:3ece:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2fce8740b67mr26636368a91.29.1740461086795;
        Mon, 24 Feb 2025 21:24:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE629eSWp0iBQ+GwtWJD8yExk0rRA/MA5lHmZY3b0ZVr1mQchvCUVCRPoKdSpkAIzulYrLgmQ==
X-Received: by 2002:a17:90b:3ece:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2fce8740b67mr26636347a91.29.1740461086502;
        Mon, 24 Feb 2025 21:24:46 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb12dc27sm7652826a91.45.2025.02.24.21.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 21:24:45 -0800 (PST)
Message-ID: <c710a9d6-bd1b-4867-bdc9-b3a79e577d0e@redhat.com>
Date: Tue, 25 Feb 2025 15:24:38 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
To: Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
 robin.murphy@arm.com, catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-4-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250219220751.1276854-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Suzuki,

On 2/20/25 8:07 AM, Suzuki K Poulose wrote:
> When a device performs DMA to a shared buffer using physical addresses,
> (without Stage1 translation), the device must use the "{I}PA address" with the
> top bit set in Realm. This is to make sure that a trusted device will be able
> to write to shared buffers as well as the protected buffers. Thus, a Realm must
> always program the full address including the "protection" bit, like AMD SME
> encryption bits.
> 
> Enable this by providing arm64 specific dma_{encrypted,decrypted,clear_encryption}
> helpers for Realms. Please note that the VMM needs to similarly make sure that
> the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
> unprotected alias.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
> index f8f78f622dd2..aeda3bba255e 100644
> --- a/arch/arm64/include/asm/mem_encrypt.h
> +++ b/arch/arm64/include/asm/mem_encrypt.h
> @@ -21,4 +21,26 @@ static inline bool force_dma_unencrypted(struct device *dev)
>   	return is_realm_world();
>   }
>   
> +static inline dma_addr_t dma_decrypted(dma_addr_t daddr)
> +{
> +	if (is_realm_world())
> +		daddr |= prot_ns_shared;
> +	return daddr;
> +}
> +#define dma_decrypted dma_decrypted
> +

There is an existing macro (PROT_NS_SHARED), which is preferred to return
prot_ns_shared or 0 depending on the availability of the realm capability.
However, that macro needs to be improved a bit so that it can be used here.
We need to return 0UL to match with the type of prot_ns_shared (unsigned long)

-#define PROT_NS_SHARED         (is_realm_world() ? prot_ns_shared : 0)
+#define PROT_NS_SHARED         (is_realm_world() ? prot_ns_shared : 0UL)

After that, the chunk of code can be as below.

	return daddr | PROT_NS_SHARED;

> +static inline dma_addr_t dma_encrypted(dma_addr_t daddr)
> +{
> +	if (is_realm_world())
> +		daddr &= prot_ns_shared - 1;
> +	return daddr;
> +}
> +#define dma_encrypted dma_encrypted
> +

With PROT_NS_SHARED, it can become something like below. (PROT_NS_SHARED - 1)
is equivalent to -1UL, 'daddr & -1UL' should be fine since it does nothing.

	return daddr & (PROT_NS_SHARED - 1);

> +static inline dma_addr_t dma_clear_encryption(dma_addr_t daddr)
> +{
> +	return dma_encrypted(daddr);
> +}
> +#define dma_clear_encryption dma_clear_encryption
> +
>   #endif	/* __ASM_MEM_ENCRYPT_H */

Thanks,
Gavin


