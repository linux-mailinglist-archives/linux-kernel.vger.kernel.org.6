Return-Path: <linux-kernel+bounces-280086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4995794C581
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B286B285300
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7301552F5;
	Thu,  8 Aug 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2rJjDwI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6E7E1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147448; cv=none; b=tCCsvZPcerzwn08tlmW84eU0Q584au1qhoYRG9533w2TfAfLTlZq7cJ+XLe5k6BXt3HLkVvi4UIZ2CkzbheU1JbxyoZpuY4cs1INW2BZoPxrfcMDnzNkd/tpaXnzgxsizgN8WQ26di3yk6psXE+IKaFR5k46Vl0d1tvd577AP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147448; c=relaxed/simple;
	bh=k5ExbZN5oXwwq7vAsX1HlqnQ7bM0W9YuObt7lmTaIhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buUcfmCdXgUVjcJeY51RuvX2x1aIr5LZ4j1ydj6xyJYTtkSsn8X8mqiqt/r+q4twQI3GEHHAiHNBOQMfYZ+ouNXb/tdREdZqe8c3GgiUIYSP8rAd8C9+pdqqsloOVhYtJHZ0HSkuibTQSFQViGn7qCrAG05uXyScJG4oXhjYsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2rJjDwI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04150796so1721885e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723147444; x=1723752244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHo2bWArmiJcnl4yTkhnUjmNKz0bV7s3htlSuSHuKls=;
        b=F2rJjDwIAPoYNDHTFDtaRUb+D6GEQPnUfPjqixSru+Yu6kpkcbRX33nd9nDvgigI2H
         e869aygalYCCWOOzHDDZL9A2C3wQ6o73qAe690owskFLF1BzYHPysHz5LK3sjCKtLT9o
         8Hv0pnSdq7VeIF7yeQlU330ZhR91SWEtP+a0gF7vE5LxXSFtx0wQ3LJ+s0++Gn8QL4uF
         2Uf8qBprrP5aurOX/+YTawHQj3LaomHqiZWfX9WUPGJqPK/YYELP1fO97UZdq2owadB6
         g6IBbPFwgg4Xwt4+MUH+I5eENO9/B4DK3FDrM0qECSz6wifLmJGGonjhDSQr+rM+6G1j
         zIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723147444; x=1723752244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHo2bWArmiJcnl4yTkhnUjmNKz0bV7s3htlSuSHuKls=;
        b=YyJgNElYY0uQCvsDCpJ24FfnOSo6rmq7fy96Mv4efhj6c+PYJqq7gChC8nv+nSevrk
         CUPDXsuiwO1n6bKARkF6mgBL1DLDtVihcvhRNqvo70AzyFjwLK5q+NubquKfq+dGfkTN
         rqEQ+pA89Bwv6JwRKO51fbmKZb2Y7hl2zvqDbqrCLr/UlLfXaBagrxHeiJfSms0TnoU3
         ZVRjNM4dgeuqAkguPXLH3me6yRBlwhIjwCBhPnZLo8I+dOquEdDU/qbzmhtcIPX4MV98
         NE141A06ogMcOaCVgpUaNXCACiunICt1X/YuWGOgyL1gYr8HGSST449y/ci9B1m9fSid
         bp5w==
X-Gm-Message-State: AOJu0Yz/3EF8M+eqEcbyLPVwE14+Yk3a+6pV0WZp5Qv+jtvVvRrCnKbJ
	fLYa1kXtYOyPHImYe1SXdlMAfg+D6eRqGNBQV9PICHwGPqLiC5WoVxUmU53xH6q3xRStkwCSnTC
	Vks0XOFtHprKnTfKdho6UqDlGKEA=
