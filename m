Return-Path: <linux-kernel+bounces-312720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674B969A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE72831DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079011B9837;
	Tue,  3 Sep 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ew2bIW0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A51A0BC7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359831; cv=none; b=cxeHvQLp4X7eUZGL1mUovwMZfi9t4S470aQ18a3zR1JzAzspMppOn5cwEJv+waCfSAoYuBueTz1PLFspO9ZK/MMrTfT272r+AtgLyxCDr1c1LoFN8gye+Ueo/fMfZhwlq6DoJPNCLiiQIjjWDr8gQNSyIGMYRpI+10nOTR3tRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359831; c=relaxed/simple;
	bh=lgFfoM9wea4mTJR7aEIx+Ij9DkleM4tc+jOoWTKZ3e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOqXW/X3j/gh4HArraVFQO9sHGpkGGLB11D4v/i/S6DDh40ts+indd8e1w9y/ukZPiVSFHryvnGvxlWf9YNaCHMQ2FgH46Phv9hW09Odd/QiRV/0K9L9fM8goNGCNic1HV+o7Q9RLL0LO/yumIM7RAd4n4xZ31pfZeb1/Gcnw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ew2bIW0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F97C4CEC5;
	Tue,  3 Sep 2024 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725359830;
	bh=lgFfoM9wea4mTJR7aEIx+Ij9DkleM4tc+jOoWTKZ3e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ew2bIW0pEtrD5VzvPKrMlwVAbI4f+7Oc/dfujjthQkAzX5oBReRBiS5fcEuKaQA8h
	 OO3gvBhp3/yJ3qwoHOidZaaus87ctEDfPlrgrmm7lgaAmH/HFdcu6mQu0Om/P0KHK3
	 nUr1q20AvI1QNiFEysbA86+pROmi9HGTItEPwnnM=
Date: Tue, 3 Sep 2024 12:04:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to
 reduce the lock duration
Message-ID: <2024090331-rewire-ransack-e73b@gregkh>
References: <20240902225009.34576-1-21cnbao@gmail.com>
 <2024090325-sublet-unsworn-b6a3@gregkh>
 <CAGsJ_4ybZRudJ+p7pxgb1xH7HP0rKcWW1Dtr_kvb7EUwnqxsQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ybZRudJ+p7pxgb1xH7HP0rKcWW1Dtr_kvb7EUwnqxsQQ@mail.gmail.com>

On Tue, Sep 03, 2024 at 05:07:23PM +0800, Barry Song wrote:
> On Tue, Sep 3, 2024 at 4:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 10:50:09AM +1200, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > The mmap_write_lock() can block all access to the VMAs, for example page
> > > faults. Performing memory allocation while holding this lock may trigger
> > > direct reclamation, leading to others being queued in the rwsem for an
> > > extended period.
> > > We've observed that the allocation can sometimes take more than 300ms,
> > > significantly blocking other threads. The user interface sometimes
> > > becomes less responsive as a result. To prevent this, let's move the
> > > allocation outside of the write lock.
> > > A potential side effect could be an extra alloc_page() for the second
> > > thread executing binder_install_single_page() while the first thread
> > > has done it earlier. However, according to Tangquan's 48-hour profiling
> > > using monkey, the likelihood of this occurring is minimal, with a ratio
> > > of only 1 in 2400. Compared to the significantly costly rwsem, this is
> > > negligible.
> > > On the other hand, holding a write lock without making any VMA
> > > modifications appears questionable and likely incorrect. While this
> > > patch focuses on reducing the lock duration, future updates may aim
> > > to eliminate the write lock entirely.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Arve Hjønnevåg" <arve@android.com>
> > > Cc: Todd Kjos <tkjos@android.com>
> > > Cc: Martijn Coenen <maco@android.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Carlos Llamas <cmllamas@google.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Tested-by: Tangquan Zheng <zhengtangquan@oppo.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  drivers/android/binder_alloc.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > index b3acbc4174fb..f20074e23a7c 100644
> > > --- a/drivers/android/binder_alloc.c
> > > +++ b/drivers/android/binder_alloc.c
> > > @@ -227,13 +227,23 @@ static int binder_install_single_page(struct binder_alloc *alloc,
> > >       if (!mmget_not_zero(alloc->mm))
> > >               return -ESRCH;
> > >
> > > +     /*
> > > +      * Don't allocate page in mmap_write_lock, this can block
> > > +      * mmap_rwsem for a long time; Meanwhile, allocation failure
> > > +      * doesn't necessarily need to return -ENOMEM, if lru_page
> > > +      * has been installed, we can still return 0(success).
> > > +      */
> > > +     page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> >
> > But now you are allocating new pages even if binder_get_installed_page()
> > is an error, right?  Doesn't that slow things down?
> 
> very very unlikely, as the ratio is only 1/2400 while write lock 100% blocks
> everyone.

Ok, but:

> > How was this benchmarked?
> 
> i actually put Tangquan's profiling result:
> "
> However, according to Tangquan's 48-hour profiling
>  using monkey, the likelihood of this occurring is minimal, with a ratio
>  of only 1 in 2400. Compared to the significantly costly rwsem, this is
>  negligible."

That's not a benchmark, or any real numbers of how this overall saves
any time.

> > >       /*
> > >        * Protected with mmap_sem in write mode as multiple tasks
> > >        * might race to install the same page.
> > >        */
> > >       mmap_write_lock(alloc->mm);
> > > -     if (binder_get_installed_page(lru_page))
> > > +     if (binder_get_installed_page(lru_page)) {
> > > +             ret = 1;
> >
> > That is not a valid error value :(
> >
> > >               goto out;
> > > +     }
> > >
> > >       if (!alloc->vma) {
> > >               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> > > @@ -241,7 +251,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
> > >               goto out;
> > >       }
> > >
> > > -     page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> > >       if (!page) {
> > >               pr_err("%d: failed to allocate page\n", alloc->pid);
> > >               ret = -ENOMEM;
> > > @@ -252,7 +261,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
> > >       if (ret) {
> > >               pr_err("%d: %s failed to insert page at offset %lx with %d\n",
> > >                      alloc->pid, __func__, addr - alloc->buffer, ret);
> > > -             __free_page(page);
> > >               ret = -ENOMEM;
> > >               goto out;
> > >       }
> > > @@ -262,7 +270,9 @@ static int binder_install_single_page(struct binder_alloc *alloc,
> > >  out:
> > >       mmap_write_unlock(alloc->mm);
> > >       mmput_async(alloc->mm);
> > > -     return ret;
> > > +     if (ret && page)
> > > +             __free_page(page);
> > > +     return ret < 0 ? ret : 0;
> >
> > Please only use ? : for when you have to, otherwise please spell it out
> > with a normal if statement:
> >         if (ret < 0)
> >                 return ret;
> >         return 0;
> >
> > But, this is abusing the fact that you set "ret = 1" above, which is
> > going to trip someone up in the future as that is NOT a normal coding
> > pattern we have in the kernel, sorry.
> >
> > If you insist on this change, please rework it to not have that type of
> > "positive means one thing, 0 means another, and negative means yet
> > something else" please.
> 
> I was trying to consolidate all free_page() calls into one place. Otherwise,
> we would need multiple free_page() calls. I'm perfectly fine with having more
> free_page() calls in both the ret = 1 and ret < 0 paths. In that case,
> the ret = 1
> path can be removed if you prefer.

Remember, we write code for people first, and compilers second.  You
have to maintain this code for the next 10+ years, make it _VERY_
obvious what is happening and how it works as you will be coming back to
it and not remembering what was made for what reason at all.

thanks,

greg k-h

