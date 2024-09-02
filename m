Return-Path: <linux-kernel+bounces-311536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CC968A30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A561F22EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7201A2652;
	Mon,  2 Sep 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egiwrAL8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37751A2644
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288150; cv=none; b=p+b5eQxwSDycaPwcb7Ac1+4GqtitWTNoPCGR3PP7dfSQ7zAqxKKPz5ucY1l0Oyjg4KqzR1b3AF4p63C6nZRwFbTJP8BaUyUjFbZUGIRNg3ICUp021gu3tNpl69eg3eSdLrPlCD2qo+m+XAmfyG5YoxR21ZkJEKWlYB9JunXvbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288150; c=relaxed/simple;
	bh=hT4+/im8Shw8AYLNWF1oCRmIlw6rD8nxwdxQiKB80N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXKq8CgWkRy+m8Y2BeKUM/UaQ+/Ap5zoRTtLvrLnC3s6yC+SIMBoAev4Y9T4v5yZEBrUXM6JjE0NzfEyzkSeJL1DgzA/rd0zHq1aEhrG3QmHUC3tNjtFFXEhv/TMVKf/Hau7CxGxIyoKxnGyHzZA4naZE5iXBA2Ak+Xiy7xrlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egiwrAL8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725288147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2MFYfuHNL3RyOhKmQdM5Y+z9WH6X5FHEktceTsR2UCc=;
	b=egiwrAL8trZR+iJPyyCjXN9DTLpGmzWqBThdDx8xHPJ/vnVoq5ZVvr9hknorruFdcgZH1n
	V4L8j5q1TnT8Y9mrFsC+lfd2Fk9jAqH5612SQcwc/oZUKybodACbGhT7UOrEWKeyy2+Tg8
	NiUXtmXIRBT5sLw1qCOyS4fU1nOet28=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-rgWgzenrNNyduroubLy2oQ-1; Mon, 02 Sep 2024 10:42:26 -0400
X-MC-Unique: rgWgzenrNNyduroubLy2oQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bbe9083d1so27475955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725288145; x=1725892945;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2MFYfuHNL3RyOhKmQdM5Y+z9WH6X5FHEktceTsR2UCc=;
        b=U1mAEeuKjhgVlzPX1YBd88WH6WpU40TvPuctsVjaGTn6sX6P46URiZw271wuyGnx+0
         J+pFEHuSMAGQ+n5LzByOwLR0QPnd00vMRmX7Doh2Sz9FXWOgTLpLToVnLMe4TKP0EMzY
         oH2JNRlfpwgD+JLa+LrSUJOwfVMCWfQq3LlaUO5p5BQ3tuPD0Oz6mHji62Wpi33y88c0
         nzFCGZoipP3h1TGtDfsKya/i0SyCOvNyfcINCL7fOCKqpIX0XbvhrwqxckTtzdwIabSx
         DUNPvwcAo3/cjnZb24mbJoQteQui1CvXfwOZMVmuj5opAS6INL+OnJS4Y8af0yJEKOj/
         D2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV9GbOZkg4KP7r+eaUxvf8BFP/fBzSJr7BU0OTzPaPf6C1EeoYtKHtSnaYrUbbNuHFaeLqGeEex0QBnAxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gZYsnLLxv/F5rBNWMdSx0UGGqGjGomahDvTqWkdovq1zPoKd
	xyS3CUlSKhTi3Ih9nrD91AaeTcAicy14pHOpBPgvy0W7cGQlI/vE6Q53n7xS01nHTSqjQux4+0q
	PB9UGTaff9p3pVKC/9YkeGPSansk7Py7s9hFyrjYrzUY3mWjF8yvXy+P1Z0IEfw==
X-Received: by 2002:a05:600c:1d98:b0:42b:a9bb:924a with SMTP id 5b1f17b1804b1-42c7b5d902cmr43481955e9.23.1725288145365;
        Mon, 02 Sep 2024 07:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcdksUugss8NQ3p2NoFd69SVnFW2DOpdbvsLEwvqYT0MzW+uMFtVXyRqwyU2COwN3zbYBjvA==
X-Received: by 2002:a05:600c:1d98:b0:42b:a9bb:924a with SMTP id 5b1f17b1804b1-42c7b5d902cmr43481655e9.23.1725288144487;
        Mon, 02 Sep 2024 07:42:24 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df92f1sm141005245e9.25.2024.09.02.07.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:42:23 -0700 (PDT)
Message-ID: <8f9f16e9-4d89-44ba-a244-9389233b5325@redhat.com>
Date: Mon, 2 Sep 2024 16:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm/page_isolation: remove migratetype from
 move_freepages_block_isolate()
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240828202240.2809740-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.24 22:22, Zi Yan wrote:
> Since migratetype is no longer overwritten during pageblock isolation,
> moving pageblocks to and from MIGRATE_ISOLATE do not need migratetype.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/page-isolation.h |  3 +--
>   mm/page_alloc.c                | 27 +++++++++++++++++++++------
>   mm/page_isolation.c            | 19 +++++++++----------
>   3 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 11b8695115ea..6a62401410c3 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -35,8 +35,7 @@ static inline bool is_migrate_isolate(int migratetype)
>   
>   void set_pageblock_migratetype(struct page *page, int migratetype);
>   
> -bool move_freepages_block_isolate(struct zone *zone, struct page *page,
> -				  int migratetype);
> +bool move_freepages_block_isolate(struct zone *zone, struct page *page);
>   
>   int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   			     int migratetype, int flags, gfp_t gfp_flags);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4ea5cd1a07e2..dc7c36461953 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1764,10 +1764,12 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
>    *
>    * Returns %true if pages could be moved, %false otherwise.
>    */
> -bool move_freepages_block_isolate(struct zone *zone, struct page *page,
> -				  int migratetype)
> +bool move_freepages_block_isolate(struct zone *zone, struct page *page)
>   {
>   	unsigned long start_pfn, pfn;
> +	bool is_block_isolated = get_pageblock_isolate(page);
> +	int from_mt;

I think we should have two functions, one that isolates, another one 
that un-isolates. Or at least make the semantics not depend on the 
current state of the pageblock.

bool pageblock_set_isolated_and_move_free_pages(struct zone *zone, 
struct page *page, bool isolated);

vs.

pageblock_isolate_and_move_free_pages()
pageblock_unisolate_and_move_free_pages()

-- 
Cheers,

David / dhildenb


