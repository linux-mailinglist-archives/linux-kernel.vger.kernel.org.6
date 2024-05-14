Return-Path: <linux-kernel+bounces-178662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E98C5612
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9941F21D67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F7C66B5E;
	Tue, 14 May 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sLnBucH0"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9C55C08
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690426; cv=none; b=Jzf6O4ALTYEOilXicHZXcAuBY55my+WJSJBF53eSG0Fw9FO4aR3WkvV0ohVXVRHlq9Tec/WlZKzLhm8SHzsWwZouGeBTCNXi3hKysLlZQ8inr8xB6xH0ix9Wm5OXJTQjKVaut3Xn0ydKhA0w6k1s8EI0/vPo9V6E7yo8OGTLwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690426; c=relaxed/simple;
	bh=QZb/mo6ns+8KW5c+bHz3SdWRExM9jZjW/diuq7yXC6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1jJMd6mI3acm3We1XtSI6YN2BVWE/raRxDa7RfDY5iD1bBXpLqOJKiCdUK86ZaySAR4tEfKzSbmBVpJaz0LGY901Sj+eoP0sdW6uBp2+KmP86f8PN++Jg7NKbI1/otQ5eHKW3je5xMdTPcv5zqlK+d8w+htsS0tew53H1hq/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sLnBucH0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de59daab3f3so5256859276.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715690421; x=1716295221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr/2UgPjXu/H0D1UFUJeNgJF+vMnPICm51SvEqdX7wE=;
        b=sLnBucH0ARWe9GOrsBuYeN/tol5XH10mDDQF2zctaoZIrgnSCKW71D2SmZ+1LujIQ9
         Gri/k4R/B1QtyoQiXfszc0P1qdLnMRjWPf2rAJbXmQ7ga+zE/8S4GoJIcCX/YUJvZuf4
         yJpmX0WPMmJaqD48lW0p24OwgMmEq5kL8eyrqKu5ozQeRlhRdvfClYKfMrPHBYOA/U7t
         3uG5LewcN5yBkETe18ErLA1Z+12y4DmXnmonghF5tM8DbEhKaFmYsFzx+2prUM2mtVnO
         q+a5EBtk3LpcOsYrI3ZaaeOUAbHi0lrMoYdaFDZfiXaBFgDCIyFGpFb6XCfh7NlILcNV
         9G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690421; x=1716295221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr/2UgPjXu/H0D1UFUJeNgJF+vMnPICm51SvEqdX7wE=;
        b=fK+vgFNTek5nUbLRo9Ox+zqC9HKgFEStaK0OjBCrKfj3G0Z4MGzy7KeAIwfKSaVkkJ
         AKFHqR75eV7VQ3wMjbzlAMjQZy7aBcs9tiZ0DBV42cH+PJTxDusbjJIMNmiYRatyx4cJ
         G2NEIi2omDLoStGlzhTL3/RuH650qXGDYiwkSe0J7hAa3JTk4HKZxuwmn4uGrOdAoLcV
         y/iW5MfbhgqKl/qT+ujpi1Z3WE7fWU1kZtfuhH2g8Uf2wSpmuGJE2SWivX5WstssiHpR
         fKUr6fGyuCBEZd7a0hcfpXbNa+kGNPdHWJdCPp22Lz830S2ZATPa+InHVMUYIozFrYdE
         xBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1GQWfm9K61xALmVI8/WQqADd6iPIqqJg1VbovdKhJpbnKMw7ZJMq+kidxhQ7idBkwsC77YcVdqXUmVHakwPkLA5gKppxp5+ZRL3b
X-Gm-Message-State: AOJu0YyaFm6e9dolyJRUTEDdv+djPsdoNPw2jkJEuZRAt+489jYGbo3D
	QxSc7XPugeb7pTDISq9B7m9mxZ6mIeH1WIi2JHfPUMK6oOOADjHWWaH7llC7eJo=
X-Google-Smtp-Source: AGHT+IE1+XbMRwozZxpA4C9CaPKdFTjcevNjO2A9IWP4rqyaGNqmRD6s+desWHihx9kNqdTFEJ6FVA==
X-Received: by 2002:a25:a292:0:b0:de6:d7f:2a37 with SMTP id 3f1490d57ef6-dee4f324b52mr11464417276.6.1715690421259;
        Tue, 14 May 2024 05:40:21 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a166309ba5sm47232376d6.122.2024.05.14.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:40:20 -0700 (PDT)
Date: Tue, 14 May 2024 08:40:15 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: fix the incorrect parameter
Message-ID: <20240514124015.GA2697047@cmpxchg.org>
References: <20240514065933.1523170-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514065933.1523170-1-yajun.deng@linux.dev>

On Tue, May 14, 2024 at 02:59:33PM +0800, Yajun Deng wrote:
> The first parameter passed to set_pageblock_migratetype should be the
> buddy, not the page. Let's change it back correctly.

No it shouldn't be.

> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cd584aace6bf..5422f6f8975d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1728,7 +1728,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
>  
>  		del_page_from_free_list(buddy, zone, order,
>  					get_pfnblock_migratetype(buddy, pfn));
> -		set_pageblock_migratetype(page, migratetype);
> +		set_pageblock_migratetype(buddy, migratetype);
>  		split_large_buddy(zone, buddy, pfn, order);

[ pageblock | pageblock ]
^             ^
buddy         page

We're trying to isolate the second pageblock, but it's part of a
bigger buddy. Remove buddy from the free list, update the migratetype
of page, then split and free the chunks back. This puts the first
pageblock back on the original freelist and the second block onto the
isolate list.

In the else branch, it's the first block we're interested in:

[ pageblock | pageblock ]
^
page

So again, take the whole thing off, but now mark the first block
isolate, then split and free.

