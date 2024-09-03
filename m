Return-Path: <linux-kernel+bounces-313925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A608B96AC70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF71282073
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E21D5CEC;
	Tue,  3 Sep 2024 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YypRK+9Y"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F41D5CDF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403424; cv=none; b=GpUCtsVlE1J9pHi6TrK4iQb73HkkhGxtOGbv3ksv/tLDqo2CUeEC94FYZ4vYoU0jTf9FNcYIH18pffI+ox8DRJx6bRnPSHOaaxs8rRQC+xRCjj+rrJeSqH7EUHB/AbV9ALtcTyZ+gusuk0qjFx8P5t5wtZIqm7n5UaizNzajSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403424; c=relaxed/simple;
	bh=RSLA6nbeYDB69SfLvlA4XoBuJ0rmB3xsdXSwqCL9b2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNxk+lUpFI/Fkam0qI9eGHs1lcmpRB4LrB68CBZMYWhNEqg4w2tZWcUTJpfIk1y6+MYlHQlQgGy1Iw6b87PLTbA2vbzyFgUtiT14cMvWmZcDSu5l5T9jLy9bhSxBjvm66Hy4FSCDaiEqVUV74Xm+pu3m9moCyAIGzeSrR92A5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YypRK+9Y; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso1179045241.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725403421; x=1726008221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyKLp2X/aLUkAuQMAIzM6BMt+s7i3E+TaRptCHvpUeU=;
        b=YypRK+9YiePAWAbKBU50UFU9x8EwNT9VGxT2C/FfubAIbLRNVOWmpi1t+BbNHDjneW
         u7L8dOlLjv8NA3W05eeAQEd8PDhoYc0XTT/gCwAlWlrHhK6YnhbFoeDCvVEYVXSGyZAB
         2XGEc6m4y9Hpr31GIZePmpAlVjiRwZO48BCuWRWZk1JZvJ+qlG/u/YF2VDPxsUNuaEXK
         I95lD8wZDVvYIB/dmGxvNRDwwUCoSSqK1ppCALHMSHvZthw2oWgKFVIbNxzs6HjaJVlB
         QPYcVcP1Zoefne42+fZ7h7sF0ujDWoJXnftHaIsMmwgxaz6rP0WgfOgusXY/sFhD0UiK
         zFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403421; x=1726008221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyKLp2X/aLUkAuQMAIzM6BMt+s7i3E+TaRptCHvpUeU=;
        b=JLHNH3KdpQPOAHt0XBws2TXIjY3S7bUFTRQ0+LOdgRi7H1Fmx28g0VLsKTEqsU4pEz
         imWo2PbmVKp8AGRJ0xKWwI4g/rDoxMs1plNR+xh+uIdKK/HAMNW/oYtA5tTrWcytx55z
         snMZeU4ujacTcowwVfcLC1CGbBNTOvZpKWmgPwqy6HZ2/jqBIi7U8SlyCYm7Xg6vQGT0
         YWrrz13oJuGoEaMKq3syCB41wTWdHwBYNpzpHF56xQhgu+hMiToxZHDdG6jHQyHLuH0q
         garIhf/hXr+rmH0O9NEWJOs9wWAfPojirnsXvqtUxt9Lkdew+y4djcd4BQHnkHEHwSa0
         2zMA==
X-Forwarded-Encrypted: i=1; AJvYcCXw5kuDT+xQwLaIE3kQIZ0broDaPrHapBbRAHQ8//pMCFcbMKwMev/NRkvD4dpXXEiFaz0S61ZoNFQbDDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBesr48vj+kzvTsjF+ZpOdlmUEEvaHlJs8IqTBzW9oW8MuKtTh
	bDh/Zku4Oze3LwbwmLGeGFSSOL/G+Nr/JGdkBqyX9l5Dxk99fTF7x2Dke3S3T0k7ic6qi3nfPim
	PnF/juclXNZCaWuEv9I+9w8+X+Rk=
X-Google-Smtp-Source: AGHT+IFkginAgKVH6MtyiWT0JWfQMlg3M6600l6CL0SZSSNEdqsRrSzzSKjjbrH7j90ZkLGjMDRc5+u0/OoORyC/eA4=
X-Received: by 2002:a05:6102:d8a:b0:48f:4eeb:566d with SMTP id
 ada2fe7eead31-49ba89d5d90mr5955078137.12.1725403421161; Tue, 03 Sep 2024
 15:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225009.34576-1-21cnbao@gmail.com> <20240903110109.1696-1-hdanton@sina.com>
 <CAGsJ_4xr-HvqKdh=Q=sVKM+hM+VS1Cf4gqPvq9vDtnQSBO9X=A@mail.gmail.com>
 <ZtcVYBUNWGow40pX@google.com> <CAGsJ_4y-s25N94b2GnxypFhb-5bv53wOcJBt14Dx83M6AJD=7Q@mail.gmail.com>
 <ZteMZEsMCMig8zOQ@google.com>
