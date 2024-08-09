Return-Path: <linux-kernel+bounces-280480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6046594CB32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ED1B248FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52897176258;
	Fri,  9 Aug 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzBE+9VW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C7174EFC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188166; cv=none; b=FEaRnT6sOiSrwVoYCspuVltkbyNKh4BXhMCyYTduG2Q+LdIizN6M7Q251l+AU2XOH4J99DBr4qzRWXmBFdsR0546uMr5ySiQWYBp6E72QSqZDoGY/bMCpA1tM2/3c75kru80ZrsnNxRAb5ivB0fU/fCnWCCm0a6BsYwaai5M3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188166; c=relaxed/simple;
	bh=QuBJmyVVZMtOgE35tXZ8YzDcTt8D4eA5FZ3LF7gkFzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC78gJme5CJ+HWqZr1nH2KuakmTglI3dNXM1YCVCqn+DWdzluHeZb759eaB7d7aZpqAy2dWR/iySp2eUtbNTWG9StCgu4qdnQnW4lAs+abq6caTGh5qqBfTmHsI7XrAEixMsuyj3a12aTFb0mPewzrwqs5DkRJxU8ou4i6CskYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzBE+9VW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723188163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=An2AcY81fgO0mdA5c6ZQ8LcJNGMu/xYz+Bw3VWTJl70=;
	b=TzBE+9VWHPaTFpH/suemkUZ7jE9MWKgHOkpWjp2dYHXp2a5Yx9+++cW9NKgFMkFvguvs/J
	hTUk7ALPHONrKwB3r7mApVUBk0xYZI6SJJFCSj7r7r+DHo3AuUpbA0xZsplBoWCfhXcdo2
	VPPGnSgLr6Bd7Q12r4/kApwsPx0CsLI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-FOGg9NGHMoqo9ctir4IJ_A-1; Fri, 09 Aug 2024 03:22:41 -0400
X-MC-Unique: FOGg9NGHMoqo9ctir4IJ_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42816aacabcso12545985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188160; x=1723792960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=An2AcY81fgO0mdA5c6ZQ8LcJNGMu/xYz+Bw3VWTJl70=;
        b=M4QnEifddaNAZTuY132vJqYARmWtE6B4XXh0rfhjQsWDpx4douHuX3JIZNE8zN5FvD
         8a/ZOFOhzaeI05oODytzPE9rx7kDrP70TE44x9gFuU5oIgiOKveEE+bzSgiEkmB8F3xr
         3ichvsoJSWZWO4COfzVu86NpunYNIal/PG20CvTxEfIuWyUA//uHAK3fJbs4Oz3Ew5JQ
         PsKwAjPB3/5l5aT3EMfvTp2d9MWFlfQnc/Zan+bdG83J3801vyRRCt+p2b7neiXK4lw/
         YE6ahQ3yHOVIWyTUpBq6K/lmrnPETfd205dPk7FCMHGJyMHMBKztunQ4yKZHKM4bJVsZ
         DFlg==
X-Forwarded-Encrypted: i=1; AJvYcCUDzAUDKCLuwgKbJPOpks9Qs45LJkS/FfcVN9uruF8R886qcDjuhNyr4SCN9k6Vatnj73ZvBxldOTqYtMwxwotdF/qUQ46pgDI6A18w
X-Gm-Message-State: AOJu0YwNQjEvVneng2r75cRLmvJDW/EjZIPqVnm+/XtifYfs2TxVSYX0
	C9oBJTP5fJ9y3Bk95rnVqamjPTSUHYOlseXLU5TDJf4Pp4gO7c+hn46VQ0fGGtNkYTG3dM1xtax
	yK7A8AgpA+burkttPZ7Bo/VdzuilT3/FbOxEwjeW9BHrsd1YUVuCZYTQ1A9hlIw==
X-Received: by 2002:a05:600c:524f:b0:426:5983:ed0a with SMTP id 5b1f17b1804b1-429c3a52e11mr3293805e9.30.1723188160198;
        Fri, 09 Aug 2024 00:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVlGPUmwvQnxIW84lINbTWk/fw1MaVdMxyhLFrIY+KZPWX+wml0gEB/QSBxFFkDMnr/SckWw==
