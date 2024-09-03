Return-Path: <linux-kernel+bounces-313906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45096AC25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F213C1F21C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AB1D2230;
	Tue,  3 Sep 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NePF8YJa"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1D1EBFE4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402220; cv=none; b=ImfAL7gIXck5LW2zUAQDBvoQg2Az4RJyzfX0J4ZV5A/GuhbIL9AygyZht8QLeas5/4n7hogHGTDBrC85C+htx3zQS8bxLJK6VtUxyrDam8pvE1OaBp99SUJMLf7QZvphb+zQcBxyXK1aQ3gL7yRnfOJD9eWRsyG0H5Wgf9+Xdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402220; c=relaxed/simple;
	bh=g9uVYzq1UsU2PbcrqmQGTnSNLBXbtYLselYEvmUKEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe9ZElw9jKnKnnL7myCl7JtcePEtImkBDn/QgjKtoZGZ4pTXEMY1YQAHJ5qOzN2P+r7kFhZo7ub+w7w6mPm7qJLRIHEluc422/HxuIp8JwHhhVdZGOXbrKT67eeKu6OqzIaVsNSvz+TYxPzsUKnphatSy0FC+qWozzbbhvT1fS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NePF8YJa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2056aa5cefcso33565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725402219; x=1726007019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NroSIqwal6C0TPK35/SdmH0JtLPdZfaKT8kFABhfjM0=;
        b=NePF8YJaMg9iAaRfot9sKAF5nfZhHb5IA4e2zr2/19GwmFGbQpt11P7odzl0wb2nVR
         7zL/muuPhwkMrscERFr4tO79SfIUssAuM7g14CW5UoMk62M3/e50JX4GYuXlAhTf+6tA
         MeE8I1vNENnHFa3bG/GUBOskb3JEdjCZrE6AHEmBXQyBXzD+yvWbH69acF2thwHkleHo
         BXlZOeM+pJvpo+fL07lz9mbj2vGShUf8Sx/7DYF/82K1MGeFF4LMhtBfXLuty1gggvvQ
         ELYfSJnhGYwicGkCLhABBYLTq/dTXTNjgnLCRVIODd8PElOq9T5ZftjbHqNiumWjCLla
         arNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725402219; x=1726007019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NroSIqwal6C0TPK35/SdmH0JtLPdZfaKT8kFABhfjM0=;
        b=PRlISxzhRIo9ndHTxqsMg0h2E2UXomS8JAOA3zL+aru/mx4cZ2vrusGAOHQXJ7O0IL
         plXm8oLL445zYdiOEz6JqO17QMbgwtZ96ezTH5xNLqiNbruZQZ0L1+Vi86vijhYyL+Op
         UeOpmlFwLedgblnD2zo+rZClkr9rwpBD6oMD2lEDoKqHHnMIdpypdxtjwOKOdm+E1R8l
         tKPS7WLimqXl76Os5Rfv3LpAa6HDJgA4j54aHnVtonurG3QGomzUXLZrX6P2t7UdLBL/
         ugLpbKCNGDCvQwX2RhDJ0R3cPNJ1JFnfUx/OZOT9DF8CRhcR4e47q2Lm2svq8oX3CsLM
         xwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURrazGU6YdYUW60sWWvEkQrqQ6gQsSgXElz2eE8FVyoDXau4nt3ffPB/HFsommpOTr8cLeGmZrVdOzjME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7VFClM8Nz5WD7jaRNiFdKtY1cAUzhDyF6J+77sOJWrRnIYpn
	zXGkiDYwjDwMaVD1AHWeLrRplV47pu3L9dD8PRYE6Uz80qFMDV8/+TaxB5cN7Q==
X-Google-Smtp-Source: AGHT+IGPK+Sty2egGVVQYW1P+X2yQYVnvIv8jHjlO6wDgkw0UaUcxded/EZRq+TQYfvI+DIfmARohw==
X-Received: by 2002:a17:902:f546:b0:206:ae39:9f9 with SMTP id d9443c01a7336-206b58bdcf2mr424035ad.21.1725402218366;
        Tue, 03 Sep 2024 15:23:38 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d38ffff9sm5300801a91.39.2024.09.03.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:23:37 -0700 (PDT)
