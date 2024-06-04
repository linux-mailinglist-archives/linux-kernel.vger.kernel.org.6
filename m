Return-Path: <linux-kernel+bounces-200223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E782D8FAD30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A055283E65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C71411F6;
	Tue,  4 Jun 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSTXyiq7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6627446CF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488739; cv=none; b=vFzHNUHrYDbRk6GHO2TEif4oMlGX9nf+8ijn7Rl6uoDXUXtSMpLtT1uLS6QfinFhdCaE9SmdhaAonG+Sd5CLIDDK1I7qDLguUjEcEWck45ivFZOl1/o/v6GJeF96xVBNDdaMODZbGToTsrW2A40w1JE40MfwowXjRtS2WNG1lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488739; c=relaxed/simple;
	bh=OjxiDW8aCLdBjhHwLO5juHvlhuDylHIig6Vdxijp6eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MF4oI1RxJKu+l1/mR6uQU2DmZM4UNNshZpOts82qub2Y902o8fnKtW/UwQJPjac53RHIyfo8YSbpafZ70Sah/m5LlOjIIiZOBS42SA9hayPBkx9URQfCeA+3gAsk/QuCg4858lRYyUdWWV1jTiE3LluirqxcU5FFagRrExhhfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSTXyiq7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717488736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NO46/e2k3bswdUgx3pOlFMftDVA9hEI7Aka+jetV9KM=;
	b=MSTXyiq7Pyv8TSnDAVSJznrLM3U08t3zgxP5728QwdodMpl49bj8xgc1z/abnQ/aBtgOQ4
	0GM0Z3GXTRQIHnQUoDX3fd0n7eO4dS/SRbjY1oeR348LOyurl6zsQqRfXEooiB+fn24/wT
	bGuGy9qonNkdgFjD0VwxsfUcdcEwpM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-meFAFBkCO4WuLgSmGFgqPQ-1; Tue, 04 Jun 2024 04:12:15 -0400
X-MC-Unique: meFAFBkCO4WuLgSmGFgqPQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42120e123beso47774065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 01:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488734; x=1718093534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO46/e2k3bswdUgx3pOlFMftDVA9hEI7Aka+jetV9KM=;
        b=chEIXVf1FsSaVWP99Ci0dwOBJZmgrUEPbC8tL81WDPJPs9LLOMpZv4dzRRRQU+0O1L
         h9Xr3XoxMNTdDfcm0/bBe+8YJbDlE96wg3/7pZr85lSbsdBHOtjXiebPxAzQQC+6guNd
         RSdRsK25A64qK1zs8lCVi8+Oljg3nwScS7T7tkl0NgvK5ZRfsoMNBVQjJm4zp+iahUbn
         xyNOpLq4LhhzaRnz/xxvrFHgchd+qpli48Qm0W0fTXugpkOD6yW1MLgYklgOhCR70kqb
         KTN86tYkWy/tamzGaz5O2Sf1kQ1Sygrv8C0MCrhvzT91QJtNwR77H8zg69PI6Jynzp26
         GgEA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ewI137ySVmqpqNzv1OW9WUgijp0T1B+4HjsdEhdy7i3h7JDGWP7ZP7ESncqqTv33RNT7m50TO38PGXTr1t8Abl7eHNVadMH6+RaL
X-Gm-Message-State: AOJu0YyFPDdLvTSOha7tq1CbSAVYTB13qFTxtkCUzLtQ5TJ9RVte07GK
	/wjWzb/Rt3Qr8gmjdBotxPdyPz5vlFlnZdtJ3HVJnvE4Yitcf1QB1czpghYB8G9ZtOsHptL6K+g
	7hhHzC4lNhEkbIxkeuNXJJHYwLm9kxKyapkZBu+rcy5Ue1If7ytUzVmjqheXlQQ==
X-Received: by 2002:a05:600c:3c9f:b0:41c:2313:da8d with SMTP id 5b1f17b1804b1-4212e004b7amr121595655e9.0.1717488734093;
        Tue, 04 Jun 2024 01:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBkFzGm/IQ6fJfySmp0r/k+mQkzs3zDPPMDyKLC0UxmDPdH+oAHv5eyS+GEvBDE1JWUSSs2g==
X-Received: by 2002:a05:600c:3c9f:b0:41c:2313:da8d with SMTP id 5b1f17b1804b1-4212e004b7amr121595465e9.0.1717488733728;
        Tue, 04 Jun 2024 01:12:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b55sm144195325e9.5.2024.06.04.01.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 01:12:13 -0700 (PDT)
Message-ID: <8d3a60d5-06c5-4df4-aeda-2fbec45a8ae0@redhat.com>
Date: Tue, 4 Jun 2024 10:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240604042454.2012091-3-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 06:24, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> When a folio isn't fit for KSM, the subpages are unlikely to be good,
> So let's skip the rest page checking to save some actions.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---
>   mm/ksm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 97e5b41f8c4b..e2fdb9dd98e2 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2644,6 +2644,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   		goto no_vmas;
>   
>   	for_each_vma(vmi, vma) {
> +		int nr = 1;
> +
>   		if (!(vma->vm_flags & VM_MERGEABLE))
>   			continue;
>   		if (ksm_scan.address < vma->vm_start)
> @@ -2660,6 +2662,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   				cond_resched();
>   				continue;
>   			}
> +
> +			VM_WARN_ON(PageTail(*page));
> +			nr = compound_nr(*page);
>   			if (is_zone_device_page(*page))
>   				goto next_page;
>   			if (PageAnon(*page)) {
> @@ -2672,7 +2677,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   					if (should_skip_rmap_item(*page, rmap_item))
>   						goto next_page;
>   
> -					ksm_scan.address += PAGE_SIZE;
> +					ksm_scan.address += nr * PAGE_SIZE;
>   				} else
>   					put_page(*page);
>   				mmap_read_unlock(mm);
> @@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   			}
>   next_page:
>   			put_page(*page);
> -			ksm_scan.address += PAGE_SIZE;
> +			ksm_scan.address += nr * PAGE_SIZE;
>   			cond_resched();
>   		}
>   	}

You might be jumping over pages that don't belong to that folio. What 
you would actually want to do is somehow use folio_pte_batch() to really 
know the PTEs point at the same folio, so you can skip them. But that's 
not that easy when using follow_page() ...

So I suggest dropping this change for now.

-- 
Cheers,

David / dhildenb


