Return-Path: <linux-kernel+bounces-346918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6698CB05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E21C2179B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA51FBA;
	Wed,  2 Oct 2024 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLGcBtWM"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16179CC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834351; cv=none; b=bCZjvZs4xXDyHinA8IH+J/Gp912Yz3zAQpKZORPpzainFiFcS52rj+vYeML9mwZLvTTOZrtZm8mZy1KnpPsyJXI7bCSBfFhCpwDKlMS5HEVcAXH4UdtQedPtVpK8j1+9IyPQXwsIcjugfxSgGTAKVI53QHF/GDcwhirJugFcTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834351; c=relaxed/simple;
	bh=G9OrjlxM3qCQzSru8c+ilhm5EW5RuMWpVdWOwdZY6no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8z42c1F2cWgu1M0gy6YVZfyZVhuWTlsihdDPrs0Qvyzv6yMix5bxIMPRfRIdExklVNavdpT3iHlZu9ENayjMuun0KOMKKzxWQVQQxzurBGPanJrGyPK6y8ZKW+xzXTc1vDmNmHs0T8Mla9i1U67L00ZoDjmdGnhysaB148Zo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLGcBtWM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb25aad5dfso56783436d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727834348; x=1728439148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R02VCGFBtA8SZcjGZJ1MtZs5NcfzN1P5h45gPgg+pnc=;
        b=HLGcBtWMfdyUsO11MJdwVxj6vEEInfFdDQsBI7KUWHYQ5p1xgs4GBQJjDOMM98s1Zz
         aJPgviNnIcrWvirJmC7v8SDIRjujo5dUDr/natJqkt11riarPWak79ybdnxVS8hoi2Ha
         G/zfkKK+inAMKypR70dIWW5SzBlTnSxG3p+HEwplGdZV6STIv2MXokQt1qknRctbtjzp
         b4fUP1Fik0ssUpIhLjVPmbskOw5QqIg3rqiuyKBIqIDrP+EhpuGQVSyU3/V+RGsh054+
         QrbIDXFDpobreJuFNTpR67mmGTl0qDtR/eAi0Yd0CT9sspfQbVsRg1IP2bGtznRRoCIQ
         CGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834348; x=1728439148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R02VCGFBtA8SZcjGZJ1MtZs5NcfzN1P5h45gPgg+pnc=;
        b=u7CiShMbAjwZ38qbPDz5et0znLXKGS3MbBIj1V7wfq6ib5tzkfQoIy/03TwI6zma7G
         Ou2HRiI5ijYyFeo4pkfUK0MHMF8UZyxiv+9QXakr4sJklgH1PuVN++KtUw7TYutjwV+E
         aiXTgcAiBn94T/fry+mYawasnDI7cfAcCy1qZ8+sAC1rtnoIu7ievlGQ6UhoifdWp4Oq
         /g7mDBGBGSnPR7WDiuJ7GhvBAwUJlJ31C8VJ5OaxY+NFxG9tNhsZC2nyucFP+QAebcWk
         viEo1jJ8l/ftdrD6TW/U/IqlWzahJjfmL/lTv5R5np/g1UwLXVM1rNMZ0O/hj7VY8qZl
         Ezgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2HhpQcv/lNEmkPYya9WAYokBb2Gfx2/bfr0PIhZjKMuaXdI3ZbqdULg81DjTVCwzqnTJGoDe4+gxUJ9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5jfHTQ5WQGKATOgfRuar1mSoSzW4sHPogfryNTZJI4022TaG
	ExpBZ8/jvfJh/zsz2vDkiZ4k85pVZYLt5TZgYQMHJsWdDEg83tYV1P8pmLNJjCNtrbci57loFye
	CGd1hKaKeSXul9FhK+2hU50jpDxA=
X-Google-Smtp-Source: AGHT+IGTVdyYXCAsGR+YePZiEIP/JqAhQv2khf790rChdV0an3VdmVXIA+PK+goxRlsGuKccl4vng/jy4tkKonjaoZI=
X-Received: by 2002:a05:6214:5346:b0:6cb:7a65:f6df with SMTP id
 6a1803df08f44-6cb81bc4b53mr20050956d6.44.1727834348278; Tue, 01 Oct 2024
 18:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