X-Google-Smtp-Source: AGHT+IFg6Ots6VLl1spUF5CAN89IJIsJF8kdqiyFnulLMRk5DNM1jAnEWhy6pKLG1ASDbsaIk36m1tq2b3JWZJ4BMYs=
X-Received: by 2002:a05:6512:b8f:b0:52c:e030:1450 with SMTP id
 2adb3069b0e04-530e5829a11mr1745921e87.14.1723147443339; Thu, 08 Aug 2024
 13:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
In-Reply-To: <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 8 Aug 2024 22:03:51 +0200
Message-ID: <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lstoakes@gmail.com, pedro.falcato@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Thu, Aug 8, 2024 at 7:00=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >
> > ACHTUNG: this is more of a request for benchmarking than a patch
> > proposal at this stage
> >
> > I was pointed at your patch which moved the vma lock to a separate
> > allocation [1]. The commit message does not say anything about making
> > sure the object itself is allocated with proper alignment and I found
> > that the cache creation lacks the HWCACHE_ALIGN flag, which may or may
> > not be the problem.
> >
> > I verified with a simple one-liner than on a stock kernel the vmas keep
> > roaming around with a 16-byte alignment:
> > # bpftrace -e 'kretprobe:vm_area_alloc  { @[retval & 0x3f] =3D count();=
 }'
> > @[16]: 39
> > @[0]: 46
> > @[32]: 53
> > @[48]: 56
> >
> > Note the stock vma lock cache also lacks the alignment flag. While I
> > have not verified experimentally, if they are also romaing it would mea=
n
> > that 2 unrelated vmas can false-share locks. If the patch below is a
> > bust, the flag should probably be added to that one.
> >
> > The patch has slapped-around vma lock cache removal + HWALLOC for the
> > vma cache. I left a pointer to not change relative offsets between
> > current fields. I does compile without CONFIG_PER_VMA_LOCK.
> >
> > Vlastimil says you tested a case where the struct got bloated to 256
> > bytes, but the lock remained separate. It is unclear to me if this
> > happened with allocations made with the HWCACHE_ALIGN flag though.
> >
> > There is 0 urgency on my end, but it would be nice if you could try
> > this out with your test rig.
>
> Hi Mateusz,
> Sure, I'll give it a spin but I'm not optimistic. Your code looks
> almost identical to my latest attempt where I tried placing vm_lock
> into different cachelines including a separate one and using
> HWCACHE_ALIGN. And yet all my attempts showed regression.
> Just FYI, the test I'm using is the pft-threads test from mmtests
> suite. I'll post results today evening.
> Thanks,
> Suren.

Ok, well maybe you did not leave the pointer in place? :)

It is plausible the problem is on vs off cpu behavior of rwsems --
there is a corner case where they neglect to spin. It is plausible
perf goes down simply because there is less on cpu time.

Thus you bench can you make sure to time(1)?

For example with zsh I got:
./run-mmtests.sh --no-monitor --config configs/config-workload-pft-threads

39.35s user 445.45s system 390% cpu 124.04s (2:04.04) total

I verified with offcputime-bpfcc -K that indeed there is a bunch of
pft going off cpu from down_read/down_write even at the modest scale
this was running in my case.

