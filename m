Return-Path: <linux-kernel+bounces-400431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BC9C0D72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC540283925
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E2216E08;
	Thu,  7 Nov 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMnk57vs"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27833216420
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002677; cv=none; b=VS69xHY5uqUtcwYjvIcH+oDQNswCSOyEXPGGVoO+3M4V59nwIdHQDBgFNip7XGz/B/sbAHmfNyRh22cGbyBiT/WLiu154TyPzLu3MvGJH4CKcnrKEOVNvmRZql8+2nExLcjk40MMT0cKkBFlC/fnagRprvn+vBnyGohFU13sKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002677; c=relaxed/simple;
	bh=AoGdPGCHB1CEqclFtXuGMQlG7acgjTvG08UwNfyX80M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLZaGmYwJnDn2drGyeOkhhRccAQ/MNIvR7ZfbWkCemLVbctbZLnrwshS27Slg7Vt868SL8iI0kGf6B8+FnD+6U1WCnNXCvzwfxAbvEogpb656/5Nfzp0U1T5GPse4s9k5oen/JIdg3zMTYrtopO1jn1lD/vS3bTqnESSsA0OFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMnk57vs; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4608dddaa35so13561cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731002675; x=1731607475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp7o7HnZvkg1atMAdU2HGbX95NuzWO3BKP5CnSuHnys=;
        b=kMnk57vsnsrKTMKUCJWOEicfAaU6zQdDNQjiIX6dZMjqB60AnuUnCWXZOPde1hZELo
         f02FKaTOb4KDgpmQ77VSIj15OUjUWsV9IGFBochlQENoVUaR459y+zUT3uTj6MF3C9AQ
         fpAF2UIZ7crhk7JkjBO4emHFeMS9Cf62I4oyBmqKODqoMdULcUBI6A/jm9o6j/xg+Zdk
         A7JfWGHGP1kn/lrO6bltMgKi04LpmVpqPiGQ8GgJJt26TuzwogQfSh3YHQWUVdiUtESO
         tSNAhRQFI2wcHT0/2d0dKUYozHK74Kft7ttpfm68vNylnwe6Hdya94eQ7KwgAUwk+Tfu
         nzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002675; x=1731607475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp7o7HnZvkg1atMAdU2HGbX95NuzWO3BKP5CnSuHnys=;
        b=hZsCDxoSes42UAmTQDTfe5iruR0lpascNOH70hLaaV32Ra5RSXepk/+ffoSgdPeAq/
         hhZiEWpfTeahqeaJlK/vTmx2L7qgLQE9IvIgsIq99exTapffEWPOIbpUNH845hvGfh0V
         IgQerbfYZ53/1x9NGu1efJKpBFZYT7wKFT+vEMFuY8TlpXYV5hvdF8lh9GAdkNZanHsE
         cheaMKwQhTpLTnUGIh0r2dQ9PNY7kP19wFy6Z3txa27Tr3XX5ul453o4pv3lSgJEsTgn
         Z+5apPvgcACUm/zbLo7ZZ2ELEBxaAEjV30/JK3VHLcA8HPbpEtPxWuL4LvrI1rAT5My5
         nGQg==
X-Forwarded-Encrypted: i=1; AJvYcCVgqyUI18wa61whmYMkMKzakWJgYKexBYdZNJ8KnSnkNu7O+UcHxTzEaiygfzCEtpJwoX55tPFb/otwOGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1fXH5IMEFhNZcij32sBth++JLw+tQxm/E+pqaTwCcbxG4iLJ
	hA7/OxwaSHUmTm4j/7XaQrkoTL3kUnfhOMRT3uHW7PiJ2YK0T+MbxLhoWVZipyIindd95Km3pgQ
	YDUApbxsyRQ2PRFyBMiHpR1mRuAh6f3vVdGPz
X-Gm-Gg: ASbGncvvTfeCuSAkCzq389TSNEEZKSC7Y8a26rnXY4m6TZPvOvYGD03Spr+niQ5tgGa
	i4iC+3QSfqYFTrPTmLkbrp8Su/wJ+yKyL/9b2rEaGBXQyCUK1K2E6q1bARMf5TA==
X-Google-Smtp-Source: AGHT+IG4zvVeAPzzuQSjqEAlYh+GhlTYkbHeruQH2ZyqZ12SI5Wsg7uiawewaoNFffeIDWCHKxOitFzYPnN/1nrTvPc=
X-Received: by 2002:a05:622a:1391:b0:461:4467:14c7 with SMTP id
 d75a77b69052e-462fa47d2b8mr5543301cf.0.1731002674735; Thu, 07 Nov 2024
 10:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com> <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com> <Zyz--bjvkVXngc5U@google.com>
