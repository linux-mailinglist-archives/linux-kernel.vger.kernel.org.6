Return-Path: <linux-kernel+bounces-343600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F75989D23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3021F22549
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7614B941;
	Mon, 30 Sep 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HevoYfu4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941C180A76
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685936; cv=none; b=ZydATwdRNXhO22pmOmbKxU9zV5FIfmBZHMkm28wSJQ7G8AtMK5QTRpaOgmKNj6PdsbDUY1LMK8KtnUYH6CUFy9Y2v3AW8L4g0Dj53CAu56Vd3zEnKvnQTvEmu950S9WuVXo9rwbGe0SDp8uIFE8+shN6o6/PgKAWSlVFvxyJ6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685936; c=relaxed/simple;
	bh=pFrfJFP0lSZnYPMr6mWEUrhQ2ByyGp1pb1X/9DWTPrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LV5XVMbkFGM+ixhoiduapayvhwN94nG2q3Jo7YNMW9JjOUGlLEIgB1TLt+b0DwDSsr9ONChDECX2FetMNneVtDR3AqLrhKxWiWdyRLb0U7rmvO5L2WzfV1G3hMfi1mmgpxJLq0rsVHFXd1Cy26iTCZZ1qHiY1NMuV7jihApMq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HevoYfu4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a/430ydxvfdkbT58361Uy7HVxy5PiphOwNV4mQnykbE=;
	b=HevoYfu4DrURI4X5GBvIZF7TFI5TeHRwteTolUwjyC7rAvFDUkhhlkmY7el2nPuxASti8k
	6YahsryZCImrVPIQj7iZMTbh9u2Quzl1LcVqPTSAa5vWPjiVnj/1F0/9AQDRComnJAiQ7l
	Zxsv/a+UZ0I0h9iJUTbEEjW5epqpzJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Vrp1BAebNl-yE3RhhdDGvw-1; Mon, 30 Sep 2024 04:45:32 -0400
X-MC-Unique: Vrp1BAebNl-yE3RhhdDGvw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cdb0e9eb7so713485f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727685931; x=1728290731;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a/430ydxvfdkbT58361Uy7HVxy5PiphOwNV4mQnykbE=;
        b=Fb/gdUbKiCFoWk1jCNQh8C0UHS8BZsaGtAVVWDhXRrMkxTVlPDDDePFF+98mc/AcyG
         CShuW1UJtMVRj75oVEcs4lMKFe+c1IZnjMYnjfmZDFHk9xIY8TIAqCArJj6hsWTrTngl
         Z/6HpoaMdQmyTaMDfND7odMW80EaEyUfqiOewQf01uKbZC4TthypcUFpOes0QZMX0jtM
         MUCchtdlPmgngxt+JC1qdw7iBurC0X5QKuDVuZlHe7InpB3+IkJARGyyTSBLZAvdHIOi
         0JAgfMeAmF74co43Rm4GiXkQwdPdUrd31eN1rvIghwRGe09iMC5DsE+ARhjFC0FA5WKZ
         imRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZtUwdSWwAxeonfeYQiNzUfdzTTL6VQ8uB3FM2/r/lO+K06w5mlpA8oWYlT7QeaFvEMpoVKxRgplbTvtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaXUy06VHB83KSHmk+csW44/1Amf7LGu5k5iSf9YTXTxHgdLs
	FfOVqSjeXFpCRfmwIrGjQ2Nshzw3MWxyZvjp/mDjtpWg/rn9O+3D9hM0zE2GXuFDZfS+FfNBgT2
	On4TsTV1w0SpWVbSImH3FhOlziIolBS7cWSAfaUuA8u4V9kadouBpy53Q6D0QaA==
X-Received: by 2002:a5d:5548:0:b0:37c:cfbb:d356 with SMTP id ffacd0b85a97d-37cd5aebe7bmr5448122f8f.28.1727685930995;
        Mon, 30 Sep 2024 01:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeSuLQ3p/3SAxtJdxkEgYzS17qTXoyQLqPyhHTyNf8v3bk3S9YMvLIsay3YfHKh3OtM/IwOA==
X-Received: by 2002:a5d:5548:0:b0:37c:cfbb:d356 with SMTP id ffacd0b85a97d-37cd5aebe7bmr5448101f8f.28.1727685930545;
        Mon, 30 Sep 2024 01:45:30 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57423afsm8472938f8f.90.2024.09.30.01.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:45:29 -0700 (PDT)
Message-ID: <7c563924-47ea-42d1-82dc-3597151998a3@redhat.com>
Date: Mon, 30 Sep 2024 10:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] mm: Abstract THP allocation
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240930052812.2627395-1-dev.jain@arm.com>
 <20240930052812.2627395-2-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240930052812.2627395-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.24 07:28, Dev Jain wrote:
> In preparation for the second patch, abstract away the THP allocation
> logic present in the create_huge_pmd() path, which corresponds to the
> faulting case when no page is present.
> 
> There should be no functional change as a result of applying this patch,
> except that, as David notes at [1], a PMD-aligned address should
> be passed to update_mmu_cache_pmd().
> 
> [1]: https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 98 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 57 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4e34b7f89daf..e3bcdbc9baa2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1148,47 +1148,81 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>   }
>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>   
> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> -			struct page *page, gfp_t gfp)
> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
> +					      unsigned long addr)

Just a nit as I am skimming over this once more:

We try to make any new code / code we touch to use a 2-tab
indentation for the second parameter line.

E.g.,

static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
		unsigned long addr)
{


-- 
Cheers,

David / dhildenb


