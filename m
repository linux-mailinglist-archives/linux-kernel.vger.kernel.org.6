Return-Path: <linux-kernel+bounces-195653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF168D4FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A81C2319F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145322619;
	Thu, 30 May 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeBf/g4V"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0020B3E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086300; cv=none; b=QMiNeNLm5f5OI/kPFSlmsjTlAUl0t8yS2fGN4Wvx/oRBa/krqFHw4OOyWsFxphGAfjzmauDJaJPGPN5+DBF9ulhw8m+mdcpL9SnRt0Tq3fTCGtPmeSJaGOhgU3KXlqw1cXHqjhM7IMv7q+qzSWzWas7xetMI8j306qtBIdVHhGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086300; c=relaxed/simple;
	bh=8o0ZIK2d5CAvM/zF5h5sybmXtMx4wa2NagpYFQt5FTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLzONU7EJdujgUeK2j95fLI2wqAl+UuDsf53oPAnw9HSDDseviXLHY9qQj03nxFV63Oo8XudaYZQKSjUg73CxcwTsuCfAoy9FtYK7JPBNj8X2FHno0SRFN+pv+ZBqRv/VSWcuumk0E6prHMb0RwKb6SVrA/2eydpURXPuyMKJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeBf/g4V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a352bbd9so174901066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717086297; x=1717691097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FNesVw/sAj7Em9Zy23GdchPLFbPVXVlEFF3WazTuoo=;
        b=xeBf/g4VNEmcG5qnve1j3Hs4brvsuNRt3w5anaZUN+7liuix5UeRzbIZIB/0699Ku4
         s4ZnMuETvVrIoDdp5ojcw7b52/GHeRCt8UvHHUfuL/ZS6NpzaFgR4uMAZHFtNYGBX7QB
         DYl5O2MPIz9nzJa31IiDhUBsXdtc0bWMlvTjcplpT+EwN8hPDBXF+9uQhguJ+t6EZ+10
         6IkQsDOpA8RTVwc4OHE6AWPGShQocTJtN3tGJKc7zoSwXeUUbKM9vqmnG3ZXyHIvvhEw
         IN0CmR+wlYdDhQf1tLD7HEk7WDczrmFy6sTNK2YfdZ+FkMxSNj6ugZyK/L/noNGHNLuD
         Q3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717086297; x=1717691097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FNesVw/sAj7Em9Zy23GdchPLFbPVXVlEFF3WazTuoo=;
        b=no8shPb+a317Ra6iOuzdsmt9uEhAN3lfNvVUAvPGc8Ujgt9QxAafSYvv+18oF8FYaQ
         A2H6JpIi4BMgcOPds5NBDcNsI1Pfg7GQ4U1Z/GLh6DIk/Jb89xfJmD9kvii2HNAtQIh8
         vU7H0dYQd/YwtqdTZX/5wtXWBtjuMAHnjyhfv0qbJPDVuTl7k3Ro7RiygDVZtYISPpry
         FWkfPqBpOz0pEsxygS8JdwFZEBBzXXTTAZLG2G3yNFbtgu6La12/nayr0H4Y+aM9Bidk
         XHjHJEGJgM/zKVeMdoPKeTZ8a46/K40GOOdRSa4bX8VeVemyg9PS9ufXVMfNN8hTF3+W
         O1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOnM8Qza/SYBJq80biK5WFXr+DADX+dWDqO38SIT7GfHNvT8mjA3R91FLzFPeJfp7N8ihJQhloCR+XA1Nd2yfAskgjq3G/0P0pJaZj
X-Gm-Message-State: AOJu0Yyz0xsCBdO05RuPcuGCaUFstI4g8zKHJMEMZNyCU/IUpZ9jCHjO
	lpX382CENnXBh5syootlWn76njr6I2n0SKz5LciIQVHw+03nqSbX6TbZXCjSPYKkKjdldNab93M
	Tj0FRplR3Si6uf3/AlDLzLifeMVBuRnYw6gUX
X-Google-Smtp-Source: AGHT+IFwLT2oLWqkwAVjuKHT0oAS13N6O5emKTnqOQ4nc8/3wmrmPqfIXiLZwyctW/dHf5j6sSQb8/kI/xPKl5Vb++s=
X-Received: by 2002:a17:906:f143:b0:a59:be21:3587 with SMTP id
 a640c23a62f3a-a65f0918c9cmr184816566b.8.1717086296523; Thu, 30 May 2024
 09:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com> <20240530122715.GB1222079@cmpxchg.org>
In-Reply-To: <20240530122715.GB1222079@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 30 May 2024 09:24:20 -0700
Message-ID: <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:27=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, May 30, 2024 at 11:19:07AM +0100, Usama Arif wrote:
> > Approximately 10-20% of pages to be swapped out are zero pages [1].
> > Rather than reading/writing these pages to flash resulting
> > in increased I/O and flash wear, a bitmap can be used to mark these
> > pages as zero at write time, and the pages can be filled at
> > read time if the bit corresponding to the page is set.
> > With this patch, NVMe writes in Meta server fleet decreased
> > by almost 10% with conventional swap setup (zswap disabled).
> >
> > [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d0=
3d1344dde9fce0@epcms5p1/
> >
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>
> This is awesome.
>
> > ---
> >  include/linux/swap.h |  1 +
> >  mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++++--
> >  mm/swapfile.c        | 10 ++++++
> >  3 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index a11c75e897ec..e88563978441 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -299,6 +299,7 @@ struct swap_info_struct {
> >       signed char     type;           /* strange name for an index */
> >       unsigned int    max;            /* extent of the swap_map */
> >       unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
> > +     unsigned long *zeromap;         /* vmalloc'ed bitmap to track zer=
o pages */
>
> One bit per swap slot, so 1 / (4096 * 8) =3D 0.003% static memory
> overhead for configured swap space. That seems reasonable for what
> appears to be a fairly universal 10% reduction in swap IO.
>
> An alternative implementation would be to reserve a bit in
> swap_map. This would be no overhead at idle, but would force
> continuation counts earlier on heavily shared page tables, and AFAICS
> would get complicated in terms of locking, whereas this one is pretty
> simple (atomic ops protect the map, swapcache lock protects the bit).
>
> So I prefer this version. But a few comments below:

I am wondering if it's even possible to take this one step further and
avoid reclaiming zero-filled pages in the first place. Can we just
unmap them and let the first read fault allocate a zero'd page like
uninitialized memory, or point them at the zero page and make them
read-only, or something? Then we could free them directly without
going into the swap code to begin with.

That's how I thought about it initially when I attempted to support
only zero-filled pages in zswap. It could be a more complex
implementation though.

[..]
> > +
> > +static void swap_zeromap_folio_set(struct folio *folio)
> > +{
> > +     struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > +     swp_entry_t entry;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < folio_nr_pages(folio); i++) {
> > +             entry =3D page_swap_entry(folio_page(folio, i));
> > +             bitmap_set(sis->zeromap, swp_offset(entry), 1);
>
> This should be set_bit(). bitmap_set() isn't atomic, so it would
> corrupt the map on concurrent swapping of other zero pages. And you
> don't need a range op here anyway.

It's a shame there is no range version of set_bit(). I suspect we can
save a few atomic operations on large folios if we write them in
chunks rather than one by one.

