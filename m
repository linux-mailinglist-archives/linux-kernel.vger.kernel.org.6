Return-Path: <linux-kernel+bounces-205404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07918FFB12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543D2288AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03650364BE;
	Fri,  7 Jun 2024 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkYfHhWf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0E18E1F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736197; cv=none; b=iTfjZ87ejaViGFg+maGNt+X4ENjssG9nF5Nc4SEGo0ZIKsBBMv0C6okmYqQeSOfnxS2e+66w6OYLiwdTrK4zLe8vbjjCnPdpZFHZa48wt9GJytEH5s5KlT1kTCXkdX7ckFu7MCBYM6VyGsFmD7hyP7ExrGOILbzKyg3tm6Cr1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736197; c=relaxed/simple;
	bh=smWCGS/Y3Hc8I4Yi+x0l0NQjxwNHCdJCtYwMVZ64a8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9Uum05aTFcrJnYxEvMSHlQV8mHwBF0CITv5dPITUYh4YgcuQe98BsTV2XHcOocwicO93i0G94XC5OywruQB8qDUNDxMaPah50DWg1yswmsdO7eEpjKsJpzqGtETS4Dr4ycLTY2LvOZxZcbBl+4GNz/ERnbXuIsn3yeUuiCzdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkYfHhWf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a696cde86a4so185347866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 21:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717736194; x=1718340994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22jJUg56o3o2LRfw08GcS6cO34XlfeFsCoCXxwR36XQ=;
        b=FkYfHhWfNXAr1rIwluFUw9o/Fxd1WTqw8AUvVbERer1iHHBx6UheaQ69pn/1/5gQ0b
         bCkwxe2wP9YVALLrsm/T0+zQYb3kRdoShNBjIcGG3CSsVfDuwgL/xkuLsRfVqNlPnXV9
         2XXsb4A6wSYJxG9RqGgi4mQIWMQA3O57ve8mwU8XEvNSqV9sksn9sy7CXA6tYooq+0uB
         op7W9dJqZQitZIzXBTRXGj2Fta5RAa9fNCo+ExW3zqh+gM/HTC30uUumnV9lNBS0wept
         wwHNAN2ZM6YN9dwusnguwpv8Bp5lctAoTIFCzLH6GTaQIjGd4qeIuztOdzQLfJ2G4Aig
         s5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717736194; x=1718340994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22jJUg56o3o2LRfw08GcS6cO34XlfeFsCoCXxwR36XQ=;
        b=MFydHRUCFRN+gPMcYncWxk64Rso+wZ3pt8yGWWdNXBbU3pS5qfcC6k7LZRehs6zCXL
         nrJtSULbOnSbM1WRpsk0zkto7IQTJG+NcCjcgBluBwTWOiZ+/6FIXAABvGMddF2uFcKT
         7II6j7JRG8UGZZicwdN5dPay7Ny7hFT2d3sqatu38DmuOFfaIzWbg+s/bj9g5brACgSq
         405nA8Gx+j7fNVP3deeYqoj5AAwFVFWE16wceldWyfouF6eviFwmyqG9SStqXsRvGk3Q
         N9ZyJVLUDf/mlZAA8xu0KD4xTavvMstRx+jBBXb7RbyzF9Blc3uHHS7SbBqzZ2cp9+1r
         P/bg==
X-Forwarded-Encrypted: i=1; AJvYcCUa2NeL+7gpxwVHTlrwIoldwPOkzhQxvVd38pFyfzE4JpktvgpMRL9FOpnHlHaJRI8BFsKW7eVS8OMSuZH3lytXXJZwMrW9WnqNDcpN
X-Gm-Message-State: AOJu0YzrF7yqy6oyzNHhwFlrN6zLZJqZukRB9d3qTo7q38QlpySQYIYW
	NbKTHGmvcuHDKO9QilEUvwCe0UlIR7cHtj8xgUgJJFJGW0isyPCRve59CKuIBpdCWX531ujxz/y
	onHNRR+tQ4DKMocdq+OmsEmMKzRZrLq7OZk8QzkDYj9Ykdtgo/9VM
X-Google-Smtp-Source: AGHT+IGv2nlZeHssEN9DHKwmokSQQGRw0Hv+ylewt2D2lkdahoDhm3urF9JZ4ZWjk4uZ0m/tXnH9Nw+rdMO6kvitdO0=
X-Received: by 2002:a17:906:6953:b0:a6c:73a0:7dc3 with SMTP id
 a640c23a62f3a-a6cd5612064mr93148766b.9.1717736194065; Thu, 06 Jun 2024
 21:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606210840.1650341-1-yosryahmed@google.com> <871q598qy0.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q598qy0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 21:55:55 -0700
Message-ID: <CAJD7tkbCHkQ1dO0ps5rTLo2pRMmjriWvMT+nBtOA3hfdD6O43w@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: remove 'synchronous' argument to swap_read_folio()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:48=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > swap_read_folio() reads the folio synchronously if synchronous is passe=
d
> > as true or if SWP_SYNCHRONOUS_IO is set in swap_info_struct. The only
> > caller that passes synchronous=3Dtrue is in do_swap_page() in the
> > SWP_SYNCHRONOUS_IO case.
> >
> > Hence, the argument is redundant, it is only set to true when the swap
> > read would have been synchronous anyway. Remove it.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> LGTM, Thanks!
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks!