Date: Tue, 3 Sep 2024 22:23:32 +0000
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
Message-ID: <ZteMZEsMCMig8zOQ@google.com>
References: <20240902225009.34576-1-21cnbao@gmail.com>
 <20240903110109.1696-1-hdanton@sina.com>
 <CAGsJ_4xr-HvqKdh=Q=sVKM+hM+VS1Cf4gqPvq9vDtnQSBO9X=A@mail.gmail.com>
 <ZtcVYBUNWGow40pX@google.com>
 <CAGsJ_4y-s25N94b2GnxypFhb-5bv53wOcJBt14Dx83M6AJD=7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4y-s25N94b2GnxypFhb-5bv53wOcJBt14Dx83M6AJD=7Q@mail.gmail.com>

On Wed, Sep 04, 2024 at 09:10:20AM +1200, Barry Song wrote:
> However, I'm not entirely convinced that this is a problem :-) Concurrent
> allocations like this can occur in many places, especially in PFs. Reclamation
> is not useless because it helps free up memory for others; it's not
> without value.

Yeah, for binder though there is a high chance of multiple callers
trying to allocate the _same_ page concurrently. What I observed is that
pages being reclaimed "in vain" are often in the same vma and this means
subsequent callers will need to allocate these pages.

But even if this wasn't an issue, the correct solution would still be to
support concurrent faults. So, in reality it doesn't matter and we still
need to refactor the call to be non-exclusive.

> I also don't believe binder is one of the largest users executing concurrent
> allocations.

Oh, I have no statistics on this.

> Awesome! I’m eager to see your patch, and we’re ready to help with testing.
> I strongly recommend dropping the write lock entirely. Using
> `mmap_write_lock()` isn’t just a binder-specific concern; it has the
> potential to affect the entire Android system.
> 
> In patch 3, I experimented with using `per_vma_lock` as well. I’m _not_
> proposing it for merging since you’re already working on it, but I wanted
> to share the idea. (just like patch2, it has only passed build-test)

Yeap, I'm using the per-vma-lock too per Suren's suggestion.

> 
> [PATCH] binder_alloc: Further move to per_vma_lock from mmap_read_lock
> 
> To further reduce the read lock duration, let's try using per_vma_lock
> first. If that fails, we can take the read lock, similar to how page
> fault handlers operate.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  drivers/android/binder_alloc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index a2281dfacbbc..b40a5dd650c8 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -221,6 +221,8 @@ static int binder_install_single_page(struct
> binder_alloc *alloc,
>                                       struct binder_lru_page *lru_page,
>                                       unsigned long addr)
>  {
> +       struct vm_area_struct *vma;
> +       bool per_vma_lock = true;
>         struct page *page;
>         int ret = 0;
> 
> @@ -235,10 +237,15 @@ static int binder_install_single_page(struct
> binder_alloc *alloc,
>          */
>         page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> 
> -       mmap_read_lock(alloc->mm);
> +       vma = lock_vma_under_rcu(alloc->mm, addr);
> +       if (!vma) {
> +               per_vma_lock = false;
> +               mmap_read_lock(alloc->mm);
> +               vma = find_vma(alloc->mm, addr);
> +       }
> 
> -       /* vma might have been dropped or deattached */
> -       if (!alloc->vma || !find_vma(alloc->mm, addr)) {
> +       /* vma might have been dropped, deattached or changed to new one */
> +       if (!alloc->vma || !vma || vma != alloc->vma) {
>                 pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
>                 ret = -ESRCH;
>                 goto out;
> @@ -270,7 +277,10 @@ static int binder_install_single_page(struct
> binder_alloc *alloc,
>         binder_set_installed_page(lru_page, page);
>         spin_unlock(&alloc->lock);
>  out:
> -       mmap_read_unlock(alloc->mm);
> +       if (per_vma_lock)
> +               vma_end_read(vma);
> +       else
> +               mmap_read_unlock(alloc->mm);
>         mmput_async(alloc->mm);
>         if (ret && page)
>                 __free_page(page);
> -- 
> 2.39.3 (Apple Git-146)

This looks fairly similar to my patch. However, you would need to handle
the case were vm_insert_page() returns -EBUSY (success that raced) and
also sync with the shrinker callbacks in binder_alloc_free_page() which
is the biggest concern.

Let's not duplicate efforts though. Can we please wait for my patch?
I'll add you as Co-Developed-by, since you've posted this already?

Regards,
Carlos Llamas

