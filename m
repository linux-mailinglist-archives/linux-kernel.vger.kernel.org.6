Return-Path: <linux-kernel+bounces-542396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF12A4C921
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B631890D37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE6233D92;
	Mon,  3 Mar 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PV+NSoqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C3212B14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021127; cv=none; b=l0R8g8l2HQ2rriKZBSAFZRpRNWOBrvP/rdS7tKubY/adglJZqkKIcX3hm/twKI31WxRAgowhuYlDoxXeiBtyJj7rSw0dV0ePI4R5m5Fmrok8k3RxuPC5W5lrPR8rYBWOXlhXN/RiBtg3agZ430/44CxvHNgV7+dO6aRyYtPK1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021127; c=relaxed/simple;
	bh=A5UlDzl5nbUR4tlKbNSxmhc1+oiZSLIGlJ0yzJ7GSYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeHxozAPa7vwD6N4D84VKLjR1JtO1aZ6WGVsx6XjfElm0HIuLf2idDJ4cYMrlQm6KFl5LWmD9Nlg+OLldmR4JWS+Cr8tHh2D+tkBMdDCR0B2IncTcPKwRLhv0iP2odPMH/1gk2X7CeiwgLRzUtGL5Tzj/LisryaSH5XxsHHBSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PV+NSoqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741021123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTRDB4UFZjsCv4E5dv3rGEUaI4YH49DqaGlGq3dSoiU=;
	b=PV+NSoqXUKHtGDEB7TRA5pqnb7YfSkKFgp8SkOet8VPcVxS923HbkURpOjxvnhhQVGz7Fr
	/x7/2DH+elmVSFlE0WX45WVuWvRD+ZzJEZwjsDiSoses/pc5fn9XK0nvnEHIkeMFq31zNI
	5YQ7UOWJbTEOTjLjt5m5t0Xr1Z++1i8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-gnwJz7u-MmGgTTlh4eD_aw-1; Mon, 03 Mar 2025 11:58:36 -0500
X-MC-Unique: gnwJz7u-MmGgTTlh4eD_aw-1
X-Mimecast-MFC-AGG-ID: gnwJz7u-MmGgTTlh4eD_aw_1741021116
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b88ff443so246270585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021116; x=1741625916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTRDB4UFZjsCv4E5dv3rGEUaI4YH49DqaGlGq3dSoiU=;
        b=VIVwXel/PE+Fe4V3RbPhFgcQZb5xVr6lSZsbJ+bo5QQ/ZuCCWKYQQVN84lR+t5w0hB
         Q+2ZhZQLTB7qNcN2f8S8MCeL8o13EQ4PvvPvocV/rY9LLczkpVIw5vBz/XbOc2QmK0oV
         F4S5/9Z74kQ9yT7rcch51qgt7E78JR+6hF+5gOKlH6eT+m/0sw1rqXcRKm9EKkMze940
         pMJMxyJflADhvRLPFJMTvaC4G5ArwXp+8OunV6kknmYHNYz6WlO4/AOUIDeWbKKv6RQP
         GyuM81p0bxXxr6OYXc2nN/QwspXIpktbCESHEj1c6wjF6hqDjW6hiF0xKDo3kkkLCEkX
         YlQA==
X-Forwarded-Encrypted: i=1; AJvYcCXC2yW0SRsETj8v4vqNEjBbnBVAAEZFYtmMMbzXzDNl9dXPivuNz5z7P/JpMQyzDd3XQMSbF6QhJal8RG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6F2by5uqcJB8snvMCQqTlwN7HDF7GqqkLWXBpmjWDIZIY6Vgu
	o8Nh0TqCsxOs5fllLSQ791e2zhpJbPAbynMf7RZcM8ijNQRKlNzYcSJRMGE9Mi13IWHhW/rUsFO
	1kD8fVs9P41PQ37KLZvUmXfTTU8+hlbnLmDVROHkyVfoDfldOvt9pMHu9hIhIlQ==
