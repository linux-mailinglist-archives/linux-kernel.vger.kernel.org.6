Return-Path: <linux-kernel+bounces-297748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5695BD10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16061F2380F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B48A1CEAC6;
	Thu, 22 Aug 2024 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhHClJQD"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CD1CE71E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347464; cv=none; b=maRudZs8GK+J8zjeFhDAsklK89LPpu/GHzkLX8FYt7z9NVg+WsI2ZBB9sYeP+YUVMLljsqmIFKU6+l5eKeLkyK8HTLAVJdkx9ph5aRxReMSfSitzazsaJzy8kYojddeyZlbxN0EsCVOS/fZv7WMG9DcGO0FVwze/2n2Q7ekXeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347464; c=relaxed/simple;
	bh=kj827C8ChuPu/Z8oxS5/HNbsVhpe3k9VLf+rHfA3+h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSi9BEcxVHULOHKQSYUlEof39Qwo18oBOETt1mkzomEkdhTdoW2Rr/XsRPwxNpnlGxy5zAq/7m14gMnxWBUAmBDPQ7Cr9f/h8PR+2WyijtmJess3QRunicPORXMkzIJlm9GAAyjhhlv+4KmkFCzRAiHiNVXlY59B0GHGOcK8h/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IhHClJQD; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d47a9ffd5so3713295ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724347462; x=1724952262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mN5wIRJdiVSlta0TS2suOK6eU9WU8r0xHPYK/6dBy6U=;
        b=IhHClJQDZab8VMWQYq67bEC2NlpHrpgdKTa9bYXJsYY3R4hGRsX+h9EPXDM+lHMI+g
         P43hVZglSSHOwD0/OzbafmBneMVF4mFj1mw4q+mckG2qOA2E2/4LuWYHz4Qzo9jovpe0
         6ZzNWZIXkWl8koSlBNQ7hYawALYJyUHkykKS+PQjN0H+wtPjgKP4DTI3BQri8DR8oDZW
         xrPdvfz4Z6Sk22HDGldlVyXlop2SP8iKzAhEVBUlOCVUMe6blCCqg5poIhIwfghvojCU
         pEPmr+8Ddpj6YkGgHzaYDwClkMMDkhxe8pQ2GxTD0iFTzejJFb2s1g+HshSVR4QY+wFS
         /FlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347462; x=1724952262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN5wIRJdiVSlta0TS2suOK6eU9WU8r0xHPYK/6dBy6U=;
        b=EFMdk5dP5QUiba3+KhDEFU75OjvFxTuZJ85joxe+/LQ+0qc/aM1HeE6U4Y2FThuIRK
         2g1925KQHbktzA1UNOmbMzd/wBaJEf3/a31zsfXKQO4ayUuOTFUHNG07nKLaNrQhFE2r
         Ho3H9CTQ0nhO17ZU00wRdclK5IMIbnIoXlWjXEXS0nSs8vp/LjbRnu94AJXIgarb58gH
         6DYSY7XFvIPnGGFaIvI9ezJmtllbIzPpDBE3H19o+8VpCX0yZWbiB7QdLAw/HGHT6Gx/
         UdrY6tKhSzzHtFu7qN8UYka0Ce6MZNTj6h2jLekE5s8glXGX2jp/4eNmLXm/MGeAR2Of
         Q8NA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Q5i6dJ7t6FKx7ldt29kDdBa2wK5lRrb5XCWHYJf2ngjHJ5REb+RBa0qBFWaaKKXit7zPCHaiNPJ5iaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NZqjMSaGCCA7JfSMMKe1GVrvZwbghvPiHpahBtVtBuFM6f27
	HbDU2CaXs10KBJEL4RdTsSiav/GQKjr3PDFQ88dfW1xwFf65/ZCJRIcCLPqViQ==
