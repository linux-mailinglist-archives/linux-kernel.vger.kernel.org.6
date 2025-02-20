Return-Path: <linux-kernel+bounces-523502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC29A3D795
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19877AB870
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F461F1527;
	Thu, 20 Feb 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfTig4Et"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487931F152C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049160; cv=none; b=kiHujcysvusff5dqoaJH/mMzqIGXTLKe8nf9B+b8V4hI/In6H7a3qSaN8gzxddaMj6J6IyYtW7UGIqOnvdi+BMyNGAyTKC/7716Xp+tdJghHxz+uh8wnq5h/r3GBBFdLcfG3g5gZ40SWkZCjTOqBuIfNIGdFAWVCHsXeBHIWYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049160; c=relaxed/simple;
	bh=p9G5iijKSGbJ4Hz5iogSKjWDf3rzmHOuLlIYzCwNdn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOdbGkDwJsb0Tf3s840ZuXbk0v5TwHbMiStJ2c1qIJE4AIOQv4+uzSvAm+mcOo8uqV+VDl1+oV0hyM5AkU7ZTPEB4Xj+okmd4p5RZBK9vB1m+sx4xHMXwyIZmks5SLctViimoTonlR+vfB2uGhZO++csZSu9nOMM3gD9rzVn1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfTig4Et; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740049157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vnURZeq1DMt7nmY5gkvj+YkPNwMtqgNMrdcMQ0ZzI5Y=;
	b=LfTig4Et6aZsrldv6fv1SDg8IFB6qyLV5kMOa7ygnfPlMGwDGVhULYVR7xuVwKpnsW0M4V
	J1rrIhmdyle7aOJcLajj50iDbUC4KD8l17OoD3nlwL0I1+12KiMVzvnRY0kTVltoPjWmiC
	cUNrO1nmXF5q+68BD6M+eiOE+oP1g3A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-etDa18tJPrODvZ2X2VwYOA-1; Thu, 20 Feb 2025 05:59:15 -0500
X-MC-Unique: etDa18tJPrODvZ2X2VwYOA-1
X-Mimecast-MFC-AGG-ID: etDa18tJPrODvZ2X2VwYOA_1740049154
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f39352f1dso281221f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740049154; x=1740653954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnURZeq1DMt7nmY5gkvj+YkPNwMtqgNMrdcMQ0ZzI5Y=;
        b=e8M4RMzA3Mnu1BNqsytU0cbSBAakgM+p/+4cKgNJLE3Q4V/KaZZiIYNzO/QVPht2uM
         aNFhdGApsHF1HCfRKvDL0CI1Diy1A/7Rwm2B0/vLN/NlsWnns8vw5G4tqgO96ZOF9ST9
         1awbAM/HhOi0o08y1ZJS7kQMmAKj32C/mJ0MfZxGZiwqQpSJMH9ugtQdY0uxWFjI/SI9
         nVM8xn1Sj9+VO/WU9DQRZUIWV6mxG2v0l+FobuistK8VvyCsSnHsvtpoRgw684O+05nt
         guFB3rz28OdvKf1gc3mPZVhUDHpKvSjxxf0ELDJlnBD9qOm+anwMTcLyagjATD8u4ohG
         csMg==
X-Forwarded-Encrypted: i=1; AJvYcCXQQLX4vha2/u0nBEOssmKT+aLpNyou0nX1Zetha+THEBIX0VbTLSldeNarZH2sC3Gt/857Q/ioixBRl04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JPxu2I9thNNvC7yzFA6QckZP2sOZlR3lQCnZios0fy2c8DHe
	jGdfb3c/EnRk07s+n8DM5CfYv54HiD7e9VhqheVtJWpAh+jNxlcDRiUyv5LkUc6370Z0cfN9hO7
	FgaijGEOiNIhgccoyiFbx2+w3a8cSvXsmRbaT++1u+s1PBnDDOKon6JhdT+xjbmu/Yqmbgw==
