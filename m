Return-Path: <linux-kernel+bounces-312774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF07969B10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE921F249FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21771A0BDF;
	Tue,  3 Sep 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEOlR0CK"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFA1B12CE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361287; cv=none; b=k1GqnsqTNrkavgO/hkJi4FSNBLzO1j1mcwE3IapKxqGA26hSFaF9TV0Ee4gfUOl2/WHH5fX9VYTQMN2ROVi+FSGk7GwiOhF1Q5NsxhZZQPtWBb+NC+ykJhRB2BNS3w+L5L19Dr1MNOoGoJ/xJkKjkDY/tBrcfYs2Xta9yYTeum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361287; c=relaxed/simple;
	bh=VQP5cZB3AHdT3kBmHHiSXdnNpyJ5EZRJxhmpn9xmrMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0p/Ec37QO2G7Klb1Yz0u49tZmObbTg+tXjpPUrz/ZGwBu9PUIsz0ssQAP+im0W9uipAcfWlW42FB8RHWR0ziFJDqJgwpMWToTeMY7VvGzsYYe5uh3aq76B6AWNnZj/BBh1XIH6wwdm/BizP6TAlltq/ALKlia7Mctd694RjW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEOlR0CK; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4fd094c88afso1709005e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725361283; x=1725966083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+W5ncyMf/3/rrJ60/0xzarvVQ+hV/TRfWbGHxMBYTY=;
        b=DEOlR0CKOmbmZ0YB5BuSCKVZ6jTHYW7IgLgNqTXZtIoXzH2oT3rxIPh8gyCrffsL+U
         O3U5mxya2rtLfUUbLEs9zMvlgKxl1i9gSF1Q2b5j7BlKQ0+aiNkwLpn2vZnE9tQi0vsC
         LsqGVpaXgRe38BNy3STtBRpGjQenvXYIw6AobhvjA/ZwlxkRdBCzgciz4IrOncV1QDhN
         m12ErYJdLr8aQ0CgoMWn7exK0MD5QHF4inNSd6RIRPVywFaKtUZzzvBm1fIeVblWHa91
         /Qwu41yy8AsFu6E7Vte9x6Ka+ybF2/ylnPKuLC4ZQDlg5NQWnWpwNvWEHGlhyEaj8BND
         9tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725361283; x=1725966083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+W5ncyMf/3/rrJ60/0xzarvVQ+hV/TRfWbGHxMBYTY=;
        b=ttORKgecoBjlkJpjEvdqcDDShOLaBY9P9xnADPJuCKwqwD9WDZpJlbZxt8h+iWYN3R
         Bp2je+BbZdqD76HQmTeFsIZ3475DRxfOi+TWoTO/OWoJM/NWJQzO7EG6nQQckXkoOFbH
         Bf7NQyV8Yf60l0C8Hw2PUAWperOEjNU/iZEX+0b/iRiRnwFBMshNkjk7iTMJf9LcM5aY
         4BZMxvh8EfTqKvC+DlVHBjDquPNjrkWKlas9H93rfsIiOn3VCckLTwqg2CSR8tdiaak1
         O+k8AP18mrxtGf+kEJrbvESeGpQkj7Y9gzHmlHDXJo+j33CoxrjqHn8zpNDjoataYMeu
         AZWg==
X-Forwarded-Encrypted: i=1; AJvYcCWC7u9T6O3cXog+GxcWHCQ/xhNMNqGHN8Wmn5kexti+u61dEF2M6FC3UBEBAg/QHAu8QrMUp4MDOMzvuAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkaxXBoFhQqZQDpFWVOJCqj1hTeAUxlmil8dQryPjNDh3QgpA
	sw68T1AEFeCuIL5/c3xOQ5R7EggjiBpJaSnslJYrP+k5A4DqKcXFiAgNEawywlgU0ge6Pt9Hf35
	zkkzh/BMZuH3+RJeg7e1M/tS29SN41/btBOY=
