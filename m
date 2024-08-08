Return-Path: <linux-kernel+bounces-280077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D694C563
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A5A1F2285F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99E15572F;
	Thu,  8 Aug 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fenQgdXD"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAA14F9FB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145951; cv=none; b=MelI4ML04rN3oMPaxutRPPdGEW6P2pyBckHhIQ9v5bS5O3a3M9+ir5gNlL9xgEgB2aL+a3+QcyQ/SPipIQnFIE06CNomtHIGyu52C6dbm4Y9UiU/CNyUM7g42JP84Oh9EYxOOLVmZbxoMmDJfwOq/wekGN5CYx4rJn4m3BTfCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145951; c=relaxed/simple;
	bh=SDgJFiJHvG4Jkq48DtZsmE0VnPpnKFj0SxOOWBY7x/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvXr5RJ/XsuN7fOpsR5b4LPsRWyhZSlPtrBi8hME//t4Xhj1YJRacwgFFhndNfUCYjOoHGSIybme56jMbvm/NZXE6Uep44MNJO6NG0Ib2K/a69sKEFiHhXcOSAu9cSvbSNWo68ZsIjX0JJ2SWUcfeBh/1DJ7nW4+8exud9mM6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fenQgdXD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66c7aeac627so14215367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723145948; x=1723750748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9WjPqxVi+qyY0gD+I3pguLmX9srGyitoSJtP9fP+jw=;
        b=fenQgdXDSuVudNw8YrKKePnBES4ZdmxUPcoDBmunCQf5u96XhgzNyRDDZP8b5jVSW1
         pUZZuqkhPD2c57jQHPIkCkGVGbS7S6kbNEWqwdWa4vk+kOG6Vn2k1tbGOx0mKuoPo8f+
         533fHU7KuvOqxmZCeem7fgdVGyA9sB5VOCxfIWrhdVRqkMdglkSbV6FyuYOyP4S2tZiK
         Eyw2Fvdswr/fbTiXvwzHOkM287Z41khX4JWsao3OleqQP667K5y3jk7fb+B/sK1jbKza
         4aCDC//C4rfPkVOayziJijJeC5eHEsKrYBIRAf15mqnIKd0eJ9t9jts0/yNlzGCPRnG3
         7PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145948; x=1723750748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9WjPqxVi+qyY0gD+I3pguLmX9srGyitoSJtP9fP+jw=;
        b=JZrs55EdDoiqhyRHzrBQ7eTwJd/ugZZ7AMlMSazRj7/jalqTRte9aw8duxfu4vBuZQ
         UYSpKF1aDQpGh1vwSoXm35Rm007vEj+x6ue8I/NFyFJqQM5NEx7tQ9IRZbKwTDBdc6Xu
         JwM3YV6hwDQAfuKPVWjQmIlW38IhjRNEmiXhfhb6ilQwmXHUdWjVBXL5bvG84XMXMZZQ
         s8e3lpSxetEf/IFdl8Ocijzwe+Y58ehs4ajyg2DBeJ3YL+eODTFU3vQd62atMkM4Ybg2
         JFwj8eSOgda4cKButCC3Z+AWpjro4U6pL+e2yW1SqeFM/EJeT+JcgHgA4yTS/PiNcC/U
         y1DA==
X-Gm-Message-State: AOJu0YyH7dvWImspip4aDFFsD1TAxRojOb+B1eZZybZPvSEVF7xXM49p
	YbWOuMZwBhu4Hi26c7ZcmFSf8eIyVBRfXsvlxHCMdRTG/Q7ApYzJwG6NTwmdmz0NixKVd6CdaWr
	UH5ypmxl3J4CrnJfgliapiQ4wJObbSoaS0L7Mu6DxpWC//cbdqrBk
X-Google-Smtp-Source: AGHT+IHn5t+U3VeTjnzSaR/vEuHLpp1i0k8EvI299d9tn+X095/ahlUlJVPlB+VGjJMyXedNhNnX2lsnFIsBkFKdCQ8=
X-Received: by 2002:a05:690c:60c4:b0:63c:416f:182d with SMTP id
 00721157ae682-69bf7d075b1mr43882077b3.12.1723145948011; Thu, 08 Aug 2024
 12:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com>