X-Gm-Gg: ASbGncvCm2h5gyt6tLedVgBXSJxjILbi4uaJJYGd7DQBYmA/ojDUi6AKRi58JsBcCAF
	reHQG8wOOxWMWjeIRuoMKG+7fnGurEHio4/psewD6SuLHpNMfGYURlgEsSBpc9XbbYVCEDudcEF
	C9L/CZ3rKXztdB4LMhVga3gAZYE1apebJny98QNRG9JXbPvTU260dHuVRUqchhToISHyELiKifm
	5Ut+iXtyIcTLf913SJ1jaB3mrMNhJ3fEjE1IM8gdBvz5ZlGuLJGlkwnAJbNsLdzWS4T7Hxb7/7m
	R1tv7ggtsOs8UJrbCkk4Xl6GGlPGrjJySmcVRbJF00/FVjZCDYtu+5vPLi2QhbzR8/kp59lpdi9
	O1PlAj6yUm7jwL1ZfGtMJxXOz8QsBSQ==
X-Received: by 2002:a5d:64a7:0:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-38f33f1155fmr19019027f8f.8.1740049154362;
        Thu, 20 Feb 2025 02:59:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU1aZcxXD7wcuW3MDI2uNnpwIQ9SbwWHEXKdK9he1xcEMC4J1NN0hnygig+Cl0CN1Jbm7HTQ==
X-Received: by 2002:a5d:64a7:0:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-38f33f1155fmr19019010f8f.8.1740049153998;
        Thu, 20 Feb 2025 02:59:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm20586344f8f.66.2025.02.20.02.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:59:13 -0800 (PST)
Message-ID: <4cb93166-29fd-4aea-965b-5dfb62d4dc8c@redhat.com>
Date: Thu, 20 Feb 2025 11:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: page_ext: add an iteration API for page
 extensions
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <3f0e058aef3951b39cf6bb4259c247352d4fe736.1739931468.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3f0e058aef3951b39cf6bb4259c247352d4fe736.1739931468.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.25 03:17, Luiz Capitulino wrote:
> The page extension implementation assumes that all page extensions of
> a given page order are stored in the same memory section. The function
> page_ext_next() relies on this assumption by adding an offset to the
> current object to return the next adjacent page extension.
> 
> This behavior works as expected for flatmem but fails for sparsemem when
> using 1G pages. The commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for
> gigantic folios") exposes this issue, making it possible for a crash when
> using page_owner or page_table_check page extensions.
> 
> The problem is that for 1G pages, the page extensions may span memory
> section boundaries and be stored in different memory sections. This issue
> was not visible before commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP
> for gigantic folios") because alloc_contig_pages() never passed more than
> MAX_PAGE_ORDER to post_alloc_hook(). However, the series introducing
> mentioned commit changed this behavior allowing the full 1G page order
> to be passed.
> 
> Reproducer:
> 
>   1. Build the kernel with CONFIG_SPARSEMEM=y and table extensions
>      support
>   2. Pass 'default_hugepagesz=1 page_owner=on' in the kernel command-line
>   3. Reserve one 1G page at run-time, this should crash (backtrace below)
> 
> To address this issue, this commit introduces a new API for iterating
> through page extensions. The main iteration loops are for_each_page_ext()
> and for_each_page_ext_order(). Both must be called with the RCU read
> lock taken. Here's an usage example:
> 
> """
> struct page_ext_iter iter;
> struct page_ext *page_ext;
> 
> ...
> 
> rcu_read_lock();
> for_each_page_ext_order(page, order, page_ext, iter) {
> 	struct my_page_ext *obj = get_my_page_ext_obj(page_ext);
> 	...
> }
> rcu_read_unlock();
> """
> 

[...]

