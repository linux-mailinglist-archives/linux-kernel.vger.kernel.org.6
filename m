Return-Path: <linux-kernel+bounces-200240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDAA8FAD5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A9C1F2196C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460421422CC;
	Tue,  4 Jun 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+Hbj6D5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A28139CFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489188; cv=none; b=Jzh4tCiJ5o1YlCv5s5sG4TCEONRhvyHLNx/3w840lOxd2AtH+SsWfY6CFCTp6I6q6e79Q0zfszQYLE4X3+KcWrdN8R5V1bvfVrzkeGOujIU1DqEXoSB6errNaIUZggYkP2nRD88TqBQDL0C5iAHa2KTU7wP2NdOgxu9FeRF3zIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489188; c=relaxed/simple;
	bh=di0pGHEbFEqyrPb2YfDbD3de5IYrchc7O4SZH7vVpIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y+fkP9XzcYh+7YkysqdMTTjhbJuIXEYYXII+AQJc0AKASKM47FinCdV+2X26RFGcIaswMrRiiVUOd6H13J/dGv75ZzzI6mgL7yoKzs8KR70xCRW5pnvQVdgkbtBPfWSm6ZufKnWDDf84dMXhVXhPqWLq79INz59e27dU2eZeHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+Hbj6D5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717489185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VEo0g1z5AXZdRYRQP7UwgkDi3u10k8Gf3M7iNnE0abE=;
	b=E+Hbj6D5ghQMFJugNKgzwpLhepRBzboe0MEUucN0Rk++YbZdfdJ7urzOEmbUEHqB5CGMSU
	fN5Y0eJF7zQKcBgnRqHyLbEUL+hPzc2X+3cn2CXXlVtxjaV5kTKJKlUeJPoHxMrU99Ncja
	Jkra+AaZ5SWfnqVeQ4jiDwDaL9TnOB8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-IVM5WqmaO76Wqc32VovaBg-1; Tue, 04 Jun 2024 04:19:42 -0400
X-MC-Unique: IVM5WqmaO76Wqc32VovaBg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4211211e18cso39241365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 01:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489181; x=1718093981;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEo0g1z5AXZdRYRQP7UwgkDi3u10k8Gf3M7iNnE0abE=;
        b=DsxCJjZ+VQjrrrezA0c9yvsszcRW1u1rjuygSROoKXhx4I4WMknnNqq03WR/a3ME3c
         JcLEAoUIIObmViiuhMWojVUSWxrb5bFJnW42YuuMoebHqXZ1uZtTDP+pnEo2ZYpM1qoK
         Pnb2EkzTTBYiCkoTcNm+O+icrOht+U0ZiH/hAkOSjNRCUI6UXeCrOpGSm9P83FzMx/bo
         Gh9nviPkORO/ow8SfxtaD17vuqk5BAfyDFBazdj/hz68Xb8mmfD+sjvZilRc5w3uBK/9
         LSpd+FMZ2Nst8dqI/j65gGilry3SqJ+xhbsERn8AmEnyvnAyRQYV5DL0bL5uqL8zixDY
         xPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW0QXvWsPD0xYnycv0hg1RiDiuG97F15M0iRUAu3y8i8V/z3qz7Vb5V7U2zwtDDXVMljtUBS25yB45uuSmdw0mvsS68zTaYJbcKBes
X-Gm-Message-State: AOJu0YyjlcCygL7MI98++thcf89pUu7sDMw0NLQky/w/MvC0GhkShX3N
	o4tAuRV3309V/P5sBqPHDA6EK7CVgCejCny0hY/Nagk0i0TjfbfVCPwggMvfrLVcsDBY3DfX6Sr
	A15wMkS4myyTIQwMnn7Mkwjq/j96deDRXIOxZ6rJwPjrpg3a1WA1s84535QnLKQ==
X-Received: by 2002:a05:600c:3550:b0:420:1853:68c3 with SMTP id 5b1f17b1804b1-421417bd9aemr24872775e9.20.1717489181072;
        Tue, 04 Jun 2024 01:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLiS64jPiTi2fewXdJ41gcIFcWL2i3BpSrvPJCGUWRs1eAVb2r9Xo2xIoxsm4D+4vvwSRaIQ==
