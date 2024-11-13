Return-Path: <linux-kernel+bounces-407933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662219C7794
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25333280A57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593BC1632DC;
	Wed, 13 Nov 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkYefeP3"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D619158861
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512584; cv=none; b=iLX7o+UWmhBP31ZwLloOvTWvPV9v5aje5qk1NVnANOSiy70tVHpH2woMB4cdbYj6BHlEK7PGXU28DnE8GjycHFHe+ep3bk3AzyYBHqs2ywPSK1VjVhjzO0s4R1tEW3bOHMBQMFP4d9RyKWso6i1eHbbb22Ag8GD/37X5qdwwUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512584; c=relaxed/simple;
	bh=zFKsTMccqrK0GWEV87cV5u8OkzOzxmruhhFhmcK23I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEaLlHmh2qfPjEbqNKVbDm0OZqYraZsoUeVOyxapL58ZxiQ7PdZcJ5jQLqnZgDsG80r/lX1wcy2Uq+ZbMqlqGvMjUrR52MjyQWtP36+vVOGRhFUl+Cf9C4gq79MEHEXxmyrrqaz9U8pNQ+jnw3yT1KyOV16i7q/y6DVrssS/He8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkYefeP3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460969c49f2so301001cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731512581; x=1732117381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvam9WV1Qmn4wOJy3DU8hiIppiH9WSEamCw5jH8Jzro=;
        b=dkYefeP3zY3xZ5ZHfOx1rPPqYl7+bj4CqskRusQyAWn6Mk5EHsbhvuzD8azhAPLarK
         PUA9emp62XLAqrtPDabT8788yULEyzRIUSf8yOEDzpqS7SRKYAIeOkwIFBVbJjm3C5eP
         23ZgVziqGcIsEI/bciXWGcElhgueIOB0k5ireEUN+llc5Y2ym0k6Nqd17jaihea02y20
         YlxHFQ0k7psUe+DRYYQyovmjEG0xyqVyokzGdR7scWFJb5QIHhDDaXF+EN2/UPJPhHYQ
         7TfAk2DGJFZGftKzVOUv2MQpSJRbCepHqAM+eFzG/H63pLrIOVQqQKMLHEdmBAEqLmZF
         UCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512581; x=1732117381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvam9WV1Qmn4wOJy3DU8hiIppiH9WSEamCw5jH8Jzro=;
        b=eOIvJPv5Ho2x7N5R9A0RpxO9/kohxdFMOwJqVDCXy2S5Vvu5heZoXCKAhv5PRdeAl7
         xarzU84y+5atG3f8ZV19Je215cMBd4hq536U3iWeQ98uoGevpqvRO2DFiGNdQGjZfyXc
         TCXHtk7geHvfq6Lz9BBuRleQcOeH2yr8GkXHpMz/S3V8zCg3L/1cwwuQtFiCMx9VU/YA
         pA4M8fYc5+7XmAabqP/WGrVXKG8lEbmxKrZH8SAzCLNyTDFihyhA7ny6DkOe7eTg5nC5
         tS/QSQHO12vSW3RjbJ4fysDK8bgjnSYIiPmEZhbQf8bSGqKTj9IjSlvs9rOkZOhEc8ET
         qEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3LEnC+k0MCGOPu1AQbbWOakkWwIglpwpPiTetlVtzK7daH9AQUrrhnylVxFSLHJV1tSYnd3Rbbm1vYwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBynBato9kokPrlipu2rBLb3zKKYxOVjZqKiaqiZL5kDJ4GHo
	vwLsn4soSfvBeOPE7Lmrom5hmkLR9zMTqOG5+27qoDGBcZOg+3HoEjlCUmtPSc5s4LM5r5OYtyF
	1LJVW/kjL83u0ZvHr86lGe2Wilr2VsMnqRCJ9
X-Gm-Gg: ASbGnct5Ll8PlJo+yhuK369h9SIyWzy8kALNmmUtbSgQaDE8LhHlPG/qOSzj6Lw+FIS
	KGrFvi+sGDuXEtTP+A+Dx8Mb5nTRx23Q=
X-Google-Smtp-Source: AGHT+IGoSJC7NEVZDp5NW6fuqArmuQfmnz8hDVQ+6Ciw+IGZ+zOWqIauKKI4LWWqo2ZgFZSMtZZdIqMYrtQukXe69Zs=
X-Received: by 2002:a05:622a:13cc:b0:462:c158:9f5b with SMTP id
 d75a77b69052e-4634cad5b89mr3497791cf.19.1731512580871; Wed, 13 Nov 2024
 07:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
