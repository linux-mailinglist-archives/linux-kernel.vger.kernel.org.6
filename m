Return-Path: <linux-kernel+bounces-305289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8AF962C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B01F25BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7D1A38CF;
	Wed, 28 Aug 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHe4DrwU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7917C223
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859097; cv=none; b=lmYSBe/Qz2bJ6JQS52AqVmu9gxFYQUBD6cKVAFA0+80Orev9DuKtZkh34DeH+j2LhxC59+a0/41f0ek7kKGajChylwWpKGnd7aYL2EInZb9iGkazsGccAWorG0gtmCOoIrrkceOU9Cm3OBg0vrc9+4Gtf3OHM/WEMvM+BBN/Xak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859097; c=relaxed/simple;
	bh=HB83BpCSZwmFCFPQy1dp2nbaKNvjyY/GryE6N3K9Yn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEhgysvrEYcSWrAJf2GRj5AlSwzCmVwTp3rOTR+DqKJ8/1YdsADZH8NEtF1HUGVnVSnTWpektZZEBI05p0cAevX21Pe7KGJ8IKDosyWtu0NDJNeECHf6SYPquPZfZL0jDA6nlHEaY7vkRFxxhALBx+gAtBHM281ADtRck7aS1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHe4DrwU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724859095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xOPKOsg5jv8jg6VD4xEjJRB23KAp6IEXnaWD2DP6S5o=;
	b=QHe4DrwUQipKJT1Y5nAoL8Gv/JwmSYPkHmr0rDETsU//0TXtdze5Q4irf/3Jkp1RZCvlv6
	lazC7qQZSnB9kkgFtsZiHI8ZnxVRPDfgDZUBHH4llF/UNPZkHcWWRCAcE0Lj8qbQPZLGVi
	kuv/feKYSbcRERU9ENFkQQr89cfCEp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-SfBxY1b7Orey1cXKXiJ75A-1; Wed, 28 Aug 2024 11:31:32 -0400
X-MC-Unique: SfBxY1b7Orey1cXKXiJ75A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42ab8492cedso63822095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859091; x=1725463891;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOPKOsg5jv8jg6VD4xEjJRB23KAp6IEXnaWD2DP6S5o=;
        b=jnPxbHw9JTvEZvMFOQnqypA5yzIwTlLlJAL98w14vxuWwvPeVt3LxXzAxNYZ2+bmsA
         wIVN46q+x+9jg0ePIY1yrVt1dWt9iWOxv5LCpENd2pSRwEzgX8xLuaRF5MlnKCTmIS6i
         uJ1HNGYYew5Cg+lNd947IwRXcICGCnFlrXwN4FAjSNPfBHGYdnCj5rHOx49IDekjM+6w
         /iZaoP9ykY/fLsoAXmUCQX/vGwGBPEnRvQyq0X9a9zLB0tKwk9dyyJ2XX5rp5qo8vJEK
         n6Djbxv8uHu3+rIWeQub4P5t0yXdCK/kL0qWTa+ijek1dXwcm87wuPD/RrcWHxvPz7YV
         DKpA==
X-Forwarded-Encrypted: i=1; AJvYcCUSiiOMBQyRA3UyMDvlpZ0BN3YU+Mo885lwMh45n0uUvzA0qu5IFPfyyWVHpdRItdlHGokTU6L9wb5PxB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W4vcytHNTmhCYbU2fRYBmTz6qcnXnpNLS17qtApGHXirBfBj
	Epq9fRxdVoSHVxJ4Ty7bUdt9LU7d2u7FXeZmE7MD4GxToZwkg8u+oykeO1aaxP/Q70QxeBDyO9X
	YgTNvOurIhJxnLmUx8n8mE99xcdIFfBxaXlplVE9ttlXR/taIDYaJKZlAhoAaag==
X-Received: by 2002:a05:600c:3b97:b0:426:5c36:207c with SMTP id 5b1f17b1804b1-42bb27a9c77mr76535e9.25.1724859091174;
        Wed, 28 Aug 2024 08:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6XqulJHuzc87ef1Sa38B+B4vXhV59jcrORNIKvdBRzM+hIg3NDU7pbYLM5WafNDZhZwqCXg==
X-Received: by 2002:a05:600c:3b97:b0:426:5c36:207c with SMTP id 5b1f17b1804b1-42bb27a9c77mr75985e9.25.1724859090191;
        Wed, 28 Aug 2024 08:31:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a? (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de. [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d3029sm772145e9.42.2024.08.28.08.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 08:31:29 -0700 (PDT)
Message-ID: <012789cd-90d0-4b3b-b48e-16990ee40fc4@redhat.com>
Date: Wed, 28 Aug 2024 17:31:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] mm: Mark special bits for huge pfn mappings when
 inject
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-4-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240826204353.2228736-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.24 22:43, Peter Xu wrote:
> We need these special bits to be around on pfnmaps.  Mark properly for
> !devmap case, reflecting that there's no page struct backing the entry.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/huge_memory.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3f74b09ada38..dec17d09390f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1346,6 +1346,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>   	if (pfn_t_devmap(pfn))
>   		entry = pmd_mkdevmap(entry);
> +	else
> +		entry = pmd_mkspecial(entry);
>   	if (write) {
>   		entry = pmd_mkyoung(pmd_mkdirty(entry));
>   		entry = maybe_pmd_mkwrite(entry, vma);
> @@ -1442,6 +1444,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>   	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
>   	if (pfn_t_devmap(pfn))
>   		entry = pud_mkdevmap(entry);
> +	else
> +		entry = pud_mkspecial(entry);
>   	if (write) {
>   		entry = pud_mkyoung(pud_mkdirty(entry));
>   		entry = maybe_pud_mkwrite(entry, vma);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