>
> >
> > 1: https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.=
com/T/#u
> >
> > ---
> >  include/linux/mm.h       | 18 +++++++--------
> >  include/linux/mm_types.h | 10 ++++-----
> >  kernel/fork.c            | 47 ++++------------------------------------
> >  mm/userfaultfd.c         |  6 ++---
> >  4 files changed, 19 insertions(+), 62 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 43b40334e9b2..6d8b668d3deb 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -687,7 +687,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >         if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm=
_lock_seq))
> >                 return false;
> >
> > -       if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
> > +       if (unlikely(down_read_trylock(&vma->vm_lock) =3D=3D 0))
> >                 return false;
> >
> >         /*
> > @@ -702,7 +702,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >          * This pairs with RELEASE semantics in vma_end_write_all().
> >          */
> >         if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vma->vm_=
mm->mm_lock_seq))) {
> > -               up_read(&vma->vm_lock->lock);
> > +               up_read(&vma->vm_lock);
> >                 return false;
> >         }
> >         return true;
> > @@ -711,7 +711,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >  static inline void vma_end_read(struct vm_area_struct *vma)
> >  {
> >         rcu_read_lock(); /* keeps vma alive till the end of up_read */
> > -       up_read(&vma->vm_lock->lock);
> > +       up_read(&vma->vm_lock);
> >         rcu_read_unlock();
> >  }
> >
> > @@ -740,7 +740,7 @@ static inline void vma_start_write(struct vm_area_s=
truct *vma)
> >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> >                 return;
> >
> > -       down_write(&vma->vm_lock->lock);
> > +       down_write(&vma->vm_lock);
> >         /*
> >          * We should use WRITE_ONCE() here because we can have concurre=
nt reads
> >          * from the early lockless pessimistic check in vma_start_read(=
).
> > @@ -748,7 +748,7 @@ static inline void vma_start_write(struct vm_area_s=
truct *vma)
> >          * we should use WRITE_ONCE() for cleanliness and to keep KCSAN=
 happy.
> >          */
> >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > -       up_write(&vma->vm_lock->lock);
> > +       up_write(&vma->vm_lock);
> >  }
> >
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > @@ -760,7 +760,7 @@ static inline void vma_assert_write_locked(struct v=
m_area_struct *vma)
> >
> >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> >  {
> > -       if (!rwsem_is_locked(&vma->vm_lock->lock))
> > +       if (!rwsem_is_locked(&vma->vm_lock))
> >                 vma_assert_write_locked(vma);
> >  }
> >
> > @@ -827,10 +827,6 @@ static inline void assert_fault_locked(struct vm_f=
ault *vmf)
> >
> >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> >
> > -/*
> > - * WARNING: vma_init does not initialize vma->vm_lock.
> > - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> > - */
> >  static inline void vma_init(struct vm_area_struct *vma, struct mm_stru=
ct *mm)
> >  {
> >         memset(vma, 0, sizeof(*vma));
> > @@ -839,6 +835,8 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
> >         INIT_LIST_HEAD(&vma->anon_vma_chain);
> >         vma_mark_detached(vma, false);
> >         vma_numab_state_init(vma);
> > +       init_rwsem(&vma->vm_lock);
> > +       vma->vm_lock_seq =3D -1;
> >  }
> >
> >  /* Use when VMA is not part of the VMA tree and needs no locking */
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 003619fab20e..caffdb4eeb94 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -615,10 +615,6 @@ static inline struct anon_vma_name *anon_vma_name_=
alloc(const char *name)
> >  }
> >  #endif
> >
> > -struct vma_lock {
> > -       struct rw_semaphore lock;
> > -};
> > -
> >  struct vma_numab_state {
> >         /*
> >          * Initialised as time in 'jiffies' after which VMA
> > @@ -716,8 +712,7 @@ struct vm_area_struct {
> >          * slowpath.
> >          */
> >         int vm_lock_seq;
> > -       /* Unstable RCU readers are allowed to read this. */
> > -       struct vma_lock *vm_lock;
> > +       void *vm_dummy;
> >  #endif
> >
> >         /*
> > @@ -770,6 +765,9 @@ struct vm_area_struct {
> >         struct vma_numab_state *numab_state;    /* NUMA Balancing state=
 */
> >  #endif
> >         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +       struct rw_semaphore vm_lock ____cacheline_aligned_in_smp;
> > +#endif
> >  } __randomize_layout;
> >
> >  #ifdef CONFIG_NUMA
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 92bfe56c9fed..eab04a24d5f1 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
> >  /* SLAB cache for mm_struct structures (tsk->mm) */
> >  static struct kmem_cache *mm_cachep;
> >
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -
> > -/* SLAB cache for vm_area_struct.lock */
> > -static struct kmem_cache *vma_lock_cachep;
> > -
> > -static bool vma_lock_alloc(struct vm_area_struct *vma)
> > -{
> > -       vma->vm_lock =3D kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
> > -       if (!vma->vm_lock)
> > -               return false;
> > -
> > -       init_rwsem(&vma->vm_lock->lock);
> > -       vma->vm_lock_seq =3D -1;
> > -
> > -       return true;
> > -}
> > -
> > -static inline void vma_lock_free(struct vm_area_struct *vma)
> > -{
> > -       kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> > -}
> > -
> > -#else /* CONFIG_PER_VMA_LOCK */
> > -
> > -static inline bool vma_lock_alloc(struct vm_area_struct *vma) { return=
 true; }