X-Received: by 2002:a05:600c:3550:b0:420:1853:68c3 with SMTP id 5b1f17b1804b1-421417bd9aemr24872605e9.20.1717489180675;
        Tue, 04 Jun 2024 01:19:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214beb5c9asm10928485e9.7.2024.06.04.01.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 01:19:40 -0700 (PDT)
Message-ID: <8a4d048c-0764-442a-aa70-48518068f163@redhat.com>
Date: Tue, 4 Jun 2024 10:19:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] mm/ksm: use folio in try_to_merge_one_page
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-4-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240604042454.2012091-4-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 06:24, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> scan_get_next_rmap_item() return folio actually now. So in the calling
> path to try_to_merge_one_page() parameter pages are actually folios.
> So let's use folio instead of of page in the function to save few
> compound checking in callee functions.
> 
> The 'page' left here since flush functions still not support folios yet.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---
>   mm/ksm.c | 61 ++++++++++++++++++++++++++++++++------------------------
>   1 file changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index e2fdb9dd98e2..21bfa9bfb210 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1462,24 +1462,29 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>   }
>   
>   /*
> - * try_to_merge_one_page - take two pages and merge them into one
> - * @vma: the vma that holds the pte pointing to page
> - * @page: the PageAnon page that we want to replace with kpage
> - * @kpage: the PageKsm page that we want to map instead of page,
> - *         or NULL the first time when we want to use page as kpage.
> + * try_to_merge_one_page - take two folios and merge them into one
> + * @vma: the vma that holds the pte pointing to folio
> + * @folio: the PageAnon page that we want to replace with kfolio
> + * @kfolio: the PageKsm page that we want to map instead of folio,
> + *         or NULL the first time when we want to use folio as kfolio.
>    *
> - * This function returns 0 if the pages were merged, -EFAULT otherwise.
> + * This function returns 0 if the folios were merged, -EFAULT otherwise.
>    */
> -static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
> -				 struct ksm_rmap_item *rmap_item, struct page *kpage)
> +static int try_to_merge_one_page(struct vm_area_struct *vma, struct folio *folio,
> +				 struct ksm_rmap_item *rmap_item, struct folio *kfolio)
>   {
>   	pte_t orig_pte = __pte(0);
>   	int err = -EFAULT;
> +	struct page *page = folio_page(folio, 0);
> +	struct page *kpage;
>   
> -	if (page == kpage)			/* ksm page forked */
> +	if (kfolio)
> +		kpage = folio_page(kfolio, 0);
> +
> +	if (folio == kfolio)			/* ksm page forked */
>   		return 0;
>   
> -	if (!PageAnon(page))
> +	if (!folio_test_anon(folio))
>   		goto out;
>   
>   	/*
> @@ -1489,11 +1494,11 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
>   	 * prefer to continue scanning and merging different pages,
>   	 * then come back to this page when it is unlocked.
>   	 */
> -	if (!trylock_page(page))
> +	if (!folio_trylock(folio))
>   		goto out;
>   
> -	if (PageTransCompound(page)) {
> -		if (split_huge_page(page))
> +	if (folio_test_large(folio)) {
> +		if (split_folio(folio))
>   			goto out_unlock;
>   	}

Careful: there is a subtle change:

In the old code, after split_huge_page() succeeded, you would have a ref 
on *page* that you have to drop.

Now, you would have a ref on *folio* -- IOW the head page that calling 
code has to drop.

Is that handled accordingly? IOW, is there no code that would assume it 
would drop the reference on the *page* instead of on the *folio* (that, 
after split succeeds, would be an order-0 folio)

If so, worth spelling out in the description (you say "So in the calling 
path to try_to_merge_one_page() parameter pages are actually folios", 
but I am not sure if that means that all page refcounting code was 
changed to folio refcounting code).

-- 
Cheers,

David / dhildenb