In-Reply-To: <20240808185949.1094891-1-mjguzik@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 8 Aug 2024 19:38:55 +0000
Message-ID: <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lstoakes@gmail.com, pedro.falcato@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:00=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> ACHTUNG: this is more of a request for benchmarking than a patch
> proposal at this stage
>
> I was pointed at your patch which moved the vma lock to a separate
> allocation [1]. The commit message does not say anything about making
> sure the object itself is allocated with proper alignment and I found
> that the cache creation lacks the HWCACHE_ALIGN flag, which may or may
> not be the problem.
>
> I verified with a simple one-liner than on a stock kernel the vmas keep
> roaming around with a 16-byte alignment:
> # bpftrace -e 'kretprobe:vm_area_alloc  { @[retval & 0x3f] =3D count(); }=
'
> @[16]: 39
> @[0]: 46
> @[32]: 53
> @[48]: 56
>
> Note the stock vma lock cache also lacks the alignment flag. While I
> have not verified experimentally, if they are also romaing it would mean
> that 2 unrelated vmas can false-share locks. If the patch below is a
> bust, the flag should probably be added to that one.
>
> The patch has slapped-around vma lock cache removal + HWALLOC for the
> vma cache. I left a pointer to not change relative offsets between
> current fields. I does compile without CONFIG_PER_VMA_LOCK.
>
> Vlastimil says you tested a case where the struct got bloated to 256
> bytes, but the lock remained separate. It is unclear to me if this
> happened with allocations made with the HWCACHE_ALIGN flag though.
>
> There is 0 urgency on my end, but it would be nice if you could try
> this out with your test rig.

Hi Mateusz,
Sure, I'll give it a spin but I'm not optimistic. Your code looks
almost identical to my latest attempt where I tried placing vm_lock
into different cachelines including a separate one and using
HWCACHE_ALIGN. And yet all my attempts showed regression.
Just FYI, the test I'm using is the pft-threads test from mmtests
suite. I'll post results today evening.
Thanks,
Suren.

>
> 1: https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.co=
m/T/#u
>
> ---
>  include/linux/mm.h       | 18 +++++++--------
>  include/linux/mm_types.h | 10 ++++-----
>  kernel/fork.c            | 47 ++++------------------------------------
>  mm/userfaultfd.c         |  6 ++---
>  4 files changed, 19 insertions(+), 62 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 43b40334e9b2..6d8b668d3deb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -687,7 +687,7 @@ static inline bool vma_start_read(struct vm_area_stru=
ct *vma)
>         if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq))
>                 return false;
>
> -       if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
> +       if (unlikely(down_read_trylock(&vma->vm_lock) =3D=3D 0))
>                 return false;
>
>         /*
> @@ -702,7 +702,7 @@ static inline bool vma_start_read(struct vm_area_stru=
ct *vma)
>          * This pairs with RELEASE semantics in vma_end_write_all().
>          */
>         if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vma->vm_mm=
->mm_lock_seq))) {
> -               up_read(&vma->vm_lock->lock);
> +               up_read(&vma->vm_lock);
>                 return false;
>         }
>         return true;
> @@ -711,7 +711,7 @@ static inline bool vma_start_read(struct vm_area_stru=
ct *vma)
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>         rcu_read_lock(); /* keeps vma alive till the end of up_read */
> -       up_read(&vma->vm_lock->lock);
> +       up_read(&vma->vm_lock);
>         rcu_read_unlock();
>  }
>
> @@ -740,7 +740,7 @@ static inline void vma_start_write(struct vm_area_str=
uct *vma)
>         if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
>
> -       down_write(&vma->vm_lock->lock);
> +       down_write(&vma->vm_lock);
>         /*
>          * We should use WRITE_ONCE() here because we can have concurrent=
 reads
>          * from the early lockless pessimistic check in vma_start_read().
> @@ -748,7 +748,7 @@ static inline void vma_start_write(struct vm_area_str=
uct *vma)
>          * we should use WRITE_ONCE() for cleanliness and to keep KCSAN h=
appy.
>          */
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> -       up_write(&vma->vm_lock->lock);
> +       up_write(&vma->vm_lock);
>  }
>
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> @@ -760,7 +760,7 @@ static inline void vma_assert_write_locked(struct vm_=
area_struct *vma)
>
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -       if (!rwsem_is_locked(&vma->vm_lock->lock))
> +       if (!rwsem_is_locked(&vma->vm_lock))
>                 vma_assert_write_locked(vma);
>  }
>
> @@ -827,10 +827,6 @@ static inline void assert_fault_locked(struct vm_fau=
lt *vmf)
>
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
>
> -/*
> - * WARNING: vma_init does not initialize vma->vm_lock.
> - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> - */
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct=
 *mm)
