Return-Path: <linux-kernel+bounces-313048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48877969F87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1C41C23FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43F2AE97;
	Tue,  3 Sep 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McaI5UkH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C692A1D6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371751; cv=none; b=u8hNNY6fznPvwDuA53eL9AVe6IzCFG+1hXSY0pxtOzF2Jd09b4ByF9v2lchdJ7Wp7gxaaahiUyMLuI79eWLrM/tsATS1fUMHrV3NeEDpVsLwzHCXlSxpGtRB0dGY36wGzAoGgd1ybxfsyDOZpIH6rDhH/2mD0pxBHtbKlCd1BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371751; c=relaxed/simple;
	bh=5zIeyeM/Qmt4j7Zx6DyEsvWyE6OtRWbAlepzVfbZTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1RoA+I44hC9lHVcC/t4c+DaKGRcShwOtfuF9uVLkCaGOEs70PUVcCeDgzXqL8kXsclOv/0zKOFmZufcVqowdKnWkdpUCmaeOConhrNSMa6ZmyLVwX/BP56ItdqGzzuL2gi5MzxMxhDasz3Zv91McjLaPeI/x8ZNXxNV0/9aCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McaI5UkH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2056aa5cefcso428395ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725371749; x=1725976549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aFVlJE2wcPJ/73dJ2/hsvJKsdhKy12KE5SwOspRc07o=;
        b=McaI5UkHa4DuiC7qsBPkyg86dNp2oK3+vIkPd4f9ZXyzVsRZ0TzUfiZc5WKT8iI270
         XFhD/HtFDnz7ySdvMaO7S1Bc5tSe0JxLXgxhzqXusZDIiSlnVP1z9VzhaYsgsVYrYFMv
         6CffEUK1aY+IsTN4IBQikTsjtSMd4rktysXN2nuLBSCXAZ3i9PTvrpaXO1QiUuABF4+r
         TPJ7mKwvuGEf18TIFhkjItq5KeD4oO0mgbDshVSwzgt2vU/Tjbt1/nkZrmDDq4emJQFz
         od2Lr2EK/OBozvgwaS+kohV+8ZhvYsXmWCKHXh9IhdytTXSZdOa3FtrJ35U9Xfc70FUE
         s9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725371749; x=1725976549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFVlJE2wcPJ/73dJ2/hsvJKsdhKy12KE5SwOspRc07o=;
        b=EqNAhGMcsOZVgyVixT8prND/8OlQsGkMGIlH0W/jMSnKpYEAzBFMAAFqVnkfNO3lfc
         6euIbXCTZr8wm7GzYYRPCZl3+8pkajciuRQD6iwhPyGKsi0BGgMkBMNsKTC6DEb03cnj
         kGVsuTrxWmrostqCtXv/AUB8jwjx0ib8lXAcArJzVCH4gFdCCq0IMlbd8U9GK9tWUoJO
         2LoYvREqHpb1JljFuNS8kw1VHsTrXM36wTcmahvzvOYcPNMZC1Jk5vHJPK7WWZQ7wEiW
         rbEb8lW4ickuY84XJ9stVpMef7kNuh5uYB5Ryfr+QXFqiT5Ash1uQU9+9ZUBuY9aYcwF
         BAwg==
X-Forwarded-Encrypted: i=1; AJvYcCXjjr/Np21EMxAQJogo8YTXSs0cUI4xEWOKVQeTZmRSuipfMQ3Xw2jh2TD+kMEIGfmkc4Kvz6qR7cs/5ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YynM3OuhA7YqL01u6+mtAydlDuzGVyXZGVK4cKuAYPYnZMm3nzW
	KugvSu7RQ+LQiceod4gWwDRmv4qVTI9FLdKOV91JvrMP8AAoXxmU4h0UIqIr1Q==
X-Google-Smtp-Source: AGHT+IGrElXa+ZnVJVusZLLZ3n1gY1PRDfijfMKbWF3ERqoNh+U8MNTJcATggm62KZcSLZN+diKQuQ==
X-Received: by 2002:a17:902:da92:b0:1f9:dc74:6c2b with SMTP id d9443c01a7336-20549b8e7c6mr6672125ad.29.1725371748904;
        Tue, 03 Sep 2024 06:55:48 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd9a3sm81638545ad.90.2024.09.03.06.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:55:48 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:55:44 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to
 reduce the lock duration
Message-ID: <ZtcVYBUNWGow40pX@google.com>
References: <20240902225009.34576-1-21cnbao@gmail.com>
 <20240903110109.1696-1-hdanton@sina.com>
 <CAGsJ_4xr-HvqKdh=Q=sVKM+hM+VS1Cf4gqPvq9vDtnQSBO9X=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xr-HvqKdh=Q=sVKM+hM+VS1Cf4gqPvq9vDtnQSBO9X=A@mail.gmail.com>

On Tue, Sep 03, 2024 at 07:45:12PM +0800, Barry Song wrote:
> On Tue, Sep 3, 2024 at 7:01 PM Hillf Danton <hdanton@sina.com> wrote:
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

Thanks for you patch Barry. So, we are aware of this contention and I've
been working on a fix for it. See more about this below.

