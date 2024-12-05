Return-Path: <linux-kernel+bounces-433975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BE9E5FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0979288060
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802261B87ED;
	Thu,  5 Dec 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+mClXga"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167719FA7C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431747; cv=none; b=Tz4q2xjIpeUsD3CtQ8+JXF2Q8hSvtn00SHcZeVDeN9rd+oUvy6vO1jdNX71EBIaEitibCe2nylGzLm5j/+hjXBnqV3vnO9cUPAkvFoOKdsN1FrPSZkY5/OVTZCLcnc33jJ/A5fWNjqE8gCMjYqa2783ZyuisXBJXFdtJjlKYQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431747; c=relaxed/simple;
	bh=+KZ/4wagVCcuPq7Hahi3+dYkLjMvPj2faUt5ywA+be4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIH1B1fhuQjRVZPgqvU2B5lLvySEo7xiq8/KHOhUJI4/W4E/q+PlMwOrtHfKBNekWUspzcLbEP04xbZzKYl8iu+wYhKmQjjkPsILFKIJCyMLrBek6bxUZKpyRL/Ji9z3qavO8al/S2OhgQ6SaGTANy+vuhWmgSmunfs9NQIZQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+mClXga; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d89111fe69so8810006d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733431745; x=1734036545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ0AOBeo7g3/i5v/kE4t8H/hzPtN20X0kgA3rN1iWCY=;
        b=y+mClXgago+jieSed/s7w/CPjb3Auf41qrPsXx0x+N3li7SG1E1PMfJGQf2ArjFPl7
         lNa5xqCKcSQFXBgRfhsU0cbCbNCoRhN7ZqXVCKyMVsxIcs5VgXv8cXVflLWzID+s77Ou
         mMurBzrcEOgWBh15+djSwDHNwClIAetK+WclN8J4bv/K1UalZG2t6XFAUoPRGtazU0Js
         z5kAzMP+Q1YVIJWndak3VPF6eHnyanoO9v7ffRvwGVgffncUQN6e7fOArlHSOapX6ISq
         883C3QN1u71z+pbo/DUOJmDq3ZiBhG7NIvYPR7FjiHsPWoURDuc+uNI4g4M2bk4ljsdv
         ydMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733431745; x=1734036545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJ0AOBeo7g3/i5v/kE4t8H/hzPtN20X0kgA3rN1iWCY=;
        b=ieuBTP6bibjAaKW4r1o53aU9Y2KAWcm+vJ1w1gQEiKX88/kXWWD9eM7BtV7sDVGh2x
         TmqJsTNksyLzc7N1+DOrvcIaFSSz2dUxU4vz2WWGS1+IYjqyq/INWMW+wx+jo5kSuS2w
         DPDgzfaGjKtE4GC8ydA8Zuwghx0hAC3LnL2YpwAq2aatcHion2e7aHNKWWNFvuEEHWkH
         PnrRCrv9qlYWlT16lSJcjkXCVUxm+aGV/cfpiNOV8+d3yXAfhqkQSgiWSswgrmzHLBaa
         7IhTTFWgyybP4P7pD+8lXhH6KUaBeSG0vZbNskiWv+fV0QK21iGCsATKAqpc33w9XUUX
         m4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhzljBqwc5DVYjlp4CUHn9RJmyYaPE3HOQMeipT2gbB9ZiKbYrXeyPQH+ABTmUzoeQuSGdFpIq2p8/uJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqWjimKaNkqtC8lp5M3Kzr1EZ+NRVDmCWNaZivhVuavP+HK5f
	WubEKGhteVlWPh7GePKv2BEptIDPGC5iotsNqbk1XFqxiCokxiVNN0x9OZ8XFnyjharJI49rOGB
	vQjsi5mk86BRv1U7JUK8okg10i5P+dcpCTEa3
X-Gm-Gg: ASbGnctmJf8B2xc8SGT4e+5CIYVDCst9AtIUQtzhGOsYop0vKcBsBHQpDl97Zdj9bSB
	kbmn3vzTnSMpq7cKSg3oUXg2n3xrQ
