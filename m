Return-Path: <linux-kernel+bounces-200205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF4D8FACF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8252816E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560021420B0;
	Tue,  4 Jun 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uw0A3bzp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF114198A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487863; cv=none; b=mG9yfUhp6ScCYwIIJx1W1SfnlEzkMJUR/OiF002WXCXgo85xnVGvDV15wyg/E9YOYqOWr5u7sX8kGGeeuDHEizBAaSCODGYRN0BouK++3mqnmhwEiz9ZE8uE/AiavTteAvoqodti7i71iH+Rq0fwiaRrtw7sC56yPc4FRHr8sMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487863; c=relaxed/simple;
	bh=ErawTfT6GWyiHOBCJhtV9vZUNVYqvJIcBArGwtbMxuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baW/jKIa9jW5AeJ5tp7svDfGIGxck60Q4i06aTIvWuq5P1k2MxJWCv3sWlmKjaY6rRQbQgwyo43hIvMbSb53Kc6XSr+0FuGXCF9jmJRBmTy5Dwn5WBUiJvPyyv0se2YEMYqVu/VKHZZ6PZlzJjmgoZKt6X739sxud9cBHIJiuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uw0A3bzp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717487859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fhKGgBnctTbwLn+gwO3hK+Z8LhOuJ3SkwsQs2/qMiEo=;
	b=Uw0A3bzpLBLisep4sB9zqAWKB+9L+zf4LUM7j1csNOKpSaiCi/zTUlOUh9CS9719QgOQl0
	/ImImezC0kVPbanj5cg8TGypZspDnzveyesjSguIl7LBvUdEWvUsmnFZshD3FAJ2AEM8ED
	+P0jZrW8ATWdzOvQM/LDv889OQGjuNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-bKgKG5brMQWncZPq2d5Bgg-1; Tue, 04 Jun 2024 03:57:36 -0400
X-MC-Unique: bKgKG5brMQWncZPq2d5Bgg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421388f1deaso6571915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487855; x=1718092655;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fhKGgBnctTbwLn+gwO3hK+Z8LhOuJ3SkwsQs2/qMiEo=;
        b=OWYauftsVz7DCCWwIy0lsQOtFByK+qfRN7Ao8udQURV7eUFNNzkA1Oaxo3ynhLMKQ2
         ZaU790L8KfFXACbpJuVtQhnjlUKtJr2UtYRcd7UPGSW9WaWVgX4E8YYY0sBUaEPHRtxs
         goF6ecjDRLChfEJdCE7diRyCnrPwZq5HWyWZsyTbs3UKh3E23ucN5EHhjhfjKr00kj4l
         WlGrHe3QeDiKdVfp8fcY3/l0w3IXhW+Sz6re3Y8V+Kdm79qdc9cKPLWjAjEGTsCbIaIZ
         S7ufCnVvMtLdrxbzbciFw8rVa0aFkv329K2fvNd2OxRBjNyU3fjPteZ6WXgoXtMkM5uC
         IgHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgJYPDDx1w/XyKGCif/Yudsj5B5RICTQxs1KSxnAtlSLijyOex9wjp52MzCLY8BNT57K6DphJ/ZToNrrsT877iMB7gc0ZuLd8yq7Av
X-Gm-Message-State: AOJu0Yxrc5He3lLe7pFSCkAkXzNZbueZl3D2Gn49g8QsyhLUw4AJcmWx
	4fRr/ilQ+qqnhGdrjzqcp1Yl6dvUZMuEF8usSSPpFZE61wMbHO99vbK0VFc93LRzDe/hAVvkNzZ
	WEluj2n+C1tmLH1zuCD3zqxiMihNojnkdPJxVtM0R/0BssmwqVD2pqlnesG07eQ==
X-Received: by 2002:a05:600c:3b0d:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-4212e0b08f7mr95905095e9.33.1717487855392;
        Tue, 04 Jun 2024 00:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJiwhUIYWPGkpgzFuQHClAd9zfc6McyYTS3oqNVMIhVl/EmmcMfYR86vKAt1zVPoCzzugPhg==
X-Received: by 2002:a05:600c:3b0d:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-4212e0b08f7mr95904865e9.33.1717487854866;
        Tue, 04 Jun 2024 00:57:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84ae09sm143652095e9.18.2024.06.04.00.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:57:34 -0700 (PDT)
Message-ID: <fe35d494-b54e-4302-8c75-24abc9094ea1@redhat.com>
Date: Tue, 4 Jun 2024 09:57:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org, ziy@nvidia.com
Cc: v-songbaohua@oppo.com, mhocko@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn
References: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But my test cases are only for anonmous folios.
> while mapping_large_folio_support() is only reasonable for page
> cache folios.

Agreed.

I wonder if mapping_large_folio_support() should either

a) Complain if used for anon folios, so we can detect the wrong use more 
easily. (VM_WARN_ON_ONCE())

b) Return "true" for anonymous mappings, although that's more debatable.

> 
> In split_huge_page_to_list_to_order(), the folio passed to
> mapping_large_folio_support() maybe anonmous folio. The
> folio_test_anon() check is missing. So the split of the anonmous THP
> is failed. This is also the same for shmem_mapping(). We'd better add
> a check for both. But the shmem_mapping() in __split_huge_page() is
> not involved, as for anonmous folios, the end parameter is set to -1, so
> (head[i].index >= end) is always false. shmem_mapping() is not called.
> 
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..4c9c7e5ea20c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	if (new_order >= folio_order(folio))
>   		return -EINVAL;
> 
> -	/* Cannot split anonymous THP to order-1 */
> -	if (new_order == 1 && folio_test_anon(folio)) {
> -		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> -		return -EINVAL;
> -	}
> -
>   	if (new_order) {
>   		/* Only swapping a whole PMD-mapped folio is supported */
>   		if (folio_test_swapcache(folio))
>   			return -EINVAL;
> -		/* Split shmem folio to non-zero order not supported */
> -		if (shmem_mapping(folio->mapping)) {
> -			VM_WARN_ONCE(1,
> -				"Cannot split shmem folio to non-0 order");
> -			return -EINVAL;
> -		}
> -		/* No split if the file system does not support large folio */
> -		if (!mapping_large_folio_support(folio->mapping)) {
> -			VM_WARN_ONCE(1,
> -				"Cannot split file folio to non-0 order");
> -			return -EINVAL;
> +
> +		if (folio_test_anon(folio)) {
> +			/* Cannot split anonymous THP to order-1 */
> +			if (new_order == 1) {
> +				VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> +				return -EINVAL;
> +			}
> +		} else {
> +			/* Split shmem folio to non-zero order not supported */
> +			if (shmem_mapping(folio->mapping)) {
> +				VM_WARN_ONCE(1,
> +					"Cannot split shmem folio to non-0 order");
> +				return -EINVAL;
> +			}
> +			/* No split if the file system does not support large folio */
> +			if (!mapping_large_folio_support(folio->mapping)) {
> +				VM_WARN_ONCE(1,
> +					"Cannot split file folio to non-0 order");
> +				return -EINVAL;
> +			}
>   		}
>   	}

What about the following sequence:

if (folio_test_anon(folio)) {
	if (new_order == 1)
		...
} else if (new_order) {
	if (shmem_mapping(...))
		...
	...
}

if (folio_test_swapcache(folio) && new_order)
	return -EINVAL;

Should result in less churn and reduce indentation level.

-- 
Cheers,

David / dhildenb


