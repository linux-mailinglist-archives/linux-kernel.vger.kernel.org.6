Return-Path: <linux-kernel+bounces-400190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681E9C0A21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4032B216C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A38212D2E;
	Thu,  7 Nov 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hwqeBib"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF72942A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993499; cv=none; b=Jf5WThUX0b5V5MMA7Rx+P2+pykNpX+iWehdhA1zW+33x+RG9kHTYPckhQnGwzeGwP+kJrh9r8/53GslYEycZJR9DTtNs/UqKf/ZvtuVnriGFyPB/5yJvtpuu/rV7LwfoEEWG6wkegTgzZ8aQ3UX3GpNxmRUxXeiEY1RSV0Q3Zwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993499; c=relaxed/simple;
	bh=zz9hTFjd6/cn1Gfkr6FQM+vHuQwjS4WyN09wtji3Uno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwV1/hnt8hJDepQ8cLDWgLxzsNba9FS+rK2IaXG06KP69u2vKwNzdC7N4fss4As95o17a6iLBFlFeMqP9XBb0fHyPEdYzddREY02BQDyRSO9fznQkVVmM974oX5/95IOMpDQOZaYG9HQ1aju8X4wAqiuYOSQIE2IbzejehPCQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hwqeBib; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8ac50b79so140495ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730993497; x=1731598297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/lmL/u0IEpO/zt/opxgPK/xy9xRBpmmh/JTurGOam7Y=;
        b=1hwqeBib4bmNBl2yZgB1Vct48Qo8IIMGkZEMTAo3WeGtOgBPKGLjHt97z05qr4rKPd
         oCUHrTGoXBFAthkaZGC2SFN7Oava7qhk3aTZRhDuz2A9cKUw69o+eBdkjqHdsjkKKVKZ
         xwDME6Pqhn48oCVBahRkb12sB7AUgtIx5JgFQuyf1S46SgsCuiDBX0Id+9AK9JPfr5fU
         b8ejv7YX+oOHsA6U/bv5C1Ars9NpLmE//EAGo9xDq6jyzpTAydjbWjsHLZ5t811U7u4k
         w2d12gwzzioNQpzZCwUhizHbi47yZLhs6DJseZ2LoKFIPUCbN1NpH45h2g865vVKA7jz
         B6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730993497; x=1731598297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lmL/u0IEpO/zt/opxgPK/xy9xRBpmmh/JTurGOam7Y=;
        b=XysEiOXU3DLt7jTx31/8cgbX5Q9mZ6tqGVDxoZ65A86F79YbwgfIfrqMY+pUj/jArT
         w+vTXYeo1jvsA9TK+9lWZGfsjk2wrQr6qe5fcROSRGDzCT6dhPpCNvcfJpwcS7rApvJc
         mUgobjQ7Svrvya0LKvg4UXIHaILdgfVby63RGa3k15T2ZMzZoo0SQFz8mHpQ6M5sL3CA
         N4Z1qosM4gJl3K1FsIhKOn1YP/9x3Wjoz7F0ZdGr/H1E7QMC+Kuy6/qAdHu2TSuTYlCM
         TEUv8BwK9U0e2345xLGxm5o1wjpEl/M0ukIQ7HZcaFoiyjsPWH6FnN4KjfZfqDQC/9OD
         PfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUjcCqCxZ1JEcqucjeNac00icBvHbKzcSNSdUBMiMUxgHlll/iZGlHYNuupgjLvG1GJ29AzlFusnIrj6i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//edcJR0PrbN1fE92cINEzY8sVC6N7eL+Bbj3a+6I0pDVvEEX
	itEMMpUDo94TuVpO06s5G9DpB5JocPke0RSXMTtpxOGeHaVRWAnRrtgO8nfmfw==
X-Gm-Gg: ASbGnct4BHHEiMERo61xgx5HOI0eb0xepdBLo+nCyKucWctBLcS+77mcA2yiXLwj6sF
	hN+/GREJcpo5Op9Mh+FxDLwe85EHCE9FsZlbNyA+J2kHnQHF2VVQHJgF9DwEqAIUi/qS1xaahsy
	/Md0cuacafu+w53SXVnmJNh7ATFSs1zcPR/wrmpbm7FtUn5+RGk0LGG87kf5ET+5E3/xj92qKfs
	DLs+KwUI6KVsLV6cn1AwZ6a7DB3+Uy4z0Pw3FNN4VNK0YzYNYWdDp90R6ZQVrstbIeZBCW0zC/I
	94WcRmDj/FQyDyw=
X-Google-Smtp-Source: AGHT+IFZzE4Nm6/gS9MwKgxAYH9kKOheJiLcgMS5KLTBmexCLYtpnm2Om+ho6e17RlCO6PmicofEog==
X-Received: by 2002:a17:902:e891:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-211749a8c31mr3148785ad.22.1730993496720;
        Thu, 07 Nov 2024 07:31:36 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541d68sm3959418a91.20.2024.11.07.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:31:36 -0800 (PST)