In-Reply-To: <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 1 Oct 2024 18:58:57 -0700
Message-ID: <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
>
> Nit: extra blank line.
>
> >  static inline void free_swap_and_cache(swp_entry_t entry)
> >  {
> >         free_swap_and_cache_nr(entry, 1);
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 0613421e09e7..e3f72f99be32 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1561,7 +1561,7 @@ static int shmem_writepage(struct page *page, str=
uct writeback_control *wbc)
> >                         __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
> >                         NULL) =3D=3D 0) {
> >                 shmem_recalc_inode(inode, 0, nr_pages);
> > -               swap_shmem_alloc(swap, nr_pages);
> > +               swap_duplicate_nr(swap, nr_pages);
> >                 shmem_delete_from_page_cache(folio, swp_to_radix_entry(=
swap));
> >
> >                 mutex_unlock(&shmem_swaplist_mutex);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 0cded32414a1..9bb94e618914 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1381,12 +1381,6 @@ static unsigned char __swap_entry_free_locked(st=
ruct swap_info_struct *si,
> >         if (usage =3D=3D SWAP_HAS_CACHE) {
> >                 VM_BUG_ON(!has_cache);
> >                 has_cache =3D 0;
> > -       } else if (count =3D=3D SWAP_MAP_SHMEM) {
> > -               /*
> > -                * Or we could insist on shmem.c using a special
> > -                * swap_shmem_free() and free_shmem_swap_and_cache()...
> > -                */
> > -               count =3D 0;
> >         } else if ((count & ~COUNT_CONTINUED) <=3D SWAP_MAP_MAX) {
> >                 if (count =3D=3D COUNT_CONTINUED) {
> >                         if (swap_count_continued(si, offset, count))
> > @@ -3626,7 +3620,6 @@ static int __swap_duplicate(swp_entry_t entry, un=
signed char usage, int nr)
> >
> >         offset =3D swp_offset(entry);
> >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> > -       VM_WARN_ON(usage =3D=3D 1 && nr > 1);
> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >
> >         err =3D 0;
> > @@ -3652,6 +3645,13 @@ static int __swap_duplicate(swp_entry_t entry, u=
nsigned char usage, int nr)
> >                                 err =3D -EEXIST;
> >                 } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
> >                         err =3D -EINVAL;
> > +               } else {
> > +                       /*
> > +                        * The only swap_duplicate_nr() caller that pas=
ses nr > 1 is shmem,
> > +                        * who never re-duplicates any swap entry it ow=
ns. So this should
>
> nit: I think "which" is the right word here, but I am not a native speake=
r :)

Yeah I think it should be which. Fix(let) incoming.

>
> > +                        * not happen.
> > +                        */
> > +                       VM_WARN_ON(nr > 1 && (count & ~COUNT_CONTINUED)=
 =3D=3D SWAP_MAP_MAX);
>
> Why not return an error in this case? I think we should add recovery
> for bugs when it's possible and simple, which I believe is the case
> here.
>
> In shmem_writepage() we can add a WARN if swap_duplicate_nr() fails,
> or propagate an error to the caller as well (perhaps this belongs in a
> separate patch that does this for swap_shmem_alloc() first).
>
> Sorry if I am being paranoid here, please let me know if this is the case=
.

I was debating between WARN-ing here, and returning -ENOMEM and
WARN-ing at shmem's callsite.

My thinking is that if we return -ENOMEM here, it will work in the
current setup, for both shmem and other callsites. However, in the
future, if we add another user of swap_duplicate_nr(), this time
without guaranteeing that we won't need continuation, I think it won't
work unless we have the fallback logic in place as well:

while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
err =3D add_swap_count_continuation(entry, GFP_ATOMIC);

>
> >                 }
> >
> >                 if (err)
> > @@ -3686,27 +3686,28 @@ static int __swap_duplicate(swp_entry_t entry, =
unsigned char usage, int nr)
> >         return err;
> >  }
> >
> > -/*
> > - * Help swapoff by noting that swap entry belongs to shmem/tmpfs
> > - * (in which case its reference count is never incremented).
> > - */
> > -void swap_shmem_alloc(swp_entry_t entry, int nr)
> > -{
> > -       __swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
> > -}
> > -
> > -/*
> > - * Increase reference count of swap entry by 1.
> > +/**
> > + * swap_duplicate_nr() - Increase reference count of nr contiguous swa=
p entries
> > + *                       by 1.
>
> Can we avoid the line break by using "refcount" instead of "reference cou=
nt"?
>
> > + *
> > + * @entry: first swap entry from which we want to increase the refcoun=
t.
> > + * @nr: Number of entries in range.
> > + *
> >   * Returns 0 for success, or -ENOMEM if a swap_count_continuation is r=
equired
> >   * but could not be atomically allocated.  Returns 0, just as if it su=
cceeded,
> >   * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT)=
, which
> >   * might occur if a page table entry has got corrupted.
> > + *
> > + * Note that we are currently not handling the case where nr > 1 and w=
e need to
> > + * add swap count continuation. This is OK, because no such user exist=
s - shmem
> > + * is the only user that can pass nr > 1, and it never re-duplicates a=
ny swap
> > + * entry it owns.
>
> Do we need this comment when we have the WARN + comment in __swap_duplica=
te()?

Here I'm just being cautious and include the limitation of the
function in the API documentation itself.

No strong opinions though.

>
> >   */
> > -int swap_duplicate(swp_entry_t entry)
> > +int swap_duplicate_nr(swp_entry_t entry, int nr)
> >  {
> >         int err =3D 0;
> >
> > -       while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
> > +       while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
> >                 err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
> >         return err;
> >  }
> > --
> > 2.43.5

