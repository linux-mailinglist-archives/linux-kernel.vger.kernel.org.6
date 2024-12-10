Return-Path: <linux-kernel+bounces-439924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37969EB628
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F34161F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B11BBBFE;
	Tue, 10 Dec 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jul2tfis"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711E1AAA0E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847818; cv=none; b=RHY2to3h5EtIu41eH5lHLW7+zobHm5Sm0mDrrSxVLveagFuI4uQha7vdXTmjMz3LMtZ3Im74hRhDW9H/MbczlzDCORfC2AbxRwKbEqPLYnmpIm1A3vR87OQYsexbkcakIzI7//ZJUvbqitsmFPourSJnY3A+lSvLYqin+ihICAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847818; c=relaxed/simple;
	bh=EgNAnZt/X6+3EynJv3E+SWObqbPol4gEyTlUiv5uDO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/gOMS1Q7faTj08DZb8K7GW7zR51vsUyIU9PSArSsnBZsR1EbQE9uJbKhZYcY0rV2wigb5yAmqAmRV9mKXra5fU243PqZSrSOAY44k86gN3Q7zPc8Tb6ywIe/9VPdf5ZAIcFVvuRjFGL8EmN5dSkkHW0Bex+RGhpDHHNxinpL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jul2tfis; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4674c22c4afso299571cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733847814; x=1734452614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+EjMlFhXDunShDRcDP0ShIng5wdn8oOvu3uP5ozI5o=;
        b=Jul2tfisS/nc6wcFLQjAIhrTuNMojMzkxqZkb80Y9iQJUN21XUTOSCzYnBoXBn2Nds
         vBTLeqDqJz+LIFoxPCMcFJ3aNS5hHUUJ9IoYQYsB8yN4JgcWMxhV1yuFs4OxDD+LKZnq
         4F1wXz7LWNr1LM7I9Nwm4cDtAZXbOfxFjpscirw/Waf9mGbsIU34laSYkqaMOeXSAFlQ
         UhOq71IwjUR44cDcJtDjq8NPAhL40NGlw6o+KtlbF1bKsDsL9KAuRMKpyUw8zkf6pATB
         O0XcKUGuWo7RqpPpK8xku+XmMEtMcjcQIOl3sCEuJ7YswvWUE5T8EACbMyFkZL06E1kT
         vT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847814; x=1734452614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+EjMlFhXDunShDRcDP0ShIng5wdn8oOvu3uP5ozI5o=;
        b=TAZyR9DqC9TXg2JypfoMGr5DkJapFMJ/cfOsOmMEkVFCvYAPPsi5W3aSIVI9ZNqFU9
         P28TWSSc7usXdh5ciW+rS3zXP46kUYxB6RH0uAZMwdfESWKgHA4Dynnl81FaPjDLOUJc
         EHGvOR4Nye8zN5VDnKdTfPC05kGsdrcA9QlxvjhtWHVqI1afgExeRbLwMwEKJ1IyuZsq
         G9iM6AJsJT/+cFDw7Lbi6iiAb8r4tGwWnOePLW6Xqcxof2GWC+ruyvif7fvZ0NMmhC3r
         hhzRsw4MSYjJ9KzjEiTsum/c3/DKbFjaH7qsIEBqPdX3+ZKAEptv0Tr75bBO9Ud0zowp
         tXtA==
X-Forwarded-Encrypted: i=1; AJvYcCXhysMnkCVq3CWFsGetMNmdhIHHYazZfs7uoN2rOEDoJbp51ca0Q+3zgABgN762jW1blqW2amWh+AxSDfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDYtFvHNZOxrtGi+tPoszQSm8PytZqNoxQg5bZNlP1ZrcJql8
	KPqEnFFBypg0Xn90GcXO41ypfttRym0VDji2BoS/zu/ZcMSaYCULHgXC0zF2gU7oaZoJzi2C8hh
	Pip3prRHyxORGECQiVhuJbTdBCoVW3vtVGd2l
