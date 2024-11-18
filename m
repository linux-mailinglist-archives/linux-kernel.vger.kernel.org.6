Return-Path: <linux-kernel+bounces-413205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E319D150C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022F4284D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797011BD007;
	Mon, 18 Nov 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLiUgEew"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195C1BBBC0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946024; cv=none; b=MVxLaa7PIxYgdRcSIy8cpH2l/BK1gKMlbKkW0cO1WChS8C82Gke0QW7jIAYr5vfdPvJmS3BOXTwTOhTW5JxgK4nCnKBUHQvgB8AbduJEJnKLFmIaXfkFXlx3AK/7zx2xGjF4+r4g/91TjAXK8tULNs3HYqntHqQ+wOlhXK7kVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946024; c=relaxed/simple;
	bh=mYnGK6HZeiYQQdmA8GANwNGIb8x+ssVtf5ucrUGsho4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er3huWvYG5UIq6NhYWDIXuT0OBz37IXGIrX5zkAIYpG2Sw21KLhJxethh3rvdld50++gBBOlY1grTSvLbfm6vXyZPuyEa3vfTMajwj/diCN933HsSN2JH0mT23Qof65NAy5c6xinV9vxScyT5AsgzvqNO7S9/Pqblvc6Sz/iXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLiUgEew; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460a8d1a9b7so498611cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731946021; x=1732550821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUW0v7iNCbEBUtn6m2qdPUspoqtSmKt5JStX2iAU/JQ=;
        b=bLiUgEewTEYqm000d9nLnLTh9TfVzkJOAWwYZ2UA++e9arUnWv+66Qoh6w6M+J8jmU
         f9mQEmWT/HrIhsS42z4wYailtOlYSPEWmgHUqH4VGhGyu0PZvKXK5F68pZYCAYOo7mEL
         qDhj8joE6UczAM7qH9r9vGtiv8A8yF//ZIobEnk0tTDYM8O4eZEv0JMMaCYbWAoco5gw
         GgNyHDuPSbURyVu3FD+LAn7XXmlz1xx1vn0Vg9ivNUucl2yC0BfiB0SWtZDQN/gu1hHN
         VOJmknguJBX32T2CBokaDjF7Y657BYRfqxiczY1Be6yHEnXgEJ1mHTCdfjWt7tVPjnqN
         uZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946021; x=1732550821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUW0v7iNCbEBUtn6m2qdPUspoqtSmKt5JStX2iAU/JQ=;
        b=D4z2QnXIDnSBZqi3mq465cYWLa6dCUiM2Kf/7RDunCijzRO4aNAqdwi/FefoRb97Vz
         UxDzzm1TNC5Oy7T+TXLrTLgU5EwR1zY1yGUI3nwskuCCXRSWfmCtr7CBv/tlY9mJsv7n
         wQDwcmgalqpLiIWAPC9OXNg2VrcHArAxAwscF6LRYZFMDxxgKqrC7oElYATvQLejif00
         KVzL8NF+BIo58xailVWUNQrKk9zbvixj+CHBCrrnZXUXWz1yW9XGKIV0ilrCFVjdN93k
         1Qbw4SEbz/ZBUrah8W+ydIbR+tfbzFPyGOMV4F82ZfHyh9pvdqkRIZ4V8Fa4y7+9w/b8
         g1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXIHOXL9PZSxGpqByMpyCMIkt5mad1np8orSJ98XXni9WEFIwMBYimWp30bYdItlWKt+9gISaJZAXk/teg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbbDlNuiCAx+qHW5JZqMcxP1Xw8WIszYkPVctP5yBca8pyHE2
	i+UBROo/POJtUON9uYG3VsaRzzTBOBu5vUzkBY97KvBIy2uIl8CfsqcJisufPv5buhQTr4LF4P8
	j2cll3LwvuOH3Z5pnPFmn8Xy8tufANetZAHHe
