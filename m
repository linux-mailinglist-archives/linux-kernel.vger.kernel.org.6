Return-Path: <linux-kernel+bounces-448211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2499F3CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AC616B965
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E41D63F7;
	Mon, 16 Dec 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KH/h+aLX"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CC1D61BC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385499; cv=none; b=ppoM3vN5jHKBFQ0rv6Qku8j19r019NBoIwHwIE3MBgueB5mwE2LRRhx/rZEzypjJgJ5K4TsCQpnQBAEQxgxlZJ8W9DSd9w5fkJ6o/ATgVZNjCaYm737hWaTtS6Aux+UC/DfghJ9Q0BBlUtTwuoY69Dj2DsxC2G8d4ATHcdSO8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385499; c=relaxed/simple;
	bh=JmGwLUs6UDHze2TMl1AzsDLGz9MSdoqdIKapmGtJOrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qejxec9aw03KOTgcEh/waM7sRxiWkpA2QCasdzU+54LKGdY/7w/F1Wr7nWsr49L3taVORCFI/4dZ/SHYSeB0MgsNRdA1mYpEsRkEAkwesKK0nE1TAGjueWxP5+JFZtA6yQul7d/1qu0bBsHUVFS+yrpqQEUJ3WXnwkYBt+j6v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KH/h+aLX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679b5c66d0so18831cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734385497; x=1734990297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuJwz+yRVvIlEgf04EbTYieZU4XF4v2uk6gzXtst0Jc=;
        b=KH/h+aLXgPJ7xYRMZn5jINd3uePVZ1JLT7oVBihSRTkvIRfMzDSCbfFtDaHwzUr2RB
         bYFIYtyehMOBx2Gf4/P2LECKjjrhglshXh3xtWLMJCXYjtrspl2RO4ReDr38xzhRAwXT
         5qXKtfLNKsHHZ27WkHNyRsYx8d2utlr2jqHxWSDenGaLKTaDx1L1/uZ1el3gKKqXoTyN
         8aA1jiKA3d4o5yfe8+WjvOAkAP9dXPT8wUY+0CQdI0T2prGtX70FXMUQMMCYukch/MzI
         EJKbABZcUIU5nAhcYxFPPUM54tscUCK9lQml0pCJPOfiqVGZgj1b6p0rcZvrDOH1Ahhx
         nVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385497; x=1734990297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuJwz+yRVvIlEgf04EbTYieZU4XF4v2uk6gzXtst0Jc=;
        b=EhEwpV20RSBEvYGBjTzbDtZekMyQEl3SxKUOYrgeCpwUwIhedJvhZp/BzZEMBooadd
         cXcDQ84VoqBvlbocFugCb6dDvM6PLr8sTP2pLM44iOF/B9iCI12YL02viy1+EKchD+1w
         3pfylLI7w/SVU1xHFt43pW9s+YjvBYekNZRfs0FKFl+wL8/ySdM3MYdt5n3ctlA8wXAu
         AOeHyE6eyNq7gKvetwaoOZfU3AkOxZYdnE0CiHUXptetq8hdYAmoDEHd61S7yv06mXE6
         tWEUVMkzlDkG+BcM434aTn2TZSSvczTwq4aOYyIamy2gwLRyTZF0zcmND3mr6/iHOnxI
         ueXA==
X-Forwarded-Encrypted: i=1; AJvYcCXr+q2Nnbw+0dmCSJvA3VIP6ZoWI14Yw4B2r3XFnMjs4ROinl9qNSz/TZR2rU0gMUkc0q8rnBOSEazr+sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Upitky5hYEbR/1auHFwlAhicqQ4Is/wIlSJCfyn4NLjXVAs5
	9oXO3jKa9Zs0VyYsKL/cPecAA2Se5oeb2slCWpCbiguBVIobBfsHK0H+2Sww0EAxXb+B1JoY6aR
	417usYYVbR6rruOHCCyqO0K7RO/YqpuIEozgl
X-Gm-Gg: ASbGncvPegxhp/9x2RI9xN6UWAHyYguuxOn/Qxi692UxpG4a3KxpglkYR8JeMp7ra9o
	gs32gOmI3QunOS7BIK0n+laDZdnEWEt596k60ag==
