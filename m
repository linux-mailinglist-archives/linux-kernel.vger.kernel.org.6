Return-Path: <linux-kernel+bounces-266633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29059403D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BED282229
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31606C2E3;
	Tue, 30 Jul 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYJYo6jw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0897944E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722303413; cv=none; b=LuPV9FYbLcz60WkVccnqm5SECZZWnB4bu4OVyV/DbGwn2wUechRTL5TAg0xOB9ZWezNXFLvbs1kTFHtpICG8RD+AZXmLVhKgpYhl43pppur3BSs+sqW0sioEMIGgd+wlXq3lu6sRTfdcidgsBN0c9swQfzPMBYzuprDs3bbkSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722303413; c=relaxed/simple;
	bh=rUFm6NnaIaVmwvkhJRUqaSkO4z0E6w1GYUQFwx5xLeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT5pAGDyD69il3WdMO0ceTuyyVs/PYyueRT/Ipot6/L4yiNT5CF5mCVUIDOIH69vxdcRE+gh66O1RfSKgw3mW5QzljqmKghMGnMq+ijIfm7pEVCgrfzSd/fW3OD/V1jW20txZFgxmtz6KxFVr6//coXmhkltcEeUfug1nVbXmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYJYo6jw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722303410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpLxUbenjvM5d5qBB7kCuthLr1OMeOtBCRFWHq7ibaU=;
	b=EYJYo6jwnWSccq6D5I2WoUlpuSdyUVTQKCE2CeZT6nXVAG/DqB7HS+VbLK+ygDeex8wR08
	0qq6cwSpDZl7BMFMfJgSW5stEQlK5cHK+TztHCvNK8yKFlw/7xJ4tgo8PUMKHQOSfNJ3Uv
	y5NuocMswI41yJFXKwJ8kIZUahWaBIQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-9yrHvZOAMKqglOPnJccTcQ-1; Mon, 29 Jul 2024 21:36:49 -0400
X-MC-Unique: 9yrHvZOAMKqglOPnJccTcQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fd72932d74so28788335ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722303408; x=1722908208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpLxUbenjvM5d5qBB7kCuthLr1OMeOtBCRFWHq7ibaU=;
        b=g3KkdxHkH4JE24HzDUQ6BCHLlL2ATM61+VIe0eDSqVTC4DytnzrfVxk1uIMbL3xumy
         1ds7qJR5euoQ+h2Gh6TbxVJNTs4/IfJ0pY60VlA1DaLl+S3ntXaQM+dAB763+eJyAztD
         jrvgz/JFHCRb6w5vTR7ykMjzfjxQ2+pz7ArtrPaRuL85EU68vrM1hFgFbTfBHoktBkVk
         amt0npUYxbbQfeUamULzeCOqXx5oWtciaMrHJBTZCUIxAP9kAZnXYEY4lCuGErozBxz5
         MbH4RQiPcgDh/iUsBcmNXeKTGhFrdsG9L3Ci7smG7j2dVYXfsdLMS9dvG49GJAGk5/Ie
         3h/g==
X-Forwarded-Encrypted: i=1; AJvYcCWwMls/uI0vc9gE9r4+mnvIB6UGuFty6+FUyh4Z+QHXE4A/kVQiUD8Grqvdn8QDDwBdclMhn0KgUtK9DJrMp2pZDsdYo8tc8DIGQIJ9
X-Gm-Message-State: AOJu0YwbPcLz7+fISl6ZZxmrilH6d35IF5ziHOsh2KkLkuxU8coNcdny
	P9c5AwlwBpBENH+okEy5qseZrXJme/uBjSwU3wqnqFNxuoY8PBNAsJmrRTb1udvgQwGxDhjjd2V
	QqhrHVJ0AlYySSqpdtFCiJNY7K7OEXKmr4PQYFpXKHsxSi5UBzNy/nWpgKU5nwA==
