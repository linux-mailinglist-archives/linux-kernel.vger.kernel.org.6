Return-Path: <linux-kernel+bounces-313791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADA96A9CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7335D1F24F02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B51EBFF1;
	Tue,  3 Sep 2024 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIhDpOZp"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D81EBFEB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725397835; cv=none; b=D6qnBfYkJwQBddcYn3icSBYaY9kU+bHoNuBaTUBi8cMW8B7VFWHm7CAB669WVx4XrTX4HDG3OgwY9rAIU4H5IFp5ofT6rFf76fMkVN/nge5yTdTdAW9qbbvuw/3KbGlkaWv+IFqxWM+DavoDtNzy9JHoalxWWC1zH15eEadfoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725397835; c=relaxed/simple;
	bh=kTpXgRFyLYM+/yBEitslSJ/oSHaBQDe16DCwXU0SxZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZjf/C7IR1xWxYuOUOxG8yumfJFDT6aokbitsCtZPKuZ7+7lqIOm5Nzt2efPFEBkPeeZtsqwp93lrLE/GHDAQeJkzGvsBhmGkBLEykz7pLgGA767jIw5W4VNPTbTs/6xTSrGvGtnN6N85mBhdXuMoPw7hzwPLoQwhFgHgUc9wPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIhDpOZp; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498d0c68a14so1894033137.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725397832; x=1726002632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1YSZZgvfXVO5DYb8OvWgPT+mVWIMqYovLPmo9Ff4pQ=;
        b=UIhDpOZpWVDQU44qg5kT5BA6pkUrAr7wJIfB8KsPG9BCDU0k9u2FfBYkUfesmwy+3h
         b6N5czRkR4R7cW/ndNz5yZWZd12bgkvH8V4SReWruPxXnjaTzzXmD/aeR1OlTf5I23sk
         Jd6ks8/7pIZtZPNvZPy99+0oUH7RnUeCF5UZlh00rWkjceB/jkNFj0M6keZYjSVz3d4H
         fh+m/mSelR0wJpSsfVWxOD0PQHXBNyBYKXLeHqkFifenx6vlARPG2Ybxv6fYw80MRnN8
         6XLCiyVmoVKchh4+tt9ioSfr5S3XPqXdfUr9pqtDemOLde9B+rkSJCDaaR8aozcHcOjj
         Qsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725397832; x=1726002632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1YSZZgvfXVO5DYb8OvWgPT+mVWIMqYovLPmo9Ff4pQ=;
        b=YJiPxYNBnC655Iw5Rz9eSQUKLukYqFGHgn4xlwzNtzofHZNoUYQhtdC6y8kEdJq/3n
         ITbaPfC5oRnY/B8RYRlWN1Bhm2SrIbrM3DnQb8vtIrgY0Im2kHyHESmabHwa7bGMWGiQ
         aiwLSequQFuMwORTXFTMgPtD1ruKNtyRqAHYKphHt1jEKChxCftZC1fcY+9H0sjLiWGS
         AIkwfnyeLKIrzEvwHpvSySHRR6PWmgPfx+P5xs2Ld8YIxoVchHW45SvVEIYqStE9YXeS
         XHtbvbr/cCDiUwwSzIWtfhGG9W2mjXuGDN69tr5oxASXSsrj9lnZWUuAoq4uDP9si1rV
         HsPw==
X-Forwarded-Encrypted: i=1; AJvYcCU7DIAMVhuDr3o6cl+KVEha173yQ3DUUj5+tBmhA/XJ0PeL/UdznHXn2z3S0oD8AuOxB4gLIXv5R04thc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0B6GG9XUfohyx08tspbNRNkc6i5WjOnI102B5dgrwywPhaWUd
	+cQaa1AEVoCvk2S0e9dy490/hgmxh7Zkshtd8fuZdOQm5px5pb1vCl1/53ANWY0P7POkMSpiK2H
	WcLdo5K28wfaZ2PGq3CslBO2m4WA=
X-Google-Smtp-Source: AGHT+IERyU0B2xVmbm879xr3A+O4L9Hv/Kmux6TZiP0CyIKM7GOV6cJ1IJPUej4K7CC4lL4Df2rtOuqWOGR1OYtGNgA=
X-Received: by 2002:a05:6102:3593:b0:498:f027:254a with SMTP id
 ada2fe7eead31-49a798ffb28mr14780511137.1.1725397831982; Tue, 03 Sep 2024
 14:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225009.34576-1-21cnbao@gmail.com> <20240903110109.1696-1-hdanton@sina.com>
 <CAGsJ_4xr-HvqKdh=Q=sVKM+hM+VS1Cf4gqPvq9vDtnQSBO9X=A@mail.gmail.com> <ZtcVYBUNWGow40pX@google.com>
