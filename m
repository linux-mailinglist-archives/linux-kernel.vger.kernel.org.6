Return-Path: <linux-kernel+bounces-241367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A659927A59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FA81F21E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E71B14FC;
	Thu,  4 Jul 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBYydbnX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265221B1439
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107706; cv=none; b=QYmE+Ctd2FL9DdhEnaeZa3eiGiGxe6Q/d27aJLR0XEBCFeCGVSFIcGkHQkhpJlORmRtQzHDA3qL7zlWuwEpvPPNzkV8tZbB/j6EtF8xttRhmRsmjYr6SSng73lsVE/ccQaZjdDU0cJXgZYIGFWTqhQZWqB2TFwoTeqsxKat0sgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107706; c=relaxed/simple;
	bh=6MX8xELIwq09fmnouAW8E9WMADfTYiZz9fR+tf5QSzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pED7wqearbwXY9OE3YO1aZAJPV/4fDYF+ivzFtIfzHi/qItTtFx2V2TEwjFqClvNwqgnAUBuIJQOBU38T7YOkwWlNzvTcA7deZH7j0NZZk7+yE05/IECZXfgWhYwhLYrtSCwpezGTbDCAXGNtGrXVCF1T1+NoP7yZOdh+lkftCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBYydbnX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720107704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b/guLxSHeFfZm60bqfRYgec2x5BpfKtwP3VHSwDVju0=;
	b=QBYydbnXwZewgkXcuDjap1lRDAPPxWECug1qZmkaSyabQYImK1dl+LxovzcnynhlPeTcq5
	JxgkOXZvIXc5qGa76CzMEn0oiXaPvlwLYAfE2Rd7noIf3/dGxPuGZC5cDiGBr+ZRNjHR4r
	w8PIdhIM8qdXp/D5Ek9Nbnf0tgYtJS4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-PEY4Dn6iO6ahMdesopL4Pw-1; Thu, 04 Jul 2024 11:41:42 -0400
X-MC-Unique: PEY4Dn6iO6ahMdesopL4Pw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3679aa0ee0aso507543f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720107701; x=1720712501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/guLxSHeFfZm60bqfRYgec2x5BpfKtwP3VHSwDVju0=;
        b=Fdr8rYE17qOQqZrthVhXovF9wVYEUkdMr4el4GtqTFcJU9PbLt9QGBUthKuVKpOXM8
         KxzBsAnx0PFc94Kuzf0tESAVVt+ab5ckJh6FGaZDTkUveEXKM4/XmZ90KcOppj6ntvHb
         ThCIEy0CD/vxLtSRwEAduQT6C6Sd43bilcDm7nzb2P7nw1McoZ+aWuIp/ema/9hTpMrn
         4atYYo9pC4eZoXN/O/2oQWg6iihPi4N/EErUqD1UhAMUK4CBD02wr1sV65NNzi/rmf8r
         Pe7MrGbyTLbST0yWDg9cITjJgo04XxT3nA2zGIAX5I+Le4d7YstFCDQ0VtCVlCNv72Fo
         LQhQ==
X-Gm-Message-State: AOJu0Yx8BaTwaQYgALC6nYIgwr7i3Zn7GWjSEupmZ4NPJAa2sAyYvFkZ
	NsToZtNMY+3e7tZNylQHFmNY1LYzMBidzuRW/o6N0OBIuWQlUOMvbhMQeGDxN5xKo9jTKAi7/jl
	u/Fo2/L3o9T134cENslgB2BqB/ZIU7qHU+v5o7kOUYzsLtvuqKm8gPjqiRXHF9Q==
X-Received: by 2002:adf:f2d2:0:b0:367:9792:8bd4 with SMTP id ffacd0b85a97d-3679dd65208mr1367695f8f.43.1720107701719;
        Thu, 04 Jul 2024 08:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvifDljnLTl51EWIff/gzGB+bulX9OAvOSzHrPj0EubUhit2RcrXbNd9B4uizJswZo9uPVmw==
X-Received: by 2002:adf:f2d2:0:b0:367:9792:8bd4 with SMTP id ffacd0b85a97d-3679dd65208mr1367685f8f.43.1720107701272;
        Thu, 04 Jul 2024 08:41:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd66fsm18988535f8f.8.2024.07.04.08.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 08:41:40 -0700 (PDT)
Message-ID: <df9afef5-f5db-4d50-9803-28f2ce30086d@redhat.com>
Date: Thu, 4 Jul 2024 17:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/45] mm/pagewalk: Enable walk_pmd_range to handle
 cont-pmds
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240704043132.28501-1-osalvador@suse.de>
 <20240704043132.28501-6-osalvador@suse.de>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704043132.28501-6-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 06:30, Oscar Salvador wrote:
> HugeTLB pages can be cont-pmd mapped, so teach walk_pmd_range to
> handle those.
> This will save us some cycles as we do it in one-shot instead of
> calling in multiple times.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   include/linux/pgtable.h | 12 ++++++++++++
>   mm/pagewalk.c           | 12 +++++++++---
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..3a7b8751747e 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1914,6 +1914,18 @@ typedef unsigned int pgtbl_mod_mask;
>   #define __pte_leaf_size(x,y) pte_leaf_size(y)
>   #endif
>   
> +#ifndef pmd_cont
> +#define pmd_cont(x) false
> +#endif
> +
> +#ifndef CONT_PMD_SIZE
> +#define CONT_PMD_SIZE 0
> +#endif
> +
> +#ifndef CONT_PMDS
> +#define CONT_PMDS 0
> +#endif
> +
>   /*
>    * We always define pmd_pfn for all archs as it's used in lots of generic
>    * code.  Now it happens too for pud_pfn (and can happen for larger
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d93e77411482..a9c36f9e9820 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -81,11 +81,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   	const struct mm_walk_ops *ops = walk->ops;
>   	int err = 0;
>   	int depth = real_depth(3);
> +	int cont_pmds;
>   
>   	pmd = pmd_offset(pud, addr);
>   	do {
>   again:
> -		next = pmd_addr_end(addr, end);
> +		if (pmd_cont(*pmd)) {
> +			cont_pmds = CONT_PMDS;
> +			next = pmd_cont_addr_end(addr, end);
> +		} else {
> +			cont_pmds = 1;
> +			next = pmd_addr_end(addr, end);
> +		}
>   		if (pmd_none(*pmd)) {
>   			if (ops->pte_hole)
>   				err = ops->pte_hole(addr, next, depth, walk);
> @@ -126,8 +133,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   
>   		if (walk->action == ACTION_AGAIN)
>   			goto again;
> -
> -	} while (pmd++, addr = next, addr != end);
> +	} while (pmd += cont_pmds, addr = next, addr != end);

Similar to my other comment regarding PTE batching, this is very 
specific to architectures that support cont-pmds.

Yes, right now we only have that on architectures that support 
cont-pmd-sized hugetlb, but Willy is interested in us supporting+mapping 
folios > PMD_SIZE, whereby we'd want to batch even without arch-specific 
cont-pmd bits.

Similar to the other (pte) case, having a way to generically patch 
folios will me more beneficial. Note that cont-pmd/cont-pte is only 
relevant for present entries (-> mapping folios).

-- 
Cheers,

David / dhildenb


