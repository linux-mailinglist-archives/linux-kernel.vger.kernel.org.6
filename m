Return-Path: <linux-kernel+bounces-300585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAC95E587
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CE01C209AF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755D6FE16;
	Sun, 25 Aug 2024 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMVeuoAI"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EE10E6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724623536; cv=none; b=XSf5+Ybb7aoqXOpdn44C6PWNnhFUsmg9N2m31zTkVND8pKnCVHFIeoV/OCUnylyucUnQS6R+n86gsrhVD2Exjcu9Xkg2zLZHjh7Qq6PoNXi+2qt4ipuGWjcZq6V+IL0W4ng2Eeq2hndHgGTZf8tpO/GBxkIDYn7K6OUDje7HIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724623536; c=relaxed/simple;
	bh=ciryB0BZf6P0Pf5yG3xhzMXeCFXj1RhRHCnmd8iTWBc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uIb0mF6tv+nmeV4nswTb59BHvWt2Eg5Ig6kI/c2nsHgSu+tHtaqbqzJRV4qNZmdcgH13x6P5INaZcQ9gq3aR1l9KvYHHXXmV2imvnFHjpTTkd5eOj626Q5NcuWti01J0iEvKlfLTBRs5y+UV17FV3NaMFK8xxxGE2zlbbYzmuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMVeuoAI; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5e97b84fbso3105509eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724623533; x=1725228333; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/DbmaHqRLlCXqB0erc6lMDhMIgce7/NU5XyP1hIbAA=;
        b=xMVeuoAIGwGzzXUJYGVhECAPo8ab6IJwpOBWEgjSKBZt62tjnDLkoN7AQSF8Hulz60
         wIFq2bLG4l+AcD5dTzK3vjGupoRqelaXPaqcahxyM0Mcx5IEyAEBGgHP8T8trq3+LiqJ
         Yocf6bZs/5ZCkeWamc9si+Jd/r9V7456G5KjiztfO6uk1FLxoUrrJ2Ozww1yLweG+aPD
         +Tu7OX57LfJA2l47V32ihdxQHhgorCSY94xNJhnX/0Gwd2G67kyV6owvrGhXuFSGe7aP
         jQ6XutLYHS2ZNGBwJMp6FUOIHfdlM/+1BAksHkvsU63voe6zx5TKiideZup4OnKMSuTb
         25BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724623533; x=1725228333;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/DbmaHqRLlCXqB0erc6lMDhMIgce7/NU5XyP1hIbAA=;
        b=BVfMHv1xjLd/CSvJFbEt4maGcbrszegGnLRa+iV/kjiNhn3GHZFmEDsyjoBuze9h2G
         m6AvqUy/8uaYuE5TV8Fa0VMYXmcek8Eo2/j2yvgi+dpRwhKHnjnWf3VVYSXlWcRFjdak
         9WVEab5XPTA3CRgBY45G4Y1hjhp/rENEHw/CbFexhU+6yH9/Yv55tgn8QAfsZn1HlNAU
         AocWkTbGpgu3RjaNkLos10hklleke8lCNe5t5zLSMZ2XQVLs5MFP1IXBPQ8hdp0krYC2
         SmTYBxW6qhKbw8YoevzFsRze8xx4t9p8XIdpmIfJB3rdtOllhNezBq21yJ6Rkf71lX/M
         ZsHg==
X-Forwarded-Encrypted: i=1; AJvYcCVFN6evEkm5u8qKfn06p74CUN/ifJKhZFUnDGvnEHjP7217hcaZTCwpLvvLiHZ457ZwuENfm2D6BEZ8Pt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdX62Ay0LlhNSyIynWU0f5muin4wx1S0IL07A6tJY19w/oa8D+
	WGkW1qTWXnWMn8BsC6lTsKoFjJN3g/v6wpFqRY/nkcEkuZhrtXZBcqm6IVwdMg==
X-Google-Smtp-Source: AGHT+IElTOJlfF8aX64jaL6+Z/2zZyZR5ZI3HzlGU9aZNsNDW/Rswb1nhqvqzktlW3QjIkbZUadzIw==
X-Received: by 2002:a05:6820:222a:b0:5dc:a733:d984 with SMTP id 006d021491bc7-5dcc5e9ba9dmr9324315eaf.1.1724623533225;
        Sun, 25 Aug 2024 15:05:33 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dcb5e6894esm1754506eaf.36.2024.08.25.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:05:32 -0700 (PDT)
Date: Sun, 25 Aug 2024 15:05:30 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
    david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
    ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
    shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
    da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] mm: shmem: support large folio allocation for
 shmem_replace_folio()
In-Reply-To: <a41138ecc857ef13e7c5ffa0174321e9e2c9970a.1723434324.git.baolin.wang@linux.alibaba.com>
Message-ID: <ab9070f8-a949-2fb0-5f7b-e392f3242928@google.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com> <a41138ecc857ef13e7c5ffa0174321e9e2c9970a.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Baolin Wang wrote:

> To support large folio swapin for shmem in the following patches, add
> large folio allocation for the new replacement folio in shmem_replace_folio().
> Moreover large folios occupy N consecutive entries in the swap cache
> instead of using multi-index entries like the page cache, therefore
> we should replace each consecutive entries in the swap cache instead
> of using the shmem_replace_entry().
> 
> As well as updating statistics and folio reference count using the number
> of pages in the folio.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/shmem.c | 54 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f6bab42180ea..d94f02ad7bd1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1889,28 +1889,24 @@ static bool shmem_should_replace_folio(struct folio *folio, gfp_t gfp)
>  static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>  				struct shmem_inode_info *info, pgoff_t index)
>  {
> -	struct folio *old, *new;
> -	struct address_space *swap_mapping;
> -	swp_entry_t entry;
> -	pgoff_t swap_index;
> -	int error;
> -
> -	old = *foliop;
> -	entry = old->swap;
> -	swap_index = swap_cache_index(entry);
> -	swap_mapping = swap_address_space(entry);
> +	struct folio *new, *old = *foliop;
> +	swp_entry_t entry = old->swap;
> +	struct address_space *swap_mapping = swap_address_space(entry);
> +	pgoff_t swap_index = swap_cache_index(entry);
> +	XA_STATE(xas, &swap_mapping->i_pages, swap_index);
> +	int nr_pages = folio_nr_pages(old);
> +	int error = 0, i;
>  
>  	/*
>  	 * We have arrived here because our zones are constrained, so don't
>  	 * limit chance of success by further cpuset and node constraints.
>  	 */
>  	gfp &= ~GFP_CONSTRAINT_MASK;
> -	VM_BUG_ON_FOLIO(folio_test_large(old), old);
> -	new = shmem_alloc_folio(gfp, 0, info, index);
> +	new = shmem_alloc_folio(gfp, folio_order(old), info, index);

It is not clear to me whether folio_order(old) will ever be more than 0
here: but if it can be, then care will need to be taken over the gfp flags,
that they are suited to allocating the large folio; and there will need to
be (could be awkward!) fallback to order 0 when that allocation fails.

My own testing never comes to shmem_replace_folio(): it was originally for
one lowend graphics driver; but IIRC there's now a more common case for it.

Hugh