X-Received: by 2002:a05:600c:524f:b0:426:5983:ed0a with SMTP id 5b1f17b1804b1-429c3a52e11mr3293585e9.30.1723188159678;
        Fri, 09 Aug 2024 00:22:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27156c95sm4397595f8f.22.2024.08.09.00.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:22:39 -0700 (PDT)
Message-ID: <62d758b1-595a-4c05-ab89-3fe43d79f1bf@redhat.com>
Date: Fri, 9 Aug 2024 09:22:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com
References: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
 <20240809070412.33847-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240809070412.33847-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 09:04, Barry Song wrote:
>>>> I would appreciate if we leave the rmap out here.
>>>>
>>>> Can't we handle that when actually freeing the folio? folio_test_anon()
>>>> is sticky until freed.
>>>
>>> To be clearer: we increment the counter when we set a folio anon, which
>>> should indeed only happen in folio_add_new_anon_rmap(). We'll have to
>>> ignore hugetlb here where we do it in hugetlb_add_new_anon_rmap().
>>>
>>> Then, when we free an anon folio we decrement the counter. (hugetlb
>>> should clear the anon flag when an anon folio gets freed back to its
>>> allocator -- likely that is already done).
>>>
>>
>> Sorry that I am talking to myself: I'm wondering if we also have to
>> adjust the counter when splitting a large folio to multiple
>> smaller-but-still-large folios.
> 
> Hi David,
> 
> The conceptual code is shown below. Does this make more
> sense to you? we have a line "mod_mthp_stat(new_order,
> MTHP_STAT_NR_ANON, 1 << (order - new_order));"
> 
> @@ -3270,8 +3272,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>   	/* reset xarray order to new order after split */
>   	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
> -	struct anon_vma *anon_vma = NULL;
> +	bool is_anon = folio_test_anon(folio);
>   	struct address_space *mapping = NULL;
> +	struct anon_vma *anon_vma = NULL;
>   	int order = folio_order(folio);
>   	int extra_pins, ret;
>   	pgoff_t end;
> @@ -3283,7 +3286,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	if (new_order >= folio_order(folio))
>   		return -EINVAL;
>   
> -	if (folio_test_anon(folio)) {
> +	if (is_anon) {
>   		/* order-1 is not supported for anonymous THP. */
>   		if (new_order == 1) {
>   			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> @@ -3323,7 +3326,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	if (folio_test_writeback(folio))
>   		return -EBUSY;
>   
> -	if (folio_test_anon(folio)) {
> +	if (is_anon) {
>   		/*
>   		 * The caller does not necessarily hold an mmap_lock that would
>   		 * prevent the anon_vma disappearing so we first we take a
> @@ -3437,6 +3440,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   			}
>   		}
>   
> +		if (is_anon) {
> +			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> +			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
> +		}
>   		__split_huge_page(page, list, end, new_order);
>   		ret = 0;
>   	} else {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 408ef3d25cf5..c869d0601614 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1039,6 +1039,7 @@ __always_inline bool free_pages_prepare(struct page *page,
>   	bool skip_kasan_poison = should_skip_kasan_poison(page);
>   	bool init = want_init_on_free();
>   	bool compound = PageCompound(page);
> +	bool anon = PageAnon(page);
>   
>   	VM_BUG_ON_PAGE(PageTail(page), page);
>   
> @@ -1130,6 +1131,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>   
>   	debug_pagealloc_unmap_pages(page, 1 << order);
>   
> +	if (anon && compound)
> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> +
>   	return true;

I'd have placed it here, when we are already passed the "PageMappingFlags" check and
shouldn't have any added overhead for most !anon pages IIRC (mostly only anon/ksm pages should
run into that path).

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 408ef3d25cf5..a11b9dd62964 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1079,8 +1079,11 @@ __always_inline bool free_pages_prepare(struct page *page,
                         (page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
                 }
         }
-       if (PageMappingFlags(page))
+       if (PageMappingFlags(page)) {
+               if (PageAnon(page) && compound)
+                       mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
                 page->mapping = NULL;
+       }
         if (is_check_pages_enabled()) {
                 if (free_page_is_bad(page))
                         bad++;

Conceptually LGTM. We account an anon folio as long as it's anon,
even when still GUP-pinned after unmapping it or when temporarily
unmapping+remapping it during migration.

-- 
Cheers,

David / dhildenb