X-Gm-Gg: ASbGncu0Ne6OUesDr6YFjXDh0tdhVdoLyPgrwsoTsYySXiQyYmXwoN4CWlWDknGmGqj
	GZ3fjVeVrCesc5SYz9GiwmxYJ1ATLLyE=
X-Google-Smtp-Source: AGHT+IGaAEqKEeXTj9xm701ve2v7Iwo99vI6vVbzj9JO4WVeBxRPYSho9TdqF72lZEWWLeze6ef5Whpyx6+/KnFTgjo=
X-Received: by 2002:ac8:7e8e:0:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-463701f74f9mr6410121cf.28.1731946020120; Mon, 18 Nov 2024
 08:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117080931.600731-1-surenb@google.com> <20241117080931.600731-5-surenb@google.com>
 <6d010369-c0aa-458a-8b08-c14febea2f5f@lucifer.local>
In-Reply-To: <6d010369-c0aa-458a-8b08-c14febea2f5f@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Nov 2024 08:06:49 -0800
Message-ID: <CAJuCfpGC3oTbA--nX6AXU2BGC5yeohCFh4qY-=n2T145WpvHrA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:06=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Sun, Nov 17, 2024 at 12:09:30AM -0800, Suren Baghdasaryan wrote:
> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> > object reuse before RCU grace period is over will be detected inside
> > lock_vma_under_rcu().
> > lock_vma_under_rcu() enters RCU read section, finds the vma at the
> > given address, locks the vma and checks if it got detached or remapped
> > to cover a different address range. These last checks are there
> > to ensure that the vma was not modified after we found it but before
> > locking it.
> > vma reuse introduces several new possibilities:
> > 1. vma can be reused after it was found but before it is locked;
> > 2. vma can be reused and reinitialized (including changing its vm_mm)
> > while being locked in vma_start_read();
> > 3. vma can be reused and reinitialized after it was found but before
> > it is locked, then attached at a new address or to a new mm while being
> > read-locked;
> > For case #1 current checks will help detecting cases when:
> > - vma was reused but not yet added into the tree (detached check)
> > - vma was reused at a different address range (address check);
> > We are missing the check for vm_mm to ensure the reused vma was not
> > attached to a different mm. This patch adds the missing check.
> > For case #2, we pass mm to vma_start_read() to prevent access to
> > unstable vma->vm_mm.
> > For case #3, we write-lock the vma in vma_mark_attached(), ensuring tha=
t
> > vma does not get re-attached while read-locked by a user of the vma
> > before it was recycled.
> > This write-locking should not cause performance issues because contenti=
on
> > during vma_mark_attached() can happen only in the rare vma reuse case.
> > Even when this happens, it's the slowpath (write-lock) which will be
> > waiting, not the page fault path.
> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep=
.
> > This will facilitate vm_area_struct reuse and will minimize the number
> > of call_rcu() calls.
> > Adding a freeptr_t into vm_area_struct (unioned with vm_start/vm_end)
> > could be used to avoids bloating the structure, however currently
> > custom free pointers are not supported in combination with a ctor
> > (see the comment for kmem_cache_args.freeptr_offset).
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I've stayed out of this discussion as my slab knowledge is far less than
> others (e.g. Vlastimil), but I shazam'd this series today and the kernel
> isn't booting on my qemu setup, and I bisected it to this commit, and an
> addr2line decode tells me this is:
>
> static inline void vma_mark_attached(struct vm_area_struct *vma)
> {
>         /* vma shoudn't be already attached */
>         VM_BUG_ON_VMA(!vma->detached, vma); <-------- here
>
>         ...
> }
>
> And if I go back to prior commits, this triggers too, since "mm: mark vma
> as detached until it's added into vma tree".
>
> I don't think this check should be added in this commit at any rate, it
> should be added in "mm: mark vma as detached until it's added into vma
> tree".

Agree, that patch is a better place to add this check and probably
locking as well. I think I know why I didn't catch this assertion in
my testing and how to fix it.

>
> I will go to that commit to continue this investigation, but we should
> definitely move that check over there.

Will reply to your comments in that commit.

