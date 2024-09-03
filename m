Return-Path: <linux-kernel+bounces-312571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162996984C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410FFB22F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE7131E2D;
	Tue,  3 Sep 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPPCjKDi"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07C1C7668
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354460; cv=none; b=X6p91RoHNexDNTMhjjB6vte4XLtOylvxqs6e91TAg4IlvskDy+oeZa4mKd0vlMW8Gg3X/OQXSIkdz7YthJowAAWx+1Eizx9w8SgkeNtufdrWrMX0lP0ae+h5dSRkLShPEetboD+vSfXIuIOplBm+EenxIDhvCfntAC3L1DCVkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354460; c=relaxed/simple;
	bh=AGjM9sgZ0hqocEvvffJfYM8EM3WykrklcyBqDCdQW8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kH8Mhr4zEB0USq7dYtmWm7A49c1c7rVIlWeDgciKM2+k0jbRz60W3sssnTDkDAXcDkuNFlP8qHNxZqO8tuBRWKshyKO2HsUa+rrsOUnqc0uVAhF4gP5f3A9MRQkEHRiUCK5qnWkTrIqOb28BO+76LmGZJods2URhh72Y03JfQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPPCjKDi; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4fcec06ce09so909349e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725354458; x=1725959258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e85t1jRey5hTU/qXZuJShM2FVDPgwHYzlYskgkKH3lk=;
        b=mPPCjKDi0o6V+FeL3H62lk/r6aqxkNE9HlIm6y61X+UCc8ZhOYPWK3Ri7Xu7p5m3n8
         0ruWgAGnFTN0rr5eGfci755H7GkT5/pgrvzlsAPeZ5sXrqJahwOxS2OKNzTnuXfmQu07
         QLQ3FLsZoqn0BbtIHZviZyp6PA9+tpaWAp4KtwRALS6zV7VXt+Hoy2/iXm+xu/FvmCWV
         fWsXFIebX3FjzPt/1ZT3K7urswZikq5E+evni8Xi+Ejw76/9P0TtN1dIvo4wb8qMkbai
         dGYGzzBjiJwm+HQwWKfIcypnCYmC8ziBgeqfMsh2GfFHSjQvHWl6BhgE0Pkn3zuRhDjU
         Pd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354458; x=1725959258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e85t1jRey5hTU/qXZuJShM2FVDPgwHYzlYskgkKH3lk=;
        b=P/uY1BvnbnNX+lOvs+lIcO0Dsdtvz7ALmm4IRSIORrbuZWjw7PIMT7GHutgfjclCHc
         Wr4azlUTzLV+mW+JPXEoFA/4nFJEWLrtfJYFfXHdJLZloSKCzZIuch9fa41VFl6o61LV
         7OEiR8hcewkLfWWXwDdWzVHOHNJZW1D8MKGBDTYRR2aLGW/RaHfDebzLqrQ7tReHtZPN
         rOdQ0tclG0WmystB2qwmdkGrlGnEDwMQpQyQJjZRVl1Au2YTxl77GfszCk6TYeDDVaV6
         8qbctMz2Vq4VtgRygkpDALnDQct0tMEcim9guavhHb2bvUhFOJuyWJxTvnFKnMTqtOaF
         eIww==
X-Forwarded-Encrypted: i=1; AJvYcCUe1Ii080m6GkNHrV/IcaetCXxDEL5tJiaqT3KwkUvG8N7ttnC5WXQQPXLhQc4s9mZAx1bT2TxVuYzLhF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbNSE5Dt0fQ0vVzIzWFuC3VsFFL+4cSYuv6Bg1RAIDZh/b9t8
	5Cl2nUEliwTXKbnxWNkW1wgedVQbjSVjiVdXOey5jkx/bqWqhNLbKrHFL8+UM+kXIKU2P6MZMfw
	q7mMpTfiu7qVvFF4WtPo3/Y1c60E=
X-Google-Smtp-Source: AGHT+IHj1AYVj3zCjimE6wgEWqwQiNxIzOdiHbhd55efBHjy3uYLPaw0NRbvJjhQByOZI/TtPwKxBmLc4xUZcamm5RY=
X-Received: by 2002:a05:6122:c97:b0:4f5:446c:f749 with SMTP id
 71dfb90a1353d-5009ac67965mr11745711e0c.6.1725354457477; Tue, 03 Sep 2024
 02:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225009.34576-1-21cnbao@gmail.com> <2024090325-sublet-unsworn-b6a3@gregkh>
