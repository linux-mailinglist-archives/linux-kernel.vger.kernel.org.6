Return-Path: <linux-kernel+bounces-271825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5FA94539D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F391F23F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29DD14A4D6;
	Thu,  1 Aug 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2LpHcrF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5E1EB48A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542573; cv=none; b=I72IP4Mg+oytYLDFR0hd7/GNuBsid0Z1PoxC5UoOXfb1ceHal7MeoJ+y7pkMxigAmKSPKLAlaUYLh4hLmOdImkaq32BUe6ui76qoXh0JDeKJ4XVAmGk97z6Z7+NGWcnyiOrnsAfdkUoG4jw3mBaLP5CC+zXYw1NrQoXKdkFefz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542573; c=relaxed/simple;
	bh=cNzGvP8+7SPirPiBstwlvEvXvxwd8wsrgbZbPogWzKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFBVxY3vQ9lLhc3g9F/dvCQyar/xNx2vN7P+8gOwbcr1cdxD5QhGD3+kOGrkNUa9lX+y6oVxXDLMbsDi+kiv2Cc45rFIkcclTYDztcCiFmlReNyv4LDaFv5PHiY8Dl22M4WFyAzG0SIPTzphcQopMi+ixFrR7aqdNWkRhqmBIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2LpHcrF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8553db90so1000054866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722542570; x=1723147370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlkiZo54BZ/zKdNjgu9gaTV31mJk+LsgKPG3sWxE9vc=;
        b=c2LpHcrFFBFZ8YlQflms9M31VTENS66ix41sV1dQ9a4NLwuo1NLHVeokWqHAgQxLmV
         M+Z1tDqHLe87D3+RNnd1bhaUM1pQmimknGDYLJ2k6JDUx3kll7FM5TsC4E3elydtWpVW
         CFjXKKeKU1WIyVw/gHFbLPxRxDwret1A02SYU8HlVTWuywpBZQIJCcklEmzqLTnfPEgO
         4QbwNte6zLmlZEugFHQTS3gLCmcUuY1Gnw0joc22QtfCgqptleYFom9SjfIMePMhb2Nm
         7OfO3tYuUu1dLriwqBRR1A2LGxwD61kaLyFQpnDDihm7mNlnXsL46FI85BM/OgRnvjjp
         U0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542570; x=1723147370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlkiZo54BZ/zKdNjgu9gaTV31mJk+LsgKPG3sWxE9vc=;
        b=sMd7ik4c+QPYlk/tNv7lnyJDog6G82gxVznzjPo9kfJ4kNlUppG0Sltoykoj0hCpyW
         mtgVNomDaLMv+FfwhsF/9UmrVm8FBu8tIWf40vJVFNufFW9MbBqlRtuz4vwkYcxyM45Y
         1mbrIYJHt4Z8ZMCRdKL4+CTtb+/Dfnbra+/Y/52po9OVZ4fUVfbCZufIGlp26tHRWzFC
         U3+IA6e+Vl/fnEHBcZ9UvSgTImeOMAoFhkcENpNyPgcTlbin4P+vpZ45FHaj2b7fvhVd
         5Gbu3FEqit4KTa+Ev/0GzXBWI8Oc/l377VI1ysDn4qyqelzbsSZRcWhJ1PDyaKl6IdJR
         tvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD6NqMpigAhecbQ1v29Iipn+JOMqVmzyJJvxboL7dB08GCWU9XO7JFnUTI5jQL2F9Cy6aFVO//iG+wyoU+JlNop+/o4Hi0xwr9Cwp4
X-Gm-Message-State: AOJu0YzS872RPkip1rBUKwPiWYl2HwEqGodSfZlp+9FnVR+StjAoyYmX
	Uv2qHUSCiCiR+6erlYy1B+JocDIjID5gXT1OQ75YJBlfWOAlR27IspeHhfsV1qp/5i591wlmGgG
	/X04VRHkmtkGBB2yKJoBOw+8VwjuU+10XByd4
X-Google-Smtp-Source: AGHT+IH7npuOr2V8R8GmfqK3qHO01cI/3LfNe2Xe6ngcXgPKH2SSXYEqtYqETgGR8DdlyWt4sZfX9oRGP57DA04+aMY=
X-Received: by 2002:a17:906:fe0e:b0:a6f:6126:18aa with SMTP id
 a640c23a62f3a-a7dc51888c9mr92720066b.67.1722542568848; Thu, 01 Aug 2024
 13:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222707.2324536-1-nphamcs@gmail.com> <20240730222707.2324536-3-nphamcs@gmail.com>
