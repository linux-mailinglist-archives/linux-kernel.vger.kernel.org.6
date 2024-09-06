Return-Path: <linux-kernel+bounces-319542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894596FE29
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5E92839C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10015B0E8;
	Fri,  6 Sep 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pd8eULJP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB775C613
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663393; cv=none; b=kMNb+AV1skKYdxY2rqekUQP7mVvsDyEVSxNyjKOSmJLDULlW3rZlfrg//Aufo/cXASFrFaVVH0OimQb+4R4MgQy4S23aaDDArSTmy9HcgcBByiJx45RDSFlhjf4el/8LLgfWJcTYQ7xVFOL+/iaoQEjZBxIyCj19E3rKUjTgKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663393; c=relaxed/simple;
	bh=owQU3ZoBGb9gALaXbrMvkB3WR4iFXfXbl5qZR9j/B3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xvdp+XwgDf1gdZAAV1cdUHDrz4fjJgJKqY7cNIUsE3Hu9jKvx0x0MyU9Kq5weuPxTQUDnes6fChrA2xV5wHih0X51BP8mXhrmnTU8gUJyp3PEStat5ycCAxPgNMCrWnGfyWH+X9DIlfxHxEeYoN31/CLUVaMJb82g8943dBDKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pd8eULJP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7929fd64so286528466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725663390; x=1726268190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiNEXxUXaAya/J/V4msCpoH+GzBrHzq/eQ1BTfNZOyg=;
        b=Pd8eULJPtyZ3iZjBlKUxf5fPk4ab8dnC84WAnpw9A7JUlBrqrFYJF0+QEcxJSJmncD
         PnFKeAHTEMvGBRLQHPs38MDkfZ3D2w1XtRAH3AY+o/FHODSB303v1vE9YslYxz+bkpza
         Yeq5MuFmFVMkPl+FlB8RqgtRmCCu9i/Hakqozk8zwawpncIlBDZVY2ZVlFVaHd1TgNmU
         GHkX8xPT+xZer4z8RG5ACn1ASt7lL+NwYAn/0woKsN4xD+bYbTEcOXMBhzfXadLJTa3O
         4tKcJtQ0Nuo2TDv1hUEcY+Y94V07tgl+C2MFH24jR3cwAjqgNkx2lYlXz5hdPwwgs4ds
         b75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725663390; x=1726268190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiNEXxUXaAya/J/V4msCpoH+GzBrHzq/eQ1BTfNZOyg=;
        b=DbXney7wfxY1UXgTP1lYC+4M2zGaBcHT1H3AkGHcgresPJmmi+cBezDeoVZNEpoJpI
         XH6O8kIWAMtbyTjndxbhfx/tTm4zPR1CjBAT/oaerlwqLgqaH9kqMiWQZ1rwkBdBBLVq
         YkbI5mSWgYqcffGD0aoz+owfCXLAOXP8nBbtcyzQ3x7d1oFNBYFuN6A/w1Hc3QIYBKAc
         c1zMsyD9JzF+hEV6Y56dOMCTv0C9vXTfxYfFmt8n+ZL37ZyoOqyWj7NUzQnEjYIQmU6C
         H+53n+op42uJls1tySt/DBDarPek+OCacQT17Bl38ee8TGBSttJ8O4gyqQmXHgKssd4o
         dz8A==
X-Forwarded-Encrypted: i=1; AJvYcCVqLXynVtnAgZDzVOo5yM2fn7PTMxIsXaOQWkQY26ts9+Z0Yq1EI3tplD15q4YHO84ugj10XkKXJyYpcD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NTplBRKKWqD/0qrmoJq611m8B/l+vUgNxgsb2JmlxyTwDDAC
	LdQ/+qfry0KkQxXuee1QpY5BKAS1yZ/d7QvARui4xHYAJ7zDd6HD347TGlU5Ualj+hTt3C7v+3K
	bf2k7RcQkeu9S2Oc9HDVtoaqEWxsqWw7IkE58
X-Google-Smtp-Source: AGHT+IHVaYMNUjIyM5zmQ6DYBa7f2LxFvdld0ZeITpKhBft97oz/KkCwl+fmf8DKk1mlfjh3WU/DXvkc9+cnS7WHjpQ=
X-Received: by 2002:a17:907:a45:b0:a8a:445f:ac4d with SMTP id
 a640c23a62f3a-a8a885f48b3mr363423566b.18.1725663389282; Fri, 06 Sep 2024
 15:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkb43Of7d0mv4XTRmsRJm3_8LcnvhAnJDiRF6d7+ZQaNNw@mail.gmail.com>
 <20240906215842.1603-1-21cnbao@gmail.com>
