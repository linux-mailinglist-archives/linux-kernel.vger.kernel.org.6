Return-Path: <linux-kernel+bounces-208764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D79028E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF9DB2150F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAA179A3;
	Mon, 10 Jun 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpTWHtAC"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482677482
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045284; cv=none; b=YapNgdTHmo0p674dw9KSx5f5cmLMr4Boo0GMki0qQKAhjQMFUKwProHEqnAOV9CFyxe4uAlXg2Ws9up7QznHF3ALTdrbD73YhSbOApGlN4IWDYr+Pw5+jJSVJuHPP4CrBFtWx7S6j4RvzgNM2Ni/a4wJlH8EQg38xqNreOcq+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045284; c=relaxed/simple;
	bh=H9Mv/5U+PF4plUGem/Ygqy1uCIWntlHyX/qjGP7Ho/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6rkKOF6zrWr5ZZnFvLniBgvRc5CC3In8ju6UeOxgJHixP2eF8JCA0RroagcgUVX6Xxh0QbRkUC0+vc/ZPij6DGUS6hNAKzQeIMb2yD5ZmKZuTg4DjSeKve2EqPYDjw1Uz4FjYm5LDBQHQ4TpKpQe5ERZhzMnUI9KOQn3QLoVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpTWHtAC; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80b8d45e6b7so611896241.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718045282; x=1718650082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuGUa7CVchxCQzZnDrxry9gBHUUsdKMsQsZqXLfKacE=;
        b=rpTWHtACRO9cfu2mf7XETsYLzsZ3ic7YXzlGF/ekFkil/U00sFVMlRp+O/VUsbmRsd
         O6q3N/rWOagHklte4OlMErLbiyA/FjWI0RfrkEjPqlK5JOcBWPTlLkpqvWJEGpDq4Yto
         U/rh8yGyBj9wzNnDpJAukO/X947I2pXQY9tYCT5ecpfaySNDZj+6eNc7q8ljpBoEgsQO
         8Y2CHBLX6zswE1pHNtzFqzvEcAMMLVO2Svpdt4AMkVa6pPKExM9NvdHbIW2TW8xJxUU4
         Nt5fwMHNun2mT2pigYvlCmeLHytCEPhHgHlzDUDvFE7KEHFU/dToMOxN+S+qWPT+/kOL
         +InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718045282; x=1718650082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuGUa7CVchxCQzZnDrxry9gBHUUsdKMsQsZqXLfKacE=;
        b=KxzVmIDYfSsSyw57EMLg+YJa9QeexMYZWddQKmD2z7f6pqCOgT15OHlK+vJGkvWx6q
         PEW7z725R+IeZs1oIm5t3GVzvp9H0ZtxVyqk34VMTjN4I1siQ7lG+5mk1yjwJlNoJv7l
         OQSC+/o6zLEmoRy96ic3pp30LVg3PmHgDNYUIuMrU5JVsdUH1BeTkdr9GdcRPysAYYTA
         s/U6l7tXLXnPfuAEC8t2j995G50hJDHfm9+CLRn4/m0dMXJzIO7LRqn3JLwAOmNOCvDQ
         wMwkvoLxKRIWVwjlpRcjcBlDVo6GgbUD4Gq0IznWAt5OBR6cQycZ9bGT7DcILppv0bMJ
         P6wg==
X-Forwarded-Encrypted: i=1; AJvYcCXP7w3i4Fe13G0eGY834aDJuf8Nx9XHLl28sPluFKAipwE0Mp9BCxc06gsws/UnNyCxBELv4ECOzbG6gORYSfaHUalI0/LA1Ai4Bo1K
X-Gm-Message-State: AOJu0YxQ/uMN5kdEcrsMfVZL6uuHLtQ/XFATRWcMWT58svi26Pfs/VGo
	6ej0fx7fzT0NJtLjiL11WOmWOcRPFStjLo7cvAAhUz3zOgLQJBHrrlx4z3XaEgN9LtkUKi3pN+W
	UURtk5loMTKhvTzu2kPqhFCOGJnRzI0DQXiOk
X-Google-Smtp-Source: AGHT+IFYp+hxMPPq6Tw4jfx8m1UKvQOQde5VyRSxdjv6ntcwDcAYoaAaXX+ZUFxeuqo7QHBu5dD5nketLn2jRf8xyEI=
X-Received: by 2002:a67:fbda:0:b0:47a:231a:3856 with SMTP id
 ada2fe7eead31-48c275deb29mr11694458137.16.1718045281792; Mon, 10 Jun 2024
 11:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com> <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
 <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com>
