Return-Path: <linux-kernel+bounces-280139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55ED94C63D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0D281B91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1515A864;
	Thu,  8 Aug 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMJxgd+q"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1A1D554
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151984; cv=none; b=I5f1Zs28spjEA0r5/CLAtRoBf6lQVVKa6KchBaSKdLuga2YdQc5UWcngPygwoZQMTAqLIcftmCuzCVJC031YHWpPcDATA7vPjPRC77rpAEM8vMHQZyp3aRzlyyX82h6De2LWMFvg4OItC8m0yGZTEnl+aXO6CtolocOp8ar4G2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151984; c=relaxed/simple;
	bh=hr4bYm4HjrP/3hzoEVHit7a+Trpa6Li1We9FZF3IEyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEGfIMFraJMYyNiO7NQKME8+2bsngZwxCN/bHZp8Obh2jSXgn04OHM9QeRKyrwofazn3vWOvGTw7HqFNT6bg/lKhVFOXIGmUnx2HQl0tT5MqaDDCxPluDLhIlGj4BSowkcpddLSy3qNhS/Co4q2+vAIqtGVWJSwANC4mZNRJles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMJxgd+q; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690404fd27eso13438537b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723151982; x=1723756782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpltPMV1dV0xpt4bs09W+0HY8kECmjByBy+/ViP+3NQ=;
        b=KMJxgd+qyDTK4jAMO68I4uedWt3GLIiz3KMSisTjV91UvxK9kh+xnduCMfGO33/WjG
         Y8En8ZplMqXqe3CltH4eNm4E8vA0iVT6BQ4tZMHb1IK+YAXojr5civO5eZ67LRxjF34X
         NU9Ls2PEok9GfVIbPRBFMTWjlFgApabsFoVcXoa/85TWWXrDnToU7KzWcb8uRXIFmUfU
         qSUjKYv0YYhvkK/F8IWuUEa7IZFPIhVVjPtSpqCIfLeehXHnFSVGUWtc6NB5n8R/99vL
         MGlXzvvWC2yx3UyIgqtdkpF4aRQ8ZnY1nIG8tm7mIVewkuzsAPHULKp+zXJ5ogmgSXOj
         PBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151982; x=1723756782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpltPMV1dV0xpt4bs09W+0HY8kECmjByBy+/ViP+3NQ=;
        b=uPOFerB37i8QSABrclcrZXm7/9WTfftUJJeJwn9O1/DMqG3rBNAASXFDCgCqGSKjMz
         r+H2RZyEOWWaALmxEppxJc5SG7H92lYniaCrZbWkNbAYVu3SB2TTfalKP76Yb942uywb
         51Huzut1A2IGwgJY+/c3DhXRgsip818zBekIpKm2VDcmYCMk6IgI8+PQpeX+dSLGLGDq
         tKcwRl+gYWVcl36mRZX6vjQ7EYrX9qA9Hji8J9rzdenanKtzXjPVrOstkKytzlZQMZpb
         1coG2rTtnAJMWhkRbhGJwZrzyi42DvotpvdaRZqCPFsPGI3wUq7UbolkjqQyZneNLDXH
         HW6Q==
X-Gm-Message-State: AOJu0YwwA/s78Doy5SXD4KhN3oG903KF2u/iqutfymShoDEUkN7Aerlu
	FiBWKpWUHHJhRLBdUWhnSMpiW/mdpW0/9gvolAdrz7n/tVXZlhU4V9T+cKk57EBKpyLw+7AFFYr
	dnVAU3JR7kENk+KFOMR0wgSrV7RDJjIUrHFA3
X-Google-Smtp-Source: AGHT+IF03qtBAxkRakR8h/7HFDMvp5qxxPussBYGU5H0UVRQB/ezK/UAPBb2AsnF6c5rCMxYRK929f2Lkpf5ctiOYxU=
X-Received: by 2002:a05:690c:2844:b0:673:1ac6:4be0 with SMTP id
 00721157ae682-69bfbbbdc1amr30033237b3.44.1723151981347; Thu, 08 Aug 2024
 14:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