In-Reply-To: <20240730222707.2324536-3-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 1 Aug 2024 13:02:13 -0700
Message-ID: <CAJD7tkbQMB1RBr1mDb_Ye+wvk97mD1D-+uFAxOEw0ZRLZp1yRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] zswap: increment swapin count for non-pivot
 swapped in pages
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 3:27=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Currently, we only increment the swapin counter on pivot pages. This
> means we are not taking into account pages that also need to be swapped
> in, but are already taken care of as part of the readahead window. We

Hmm, but there is a chance that these pages are not actually needed,
in which case we will unnecessarily increase the zswap protection.
Does the readahead window self-correct if the pages were not used?

> are also incrementing when the pages are read from the zswap pool, which
> is inaccurate.

I feel like this is the more important part. It should be the focus of
the commit log with more details (i.e. why is it wrong to increment
the zswap protection in this case).

Do we need a Fixes and cc:stable for this one? Maybe it can be moved
first to make backports easy.

>
> This patch rectifies this issue by incrementing whenever we need to
> perform a non-zswap read.
>
> To test this change, I built the kernel under a cgroup with its
> memory.max set to 2 GB:
>
> real: 236.66s
> user: 4286.06s
> sys: 652.86s
> swapins: 81552
>
> For comparison, with just the new second chance algorithm, the build
> time is as follows:
>
> real: 244.85s
> user: 4327.22s
> sys: 664.39s
> swapins: 94663
>
> Without neither:
>
> real: 263.89s
> user: 4318.11s
> sys: 673.29s
> swapins: 227300.5
>
> (average over 5 runs)
>
> With this change, the kernel CPU time reduces by a further 1.7%, and
> the real time is reduced by another 3.3%, compared to just the second
> chance algorithm by itself. The swapins count also reduces by another
> 13.85%.
>
> Combinng the two changes, we reduce the real time by 10.32%, kernel CPU
> time by 3%, and number of swapins by 64.12%.
>
> To gauge the new scheme's ability to offload cold data, I ran another
> benchmark, in which the kernel was built under a cgroup with memory.max
> set to 3 GB, but with 0.5 GB worth of cold data allocated before each
> build (in a shmem file).
>
> Under the old scheme:
>
> real: 197.18s
> user: 4365.08s
> sys: 289.02s
> zswpwb: 72115.2
>
> Under the new scheme:
>
> real: 195.8s
> user: 4362.25s
> sys: 290.14s
> zswpwb: 87277.8
>
> (average over 5 runs)
>
> Notice that we actually observe a 21% increase in the number of written
> back pages - so the new scheme is just as good, if not better at
> offloading pages from the zswap pool when they are cold. Build time
> reduces by around 0.7% as a result.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/page_io.c    | 11 ++++++++++-
>  mm/swap_state.c |  8 ++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ff8c99ee3af7..0004c9fbf7e8 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -521,7 +521,15 @@ void swap_read_folio(struct folio *folio, struct swa=
p_iocb **plug)
>
>         if (zswap_load(folio)) {
>                 folio_unlock(folio);
> -       } else if (data_race(sis->flags & SWP_FS_OPS)) {
> +               goto finish;
> +       }
> +
> +       /*
> +        * We have to read the page from slower devices. Increase zswap p=
rotection.
> +        */
> +       zswap_folio_swapin(folio);
> +
> +       if (data_race(sis->flags & SWP_FS_OPS)) {
>                 swap_read_folio_fs(folio, plug);
>         } else if (synchronous) {
>                 swap_read_folio_bdev_sync(folio, sis);
> @@ -529,6 +537,7 @@ void swap_read_folio(struct folio *folio, struct swap=
_iocb **plug)
>                 swap_read_folio_bdev_async(folio, sis);
>         }
>
> +finish:
>         if (workingset) {
>                 delayacct_thrashing_end(&in_thrashing);
>                 psi_memstall_leave(&pflags);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a1726e49a5eb..3a0cf965f32b 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -698,10 +698,8 @@ struct folio *swap_cluster_readahead(swp_entry_t ent=
ry, gfp_t gfp_mask,
>         /* The page was likely read above, so no need for plugging here *=
/
>         folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>                                         &page_allocated, false);
> -       if (unlikely(page_allocated)) {
> -               zswap_folio_swapin(folio);
> +       if (unlikely(page_allocated))
>                 swap_read_folio(folio, NULL);
> -       }
>         return folio;
>  }
>
> @@ -850,10 +848,8 @@ static struct folio *swap_vma_readahead(swp_entry_t =
targ_entry, gfp_t gfp_mask,
>         /* The folio was likely read above, so no need for plugging here =
*/
>         folio =3D __read_swap_cache_async(targ_entry, gfp_mask, mpol, tar=
g_ilx,
>                                         &page_allocated, false);
> -       if (unlikely(page_allocated)) {
> -               zswap_folio_swapin(folio);
> +       if (unlikely(page_allocated))
>                 swap_read_folio(folio, NULL);
> -       }
>         return folio;
>  }
>
> --
> 2.43.0