In-Reply-To: <ZteMZEsMCMig8zOQ@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Sep 2024 10:43:29 +1200
Message-ID: <CAGsJ_4wuKpk+U2K+o_zwYXtyR=qsnKxadfkm39rsaKkJxY-j5A@mail.gmail.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to
 reduce the lock duration
To: Carlos Llamas <cmllamas@google.com>
Cc: Hillf Danton <hdanton@sina.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:23=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Wed, Sep 04, 2024 at 09:10:20AM +1200, Barry Song wrote:
> > However, I'm not entirely convinced that this is a problem :-) Concurre=
nt
> > allocations like this can occur in many places, especially in PFs. Recl=
amation
> > is not useless because it helps free up memory for others; it's not
> > without value.
>
> Yeah, for binder though there is a high chance of multiple callers
> trying to allocate the _same_ page concurrently. What I observed is that
> pages being reclaimed "in vain" are often in the same vma and this means
> subsequent callers will need to allocate these pages.
>
> But even if this wasn't an issue, the correct solution would still be to
> support concurrent faults. So, in reality it doesn't matter and we still
> need to refactor the call to be non-exclusive.
>
> > I also don't believe binder is one of the largest users executing concu=
rrent
> > allocations.
>
> Oh, I have no statistics on this.
>
> > Awesome! I=E2=80=99m eager to see your patch, and we=E2=80=99re ready t=
o help with testing.
> > I strongly recommend dropping the write lock entirely. Using
> > `mmap_write_lock()` isn=E2=80=99t just a binder-specific concern; it ha=
s the
> > potential to affect the entire Android system.
> >
> > In patch 3, I experimented with using `per_vma_lock` as well. I=E2=80=
=99m _not_
> > proposing it for merging since you=E2=80=99re already working on it, bu=
t I wanted
> > to share the idea. (just like patch2, it has only passed build-test)
>
> Yeap, I'm using the per-vma-lock too per Suren's suggestion.
>
> >
> > [PATCH] binder_alloc: Further move to per_vma_lock from mmap_read_lock
> >
> > To further reduce the read lock duration, let's try using per_vma_lock
> > first. If that fails, we can take the read lock, similar to how page
> > fault handlers operate.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  drivers/android/binder_alloc.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index a2281dfacbbc..b40a5dd650c8 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -221,6 +221,8 @@ static int binder_install_single_page(struct
> > binder_alloc *alloc,
> >                                       struct binder_lru_page *lru_page,
> >                                       unsigned long addr)
> >  {
> > +       struct vm_area_struct *vma;
> > +       bool per_vma_lock =3D true;
> >         struct page *page;
> >         int ret =3D 0;
> >
> > @@ -235,10 +237,15 @@ static int binder_install_single_page(struct
> > binder_alloc *alloc,
> >          */
> >         page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> >
> > -       mmap_read_lock(alloc->mm);
> > +       vma =3D lock_vma_under_rcu(alloc->mm, addr);
> > +       if (!vma) {
> > +               per_vma_lock =3D false;
> > +               mmap_read_lock(alloc->mm);
> > +               vma =3D find_vma(alloc->mm, addr);
> > +       }
> >
> > -       /* vma might have been dropped or deattached */
> > -       if (!alloc->vma || !find_vma(alloc->mm, addr)) {
> > +       /* vma might have been dropped, deattached or changed to new on=
e */
> > +       if (!alloc->vma || !vma || vma !=3D alloc->vma) {
> >                 pr_err("%d: %s failed, no vma\n", alloc->pid, __func__)=
;
> >                 ret =3D -ESRCH;
> >                 goto out;
> > @@ -270,7 +277,10 @@ static int binder_install_single_page(struct
> > binder_alloc *alloc,
> >         binder_set_installed_page(lru_page, page);
> >         spin_unlock(&alloc->lock);
> >  out:
> > -       mmap_read_unlock(alloc->mm);
> > +       if (per_vma_lock)
> > +               vma_end_read(vma);
> > +       else
> > +               mmap_read_unlock(alloc->mm);
> >         mmput_async(alloc->mm);
> >         if (ret && page)
> >                 __free_page(page);
> > --
> > 2.39.3 (Apple Git-146)
>
> This looks fairly similar to my patch. However, you would need to handle
> the case were vm_insert_page() returns -EBUSY (success that raced) and
> also sync with the shrinker callbacks in binder_alloc_free_page() which
> is the biggest concern.
>
> Let's not duplicate efforts though. Can we please wait for my patch?
> I'll add you as Co-Developed-by, since you've posted this already?

Yes, I=E2=80=99d be more than happy to wait for your patch, as I believe yo=
u have
much much more experience with binder.

>
> Regards,
> Carlos Llamas

Thanks
Barry