In-Reply-To: <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 8 Aug 2024 14:19:30 -0700
Message-ID: <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lstoakes@gmail.com, pedro.falcato@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:04=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Thu, Aug 8, 2024 at 9:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Thu, Aug 8, 2024 at 7:00=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> > >
> > > ACHTUNG: this is more of a request for benchmarking than a patch
> > > proposal at this stage
> > >
> > > I was pointed at your patch which moved the vma lock to a separate
> > > allocation [1]. The commit message does not say anything about making
> > > sure the object itself is allocated with proper alignment and I found
> > > that the cache creation lacks the HWCACHE_ALIGN flag, which may or ma=
y
> > > not be the problem.
> > >
> > > I verified with a simple one-liner than on a stock kernel the vmas ke=
ep
> > > roaming around with a 16-byte alignment:
> > > # bpftrace -e 'kretprobe:vm_area_alloc  { @[retval & 0x3f] =3D count(=
); }'
> > > @[16]: 39
> > > @[0]: 46
> > > @[32]: 53
> > > @[48]: 56
> > >
> > > Note the stock vma lock cache also lacks the alignment flag. While I
> > > have not verified experimentally, if they are also romaing it would m=
ean
> > > that 2 unrelated vmas can false-share locks. If the patch below is a
> > > bust, the flag should probably be added to that one.
> > >
> > > The patch has slapped-around vma lock cache removal + HWALLOC for the
> > > vma cache. I left a pointer to not change relative offsets between
> > > current fields. I does compile without CONFIG_PER_VMA_LOCK.
> > >
> > > Vlastimil says you tested a case where the struct got bloated to 256
> > > bytes, but the lock remained separate. It is unclear to me if this
> > > happened with allocations made with the HWCACHE_ALIGN flag though.
> > >
> > > There is 0 urgency on my end, but it would be nice if you could try
> > > this out with your test rig.
> >
> > Hi Mateusz,
> > Sure, I'll give it a spin but I'm not optimistic. Your code looks
> > almost identical to my latest attempt where I tried placing vm_lock
> > into different cachelines including a separate one and using
> > HWCACHE_ALIGN. And yet all my attempts showed regression.
> > Just FYI, the test I'm using is the pft-threads test from mmtests
> > suite. I'll post results today evening.
> > Thanks,
> > Suren.
>
> Ok, well maybe you did not leave the pointer in place? :)

True, maybe that will make a difference. I'll let you know soon.

>
> It is plausible the problem is on vs off cpu behavior of rwsems --
> there is a corner case where they neglect to spin. It is plausible
> perf goes down simply because there is less on cpu time.
>
> Thus you bench can you make sure to time(1)?

Sure, will do once I'm home. Thanks for the hints!

>
> For example with zsh I got:
> ./run-mmtests.sh --no-monitor --config configs/config-workload-pft-thread=
s
>
> 39.35s user 445.45s system 390% cpu 124.04s (2:04.04) total
>
> I verified with offcputime-bpfcc -K that indeed there is a bunch of
> pft going off cpu from down_read/down_write even at the modest scale
> this was running in my case.
>
> >
> > >
> > > 1: https://lore.kernel.org/all/20230227173632.3292573-34-surenb@googl=
e.com/T/#u
> > >
> > > ---
> > >  include/linux/mm.h       | 18 +++++++--------
> > >  include/linux/mm_types.h | 10 ++++-----
> > >  kernel/fork.c            | 47 ++++----------------------------------=
--
> > >  mm/userfaultfd.c         |  6 ++---
> > >  4 files changed, 19 insertions(+), 62 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 43b40334e9b2..6d8b668d3deb 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -687,7 +687,7 @@ static inline bool vma_start_read(struct vm_area_=
struct *vma)
> > >         if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->=
mm_lock_seq))
> > >                 return false;
> > >
> > > -       if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0)=
)
> > > +       if (unlikely(down_read_trylock(&vma->vm_lock) =3D=3D 0))
> > >                 return false;
> > >
> > >         /*
> > > @@ -702,7 +702,7 @@ static inline bool vma_start_read(struct vm_area_=
struct *vma)
> > >          * This pairs with RELEASE semantics in vma_end_write_all().
> > >          */
> > >         if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vma->v=
m_mm->mm_lock_seq))) {
> > > -               up_read(&vma->vm_lock->lock);
> > > +               up_read(&vma->vm_lock);
> > >                 return false;
> > >         }
> > >         return true;
> > > @@ -711,7 +711,7 @@ static inline bool vma_start_read(struct vm_area_=
struct *vma)
> > >  static inline void vma_end_read(struct vm_area_struct *vma)
> > >  {
> > >         rcu_read_lock(); /* keeps vma alive till the end of up_read *=
/
> > > -       up_read(&vma->vm_lock->lock);
> > > +       up_read(&vma->vm_lock);
> > >         rcu_read_unlock();
> > >  }
> > >
> > > @@ -740,7 +740,7 @@ static inline void vma_start_write(struct vm_area=
_struct *vma)
> > >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> > >                 return;
> > >
> > > -       down_write(&vma->vm_lock->lock);
> > > +       down_write(&vma->vm_lock);
> > >         /*
> > >          * We should use WRITE_ONCE() here because we can have concur=
rent reads
> > >          * from the early lockless pessimistic check in vma_start_rea=
d().
> > > @@ -748,7 +748,7 @@ static inline void vma_start_write(struct vm_area=
_struct *vma)
> > >          * we should use WRITE_ONCE() for cleanliness and to keep KCS=
AN happy.
> > >          */
> > >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > > -       up_write(&vma->vm_lock->lock);
> > > +       up_write(&vma->vm_lock);
> > >  }
> > >
> > >  static inline void vma_assert_write_locked(struct vm_area_struct *vm=
a)
> > > @@ -760,7 +760,7 @@ static inline void vma_assert_write_locked(struct=
 vm_area_struct *vma)