In-Reply-To: <ZtcVYBUNWGow40pX@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Sep 2024 09:10:20 +1200
Message-ID: <CAGsJ_4y-s25N94b2GnxypFhb-5bv53wOcJBt14Dx83M6AJD=7Q@mail.gmail.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to
 reduce the lock duration
To: Carlos Llamas <cmllamas@google.com>
Cc: Hillf Danton <hdanton@sina.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:55=E2=80=AFAM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Tue, Sep 03, 2024 at 07:45:12PM +0800, Barry Song wrote:
> > On Tue, Sep 3, 2024 at 7:01=E2=80=AFPM Hillf Danton <hdanton@sina.com> =
wrote:
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
>
> Thanks for you patch Barry. So, we are aware of this contention and I've
> been working on a fix for it. See more about this below.

Cool, Carlos!

>
> > >
> > > I suspect concurrent allocators make things better wrt response, cutt=
ing
> > > alloc latency down to 10ms for instance in your scenario. Feel free t=
o
> > > show figures given Tangquan's 48-hour profiling.
> >
> > Likely.
> >
> > Concurrent allocators are quite common in PFs which occur
> > in the same PTE. whoever gets PTL sets PTE, others free the allocated
> > pages.
> >
> > >
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
>
> This is not negligible. In fact, it is the exact reason for the page
> allocation to be done with the mmap sem. If the first thread sleeps on
> vm_insert_page(), then binder gets into a bad state of multiple threads
> trying to reclaim pages that won't really be used. Memory pressure goes
> from bad to worst pretty quick.
>
> FWIW, I believe this was first talked about here:
> https://lore.kernel.org/all/ZWmNpxPXZSxdmDE1@google.com/

However, I'm not entirely convinced that this is a problem :-) Concurrent
allocations like this can occur in many places, especially in PFs. Reclamat=
ion
is not useless because it helps free up memory for others; it's not
without value.
I also don't believe binder is one of the largest users executing concurren=
t
allocations.

