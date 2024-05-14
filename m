Return-Path: <linux-kernel+bounces-178903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED48C5944
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102401F2433E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1717EBB0;
	Tue, 14 May 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZLTdQVA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64D1448C0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702709; cv=none; b=NmqDoxup0L/T/eVV54rbyrN602UsC3H1J5Q64TvafwKGJs6o4foBVDSAnoajalllntusaa1qlPlhRGxs32wa5aBlZ7vm8yNP2AioTabVxz38zzFPfXJuKASkrm5WOjkJdQf/RwZYnl3EK5ARDNgLnS+whl05C2KZv0qXW4K41qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702709; c=relaxed/simple;
	bh=OtvO/UVSSjnpWJnrEoHjDPqpFiRtgMqT7h0ba7myut4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U28RmB57Bmi8wafrygoCFTmXVQW4ZVa3yJx9mC5tXEDNh+B7xi8ZCPBwXjyy04mRX0imM+ALRjcCknEOFS3BTHXNix8B6A4y7fEA0FLnOvaX1rTkYlfXH44n0nBDaMR3EvsUnw0Cv9z465qgQSiC7d5G2YtQlEDOffAv5eN83qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZLTdQVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715702706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dmMmRWEieJM/VyycAHEtr/8G1hbbQFys09rSH0ZH8zw=;
	b=EZLTdQVAFgFSS7HgSrPLBEsDj33dmQze/g9PJoIwi3O4E8h6Wy4tg+nW9SX4EAyd2kRp02
	no8g+oo7lpCt+lgAyZ9SEy87It2CTqCbrjREnKp6GAp8+aO10D+eL9xG0iRLTVq0pXVG2D
	Inp4HQVy4dk+14bGyYlQ99IdLSkknS0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-HeIx3AcuOFK0SRK_5wkETA-1; Tue, 14 May 2024 12:04:54 -0400
X-MC-Unique: HeIx3AcuOFK0SRK_5wkETA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-61c6560f50bso5647040a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702693; x=1716307493;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmMmRWEieJM/VyycAHEtr/8G1hbbQFys09rSH0ZH8zw=;
        b=nSvItg1klSAvW/KoMrU6P1kRo1QmYP/bczZdchN6K/sKx6kPUWEGJS7Vqatq7FaJp2
         XgTcKaE9XyvwOr1C4VVQERoDYwKe7zelt25hj8ut+wO2EZUV6aFFfEeawYJN+zWQ0tS6
         vBxn2qlSpUtOnjbh6+pPmF1stDE+2bI71IWsV+xlEsDmYpAIyBLHlkV1juZrb+7klywM
         7AdugSCljYN8ktMXyey5QS1ctDNEviLQERhPA5TEYKq5TDmzKIS8vo1nvZfYhKjKFgfk
         2SpiZLRDXu0Xtn70DrE66I9Jgz5hISjf+dexhT6bFxiBgwik24xk82EpOesgqo5R0ASx
         dq6A==
X-Forwarded-Encrypted: i=1; AJvYcCVSea541+xUGdUAAB2KNGwRyU3Yq30dnJmJRlxIuWjLEPA2ghpbk+EzFEQZ6jin1LSz32jPVfyVFkcyhF0oR9LzH/FpvB51YODwbtvw
X-Gm-Message-State: AOJu0Ywpl04YdcH1SSY/aQb+vZ7fGybYx41FtHZsmeldRheOX1UJIK7H
	9Ew9ZduXeYquFcPS3O9MLKOFDviTzl2dprBlnH2bAXQqU0bAql3g9UwnmDgxjisgV5MNHVkfYpF
	Q+rwpAH6z+mJroHmaawBp+rAmcwf1Vzj3cDV4q/gWV6DDyn2u0AFXC3qtxDWyaw==
X-Received: by 2002:a17:902:dacf:b0:1ec:c9e0:c749 with SMTP id d9443c01a7336-1ef440505a0mr157388235ad.48.1715702692870;
        Tue, 14 May 2024 09:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyf1swdEc22d91QGE9oGlryQiUSYdvmusRTHKjFTFoYZZ/QMi0pxUaBLy+FRW8uQxZQ9IVjw==
X-Received: by 2002:a17:902:dacf:b0:1ec:c9e0:c749 with SMTP id d9443c01a7336-1ef440505a0mr157387705ad.48.1715702692355;
        Tue, 14 May 2024 09:04:52 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2566c1sm99172045ad.293.2024.05.14.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 09:04:51 -0700 (PDT)
Message-ID: <267be75e-ed4a-45d0-883f-51c7324c30f1@redhat.com>
Date: Tue, 14 May 2024 18:04:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Andrew Bresticker <abrestic@rivosinc.com>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240514140446.538622-5-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.05.24 16:04, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> For an architecture to support memory hotplugging, a couple of
> callbacks needs to be implemented:
> 
>   arch_add_memory()
>    This callback is responsible for adding the physical memory into the
>    direct map, and call into the memory hotplugging generic code via
>    __add_pages() that adds the corresponding struct page entries, and
>    updates the vmemmap mapping.
> 
>   arch_remove_memory()
>    This is the inverse of the callback above.
> 
>   vmemmap_free()
>    This function tears down the vmemmap mappings (if
>    CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
>    backing vmemmap pages. Note that for persistent memory, an
>    alternative allocator for the backing pages can be used; The
>    vmem_altmap. This means that when the backing pages are cleared,
>    extra care is needed so that the correct deallocation method is
>    used.
> 
>   arch_get_mappable_range()
>    This functions returns the PA range that the direct map can map.
>    Used by the MHP internals for sanity checks.
> 
> The page table unmap/teardown functions are heavily based on code from
> the x86 tree. The same remove_pgd_mapping() function is used in both
> vmemmap_free() and arch_remove_memory(), but in the latter function
> the backing pages are not removed.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   arch/riscv/mm/init.c | 242 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 242 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 6f72b0b2b854..7f0b921a3d3a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1493,3 +1493,245 @@ void __init pgtable_cache_init(void)
>   	}
>   }
>   #endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
> +{
> +	pte_t *pte;
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++) {
> +		pte = pte_start + i;
> +		if (!pte_none(*pte))
> +			return;
> +	}
> +
> +	free_pages((unsigned long)page_address(pmd_page(*pmd)), 0);
> +	pmd_clear(pmd);
> +}
> +
> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
> +{
> +	pmd_t *pmd;
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++) {
> +		pmd = pmd_start + i;
> +		if (!pmd_none(*pmd))
> +			return;
> +	}
> +
> +	free_pages((unsigned long)page_address(pud_page(*pud)), 0);
> +	pud_clear(pud);
> +}
> +
> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
> +{
> +	pud_t *pud;
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++) {
> +		pud = pud_start + i;
> +		if (!pud_none(*pud))
> +			return;
> +	}
> +
> +	free_pages((unsigned long)page_address(p4d_page(*p4d)), 0);
> +	p4d_clear(p4d);
> +}
> +
> +static void __meminit free_vmemmap_storage(struct page *page, size_t size,
> +					   struct vmem_altmap *altmap)
> +{
> +	if (altmap)
> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +	else
> +		free_pages((unsigned long)page_address(page), get_order(size));

If you unplug a DIMM that was added during boot (can happen on x86-64, 
can it happen on riscv?), free_pages() would not be sufficient. You'd be 
freeing a PG_reserved page that has to be freed differently.

-- 
Cheers,

David / dhildenb


