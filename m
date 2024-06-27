Return-Path: <linux-kernel+bounces-232407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D691A861
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877441C21BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43869195395;
	Thu, 27 Jun 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TY/1s+Ug"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9F194C78
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496466; cv=none; b=iHGLid/1FfJ1eWR+kZTAGl/NlpzSpmLgKR1AM7R20vA4ZFkCcpTVMCrd4N9ySXZYRaxDVmYwFULiIz61hxmyfaSht/oCObnEWkcOx2xjaufrGZJwefI9Sbmla2B7HG73ODPVrxGdS+5c7S17/MiYwBDew7BjIjUGFrX5Oh8q8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496466; c=relaxed/simple;
	bh=X1nvLNikeUSgIOSiGO75ScQahkne3E90NQ1b9sqzvh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHu2WW2FLfBpMm82gFC285tav1fcWGeSp3sYBx5q11uOWgCqXBKfB+iINUB8zPPkGrCOomSJ0qzKsZu6q2Z7PGkvEjbg2NL9xkMk19PmIGT1FhX+CpDj2WrYXbj6nCQeGMv8suS6WfedEHCen/I9LHpneBhfOnniunoX13DVeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TY/1s+Ug; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719496463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7FZ5fXMWR7t7gWgo0hMSBgAVgtDH4DNyErrvWiLg15w=;
	b=TY/1s+UguP7Z2urtrvmP/HLFC5I75OTtiuaKHz+tmk170Ock8xd1xbLB8L+v6HJXJTUt1s
	n4ssxk71yNNvhyL0BiX7sDdjTgj3Y5Vg2E+9/5wb0Rf3fPkUBNbeonoWgAP9FdcVjlSUgt
	YLZoFsW0AhRtQbJfx50eYE3fOmOqdpk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-SIwl0TFYN7Kmbz-YY_CHhw-1; Thu, 27 Jun 2024 09:54:20 -0400
X-MC-Unique: SIwl0TFYN7Kmbz-YY_CHhw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-422322e4abaso10216645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719496459; x=1720101259;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7FZ5fXMWR7t7gWgo0hMSBgAVgtDH4DNyErrvWiLg15w=;
        b=GBLDzlwaoAddOxU62PvJdOYykQfCS72PLzAobsUhS6P0exLNYgiM/9aQHQSkTqHvxG
         HkK6dwpWxJ9z/DpjGcZLt3ssHNiAshAQ7n9K4Aw/YYxao0L/jdv2OmXgShgeYavLmYO0
         6J5WLlQSgh/bIygRx6BJVDdhEgnifjQDQ3qhEOsIiuoRHmxEmgv2wRrkhc+dO041w8x3
         LjLABi0TwWaxbQyREMSVxRk7csHnZ7gm9/guJ/mYvEy2zxZ5OMBouy4WlffKT70v6+sI
         16eRMQvKlQYAvfQQwZ56jEdIBc8cANV1+GpRw5LSeuk3RodAdEha2P9WiKfXiO27SdMC
         rKaw==
X-Forwarded-Encrypted: i=1; AJvYcCWkDFRT7sYC8glPsOspxQ+3AGKQt6WXZR2dgvUzEbXaik7955J+vr3E2JdSkwh6kEv6kNyNpeFPalUHD8amBAmOctSfd1TTI+yuxWm5
X-Gm-Message-State: AOJu0YxK4Kmi91Z+60WXNTB9/pR7fNsrLY2h8YN4yxBk9Je15uuIAnH1
	pKZ7IxowrSI/9r7WtJ/pwrexkzHHMg+y0Fm03iELboQEeicWu7Yb1oYyVzWR8vt3RmmcVlFDl/c
	1iKqNdD6rURh8Q7cImSwHHVYZHGG02WCzlx/re4h+N1Yu2B+whTKUNV8yJ79XFg==
