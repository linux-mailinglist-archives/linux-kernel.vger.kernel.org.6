Return-Path: <linux-kernel+bounces-279981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E775194C420
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA6C1C21EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AD1465BB;
	Thu,  8 Aug 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZEbtoKs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DB55769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140779; cv=none; b=OgVL/a4bZqsNnZwS6x75z0jnEy8ZFTaOkA4f/DERg5u9ALOIY3Xr4QW+AdOt0e5DFeRJjH0iERaGzBawY/mRmMVZRoKBbPpTUaHCcUTGJk4ji0uhtg0y+VRnSSXWL3qcSXHZNy/m0F59fhakFRwMgKQTwEd2MbcmHCV1T3PxnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140779; c=relaxed/simple;
	bh=VrjY+3ZdCYNijwzf5GMnqknTkVXUne9BO+PHggg/zWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xe14g5HtMD/m+hn9rI7YsA/q/c6evS3Z9E1h7iaQ7iZ9VEoBuOYeZWT7F4AzXvsMpZppw+OnklPGFkTVSn3RaBfW7uPPmS4BOEcV1VAzeycRi9sE6qUJgQwicwpCusBLIDI/XyF27I6QuO6N5JfLHT7nJ08qcr3GKsah8wBfYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZEbtoKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723140776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sby/LX1Z7JxkNjpyIbfQ0FNVYX/5ZiYS7SaHjE6I1kI=;
	b=OZEbtoKs2YFoBdQkw212KL3fna+2mJV+xqBY19sVAwjhrT8UdD6hQkhGut+B7NoK02eSUm
	4hzwbVeAt8qgCcGtWwVd8XjQAevYtylTiJr0RAYCcbSv6CkIrNmewMsXLXrVK4Bd2iQYeo
	NHPRohnU900upZL6TtJWL7tYgS1Kp20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-jnVgXUE8OhGAtmNbA6c5CA-1; Thu, 08 Aug 2024 14:12:55 -0400
X-MC-Unique: jnVgXUE8OhGAtmNbA6c5CA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so9240145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723140774; x=1723745574;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sby/LX1Z7JxkNjpyIbfQ0FNVYX/5ZiYS7SaHjE6I1kI=;
        b=QONN62kYwGwVmeQrk2dkzYz0oF+rKheT74t7PmtFMTVLVuKWslUVh6FGBEh5cjNdYd
         FFNNwQkzA9ljUZ3v5UalFprPcVK0AYnfLTbt7Tcl2yx+qKeDPHTylgyReVt7U1z6RC67
         WLuON9FTke2IsFl5qQvijNGsY8htarVDYlXq+qc/UwtZ2HxgzTfJlcqj3OayAE9GK0N8
         +NHprsn9vRKd8FNsAdRINucMko3gF0E6afYzaYZhDMWHro4e+ZS31yLCHfJ1MQeV+EVx
         XKh8qJJttr2F9UUi8P82KQnpQ15/k3nJ4Iev0kLCtMqv5wUca23Ggq7ACv8gZ3KsGFbi
         OU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh3weUiH6yZj53QBtuP8eWpTAbBz+h66du+I0wbKAZdo4TMlaADIzE0W7SAzvjNuEQJsIuZZ9KYrQIqzW5vXKrSgdivNZjbMARIYks
X-Gm-Message-State: AOJu0Yw2I6rVgJR4ZRKQr36TXIomiXB6r/P2EvZ9HHiN+fYZbl7kpi/t
	VWLk9PaAvQP25WOse8lJMHJbkWBh/hJvJPm3zHInH5+JiTDoBLhqSDAJnzOGT6tAp2a2FSJql1g
	NKvmygubMT3D34Dq7ai++4XcJ5gmtzd/pJrwY5O8GG6WHGxTnRxZnYSQ6unOP6Q==
X-Received: by 2002:adf:fa4f:0:b0:368:3ee5:e3e1 with SMTP id ffacd0b85a97d-36d273cde58mr1692224f8f.7.1723140774252;
        Thu, 08 Aug 2024 11:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYjRZzGeEoOB+7CuuXgLrCB1uYf8qQUNYyEmlp1E1bTlB1Ve2QnSpVqkr+g30YSrqwVM9+EA==
X-Received: by 2002:adf:fa4f:0:b0:368:3ee5:e3e1 with SMTP id ffacd0b85a97d-36d273cde58mr1692213f8f.7.1723140773726;
        Thu, 08 Aug 2024 11:12:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2693875f8f.95.2024.08.08.11.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:12:53 -0700 (PDT)
Message-ID: <24003526-ba18-42fb-b5c0-7b89872eb61e@redhat.com>
Date: Thu, 8 Aug 2024 20:12:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm: don't account memmap on failure
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com,
 lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com,
 rientjes@google.com, rppt@kernel.org, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org, dan.j.williams@intel.com,
 yi.zhang@redhat.com, alison.schofield@intel.com, yosryahmed@google.com
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-3-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808154237.220029-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 17:42, Pasha Tatashin wrote:
> When in alloc_vmemmap_page_list() memmap is failed to allocate, do
> not account, the memory is going to be release at the function exit.

I would write it as

"When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do 
not account any already-allocated pages: we're going to free all them 
before we return from the function."

Acked-by: David Hildenbrand <david@redhat.com>

> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/hugetlb_vmemmap.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fa83a7b38199..70027869d844 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>   
>   	for (i = 0; i < nr_pages; i++) {
>   		page = alloc_pages_node(nid, gfp_mask, 0);
> -		if (!page) {
> -			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
> +		if (!page)
>   			goto out;
> -		}
>   		list_add(&page->lru, list);
>   	}
> -
>   	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
>   
>   	return 0;

-- 
Cheers,

David / dhildenb