X-Google-Smtp-Source: AGHT+IHSCAO9iQHEYLNXIJAxK4wdh8jBKfn7bro1hAD4EjBpHJqaMGL174tkiD5onRcXrrU1sVKTBcw8Q4f33gkb36w=
X-Received: by 2002:ac8:5d93:0:b0:465:18f3:79c8 with SMTP id
 d75a77b69052e-468fb10f5f3mr134651cf.13.1734385496878; Mon, 16 Dec 2024
 13:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-11-surenb@google.com>
 <20241216213753.GD9803@noisy.programming.kicks-ass.net>
In-Reply-To: <20241216213753.GD9803@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Dec 2024 13:44:45 -0800
Message-ID: <CAJuCfpEu_rZkC+ktWXE=rA-VenFBZR9VQ-SnVkDbXUqsd3Ys_A@mail.gmail.com>
Subject: Re: [PATCH v6 10/16] mm: replace vm_lock and detached flag with a
 reference count
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:38=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Dec 16, 2024 at 11:24:13AM -0800, Suren Baghdasaryan wrote:
> > +static inline void vma_refcount_put(struct vm_area_struct *vma)
> > +{
> > +     int refcnt;
> > +
> > +     if (!__refcount_dec_and_test(&vma->vm_refcnt, &refcnt)) {
> > +             rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > +
> > +             if (refcnt & VMA_STATE_LOCKED)
> > +                     rcuwait_wake_up(&vma->vm_mm->vma_writer_wait);
> > +     }
> > +}
> > +
> >  /*
> >   * Try to read-lock a vma. The function is allowed to occasionally yie=
ld false
> >   * locked result to avoid performance overhead, in which case we fall =
back to
> > @@ -710,6 +728,8 @@ static inline void vma_lock_init(struct vm_area_str=
uct *vma)
> >   */
> >  static inline bool vma_start_read(struct vm_area_struct *vma)
> >  {
> > +     int oldcnt;
> > +
> >       /*
> >        * Check before locking. A race might cause false locked result.
> >        * We can use READ_ONCE() for the mm_lock_seq here, and don't nee=
d
> > @@ -720,13 +740,20 @@ static inline bool vma_start_read(struct vm_area_=
struct *vma)
> >       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq.sequence))
> >               return false;
> >
> > +
> > +     rwsem_acquire_read(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > +     /* Limit at VMA_STATE_LOCKED - 2 to leave one count for a writer =
*/
> > +     if (unlikely(!__refcount_inc_not_zero_limited(&vma->vm_refcnt, &o=
ldcnt,
> > +                                                   VMA_STATE_LOCKED - =
2))) {
> > +             rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> >               return false;
> > +     }
> > +     lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> >
> >       /*
> > +      * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
> >        * False unlocked result is impossible because we modify and chec=
k
> > +      * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lo=
ck_seq
> >        * modification invalidates all existing locks.
> >        *
> >        * We must use ACQUIRE semantics for the mm_lock_seq so that if w=
e are
> > @@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_area_=
struct *vma)
> >        * after it has been unlocked.
> >        * This pairs with RELEASE semantics in vma_end_write_all().
> >        */
> > +     if (oldcnt & VMA_STATE_LOCKED ||
> > +         unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->vm_m=
m->mm_lock_seq))) {
> > +             vma_refcount_put(vma);
>
> Suppose we have detach race with a concurrent RCU lookup like:
>
>                                         vma =3D mas_lookup();
>
>         vma_start_write();
>         mas_detach();
>                                         vma_start_read()
>                                         rwsem_acquire_read()
>                                         inc // success
>         vma_mark_detach();
>         dec_and_test // assumes 1->0
>                      // is actually 2->1
>
>                                         if (vm_lock_seq =3D=3D vma->vm_mm=
_mm_lock_seq) // true
>                                           vma_refcount_put
>                                             dec_and_test() // 1->0
>                                               *NO* rwsem_release()
>

Yes, this is possible. I think that's not a problem until we start
reusing the vmas and I deal with this race later in this patchset.
I think what you described here is the same race I mention in the
description of this patch:
https://lore.kernel.org/all/20241216192419.2970941-14-surenb@google.com/
I introduce vma_ensure_detached() in that patch to handle this case
and ensure that vmas are detached before they are returned into the
slab cache for reuse. Does that make sense?


>
>
> >               return false;
> >       }
> > +
> >       return true;
> >  }