>
> And, there's some history information in commit b243dcbf2f13 ("swap:
> remove remnants of polling from read_swap_cache_async").
>
> "
>     Commit [1] introduced IO polling support duding swapin to reduce swap=
 read
>     latency for block devices that can be polled.  However later commit [=
2]
>     removed polling support.  Therefore it seems safe to remove do_poll
>     parameter in read_swap_cache_async and always call swap_readpage with
>     synchronous=3Dfalse waiting for IO completion in folio_lock_or_retry.
>
>     [1] commit 23955622ff8d ("swap: add block io poll in swapin path")
>     [2] commit 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")
> "
>
> IMO, it will help people to understand the code change to add some
> history information as above, or refer to the commit.

I sent a v2 with some history in the commit log.

>
> --
> Best Regards,
> Huang, Ying
>
> > ---
> >  mm/memory.c     |  2 +-
> >  mm/page_io.c    |  6 +++---
> >  mm/swap.h       |  6 ++----
> >  mm/swap_state.c | 10 +++++-----
> >  4 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index db91304882312..2b3ef08e8bb7d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4113,7 +4113,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >
> >                               /* To provide entry to swap_read_folio() =
*/
> >                               folio->swap =3D entry;
> > -                             swap_read_folio(folio, true, NULL);
> > +                             swap_read_folio(folio, NULL);
> >                               folio->private =3D NULL;
> >                       }
> >               } else {
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 41e8d738c6d28..f1a9cfab6e748 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -493,10 +493,10 @@ static void swap_read_folio_bdev_async(struct fol=
io *folio,
> >       submit_bio(bio);
> >  }
> >
> > -void swap_read_folio(struct folio *folio, bool synchronous,
> > -             struct swap_iocb **plug)
> > +void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
> >  {
> >       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > +     bool synchronous =3D sis->flags & SWP_SYNCHRONOUS_IO;
> >       bool workingset =3D folio_test_workingset(folio);
> >       unsigned long pflags;
> >       bool in_thrashing;
> > @@ -521,7 +521,7 @@ void swap_read_folio(struct folio *folio, bool sync=
hronous,
> >               folio_unlock(folio);
> >       } else if (data_race(sis->flags & SWP_FS_OPS)) {
> >               swap_read_folio_fs(folio, plug);
> > -     } else if (synchronous || (sis->flags & SWP_SYNCHRONOUS_IO)) {
> > +     } else if (synchronous) {
> >               swap_read_folio_bdev_sync(folio, sis);
> >       } else {
> >               swap_read_folio_bdev_async(folio, sis);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 2c0e96272d498..baa1fa946b347 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -11,8 +11,7 @@ struct mempolicy;
> >  /* linux/mm/page_io.c */
> >  int sio_pool_init(void);
> >  struct swap_iocb;
> > -void swap_read_folio(struct folio *folio, bool do_poll,
> > -             struct swap_iocb **plug);
> > +void swap_read_folio(struct folio *folio, struct swap_iocb **plug);
> >  void __swap_read_unplug(struct swap_iocb *plug);
> >  static inline void swap_read_unplug(struct swap_iocb *plug)
> >  {
> > @@ -83,8 +82,7 @@ static inline unsigned int folio_swap_flags(struct fo=
lio *folio)
> >  }
> >  #else /* CONFIG_SWAP */
> >  struct swap_iocb;
> > -static inline void swap_read_folio(struct folio *folio, bool do_poll,
> > -             struct swap_iocb **plug)
> > +static inline void swap_read_folio(struct folio *folio, struct swap_io=
cb **plug)
> >  {
> >  }
> >  static inline void swap_write_unplug(struct swap_iocb *sio)
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 0803eedeabe3d..994723cef8217 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -567,7 +567,7 @@ struct folio *read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
> >       mpol_cond_put(mpol);
> >
> >       if (page_allocated)
> > -             swap_read_folio(folio, false, plug);
> > +             swap_read_folio(folio, plug);
> >       return folio;
> >  }
> >
> > @@ -684,7 +684,7 @@ struct folio *swap_cluster_readahead(swp_entry_t en=
try, gfp_t gfp_mask,
> >               if (!folio)
> >                       continue;
> >               if (page_allocated) {
> > -                     swap_read_folio(folio, false, &splug);
> > +                     swap_read_folio(folio, &splug);
> >                       if (offset !=3D entry_offset) {
> >                               folio_set_readahead(folio);
> >                               count_vm_event(SWAP_RA);
> > @@ -701,7 +701,7 @@ struct folio *swap_cluster_readahead(swp_entry_t en=
try, gfp_t gfp_mask,
> >                                       &page_allocated, false);
> >       if (unlikely(page_allocated)) {
> >               zswap_folio_swapin(folio);
> > -             swap_read_folio(folio, false, NULL);
> > +             swap_read_folio(folio, NULL);
> >       }
> >       return folio;
> >  }
> > @@ -834,7 +834,7 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
> >               if (!folio)
> >                       continue;
> >               if (page_allocated) {
> > -                     swap_read_folio(folio, false, &splug);
> > +                     swap_read_folio(folio, &splug);
> >                       if (addr !=3D vmf->address) {
> >                               folio_set_readahead(folio);
> >                               count_vm_event(SWAP_RA);
> > @@ -853,7 +853,7 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
> >                                       &page_allocated, false);
> >       if (unlikely(page_allocated)) {
> >               zswap_folio_swapin(folio);
> > -             swap_read_folio(folio, false, NULL);
> > +             swap_read_folio(folio, NULL);
> >       }
> >       return folio;
> >  }