> > -static inline void vma_lock_free(struct vm_area_struct *vma) {}
> > -
> > -#endif /* CONFIG_PER_VMA_LOCK */
> > -
> >  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> >  {
> >         struct vm_area_struct *vma;
> > @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_str=
uct *mm)
> >                 return NULL;
> >
> >         vma_init(vma, mm);
> > -       if (!vma_lock_alloc(vma)) {
> > -               kmem_cache_free(vm_area_cachep, vma);
> > -               return NULL;
> > -       }
> >
> >         return vma;
> >  }
> > @@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm_area_=
struct *orig)
> >          * will be reinitialized.
> >          */
> >         data_race(memcpy(new, orig, sizeof(*new)));
> > -       if (!vma_lock_alloc(new)) {
> > -               kmem_cache_free(vm_area_cachep, new);
> > -               return NULL;
> > -       }
> > +       init_rwsem(&new->vm_lock);
> > +       new->vm_lock_seq =3D -1;
> >         INIT_LIST_HEAD(&new->anon_vma_chain);
> >         vma_numab_state_init(new);
> >         dup_anon_vma_name(orig, new);
> > @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vma)
> >  {
> >         vma_numab_state_free(vma);
> >         free_anon_vma_name(vma);
> > -       vma_lock_free(vma);
> >         kmem_cache_free(vm_area_cachep, vma);
> >  }
> >
> > @@ -522,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *he=
ad)
> >                                                   vm_rcu);
> >
> >         /* The vma should not be locked while being destroyed. */
> > -       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> > +       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock), vma);
> >         __vm_area_free(vma);
> >  }
> >  #endif
> > @@ -3192,10 +3156,7 @@ void __init proc_caches_init(void)
> >                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> >                         NULL);
> >
> > -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_A=
CCOUNT);
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -       vma_lock_cachep =3D KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUN=
T);
> > -#endif
> > +       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_A=
CCOUNT|SLAB_HWCACHE_ALIGN);
> >         mmap_init();
> >         nsproxy_cache_init();
> >  }
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 3b7715ecf292..e95ecb2063d2 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -92,7 +92,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm=
_struct *mm,
> >                  * mmap_lock, which guarantees that nobody can lock the
> >                  * vma for write (vma_start_write()) under us.
> >                  */
> > -               down_read(&vma->vm_lock->lock);
> > +               down_read(&vma->vm_lock);
> >         }
> >
> >         mmap_read_unlock(mm);
> > @@ -1468,9 +1468,9 @@ static int uffd_move_lock(struct mm_struct *mm,
> >                  * See comment in uffd_lock_vma() as to why not using
> >                  * vma_start_read() here.
> >                  */
> > -               down_read(&(*dst_vmap)->vm_lock->lock);
> > +               down_read(&(*dst_vmap)->vm_lock);
> >                 if (*dst_vmap !=3D *src_vmap)
> > -                       down_read_nested(&(*src_vmap)->vm_lock->lock,
> > +                       down_read_nested(&(*src_vmap)->vm_lock,
> >                                          SINGLE_DEPTH_NESTING);
> >         }
> >         mmap_read_unlock(mm);
> > --
> > 2.43.0
> >



--=20
Mateusz Guzik <mjguzik gmail.com>