In-Reply-To: <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 07:42:49 -0800
Message-ID: <CAJuCfpHz-u9w1A8d9LEZ6=mmxXN=JLQr9N00dKpALWUT6GVsfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 6:28=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
>
> I don't see a motivating reason as to why we want to do this? We increase
> memory usage here which is not good, but later lock optimisation mitigate=
s
> it, but why wouldn't we just do the lock optimisations and use less memor=
y
> overall?
>
> > This patchset moves vm_lock back into vm_area_struct, aligning it at th=
e
> > cacheline boundary and changing the cache to be cache-aligned as well.
> > This causes VMA memory consumption to grow from 160 (vm_area_struct) + =
40
> > (vm_lock) bytes to 256 bytes:
> >
> >     slabinfo before:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vma_lock         ...     40  102    1 : ...
> >      vm_area_struct   ...    160   51    2 : ...
>
> Pedantry, but it might be worth mentioning how much this can vary by conf=
ig.
>
> For instance, on my machine:
>
> vm_area_struct    125238 138820    184   44

Ack.

>
> >
> >     slabinfo after moving vm_lock:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    256   32    2 : ...
> >
> > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 page=
s,
> > which is 5.5MB per 100000 VMAs. This memory consumption growth can be
> > addressed later by optimizing the vm_lock.
>
> Yes grabbing this back is of critical importance I'd say! :)
>
> Functionally it looks ok to me but would like to see a stronger
> justification in the commit msg! :)
>
> >
> > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google=
.com/
> > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT=
_kbfP_pR+-2g@mail.gmail.com/
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h       | 28 +++++++++++++----------
> >  include/linux/mm_types.h |  6 +++--
> >  kernel/fork.c            | 49 ++++------------------------------------
> >  3 files changed, 25 insertions(+), 58 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 01ce619f3d17..a5eb0be3e351 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -684,6 +684,12 @@ static inline void vma_numab_state_free(struct vm_=
area_struct *vma) {}
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> > +static inline void vma_lock_init(struct vm_area_struct *vma)
> > +{
> > +     init_rwsem(&vma->vm_lock.lock);
> > +     vma->vm_lock_seq =3D UINT_MAX;
> > +}
> > +
> >  /*
> >   * Try to read-lock a vma. The function is allowed to occasionally yie=
ld false
> >   * locked result to avoid performance overhead, in which case we fall =
back to
> > @@ -701,7 +707,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq.sequence))
> >               return false;
> >
> > -     if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
> > +     if (unlikely(down_read_trylock(&vma->vm_lock.lock) =3D=3D 0))
> >               return false;
> >
> >       /*
> > @@ -716,7 +722,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >        * This pairs with RELEASE semantics in vma_end_write_all().
> >        */
> >       if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->vm_m=
m->mm_lock_seq))) {
> > -             up_read(&vma->vm_lock->lock);
> > +             up_read(&vma->vm_lock.lock);
> >               return false;
> >       }
> >       return true;
> > @@ -729,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >  static inline void vma_start_read_locked_nested(struct vm_area_struct =
*vma, int subclass)
> >  {
> >       mmap_assert_locked(vma->vm_mm);
> > -     down_read_nested(&vma->vm_lock->lock, subclass);
> > +     down_read_nested(&vma->vm_lock.lock, subclass);
> >  }
> >
> >  /*
> > @@ -739,13 +745,13 @@ static inline void vma_start_read_locked_nested(s=
truct vm_area_struct *vma, int
> >  static inline void vma_start_read_locked(struct vm_area_struct *vma)
> >  {
> >       mmap_assert_locked(vma->vm_mm);
> > -     down_read(&vma->vm_lock->lock);
> > +     down_read(&vma->vm_lock.lock);
> >  }
> >
> >  static inline void vma_end_read(struct vm_area_struct *vma)
> >  {
> >       rcu_read_lock(); /* keeps vma alive till the end of up_read */
> > -     up_read(&vma->vm_lock->lock);
> > +     up_read(&vma->vm_lock.lock);
> >       rcu_read_unlock();
> >  }
> >
> > @@ -774,7 +780,7 @@ static inline void vma_start_write(struct vm_area_s=
truct *vma)
> >       if (__is_vma_write_locked(vma, &mm_lock_seq))
> >               return;
> >
> > -     down_write(&vma->vm_lock->lock);
> > +     down_write(&vma->vm_lock.lock);
> >       /*
> >        * We should use WRITE_ONCE() here because we can have concurrent=
 reads
> >        * from the early lockless pessimistic check in vma_start_read().
> > @@ -782,7 +788,7 @@ static inline void vma_start_write(struct vm_area_s=
truct *vma)
> >        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN h=
appy.
> >        */
> >       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > -     up_write(&vma->vm_lock->lock);
> > +     up_write(&vma->vm_lock.lock);
> >  }
> >
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > @@ -794,7 +800,7 @@ static inline void vma_assert_write_locked(struct v=
m_area_struct *vma)
> >
> >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> >  {
> > -     if (!rwsem_is_locked(&vma->vm_lock->lock))
> > +     if (!rwsem_is_locked(&vma->vm_lock.lock))
> >               vma_assert_write_locked(vma);
> >  }
> >
> > @@ -827,6 +833,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> > +static inline void vma_lock_init(struct vm_area_struct *vma) {}
> >  static inline bool vma_start_read(struct vm_area_struct *vma)
> >               { return false; }
> >  static inline void vma_end_read(struct vm_area_struct *vma) {}
> > @@ -861,10 +868,6 @@ static inline void assert_fault_locked(struct vm_f=
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
> >       memset(vma, 0, sizeof(*vma));
> > @@ -873,6 +876,7 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> >       vma_mark_detached(vma, false);
> >       vma_numab_state_init(vma);
> > +     vma_lock_init(vma);
> >  }
> >
> >  /* Use when VMA is not part of the VMA tree and needs no locking */
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 80fef38d9d64..5c4bfdcfac72 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -716,8 +716,6 @@ struct vm_area_struct {
> >        * slowpath.
> >        */
> >       unsigned int vm_lock_seq;
> > -     /* Unstable RCU readers are allowed to read this. */
> > -     struct vma_lock *vm_lock;
> >  #endif
> >
> >       /*
> > @@ -770,6 +768,10 @@ struct vm_area_struct {
> >       struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
> >  #endif
> >       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* Unstable RCU readers are allowed to read this. */
> > +     struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> > +#endif
> >  } __randomize_layout;
> >
> >  #ifdef CONFIG_NUMA
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 0061cf2450ef..7823797e31d2 100644
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
> > -     vma->vm_lock =3D kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
> > -     if (!vma->vm_lock)
> > -             return false;
> > -
> > -     init_rwsem(&vma->vm_lock->lock);
> > -     vma->vm_lock_seq =3D UINT_MAX;
> > -
> > -     return true;
> > -}
> > -
> > -static inline void vma_lock_free(struct vm_area_struct *vma)
> > -{
> > -     kmem_cache_free(vma_lock_cachep, vma->vm_lock);
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
> >       struct vm_area_struct *vma;
> > @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_str=
uct *mm)
> >               return NULL;
> >
> >       vma_init(vma, mm);
> > -     if (!vma_lock_alloc(vma)) {
> > -             kmem_cache_free(vm_area_cachep, vma);
> > -             return NULL;
> > -     }
> >
> >       return vma;
> >  }
> > @@ -496,10 +463,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_=
struct *orig)
> >        * will be reinitialized.
> >        */
> >       data_race(memcpy(new, orig, sizeof(*new)));
> > -     if (!vma_lock_alloc(new)) {
> > -             kmem_cache_free(vm_area_cachep, new);
> > -             return NULL;
> > -     }
> > +     vma_lock_init(new);
> >       INIT_LIST_HEAD(&new->anon_vma_chain);
> >       vma_numab_state_init(new);
> >       dup_anon_vma_name(orig, new);
> > @@ -511,7 +475,6 @@ void __vm_area_free(struct vm_area_struct *vma)
> >  {
> >       vma_numab_state_free(vma);
> >       free_anon_vma_name(vma);
> > -     vma_lock_free(vma);
> >       kmem_cache_free(vm_area_cachep, vma);
> >  }
> >
> > @@ -522,7 +485,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *he=
ad)
> >                                                 vm_rcu);
> >
> >       /* The vma should not be locked while being destroyed. */
> > -     VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> > +     VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
> >       __vm_area_free(vma);
> >  }
> >  #endif
> > @@ -3168,11 +3131,9 @@ void __init proc_caches_init(void)
> >                       sizeof(struct fs_struct), 0,
> >                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> >                       NULL);
> > -
> > -     vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACC=
OUNT);
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -     vma_lock_cachep =3D KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT)=
;
> > -#endif
> > +     vm_area_cachep =3D KMEM_CACHE(vm_area_struct,
> > +                     SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> > +                     SLAB_ACCOUNT);
>
> Why the SLAB_NO_MERGE?

Ah, I had it there for convenience to be able to see them separately
in /proc/slabinfo. With SLAB_HWCACHE_ALIGN I don't think it matters
for cacheline sharing...
Once we add SLAB_TYPESAFE_BY_RCU this flag won't matter anyway because
it will prevent slab merging.

>
> >       mmap_init();
> >       nsproxy_cache_init();
> >  }
> > --
> > 2.47.0.277.g8800431eea-goog
> >

