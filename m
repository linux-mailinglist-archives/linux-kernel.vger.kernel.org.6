Return-Path: <linux-kernel+bounces-319334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FA96FB3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3791F26F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE3224D7;
	Fri,  6 Sep 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4q6pSY4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D31B85FD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647566; cv=none; b=aHKXUpx6UeJfGuv3Bpfizk72umCs11CN6lDN5DbIm++bCfl/c8GluQvnYAMOn9NUStJO9O1NQeDF3rmfWSwWZbIb6VMQ/Wjc1KEbfLz0JN3qHasL4hmg3rHsm5dzRyBX8FNBWfhQLLBMTrIadtH62n8Cx/2Mo33ik+R6B9O7Zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647566; c=relaxed/simple;
	bh=c0C5mZ9OFx2jd9dUA2KGkQJJVFWRXEtLqfqswWbrbV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcEByBxW3TOSLkrxPu6oHON85AycD93xPLaKVlZf/VmrvgC2izh+BJohXZTGeZY8vGZGpEe7knwD1gS+TYp5q5Royp4ucCeK4CZ/+OC9AyfiEpILnoMukuns0vOGTMbA3fhBiKOWXbSJSC6ZY3w3Z1Lf/+l8Nwwnbs8JOsT3rOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4q6pSY4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa086b077so239966966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725647563; x=1726252363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xZR5pZidPrjdEX8X4OXt++VFgXgiFZPMi5tniCrHIM=;
        b=f4q6pSY4AboVpcA/nbG2a8TKkids7bND3gsbKChEGNnVzsKX8vfzbgPeRm4BJ+GvNg
         CpxbbqWFYw5/keClNnJ4WKxVnwjNlMILUhxE5/e5TalEavk+DpH+HrYHjcihfew0N0Q+
         O6ipEp1nlGQyPmaz3dRwH7oVoVgKn251g++rvnQkNnk/+0pBtJWKk8lvuux269+BHnqn
         qQlMH4Zxj47a6R9KRyP5+3Wjy8QJ9wdvev6daxDNADl6tH+ps0ewGLEWsc3pt2zhSAMG
         ML7Bf6Xlo2BipsqzAXSTLMTDxdsJ6s2kh681GG2ha5Vb8WRfmQ6o5iJtNUggJJbDCKj5
         lYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647563; x=1726252363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xZR5pZidPrjdEX8X4OXt++VFgXgiFZPMi5tniCrHIM=;
        b=qhWl/C1kHmK8oRARHCBH5jMpGq2XMBNUXRTR+yrsmcvL+NzHmPrJTFlGYvAQul7iSY
         hI5Xu9pzN2c95JFmV9z/ss1TyWyF8FSzxfTg+GfMziJzrXatJjnizVoET43x/djPxlES
         WwPdHSc+YdC7JXtqXOzTkwAGH3bqWYefS0FuzuVvnnZT7YJFhCrqYo2sPIhYzdxNeZ40
         k7jYtEn9QtQNCjEVX3RZ+aCJ4wi16xQD+EFdjPw8sPEW4IqLo0jPdEZe09j4XeJmaDuQ
         jtzzCbWIzwdZIfTDDBqKF5RicBzht4txjdp13JaMiDTLOPlvwgUL/pQIZAluwRFuTR8W
         zpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgaRblghtjsu+vKQPL8zmUZ41zj2wLkZGOeApS/B9ADcfxEbEBFUSzC4pGRBhMb/udYUlaZTQ9pYUVTiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalMo4Ettvhlp9JRrGIOvjoTJqEoRQwMO4pZLuLRqhPD/M8GRZ
	idxTqOI+CzYugdUD6fSSQXju3/f5RxFYHKo1JI0TlhEE0ONsg86NCylmEwBBB4CjhNI4YpMGufY
	F8S5S3UL+RUDOSbFC5jHEUkGQGcLVo8bnzexx
X-Google-Smtp-Source: AGHT+IEOp32+s6cAncKwanaXicGS4uaeek9IlbcC59IcvMCUON/lvRWwH4y+J7v1GgByoXLuw4V5pVULf5mqMBnDTZw=
X-Received: by 2002:a17:907:36c7:b0:a86:ab90:6af6 with SMTP id
 a640c23a62f3a-a8a885f9ca6mr259888966b.16.1725647562713; Fri, 06 Sep 2024
 11:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906001047.1245-1-21cnbao@gmail.com> <20240906001047.1245-2-21cnbao@gmail.com>
In-Reply-To: <20240906001047.1245-2-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 6 Sep 2024 11:32:06 -0700
Message-ID: <CAJD7tkb43Of7d0mv4XTRmsRJm3_8LcnvhAnJDiRF6d7+ZQaNNw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] mm: Fix swap_read_folio_zeromap() for large folios
 with partial zeromap
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hanchuanhua@oppo.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hch@infradead.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ryncsn@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
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
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap"=
)
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/page_io.c | 32 +++++++-------------------------
>  mm/swap.h    | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bc77d1c6bfa..2dfe2273a1f1 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *f=
olio)
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
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> -       swp_entry_t entry;
> -       unsigned int i;
> -
> -       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> -               entry =3D page_swap_entry(folio_page(folio, i));
> -               if (!test_bit(swp_offset(entry), sis->zeromap))
> -                       return i;
> -       }
> -       return i;
> -}
> -
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -524,19 +504,21 @@ static void sio_read_complete(struct kiocb *iocb, l=
ong ret)
>
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
> -       unsigned int idx =3D swap_zeromap_folio_test(folio);
> -
> -       if (idx =3D=3D 0)
> -               return false;
> +       int nr_pages =3D folio_nr_pages(folio);
> +       bool is_zeromap;
> +       int nr_zeromap =3D swap_zeromap_batch(folio->swap, nr_pages, &is_=
zeromap);

swap_zeromap_batch() reads to me like the number of entries that are
in the zeromap (i.e. bits are set), not the number of contiguous equal
bits. I can't think of a better name though :/

The local variable is not adding much value here either. It's
reinforcing the misunderstanding I point out above, if anything. You
can just drop that.

>
>         /*
>          * Swapping in a large folio that is partially in the zeromap is =
not
>          * currently handled. Return true without marking the folio uptod=
ate so
>          * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>          */
> -       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +       if (WARN_ON_ONCE(nr_zeromap !=3D nr_pages))
>                 return true;
>
> +       if (!is_zeromap)
> +               return false;
> +
>         folio_zero_range(folio, 0, folio_size(folio));
>         folio_mark_uptodate(folio);
>         return true;
> diff --git a/mm/swap.h b/mm/swap.h
> index f8711ff82f84..1cc56a02fb5f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct fol=
io *folio)
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
> +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> +       unsigned long start =3D swp_offset(entry);
> +       unsigned long end =3D start + max_nr;
> +       bool start_entry_zeromap;
> +
> +       start_entry_zeromap =3D test_bit(start, sis->zeromap);

first_bit is probably a better name.

> +       if (is_zeromap)
> +               *is_zeromap =3D start_entry_zeromap;
> +
> +       if (max_nr <=3D 1)
> +               return max_nr;
> +       if (start_entry_zeromap)
> +               return find_next_zero_bit(sis->zeromap, end, start) - sta=
rt;
> +       else
> +               return find_next_bit(sis->zeromap, end, start) - start;

The usage of these functions look correct to me, although
FIND_NEXT_BIT is not really easy for me to parse :)