> >
> > I suspect concurrent allocators make things better wrt response, cutting
> > alloc latency down to 10ms for instance in your scenario. Feel free to
> > show figures given Tangquan's 48-hour profiling.
> 
> Likely.
> 
> Concurrent allocators are quite common in PFs which occur
> in the same PTE. whoever gets PTL sets PTE, others free the allocated
> pages.
> 
> >
> > > A potential side effect could be an extra alloc_page() for the second
> > > thread executing binder_install_single_page() while the first thread
> > > has done it earlier. However, according to Tangquan's 48-hour profiling
> > > using monkey, the likelihood of this occurring is minimal, with a ratio
> > > of only 1 in 2400. Compared to the significantly costly rwsem, this is
> > > negligible.

This is not negligible. In fact, it is the exact reason for the page
allocation to be done with the mmap sem. If the first thread sleeps on
vm_insert_page(), then binder gets into a bad state of multiple threads
trying to reclaim pages that won't really be used. Memory pressure goes
from bad to worst pretty quick.

FWIW, I believe this was first talked about here:
https://lore.kernel.org/all/ZWmNpxPXZSxdmDE1@google.com/


> > > On the other hand, holding a write lock without making any VMA
> > > modifications appears questionable and likely incorrect. While this
> > > patch focuses on reducing the lock duration, future updates may aim
> > > to eliminate the write lock entirely.
> >
> > If spin, better not before taking a look at vm_insert_page().
> 
> I have patch 2/3 transitioning to mmap_read_lock, and per_vma_lock is
> currently in the
> testing queue. At the moment, alloc->spin is in place, but I'm not
> entirely convinced
> it's the best replacement for the write lock. Let's wait for
> Tangquan's test results.
> 
> Patch 2 is detailed below, but it has only passed the build-test phase
> so far, so
> its result is uncertain. I'm sharing it early in case you find it
> interesting. And I
> am not convinced Commit d1d8875c8c13 ("binder: fix UAF of alloc->vma in
> race with munmap()") is a correct fix to really avoid all UAF of alloc->vma.
> 
> [PATCH]  binder_alloc: Don't use mmap_write_lock for installing page
> 
> Commit d1d8875c8c13 ("binder: fix UAF of alloc->vma in race with
> munmap()") uses the mmap_rwsem write lock to protect against a race
> condition with munmap, where the vma is detached by the write lock,
> but pages are zapped by the read lock. This approach is extremely
> expensive for the system, though perhaps less so for binder itself,
> as the write lock can block all other operations.
> 
> As an alternative, we could hold only the read lock and re-check
> that the vma hasn't been detached. To protect simultaneous page
> installation, we could use alloc->lock instead.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  drivers/android/binder_alloc.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index f20074e23a7c..a2281dfacbbc 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -228,24 +228,17 @@ static int binder_install_single_page(struct
> binder_alloc *alloc,
>                 return -ESRCH;
> 
>         /*
> -        * Don't allocate page in mmap_write_lock, this can block
> -        * mmap_rwsem for a long time; Meanwhile, allocation failure
> -        * doesn't necessarily need to return -ENOMEM, if lru_page
> -        * has been installed, we can still return 0(success).
> +        * Allocation failure doesn't necessarily need to return -ENOMEM,
> +        * if lru_page has been installed, we can still return 0(success).
> +        * So, defer the !page check until after binder_get_installed_page()
> +        * is completed.
>          */
>         page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> 
> -       /*
> -        * Protected with mmap_sem in write mode as multiple tasks
> -        * might race to install the same page.
> -        */
> -       mmap_write_lock(alloc->mm);
> -       if (binder_get_installed_page(lru_page)) {
> -               ret = 1;
> -               goto out;
> -       }
> +       mmap_read_lock(alloc->mm);
> 
> -       if (!alloc->vma) {
> +       /* vma might have been dropped or deattached */
> +       if (!alloc->vma || !find_vma(alloc->mm, addr)) {
>                 pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
>                 ret = -ESRCH;
>                 goto out;
> @@ -257,18 +250,27 @@ static int binder_install_single_page(struct
> binder_alloc *alloc,
>                 goto out;
>         }
> 
> +       spin_lock(&alloc->lock);

You can't hold a spinlock and then call vm_insert_page().

> +       if (binder_get_installed_page(lru_page)) {
> +               spin_unlock(&alloc->lock);
> +               ret = 1;
> +               goto out;
> +       }
> +
>         ret = vm_insert_page(alloc->vma, addr, page);
>         if (ret) {
>                 pr_err("%d: %s failed to insert page at offset %lx with %d\n",
>                        alloc->pid, __func__, addr - alloc->buffer, ret);
> +               spin_unlock(&alloc->lock);
>                 ret = -ENOMEM;
>                 goto out;
>         }
> 
>         /* Mark page installation complete and safe to use */
>         binder_set_installed_page(lru_page, page);
> +       spin_unlock(&alloc->lock);
>  out:
> -       mmap_write_unlock(alloc->mm);
> +       mmap_read_unlock(alloc->mm);
>         mmput_async(alloc->mm);
>         if (ret && page)
>                 __free_page(page);
> --
> 2.39.3 (Apple Git-146)


Sorry, but as I mentioned, I've been working on fixing this contention
by supporting concurrent "faults" in binder_install_single_page(). This
is the appropriate fix. I should be sending a patch soon after working
out the conflicts with the shrinker's callback.

Thanks,
--
Carlos Llamas