In-Reply-To: <2024090325-sublet-unsworn-b6a3@gregkh>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 3 Sep 2024 17:07:23 +0800
Message-ID: <CAGsJ_4ybZRudJ+p7pxgb1xH7HP0rKcWW1Dtr_kvb7EUwnqxsQQ@mail.gmail.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to
 reduce the lock duration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:57=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 03, 2024 at 10:50:09AM +1200, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The mmap_write_lock() can block all access to the VMAs, for example pag=
e
> > faults. Performing memory allocation while holding this lock may trigge=
r
> > direct reclamation, leading to others being queued in the rwsem for an
> > extended period.
> > We've observed that the allocation can sometimes take more than 300ms,
> > significantly blocking other threads. The user interface sometimes
> > becomes less responsive as a result. To prevent this, let's move the
> > allocation outside of the write lock.
> > A potential side effect could be an extra alloc_page() for the second
> > thread executing binder_install_single_page() while the first thread
> > has done it earlier. However, according to Tangquan's 48-hour profiling
> > using monkey, the likelihood of this occurring is minimal, with a ratio
> > of only 1 in 2400. Compared to the significantly costly rwsem, this is
> > negligible.
> > On the other hand, holding a write lock without making any VMA
> > modifications appears questionable and likely incorrect. While this
> > patch focuses on reducing the lock duration, future updates may aim
> > to eliminate the write lock entirely.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Martijn Coenen <maco@android.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Tested-by: Tangquan Zheng <zhengtangquan@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  drivers/android/binder_alloc.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index b3acbc4174fb..f20074e23a7c 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -227,13 +227,23 @@ static int binder_install_single_page(struct bind=
er_alloc *alloc,
> >       if (!mmget_not_zero(alloc->mm))
> >               return -ESRCH;
> >
> > +     /*
> > +      * Don't allocate page in mmap_write_lock, this can block
> > +      * mmap_rwsem for a long time; Meanwhile, allocation failure
> > +      * doesn't necessarily need to return -ENOMEM, if lru_page
> > +      * has been installed, we can still return 0(success).
> > +      */
> > +     page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
>
> But now you are allocating new pages even if binder_get_installed_page()
> is an error, right?  Doesn't that slow things down?

very very unlikely, as the ratio is only 1/2400 while write lock 100% block=
s
everyone.

>
> How was this benchmarked?
>

i actually put Tangquan's profiling result:
"
However, according to Tangquan's 48-hour profiling
 using monkey, the likelihood of this occurring is minimal, with a ratio
 of only 1 in 2400. Compared to the significantly costly rwsem, this is
 negligible."

> > +
> >       /*
> >        * Protected with mmap_sem in write mode as multiple tasks
> >        * might race to install the same page.
> >        */
> >       mmap_write_lock(alloc->mm);
> > -     if (binder_get_installed_page(lru_page))
> > +     if (binder_get_installed_page(lru_page)) {
> > +             ret =3D 1;
>
> That is not a valid error value :(
>
> >               goto out;
> > +     }
> >
> >       if (!alloc->vma) {
> >               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> > @@ -241,7 +251,6 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
> >               goto out;
> >       }
> >
> > -     page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> >       if (!page) {
> >               pr_err("%d: failed to allocate page\n", alloc->pid);
> >               ret =3D -ENOMEM;
> > @@ -252,7 +261,6 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
> >       if (ret) {
> >               pr_err("%d: %s failed to insert page at offset %lx with %=
d\n",
> >                      alloc->pid, __func__, addr - alloc->buffer, ret);
> > -             __free_page(page);
> >               ret =3D -ENOMEM;
> >               goto out;
> >       }
> > @@ -262,7 +270,9 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
> >  out:
> >       mmap_write_unlock(alloc->mm);
> >       mmput_async(alloc->mm);
> > -     return ret;
> > +     if (ret && page)
> > +             __free_page(page);
> > +     return ret < 0 ? ret : 0;
>
> Please only use ? : for when you have to, otherwise please spell it out
> with a normal if statement:
>         if (ret < 0)
>                 return ret;
>         return 0;
>
> But, this is abusing the fact that you set "ret =3D 1" above, which is
> going to trip someone up in the future as that is NOT a normal coding
> pattern we have in the kernel, sorry.
>
> If you insist on this change, please rework it to not have that type of
> "positive means one thing, 0 means another, and negative means yet
> something else" please.

I was trying to consolidate all free_page() calls into one place. Otherwise=
,
we would need multiple free_page() calls. I'm perfectly fine with having mo=
re
free_page() calls in both the ret =3D 1 and ret < 0 paths. In that case,
the ret =3D 1
path can be removed if you prefer.

>
> thanks,
>
> greg k-h

Thanks
Barry

