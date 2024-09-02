Return-Path: <linux-kernel+bounces-311716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82204968CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3616283C4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B781AB6DE;
	Mon,  2 Sep 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxBcByaG"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCF14A0AB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296702; cv=none; b=u019stXrZE+EzR5BA6wcX89Qt5HhtWzFe928UkMqAOyuXlgjWToK86Ro56qviW/djZCbmf5OgIlMhspfKVV3ug9nj+3HK+6FBVluajWqtxy29NIPaxRNddwmvgQjwe4PZY6Li5GaIzkEWGLz0VApmW953iOU3qgZqCHmxXS0Ysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296702; c=relaxed/simple;
	bh=f2N1cBRAJOBgoYUpYrbabJBtAYrjK9br7gYYmJREjOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjHajC0YotrUo5lK1RCSZ6KVOCp0vbcNIiFu4EdwrJGZhCBdDViRv/ssqPfVJu4KqFj6tvEjQM/9pQANo6Ifo/GhNOuMwlGpJGRITnSgF8W5vUTotdVRVdwKSUJYziYI3W/hfsOmDkU9v9FLxPT6bVDAdKgvgFuad+S+oDUw3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxBcByaG; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82a3022be9eso115626939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725296700; x=1725901500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2sUViWtGSE+SSQUfzqcc8NDtch4cMUiPSrgHV/FWcs=;
        b=WxBcByaGC5tXY9F1MFIYRK/372LhMlkAbo2it3REHihaTyzFP9Jig9wFc96av4WocD
         sWrqMPfUNldpWqi8aguKp3D13Jpf+c1tHgNDUmCgnygwz+3DM5ylpUcPQfe5afCiKWRr
         6Ou9Bx8wroyYOumKZ++pfdul7aWl1ITau7V+VYpcxE1jKc7H/nRR1M/bq25YnqA+p23D
         IzpWCYVAnhd79JdXy/bH0STUk+4j9adq9gv6lK6oh9JOv6qdrxa+qOc4xW4L6MRbtxqR
         Qy/w0JWf/AEt2eJovk3z2QeDvnnbWOl/9LQK9RqHK/Dt6GiDeE4uKMXkKCqyrxd4xOfv
         wHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296700; x=1725901500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2sUViWtGSE+SSQUfzqcc8NDtch4cMUiPSrgHV/FWcs=;
        b=gWChAw78Rpm04S3/5C77v0y8cwl7wuliM6J8j6bB3C1Cq1a/GSYEgzbPupakuvA7oo
         wTyJ9n0ccyKO9CE+0ZTIXn1g+JCLrp+x4Ty4TsNdVB3zrLDjxTGYSUSom3s7LsYfaPtz
         FayA4o+f3E3hQxFB9AMu+fmdqlSLdAzqKueBi2kN72cDrZ5Runo14agchduCCqqbzsQ0
         qiG/kMf2lWG6pNUrhLAjxvc1s/crmEnEfBPnDIlfC3Bgf8Uq4HzaKOjym3spjf3AYTb2
         tjOyqdS9xQjU3L2CX9x3K8qT4ezU1uaa4KyYKcF7VOP6mXGqpyWnCxyFwYBgy0jamihV
         +KUA==
X-Forwarded-Encrypted: i=1; AJvYcCXRRSM9f2umqcptXcl0CiFdok3jCE24WerFM6NRf/GIDZeQiMa2jB2iAYXcwO5oJbapy0B8V4GM1wgPAdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0PWcYAT8f3gzDp0HrUHMtuvmEoqXKuz6f6qLBw1RORAn/QSU
	iQvynlVjGKza8f+Mtmj4MHut359TcsSv3Y0pZwRD0RzPfU9sbk0Uz2q4RRuYhA==
X-Google-Smtp-Source: AGHT+IF1Ibh5hMTxP/3lB9P/E9K7M2mspEronZFTVewKXeI3jF3D1jNGtcJqhlIkQf6SIKHS5LHCJQ==
X-Received: by 2002:a05:6e02:1c89:b0:398:fa06:1d71 with SMTP id e9e14a558f8ab-39f49a31d36mr85422125ab.7.1725296700079;
        Mon, 02 Sep 2024 10:05:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e28:6:485e:a0d2:7c59:d251])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afaf38bsm26864565ab.19.2024.09.02.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:04:59 -0700 (PDT)
