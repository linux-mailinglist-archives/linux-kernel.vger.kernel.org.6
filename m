Return-Path: <linux-kernel+bounces-389802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648AE9B7184
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D861B2169F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9793EA71;
	Thu, 31 Oct 2024 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr8w+haB"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551A186A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337199; cv=none; b=PgJcM/D+QPs8UMhV2wlbPT1sDb5Y0meMo6snJYGAcYX+VjRgkppA4TA9D0pAqtuPZP/sqt7ZmQqDCl3sHnjJYck1GdirSOzhdJZdLlA3KvXf9IQiaBdzwBWNyckkDxJNzQqIJ4N2+6iDA74ixSt//XiNOpwFd3eiUwkcJTtza1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337199; c=relaxed/simple;
	bh=IXSaj+8MzDVcvvzqFGwsEbsTXZT8SAkrNDs1n2mazx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/ugZDOGLT9GA0gKxNjKOBwjzgD70PpSuYg9UHe2FBimqCOyPoPzBPkaX7VPLh+Lij/e99uf1TaYb7xNyc5kYsHa+SC3+jKEGz5QaUzstTFgT1AFlJyrPU95ODKNLem4YKAmTes5PGqDQpSW1C8YnaoexnRnSYHCi8z+SHn7qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr8w+haB; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso228727241.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730337196; x=1730941996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfQRpu7hXgX29iiW2DyLSovm0EXVgeHNthQ5pZDpokE=;
        b=Cr8w+haBf6NxcAbzq2b58oImHqKleNWGRRxGkON9RogT+PqshTu16bW1k4Or7aON/E
         BYgf9MOvgkZR+ksHZpCiy9W0vzZYFWZqVEi4rG1LFNFo9tPHO0ZZA0oteJ9RXyFfhDLW
         +DLNfE4BokO5zJy+JuMsGI6I6ML16Je68TkNXQPuj+KpojyzqnD4fVTWiHcohzanqwZM
         KPM3Tm+8G0cAzrn3VglXY6g4Ckqw20jMssxaEExrM1piNeWagZIKgv6qUZuQq9WjQgi9
         bY+iM7l3+OuO2y1BG+4ag09ufdN14/tOu4ZIaejeL9PbegclhXBaRSy+/rCwcIlQ3XGc
         InRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730337196; x=1730941996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfQRpu7hXgX29iiW2DyLSovm0EXVgeHNthQ5pZDpokE=;
        b=kdtlT61UVdo30IdllRIBuPmx7TPyBfBMrScY6FkZOPYHRNi/aEn0MnYiGnkl9NlDNP
         8RFxBZW5bRW/xdUKeBw+V1l83HercA758nOUt7mfup7H3PVkSfzpJ2ZC27lWn8kCNXXa
         8ASPLn2uOVueXevGuZIzK+X2BoNgXGlB+pxX0m+zQMPAsLn+eYn7DD4rEftsw/PY16DN
         T6jbZMiRjfUJrOp2Bb8q7bghCR7PNMlPOSks7KWYmo8ANIZDBB3QaezTdM0a1qlAVJrO
         MTnPGSw6tsIbzNvi1+f5X77rbruf6Ok2xYiQImE0ZwvQ+XsX7ACqOOnTpXwAX3xsCZTv
         /xBw==
X-Forwarded-Encrypted: i=1; AJvYcCU4LrCGZrR2Xsr4NABetejNKOeT4YAimlqFOuC8xWLvvNnKUaC2SX1L4Axy5bEQCAmYM6zsSWpwcJ0ZVN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnrZwaK/CF/MoOg2GGVVi8adnSOiagYxwFpJ2uKoFnJK6odd5
	lx/LKRJ/f2IwdybElpJmq5ZwKOLdXz52fKCG+MWAzwJIlriT3MPzIlr06zotDGLm9aerLPhkkgY
	w2tOF4+Q5rfhZNMgELaSXBbsgax0=
X-Google-Smtp-Source: AGHT+IFICjqEXzcy3tC3+eiE5It7QHF1ahi9Gf3s0gb7YrIrsOa85c5g+/IrJZRJvHSVvClKYqN+qL98RN8vIcSVqK0=
X-Received: by 2002:a05:6102:5121:b0:4a5:b710:bd16 with SMTP id
 ada2fe7eead31-4a956cca46bmr509884137.5.1730337196275; Wed, 30 Oct 2024
 18:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030233423.80759-1-21cnbao@gmail.com> <87cyjh9khr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cyjh9khr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 14:13:04 +1300