X-Google-Smtp-Source: AGHT+IErlP3ypEfi7AAnCViLthU1ABd7chnF50wNfQkKZsISaH+EqLZxPpAtpOSpg9lYobOqy1oXkg==
X-Received: by 2002:a05:6e02:1fe9:b0:39d:2a84:86a3 with SMTP id e9e14a558f8ab-39d6c3585e4mr60926895ab.4.1724347461638;
        Thu, 22 Aug 2024 10:24:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e28:6:b7cf:b486:59da:5224])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f20c6asm562553173.7.2024.08.22.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:24:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:24:14 -0600
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 2/3] mm/cma: add cma_{alloc,free}_folio()
Message-ID: <Zsd0PgAQmbpR8jS6@google.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-3-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814035451.773331-3-yuzhao@google.com>

On Tue, Aug 13, 2024 at 09:54:50PM -0600, Yu Zhao wrote:
> With alloc_contig_range() and free_contig_range() supporting large
> folios, CMA can allocate and free large folios too, by
> cma_alloc_folio() and cma_free_folio().
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/cma.h | 16 +++++++++++++
>  mm/cma.c            | 55 ++++++++++++++++++++++++++++++++-------------
>  2 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 9db877506ea8..d15b64f51336 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -52,4 +52,20 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
>  extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
>  
>  extern void cma_reserve_pages_on_error(struct cma *cma);
> +
> +#ifdef CONFIG_CMA
> +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
> +bool cma_free_folio(struct cma *cma, const struct folio *folio);
> +#else
> +static inline struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> +{
> +	return NULL;
> +}
> +
> +static inline bool cma_free_folio(struct cma *cma, const struct folio *folio)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif
> diff --git a/mm/cma.c b/mm/cma.c
> index 95d6950e177b..4354823d28cf 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma)
>  	spin_unlock_irq(&cma->lock);
>  }
>  
> -/**
> - * cma_alloc() - allocate pages from contiguous area
> - * @cma:   Contiguous memory region for which the allocation is performed.
> - * @count: Requested number of pages.
> - * @align: Requested alignment of pages (in PAGE_SIZE order).
> - * @no_warn: Avoid printing message about failed allocation
> - *
> - * This function allocates part of contiguous memory on specific
> - * contiguous memory area.
> - */
> -struct page *cma_alloc(struct cma *cma, unsigned long count,
> -		       unsigned int align, bool no_warn)
> +static struct page *__cma_alloc(struct cma *cma, unsigned long count,
> +				unsigned int align, gfp_t gfp)
>  {
>  	unsigned long mask, offset;
>  	unsigned long pfn = -1;
> @@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		mutex_lock(&cma_mutex);
> -		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> -				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
>  		mutex_unlock(&cma_mutex);
>  		if (ret == 0) {
>  			page = pfn_to_page(pfn);
> @@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  			page_kasan_tag_reset(nth_page(page, i));
>  	}
>  
> -	if (ret && !no_warn) {
> +	if (ret && !(gfp & __GFP_NOWARN)) {
>  		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
>  				   __func__, cma->name, count, ret);
>  		cma_debug_show_areas(cma);
> @@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	return page;
>  }
>  
> +/**
> + * cma_alloc() - allocate pages from contiguous area
> + * @cma:   Contiguous memory region for which the allocation is performed.
> + * @count: Requested number of pages.
> + * @align: Requested alignment of pages (in PAGE_SIZE order).
> + * @no_warn: Avoid printing message about failed allocation
> + *
> + * This function allocates part of contiguous memory on specific
> + * contiguous memory area.
> + */
> +struct page *cma_alloc(struct cma *cma, unsigned long count,
> +		       unsigned int align, bool no_warn)
> +{
> +	return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +}
> +
> +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> +{
> +	struct page *page;
> +
> +	if (WARN_ON(!order || !(gfp | __GFP_COMP)))

And here too. Thank you.

diff --git a/mm/cma.c b/mm/cma.c
index 4354823d28cf..2d9fae939283 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -522,7 +522,7 @@ struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
 {
 	struct page *page;
 
-	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
+	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
 		return NULL;
 
 	page = __cma_alloc(cma, 1 << order, order, gfp);