X-Gm-Gg: ASbGnctqvUBrOZD/2XHBgdxbuI37BjoudeKXyMNPIdJF5356ULuPmCppFWbm7/t3VJV
	4710cS21sNCEWndo6dk1c3SndYVaVZkaD9lTi1x5OOqkxWLU2Tv97RrUZfAwwmWVLH0FBOT6it5
	p+AJtPJVcZySiyvZgBt4soSUJWg+9FE832w3zzGkQ9S1eYQlsGh/DueXkV7IwdD9wn2pgkB3WEZ
	b0Vpo81YdYpRjfMc6Fe/rTwtmGoipkx1foonszIx/1j3UyVJJLj+N7ljbs5MV8c3MESv3SKyXL0
	3bi/DXU=
X-Received: by 2002:a05:620a:191f:b0:7c0:ab46:396c with SMTP id af79cd13be357-7c39c4b0068mr2096235485a.21.1741021116483;
        Mon, 03 Mar 2025 08:58:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyqb/M8x75akTxj3nvEdRZoMP6dagwsz5JQRmS5VKUbc7hPZabKUoTMmDqPfLiz9tdHjVsMQ==
X-Received: by 2002:a05:620a:191f:b0:7c0:ab46:396c with SMTP id af79cd13be357-7c39c4b0068mr2096232685a.21.1741021116192;
        Mon, 03 Mar 2025 08:58:36 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c5c38f8bsm62446385a.101.2025.03.03.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:58:35 -0800 (PST)
Date: Mon, 3 Mar 2025 11:58:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: update nr_huge_pages and surplus_huge_pages
 together
Message-ID: <Z8Xft6TDTa51mShZ@x1.local>
References: <20250303024105.990297-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303024105.990297-1-liushixin2@huawei.com>

On Mon, Mar 03, 2025 at 10:41:05AM +0800, Liu Shixin wrote:
> In alloc_surplus_hugetlb_folio(), we increase nr_huge_pages and
> surplus_huge_pages separately. In the middle window, if we set
> nr_hugepages to smaller and satisfy count < persistent_huge_pages(h),
> the surplus_huge_pages will be increased by adjust_pool_surplus().
> 
> After adding delay in the middle window, we can reproduce the problem
> easily by following step:
> 
>  1. echo 3 > /proc/sys/vm/nr_overcommit_hugepages
>  2. mmap two hugepages. When nr_huge_pages=2 and surplus_huge_pages=1,
>     goto step 3.
>  3. echo 0 > /proc/sys/vm/nr_huge_pages

Looks reasonable to me.  However I'm not sure whether this may cause
regression on concurrent allocations of surplus pages.

Would it be possible to stick with hugetlb_lock?  IIUC only the allocation
part of alloc_fresh_hugetlb_folio() needs the lock to be released, then
we could also update the two counters together with hugetlb_lock by open
code alloc_fresh_hugetlb_folio(), and move __prep_account_new_huge_page()
out to be after lock taken.

> 
> Finally, nr_huge_pages is less than surplus_huge_pages.
> 
> Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/hugetlb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9faa1034704ff..a900562ea7679 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2248,14 +2248,17 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  	if (hstate_is_gigantic(h))
>  		return NULL;
>  
> +	mutex_lock(&h->resize_lock);
>  	spin_lock_irq(&hugetlb_lock);
>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
>  		goto out_unlock;
>  	spin_unlock_irq(&hugetlb_lock);
>  
>  	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
> -	if (!folio)
> +	if (!folio) {
> +		mutex_unlock(&h->resize_lock);
>  		return NULL;
> +	}
>  
>  	spin_lock_irq(&hugetlb_lock);
>  	/*
> @@ -2268,6 +2271,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>  		folio_set_hugetlb_temporary(folio);
>  		spin_unlock_irq(&hugetlb_lock);
> +		mutex_unlock(&h->resize_lock);
>  		free_huge_folio(folio);
>  		return NULL;
>  	}
> @@ -2277,6 +2281,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  
>  out_unlock:
>  	spin_unlock_irq(&hugetlb_lock);
> +	mutex_unlock(&h->resize_lock);
>  
>  	return folio;
>  }
> -- 
> 2.34.1
> 
> 

-- 
Peter Xu