X-Google-Smtp-Source: AGHT+IEqU2aFaT+yL685jTuWGCTiEYj5BFrK9lDDwFRzVWMgsH4ldSem0QL8Xruidl3kmw3nBoEuaaC7+Rb+LgnOQpQ=
X-Received: by 2002:a05:6122:182a:b0:4df:1d06:eeb7 with SMTP id
 71dfb90a1353d-5009ac02acfmr11087699e0c.1.1725361283250; Tue, 03 Sep 2024
 04:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225009.34576-1-21cnbao@gmail.com> <2024090325-sublet-unsworn-b6a3@gregkh>
 <CAGsJ_4ybZRudJ+p7pxgb1xH7HP0rKcWW1Dtr_kvb7EUwnqxsQQ@mail.gmail.com> <2024090331-rewire-ransack-e73b@gregkh>
In-Reply-To: <2024090331-rewire-ransack-e73b@gregkh>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 3 Sep 2024 19:01:08 +0800
Message-ID: <CAGsJ_4zkz6fxkRFm190C89=p3=keJCYvrYtmjapTw=BbU_xUSQ@mail.gmail.com>
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

On Tue, Sep 3, 2024 at 6:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 03, 2024 at 05:07:23PM +0800, Barry Song wrote:
> > On Tue, Sep 3, 2024 at 4:57=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Sep 03, 2024 at 10:50:09AM +1200, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > The mmap_write_lock() can block all access to the VMAs, for example=
 page
> > > > faults. Performing memory allocation while holding this lock may tr=
igger
> > > > direct reclamation, leading to others being queued in the rwsem for=
 an
> > > > extended period.
> > > > We've observed that the allocation can sometimes take more than 300=
ms,
> > > > significantly blocking other threads. The user interface sometimes
> > > > becomes less responsive as a result. To prevent this, let's move th=
e
> > > > allocation outside of the write lock.
> > > > A potential side effect could be an extra alloc_page() for the seco=
nd
> > > > thread executing binder_install_single_page() while the first threa=
d
> > > > has done it earlier. However, according to Tangquan's 48-hour profi=
ling
> > > > using monkey, the likelihood of this occurring is minimal, with a r=
atio
> > > > of only 1 in 2400. Compared to the significantly costly rwsem, this=
 is
