Return-Path: <linux-kernel+bounces-363956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713299C8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049641F21278
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2D19340F;
	Mon, 14 Oct 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqA9geiK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1D13CABC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905533; cv=none; b=r8HGtVFAduHETRU9J+tA5npafRy3oL0rIITv1ksng4JeLkGIoDr03bPI1Miwri8Ugwp0o0esOKOqPB+JhV0WP0Vzj0R9MLpDk6aKoTHis12MBPAy00OmQuSrmOMpi41GpF5MRXSud6j9g+olcvvTfXkdfGdVFHwzsDr8H/cCN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905533; c=relaxed/simple;
	bh=sx74vRZX7kkkz5Epg/szFhuKmMudWo7AClbIpoze3K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/PpVvyH1M7pEoy86Gkxd0MPJLcyHHMcYQHLQFh2e/VkkfgJGnTg+S4LVtErCXTeLWU6K3YjnW8WHvFmcO7jtpOU/Q6xY3z396bGC4gSMpwcB5crV2fL1VtmZ1XS7DFVlxS255iOGP2IMzfEwSELGdefMxyJrvdSw49CIMZU33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqA9geiK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728905530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=buBQXTyIlVVvpYgFtaOBeNixVmerWC6gs9O9i5Q5eao=;
	b=fqA9geiKgACYSldNWm0pEsQEFXQc0SnTA0ZPg8GxqexyHS4NxHqq/2siKAvOelzD76/GSO
	OKXrE2GnaZUhErg7+YPGuttd7WyStiGZvktLwO82SE/Zjt/ITUrcuMsxbtTNMsobs1DKj5
	Ilg3CB120VvYMwe7aKkDPTirRKDGFaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-RdM14LUzNIuFNCzqUrPWHw-1; Mon, 14 Oct 2024 07:32:08 -0400
X-MC-Unique: RdM14LUzNIuFNCzqUrPWHw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431177f2bb3so20683945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728905527; x=1729510327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buBQXTyIlVVvpYgFtaOBeNixVmerWC6gs9O9i5Q5eao=;
        b=k2hGptzx97M4byjoIwFG+pIrgI8q8RUyplb/2a2IDn8um31/sZ3/cb4UYSCbEiuLli
         M8WRUpKKMP5FYq+YDehFIkwk9BF0pOZl3IPeG6xkhn/6qJrVMqmAwQ1zaaCeBAfPWQ7o
         VMJ9f+MXaK+tpA312u21idKNpYHCRv7sU2hI3fRRSpI4hVwtowGh70TJJWHr4w30d0lQ
         U1sNIFoQVrADwaO6uEbmba8TyEN16TUeNTc5gqHlQd0bIoL+nhGgwCUp0QGJ8HnYyzCi
         fahWWFais/xsPYhi6nvBKiiknLIICcgrdtUEHTaTCwn0D+FleorG3UHvzxY/XlHo4J6M
         j7ig==
X-Forwarded-Encrypted: i=1; AJvYcCWqA+OULeoVIfxniNsv6SdkQyo4/O4P+uwQl+uPexumsyQCoxeWRk19+VAVxODzOONTnjdr+OMeLvXrKIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyulqS8i1DP++gYZZBPSUByASxzQGzpXxG/gTFJBdb9aCAO7/R
	cVHVjZknswBfyTQSnYovDxpndLlWL5Z9yU/9EpbWmCi05EWd7dfTPHrEueDzQLe6GUNQTThgS8R
	2IRKOixFsBpZApKwzfo/4qQBI8+JdQAdyl3ehIOfKG4IPPXklGcbthgc5ldXZmQ==
X-Received: by 2002:a05:600c:190f:b0:431:251a:9dc9 with SMTP id 5b1f17b1804b1-431256099fdmr70327985e9.25.1728905527603;
        Mon, 14 Oct 2024 04:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG98VPwpWoEVUBpV5FZz8m/ngWDBS02ObK5d+QtEsfSlKS7gSe5WmneDcDW3Eye6TRogi1cpA==
X-Received: by 2002:a05:600c:190f:b0:431:251a:9dc9 with SMTP id 5b1f17b1804b1-431256099fdmr70327725e9.25.1728905527221;
        Mon, 14 Oct 2024 04:32:07 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4b1a0sm148383755e9.14.2024.10.14.04.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 04:32:06 -0700 (PDT)
Message-ID: <74467d4c-3ffc-44c0-8e9c-4d631ef9162e@redhat.com>
Date: Mon, 14 Oct 2024 13:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: khugepaged: fix the incorrect statistics when
 collapsing large file folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 12:24, Baolin Wang wrote:
> Khugepaged already supports collapsing file large folios (including shmem mTHP)
> by commit 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse"), and the
> control parameters in khugepaged: 'khugepaged_max_ptes_swap' and 'khugepaged_max_ptes_none',
> still compare based on PTE granularity to determine whether a file collapse is
> needed. However, the statistics for 'present' and 'swap' in hpage_collapse_scan_file()
> do not take into account the large folios, which may lead to incorrect judgments
> regarding the khugepaged_max_ptes_swap/none parameters, resulting in unnecessary
> file collapses.
> 
> To fix this issue, take into account the large folios' statistics for 'present'
> and 'swap' variables in the hpage_collapse_scan_file().
> 
> Fixes: 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/khugepaged.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ba28ba09fe89..6f8d46d107b4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2267,7 +2267,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   			continue;
>   
>   		if (xa_is_value(folio)) {
> -			++swap;
> +			swap += 1 << xas_get_order(&xas);
>   			if (cc->is_khugepaged &&
>   			    swap > khugepaged_max_ptes_swap) {
>   				result = SCAN_EXCEED_SWAP_PTE;
> @@ -2314,7 +2314,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   		 * is just too costly...
>   		 */
>   
> -		present++;
> +		present += folio_nr_pages(folio);
>   
>   		if (need_resched()) {
>   			xas_pause(&xas);

Looks correct to me:

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