In-Reply-To: <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 11:47:24 -0700
Message-ID: <CAJD7tkZoaM=dWim7GPqEERDZyxp3PqMNctzXQCPDMO=8kQSwfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:36=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
> On 10/06/2024 18:57, Yosry Ahmed wrote:
> > On Mon, Jun 10, 2024 at 5:18=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >> Approximately 10-20% of pages to be swapped out are zero pages [1].
> >> Rather than reading/writing these pages to flash resulting
> >> in increased I/O and flash wear, a bitmap can be used to mark these
> >> pages as zero at write time, and the pages can be filled at
> >> read time if the bit corresponding to the page is set.
> >> With this patch, NVMe writes in Meta server fleet decreased
> >> by almost 10% with conventional swap setup (zswap disabled).
> >>
> >> [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d=
03d1344dde9fce0@epcms5p1/
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>   include/linux/swap.h |  1 +
> >>   mm/page_io.c         | 92 ++++++++++++++++++++++++++++++++++++++++++=
+-
> >>   mm/swapfile.c        | 21 +++++++++-
> >>   3 files changed, 111 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index a11c75e897ec..e88563978441 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -299,6 +299,7 @@ struct swap_info_struct {
> >>          signed char     type;           /* strange name for an index =
*/
> >>          unsigned int    max;            /* extent of the swap_map */
> >>          unsigned char *swap_map;        /* vmalloc'ed array of usage =
counts */
> >> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track =
zero pages */
> >>          struct swap_cluster_info *cluster_info; /* cluster info. Only=
 for SSD */
> >>          struct swap_cluster_list free_clusters; /* free clusters list=
 */
> >>          unsigned int lowest_bit;        /* index of first free in swa=
p_map */
> >> diff --git a/mm/page_io.c b/mm/page_io.c
> >> index a360857cf75d..2cac1e11fb85 100644
> >> --- a/mm/page_io.c
> >> +++ b/mm/page_io.c
> >> @@ -172,6 +172,82 @@ int generic_swapfile_activate(struct swap_info_st=
ruct *sis,
> >>          goto out;
> >>   }
> >>
> >> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> >> +{
> >> +       unsigned long *data;
> >> +       unsigned int pos, last_pos =3D PAGE_SIZE / sizeof(*data) - 1;
> >> +       bool ret =3D false;
> >> +
> >> +       data =3D kmap_local_folio(folio, i * PAGE_SIZE);
> >> +       if (data[last_pos])
> >> +               goto out;
> >> +       for (pos =3D 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
> >> +               if (data[pos])
> >> +                       goto out;
> >> +       }
> >> +       ret =3D true;
> >> +out:
> >> +       kunmap_local(data);
> >> +       return ret;
> >> +}
> >> +
> >> +static bool is_folio_zero_filled(struct folio *folio)
> >> +{
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> >> +               if (!is_folio_page_zero_filled(folio, i))
> >> +                       return false;
> >> +       }
> >> +       return true;
> >> +}
> > Is there any benefit to iterating on the folio in pages (i.e. have
> > both is_folio_zero_filled() and is_folio_page_zero_filled())? Why
> > don't we just kmap the entire folio and check it all at once?
>
> Is there an API to kmap an entire folio?

I thought kmap_local_folio() takes in a 'size' parameter for some
reason, my bad.

>
> I could just do data =3D page_address(&folio->page) in above and iterate
> through folio_nr_pages(folio) * PAGE_SIZE, and do it all in one
> function, but this just looks much nicer and much more readable?

Yeah if we need to map each page individually, the current code is better.

>
> In other places in the kernel, the folio iteration is through pages as we=
ll:
>
> https://elixir.bootlin.com/linux/latest/source/arch/csky/abiv2/cacheflush=
.c#L29
>
> https://elixir.bootlin.com/linux/latest/source/arch/mips/mm/cache.c#L162
>
> and others as well.
[..]
> >> @@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool sy=
nchronous,
> >>                  psi_memstall_enter(&pflags);
> >>          }
> >>          delayacct_swapin_start();
> >> -
> >> -       if (zswap_load(folio)) {
> >> +       if (swap_zeromap_folio_test(folio)) {
> >> +               folio_zero_fill(folio);
> >> +               folio_mark_uptodate(folio);
> >> +               folio_unlock(folio);
> > We don't currently support swapping in large folios, but it is a work
> > in progress, and this will break once we have it.
> > swap_zeromap_folio_test() will return false even if parts of the folio
> > are in fact zero-filled. Then, we will go read those from disk swap,
> > essentially corrupting data.
>
> So yes, with this patch I tested swap out of large zero folio, but when
> swapping in it was page by page. My assumption was that swap_read_folio
> (when support is added) would only pass a large folio that was earlier
> swapped out as a large folio. So if a zero filled large folio was
> swapped out, the zeromap will be set for all the pages in that folio,
> and at large folio swap in (when it is supported), it will see that all
> the bits in the zeromap for that folio are set,  and will just
> folio_zero_fill.
>
> If even a single page in large folio has non-zero data then zeromap will
> not store it and it will go to either zswap or disk, and at read time as
> all the bits in zeromap are not set, it will still goto either zswap or
> disk, so I think this works?
>
> Is my assumption wrong that only large folios can be swapped in only if
> they were swapped out as large? I think this code works in that case.

I think the assumption is incorrect. I think we would just check if
contiguous PTEs have contiguous swap entries and swapin the folio as a
large folio in this case. It is likely that the swap entries are
contiguous because it was swapped out as a large folio, but I don't
think it's guaranteed.

For example, here is a patch that implements large swapin support for
the synchronous swapin case, and I think it just checks that the PTEs
have contiguous swap entries:
https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.com/

This makes a lot of sense because otherwise you'd have to keep track
of how the folios were composed at the time of swapout, to be able to
swap the same folios back in.

