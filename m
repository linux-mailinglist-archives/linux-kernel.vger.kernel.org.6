Return-Path: <linux-kernel+bounces-281229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430194D4A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6ED28572A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E91991B5;
	Fri,  9 Aug 2024 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZW4rn3pK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF8197A68
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220641; cv=none; b=NXFiMJTo0mGCmg8+Ti860t3SVYlnEh1Jx8EJfb+sNXHeuxxYzSmjM2JqTugm0t4iZtO8yVvGbmmWIvnxvDNqk/jq9DQZlBBy/hj7IVkSKQFaNCDynfjFOn+2GEbFIMx2XT/g/f9TMg7pNdB1YuM9QCYxbbWY+MIMvBxEUfNenbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220641; c=relaxed/simple;
	bh=1Frrb1uK4bs5RpqzA7VPeyNGdhb9nNU9fy/n2I9PdfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfAK/GDEtW1WsCWj9dd9I9heBxZF4iLKN/LORGv8uUzSUUMVFzCbzzUO+MeGUHwcTP4hcyTI3GJzRc3Oh2c8oWcQch8CckDkxg2xJpi3nPw1WbyYrxedbBokx7Lu00E18QSQgV1Xi0eLOYXaAI9AXpe2ZWcKCwENG+ADFeuf4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZW4rn3pK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723220639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DoydR2K9jhjEheARXsAR7jPO3nMpWKOxYsEoh1X3iuQ=;
	b=ZW4rn3pKtfmvF81ijF7bNOGbg7SpAxIgzjlDoz2dsdgsW/q4r18fFnIH29D+IDlCGpbQ8E
	DZr9a5txC0exb7kNfp3tZ9USquHoLji8QmN9Vg9LvjrPSQdBLRbOuMYHY4TCDxBytfgoTZ
	+4CDBilJ3r8Wu7+4vYlP/ZmbfaCYg44=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-oZuJ6uncOoaWFu4j-qVh1w-1; Fri, 09 Aug 2024 12:23:57 -0400
X-MC-Unique: oZuJ6uncOoaWFu4j-qVh1w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3683f34d8d9so941462f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220636; x=1723825436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DoydR2K9jhjEheARXsAR7jPO3nMpWKOxYsEoh1X3iuQ=;
        b=pZxsfSjBT4H07OcZ8i9Y9NWMhckkc1BqqUlAkEvytGoGFbR6kFbXFB2uULeFIZt6TJ
         8zLdn1/5QoTqYM2d7eeCMDAQPLgvQCrEr/aUpoEgNPIwKKAJULzla6YM7XgFiQm4kwgu
         VL2VkHyGxxp1wuoLRmc9RJVfB6B9Czcj0IWEL/WAF562/hkMf76tZ7cmBcRKJHsynbNH
         DZ5a151tzOShLJIXA96oTYelRHKQnzXZZBVJxDXAdzBoMVh5sOn2BmR6ifeHbNbEY/AL
         muNeH/Sx9enynYE8UE3PVbfwoPCPlBrAmX4Y2Web2dhuhxR/aNUrRfEr0TcKefc+7gdt
         3kWA==
X-Forwarded-Encrypted: i=1; AJvYcCUemYM4g0/2l/1Sz7qdPXEwxtLPmjlq8O4cvMi72cOdQgBJ+YnLPXzj4KsJepZp5sEHtjpLVHYmPu0/iYIyUoir50+KMjJyhkXXdKTT
X-Gm-Message-State: AOJu0Yyq7BHUZ4acW9f+JtHYJdc1fCpkiQnB3xHLWKiSJeN2kK/FOz0L
	Hmfzn36Gdh+ey2DDPWEKS+ddke7cJe0QNt4if2wPpD++VEeoE9yAs4ISTUzvflE+4x16UUWnmXo
	eywyULegjgp7YYgKxfv36sTZh9Uawazu5EkXD87eCGBn4VaYtVLxhQiwIfHBjNg==
X-Received: by 2002:adf:f001:0:b0:367:8fc3:a25b with SMTP id ffacd0b85a97d-36d5fd7f99dmr1333507f8f.42.1723220636563;
        Fri, 09 Aug 2024 09:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGORBUs7LIbRVg/VkWqv1QHv+oMVJI9Ds+Lr9/1kzljagZ7mVmp7Fs9PFUonC+HZscNvafqJg==
X-Received: by 2002:adf:f001:0:b0:367:8fc3:a25b with SMTP id ffacd0b85a97d-36d5fd7f99dmr1333465f8f.42.1723220636037;
        Fri, 09 Aug 2024 09:23:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d271572cdsm5844020f8f.1.2024.08.09.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:23:55 -0700 (PDT)
Message-ID: <67d734e4-86ea-462b-b389-6dc14c0b66f9@redhat.com>
Date: Fri, 9 Aug 2024 18:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] mm/gup: Detect huge pfnmap entries in gup-fast
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-6-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240809160909.1023470-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 18:08, Peter Xu wrote:
> Since gup-fast doesn't have the vma reference, teach it to detect such huge
> pfnmaps by checking the special bit for pmd/pud too, just like ptes.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/gup.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d19884e097fd..a49f67a512ee 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3038,6 +3038,9 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
>   		return 0;
>   
> +	if (pmd_special(orig))
> +		return 0;
> +
>   	if (pmd_devmap(orig)) {
>   		if (unlikely(flags & FOLL_LONGTERM))
>   			return 0;
> @@ -3082,6 +3085,9 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>   	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
>   		return 0;
>   
> +	if (pud_special(orig))
> +		return 0;
> +
>   	if (pud_devmap(orig)) {
>   		if (unlikely(flags & FOLL_LONGTERM))
>   			return 0;

In gup_fast_pte_range() we check after checking pte_devmap(). Do we want 
to do it in a similar fashion here, or is there a reason to do it 
differently?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


