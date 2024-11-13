Return-Path: <linux-kernel+bounces-407922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677A9C7923
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7FB4523F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0814D452;
	Wed, 13 Nov 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxRQMSso"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85717E0E8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512273; cv=none; b=dHij+MdT7VlM2JHpumgqRwuISwFJuXWskrLyH847f1pgs/CTikEgbmJhoDQt2a3ej5XJ2tb6j3zKJNfNYRSA9CMW75zxdqz9yiPIiKfwzjmfMU8YQldMve6tFm6VX1pyAeqv3KM6X39ZldWDeG59Bt9un0XQn3zuYZNQKkcTp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512273; c=relaxed/simple;
	bh=ZXNjTwJlm5WqTv5yRq7Abc9HnFfQthUcyk8PMdirlWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgz+ygNRlu6f7YtctzYyloNCBF/HFVG8/nLhfAL8Re2pLboYnR4hCl+SHyKZAFzhMitjHbA75aq8Er+Ac3uPHt7iNUkTXQ6sfBEcCoBTUPua3iQQvP/ZVHKG+mIGEySC/ASaCNJvi8gsxgs3Ww3bvB/zrSxbBE+W92xlUS6RhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxRQMSso; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4608dddaa35so316601cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731512271; x=1732117071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXS5EFs4Cl5CVnqNGjFqLrV5MNciF0+EB1K5+c2asu8=;
        b=UxRQMSsoNpUWmVlEqvYw0JYBQxcSQ+eAwqnzYN3RUxXVWqMmk1n5HceAqqHYQmFnPD
         6gXBtHTnvONdCtvUqt5hYEHAdlvw7eCIFr/SYMw0nXOnBtX0fH73D6gCWE4NTiGPrMVb
         LY0MNckqbD0QQekPQzo6XJwX2I7ytkPK7GKLSUzSu/q26lvLth8l3PLlW/VJ8ZRtE9Ex
         WEQLQnAIOQ6M7UJMmgNBbhRGzoK1STZGyVmCI+VmVfMTx+FNUti11+95iqZlFSxpIPSd
         FO5PX0+0z8BLP//e3I1N76/sJx0iGiLA/eArmsyKkFawHClU0B0x7qTEGKSxB1kLWcDC
         b3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512271; x=1732117071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXS5EFs4Cl5CVnqNGjFqLrV5MNciF0+EB1K5+c2asu8=;
        b=qsLgpOEthPJ28dnwW7z/W9YcPuMb3h2B9l3m0Ck3x6+g2NxTgSSaZr46jNX01G0bqG
         guwBKsVN86n5jvVe0XAZTTTyMdzphYgED2B5atAVPajhieQNQWjGajLNHDMpMCoFDMWI
         2tpTA+zgDdzbScrAJ1bGq8wrXsvU7mRhYuyuepCpdNqsyGnnJIoxT8nTo5IJITC87yMJ
         AvIGFObwWlXS3EKGxMdt9iPBXjSoQC+wCXwLITAAMXlVPgWxT2D5n8Vw8dCdxjSeHWwR
         Yn4Zlrn4RprOjhShQ9x75M9dCWHj0Z/Ky8KcO6mkRbBCG/7shakZ3XGOnyqIP8lc8yAw
         VqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4n45DtWvo9r56qRus4dY5vhvbxHwKc5y+reieBFv8Xo28dJorNbE1KwzzzYvQa3TPe3NQsT6DA6E389I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTdKUMBPad4UCyIoufbxr0Ds+C43tk4Ulqyt9Itt9iIMcLj1y
	vroL320mE9SVpgNgQxsB9ziBsjbOhiMFJMLO6xt4w5n7jm1Q0TC8cnJk8WFTN8JQkctWIM4dZB6
	LFmRCLXl33bjvKe/52qYy94r6QBfytyE6JIYN
X-Gm-Gg: ASbGncsDgdUjvvAdEamolWBWL+WKzi7H8DkSS7+5D826L35wIWeO1sB1Dq+BWCKJ2es
	o4gE4RVfZIM96wy2A2llsPMk6PSrtbcA=
X-Google-Smtp-Source: AGHT+IHEU1U5dfPZ6mIgDaKJL898ldMOWvfg9vnhENKTzuQ+Pf15wwDYZWhS8Oa0MM4oqkQ4tiKJJOYu8UNHWap1Sis=
X-Received: by 2002:a05:622a:47c6:b0:461:679f:f1ba with SMTP id
 d75a77b69052e-4634bca4e56mr3641501cf.20.1731512270176; Wed, 13 Nov 2024
 07:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-4-surenb@google.com>
 <b912f9fa-24eb-4abb-bd9c-ac0a14740847@lucifer.local>