> > >
> > >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> > >  {
> > > -       if (!rwsem_is_locked(&vma->vm_lock->lock))
> > > +       if (!rwsem_is_locked(&vma->vm_lock))
> > >                 vma_assert_write_locked(vma);
> > >  }
> > >
> > > @@ -827,10 +827,6 @@ static inline void assert_fault_locked(struct vm=
_fault *vmf)
> > >
> > >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > >
> > > -/*
> > > - * WARNING: vma_init does not initialize vma->vm_lock.
> > > - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> > > - */
> > >  static inline void vma_init(struct vm_area_struct *vma, struct mm_st=
ruct *mm)
> > >  {
> > >         memset(vma, 0, sizeof(*vma));
> > > @@ -839,6 +835,8 @@ static inline void vma_init(struct vm_area_struct=
 *vma, struct mm_struct *mm)
> > >         INIT_LIST_HEAD(&vma->anon_vma_chain);
> > >         vma_mark_detached(vma, false);
> > >         vma_numab_state_init(vma);
> > > +       init_rwsem(&vma->vm_lock);
> > > +       vma->vm_lock_seq =3D -1;
> > >  }
> > >
> > >  /* Use when VMA is not part of the VMA tree and needs no locking */
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 003619fab20e..caffdb4eeb94 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -615,10 +615,6 @@ static inline struct anon_vma_name *anon_vma_nam=
e_alloc(const char *name)
> > >  }
> > >  #endif
> > >
> > > -struct vma_lock {
> > > -       struct rw_semaphore lock;
> > > -};
> > > -
> > >  struct vma_numab_state {
> > >         /*
> > >          * Initialised as time in 'jiffies' after which VMA
> > > @@ -716,8 +712,7 @@ struct vm_area_struct {
> > >          * slowpath.
> > >          */
> > >         int vm_lock_seq;
> > > -       /* Unstable RCU readers are allowed to read this. */
> > > -       struct vma_lock *vm_lock;
> > > +       void *vm_dummy;
> > >  #endif
> > >
> > >         /*
> > > @@ -770,6 +765,9 @@ struct vm_area_struct {
> > >         struct vma_numab_state *numab_state;    /* NUMA Balancing sta=
te */
> > >  #endif
> > >         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +       struct rw_semaphore vm_lock ____cacheline_aligned_in_smp;
> > > +#endif
> > >  } __randomize_layout;
> > >
> > >  #ifdef CONFIG_NUMA
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 92bfe56c9fed..eab04a24d5f1 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
> > >  /* SLAB cache for mm_struct structures (tsk->mm) */
> > >  static struct kmem_cache *mm_cachep;
> > >
> > > -#ifdef CONFIG_PER_VMA_LOCK
> > > -
> > > -/* SLAB cache for vm_area_struct.lock */
> > > -static struct kmem_cache *vma_lock_cachep;
> > > -
> > > -static bool vma_lock_alloc(struct vm_area_struct *vma)
> > > -{
> > > -       vma->vm_lock =3D kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL=
);
> > > -       if (!vma->vm_lock)
> > > -               return false;
> > > -
> > > -       init_rwsem(&vma->vm_lock->lock);
> > > -       vma->vm_lock_seq =3D -1;
> > > -
> > > -       return true;
> > > -}
> > > -
> > > -static inline void vma_lock_free(struct vm_area_struct *vma)
> > > -{
> > > -       kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> > > -}
> > > -
> > > -#else /* CONFIG_PER_VMA_LOCK */
> > > -
> > > -static inline bool vma_lock_alloc(struct vm_area_struct *vma) { retu=
rn true; }
> > > -static inline void vma_lock_free(struct vm_area_struct *vma) {}
> > > -
> > > -#endif /* CONFIG_PER_VMA_LOCK */
> > > -
> > >  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> > >  {
> > >         struct vm_area_struct *vma;
> > > @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_s=
truct *mm)
> > >                 return NULL;
> > >
> > >         vma_init(vma, mm);
> > > -       if (!vma_lock_alloc(vma)) {
> > > -               kmem_cache_free(vm_area_cachep, vma);
> > > -               return NULL;
> > > -       }
> > >
> > >         return vma;
> > >  }
> > > @@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm_are=
a_struct *orig)
> > >          * will be reinitialized.
> > >          */
> > >         data_race(memcpy(new, orig, sizeof(*new)));
> > > -       if (!vma_lock_alloc(new)) {
> > > -               kmem_cache_free(vm_area_cachep, new);
> > > -               return NULL;
> > > -       }
> > > +       init_rwsem(&new->vm_lock);
> > > +       new->vm_lock_seq =3D -1;
> > >         INIT_LIST_HEAD(&new->anon_vma_chain);
> > >         vma_numab_state_init(new);
> > >         dup_anon_vma_name(orig, new);
> > > @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vma)
> > >  {
> > >         vma_numab_state_free(vma);
> > >         free_anon_vma_name(vma);
> > > -       vma_lock_free(vma);
> > >         kmem_cache_free(vm_area_cachep, vma);
> > >  }
> > >
> > > @@ -522,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *=
head)
> > >                                                   vm_rcu);
> > >
> > >         /* The vma should not be locked while being destroyed. */
> > > -       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> > > +       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock), vma);
> > >         __vm_area_free(vma);
> > >  }
> > >  #endif
> > > @@ -3192,10 +3156,7 @@ void __init proc_caches_init(void)
> > >                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> > >                         NULL);
> > >
> > > -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB=
_ACCOUNT);
> > > -#ifdef CONFIG_PER_VMA_LOCK
> > > -       vma_lock_cachep =3D KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCO=
UNT);
> > > -#endif
> > > +       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB=
_ACCOUNT|SLAB_HWCACHE_ALIGN);
> > >         mmap_init();
> > >         nsproxy_cache_init();
> > >  }
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 3b7715ecf292..e95ecb2063d2 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -92,7 +92,7 @@ static struct vm_area_struct *uffd_lock_vma(struct =
mm_struct *mm,
> > >                  * mmap_lock, which guarantees that nobody can lock t=
he
> > >                  * vma for write (vma_start_write()) under us.
> > >                  */
> > > -               down_read(&vma->vm_lock->lock);
> > > +               down_read(&vma->vm_lock);
> > >         }
> > >
> > >         mmap_read_unlock(mm);
> > > @@ -1468,9 +1468,9 @@ static int uffd_move_lock(struct mm_struct *mm,
> > >                  * See comment in uffd_lock_vma() as to why not using
> > >                  * vma_start_read() here.
> > >                  */
> > > -               down_read(&(*dst_vmap)->vm_lock->lock);
> > > +               down_read(&(*dst_vmap)->vm_lock);
> > >                 if (*dst_vmap !=3D *src_vmap)
> > > -                       down_read_nested(&(*src_vmap)->vm_lock->lock,
> > > +                       down_read_nested(&(*src_vmap)->vm_lock,
> > >                                          SINGLE_DEPTH_NESTING);
> > >         }
> > >         mmap_read_unlock(mm);
> > > --
> > > 2.43.0
> > >
>
>
>
> --
> Mateusz Guzik <mjguzik gmail.com>