>  {
>         memset(vma, 0, sizeof(*vma));
> @@ -839,6 +835,8 @@ static inline void vma_init(struct vm_area_struct *vm=
a, struct mm_struct *mm)
>         INIT_LIST_HEAD(&vma->anon_vma_chain);
>         vma_mark_detached(vma, false);
>         vma_numab_state_init(vma);
> +       init_rwsem(&vma->vm_lock);
> +       vma->vm_lock_seq =3D -1;
>  }
>
>  /* Use when VMA is not part of the VMA tree and needs no locking */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 003619fab20e..caffdb4eeb94 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -615,10 +615,6 @@ static inline struct anon_vma_name *anon_vma_name_al=
loc(const char *name)
>  }
>  #endif
>
> -struct vma_lock {
> -       struct rw_semaphore lock;
> -};
> -
>  struct vma_numab_state {
>         /*
>          * Initialised as time in 'jiffies' after which VMA
> @@ -716,8 +712,7 @@ struct vm_area_struct {
>          * slowpath.
>          */
>         int vm_lock_seq;
> -       /* Unstable RCU readers are allowed to read this. */
> -       struct vma_lock *vm_lock;
> +       void *vm_dummy;
>  #endif
>
>         /*
> @@ -770,6 +765,9 @@ struct vm_area_struct {
>         struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
>  #endif
>         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +#ifdef CONFIG_PER_VMA_LOCK
> +       struct rw_semaphore vm_lock ____cacheline_aligned_in_smp;
> +#endif
>  } __randomize_layout;
>
>  #ifdef CONFIG_NUMA
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 92bfe56c9fed..eab04a24d5f1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -
> -/* SLAB cache for vm_area_struct.lock */
> -static struct kmem_cache *vma_lock_cachep;
> -
> -static bool vma_lock_alloc(struct vm_area_struct *vma)
> -{
> -       vma->vm_lock =3D kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
> -       if (!vma->vm_lock)
> -               return false;
> -
> -       init_rwsem(&vma->vm_lock->lock);
> -       vma->vm_lock_seq =3D -1;
> -
> -       return true;
> -}
> -
> -static inline void vma_lock_free(struct vm_area_struct *vma)
> -{
> -       kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> -}
> -
> -#else /* CONFIG_PER_VMA_LOCK */
> -
> -static inline bool vma_lock_alloc(struct vm_area_struct *vma) { return t=
rue; }
> -static inline void vma_lock_free(struct vm_area_struct *vma) {}
> -
> -#endif /* CONFIG_PER_VMA_LOCK */
> -
>  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  {
>         struct vm_area_struct *vma;
> @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_struc=
t *mm)
>                 return NULL;
>
>         vma_init(vma, mm);
> -       if (!vma_lock_alloc(vma)) {
> -               kmem_cache_free(vm_area_cachep, vma);
> -               return NULL;
> -       }
>
>         return vma;
>  }
> @@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm_area_st=
ruct *orig)
>          * will be reinitialized.
>          */
>         data_race(memcpy(new, orig, sizeof(*new)));
> -       if (!vma_lock_alloc(new)) {
> -               kmem_cache_free(vm_area_cachep, new);
> -               return NULL;
> -       }
> +       init_rwsem(&new->vm_lock);
> +       new->vm_lock_seq =3D -1;
>         INIT_LIST_HEAD(&new->anon_vma_chain);
>         vma_numab_state_init(new);
>         dup_anon_vma_name(orig, new);
> @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vma)
>  {
>         vma_numab_state_free(vma);
>         free_anon_vma_name(vma);
> -       vma_lock_free(vma);
>         kmem_cache_free(vm_area_cachep, vma);
>  }
>
> @@ -522,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head=
)
>                                                   vm_rcu);
>
>         /* The vma should not be locked while being destroyed. */
> -       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> +       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock), vma);
>         __vm_area_free(vma);
>  }
>  #endif
> @@ -3192,10 +3156,7 @@ void __init proc_caches_init(void)
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>                         NULL);
>
> -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACC=
OUNT);
> -#ifdef CONFIG_PER_VMA_LOCK
> -       vma_lock_cachep =3D KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT)=
;
> -#endif
> +       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACC=
OUNT|SLAB_HWCACHE_ALIGN);
>         mmap_init();
>         nsproxy_cache_init();
>  }
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b7715ecf292..e95ecb2063d2 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -92,7 +92,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_s=
truct *mm,
>                  * mmap_lock, which guarantees that nobody can lock the
>                  * vma for write (vma_start_write()) under us.
>                  */
> -               down_read(&vma->vm_lock->lock);
> +               down_read(&vma->vm_lock);
>         }
>
>         mmap_read_unlock(mm);
> @@ -1468,9 +1468,9 @@ static int uffd_move_lock(struct mm_struct *mm,
>                  * See comment in uffd_lock_vma() as to why not using
>                  * vma_start_read() here.
>                  */
> -               down_read(&(*dst_vmap)->vm_lock->lock);
> +               down_read(&(*dst_vmap)->vm_lock);
>                 if (*dst_vmap !=3D *src_vmap)
> -                       down_read_nested(&(*src_vmap)->vm_lock->lock,
> +                       down_read_nested(&(*src_vmap)->vm_lock,
>                                          SINGLE_DEPTH_NESTING);
>         }
>         mmap_read_unlock(mm);
> --
> 2.43.0
>

