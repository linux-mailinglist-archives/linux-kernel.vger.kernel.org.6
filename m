Return-Path: <linux-kernel+bounces-300584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E43A95E56F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC7E1F214D7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27F7407A;
	Sun, 25 Aug 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeMC/W8y"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598A29CEF
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724622956; cv=none; b=UL6/7WyaIB584np/NR96hEk9TWNbong0xNi8GeGHsgmIzEEwrGH8Prq0V+IS8rYJhpZt46U+OnoV4VpQju61t8VlM/3j/Nhcel+MI+0eoI/du8Pqulr0Be1bYAy7Zr8Kviu79En3w9V8EJu9dQS1N+hg/LOhPqrHLKfxNNFImrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724622956; c=relaxed/simple;
	bh=dfIdhkiBoKSoD8liR9B5gqg17EvVM4GNY4JQRgHtb7A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t+xYPrPC6mA78gXWvqAxu3fL8GaBgSEs4QfonZlHY64/2ft29/zS/FJ0l7dL/qbiIyFETGZCVc1720bYGb9J0ck4QsQJ0B1wYpAZLt1UDSf0z4uQjtDil7XR9VG1wZxA6fGUU6ZP2m/lV/7+JhoGxTCszhksqXrnTZQUD1TzNmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeMC/W8y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3c396787cso3046871a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724622954; x=1725227754; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi9Fm+R9T0rGJPWvIwJycL3JZ9zC9/GPVe7x98Z67QQ=;
        b=TeMC/W8ydxcmGBdtuLAop/IXGH/ISRm9f7DMzYo0/xFTLoFS/623drotrEaa4lu33L
         cn8uDwt+X7D2Y5T6+uUn+XZTCug0pwi1A95uMxaxP/jAvkYKN/J4agVUl8pEY0nfdIM+
         MLILWM1/IvAEDe2OUrPrd7K6NvoMdCekJVP17vTtrVL+d+hrrLht/WGpHkUBKGMmwUyQ
         tnGgzbOYRLtGL+sNrIvRSY76MWORcQMPmedPY50CzlN3sZWtT6broh8oJtcAvQDdGVEC
         iDjGeo8cvtm2hC8pgs1X3bbwcmdJA0vkgZYb/ymY/yU2d57/xYO+mfTlzyjDypTy9FvW
         FCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724622954; x=1725227754;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi9Fm+R9T0rGJPWvIwJycL3JZ9zC9/GPVe7x98Z67QQ=;
        b=mi5BVarffu94FmN1YsMNkh1GeZXJhWW40VV8EpkAiEYGFB6amigMIA2UPj72OsGP/f
         0E/OsNc2v3oVUgI/ukuTBl2hAf6ainWy8RvDD+VTCLoptOofOPIrttoeuaHdeXDmXzN7
         Tl5a9KIk1TP4AXWip8DezowdsfxRTtdo7ca/naff/cFGWu/zvKCOOYP3P1pSPVOyDH6S
         58n2lcm2s6GEUBgDy4REisSHgnym/iEXnArl/AKYrbitPNhgnei4n18/6KkQm0IT1Jcx
         +JSfEUIVJMoEIemKY/mfqgo4K+LeUzZri4/4Vvy5slrcwTj1K4j+bMk2sYAwHWxiYwQ+
         n7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVTY5yvtyh7+Y/04jrkAXpztv+P43xqXUVPDt0LFmDSrakMfYSDFFEKJgwfW83SxFOqWz4uOw9jbbd+JFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxag+9mSZBpeWZBLT5hjSrR3gYLYjb1HFRY2wS8zG3LgrAwOaWA
	BpRbMKBAGQga4d/GZlERb41o6TpgLh0VH6v+uTioaFDbhAPi7mlbMhXK1hGhLA==
X-Google-Smtp-Source: AGHT+IGrjAP6qyQUpi1/Y6P33R7/e0VuJ5Re8JjRgCmxOA5sj6urQ2h5cv+QC+HFqRz9wA0hKA8bRg==
X-Received: by 2002:a17:90a:6287:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2d646d247f9mr9000335a91.33.1724622953304;
        Sun, 25 Aug 2024 14:55:53 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a58fdbsm8352099a91.29.2024.08.25.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 14:55:52 -0700 (PDT)
Date: Sun, 25 Aug 2024 14:55:41 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
    david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
    ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
    shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
    da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] mm: filemap: use xa_get_order() to get the swap
 entry order
In-Reply-To: <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com>
Message-ID: <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com> <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Baolin Wang wrote:

> In the following patches, shmem will support the swap out of large folios,
> which means the shmem mappings may contain large order swap entries, so
> using xa_get_order() to get the folio order of the shmem swap entry to
> update the '*start' correctly.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/filemap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4130be74f6fd..4c312aab8b1f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2056,6 +2056,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>  		folio = fbatch->folios[idx];
>  		if (!xa_is_value(folio))
>  			nr = folio_nr_pages(folio);
> +		else
> +			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
>  		*start = indices[idx] + nr;
>  	}
>  	return folio_batch_count(fbatch);
> @@ -2120,6 +2122,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  		folio = fbatch->folios[idx];
>  		if (!xa_is_value(folio))
>  			nr = folio_nr_pages(folio);
> +		else
> +			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
>  		*start = indices[idx] + nr;
>  	}
>  	return folio_batch_count(fbatch);
> -- 

Here we have a problem, but I'm not suggesting a fix for it yet: I
need to get other fixes out first, then turn to thinking about this -
it's not easy.

That code is almost always right, so it works well enough for most
people not to have noticed, but there are two issues with it.

The first issue is that it's assuming indices[idx] is already aligned
to nr: not necessarily so.  I believe it was already wrong in the
folio_nr_pages() case, but the time I caught it wrong with a printk
was in the swap (value) case.  (I may not be stating this correctly:
again more thought needed but I can't spend so long writing.)

And immediately afterwards that kernel build failed with a corrupted
(all 0s) .o file - I'm building on ext4 on /dev/loop0 on huge tmpfs while
swapping, and happen to be using the "-o discard" option to ext4 mount.

I've been chasing these failures (maybe a few minutes in, maybe half an
hour) for days, then had the idea of trying without the "-o discard":
whereupon these builds can be repeated successfully for many hours.
IIRC ext4 discard to /dev/loop0 entails hole-punch to the tmpfs.

The alignment issue can easily be corrected, but that might not help.
(And those two functions would look better with the rcu_read_unlock()
moved down to just before returning: but again, wouldn't really help.)

The second issue is that swap is more slippery to work with than
folios or pages: in the folio_nr_pages() case, that number is stable
because we hold a refcount (which stops a THP from being split), and
later we'll be taking folio lock too.  None of that in the swap case,
so (depending on how a large entry gets split) the xa_get_order() result
is not reliable. Likewise for other uses of xa_get_order() in this series.

There needs to be some kind of locking or retry to make the order usable,
and to avoid shmem_free_swap() occasionally freeing more than it ought.
I'll give it thought after.

Hugh

