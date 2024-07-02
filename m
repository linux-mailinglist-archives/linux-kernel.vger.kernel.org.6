Return-Path: <linux-kernel+bounces-237843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535FE923EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7856F1C22542
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664A19DF98;
	Tue,  2 Jul 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/rRJUa+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F42AF16
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926722; cv=none; b=JaYDd4Q/Rl06r2fseBlXBqD/yF00V8nb56NDKCQX2VfHMkUwR3F2+AcHhzoFEO7U+jVmKkLgWOB04+kKU6x+SaF2KcBN6reTuX6pR+Mh/AR7A5Tcl9u0Y6VbtfIgfLgG3FdxcXnvv8zLtBPV0pP5w/sS1XwYLQicCqduhgVge0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926722; c=relaxed/simple;
	bh=V28C85NExLd8E/9NwRuyjf+Z7OI7pmaKw5DLT5tZm7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCjjPOQnEeKayJcSgOCpmSA6LO2MavpeFdwSlrliy1zxu1gtmviSbF088qBP/o6BIqgDAkowDyKWGrQBlQJqD3pa84Vh5gKSudWkAU6BDnqya0lNSCp4sq8wqNefnli4Sq39JWkiB1Y04iERMWUuw1Oq8djqpcnImwK4UgOOpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/rRJUa+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XvO4S11W1NmtnE2CgxLhh4di6Izp3DpvvC0Ysz6zB1c=;
	b=X/rRJUa+9YCByB6wvcB9LBun9nvzPJ5vClcw2yaB7dqIHHviqs4DhWzmkhAbQyfxetUSAJ
	nq/A2kWYiM5wMJ8TIleE/h7g66biiMfWTIeu2wCFHdc+LMFM4HCA40PnhdDmaoioO6JY4Q
	0a4jZATvvadFHxUjNGQptYez2QHPMRI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-oYiTN_EqNCehtUa5mAzFtw-1; Tue, 02 Jul 2024 09:24:33 -0400
X-MC-Unique: oYiTN_EqNCehtUa5mAzFtw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36536118656so2540828f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926669; x=1720531469;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XvO4S11W1NmtnE2CgxLhh4di6Izp3DpvvC0Ysz6zB1c=;
        b=GMLm9dwI8EwXjg2I5ii7n0dyIbrLk3wDPoJjnWd1JUXrr3qnLh1nb9DMwEiE9dUIJX
         DyXjyJEi37dmJpd958LvYhhi+keVct89aJUwGAFSpdavxYRCgSILYrUM+1Higq9Ev+1M
         3VpIMUHSg2JuQy457krDTvtHVg1hwlKP5G/gzbNeP+piZwZh6ZanVlwdxv6CoIZr0HKa
         7KG4knqO07IVlsRJR1oZZb0L4H+uFCGvMbXU3uEhS7pHY6qoMeQbGNvbg5BKlflJRC9X
         by/B+fjIimFHkrH446ZyLrzL0DR9KQ+kx9er/FejjYEk5Jlnte0b7OoGD/YA7Ozjrjfu
         xLrA==
X-Forwarded-Encrypted: i=1; AJvYcCW8xVMwaOsytzWnI2OMFFbTIHYSqhJGYPHBllbkmJGqfQA+QUrIy190dQnVw7+c0nCXV4FqiwpKEgasxSZbxOPu11O3jVQadEizPMMY
X-Gm-Message-State: AOJu0YxgSbptsL0U/1LJ//tnT5GOmiUUlp2ZSRLsFBe6PpTsZKIrT65L
	5GzVDiz1dLCHgJXJqQ4m3NM2WSnwoyHqGJFECoHJObGpfuj3cIxRhe45e7ugY9jdpRcnbJNHTS3
	NBtfVHIHPPgN8eldqNQOVUJgG8fyQcGr5y0FPn3eORuu3Tze+GJlgPFRbEORZxg==
X-Received: by 2002:a05:6000:1e87:b0:366:553a:92bd with SMTP id ffacd0b85a97d-367756cee8emr4616878f8f.32.1719926669084;
        Tue, 02 Jul 2024 06:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr9AXVKGIlXdj+W3wfpz20IvvIXXhozxVOy5f1k3z7l0Ljhx6NtfYyxw7Tmbdqh309nBAAdA==