Date: Thu, 7 Nov 2024 15:31:31 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	David Hildenbrand <david@redhat.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v2 2/8] binder: concurrent page installation
Message-ID: <ZyzdUyHr7S_cpsso@google.com>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-3-cmllamas@google.com>
 <CAJuCfpGAr=Tm=JJtnrJ0ipFo2yqYSEVAMtx5aUU-k1F6prjYjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGAr=Tm=JJtnrJ0ipFo2yqYSEVAMtx5aUU-k1F6prjYjQ@mail.gmail.com>

On Thu, Nov 07, 2024 at 07:10:28AM -0800, Suren Baghdasaryan wrote:
> On Wed, Nov 6, 2024 at 8:02 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Allow multiple callers to install pages simultaneously by downgrading
> > the mmap_sem to non-exclusive mode. Races to the same PTE are handled
> > using get_user_pages_remote() to retrieve the already installed page.
> > This method significantly reduces contention in the mmap semaphore.
> >
> > To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
> > operating on an isolated VMA. In addition, zap_page_range_single() is
> > called under the alloc->mutex to avoid racing with the shrinker.
> >
> > Many thanks to Barry Song who posted a similar approach [1].
> >
> > Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder_alloc.c | 64 +++++++++++++++++++++-------------
> >  1 file changed, 40 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index 7241bf4a3ff2..acdc05552603 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -221,26 +221,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
> >                                       struct binder_lru_page *lru_page,
> >                                       unsigned long addr)
> >  {
> > +       struct vm_area_struct *vma;
> >         struct page *page;
> > -       int ret = 0;
> > +       long npages;
> > +       int ret;
> >
> >         if (!mmget_not_zero(alloc->mm))
> >                 return -ESRCH;
> >
> > -       /*
> > -        * Protected with mmap_sem in write mode as multiple tasks
> > -        * might race to install the same page.
> > -        */
> > -       mmap_write_lock(alloc->mm);
> > -       if (binder_get_installed_page(lru_page))
> > -               goto out;
> > -
> > -       if (!alloc->vma) {
> > -               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> > -               ret = -ESRCH;
> > -               goto out;
> > -       }
> > -
> >         page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> >         if (!page) {
> >                 pr_err("%d: failed to allocate page\n", alloc->pid);
> > @@ -248,19 +236,47 @@ static int binder_install_single_page(struct binder_alloc *alloc,
> >                 goto out;
> >         }
> >
> > -       ret = vm_insert_page(alloc->vma, addr, page);
> > -       if (ret) {
> > -               pr_err("%d: %s failed to insert page at offset %lx with %d\n",
> > -                      alloc->pid, __func__, addr - alloc->buffer, ret);
> > +       mmap_read_lock(alloc->mm);
> > +       vma = vma_lookup(alloc->mm, addr);
> > +       if (!vma || vma != alloc->vma) {
> > +               mmap_read_unlock(alloc->mm);
> 
> nit: instead of unlocking here you could have another label before
> mmap_read_unlock() at the end and jump to it.

Sounds good, I'll do this.

> 
> >                 __free_page(page);
> > -               ret = -ENOMEM;
> > +               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> > +               ret = -ESRCH;
> >                 goto out;
> >         }
> >
> > -       /* Mark page installation complete and safe to use */
> > -       binder_set_installed_page(lru_page, page);
> > +       ret = vm_insert_page(vma, addr, page);
> > +       switch (ret) {
> > +       case -EBUSY:
> > +               /*
> > +                * EBUSY is ok. Someone installed the pte first but the
> > +                * lru_page->page_ptr has not been updated yet. Discard
> > +                * our page and look up the one already installed.
> > +                */
> > +               ret = 0;
> > +               __free_page(page);
> > +               npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
> > +               if (npages <= 0) {
> > +                       pr_err("%d: failed to find page at offset %lx\n",
> > +                              alloc->pid, addr - alloc->buffer);
> > +                       ret = -ESRCH;
> > +                       break;
> > +               }
> > +               fallthrough;
> > +       case 0:
> > +               /* Mark page installation complete and safe to use */
> > +               binder_set_installed_page(lru_page, page);
> > +               break;
> > +       default:
> > +               __free_page(page);
> > +               pr_err("%d: %s failed to insert page at offset %lx with %d\n",
> > +                      alloc->pid, __func__, addr - alloc->buffer, ret);
> > +               ret = -ENOMEM;
> 
> vm_insert_page() can return EINVAL (see
> validate_page_before_insert()). Instead of converting other codes into
> ENOMEM why not return "ret" as is?

This is purely historical, binder has always propagated -ENOMEM to
userspace on errors from vm_insert_page() and I'm not sure why.

FWIW, I've dropped the behavior in the last patch and now I just forward
whatever vm_insert_page() returns. I had a look at libbinder code and it
doesn't really make a difference.

Perhaps, I should be explicit about this move and do it in a separate
commit.

Thanks,
--
Carlos Llamas