> +struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page);
> +struct page_ext *page_ext_iter_next(struct page_ext_iter *iter);
> +
> +/**
> + * page_ext_iter_get() - Get current page extension
> + * @iter: page extension iterator.
> + *
> + * Return: NULL if no page_ext exists for this iterator.
> + */
> +static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *iter)
> +{
> +	return iter->page_ext;
> +}
> +
> +/**
> + * for_each_page_ext(): iterate through page_ext objects.
> + * @__page: the page we're interested in
> + * @__pgcount: how many pages to iterate through
> + * @__page_ext: struct page_ext pointer where the current page_ext
> + *              object is returned
> + * @__iter: struct page_ext_iter object (defined in the stack)
> + *
> + * IMPORTANT: must be called with RCU read lock taken.
> + */
> +#define for_each_page_ext(__page, __pgcount, __page_ext, __iter) \
> +	__page_ext = page_ext_iter_begin(&__iter, __page);     \

Doing stuff out of the loop is dangerous. Assume something does

if (xxx)
	for_each_page_ext()

Just move that inside the for().

for (__page_ext = page_ext_iter_begin(&__iter, __page), __iter.index = 0)

> +	for (__iter.index = 0;                                 \
> +		__page_ext && __iter.index < __pgcount;        \
> +		__page_ext = page_ext_iter_next(&__iter),      \
> +		__iter.index++)

Hm, if we now have an index, why not turn iter.pfn -> iter.start_pfn, 
and only adjust the index in page_ext_iter_next?

Then you can set the index to 0 in page_ext_iter_begin() and have here

for (__page_ext = page_ext_iter_begin(&__iter, __page),
      __page_ext && __iter.index < __pgcount,
      __page_ext = page_ext_iter_next(&__iter);)


A page_ext_iter_reset() could then simply reset the index=0 and
lookup the page_ext(start_pfn + index) == page_ext(start_pfn)

> +
> +/**
> + * for_each_page_ext_order(): iterate through page_ext objects
> + *                            for a given page order
> + * @__page: the page we're interested in
> + * @__order: page order to iterate through
> + * @__page_ext: struct page_ext pointer where the current page_ext
> + *              object is returned
> + * @__iter: struct page_ext_iter object (defined in the stack)
> + *
> + * IMPORTANT: must be called with RCU read lock taken.
> + */
> +#define for_each_page_ext_order(__page, __order, __page_ext, __iter) \
> +	for_each_page_ext(__page, (1UL << __order), __page_ext, __iter)
> +
>   #else /* !CONFIG_PAGE_EXTENSION */
>   struct page_ext;
>   
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 641d93f6af4c1..508deb04d5ead 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -549,3 +549,44 @@ void page_ext_put(struct page_ext *page_ext)
>   
>   	rcu_read_unlock();
>   }
> +
> +/**
> + * page_ext_iter_begin() - Prepare for iterating through page extensions.
> + * @iter: page extension iterator.
> + * @page: The page we're interested in.
> + *
> + * Must be called with RCU read lock taken.
> + *
> + * Return: NULL if no page_ext exists for this page.
> + */
> +struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page)
> +{
> +	iter->pfn = page_to_pfn(page);
> +	iter->page_ext = lookup_page_ext(page);
> +
> +	return iter->page_ext;
> +}
> +
> +/**
> + * page_ext_iter_next() - Get next page extension
> + * @iter: page extension iterator.
> + *
> + * Must be called with RCU read lock taken.
> + *
> + * Return: NULL if no next page_ext exists.
> + */
> +struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
> +{
> +	if (WARN_ON_ONCE(!iter->page_ext))
> +		return NULL;
> +
> +	iter->pfn++;
 > +> +	if (page_ext_iter_next_fast_possible(iter->pfn)) {
> +		iter->page_ext = page_ext_next(iter->page_ext);
> +	} else {
> +		iter->page_ext = lookup_page_ext(pfn_to_page(iter->pfn));
> +	}
> +
> +	return iter->page_ext;
> +}

We now always have a function call when calling into 
page_ext_iter_next(). Could we move that to the header and rather expose 
lookup_page_ext() ?

-- 
Cheers,

David / dhildenb


