Return-Path: <linux-kernel+bounces-308741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973896612A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90823B21E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAABD197512;
	Fri, 30 Aug 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bHY+Ir/Y"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D414EC41
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019104; cv=none; b=MCI5gpl4qCSKeCL0WUPw6ogAk2s6NBL5V+8CiaPhPvKt2LP0fgJHBhnxv4u5RU8Y4HFYkOj+77I/fcpqghe1NRumj/75YGmx+GrwE74ActNDiK89dfgVMqPR/1Jb3svK8eTe1aPg4WbC0/7qGtyemz1IBHjIOdTVGu57NJGSyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019104; c=relaxed/simple;
	bh=HvSB4cOBqCOy8cPGNoJ7ibHlaiOl/vV4P/lzLmaTHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/isBYgETqQndjErBBL/ImJaNWwAIZNRGbdp1R26NUPfTk9dGHyHVnkHqNJgcycQ97EBMUa0jVDiyKduSFf8/uvlc61H+Mc3mPKhgLJ83HGzmQmkaA0MRfbyEp8Gxnl3dxok+Weu3UMQnLqiqGS/X+k7wVqX2ag1lGZRtbOwBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bHY+Ir/Y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso11972795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725019101; x=1725623901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/ZmkthQxbD6V/BZNBsTW2rTGIetq2FpOcyt+DGfaOM=;
        b=bHY+Ir/Y0Q3xM1oWuZFeGj2Zu6iS1Irc10MTCrI3sOO4gdcy0vE2ENF8/7mbGf7zOS
         m3bbkCXdlHLKVCPEiNpPc6i0Dgp4awPlhoQMPRHetxS8h6U50O0ede4n/0zESssLsesu
         xUBLo3jF+ND3kwD69982qVZqVF47ntcoX72w1rcUSX4RZcf+1+Oys7qveRFMuApN46gJ
         Yq0+6sPw7ME8fWsRB9iM8JALwaspno9NC6YpiAF9o0APYl0Tdebt1aBzj4GZVG0ggwSD
         MJR3KnP23/1UlDpPhAUhXKlSGLo2MTEpOiSkbCnXiJ8CCSiAyR5/SWmeNR9A82Ts20Yg
         LIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725019101; x=1725623901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/ZmkthQxbD6V/BZNBsTW2rTGIetq2FpOcyt+DGfaOM=;
        b=soH5ZXwhVSMfhKUm75FfSlJFUOb/c1eulF9FPfR30HvrTAB8M2gYx2E/LOum/bz9Zq
         fRb3OrYaS/bIRbP2i7VYUd6a8TAs1SWMENlxDVga8dQKXvsh8wVN9lrtVFE7kV8KeUQN
         Tf8k5hv0CZ7uBdt5RbCfCRpa2UYwDNGIV/H7YO601RMm4fxhjr0fn9He1qtJ88wBww1B
         xlnWXBkIIiKfVnXpRY69oOv9XFGKUQmcoMS3934iKT2ariBbBsBXJc2wpw2RNuuDhrMy
         igYnjlmhab0OnWZ2gxsT2Ys7Lsn7IHgrpNaQvnqGW/tducCylrtdi8SEJ7iB2uT8XzsL
         RbAw==
X-Forwarded-Encrypted: i=1; AJvYcCVL9g+FFnm5WkRD59QvgiHUmwnmHfQZQ8s1MBTH3Ckme+9j2GJa4l7vSnitT86V/92lQa1aUJu5Q7qV6hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+tVIHY3WEKbtEZEiRAVGtZWNnuruz4m57ZVLuKgoJ+PRmA/T
	86TjY4PNVNoioocQ8QhzIsNBFgHhe2fBnP9vLUQVdj98LZbhJ5Z+CZVGUUcMns4=
X-Google-Smtp-Source: AGHT+IFzYA7AZ7liIiwfeRU2/wB4g/pDYvGX+i+cDd+u5PekZ13lqdSLE2abq0T2/0yeckMQce+6BA==
X-Received: by 2002:a05:600c:4586:b0:427:9922:4526 with SMTP id 5b1f17b1804b1-42bb01ae423mr49199545e9.7.1725019100856;
        Fri, 30 Aug 2024 04:58:20 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b960ef94sm565620f8f.103.2024.08.30.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:58:20 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:58:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: fix vmalloc memcg accounting issue
Message-ID: <ZtGz28j4T5tTUEUQ@tiehlicka>
References: <20240830113956.1355-1-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830113956.1355-1-justinjiang@vivo.com>

On Fri 30-08-24 19:39:56, Zhiguo Jiang wrote:
> The oepration of adding 1 for the MEMCG_VMALLOC count value has a
> judgment "if (gfp_mask & __GFP_ACCOUNT)" in vmalloc(), but subtracting
> 1 does not have this judgment in vfree(), which leads to the non-aligned
> count value operation. This patch fixes this issue.

Are you really observing this or have you just concluded this from
reading the code?

AFAIR mod_memcg_page_state will not account if page doesn't have memcg
associated with it which means it is not charged.

> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>  include/linux/vmalloc.h |  1 +
>  mm/vmalloc.c            | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index ad2ce7a6ab7a..0253feec371f
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -38,6 +38,7 @@ struct iov_iter;		/* in uio.h */
>  #define VM_DEFER_KMEMLEAK	0
>  #endif
>  #define VM_SPARSE		0x00001000	/* sparse vm_area. not all pages are present. */
> +#define VM_MEMCG_ACCOUNT	0x00002000	/* mark vm pages alloced with __GFP_ACCOUNT for memcg accounting. */
>  
>  /* bits [20..32] reserved for arch specific ioremap internals */
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d977c280b1c4..aff1bf7a8798
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3125,6 +3125,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  		size += PAGE_SIZE;
>  
>  	area->flags = flags;
> +	/*
> +	 * Set memcg accounting flag in vm_struct, used for
> +	 * vfree() align vmalloc here.
> +	 */
> +	if (gfp_mask & __GFP_ACCOUNT)
> +		area->flags |= VM_MEMCG_ACCOUNT;
>  	area->caller = caller;
>  
>  	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
> @@ -3367,7 +3373,9 @@ void vfree(const void *addr)
>  		struct page *page = vm->pages[i];
>  
>  		BUG_ON(!page);
> -		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
> +
> +		if (vm->flags & VM_MEMCG_ACCOUNT)
> +			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
>  		/*
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
> @@ -3662,7 +3670,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		node, page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> -	if (gfp_mask & __GFP_ACCOUNT) {
> +	if (area->flags & VM_MEMCG_ACCOUNT) {
>  		int i;
>  
>  		for (i = 0; i < area->nr_pages; i++)
> @@ -3813,7 +3821,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		}
>  		goto fail;
>  	}
> -
>  	/*
>  	 * Prepare arguments for __vmalloc_area_node() and
>  	 * kasan_unpoison_vmalloc().
> -- 
> 2.39.0
> 

-- 
Michal Hocko
SUSE Labs