In-Reply-To: <20240906215842.1603-1-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 6 Sep 2024 15:55:52 -0700
Message-ID: <CAJD7tkakVisOAGn6gOTHovBz4=29D2qdzT8dBPgrPNB6Lb6mTg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] mm: Fix swap_read_folio_zeromap() for large folios
 with partial zeromap
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hanchuanhua@oppo.com, hannes@cmpxchg.org, 
	hch@infradead.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ryncsn@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev, 
	shy828301@gmail.com, surenb@google.com, usamaarif642@gmail.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"

[..]
> Yep :-) with the above two changes, the patch becomes:
>
> From 272c04cb758b8062eaa96a52b855ff79c8afdf6a Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Thu, 5 Sep 2024 11:56:03 +1200
> Subject: [PATCH v8 1/3] mm: Fix swap_read_folio_zeromap() for large folios
>  with partial zeromap
>
> There could be a corner case where the first entry is non-zeromap,
> but a subsequent entry is zeromap. In this case, we should not
> let swap_read_folio_zeromap() return false since we will still
> read corrupted data.
>
> Additionally, the iteration of test_bit() is unnecessary and
> can be replaced with bitmap operations, which are more efficient.
>
> We can adopt the style of swap_pte_batch() and folio_pte_batch() to
> introduce swap_zeromap_batch() which seems to provide the greatest
> flexibility for the caller. This approach allows the caller to either
> check if the zeromap status of all entries is consistent or determine
> the number of contiguous entries with the same status.
>
> Since swap_read_folio() can't handle reading a large folio that's
> partially zeromap and partially non-zeromap, we've moved the code
> to mm/swap.h so that others, like those working on swap-in, can
> access it.
>
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/page_io.c | 32 +++++++-------------------------
>  mm/swap.h    | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bc77d1c6bfa..bc1183299a7d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
>         }
>  }
>
> -/*
> - * Return the index of the first subpage which is not zero-filled
> - * according to swap_info_struct->zeromap.
> - * If all pages are zero-filled according to zeromap, it will return
> - * folio_nr_pages(folio).
> - */
> -static unsigned int swap_zeromap_folio_test(struct folio *folio)
> -{
> -       struct swap_info_struct *sis = swp_swap_info(folio->swap);
> -       swp_entry_t entry;
> -       unsigned int i;
> -
> -       for (i = 0; i < folio_nr_pages(folio); i++) {
> -               entry = page_swap_entry(folio_page(folio, i));
> -               if (!test_bit(swp_offset(entry), sis->zeromap))
> -                       return i;
> -       }
> -       return i;
> -}
> -
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -524,19 +504,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
> -       unsigned int idx = swap_zeromap_folio_test(folio);
> -
> -       if (idx == 0)
> -               return false;
> +       int nr_pages = folio_nr_pages(folio);
> +       bool is_zeromap;
>
>         /*
>          * Swapping in a large folio that is partially in the zeromap is not
>          * currently handled. Return true without marking the folio uptodate so
>          * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>          */
> -       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +       if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
> +                       &is_zeromap) != nr_pages))
>                 return true;
>
> +       if (!is_zeromap)
> +               return false;
> +
>         folio_zero_range(folio, 0, folio_size(folio));
>         folio_mark_uptodate(folio);
>         return true;
> diff --git a/mm/swap.h b/mm/swap.h
> index f8711ff82f84..e0397a197620 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>         return swp_swap_info(folio->swap)->flags;
>  }
> +
> +/*
> + * Return the count of contiguous swap entries that share the same
> + * zeromap status as the starting entry. If is_zeromap is not NULL,
> + * it will return the zeromap status of the starting entry.
> + */
> +static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> +               bool *is_zeromap)
> +{
> +       struct swap_info_struct *sis = swp_swap_info(entry);
> +       unsigned long start = swp_offset(entry);
> +       unsigned long end = start + max_nr;
> +       bool first_bit;
> +
> +       first_bit = test_bit(start, sis->zeromap);
> +       if (is_zeromap)
> +               *is_zeromap = first_bit;
> +
> +       if (max_nr <= 1)
> +               return max_nr;
> +       if (first_bit)
> +               return find_next_zero_bit(sis->zeromap, end, start) - start;
> +       else
> +               return find_next_bit(sis->zeromap, end, start) - start;
> +}
> +
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
> @@ -171,6 +197,13 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>         return 0;
>  }
> +
> +static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> +               bool *has_zeromap)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_SWAP */
>
>  #endif /* _MM_SWAP_H */
> --
> 2.34.1
>
> Thanks
> Barry
>