X-Received: by 2002:a17:902:f60d:b0:1fb:8245:fdeb with SMTP id d9443c01a7336-1ff048933edmr77628965ad.64.1722303408130;
        Mon, 29 Jul 2024 18:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPZMHMDXUZj1wSKwoNk+BDcdLLq2tHyZJH4+Sq/yqo8hZECliTBNIBT1SO3Bu0fym/xIh85g==
X-Received: by 2002:a17:902:f60d:b0:1fb:8245:fdeb with SMTP id d9443c01a7336-1ff048933edmr77628845ad.64.1722303407818;
        Mon, 29 Jul 2024 18:36:47 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff23ff5997sm28209945ad.267.2024.07.29.18.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 18:36:46 -0700 (PDT)
Message-ID: <b20b7e5b-95aa-4fdb-88a7-72f8aa3da8db@redhat.com>
Date: Tue, 30 Jul 2024 11:36:38 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] arm64: Mark all I/O as non-secure shared
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
References: <20240701095505.165383-1-steven.price@arm.com>
 <20240701095505.165383-6-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240701095505.165383-6-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 7:54 PM, Steven Price wrote:
> All I/O is by default considered non-secure for realms. As such
> mark them as shared with the host.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v3:
>   * Add PROT_NS_SHARED to FIXMAP_PAGE_IO rather than overriding
>     set_fixmap_io() with a custom function.
>   * Modify ioreamp_cache() to specify PROT_NS_SHARED too.
> ---
>   arch/arm64/include/asm/fixmap.h | 2 +-
>   arch/arm64/include/asm/io.h     | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 

I'm unable to understand this. Steven, could you please explain a bit how
PROT_NS_SHARED is turned to a shared (non-secure) mapping to hardware?
According to tf-rmm's implementation in tf-rmm/lib/s2tt/src/s2tt_pvt_defs.h,
a shared (non-secure) mapping is is identified by NS bit (bit#55). I find
difficulties how the NS bit is correlate with PROT_NS_SHARED. For example,
how the NS bit is set based on PROT_NS_SHARED.

> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 87e307804b99..f2c5e653562e 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -98,7 +98,7 @@ enum fixed_addresses {
>   #define FIXADDR_TOT_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
>   #define FIXADDR_TOT_START	(FIXADDR_TOP - FIXADDR_TOT_SIZE)
>   
> -#define FIXMAP_PAGE_IO     __pgprot(PROT_DEVICE_nGnRE)
> +#define FIXMAP_PAGE_IO     __pgprot(PROT_DEVICE_nGnRE | PROT_NS_SHARED)
>   
>   void __init early_fixmap_init(void);
>   
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 4ff0ae3f6d66..07fc1801c6ad 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -277,12 +277,12 @@ static inline void __const_iowrite64_copy(void __iomem *to, const void *from,
>   
>   #define ioremap_prot ioremap_prot
>   
> -#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
> +#define _PAGE_IOREMAP (PROT_DEVICE_nGnRE | PROT_NS_SHARED)
>   
>   #define ioremap_wc(addr, size)	\
> -	ioremap_prot((addr), (size), PROT_NORMAL_NC)
> +	ioremap_prot((addr), (size), (PROT_NORMAL_NC | PROT_NS_SHARED))
>   #define ioremap_np(addr, size)	\
> -	ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
> +	ioremap_prot((addr), (size), (PROT_DEVICE_nGnRnE | PROT_NS_SHARED))
>   
>   /*
>    * io{read,write}{16,32,64}be() macros
> @@ -303,7 +303,7 @@ static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
>   	if (pfn_is_map_memory(__phys_to_pfn(addr)))
>   		return (void __iomem *)__phys_to_virt(addr);
>   
> -	return ioremap_prot(addr, size, PROT_NORMAL);
> +	return ioremap_prot(addr, size, PROT_NORMAL | PROT_NS_SHARED);
>   }
>   
>   /*

Thanks,
Gavin