In-Reply-To: <Zyz--bjvkVXngc5U@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 10:04:23 -0800
Message-ID: <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] binder: use per-vma lock in page installation
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <v-songbaohua@oppo.com>, Hillf Danton <hdanton@sina.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:55=E2=80=AFAM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> > On Wed, Nov 6, 2024 at 8:03=E2=80=AFPM Carlos Llamas <cmllamas@google.c=
om> wrote:
> > >
> > > Use per-vma locking for concurrent page installations, this minimizes
> > > contention with unrelated vmas improving performance. The mmap_lock i=
s
> > > still acquired when needed though, e.g. before get_user_pages_remote(=
).
> > >
> > > Many thanks to Barry Song who posted a similar approach [1].
> > >
> > > Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmai=
l.com/ [1]
> > > Cc: Nhat Pham <nphamcs@gmail.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Hillf Danton <hdanton@sina.com>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > >  drivers/android/binder_alloc.c | 85 +++++++++++++++++++++++---------=
--
> > >  1 file changed, 57 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_=
alloc.c
> > > index 814435a2601a..debfa541e01b 100644
> > > --- a/drivers/android/binder_alloc.c
> > > +++ b/drivers/android/binder_alloc.c
> > > @@ -233,6 +233,56 @@ static inline bool binder_alloc_is_mapped(struct=
 binder_alloc *alloc)
> > >         return smp_load_acquire(&alloc->mapped);
> > >  }
> > >
> > > +static struct page *binder_page_lookup(struct mm_struct *mm,
> >
> > Maybe pass "struct binder_alloc" in both binder_page_lookup() and
> > binder_page_insert()?
>
> I'm not sure this is worth it though. Yeah, it would match with
> binder_page_insert() nicely, but also there is no usage for alloc in
> binder_page_lookup(). It's only purpose would be to access the mm:
>
>   static struct page *binder_page_lookup(struct binder_alloc *alloc,
>                                          unsigned long addr)
>   {
>         struct mm_struct *mm =3D alloc->mm;
>
> If you think this is cleaner I really don't mind adding it for v3.
>
> > I like how previous code stabilized mm with mmget_not_zero() once vs
> > now binder_page_lookup() and binder_page_insert() have to mmget/mmput
> > individually. Not a big deal but looked cleaner.
>
> Sure, I can factor this out (the way it was in v1).
>
> >
> > > +                                      unsigned long addr)
> > > +{
> > > +       struct page *page;
> > > +       long ret;
> > > +
> > > +       if (!mmget_not_zero(mm))
> > > +               return NULL;
> > > +
> > > +       mmap_read_lock(mm);
> > > +       ret =3D get_user_pages_remote(mm, addr, 1, 0, &page, NULL);
> > > +       mmap_read_unlock(mm);
> > > +       mmput_async(mm);
> > > +
> > > +       return ret > 0 ? page : NULL;
> > > +}
> > > +
> > > +static int binder_page_insert(struct binder_alloc *alloc,
> > > +                             unsigned long addr,
> > > +                             struct page *page)
> > > +{
> > > +       struct mm_struct *mm =3D alloc->mm;
> > > +       struct vm_area_struct *vma;
> > > +       int ret =3D -ESRCH;
> > > +
> > > +       if (!mmget_not_zero(mm))
> > > +               return -ESRCH;
> > > +
> > > +       /* attempt per-vma lock first */
> > > +       vma =3D lock_vma_under_rcu(mm, addr);
> > > +       if (!vma)
> > > +               goto lock_mmap;
> > > +
> > > +       if (binder_alloc_is_mapped(alloc))
> >
> > I don't think you need this check here. lock_vma_under_rcu() ensures
> > that the VMA was not detached from the tree after locking the VMA, so
> > if you got a VMA it's in the tree and it can't be removed (because
> > it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> > called after VMA gets detached from the tree and that won't happen
> > while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> > binder_alloc_is_mapped() has to always return true. A WARN_ON() check
> > here to ensure that might be a better option.
>
> Yes we are guaranteed to have _a_ non-isolated vma. However, the check
> validates that it's the _expected_ vma. IIUC, our vma could have been
> unmapped (clearing alloc->mapped) and a _new_ unrelated vma could have
> gotten the same address space assigned?

No, this should never happen. lock_vma_under_rcu() specifically checks
the address range *after* it locks the VMA:
https://elixir.bootlin.com/linux/v6.11.6/source/mm/memory.c#L6026

>
> The binder_alloc_is_mapped() checks if the vma belongs to binder. This
> reminds me, I should also check this for get_user_pages_remote().
>
> >
> > > +               ret =3D vm_insert_page(vma, addr, page);
> > > +       vma_end_read(vma);
> > > +       goto done;
> >
> > I think the code would be more readable without these jumps:
> >
> >         vma =3D lock_vma_under_rcu(mm, addr);
> >         if (vma) {
> >                if (!WARN_ON(!binder_alloc_is_mapped(alloc)))
> >                        ret =3D vm_insert_page(vma, addr, page);
> >                vma_end_read(vma);
> >         } else {
> >                /* fall back to mmap_lock */
> >                mmap_read_lock(mm);
> >                vma =3D vma_lookup(mm, addr);
> >                if (vma && binder_alloc_is_mapped(alloc))
> >                        ret =3D vm_insert_page(vma, addr, page);
> >                mmap_read_unlock(mm);
> >         }
> >         mmput_async(mm);
> >         return ret;
>
> Ok. I'm thinking with mmput_async() being factored out, I'll add an
> early return. e.g.:
>
>         vma =3D lock_vma_under_rcu(mm, addr);
>         if (vma) {
>                 if (binder_alloc_is_mapped(alloc))
>                         ret =3D vm_insert_page(vma, addr, page);
>                 vma_end_read(vma);
>                 return ret;
>         }
>
>         /* fall back to mmap_lock */
>          mmap_read_lock(mm);
>          [...]
>
>
> Thanks,
> Carlos Llamas

