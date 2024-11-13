Return-Path: <linux-kernel+bounces-407018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701D9C6779
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD4E1F246A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5596C15ADA6;
	Wed, 13 Nov 2024 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJ1CH4Cv"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C0158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466663; cv=none; b=Rloro2/D6r63ePYZwPteDGCVo2US7X+WDP0AVRhqBvdlVoq79ISptgJ7jnzPsEepYAOi1Fa3YPfTdP3EmUkwzsFuAEYZHJods7LiBCOl7XSZJa7s0I+Z0mQd1Z1JOolxgTW11WNA9r7SGkXZ6HCbNCainKYG/cuNjMI45B/h2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466663; c=relaxed/simple;
	bh=wnAdKheSmo18Y6HLy6pwEJlr03a+bXgkV8ditJ2B4VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhjGx9+9zxmwJBK5hypJVTuQWJfjnDVGnZftHdvv3BaI7fY/18PoIRKZz+Jon0ZBWxEcn3t374Qccct8RmYXXN7/EIt3x6Ep6ELnrAiPq/BelqfCtqwhg5J3GcycHYtbAOEvxKrZYurxW8WyfgMfyfBzPA2twbMhMkHLX2nrKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJ1CH4Cv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso62425ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731466661; x=1732071461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiPGZH28TjM74y6PlEbeCLpg1G4vxPdKyGtVU4e+ltk=;
        b=CJ1CH4CvKQI6GCRJNxq2WuXZNBuP81FE5ozRUPvIK3ZQfxGvH7Kbwxc1e3T8F3HZxQ
         m5pZGV1auEyxNeGb+zVQ6u11J5bztkNsH+RaUARlfO7JpycfCsqjTq/V4LpI/PPq7+1h
         IjmJXOU++E1fRkINe7lTmJMhNobwov7qzZuN8lSi/rkSHdWOByKUIzoAxLpoR62NgKk9
         pwknvOLQjARjeB6N1hOxkZaBS8vk2YMH/PXP3EumFAkIOU/04tXY+pkStogml1IVj955
         R98RUidnkohArCR2D6PGdmVjZh0AE+g0Pfu3YhA6LL9CgK7TONGPrOjszA5zcsOS16YB
         4Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731466661; x=1732071461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiPGZH28TjM74y6PlEbeCLpg1G4vxPdKyGtVU4e+ltk=;
        b=LfpTR3LK2SSPRNVdiqZSj3Hj74BzHI1X9xbHhSri5LEPxlAlraWEANn8hCUK0YYA7g
         GScNL4dLScwYQXvvyzMBqUoKX1b8msVPgDWdzVMx9VW8NL/dZcGI4TBp8AwRUl9OOL18
         p6lLio7V8JKkwgjxeBuM2LpGN7Uun0zAN0kYIkdXBediZDnRnKkPW854wuW/ic/QhPRk
         baTeYUXTVqppHK6bhJ4+y1QD6mn+FXQ9LUyx8X0CD6G0xhWn7K4GXhM1S/EKONWReiD+
         obZmGU9Cd91HSBkrawGvvxGqyuNeve1KYhfCq4xMYW4CXVMCcJwdL1Qk/24ZwqH4Ogmk
         CzZg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ev5FKocCSd+jh89jduG1ExXmtjJSaPqbk1mx6KMnWSArHT8MfTF92sHMv5zBpFXaEamm1CmS5Ja7In8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotiwlJNkZUUqmBLXrqKEGYwY8PukChNRskEPft1RcMIOOzt9j
	FXfcCrqv/p3cCV0mSkwNhmc/pDGfG+RcCcXVMQCOm3rCrHWdGxL1SvEi9mDUBWBH2k3C860FLbr
	QGxKG98t3tZdvJ7DteJ8xZqtLVP2Psedvthqj
X-Gm-Gg: ASbGncsKrxrDrBjwr3oFw6j0FJ8ECWQL/WYrltiKsE47tkvON5NwWCyowaAhaqKByWJ
	CpIAnx5/K628Blcp/XjJipsCr3JPCuCA=
X-Google-Smtp-Source: AGHT+IEECaI8sMTzzH3P3OtOAOiKpt4aBBrFl39wfr2y6vpKiA8N//g2AVMBj6w97P3qp6YBF6Zwm7sETS31Ttr2DS8=
X-Received: by 2002:a05:6e02:19cc:b0:3a0:8cb6:3ad1 with SMTP id
 e9e14a558f8ab-3a715c010eamr1580395ab.20.1731466660621; Tue, 12 Nov 2024
 18:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
In-Reply-To: <20241112194635.444146-5-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 18:57:29 -0800
Message-ID: <CAJuCfpFd2_7q6pi1=G9B0VW5ynCWhkkDDA3PU293FPtT_CcBQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:46=E2=80=AFAM 'Suren Baghdasaryan' via kernel-te=
am
<kernel-team@android.com> wrote:
>
> To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> object reuse before RCU grace period is over will be detected inside
> lock_vma_under_rcu().
> lock_vma_under_rcu() enters RCU read section, finds the vma at the
> given address, locks the vma and checks if it got detached or remapped
> to cover a different address range. These last checks are there
> to ensure that the vma was not modified after we found it but before
> locking it. Vma reuse introduces a possibility that in between those
> events of finding and locking the vma, it can get detached, reused,
> added into a tree and be marked as attached. Current checks will help
> detecting cases when:
> - vma was reused but not yet added into the tree (detached check)
> - vma was reused at a different address range (address check)
> If vma is covering a new address range which still includes the address
> we were looking for, it's not a problem unless the reused vma was added
> into a different address space. Therefore checking that vma->vm_mm is
> still the same is the the only missing check to detect vma reuse.