In-Reply-To: <b912f9fa-24eb-4abb-bd9c-ac0a14740847@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 07:37:39 -0800
Message-ID: <CAJuCfpHp=1eQa40gBL8dprhk=bFdEBJYA_UcBgpA7Z_fBeGSGQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: mark vma as detached until it's added into vma tree
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 6:43=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Nov 12, 2024 at 11:46:33AM -0800, Suren Baghdasaryan wrote:
> > Current implementation does not set detached flag when a VMA is first
> > allocated. This does not represent the real state of the VMA, which is
> > detached until it is added into mm's VMA tree. Fix this by marking new
> > VMAs as detached and resetting detached flag only after VMA is added
> > into a tree.
> >
>
> This seems very sensible.
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Aside from nits/refactoring suggestions below:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > ---
> >  include/linux/mm.h               | 10 +++++++++-
> >  mm/memory.c                      |  2 +-
> >  mm/mmap.c                        |  2 ++
> >  mm/nommu.c                       |  2 ++
> >  mm/vma.c                         |  3 +++
> >  tools/testing/vma/vma_internal.h |  3 ++-
>
> Just want to say THANK YOU for taking the time to update the testing stub=
s :)
> Much appreciated!
>
> >  6 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a5eb0be3e351..245a85caf4c3 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -812,6 +812,11 @@ static inline void vma_mark_detached(struct vm_are=
a_struct *vma, bool detached)
> >       vma->detached =3D detached;
> >  }
> >
> > +static inline bool is_vma_detached(struct vm_area_struct *vma)
> > +{
> > +     return vma->detached;
> > +}
> > +
> >  static inline void release_fault_lock(struct vm_fault *vmf)
> >  {
> >       if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > @@ -874,7 +879,10 @@ static inline void vma_init(struct vm_area_struct =
*vma, struct mm_struct *mm)
> >       vma->vm_mm =3D mm;
> >       vma->vm_ops =3D &vma_dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > -     vma_mark_detached(vma, false);
>
> How did this work before? Oh I guess we initialised the VMA lock earlier =
right?

Yes.

>
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     vma->detached =3D true;
> > +#endif
> >       vma_numab_state_init(vma);
> >       vma_lock_init(vma);
> >  }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 209885a4134f..d0197a0c0996 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >               goto inval;
> >
> >       /* Check if the VMA got isolated after we found it */
> > -     if (vma->detached) {
> > +     if (is_vma_detached(vma)) {
> >               vma_end_read(vma);
> >               count_vm_vma_lock_event(VMA_LOCK_MISS);
> >               /* The area was replaced with another one */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 386429f7db5a..1295c4cedaf4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1570,6 +1570,7 @@ static int do_brk_flags(struct vma_iterator *vmi,=
 struct vm_area_struct *vma,
> >       if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
> >               goto mas_store_fail;
> >
> > +     vma_mark_detached(vma, false);
> >       mm->map_count++;
> >       validate_mm(mm);
> >       ksm_add_vma(vma);
> > @@ -1890,6 +1891,7 @@ static struct vm_area_struct *__install_special_m=
apping(
> >       if (ret)
> >               goto out;
> >
> > +     vma_mark_detached(vma, false);
>
> similar to vma_iter_store() comment, maybe worht putting in insert_vm_str=
uct()?

Ah, this one I think is not needed because we already have
insert_vm_struct() -> vma_link() -> vma_mark_detached(vma, false)

>
> >       vm_stat_account(mm, vma->vm_flags, len >> PAGE_SHIFT);
> >
> >       perf_event_mmap(vma);
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 9cb6e99215e2..6afd5c2bd97d 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -1192,6 +1192,7 @@ unsigned long do_mmap(struct file *file,
> >       current->mm->map_count++;
> >       /* add the VMA to the tree */
> >       vma_iter_store(&vmi, vma);
> > +     vma_mark_detached(vma, false);
>
> Since we to seem always to do this with vma_iter_store() do we want to pu=
t this
> there? Or maybe make a wrapper around the two if that seems not to separa=
te
> concerns enough?

I think wrapper would be helpful. I'll try that and see if that looks bette=
r.

>
> >
> >       /* we flush the region from the icache only when the first execut=
able
> >        * mapping of it is made  */
> > @@ -1357,6 +1358,7 @@ static int split_vma(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> >       setup_vma_to_mm(vma, mm);
> >       setup_vma_to_mm(new, mm);
> >       vma_iter_store(vmi, new);
> > +     vma_mark_detached(new, false);
> >       mm->map_count++;
> >       return 0;
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 8a454a7bbc80..1426871fa6e0 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -275,6 +275,7 @@ static void vma_complete(struct vma_prepare *vp, st=
ruct vma_iterator *vmi,
> >                * (it may either follow vma or precede it).
> >                */
> >               vma_iter_store(vmi, vp->insert);
> > +             vma_mark_detached(vp->insert, false);
> >               mm->map_count++;
> >       }
> >
> > @@ -1690,6 +1691,7 @@ int vma_link(struct mm_struct *mm, struct vm_area=
_struct *vma)
> >
> >       vma_start_write(vma);
> >       vma_iter_store(&vmi, vma);
> > +     vma_mark_detached(vma, false);
> >       vma_link_file(vma);
> >       mm->map_count++;
> >       validate_mm(mm);
> > @@ -2369,6 +2371,7 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap)
> >       /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> >       vma_start_write(vma);
> >       vma_iter_store(vmi, vma);
> > +     vma_mark_detached(vma, false);
> >       map->mm->map_count++;
> >       vma_link_file(vma);
> >
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index 1d9fc97b8e80..fdb60978821f 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -438,7 +438,8 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
> >       vma->vm_mm =3D mm;
> >       vma->vm_ops =3D &vma_dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > -     vma_mark_detached(vma, false);
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     vma->detached =3D true;
>
> You're the best :)

Thanks!

>
> >  }
> >
> >  static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *m=
m)
> > --
> > 2.47.0.277.g8800431eea-goog
> >

