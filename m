Return-Path: <linux-kernel+bounces-240916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EA927485
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEDCB2263F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5F157A43;
	Thu,  4 Jul 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdh08mQs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293A1A01C7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091010; cv=none; b=MlsbdYzWK0KC2UL3shHoslR4QZ0lE4pDiECItN/ufve/CQ/4EJAi3dBVtHjuRB+y0cX00BsU6mE2DA//FMrBYB5rCtdZKiN7tuhOl2okphxDUpQx6LGgO+VM7L3O9dMCj0VVtcT5miyk7t2pR+5ZqHuO6F4z8QaXFaN4C03JY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091010; c=relaxed/simple;
	bh=NHPidTYyUyRxz0KWOpgbe41MKbyozkRCK8vxILpupUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc/R/6O9d3M61xi5DaU8fWxLjVIPV69SqgxZIQDpFUEKo7JzDlJIWbsQnpjQ2SfyJNvjx3JknGy/bpnefPTEFfaVGvCvd+ukN2il8eDWBsv2BOwkLTf1avHOimTqHdRbpAfyb5tw0QbuIkhgN9VOCAESnbTTdrNUcN5R9UpUWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kdh08mQs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720091007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kcmL/mrLNsxTT6n6Hb+CZD8jZbqOQDIm2w5SdDNo5UM=;
	b=Kdh08mQsFsXqlHq5+A3U9JrVygChswW0A4WBVeSoMNQxKQcaZqLPOx50Aa76zJKlbXwSW5
	5BPzJg9U5+zF/h3+qiiWSaVpivDj1La1TDXY5RXW6RbEUwhzVENh2sYU8oUvbfbsGQp87v
	qhUryoFygvfKSwbRYZNT4gomECl/Mzs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-7A09l5TxNvmHKnpH7Y6vaA-1; Thu, 04 Jul 2024 07:03:26 -0400
X-MC-Unique: 7A09l5TxNvmHKnpH7Y6vaA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a751eb024abso26792466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091005; x=1720695805;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcmL/mrLNsxTT6n6Hb+CZD8jZbqOQDIm2w5SdDNo5UM=;
        b=VtoRQMr2u+TUQqu8cZhN+RZqHAVaC9JnYbYbw1b7aRZd5yp3wgO/5rH4v8b9zT0iOj
         OhhXoNSXPDra1RSkAGRP3rrZiWLzhbAHx5243CQd31QXP2wxxUnVQvSBMZQGqAGMDhVC
         XfL5TVK0RnS4rTKGnQLR4Z2nwYWZA64oNfH+nIbCujJbyUFg5nkx10eY7D+6vYCQoWXb
         +1yHA5Obl7jidcH2/IBLzxlAqpUDwzz5tnfmiIBEwuRknWLvkGVFgGCPESYBt4oVDmeh
         Pf+icSinJ4NKw1rlvwZroAWKJtBZOZD9FD3qSEHevx8+3P8VkxMwYKJn3SVjA1YywYGM
         VIcw==
X-Gm-Message-State: AOJu0YyfBlbZk4Bh+rhfcc4PH1MHOp1XbUu9nYeRTuzaRieDlRM4AQ1m
	laRTeVtRGJDip0jAwiuXAhsr3O5StpTbnVWG5SzjHQfWV6XpBsB0DcauJcWZWfWcu34QvQVVMW3
	aUAAVxwD9P/JmNxaW6b9MzbfiWOA/fZwaRfXRkh7YndfXYfKGa/PPFK69ndzaqA==
X-Received: by 2002:a05:6402:90e:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-58e5b898cd6mr1205846a12.26.1720091004949;
        Thu, 04 Jul 2024 04:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQgKgodoPJSGVW4RqEd5iqAxJe31G23OyfS/FhV1XLA8+nmZgcUalxd1NjddlxvQvjlHZOgQ==
X-Received: by 2002:a05:6402:90e:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-58e5b898cd6mr1205774a12.26.1720091003581;
        Thu, 04 Jul 2024 04:03:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a754762826dsm199128966b.76.2024.07.04.04.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 04:03:23 -0700 (PDT)
Message-ID: <b98fce2c-4ad5-4a4c-9ad8-b8b307078413@redhat.com>
Date: Thu, 4 Jul 2024 13:03:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/45] mm/damon: Enable damon_mkold_pmd_entry to handle
 hugetlb vmas
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240704043132.28501-1-osalvador@suse.de>
 <20240704043132.28501-29-osalvador@suse.de>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704043132.28501-29-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 06:31, Oscar Salvador wrote:
> PMD-mapped hugetlb vmas will also reach damon_mkold_pmd_entry.
> Add the required code so it knows how to handle those there.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/damon/ops-common.c | 21 ++++++++++++++++-----
>   mm/damon/vaddr.c      | 15 +++++----------
>   2 files changed, 21 insertions(+), 15 deletions(-)
> 

(besides a lot of this code needing cleanups and likely fixes)

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d25d99cb5f2b..6727658a3ef5 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -53,18 +53,29 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>   
>   void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
>   {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
> +#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> +	struct folio *folio;
> +	unsigned long size;
> +
> +	if (is_vm_hugetlb_page(vma)) {
> +		folio = pfn_folio(pdm_pfn(*pmd))
> +		folio_get(folio);
> +		size = huge_page_size(hstate_vma(vma));
> +	} else {
> +		folio = damon_get_folio(pmd_pfn(*pmd));
> +		size = PMD_SIZE;
> +	}
>   
>   	if (!folio)
> -		return;
> +		return 0;
>   
> -	if (pmdp_clear_young_notify(vma, addr, pmd))
> +	if (pmdp_test_and_clear_young(vma, addr, pmd) ||
> +	    mmu_notifier_clear_young(mm, addr, addr + size))
>   		folio_set_young(folio);

And I think here is the issue for both the cont-PMD and cont-PTE case:

For hugetlb we *absolutely must* use the set_huge_pte_at()-style 
functions, otherwise we might suddenly lose the cont-pte/cont-pmd bit. 
We cannot arbitrarily replace these "huge_pte" functions by others that 
work on individual PTEs/PMDs.

(noting that the hugetlb code in damon_hugetlb_mkold() is likely not 
correct, because we could be losing concurrently set dirty bits I believe)

-- 
Cheers,

David / dhildenb