Message-ID: <CAGsJ_4wemLBdoV4TMaeSWThMtVJtU+HjyAVwKDV978mAOqkhBA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swpin counters
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:39=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This helps profile the sizes of folios being swapped in. Currently,
> > only mTHP swap-out is being counted.
> > The new interface can be found at:
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >          swpin
>
> This looks strange, why isn't it
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin
>
> ?

I might be mistaken, but I want to highlight the path and new interface
separately, as I=E2=80=99ve done in ec33687c67493 ("mm: add per-order mTHP
anon_fault_alloc and anon_fault_fallback counters"):

If you prefer it on the same line, I=E2=80=99m completely fine with sending=
 v3
to make the change.

>
> > For example,
> > cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
> > 12809
> > cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
> > 4763
>
> You miss "$"?

Yes.

>
> $ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
> 12809
> $ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
> 4763
>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > ---
> >  -v2:
> >  * collect Baolin's reviewed-by and David's acked-by, thanks!
> >  * add some examples for the interface in the changelog, Per
> >    Huang, Ying. thanks!
> >  * add a blank line in doc which was missed in v1.
> >
> >  Documentation/admin-guide/mm/transhuge.rst | 4 ++++
> >  include/linux/huge_mm.h                    | 1 +
> >  mm/huge_memory.c                           | 3 +++
> >  mm/page_io.c                               | 3 +++
> >  4 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 2a171ed5206e..5caa3fb2feb1 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -534,6 +534,10 @@ zswpout
> >       is incremented every time a huge page is swapped out to zswap in =
one
> >       piece without splitting.
> >
> > +swpin
> > +     is incremented every time a huge page is swapped in from a non-zs=
wap
> > +     swap device in one piece.
> > +
> >  swpout
> >       is incremented every time a huge page is swapped out to a non-zsw=
ap
> >       swap device in one piece without splitting.
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index c59e5aa9b081..b94c2e8ee918 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -120,6 +120,7 @@ enum mthp_stat_item {
> >       MTHP_STAT_ANON_FAULT_FALLBACK,
> >       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >       MTHP_STAT_ZSWPOUT,
> > +     MTHP_STAT_SWPIN,
> >       MTHP_STAT_SWPOUT,
> >       MTHP_STAT_SWPOUT_FALLBACK,
> >       MTHP_STAT_SHMEM_ALLOC,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b26c6503e993..f92068864469 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -616,6 +616,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_A=
NON_FAULT_ALLOC);
> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBA=
CK);
> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT=
_FALLBACK_CHARGE);
> >  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> > +DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> >  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> >  #ifdef CONFIG_SHMEM
> > @@ -635,6 +636,7 @@ static struct attribute *anon_stats_attrs[] =3D {
> >       &anon_fault_fallback_charge_attr.attr,
> >  #ifndef CONFIG_SHMEM
> >       &zswpout_attr.attr,
> > +     &swpin_attr.attr,
> >       &swpout_attr.attr,
> >       &swpout_fallback_attr.attr,
> >  #endif
> > @@ -666,6 +668,7 @@ static struct attribute_group file_stats_attr_grp =
=3D {
> >  static struct attribute *any_stats_attrs[] =3D {
> >  #ifdef CONFIG_SHMEM
> >       &zswpout_attr.attr,
> > +     &swpin_attr.attr,
> >       &swpout_attr.attr,
> >       &swpout_fallback_attr.attr,
> >  #endif
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index c69fab5060a1..5d9b6e6cf96c 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -487,6 +487,7 @@ static void sio_read_complete(struct kiocb *iocb, l=
ong ret)
> >               for (p =3D 0; p < sio->pages; p++) {
> >                       struct folio *folio =3D page_folio(sio->bvec[p].b=
v_page);
> >
> > +                     count_mthp_stat(folio_order(folio), MTHP_STAT_SWP=
IN);
> >                       count_memcg_folio_events(folio, PSWPIN, folio_nr_=
pages(folio));
> >                       folio_mark_uptodate(folio);
> >                       folio_unlock(folio);
> > @@ -573,6 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio =
*folio,
> >        * attempt to access it in the page fault retry time check.
> >        */
> >       get_task_struct(current);
> > +     count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
> >       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
> >       count_vm_events(PSWPIN, folio_nr_pages(folio));
> >       submit_bio_wait(&bio);
> > @@ -589,6 +591,7 @@ static void swap_read_folio_bdev_async(struct folio=
 *folio,
> >       bio->bi_iter.bi_sector =3D swap_folio_sector(folio);
> >       bio->bi_end_io =3D end_swap_bio_read;
> >       bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> > +     count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
> >       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
> >       count_vm_events(PSWPIN, folio_nr_pages(folio));
> >       submit_bio(bio);
>
> --
> Best Regards,
> Huang, Ying