X-Gm-Gg: ASbGncuEqNlv/mZ3X7CB652GLsLTs8klUqPQ9l/O+wKe9V2DksyF2YhlaYqF1jN40Ll
	BHYwoQQeXoQE+NKM0ku0DofAgzFD5OZ0v5RQgANRoGkai6jwuSMEfTjgdD0XETL3z5Q==
X-Google-Smtp-Source: AGHT+IEOXgRpOlgsb1NGKHvnvi+3D5vXYnKehzcgJVuWcqYg9JXGMb6VpYKVRgpdRgZJFhzDzTjw+1bk5bdlflK5QZU=
X-Received: by 2002:a05:622a:4c18:b0:466:97d6:b245 with SMTP id
 d75a77b69052e-46776274fdamr4711171cf.22.1733847813416; Tue, 10 Dec 2024
 08:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com> <20241206225204.4008261-5-surenb@google.com>
 <9f000fbf-b5c4-41f5-8a4a-9c78b37c2ec5@suse.cz>
In-Reply-To: <9f000fbf-b5c4-41f5-8a4a-9c78b37c2ec5@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 08:23:22 -0800
Message-ID: <CAJuCfpFn-MTSVb30e1q0xVbLgURdZibePFbPDLyKNrjeTHkRfQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:06=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/6/24 23:52, Suren Baghdasaryan wrote:
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
> > it is locked, then attached at a new address or to a new mm while
> > read-locked;
> > For case #1 current checks will help detecting cases when:
> > - vma was reused but not yet added into the tree (detached check)
> > - vma was reused at a different address range (address check);
> > We are missing the check for vm_mm to ensure the reused vma was not
> > attached to a different mm. This patch adds the missing check.
> > For case #2, we pass mm to vma_start_read() to prevent access to
> > unstable vma->vm_mm. This might lead to vma_start_read() returning
> > a false locked result but that's not critical if it's rare because
> > it will only lead to a retry under mmap_lock.
> > For case #3, we ensure the order in which vma->detached flag and
> > vm_start/vm_end/vm_mm are set and checked. vma gets attached after
> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
> > vma->detached before checking vm_start/vm_end/vm_mm. This is required
> > because attaching vma happens without vma write-lock, as opposed to
> > vma detaching, which requires vma write-lock. This patch adds memory
> > barriers inside is_vma_detached() and vma_mark_attached() needed to
> > order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep=
.
> > This will facilitate vm_area_struct reuse and will minimize the number
> > of call_rcu() calls.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h               |  36 +++++--
> >  include/linux/mm_types.h         |  10 +-
> >  include/linux/slab.h             |   6 --
> >  kernel/fork.c                    | 157 +++++++++++++++++++++++++------
> >  mm/memory.c                      |  15 ++-
> >  mm/vma.c                         |   2 +-
> >  tools/testing/vma/vma_internal.h |   7 +-
> >  7 files changed, 179 insertions(+), 54 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 2bf38c1e9cca..3568bcbc7c81 100644
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
> > @@ -706,8 +706,10 @@ static inline void vma_lock_init(struct vm_area_st=
ruct *vma)
> >   * Try to read-lock a vma. The function is allowed to occasionally yie=
ld false
> >   * locked result to avoid performance overhead, in which case we fall =
back to
> >   * using mmap_lock. The function should never yield false unlocked res=
ult.
> > + * False locked result is possible if mm_lock_seq overflows or if vma =
gets
> > + * reused and attached to a different mm before we lock it.
> >   */
> > -static inline bool vma_start_read(struct vm_area_struct *vma)
> > +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area=
_struct *vma)
> >  {
> >       /*
> >        * Check before locking. A race might cause false locked result.
> > @@ -716,7 +718,7 @@ static inline bool vma_start_read(struct vm_area_st=
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
> > @@ -733,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_st=
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
>
> This could have been perhaps another preparatory patch to make this one s=
maller?
>
> >
> > +static void vm_area_ctor(void *data)
> > +{
> > +     struct vm_area_struct *vma =3D (struct vm_area_struct *)data;
> > +
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     vma->detached =3D true;
> > +#endif
> > +     INIT_LIST_HEAD(&vma->anon_vma_chain);
> > +     vma_lock_init(vma);
> > +}
> > +
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static void vma_clear(struct vm_area_struct *vma, struct mm_struct *mm=
)
> > +{
> > +     vma->vm_mm =3D mm;
> > +     vma->vm_ops =3D &vma_dummy_vm_ops;
> > +     vma->vm_start =3D 0;
> > +     vma->vm_end =3D 0;
> > +     vma->anon_vma =3D NULL;
> > +     vma->vm_pgoff =3D 0;
> > +     vma->vm_file =3D NULL;
> > +     vma->vm_private_data =3D NULL;
> > +     vm_flags_init(vma, 0);
> > +     memset(&vma->vm_page_prot, 0, sizeof(vma->vm_page_prot));
> > +     memset(&vma->shared, 0, sizeof(vma->shared));
> > +     memset(&vma->vm_userfaultfd_ctx, 0, sizeof(vma->vm_userfaultfd_ct=
x));
> > +     vma_numab_state_init(vma);
> > +#ifdef CONFIG_ANON_VMA_NAME
> > +     vma->anon_name =3D NULL;
> > +#endif
> > +#ifdef CONFIG_SWAP
> > +     memset(&vma->swap_readahead_info, 0, sizeof(vma->swap_readahead_i=
nfo));
> > +#endif
> > +#ifndef CONFIG_MMU
> > +     vma->vm_region =3D NULL;
> > +#endif
> > +#ifdef CONFIG_NUMA
> > +     vma->vm_policy =3D NULL;
> > +#endif
>
> This isn't the ideal pattern I think, now that we have a ctor. Ideally th=
e
> ctor would do all this (except setting the vm_mm), and then we need to ma=
ke
> sure it's also done when freeing the vma, to make sure the freed object i=
s
> in the same state as a new object after the constructor.
>
> On freeing, things like numab_state and anon_name could be NULL'd (by the
> respective destructors) only when they are non-NULL and thus freeing the
> objects pointed to. vm_policy and vm_file could perhaps be handled same w=
ay
> after some refactoring (see remove_vma()), vma_dummy_vm_ops are possibly
> already reset by vma_close(), etc.

Ok, let me look some more into it and see if I can improve and
simplify the initialization/freeing logic. Thanks!

>
> > +}
> > +
> > +static void vma_copy(const struct vm_area_struct *src, struct vm_area_=
struct *dest)
> > +{
> > +     dest->vm_mm =3D src->vm_mm;
> > +     dest->vm_ops =3D src->vm_ops;
> > +     dest->vm_start =3D src->vm_start;
> > +     dest->vm_end =3D src->vm_end;
> > +     dest->anon_vma =3D src->anon_vma;
> > +     dest->vm_pgoff =3D src->vm_pgoff;
> > +     dest->vm_file =3D src->vm_file;
> > +     dest->vm_private_data =3D src->vm_private_data;
> > +     vm_flags_init(dest, src->vm_flags);
> > +     memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > +            sizeof(dest->vm_page_prot));
> > +     memcpy(&dest->shared, &src->shared, sizeof(dest->shared));
> > +     memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > +            sizeof(dest->vm_userfaultfd_ctx));
> > +#ifdef CONFIG_ANON_VMA_NAME
> > +     dest->anon_name =3D src->anon_name;
> > +#endif
> > +#ifdef CONFIG_SWAP
> > +     memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > +            sizeof(dest->swap_readahead_info));
> > +#endif
> > +#ifndef CONFIG_MMU
> > +     dest->vm_region =3D src->vm_region;
> > +#endif
> > +#ifdef CONFIG_NUMA
> > +     dest->vm_policy =3D src->vm_policy;
> > +#endif
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */

