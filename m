Return-Path: <linux-kernel+bounces-448218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0529F3D15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3701882612
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A41D5CD3;
	Mon, 16 Dec 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyf127mV"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B51B87E0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386003; cv=none; b=p+9e1ytEGMI14JH07HAbGcJ2VH0ee6Bv7VnfnPOrsi4qY4PQBS0Vdsswa45drHKtbyrpd/xgiy3a+jERCwTepOk0P+r67Fw3n2py7xNCqJgtISHcwCpL+/bxNz7MdCMtoI8TH9DpNaWRN1TVGNcCRCDhQO+i/3lsZgtdhdGW9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386003; c=relaxed/simple;
	bh=18z/vEuRWQv75oHANkQs1Xwenl/SMT3UTPsaK1Usd+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMl5iUeidtj0OldmSKIC7DEhKbmIuaYfnPx0K7X76ij1rcVPfag0OAaMIuNGox3TX9QHEueWKExIwatlAnc8Mcw615OJYrqGPdnheRRrGXVAJnv4H1VDr0T6iI9rrFOX4zzWJ+gqUvtkZEAj0OtJmqcuReMqdqV7cI8153cRSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyf127mV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467abce2ef9so77221cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734385998; x=1734990798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq05gPIyw7EB2xqbSOReuVtBjU7kZl4ZHSk4xKdPdrg=;
        b=uyf127mV3Y2Ssm8q5eidxNtqFp5TgJnB3DURfQ67MsGlQfZUY+mkCZ+qNRAGwRk1Kg
         mV+zvN3RFazWVEEMP5NCshbczDmP7UpOKzn8KZpj2nWY0vuoPbudSPtvljuknL93xjfs
         scCeX6My/4P5absR9hWGGfv8sKyL8MpASK3UQQbze5NVIOkxeJmm8ZVsY32rOuKZ16/X
         +U34z1SLZ2HIrZU2+ZrhWor+oa/nzz4uXA4i/CVtFQcDBCt6iDVuDRxJhqhMmMskZAl4
         ssLpKtBw1+PbUDJ1hQEJadxOkjF5eIGr4I7c81kHC6j60mZ8/3nIIowvDUNQW/FjMRSn
         gk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385998; x=1734990798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq05gPIyw7EB2xqbSOReuVtBjU7kZl4ZHSk4xKdPdrg=;
        b=RwBE4lZwL/Fs9QNs32RGc9P/Walv75lxCgm68Q6l8cL9dplNPjgeXtc2bD7u+e2D2o
         D4nnLHkkKioHmd8IN/PIrRrcaQcHbXO8EdXkukPzp2KbQAsW+BVeZTZXPO+A5+MQEFNv
         ZcCXAXOdgdjiA4QqIviXv2puWU3Tgy1FdkbV7hZS7Y9Xh5RP18WYK5TYcZsr82kl8G5V
         F1FVUF8XhNxAcb6o3/G09yq+5vkERKHP2bWv5FVn9oXSMnmU36AMVsvt4mWfLrAVLtsj
         pR7p/T0ws/OqEcZ0DiRc/DPZNqzxMmrtQnRm/kfhY5r4d8WKrEx3DxClp7UJAlzesqm6
         BJFg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwQFN9o4Nh835VZbwkkII3BkcmG0vckteSRk0E5cmLdUXan1RwyLQFOHyEs+PRiCEqk9BejWa1xpzaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Wqe7elUeAdSCbYuDKZx6Qvozyqk/yp2dFmmTkYg1kD1JvQa7
	0yY2dywrz18sBE4SS45v5ILgzDX1tSJlmz/0cOpcwfAsSiE1N5ygR5HzrB394WjGQ8XvU5+ji1t
	6VcHRqxwmUG8pEQdsxN3aY6y3wJY8pFMHB9b8
X-Gm-Gg: ASbGncs2bEzF6y/ts8EqoexOfd+p632PTMAJZZXmkEYjyYJrJb7FZ7UU/DbBDheb27j
	NNRqRfxYXpSkI/oCicb7noMq1BLYCKgfGS17efg==
X-Google-Smtp-Source: AGHT+IHtfvEBTV4XwO44y08RCoG8lRTuslg34UX+xLARmWTUYFF2aI3xBP0gB1KtSzzFun+sUfSbEsihc7M1sONbcGY=
X-Received: by 2002:ac8:574d:0:b0:466:861a:f633 with SMTP id
 d75a77b69052e-468fb0b4c55mr151201cf.5.1734385998024; Mon, 16 Dec 2024
 13:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-11-surenb@google.com>
 <20241216211520.GB9803@noisy.programming.kicks-ass.net>
In-Reply-To: <20241216211520.GB9803@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Dec 2024 13:53:06 -0800
Message-ID: <CAJuCfpHAZ4gwh14wi8M3jt8HPwwV_P9W29qzOXwypgUk72VBgA@mail.gmail.com>
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

On Mon, Dec 16, 2024 at 1:15=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Dec 16, 2024 at 11:24:13AM -0800, Suren Baghdasaryan wrote:
>
> FWIW, I find the whole VMA_STATE_{A,DE}TATCHED thing awkward. And

I'm bad with naming things, so any better suggestions are welcome.
Are you suggesting to drop VMA_STATE_{A,DE}TATCHED nomenclature and
use 0/1 values directly?

> perhaps s/VMA_STATE_LOCKED/VMA_LOCK_OFFSET/ ?

Sounds good. I'll change it to VMA_LOCK_OFFSET.

>
> Also, perhaps:
>
> #define VMA_REF_LIMIT   (VMA_LOCK_OFFSET - 2)

Ack.

>
> > @@ -699,10 +700,27 @@ static inline void vma_numab_state_free(struct vm=
_area_struct *vma) {}
> >  #ifdef CONFIG_PER_VMA_LOCK
> >  static inline void vma_lock_init(struct vm_area_struct *vma)
> >  {
> > -     init_rwsem(&vma->vm_lock.lock);
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +     static struct lock_class_key lockdep_key;
> > +
> > +     lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0=
);
> > +#endif
> > +     refcount_set(&vma->vm_refcnt, VMA_STATE_DETACHED);
> >       vma->vm_lock_seq =3D UINT_MAX;
>
> Depending on how you do the actual allocation (GFP_ZERO) you might want
> to avoid that vm_refcount store entirely.

I think we could initialize it to 0 in the slab cache constructor and
when vma is freed we already ensure it's 0. So, even when reused it
will be in the correct 0 state.

>
> Perhaps instead write: VM_WARN_ON(refcount_read(&vma->vm_refcnt));

Yes, with the above approach that should work.

>
> > @@ -813,25 +849,42 @@ static inline void vma_assert_write_locked(struct=
 vm_area_struct *vma)
> >
> >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> >  {
> > -     if (!rwsem_is_locked(&vma->vm_lock.lock))
> > +     if (refcount_read(&vma->vm_refcnt) <=3D VMA_STATE_ATTACHED)
>         if (is_vma_detached(vma))
>
> >               vma_assert_write_locked(vma);
> >  }
> >
> > -static inline void vma_mark_attached(struct vm_area_struct *vma)
> > +/*
> > + * WARNING: to avoid racing with vma_mark_attached(), should be called=
 either
> > + * under mmap_write_lock or when the object has been isolated under
> > + * mmap_write_lock, ensuring no competing writers.
> > + */
> > +static inline bool is_vma_detached(struct vm_area_struct *vma)
> >  {
> > -     vma->detached =3D false;
> > +     return refcount_read(&vma->vm_refcnt) =3D=3D VMA_STATE_DETACHED;
>         return !refcount_read(&vma->vm_refcnt);
> >  }
> >
> > -static inline void vma_mark_detached(struct vm_area_struct *vma)
> > +static inline void vma_mark_attached(struct vm_area_struct *vma)
> >  {
> > -     /* When detaching vma should be write-locked */
> >       vma_assert_write_locked(vma);
> > -     vma->detached =3D true;
> > +
> > +     if (is_vma_detached(vma))
> > +             refcount_set(&vma->vm_refcnt, VMA_STATE_ATTACHED);
>
> Urgh, so it would be really good to not call this at all them not 0.
> I've not tried to untangle the mess, but this is really awkward. Surely
> you don't add it to the mas multiple times either.

The issue is that when we merge/split/shrink/grow vmas, we skip on
marking them detached while modifying them. Therefore from
vma_mark_attached() POV it will look like we are attaching an already
attached vma. I can try to clean that up if this is really a concern.

>
> Also:
>
>         refcount_set(&vma->vm_refcnt, 1);
>
> is so much clearer.

Ok, IIUC you are in favour of dropping VMA_STATE_ATTACHED/VMA_STATE_DETACHE=
D.

>
> That is, should this not live in vma_iter_store*(), right before
> mas_store_gfp() ?

Currently it's done right *after* mas_store_gfp() but I was debating
with myself if it indeed should be *before* insertion into the tree...

>
> Also, ISTR having to set vm_lock_seq right before it?

Yes, vma_mark_attached() requires vma to be write-locked beforehand,
hence the above vma_assert_write_locked(). But oftentimes it's locked
not right before vma_mark_attached() because some other modification
functions also require vma to be write-locked.

>
> >  }
> >
> > -static inline bool is_vma_detached(struct vm_area_struct *vma)
> > +static inline void vma_mark_detached(struct vm_area_struct *vma)
> >  {
> > -     return vma->detached;
> > +     vma_assert_write_locked(vma);
> > +
> > +     if (is_vma_detached(vma))
> > +             return;
>
> Again, this just reads like confusion :/ Surely you don't have the same
> with mas_detach?

I'll double-check if we ever double-mark vma as detached.

Thanks for the review!

>
> > +
> > +     /* We are the only writer, so no need to use vma_refcount_put(). =
*/
> > +     if (!refcount_dec_and_test(&vma->vm_refcnt)) {
> > +             /*
> > +              * Reader must have temporarily raised vm_refcnt but it w=
ill
> > +              * drop it without using the vma since vma is write-locke=
d.
> > +              */
> > +     }
> >  }