Thinking about this some more, I don't think this works. I'm relying
on vma_start_read() to stabilize the vma, however the lock I'm taking
is part of the vma which can be reused from under us. So, the lock I'm
taking might be reinitialized after I take the lock...
I need to figure out a way to stabilize the vma in some other manner
before taking this lock.

> Add this missing check into lock_vma_under_rcu() and change vma cache
> to include SLAB_TYPESAFE_BY_RCU. This will facilitate vm_area_struct
> reuse and will minimize the number of call_rcu() calls.
> Adding vm_freeptr into vm_area_struct avoids bloating that structure.
> lock_vma_under_rcu() checks of the detached flag guarantees that vma
> is valid and attached to a tree, therefore unioning vm_freeptr with
> vm_start/vm_end is not an issue even though lock_vma_under_rcu() is
> using them.
> As part of this change freeptr_t declaration is moved into mm_types.h
> to avoid circular dependencies between mm_types.h and slab.h.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm_types.h | 10 +++++++---
>  include/linux/slab.h     |  6 ------
>  kernel/fork.c            | 29 +++++++++++++----------------
>  mm/memory.c              |  2 +-
>  4 files changed, 21 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5c4bfdcfac72..37580cc7bec0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -32,6 +32,12 @@
>  struct address_space;
>  struct mem_cgroup;
>
> +/*
> + * freeptr_t represents a SLUB freelist pointer, which might be encoded
> + * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> + */
> +typedef struct { unsigned long v; } freeptr_t;
> +
>  /*
>   * Each physical page in the system has a struct page associated with
>   * it to keep track of whatever it is we are using the page for at the
> @@ -673,9 +679,7 @@ struct vm_area_struct {
>                         unsigned long vm_start;
>                         unsigned long vm_end;
>                 };
> -#ifdef CONFIG_PER_VMA_LOCK
> -               struct rcu_head vm_rcu; /* Used for deferred freeing. */
> -#endif
> +               freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY=
_RCU */
>         };
>
>         /*
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b35e2db7eb0e..cb45db2402ac 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -212,12 +212,6 @@ enum _slab_flag_bits {
>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
>  #endif
>
> -/*
> - * freeptr_t represents a SLUB freelist pointer, which might be encoded
> - * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> - */
> -typedef struct { unsigned long v; } freeptr_t;
> -
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7823797e31d2..946c3f9a9342 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -478,25 +478,15 @@ void __vm_area_free(struct vm_area_struct *vma)
>         kmem_cache_free(vm_area_cachep, vma);
>  }
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -static void vm_area_free_rcu_cb(struct rcu_head *head)
> +void vm_area_free(struct vm_area_struct *vma)
>  {
> -       struct vm_area_struct *vma =3D container_of(head, struct vm_area_=
struct,
> -                                                 vm_rcu);
> -
> +#ifdef CONFIG_PER_VMA_LOCK
> +       /* The vma should be detached while being destroyed. */
> +       VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
>         /* The vma should not be locked while being destroyed. */
>         VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
> -       __vm_area_free(vma);
> -}
>  #endif
> -
> -void vm_area_free(struct vm_area_struct *vma)
> -{
> -#ifdef CONFIG_PER_VMA_LOCK
> -       call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
> -#else
>         __vm_area_free(vma);
> -#endif
>  }
>
>  static void account_kernel_stack(struct task_struct *tsk, int account)
> @@ -3115,6 +3105,11 @@ void __init mm_cache_init(void)
>
>  void __init proc_caches_init(void)
>  {
> +       struct kmem_cache_args args =3D {
> +               .use_freeptr_offset =3D true,
> +               .freeptr_offset =3D offsetof(struct vm_area_struct, vm_fr=
eeptr),
> +       };
> +
>         sighand_cachep =3D kmem_cache_create("sighand_cache",
>                         sizeof(struct sighand_struct), 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
> @@ -3131,9 +3126,11 @@ void __init proc_caches_init(void)
>                         sizeof(struct fs_struct), 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>                         NULL);
> -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct,
> -                       SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> +       vm_area_cachep =3D kmem_cache_create("vm_area_struct",
> +                       sizeof(struct vm_area_struct), &args,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
>                         SLAB_ACCOUNT);
> +
>         mmap_init();
>         nsproxy_cache_init();
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index d0197a0c0996..9c414c81f14a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
>                 goto inval;
>
>         /* Check if the VMA got isolated after we found it */
> -       if (is_vma_detached(vma)) {
> +       if (is_vma_detached(vma) || vma->vm_mm !=3D mm) {
>                 vma_end_read(vma);
>                 count_vm_vma_lock_event(VMA_LOCK_MISS);
>                 /* The area was replaced with another one */
> --
> 2.47.0.277.g8800431eea-goog
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

