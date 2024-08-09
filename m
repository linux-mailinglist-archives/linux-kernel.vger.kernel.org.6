Return-Path: <linux-kernel+bounces-280653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918CC94CD53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B25281CDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759919046B;
	Fri,  9 Aug 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dlX4/Odm"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D01DA21
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195836; cv=none; b=ajwzIIO2xZh7yXM9e9tlVSnB5WarNhwx4kJpDw1J7q361HjZo7TfQEWQckV4yS8KP4iiZH5y0t+vhOL4rsE64nxe/hXLjJflhCwVdIBH9rz0YW5UOqlmW8kT9dc7spVLVnzntJ58YE5PvMbrpLfcRq0+A/YxfbckEexr5mk2+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195836; c=relaxed/simple;
	bh=tdmaRs6BNYebtw8XNYqPvj2lWnzQ4DIdWp18QivOHtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR4KryfJZUEOOk67zCH35xGw+GDNyQ3ItO3XWCKMXGWO/ZpM3gOAzhrX/jChHHzIwxMudVqTUNiXxO+2Kx/XNjvzCHN/yPCgx6taJhOdIJxPhSL59F3kQpfuogSHpP/mtfBqfn3Lsegi2nFhVP9ormK6OFp5wlG5z+ltUZoOIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dlX4/Odm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so2356429a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723195832; x=1723800632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d/kZ1LJefavLTlQyNFcMmpoYpJe8zxqltVX08slcKI=;
        b=dlX4/OdmS5NS8keucXPOlliyHg0rVRqAXuZdXtvUw5MKtz8aFXXoZ4GFNMSHgiXcQT
         bJulFOhy7Vcnp0UWH4vMRbIBDMl3uQspLxGiJChbGt7vh4Ol9RZ6krx2oFnBOY+1uxOg
         +fpn7xZzbTNPBst4/tCTvAamIOzwHzkRz6+8Ta4Fa5f/c75oMv6Wb8npXoDv2mSYR/mf
         oMTiKEWB0VLZGKKWPXyEnqWebFEkbjSSJKUwomN5OcTJ+xtgyPIbInE7K3hM4LPibw2H
         EVFmxAKQgA0f1FCMM4bkxaM/iT1a1vmZHDA0EBkQbw+MSgcroqLhJltiUI59tR8xPTH5
         0RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195832; x=1723800632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d/kZ1LJefavLTlQyNFcMmpoYpJe8zxqltVX08slcKI=;
        b=JEM4V0NB4tiq3PKngJpmW278EVaDL/JcYqjuR5RJq0scEXZK1cmQtB9GyxCaH3JSXm
         yJA1d/FPpP4UPafJkM0XyuWmLP6cJtd5n1Fo6XYPtaUsxETsyXW0dX8us3h1JgbF17F+
         mHdPTNK9nkEtUDXs8/ddR5ZDJHfW0vaSE/ahD9HZpI1dhAp9C7UvBo261INK3is7gIN5
         5gT1HZlk0NBal8WRT3I77/i9bgMqMjLgQz1pxVhxfkOjh1/FO+AZ1bMFFsCyNQgjs420
         zSTKIal+tWUzVfxDgDnZ6caavluiJuVuA8MrMlnAR6c1YRldCd2wjymXc44CRAYaNhzC
         h0tg==
X-Forwarded-Encrypted: i=1; AJvYcCWcxlHDRQ62cQJqy/5zEbPREHQHsCsLhJFjrLRDiuTzEkQtniAha1pALVPn/pLJt7LoysOPA87BmRgMPEpqc4k8xmtU1CzFjOdGgvGt
X-Gm-Message-State: AOJu0YwK45P4JOopjDXVxDALbelQEQu4dql6qg1z8uN5QOGzLBRWK7MR
	knLEu/5NOdDFrf3ifJae81ia9RXf9DNWSj6kOiPSSGRL2gV7+BGtCN9+XeZT14Y=
X-Google-Smtp-Source: AGHT+IFjC0qy3uP2+neAGLE+UMB33qAmjbX/Sw9++k7wwZlr+KvlaqHUFcj9ClAk+hM2cAgKc+ddNQ==
X-Received: by 2002:a05:6402:1913:b0:5b9:df62:15cd with SMTP id 4fb4d7f45d1cf-5bd0a6a554fmr766291a12.32.1723195831962;
        Fri, 09 Aug 2024 02:30:31 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1f0b2sm1370175a12.28.2024.08.09.02.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:30:31 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:30:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1] mm/vmalloc: fix page mapping if vm_area_alloc_pages()
 with high order fallback to order 0
Message-ID: <ZrXhtprBHew7SL_v@tiehlicka>
References: <20240808120121.2878-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808120121.2878-1-hailong.liu@oppo.com>

On Thu 08-08-24 20:00:58, Hailong Liu wrote:
> The __vmap_pages_range_noflush() assumes its argument pages** contains
> pages with the same page shift. However, since commit e9c3cda4d86e
> (mm, vmalloc: fix high order __GFP_NOFAIL allocations), if gfp_flags
> includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> and page allocation failed for high order, the pages** may contain
> two different page shifts (high order and order-0). This could
> lead __vmap_pages_range_noflush() to perform incorrect mappings,
> potentially resulting in memory corruption.
> 
> Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
> kvmalloc(2M, __GFP_NOFAIL|GFP_X)
>     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
>             vmap_pages_range()
>                 vmap_pages_range_noflush()
>                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> 
> We can remove the fallback code because if a high-order
> allocation fails, __vmalloc_node_range_noprof() will retry with
> order-0. Therefore, it is unnecessary to fallback to order-0
> here. Therefore, fix this by removing the fallback code.
> 
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
> Cc: <stable@vger.kernel.org>
> CC: Barry Song <21cnbao@gmail.com>
> CC: Baoquan He <bhe@redhat.com>
> CC: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/vmalloc.c     | 11 ++---------
>  mm/vmalloc.c.rej | 10 ++++++++++

What is this?

>  2 files changed, 12 insertions(+), 9 deletions(-)
>  create mode 100644 mm/vmalloc.c.rej
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..af2de36549d6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			page = alloc_pages_noprof(alloc_gfp, order);
>  		else
>  			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> -		if (unlikely(!page)) {
> -			if (!nofail)
> -				break;
> -
> -			/* fall back to the zero order allocations */
> -			alloc_gfp |= __GFP_NOFAIL;
> -			order = 0;
> -			continue;
> -		}
> +		if (unlikely(!page))
> +			break;

This just makes the NOFAIL allocation fail. So this is not a correct
fix.

> 
>  		/*
>  		 * Higher order allocations must be able to be treated as

-- 
Michal Hocko
SUSE Labs