X-Received: by 2002:a05:6000:1e87:b0:366:553a:92bd with SMTP id ffacd0b85a97d-367756cee8emr4616853f8f.32.1719926668597;
        Tue, 02 Jul 2024 06:24:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36784e3e0f5sm2013728f8f.11.2024.07.02.06.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 06:24:28 -0700 (PDT)
Message-ID: <3376f8c8-f76d-4f5f-903f-2e9edc968a76@redhat.com>
Date: Tue, 2 Jul 2024 15:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: fix race with
 speculative PFN walkers
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: Frank van der Linden <fvdl@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu
 <peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240627222705.2974207-1-yuzhao@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240627222705.2974207-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.06.24 00:27, Yu Zhao wrote:
> While investigating HVO for THPs [1], it turns out that speculative
> PFN walkers like compaction can race with vmemmap modifications, e.g.,
> 
>    CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
>    -------------------------------  ------------------------------
>    Allocates an LRU folio page1
>                                     Sees page1
>    Frees page1
> 
>    Allocates a hugeTLB folio page2
>    (page1 being a tail of page2)
> 
>    Updates vmemmap mapping page1
>                                     get_page_unless_zero(page1)
> 
> Even though page1->_refcount is zero after HVO, get_page_unless_zero()
> can still try to modify this read-only field, resulting in a crash.
> 
> An independent report [2] confirmed this race.
> 
> There are two discussed approaches to fix this race:
> 1. Make RO vmemmap RW so that get_page_unless_zero() can fail without
>     triggering a PF.
> 2. Use RCU to make sure get_page_unless_zero() either sees zero
>     page->_refcount through the old vmemmap or non-zero page->_refcount
>     through the new one.
> 
> The second approach is preferred here because:
> 1. It can prevent illegal modifications to struct page[] that has been
>     HVO'ed;
> 2. It can be generalized, in a way similar to ZERO_PAGE(), to fix
>     similar races in other places, e.g., arch_remove_memory() on x86
>     [3], which frees vmemmap mapping offlined struct page[].
> 
> While adding synchronize_rcu(), the goal is to be surgical, rather
> than optimized. Specifically, calls to synchronize_rcu() on the error
> handling paths can be coalesced, but it is not done for the sake of
> Simplicity: noticeably, this fix removes ~50% more lines than it adds.
> 
> According to the hugetlb_optimize_vmemmap section in
> Documentation/admin-guide/sysctl/vm.rst, enabling HVO makes allocating
> or freeing hugeTLB pages "~2x slower than before". Having
> synchronize_rcu() on top makes those operations even worse, and this
> also affects the user interface /proc/sys/vm/nr_overcommit_hugepages.
> 
> [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
> [2] https://lore.kernel.org/917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev/
> [3] https://lore.kernel.org/be130a96-a27e-4240-ad78-776802f57cad@redhat.com/
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> ---
>   include/linux/page_ref.h |  8 +++++-
>   mm/hugetlb.c             | 53 ++++++----------------------------------
>   mm/hugetlb_vmemmap.c     | 16 ++++++++++++
>   3 files changed, 30 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 490d0ad6e56d..8c236c651d1d 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -230,7 +230,13 @@ static inline int folio_ref_dec_return(struct folio *folio)
>   
>   static inline bool page_ref_add_unless(struct page *page, int nr, int u)
>   {
> -	bool ret = atomic_add_unless(&page->_refcount, nr, u);
> +	bool ret = false;
> +
> +	rcu_read_lock();
> +	/* avoid writing to the vmemmap area being remapped */
> +	if (!page_is_fake_head(page) && page_ref_count(page) != u)
> +		ret = atomic_add_unless(&page->_refcount, nr, u);
> +	rcu_read_unlock();

The page_is_fake_head() thingy in page_ref.h is a bit suboptimal, 
currently it really only works on _refcount. But I get why it is 
required right now, hmmm.


(independent, all users of page_ref_add_unless seem to pass u==0, maybe 
we should clean that up at some point; hard to imagine other use cases 
for refcounts besides "unless 0").

-- 
Cheers,

David / dhildenb