X-Google-Smtp-Source: AGHT+IEp/bZDVUnX9PK/SrZE5TsB07x9bDs8w0nJ0uG7klfMZYUChdd3+Ii9Ezzm7kRYRRN8AHrIP5XBr04cKuzyhgU=
X-Received: by 2002:a05:6214:1bc6:b0:6d4:3b7a:313a with SMTP id
 6a1803df08f44-6d8e71a7e00mr3612176d6.32.1733431744877; Thu, 05 Dec 2024
 12:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
In-Reply-To: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Dec 2024 12:48:28 -0800
Message-ID: <CAJD7tkb4j5oMF6T83mAhmABB6J1_6oH2x00fXtVZB_baMZGwuA@mail.gmail.com>
Subject: Re: [PATCH hotfix] mm: shmem: fix ShmemHugePages at swapout
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:50=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> /proc/meminfo ShmemHugePages has been showing overlarge amounts (more
> than Shmem) after swapping out THPs: we forgot to update NR_SHMEM_THPS.
>
> Add shmem_update_stats(), to avoid repetition, and risk of making that
> mistake again: the call from shmem_delete_from_page_cache() is the bugfix=
;
> the call from shmem_replace_folio() is reassuring, but not really a bugfi=
x
> (replace corrects misplaced swapin readahead, but huge swapin readahead
> would be a mistake).
>
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> Cc: stable@vger.kernel.org
> ---
>  mm/shmem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ccb9629a0f70..f6fb053ac50d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -787,6 +787,14 @@ static bool shmem_huge_global_enabled(struct inode *=
inode, pgoff_t index,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> +static void shmem_update_stats(struct folio *folio, int nr_pages)
> +{
> +       if (folio_test_pmd_mappable(folio))
> +               __lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr_pages);
> +       __lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> +       __lruvec_stat_mod_folio(folio, NR_SHMEM, nr_pages);
> +}
> +
>  /*
>   * Somewhat like filemap_add_folio, but error if expected item has gone.
>   */
> @@ -821,10 +829,7 @@ static int shmem_add_to_page_cache(struct folio *fol=
io,
>                 xas_store(&xas, folio);
>                 if (xas_error(&xas))
>                         goto unlock;
> -               if (folio_test_pmd_mappable(folio))
> -                       __lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr)=
;
> -               __lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
> -               __lruvec_stat_mod_folio(folio, NR_SHMEM, nr);
> +               shmem_update_stats(folio, nr);
>                 mapping->nrpages +=3D nr;
>  unlock:
>                 xas_unlock_irq(&xas);
> @@ -852,8 +857,7 @@ static void shmem_delete_from_page_cache(struct folio=
 *folio, void *radswap)
>         error =3D shmem_replace_entry(mapping, folio->index, folio, radsw=
ap);
>         folio->mapping =3D NULL;
>         mapping->nrpages -=3D nr;
> -       __lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> -       __lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
> +       shmem_update_stats(folio, -nr);
>         xa_unlock_irq(&mapping->i_pages);
>         folio_put_refs(folio, nr);
>         BUG_ON(error);
> @@ -1969,10 +1973,8 @@ static int shmem_replace_folio(struct folio **foli=
op, gfp_t gfp,
>         }
>         if (!error) {
>                 mem_cgroup_replace_folio(old, new);
> -               __lruvec_stat_mod_folio(new, NR_FILE_PAGES, nr_pages);
> -               __lruvec_stat_mod_folio(new, NR_SHMEM, nr_pages);
> -               __lruvec_stat_mod_folio(old, NR_FILE_PAGES, -nr_pages);
> -               __lruvec_stat_mod_folio(old, NR_SHMEM, -nr_pages);
> +               shmem_update_stats(new, nr_pages);
> +               shmem_update_stats(old, -nr_pages);
>         }
>         xa_unlock_irq(&swap_mapping->i_pages);
>
> --
> 2.43.0
>

