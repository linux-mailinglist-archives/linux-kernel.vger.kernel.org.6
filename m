Return-Path: <linux-kernel+bounces-543285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8569A4D3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BA01741EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5D1F4CA2;
	Tue,  4 Mar 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aokssfSO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE31DC985
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069452; cv=none; b=S61Gq8JMQ6KmsA6CwOUy9MOfKsrYbx2OSQrnfMAnwvt4p29QQ1+s43wt6SPZdJP0DlI5lCnYiHm1BkcRbdojhbXLbIWyt1enuAMCUpI57XB0I0awLdf4J+SkvWHwZv+ocKLp2F6+KAZSVdoFujnCzUpc6i0fp3shYDR+ccfBTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069452; c=relaxed/simple;
	bh=0EYT/5igMmD/qVvWdRKvGmdh6E8JzSaWldlA7WO1ROk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBW80hBuwbqGq5qmowpF/a3av6m+cpSIs3jvyWkLiO9s+mx/LwS5ucvypAkCQ2OJbKX2e6WVQZZbv1BSf2JSuLy6WxY6ez5JU7rBMRjmjdtpWM1s9w4bkx0ZqGLLVuo1v+hfzTzIayeBEMNPLf2l/U/0gGKaKHDU+5stTddrks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aokssfSO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741069449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUEeo/X+MxYcAZNwznFspnaWG5EWN4eG0J5QKgSy/vw=;
	b=aokssfSOvKmke0T87hntyfHK3AmKw+NtyhFcefPs9f5VPCbKuFQAn8QANBoCPhNNRb4hVJ
	ba/l/9b/Q2Vr/H0kgyaL+r1LCCcWTscVSefEbqvEODAHU+3AXAUvTux2lf1cz19godp9su
	3Bm01ZAW8+jEKSkQXssuRqD5Jq/LjQA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-euzlK5AsNwG0FdxBfg26Tw-1; Tue, 04 Mar 2025 01:24:02 -0500
X-MC-Unique: euzlK5AsNwG0FdxBfg26Tw-1
X-Mimecast-MFC-AGG-ID: euzlK5AsNwG0FdxBfg26Tw_1741069441
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22350e4b7baso92796655ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069441; x=1741674241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUEeo/X+MxYcAZNwznFspnaWG5EWN4eG0J5QKgSy/vw=;
        b=WFnX2vRAr6XprI3o5dxncktEy93Hezbvpejp1uXcYLwAj12nJOXXGC8jQhaXYsvz0p
         wY1ka1oUX0xJrrVVWaOlaNErkw3VI3IBzJ4RIdYeSMzakKQg0AleoYaealafhq80K8uy
         5cCBCjoDLWdRc/W3JF8NITi69Aqy4pdfGmVhroiG27szgszOh2LrjJTMQN6tJe7hM9Ty
         3gAWm6NbSgyLKHtxHo6xKD39q/txMX21znAK3APzotR2idnHx0/6mjaL2ICz1FLGqlk8
         DJIAoeTbGUuAMQmvkPA0ThGeyPFViC+PvL6fIfNlFo/0N1/Gd5hXA1ZP4i/sAIrC7pLf
         sAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVz3H7b6hpg8l/WY4AamypKmzSCVfok7F/RCJPUHa4dBBUbq0KfrtO/BAljn0mLHhDNGhH+aY1sdNUdbIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6fY3ZjtFczdA4x5RLiPqn+xAA8DlzVXc3p1nNo7+vMuxN0qU
	DqdPvcEYVi00CWKkAVilY4LbDgtmgeKHAD3b/Dg0kZQqsS2oNvJ1kI64IPV/QVAfwV4i+ONiVap
	OKPdqyai9fl0fwGcQiu1zo7XBl5jYzXagLjnV0kscwUDvqgrPLkEvDIWf9EhypQ==
X-Gm-Gg: ASbGncsnCa7Xc6wLTrQVBFlD1k01oKupFUjgrjceDE+TACFOiDKptX9MjH0nx4EtW1j
	10kmaCttl0EfRIUElzPJBelYy6OjruUeaBi8LSMGHUHTLnfNRY+GfggLhlcdxOOqLPJ0CFC+MVF
	W46ZwfgYY+7megtEcr+w3TM4O9A0+PE3w14kV5xnXXEUecc2OTYi968MC0+YrLDYzotBtsxMEGl
	4h7RN2Q39l6rOtdzQhu3S3ZZ2C15VpfaFZBrv9QSheqQSnbn6Yd0M2S7qwThFO8T5drdzmWy8MP
	L+aCjbCLn6N3MrTBtw==
X-Received: by 2002:a17:902:ec92:b0:21f:6ce6:7243 with SMTP id d9443c01a7336-2236922454fmr215973815ad.51.1741069441094;
        Mon, 03 Mar 2025 22:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeWcLcszVzswCV3IlHec2C4u9Iv8biEcHW4AvArM9d+exFu3qcTvk3+Js7kBLoNIjChH7Sog==
X-Received: by 2002:a17:902:ec92:b0:21f:6ce6:7243 with SMTP id d9443c01a7336-2236922454fmr215973585ad.51.1741069440784;
        Mon, 03 Mar 2025 22:24:00 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d323bsm87972535ad.3.2025.03.03.22.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:24:00 -0800 (PST)
Message-ID: <9d32bfed-31f2-49ad-ae43-87e60957ad74@redhat.com>
Date: Tue, 4 Mar 2025 16:23:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 30/45] arm64: RME: Always use 4k pages for realms
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
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-31-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-31-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> Always split up huge pages to avoid problems managing huge pages. There
> are two issues currently:
> 
> 1. The uABI for the VMM allows populating memory on 4k boundaries even
>     if the underlying allocator (e.g. hugetlbfs) is using a larger page
>     size. Using a memfd for private allocations will push this issue onto
>     the VMM as it will need to respect the granularity of the allocator.
> 
> 2. The guest is able to request arbitrary ranges to be remapped as
>     shared. Again with a memfd approach it will be up to the VMM to deal
>     with the complexity and either overmap (need the huge mapping and add
>     an additional 'overlapping' shared mapping) or reject the request as
>     invalid due to the use of a huge page allocator.
> 
> For now just break everything down to 4k pages in the RMM controlled
> stage 2.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/kvm/mmu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 

The change log looks confusing to me. Currently, there are 3 classes of stage2 faults,
handled by their corresponding handlers like below.

stage2 fault in the private space: private_memslot_fault()
stage2 fault in the MMIO space:    io_mem_abort()
stage2 fault in the shared space:  user_mem_abort()

Only the stage2 fault in the private space needs to allocate a 4KB page from guest-memfd.
This patch is changing user_mem_abort(), which is all about the stage2 fault in the shared
space, where a guest-memfd isn't involved. The only intersection between the private/shared
space is the stage2 page table. I'm guessing we want to have enforced 4KB page is due to
the shared stage2 page table by the private/shared space, or I'm wrong.

What I'm understanding from the change log: it's something to be improved in future due to
only 4KB pages can be supported by guest-memfd. Please correct me if I'm wrong.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 994e71cfb358..8c656a0ef4e9 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1641,6 +1641,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   	if (logging_active || is_protected_kvm_enabled()) {
>   		force_pte = true;
>   		vma_shift = PAGE_SHIFT;
> +	} else if (vcpu_is_rec(vcpu)) {
> +		// Force PTE level mappings for realms
> +		force_pte = true;
> +		vma_shift = PAGE_SHIFT;
>   	} else {
>   		vma_shift = get_vma_page_shift(vma, hva);
>   	}

Thanks,
Gavin