> > > > negligible.
> > > > On the other hand, holding a write lock without making any VMA
> > > > modifications appears questionable and likely incorrect. While this
> > > > patch focuses on reducing the lock duration, future updates may aim
> > > > to eliminate the write lock entirely.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
> > > > Cc: Todd Kjos <tkjos@android.com>
> > > > Cc: Martijn Coenen <maco@android.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Carlos Llamas <cmllamas@google.com>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Tested-by: Tangquan Zheng <zhengtangquan@oppo.com>
> > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > ---
> > > >  drivers/android/binder_alloc.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binde=
r_alloc.c
> > > > index b3acbc4174fb..f20074e23a7c 100644
> > > > --- a/drivers/android/binder_alloc.c
> > > > +++ b/drivers/android/binder_alloc.c
> > > > @@ -227,13 +227,23 @@ static int binder_install_single_page(struct =
binder_alloc *alloc,
> > > >       if (!mmget_not_zero(alloc->mm))
> > > >               return -ESRCH;
> > > >
> > > > +     /*
> > > > +      * Don't allocate page in mmap_write_lock, this can block
> > > > +      * mmap_rwsem for a long time; Meanwhile, allocation failure
> > > > +      * doesn't necessarily need to return -ENOMEM, if lru_page
> > > > +      * has been installed, we can still return 0(success).
> > > > +      */
> > > > +     page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> > >
> > > But now you are allocating new pages even if binder_get_installed_pag=
e()
> > > is an error, right?  Doesn't that slow things down?
> >
> > very very unlikely, as the ratio is only 1/2400 while write lock 100% b=
locks
> > everyone.
>
> Ok, but:
>
> > > How was this benchmarked?
> >
> > i actually put Tangquan's profiling result:
> > "
> > However, according to Tangquan's 48-hour profiling
> >  using monkey, the likelihood of this occurring is minimal, with a rati=
o
> >  of only 1 in 2400. Compared to the significantly costly rwsem, this is
> >  negligible."
>
> That's not a benchmark, or any real numbers of how this overall saves
> any time.

My point is that mmap_rw is one of the most notorious locks impacting
system performance. Our profiling indicates that this binder's rwsem lock
is among the top two write locks, blocking page faults and other accesses
to the VMA.

From the memory management perspective, I believe the improvement will
be quite evident. However, I agree that we should include more data to show
how reducing lock contention can enhance overall user experience and
minimize UI lag.

>
> > > >       /*
> > > >        * Protected with mmap_sem in write mode as multiple tasks
> > > >        * might race to install the same page.
> > > >        */
> > > >       mmap_write_lock(alloc->mm);
> > > > -     if (binder_get_installed_page(lru_page))
> > > > +     if (binder_get_installed_page(lru_page)) {
> > > > +             ret =3D 1;
> > >
> > > That is not a valid error value :(
> > >
> > > >               goto out;
> > > > +     }
> > > >
> > > >       if (!alloc->vma) {
> > > >               pr_err("%d: %s failed, no vma\n", alloc->pid, __func_=
_);
> > > > @@ -241,7 +251,6 @@ static int binder_install_single_page(struct bi=
nder_alloc *alloc,
> > > >               goto out;
> > > >       }
> > > >
> > > > -     page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> > > >       if (!page) {
> > > >               pr_err("%d: failed to allocate page\n", alloc->pid);
> > > >               ret =3D -ENOMEM;
> > > > @@ -252,7 +261,6 @@ static int binder_install_single_page(struct bi=
nder_alloc *alloc,
> > > >       if (ret) {
> > > >               pr_err("%d: %s failed to insert page at offset %lx wi=
th %d\n",
> > > >                      alloc->pid, __func__, addr - alloc->buffer, re=
t);
> > > > -             __free_page(page);
> > > >               ret =3D -ENOMEM;
> > > >               goto out;
> > > >       }
> > > > @@ -262,7 +270,9 @@ static int binder_install_single_page(struct bi=
nder_alloc *alloc,
> > > >  out:
> > > >       mmap_write_unlock(alloc->mm);
> > > >       mmput_async(alloc->mm);
> > > > -     return ret;
> > > > +     if (ret && page)
> > > > +             __free_page(page);
> > > > +     return ret < 0 ? ret : 0;
> > >
> > > Please only use ? : for when you have to, otherwise please spell it o=
ut
> > > with a normal if statement:
> > >         if (ret < 0)
> > >                 return ret;
> > >         return 0;
> > >
> > > But, this is abusing the fact that you set "ret =3D 1" above, which i=
s
> > > going to trip someone up in the future as that is NOT a normal coding
> > > pattern we have in the kernel, sorry.
> > >
> > > If you insist on this change, please rework it to not have that type =
of
> > > "positive means one thing, 0 means another, and negative means yet
> > > something else" please.
> >
> > I was trying to consolidate all free_page() calls into one place. Other=
wise,
> > we would need multiple free_page() calls. I'm perfectly fine with havin=
g more
> > free_page() calls in both the ret =3D 1 and ret < 0 paths. In that case=
,
> > the ret =3D 1
> > path can be removed if you prefer.
>
> Remember, we write code for people first, and compilers second.  You
> have to maintain this code for the next 10+ years, make it _VERY_
> obvious what is happening and how it works as you will be coming back to
> it and not remembering what was made for what reason at all.

no objection to this.

>
> thanks,
>
> greg k-h

Thanks
Barry

