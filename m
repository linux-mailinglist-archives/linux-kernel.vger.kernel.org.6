Return-Path: <linux-kernel+bounces-322380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F897282D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D8D1C214DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD317F4F7;
	Tue, 10 Sep 2024 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqWdq0/S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B119067C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941756; cv=none; b=DYJdtGpquevUZBGq7qlBVDqFLnGpqLE+ivJpYIO63xawOMYx6/hPCQBVr7aU2wupz+AdFltxXm6wsE7HVJFCWNu+pgnS0RX1ibhSjXDIPrZ1EZj9kCE5TTKjnRXfGMB1QyY0PGGTHG1yDuXC0HKM9AkVvxyUJ5CfuPNT2O+Cw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941756; c=relaxed/simple;
	bh=gkZzcVeOY1zKE6Oa+cxE4jiLx/E16ZR2j2sfe3+e4vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THK3C5hKdyOEt2jtNE8dJe26LuEYByDXOhY8FaZGEcnwrlEKJD0sdtv0x4xTtlJ0DOOqynMT/HfvlA5nZ6RmgX83c7gT7U2vTYJC3dfTE4c9r9idiqKRkAWYMfacSAtj4WggJ9VUE6x6nFd1PMA1efmdzSo+Svikj07ubBOwe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqWdq0/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725941752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/+FRQQ8Ru8+M5tm0CToElnSS7luR16tiIP4Dg8B3y8=;
	b=dqWdq0/SMJnTpdZNVVG3YYLM2yKiE4Uujv0Lx7TJsxW/Fj+Gx0FVNPzeKjZ39nGzzRt8WT
	Fr5S/rO9ITSDEzjFAPYaDFTlpMPUfFdw50rP12VtlE79Pocor+PBug2qT1R8IqwQHqye9W
	W5PdGKvODRrTM7YCml59ZwQvg8tl9ug=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-zuihsF1gOSO-F53_nGSmQQ-1; Tue, 10 Sep 2024 00:15:50 -0400
X-MC-Unique: zuihsF1gOSO-F53_nGSmQQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2056364914eso66461395ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941749; x=1726546549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/+FRQQ8Ru8+M5tm0CToElnSS7luR16tiIP4Dg8B3y8=;
        b=kRUs5V/y4o4Hf9YNC6TivZxxeSF3b4eiCy5F8atNXzhJcH3fJq88glDxS2q0epMjcL
         rWqfqGAIOzAjXjU8RAIExN4XMR43AGibOE4Vv8By+F7YT3GnMEpUGGvRSEa0zk9CmKy9
         uRlJRqaTVrKAGZmqdsOaJ4aID5vZU31cu+MxNiav569kd6AQvvxGQTTkajYA4RMMY27Q
         cndFtLElJVnWJwtBiC1JNuHmGTNj0m5wrNeO5Lc1//zlMvijsCkVJ1erfAsds0TyAiTT
         z/SooUOHQmUlzAN0NOQxH3xzP4BhcJaQBGSepW1Ofdc7aWtE6EluZimKiMdGlyFL/HIz
         C2yw==
X-Forwarded-Encrypted: i=1; AJvYcCVzNwihfhm/1AvW9QtmWmNXaIaaL4A3N/f9Vw6PFszyCRBAF3yDk3ckTL/31v3Rh2W9I/BjdrT5sF4XqKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcq5b9MNlpjRWoiC5ba7BPBK/+s5GmAxErC1tFQcn53er0mLq
	0nMc8ySah0EuB7KlOzrrlAgCe8ptSEufcsJRQ6869pUMobpfXLuFDSOtNxMFSS+jRzG1DnVZd7w
	iP9DHCfTHK73hvwfVT3t3PgeKJF22r8AyCejRXWBB3F3xyQv34Kbr0pOvXNtS3Q==
X-Received: by 2002:a17:902:f549:b0:202:5af:47fc with SMTP id d9443c01a7336-206f0511f66mr213103645ad.13.1725941749239;
        Mon, 09 Sep 2024 21:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESpzFJPvUaYPPTKHz8T4YHLbc03zqgmBJU6sgzN1/EtRPQmV6cfuytRj9V1iBRvh9wsUVF0g==
X-Received: by 2002:a17:902:f549:b0:202:5af:47fc with SMTP id d9443c01a7336-206f0511f66mr213103255ad.13.1725941748534;
        Mon, 09 Sep 2024 21:15:48 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e0efbesm40682855ad.40.2024.09.09.21.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 21:15:48 -0700 (PDT)
Message-ID: <29016e56-e632-422d-a4d2-1891fad2c565@redhat.com>
Date: Tue, 10 Sep 2024 14:15:39 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/19] efi: arm64: Map Device with Prot Shared
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
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>
References: <20240819131924.372366-1-steven.price@arm.com>
 <20240819131924.372366-13-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240819131924.372366-13-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 11:19 PM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Device mappings need to be emualted by the VMM so must be mapped shared
> with the host.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v4:
>   * Reworked to use arm64_is_iomem_private() to decide whether the memory
>     needs to be decrypted or not.
> ---
>   arch/arm64/kernel/efi.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 712718aed5dd..95f8e8bf07f8 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -34,8 +34,16 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
>   	u64 attr = md->attribute;
>   	u32 type = md->type;
>   
> -	if (type == EFI_MEMORY_MAPPED_IO)
> -		return PROT_DEVICE_nGnRE;
> +	if (type == EFI_MEMORY_MAPPED_IO) {
> +		pgprot_t prot = __pgprot(PROT_DEVICE_nGnRE);
> +
> +		if (arm64_is_iomem_private(md->phys_addr,
> +					   md->num_pages << EFI_PAGE_SHIFT))
> +			prot = pgprot_encrypted(prot);
> +		else
> +			prot = pgprot_decrypted(prot);
> +		return pgprot_val(prot);
> +	}
>   

Question: the second parameter (@size) passed to arm64_is_iomem_private() covers the
whole region. In [PATCH v5 10/19] arm64: Override set_fixmap_io, the size has been
truncated to the granule size (4KB). They look inconsistent and I don't understand
the reason.

Thanks,
Gavin