X-Received: by 2002:a05:600c:3c8b:b0:424:8a34:9890 with SMTP id 5b1f17b1804b1-4256450c71cmr20366985e9.7.1719496459330;
        Thu, 27 Jun 2024 06:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6ZDKgOsestPJsEme1T/lSWDIbhrr4N0IqHl7IMAoeTdZ/akFCiMzQLQ6EWTdO3nnTz4fRHQ==
X-Received: by 2002:a05:600c:3c8b:b0:424:8a34:9890 with SMTP id 5b1f17b1804b1-4256450c71cmr20366745e9.7.1719496458882;
        Thu, 27 Jun 2024 06:54:18 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b7d1a8sm28419395e9.27.2024.06.27.06.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 06:54:18 -0700 (PDT)
Message-ID: <1fddf73d-577f-4b4c-996a-818dd99eb489@redhat.com>
Date: Thu, 27 Jun 2024 15:54:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
To: ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: vbabka@suse.cz, svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn,
 baohua@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240626024924.1155558-3-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.06.24 04:49, ran xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> pages, which means of any order, but KPF_THP should only be set
> when the folio is a 2M pmd mappable THP. Since commit 19eaf44954df

"should only be set" -- who says that? :)

The documentation only talks about "Contiguous pages which construct 
transparent hugepages". Sure, when it was added there were only PMD ones.


> ("mm: thp: support allocation of anonymous multi-size THP"),
> multiple orders of folios can be allocated and mapped to userspace,
> so the folio_test_large() check is not sufficient here,
> replace it with folio_test_pmd_mappable() to fix this.
> 

A couple of points:

1) If I am not daydreaming, ever since we supported non-PMD THP in the
    pagecache (much longer than anon mTHP), we already indicate KPF_THP
    for them here. So this is not anon specific? Or am I getting the
    PG_lru check all wrong?

2) Anon THP are disabled as default. If some custom tool cannot deal
    with that "extension" we did with smaller THP, it shall be updated if
    it really has to special-case PMD-mapped THP, before enabled by the
    admin.


I think this interface does exactly what we want, as it is right now. 
Unless there is *good* reason, we should keep it like that.

So I suggest

a) Extend the documentation to just state "THP of any size and any 
mapping granularity" or sth like that.

b) Maybe using folio_test_large_rmappable() instead of "(k & (1 <<
    PG_lru)) || is_anon", so even isolated-from-LRU THPs are indicated
    properly.

c) Whoever is interested in getting the folio size, use this flag along
    with a scan for the KPF_COMPOUND_HEAD.


I'll note that, scanning documentation, PAGE_IS_HUGE currently only 
applies to PMD *mapped* THP. It doesn't consider PTE-mapped THP at all 
(including PMD-ones). Likely, documentation should be updated to state 
"PMD-mapped THP or any hugetlb page".

> Also kpageflags is not only for userspace memory but for all valid pfn
> pages,including slab pages or drivers used pages, so the PG_lru and
> is_anon check are unnecessary here.

I'm completely confused about that statements. We do have KPF_OFFLINE, 
KPF_PGTABLE, KPF_SLAB, ... I'm missing something important.

> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>   fs/proc/page.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 2fb64bdb64eb..3e7b70449c2f 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -146,19 +146,13 @@ u64 stable_page_flags(const struct page *page)
>   		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
>   	else
>   		u |= 1 << KPF_COMPOUND_TAIL;
> +
>   	if (folio_test_hugetlb(folio))
>   		u |= 1 << KPF_HUGE;
> -	/*
> -	 * We need to check PageLRU/PageAnon
> -	 * to make sure a given page is a thp, not a non-huge compound page.
> -	 */
> -	else if (folio_test_large(folio)) {
> -		if ((k & (1 << PG_lru)) || is_anon)
> -			u |= 1 << KPF_THP;
> -		else if (is_huge_zero_folio(folio)) {
> +	else if (folio_test_pmd_mappable(folio)) {

folio_test_pmd_mappable() would not be future safe. It includes anything 
 >= PMD_ORDER as well.


-- 
Cheers,

David / dhildenb