Date: Mon, 2 Sep 2024 11:04:51 -0600
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 2/3] mm/cma: add cma_{alloc,free}_folio()
Message-ID: <ZtXwM0wqqAPygDXs@google.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-3-yuzhao@google.com>
 <Zsd0PgAQmbpR8jS6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsd0PgAQmbpR8jS6@google.com>

On Thu, Aug 22, 2024 at 11:24:14AM -0600, Yu Zhao wrote:
> On Tue, Aug 13, 2024 at 09:54:50PM -0600, Yu Zhao wrote:
> > With alloc_contig_range() and free_contig_range() supporting large
> > folios, CMA can allocate and free large folios too, by
> > cma_alloc_folio() and cma_free_folio().
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  include/linux/cma.h | 16 +++++++++++++
> >  mm/cma.c            | 55 ++++++++++++++++++++++++++++++++-------------
> >  2 files changed, 56 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 9db877506ea8..d15b64f51336 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -52,4 +52,20 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
> >  extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
> >  
> >  extern void cma_reserve_pages_on_error(struct cma *cma);
> > +
> > +#ifdef CONFIG_CMA
> > +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
> > +bool cma_free_folio(struct cma *cma, const struct folio *folio);
> > +#else
> > +static inline struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline bool cma_free_folio(struct cma *cma, const struct folio *folio)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  #endif
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 95d6950e177b..4354823d28cf 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma)
> >  	spin_unlock_irq(&cma->lock);
> >  }
> >  
> > -/**
> > - * cma_alloc() - allocate pages from contiguous area
> > - * @cma:   Contiguous memory region for which the allocation is performed.
> > - * @count: Requested number of pages.
> > - * @align: Requested alignment of pages (in PAGE_SIZE order).
> > - * @no_warn: Avoid printing message about failed allocation
> > - *
> > - * This function allocates part of contiguous memory on specific
> > - * contiguous memory area.
> > - */
> > -struct page *cma_alloc(struct cma *cma, unsigned long count,
> > -		       unsigned int align, bool no_warn)
> > +static struct page *__cma_alloc(struct cma *cma, unsigned long count,
> > +				unsigned int align, gfp_t gfp)
> >  {
> >  	unsigned long mask, offset;
> >  	unsigned long pfn = -1;
> > @@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
> >  
> >  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
> >  		mutex_lock(&cma_mutex);
> > -		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> > -				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> > +		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
> >  		mutex_unlock(&cma_mutex);
> >  		if (ret == 0) {
> >  			page = pfn_to_page(pfn);
> > @@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
> >  			page_kasan_tag_reset(nth_page(page, i));
> >  	}
> >  
> > -	if (ret && !no_warn) {
> > +	if (ret && !(gfp & __GFP_NOWARN)) {
> >  		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
> >  				   __func__, cma->name, count, ret);
> >  		cma_debug_show_areas(cma);
> > @@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
> >  	return page;
> >  }
> >  
> > +/**
> > + * cma_alloc() - allocate pages from contiguous area
> > + * @cma:   Contiguous memory region for which the allocation is performed.
> > + * @count: Requested number of pages.
> > + * @align: Requested alignment of pages (in PAGE_SIZE order).
> > + * @no_warn: Avoid printing message about failed allocation
> > + *
> > + * This function allocates part of contiguous memory on specific
> > + * contiguous memory area.
> > + */
> > +struct page *cma_alloc(struct cma *cma, unsigned long count,
> > +		       unsigned int align, bool no_warn)
> > +{
> > +	return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> > +}
> > +
> > +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> > +{
> > +	struct page *page;
> > +
> > +	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
> 
> And here too. Thank you.
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 4354823d28cf..2d9fae939283 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -522,7 +522,7 @@ struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
>  {
>  	struct page *page;
>  
> -	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
> +	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
>  		return NULL;
>  
>  	page = __cma_alloc(cma, 1 << order, order, gfp);

And the following instead of the above, if we don't want to warn the
potential bug.

diff --git a/mm/cma.c b/mm/cma.c
index 2d9fae939283..00c30dcee200 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -522,10 +522,7 @@ struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
 {
 	struct page *page;
 
-	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
-		return NULL;
-
-	page = __cma_alloc(cma, 1 << order, order, gfp);
+	page = __cma_alloc(cma, 1 << order, order, gfp | __GFP_COMP);
 
 	return page ? page_folio(page) : NULL;
 }