>
> > ---
> >  include/linux/mm.h               | 48 ++++++++++++++++++++++++-----
> >  include/linux/mm_types.h         | 13 +++-----
> >  kernel/fork.c                    | 53 +++++++++++++++++++-------------
> >  mm/memory.c                      |  7 +++--
> >  mm/vma.c                         |  2 +-
> >  tools/testing/vma/vma_internal.h |  7 +++--
> >  6 files changed, 86 insertions(+), 44 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index dd1b6190df28..d8e10e1e34ad 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -257,7 +257,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_stru=
ct *);
> >  struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
> >  void vm_area_free(struct vm_area_struct *);
> >  /* Use only if VMA has no other users */
> > -void __vm_area_free(struct vm_area_struct *vma);
> > +void vm_area_free_unreachable(struct vm_area_struct *vma);
> >
> >  #ifndef CONFIG_MMU
> >  extern struct rb_root nommu_region_tree;
> > @@ -690,12 +690,32 @@ static inline void vma_lock_init(struct vm_area_s=
truct *vma)
> >       vma->vm_lock_seq =3D UINT_MAX;
> >  }
> >
> > +#define VMA_BEFORE_LOCK              offsetof(struct vm_area_struct, v=
m_lock)
> > +#define VMA_LOCK_END(vma)    \
> > +     (((void *)(vma)) + offsetofend(struct vm_area_struct, vm_lock))
> > +#define VMA_AFTER_LOCK               \
> > +     (sizeof(struct vm_area_struct) - offsetofend(struct vm_area_struc=
t, vm_lock))
> > +
> > +static inline void vma_clear(struct vm_area_struct *vma)
> > +{
> > +     /* Preserve vma->vm_lock */
> > +     memset(vma, 0, VMA_BEFORE_LOCK);
> > +     memset(VMA_LOCK_END(vma), 0, VMA_AFTER_LOCK);
> > +}
> > +
> > +static inline void vma_copy(struct vm_area_struct *new, struct vm_area=
_struct *orig)
> > +{
> > +     /* Preserve vma->vm_lock */
> > +     data_race(memcpy(new, orig, VMA_BEFORE_LOCK));
> > +     data_race(memcpy(VMA_LOCK_END(new), VMA_LOCK_END(orig), VMA_AFTER=
_LOCK));
> > +}
> > +
> >  /*
> >   * Try to read-lock a vma. The function is allowed to occasionally yie=
ld false
> >   * locked result to avoid performance overhead, in which case we fall =
back to
> >   * using mmap_lock. The function should never yield false unlocked res=
ult.
> >   */
> > -static inline bool vma_start_read(struct vm_area_struct *vma)
> > +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area=
_struct *vma)
> >  {
> >       /*
> >        * Check before locking. A race might cause false locked result.
> > @@ -704,7 +724,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >        * we don't rely on for anything - the mm_lock_seq read against w=
hich we
> >        * need ordering is below.
> >        */
> > -     if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq.sequence))
> > +     if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.=
sequence))
> >               return false;
> >
> >       if (unlikely(down_read_trylock(&vma->vm_lock.lock) =3D=3D 0))
> > @@ -721,7 +741,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >        * after it has been unlocked.
> >        * This pairs with RELEASE semantics in vma_end_write_all().
> >        */
> > -     if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->vm_m=
m->mm_lock_seq))) {
> > +     if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&mm->mm_lo=
ck_seq))) {
> >               up_read(&vma->vm_lock.lock);
> >               return false;
> >       }
> > @@ -810,7 +830,18 @@ static inline void vma_assert_locked(struct vm_are=
a_struct *vma)
> >
> >  static inline void vma_mark_attached(struct vm_area_struct *vma)
> >  {
> > +     /* vma shoudn't be already attached */
> > +     VM_BUG_ON_VMA(!vma->detached, vma);
> > +
> > +     /*
> > +      * Lock here can be contended only if the vma got reused after
> > +      * lock_vma_under_rcu() found it but before it had a chance to
> > +      * read-lock it. Write-locking the vma guarantees that the vma
> > +      * won't be attached until all its old users are out.
> > +      */
> > +     down_write(&vma->vm_lock.lock);
> >       vma->detached =3D false;
> > +     up_write(&vma->vm_lock.lock);
> >  }
> >
> >  static inline void vma_mark_detached(struct vm_area_struct *vma)
> > @@ -847,7 +878,11 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void vma_lock_init(struct vm_area_struct *vma) {}
> > -static inline bool vma_start_read(struct vm_area_struct *vma)
> > +static inline void vma_clear(struct vm_area_struct *vma)
> > +             { memset(vma, 0, sizeof(*vma)); }
> > +static inline void vma_copy(struct vm_area_struct *new, struct vm_area=
_struct *orig)
> > +             { data_race(memcpy(new, orig, sizeof(*new))); }
> > +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area=
_struct *vma)
> >               { return false; }
> >  static inline void vma_end_read(struct vm_area_struct *vma) {}
> >  static inline void vma_start_write(struct vm_area_struct *vma) {}
> > @@ -883,7 +918,7 @@ extern const struct vm_operations_struct vma_dummy_=
vm_ops;
> >
> >  static inline void vma_init(struct vm_area_struct *vma, struct mm_stru=
ct *mm)
> >  {
> > -     memset(vma, 0, sizeof(*vma));
> > +     vma_clear(vma);
> >       vma->vm_mm =3D mm;
> >       vma->vm_ops =3D &vma_dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > @@ -892,7 +927,6 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
> >       vma->detached =3D true;
> >  #endif
> >       vma_numab_state_init(vma);
> > -     vma_lock_init(vma);
> >  }
> >
> >  /* Use when VMA is not part of the VMA tree and needs no locking */
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5c4bfdcfac72..8f6b0c935c2b 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -667,15 +667,10 @@ struct vma_numab_state {
> >  struct vm_area_struct {
> >       /* The first cache line has the info for VMA tree walking. */
> >
> > -     union {
> > -             struct {
> > -                     /* VMA covers [vm_start; vm_end) addresses within=
 mm */
> > -                     unsigned long vm_start;
> > -                     unsigned long vm_end;
> > -             };
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -             struct rcu_head vm_rcu; /* Used for deferred freeing. */
> > -#endif
> > +     struct {
> > +             /* VMA covers [vm_start; vm_end) addresses within mm */
> > +             unsigned long vm_start;
> > +             unsigned long vm_end;
> >       };
> >
> >       /*
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index f0cec673583c..76c68b041f8a 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -436,6 +436,11 @@ static struct kmem_cache *vm_area_cachep;
> >  /* SLAB cache for mm_struct structures (tsk->mm) */
> >  static struct kmem_cache *mm_cachep;
> >
> > +static void vm_area_ctor(void *data)
> > +{
> > +     vma_lock_init(data);
> > +}
> > +
> >  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> >  {
> >       struct vm_area_struct *vma;
> > @@ -462,8 +467,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_s=
truct *orig)
> >        * orig->shared.rb may be modified concurrently, but the clone
> >        * will be reinitialized.
> >        */
> > -     data_race(memcpy(new, orig, sizeof(*new)));
> > -     vma_lock_init(new);
> > +     vma_copy(new, orig);
> >       INIT_LIST_HEAD(&new->anon_vma_chain);
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       /* vma is not locked, can't use vma_mark_detached() */
> > @@ -475,32 +479,37 @@ struct vm_area_struct *vm_area_dup(struct vm_area=
_struct *orig)
> >       return new;
> >  }
> >
> > -void __vm_area_free(struct vm_area_struct *vma)
> > +static void __vm_area_free(struct vm_area_struct *vma, bool unreachabl=
e)
> >  {
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /*
> > +      * With SLAB_TYPESAFE_BY_RCU, vma can be reused and we need
> > +      * vma->detached to be set before vma is returned into the cache.
> > +      * This way reused object won't be used by readers until it's
> > +      * initialized and reattached.
> > +      * If vma is unreachable, there can be no other users and we
> > +      * can set vma->detached directly with no risk of a race.
> > +      * If vma is reachable, then it should have been already detached
> > +      * under vma write-lock or it was never attached.
> > +      */
> > +     if (unreachable)
> > +             vma->detached =3D true;
> > +     else
> > +             VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
> > +#endif
> >       vma_numab_state_free(vma);
> >       free_anon_vma_name(vma);
> >       kmem_cache_free(vm_area_cachep, vma);
> >  }
> >
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -static void vm_area_free_rcu_cb(struct rcu_head *head)
> > +void vm_area_free(struct vm_area_struct *vma)
> >  {
> > -     struct vm_area_struct *vma =3D container_of(head, struct vm_area_=
struct,
> > -                                               vm_rcu);
> > -
> > -     /* The vma should not be locked while being destroyed. */
> > -     VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
> > -     __vm_area_free(vma);
> > +     __vm_area_free(vma, false);
> >  }
> > -#endif
> >
> > -void vm_area_free(struct vm_area_struct *vma)
> > +void vm_area_free_unreachable(struct vm_area_struct *vma)
> >  {
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -     call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
> > -#else
> > -     __vm_area_free(vma);
> > -#endif
> > +     __vm_area_free(vma, true);
> >  }
> >
> >  static void account_kernel_stack(struct task_struct *tsk, int account)
> > @@ -3135,9 +3144,11 @@ void __init proc_caches_init(void)
> >                       sizeof(struct fs_struct), 0,
> >                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> >                       NULL);
> > -     vm_area_cachep =3D KMEM_CACHE(vm_area_struct,
> > -                     SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> > -                     SLAB_ACCOUNT);
> > +     vm_area_cachep =3D kmem_cache_create("vm_area_struct",
> > +                     sizeof(struct vm_area_struct), 0,
> > +                     SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
> > +                     SLAB_ACCOUNT, vm_area_ctor);
> > +
> >       mmap_init();
> >       nsproxy_cache_init();
> >  }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d0197a0c0996..c8a3e820ed66 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6275,7 +6275,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >       if (!vma)
> >               goto inval;
> >
> > -     if (!vma_start_read(vma))
> > +     if (!vma_start_read(mm, vma))
> >               goto inval;
> >
> >       /* Check if the VMA got isolated after we found it */
> > @@ -6292,8 +6292,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >        * fields are accessible for RCU readers.
> >        */
> >
> > -     /* Check since vm_start/vm_end might change before we lock the VM=
A */
> > -     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> > +     /* Check since vm_mm/vm_start/vm_end might change before we lock =
the VMA */
> > +     if (unlikely(vma->vm_mm !=3D mm ||
> > +                  address < vma->vm_start || address >=3D vma->vm_end)=
)
> >               goto inval_end_read;
> >
> >       rcu_read_unlock();
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 73104d434567..050b83df3df2 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -382,7 +382,7 @@ void remove_vma(struct vm_area_struct *vma, bool un=
reachable)
> >               fput(vma->vm_file);
> >       mpol_put(vma_policy(vma));
> >       if (unreachable)
> > -             __vm_area_free(vma);
> > +             vm_area_free_unreachable(vma);
> >       else
> >               vm_area_free(vma);
> >  }
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index 2fed366d20ef..fd668d6cafc0 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -632,14 +632,15 @@ static inline void mpol_put(struct mempolicy *)
> >  {
> >  }
> >
> > -static inline void __vm_area_free(struct vm_area_struct *vma)
> > +static inline void vm_area_free(struct vm_area_struct *vma)
> >  {
> >       free(vma);
> >  }
> >
> > -static inline void vm_area_free(struct vm_area_struct *vma)
> > +static inline void vm_area_free_unreachable(struct vm_area_struct *vma=
)
> >  {
> > -     __vm_area_free(vma);
> > +     vma->detached =3D true;
> > +     vm_area_free(vma);
> >  }
> >
> >  static inline void lru_add_drain(void)
> > --
> > 2.47.0.338.g60cca15819-goog
> >

