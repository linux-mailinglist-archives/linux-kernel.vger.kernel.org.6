Return-Path: <linux-kernel+bounces-307177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7585C964982
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CE72844E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AE1B14FA;
	Thu, 29 Aug 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1P4KCAT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217271B1429
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944233; cv=none; b=LnAC8Y+On6jcxIn6AVgk0jT3K2vEb5qjCNhGwhmXUDZDYkqUj9nIfSAniWqdqpIKiIAgWd6p/j/stwFUZJzNV7JUJs3ph96EPyxzrxNaEBYmpeEMJHseNdPWlVoWWt8zDf6hAaXgY8Ztrx1JIIGGJpZFjF+CH8NlyvLuzDp3uD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944233; c=relaxed/simple;
	bh=z/Ll3pbVnyVHBaUHDY97y6WdElzaD2vZh+W4+CwXnLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzjGmPHBlrtCuOtxobVSHBncH1//bUT5wKU62kRqrTPgbYfwwJM5Tk960Vx61Xuql9g4n9cdIPEU2jpjb1kRgtEIBEW15cUDbTEnYEfxp+v3zeJUNdX3raAlrz5x0M/ZUhX6yrGy+aSWi7W9lbRcZ1yysF9ssTdV8zxuXdNCVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1P4KCAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BruaygEdXCnQYW8tbQ1OgV9ZuFw/62wvKJTlu2vfTEA=;
	b=Y1P4KCAT5OfhvkeovQOZj8DWsAKi2o/6jMkh29Z66IwFHNoktVMTDAo5WKgxuvHE7O5muj
	qBuIajOwLulVuXCDxHkp+ML2Cfxudz7V/Ws8s9AOmaobVPSzs07jvbsEca4T4GXI4dYCZy
	ABQuk1B+QX4aDu6nRmbcxPOAGiwt72s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-TSayPXuIM7m2VafoZE3iNw-1; Thu, 29 Aug 2024 11:10:20 -0400
X-MC-Unique: TSayPXuIM7m2VafoZE3iNw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb7178d05so7287395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944219; x=1725549019;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BruaygEdXCnQYW8tbQ1OgV9ZuFw/62wvKJTlu2vfTEA=;
        b=bwjYERPsxBvOzKtQETRcAH28yTuv53pTsLTihJMWocTg5uq4OENPsLBWd0cUMES1GA
         22nwMyu0rM9jstwnZeTi53+swX2Sb7ZhWO/k1/99YbbTvk0CQvYBeeUqGfZBiKmRBns4
         5T+MO6SrM5JVf+DQWFeF9nzkUx0J6Zxmo5vmBjg3hNgaQ3Cr8J5cmrER9b/JLOmDAxv/
         iW/iod0RuPZKEG0pQHVnuxpm+6hmFHaiXCl9Ef4DJObEmYDZm7Uu812snfoFh/KJPxry
         xa/Tw8lupQ4wULrp1jb6seVKQXgUQOKAdhAyiHWiKW2cQMMiQtNIFbojPHjquVTIH1hI
         k7sQ==
X-Gm-Message-State: AOJu0Ywu9NGyOTeb0mJEn1piRhlMBAjSCgiZEvnHeU5ksIy3VSdqIAUv
	v4uvvoKdn4AttL4lMCWaa5VPYwCpDGF6zb+MDFanEC9uaPLV7O1kCKPhQ4afNVJxW7+N5MjXzhY
	RxH4rqi8Lcl4ZqX9bzqVU2MQzBJI7C9JAtvHnbfZO4dfx6bXm4Z7xnoAR+ZVaaw==
X-Received: by 2002:a05:600c:46c4:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-42bb029cd59mr29163075e9.34.1724944218617;
        Thu, 29 Aug 2024 08:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaB3fJNuysQDaWNUVjmCWx+VoGILEMX3LXPPl/rnoPKW6dJwP5dmIcBvd6CKZ6baC9Oqk3sQ==
X-Received: by 2002:a05:600c:46c4:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-42bb029cd59mr29161325e9.34.1724944217558;
        Thu, 29 Aug 2024 08:10:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:c600:c1d6:7158:f946:f083? (p200300cbc711c600c1d67158f946f083.dip0.t-ipconnect.de. [2003:cb:c711:c600:c1d6:7158:f946:f083])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e09esm1639187f8f.86.2024.08.29.08.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:10:16 -0700 (PDT)
Message-ID: <d25912b5-cda0-4173-befe-8a16209b1c66@redhat.com>
Date: Thu, 29 Aug 2024 17:10:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/19] mm/pagewalk: Check pfnmap for folio_walk_start()
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Gavin Shan <gshan@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
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
 <20240826204353.2228736-7-peterx@redhat.com>
 <9f9d7e96-b135-4830-b528-37418ae7bbfd@redhat.com> <Zs8zBT1aDh1v9Eje@x1n>
 <c1d8220c-e292-48af-bbab-21f4bb9c7dc5@redhat.com> <Zs9-beA-eTuXTfN6@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zs9-beA-eTuXTfN6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>> If you prefer vm_normal_page_pud() to be defined and check pud_special()
>>> there, I can do that.  But again, I don't yet see how that can make a
>>> functional difference considering the so far very limited usage of the
>>> special bit, and wonder whether we can do that on top when it became
>>> necessary (and when we start to have functional requirement of such).
>>
>> I hope my explanation why pte_special() even exists and how it is used makes
>> it clearer.
>>
>> It's not that much code to handle it like pte_special(), really. I don't
>> expect you to teach GUP-slow about vm_normal_page() etc.
> 
> One thing I can do here is I move the pmd_special() check into the existing
> vm_normal_page_pmd(), then it'll be a fixup on top of this patch:
> 
> ===8<===
> diff --git a/mm/memory.c b/mm/memory.c
> index 288f81a8698e..42674c0748cb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -672,11 +672,10 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>   {
>   	unsigned long pfn = pmd_pfn(pmd);
>   
> -	/*
> -	 * There is no pmd_special() but there may be special pmds, e.g.
> -	 * in a direct-access (dax) mapping, so let's just replicate the
> -	 * !CONFIG_ARCH_HAS_PTE_SPECIAL case from vm_normal_page() here.
> -	 */
> +	/* Currently it's only used for huge pfnmaps */
> +	if (unlikely(pmd_special(pmd)))
> +		return NULL;


Better.

I'd appreciate a vm_normal_page_pud(), but I guess I have to be the one 
cleaning up the mess after you.

-- 
Cheers,

David / dhildenb


