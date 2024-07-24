Return-Path: <linux-kernel+bounces-261466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B624293B7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E797E1C24230
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB2E16C6A5;
	Wed, 24 Jul 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hz7riYQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6415ECEA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850541; cv=none; b=CatEqJhz+9exRjWRl7WPGKF2L1rLvbcZddqkf4Qe0uw+92Ujw5VE4WOa7QZzwzAVt6JPrvdx7dvgkG9yhqWjeZKMfLSlLglPVWOG58OdlQbxGH7KADQUQiK08XpM/v7CHsHoq93mk1CQSZH9b+RW6oHm6XaT0I6fhvkg6fWPum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850541; c=relaxed/simple;
	bh=bAuv2q706kZUid9jIKKfKkE9lJuGodK9LcIf+XB9LZc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CjhyHEoGbJzBSPWqHwT+L6SCXSr09l8j8byAftCcgPvUP3DVCc0uCLt5Ct3mDiifcOjL3v9kynrDTdZ21PHEV5gxvOZ8vcbrjRuht8j45Okgds///RXgWswWHiZToSPtVzLSAJKsa7wMdTCSK8KmMR3KDFWZERQd/9T6yxCY1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hz7riYQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B3DC32781;
	Wed, 24 Jul 2024 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721850541;
	bh=bAuv2q706kZUid9jIKKfKkE9lJuGodK9LcIf+XB9LZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hz7riYQDSUckkaoEJSrhSqPMUslc5x+b5z+sD7AjssqmaKHe6VjXcXrLNayo5E+XC
	 wN8y4Hn2EJkG8qmhQwrFdZK248kaA33AHYa2dYNbxTq4TJKRU2XeIxdNVWy1fM2mQo
	 C201sS5RnU+N93dseoF/bxPSriFDOnRV+/ykKL9k=
Date: Wed, 24 Jul 2024 12:48:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/cma: export total and free number of pages for CMA
 areas
Message-Id: <20240724124845.614c03ad39f8af3729cebee6@linux-foundation.org>
In-Reply-To: <20240709163053.2514760-1-fvdl@google.com>
References: <20240709163053.2514760-1-fvdl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 16:30:53 +0000 Frank van der Linden <fvdl@google.com> wrote:

> In addition to the number of allocations and releases, system
> management software may like to be aware of the size of CMA
> areas, and how many pages are available in it. This information
> is currently not available, so export it in total_page and
> available_pages, respectively.
> 
> The name 'available_pages' was picked over 'free_pages' because
> 'free' implies that the pages are unused. But they might not
> be, they just haven't been used by cma_alloc
> 
> The number of available pages is tracked regardless of
> CONFIG_CMA_SYSFS, allowing for a few minor shortcuts in
> the code, avoiding bitmap operations.
> 
> ...
>
> @@ -382,7 +383,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  {
>  	unsigned long next_zero_bit, next_set_bit, nr_zero;
>  	unsigned long start = 0;
> -	unsigned long nr_part, nr_total = 0;
> +	unsigned long nr_part;
>  	unsigned long nbits = cma_bitmap_maxno(cma);
>  
>  	spin_lock_irq(&cma->lock);
> @@ -394,12 +395,12 @@ static void cma_debug_show_areas(struct cma *cma)
>  		next_set_bit = find_next_bit(cma->bitmap, nbits, next_zero_bit);
>  		nr_zero = next_set_bit - next_zero_bit;
>  		nr_part = nr_zero << cma->order_per_bit;
> -		pr_cont("%s%lu@%lu", nr_total ? "+" : "", nr_part,
> +		pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
>  			next_zero_bit);
> -		nr_total += nr_part;
>  		start = next_zero_bit + nr_zero;
>  	}

Can you please explain the above change?

> -	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> +	pr_cont("=> %lu free of %lu total pages\n", cma->available_count,
> +			cma->count);
>  	spin_unlock_irq(&cma->lock);
>  }
>  
> @@ -446,6 +447,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  
>  	for (;;) {
>  		spin_lock_irq(&cma->lock);
> +		if (count > cma->available_count) {

Right here would be a nice place for a comment?

> +			spin_unlock_irq(&cma->lock);
> +			break;
> +		}
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
>  				bitmap_maxno, start, bitmap_count, mask,
>  				offset);