>
>
> > > > On the other hand, holding a write lock without making any VMA
> > > > modifications appears questionable and likely incorrect. While this
> > > > patch focuses on reducing the lock duration, future updates may aim
> > > > to eliminate the write lock entirely.
> > >
> > > If spin, better not before taking a look at vm_insert_page().
> >
> > I have patch 2/3 transitioning to mmap_read_lock, and per_vma_lock is
> > currently in the
> > testing queue. At the moment, alloc->spin is in place, but I'm not
> > entirely convinced
> > it's the best replacement for the write lock. Let's wait for
> > Tangquan's test results.
> >
> > Patch 2 is detailed below, but it has only passed the build-test phase
> > so far, so
> > its result is uncertain. I'm sharing it early in case you find it
> > interesting. And I
> > am not convinced Commit d1d8875c8c13 ("binder: fix UAF of alloc->vma in
> > race with munmap()") is a correct fix to really avoid all UAF of alloc-=
>vma.
> >
> > [PATCH]  binder_alloc: Don't use mmap_write_lock for installing page
> >
> > Commit d1d8875c8c13 ("binder: fix UAF of alloc->vma in race with
> > munmap()") uses the mmap_rwsem write lock to protect against a race
> > condition with munmap, where the vma is detached by the write lock,
> > but pages are zapped by the read lock. This approach is extremely
> > expensive for the system, though perhaps less so for binder itself,
> > as the write lock can block all other operations.
> >
> > As an alternative, we could hold only the read lock and re-check
> > that the vma hasn't been detached. To protect simultaneous page
> > installation, we could use alloc->lock instead.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  drivers/android/binder_alloc.c | 32 +++++++++++++++++---------------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index f20074e23a7c..a2281dfacbbc 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -228,24 +228,17 @@ static int binder_install_single_page(struct
> > binder_alloc *alloc,
> >                 return -ESRCH;
> >
> >         /*
> > -        * Don't allocate page in mmap_write_lock, this can block
> > -        * mmap_rwsem for a long time; Meanwhile, allocation failure
> > -        * doesn't necessarily need to return -ENOMEM, if lru_page
> > -        * has been installed, we can still return 0(success).
> > +        * Allocation failure doesn't necessarily need to return -ENOME=
M,
> > +        * if lru_page has been installed, we can still return 0(succes=
s).
> > +        * So, defer the !page check until after binder_get_installed_p=
age()
> > +        * is completed.
> >          */
> >         page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> >
> > -       /*
> > -        * Protected with mmap_sem in write mode as multiple tasks
> > -        * might race to install the same page.
> > -        */
> > -       mmap_write_lock(alloc->mm);
> > -       if (binder_get_installed_page(lru_page)) {
> > -               ret =3D 1;
> > -               goto out;
> > -       }
> > +       mmap_read_lock(alloc->mm);
> >
> > -       if (!alloc->vma) {
> > +       /* vma might have been dropped or deattached */
> > +       if (!alloc->vma || !find_vma(alloc->mm, addr)) {
> >                 pr_err("%d: %s failed, no vma\n", alloc->pid, __func__)=
;
> >                 ret =3D -ESRCH;
> >                 goto out;
> > @@ -257,18 +250,27 @@ static int binder_install_single_page(struct
> > binder_alloc *alloc,
> >                 goto out;
> >         }
> >
> > +       spin_lock(&alloc->lock);
>
> You can't hold a spinlock and then call vm_insert_page().

Thanks! This patch has only passed the build test so far. It seems like
we can hold off on further testing for now.

>
> > +       if (binder_get_installed_page(lru_page)) {
> > +               spin_unlock(&alloc->lock);
> > +               ret =3D 1;
> > +               goto out;
> > +       }
> > +
> >         ret =3D vm_insert_page(alloc->vma, addr, page);
> >         if (ret) {
> >                 pr_err("%d: %s failed to insert page at offset %lx with=
 %d\n",
> >                        alloc->pid, __func__, addr - alloc->buffer, ret)=
;
> > +               spin_unlock(&alloc->lock);
> >                 ret =3D -ENOMEM;
> >                 goto out;
> >         }
> >
> >         /* Mark page installation complete and safe to use */
> >         binder_set_installed_page(lru_page, page);
> > +       spin_unlock(&alloc->lock);
> >  out:
> > -       mmap_write_unlock(alloc->mm);
> > +       mmap_read_unlock(alloc->mm);
> >         mmput_async(alloc->mm);
> >         if (ret && page)
> >                 __free_page(page);
> > --
> > 2.39.3 (Apple Git-146)
>
>
> Sorry, but as I mentioned, I've been working on fixing this contention
> by supporting concurrent "faults" in binder_install_single_page(). This
> is the appropriate fix. I should be sending a patch soon after working
> out the conflicts with the shrinker's callback.

Awesome! I=E2=80=99m eager to see your patch, and we=E2=80=99re ready to he=
lp with testing.
I strongly recommend dropping the write lock entirely. Using
`mmap_write_lock()` isn=E2=80=99t just a binder-specific concern; it has th=
e
potential to affect the entire Android system.

In patch 3, I experimented with using `per_vma_lock` as well. I=E2=80=99m _=
not_
proposing it for merging since you=E2=80=99re already working on it, but I =
wanted
to share the idea. (just like patch2, it has only passed build-test)

[PATCH] binder_alloc: Further move to per_vma_lock from mmap_read_lock

To further reduce the read lock duration, let's try using per_vma_lock
first. If that fails, we can take the read lock, similar to how page
fault handlers operate.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/android/binder_alloc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index a2281dfacbbc..b40a5dd650c8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -221,6 +221,8 @@ static int binder_install_single_page(struct
binder_alloc *alloc,
                                      struct binder_lru_page *lru_page,
                                      unsigned long addr)
 {
+       struct vm_area_struct *vma;
+       bool per_vma_lock =3D true;
        struct page *page;
        int ret =3D 0;

@@ -235,10 +237,15 @@ static int binder_install_single_page(struct
binder_alloc *alloc,
         */
        page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);

-       mmap_read_lock(alloc->mm);
+       vma =3D lock_vma_under_rcu(alloc->mm, addr);
+       if (!vma) {
+               per_vma_lock =3D false;
+               mmap_read_lock(alloc->mm);
+               vma =3D find_vma(alloc->mm, addr);
+       }

-       /* vma might have been dropped or deattached */
-       if (!alloc->vma || !find_vma(alloc->mm, addr)) {
+       /* vma might have been dropped, deattached or changed to new one */
+       if (!alloc->vma || !vma || vma !=3D alloc->vma) {
                pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
                ret =3D -ESRCH;
                goto out;
@@ -270,7 +277,10 @@ static int binder_install_single_page(struct
binder_alloc *alloc,
        binder_set_installed_page(lru_page, page);
        spin_unlock(&alloc->lock);
 out:
-       mmap_read_unlock(alloc->mm);
+       if (per_vma_lock)
+               vma_end_read(vma);
+       else
+               mmap_read_unlock(alloc->mm);
        mmput_async(alloc->mm);
        if (ret && page)
                __free_page(page);
--=20
2.39.3 (Apple Git-146)


>
> Thanks,
> --
> Carlos Llamas

Thanks
Barry

