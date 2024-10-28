Return-Path: <linux-kernel+bounces-383924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE9B9B21FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE8C2819B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBECF14386D;
	Mon, 28 Oct 2024 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJQ+uayN"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE213C809
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078694; cv=none; b=eyTZg9cphgM7yl7VETrSK7x/wAE+jTv60KAUjFyrV2/cNdI9zPw2SoHElgAaLbZmI0InJSkkyhHWvmaTgY4wo41LNJyGeOb+8szop1vH/9eF2LvsoDQ9hbt6m7EzASCur95n/0YvIUtxg6uodOIclE+5DxtO8ow3R0BLBxZmUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078694; c=relaxed/simple;
	bh=LP0FyuTled8ds4HR6JxGYJ/reSG/B5k9XR2IgJXVMz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCN1ZR2YiLuzadV4t+NvQ2ouxiL+bbW1ZG6Zp+fi4kS50h0YGIoM+wkzapvLmrjsGme5iB5Rua0NdrK7pIzVuCa///DmWquashPJd7duj7HwI+f3DQVQOoy8j3A7GFb10Vde8bqgAvTHFu8M0lJdSd+CBW0Ugj0dxp5YqRa91gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJQ+uayN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7203c431f93so2960803b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078690; x=1730683490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTs1iHW13ccnL4FX3KYPNOsHUWdayjp3Yw3+RlaAtxU=;
        b=eJQ+uayN0G1UI5peym2xZaSe2iEDLV7sVdLC0TElSkQeBztKbpIoCp1QUBwtmhgZQo
         uSeqHxi4+yw9XNGMoDqJyXAMp8/W8fJzXMPyu5CLapRNSG4sj8TAogQC0zjDCxeMs7Ee
         vKfJiO10cNjDETvxrgq4LlJlJTgdgby2y3dAsFZA0U9TaziOnywud6aeyh0WTV3uU9YH
         T8g9b1XwncBZu9UMOIOE8a5PnNW7EnAKOi6Ewt8AmrIyxlPjI9/hdNeAHaqFAiRrb2NR
         h+ksho0KKDfB1MNSlSQnJ0rS168UNizU7vNIsvB8D7sI8QxVy17stL9Go3eaZFYTqj2X
         dLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078690; x=1730683490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTs1iHW13ccnL4FX3KYPNOsHUWdayjp3Yw3+RlaAtxU=;
        b=M1YDBEacU2UCFcwbH8tkR3FeO0VWAzruhVngIomrnxZ8GV3MTn2xxJbg2EdcWw/h9j
         TqFlW3ohDJMQ/dRQMV+Ltk2JIHqlAbazo1Ds38jmj1cDl1QM41xgdmEQ/s7gXcorfXRv
         Byvde6YZvmPcaVZCV5DPPhpT6Or/m86VVQkRBnRVcxcaFaoExHHSevxk4GXXffDHYsx5
         hktAbnLwwHsnmSbJrgndpn7JmMBNr5jy9RUZhKo2Q6+i0QO7zWtfN4ikkaFWt0s7WMe/
         tZ8v9DbkzucTpmAthWuk+f9YcpCl7/ypiW51qH/t9v2HNAS4VHQD+xLcBK02fFlN08st
         +iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2ON9Xby9t5hRpFr5VLRhB0zDBJw5tmeusJlJ5pSTAYoHvoeWAMpU83nbRlmsBKKQjQ0Odd1ydMFNIDnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkTPVd/emIcbS0h9mHOEuDo4aLslLVsh60zJRHOIF9GzR0zJw
	HzG2ntihkAXtpPqvCmO9VCl5sxO1WMgNVs3FbgipVCVoSYJoG75rkVNodRYhfpMbgE/U4/hoz6H
	2iM/CWjuDBI4BOous7NCOFQmRqE8=
X-Google-Smtp-Source: AGHT+IFt4Fi0i5Lp2y2vWOlife4xrjbN8KHPBWvK1ZJSw+VxXnWEO/gPUq00+dH9sW9TjD0Rx3eVVVssn9iyTUNqDxc=
X-Received: by 2002:a05:6a21:1707:b0:1d9:b48:8b0b with SMTP id
 adf61e73a8af0-1d9a83b53abmr10228379637.5.1730078690511; Sun, 27 Oct 2024
 18:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205231.1944747-1-surenb@google.com> <CAEf4BzZvFFXByMS-eyFZzt7055MHexT2h0FfKfSN83x_jYTZEg@mail.gmail.com>
In-Reply-To: <CAEf4BzZvFFXByMS-eyFZzt7055MHexT2h0FfKfSN83x_jYTZEg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 27 Oct 2024 18:24:38 -0700
Message-ID: <CAEf4BzYi7jE39NSBeEk3_ytDhDGrvQEN67qWR=-TpzSiJfQGWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: convert mm_lock_seq to a proper seqcount
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org, 
	jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 5:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 24, 2024 at 1:52=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Convert mm_lock_seq to be seqcount_t and change all mmap_write_lock
> > variants to increment it, in-line with the usual seqcount usage pattern=
.
> > This lets us check whether the mmap_lock is write-locked by checking
> > mm_lock_seq.sequence counter (odd=3Dlocked, even=3Dunlocked). This will=
 be
> > used when implementing mmap_lock speculation functions.
> > As a result vm_lock_seq is also change to be unsigned to match the type
> > of mm_lock_seq.sequence.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Applies over mm-unstable
> >
> > This conversion was discussed at [1] and these patches will likely be
> > incorporated into the next version od Andrii's patcset.
>
> I got a notification that this patch set was applied to mm-unstable by
> Andrew. But I was wondering if Andrew and Peter would agree to move
> the patches into tip's perf/core branch, given this is a dependency of
> my pending uprobe series ([0]) and, as far as I'm aware, there is no
> urgent need for this API in mm tree(s). If we route this through
> mm-unstable, we either need a stable tag from mm tree for Peter to
> merge into perf/core (a bit of a hassle for both Andrew and Peter, I'm
> sure), or I'd have to wait for 5-6 weeks until after next merge window
> closes, which would be a huge bummer, given I'd been at this for a
> while already with basically done patches, and would prefer to get my
> changes sooner.
>
> So, I'd very much prefer to just route these changes through
> perf/core, if mm folks don't oppose this? In fact, I'll go ahead and
> will send my patches with Suren's patches included with the assumption
> that we can reroute all this. Thanks for understanding!
>
> P.S. And yeah, Suren's patches apply cleanly to perf/core just as
> well, I checked.

Sent all of that as v4, see [2]

  [2] https://lore.kernel.org/linux-trace-kernel/20241028010818.2487581-1-a=
ndrii@kernel.org/

>
>   [0] https://lore.kernel.org/linux-trace-kernel/20241010205644.3831427-1=
-andrii@kernel.org/
>
> > The issue of the seqcount_t.sequence being an unsigned rather than
> > unsigned long will be addressed separately in collaoration with Jann Ho=
rn.
> >
> > [1] https://lore.kernel.org/all/20241010205644.3831427-2-andrii@kernel.=
org/
> >
> >  include/linux/mm.h               | 12 +++----
> >  include/linux/mm_types.h         |  7 ++--
> >  include/linux/mmap_lock.h        | 58 +++++++++++++++++++++-----------
> >  kernel/fork.c                    |  5 +--
> >  mm/init-mm.c                     |  2 +-
> >  tools/testing/vma/vma.c          |  4 +--
> >  tools/testing/vma/vma_internal.h |  4 +--
> >  7 files changed, 56 insertions(+), 36 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4ef8cf1043f1..77644118b200 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -698,7 +698,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >          * we don't rely on for anything - the mm_lock_seq read against=
 which we
> >          * need ordering is below.
> >          */
> > -       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm=
_lock_seq))
> > +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm=
_lock_seq.sequence))
> >                 return false;
> >
> >         if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
> > @@ -715,7 +715,7 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
> >          * after it has been unlocked.
> >          * This pairs with RELEASE semantics in vma_end_write_all().
> >          */
> > -       if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vma->vm_=
mm->mm_lock_seq))) {
> > +       if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->vm=
_mm->mm_lock_seq))) {
> >                 up_read(&vma->vm_lock->lock);
> >                 return false;
> >         }
> > @@ -730,7 +730,7 @@ static inline void vma_end_read(struct vm_area_stru=
ct *vma)
> >  }
> >
> >  /* WARNING! Can only be used if mmap_lock is expected to be write-lock=
ed */
> > -static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_=
lock_seq)
> > +static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned=
 int *mm_lock_seq)
> >  {
> >         mmap_assert_write_locked(vma->vm_mm);
> >
> > @@ -738,7 +738,7 @@ static bool __is_vma_write_locked(struct vm_area_st=
ruct *vma, int *mm_lock_seq)
> >          * current task is holding mmap_write_lock, both vma->vm_lock_s=
eq and
> >          * mm->mm_lock_seq can't be concurrently modified.
> >          */
> > -       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq;
> > +       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq.sequence;
> >         return (vma->vm_lock_seq =3D=3D *mm_lock_seq);
> >  }
> >
> > @@ -749,7 +749,7 @@ static bool __is_vma_write_locked(struct vm_area_st=
ruct *vma, int *mm_lock_seq)
> >   */
> >  static inline void vma_start_write(struct vm_area_struct *vma)
> >  {
> > -       int mm_lock_seq;
> > +       unsigned int mm_lock_seq;
> >
> >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> >                 return;
> > @@ -767,7 +767,7 @@ static inline void vma_start_write(struct vm_area_s=
truct *vma)
> >
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> >  {
> > -       int mm_lock_seq;
> > +       unsigned int mm_lock_seq;
> >
> >         VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
> >  }
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index ff8627acbaa7..80fef38d9d64 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -715,7 +715,7 @@ struct vm_area_struct {
> >          * counter reuse can only lead to occasional unnecessary use of=
 the
> >          * slowpath.
> >          */
> > -       int vm_lock_seq;
> > +       unsigned int vm_lock_seq;
> >         /* Unstable RCU readers are allowed to read this. */
> >         struct vma_lock *vm_lock;
> >  #endif
> > @@ -887,6 +887,9 @@ struct mm_struct {
> >                  * Roughly speaking, incrementing the sequence number i=
s
> >                  * equivalent to releasing locks on VMAs; reading the s=
equence
> >                  * number can be part of taking a read lock on a VMA.
> > +                * Incremented every time mmap_lock is write-locked/unl=
ocked.
> > +                * Initialized to 0, therefore odd values indicate mmap=
_lock
> > +                * is write-locked and even values that it's released.
> >                  *
> >                  * Can be modified under write mmap_lock using RELEASE
> >                  * semantics.
> > @@ -895,7 +898,7 @@ struct mm_struct {
> >                  * Can be read with ACQUIRE semantics if not holding wr=
ite
> >                  * mmap_lock.
> >                  */
> > -               int mm_lock_seq;
> > +               seqcount_t mm_lock_seq;
> >  #endif
> >
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index de9dc20b01ba..6b3272686860 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -71,39 +71,38 @@ static inline void mmap_assert_write_locked(const s=
truct mm_struct *mm)
> >  }
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> > -/*
> > - * Drop all currently-held per-VMA locks.
> > - * This is called from the mmap_lock implementation directly before re=
leasing
> > - * a write-locked mmap_lock (or downgrading it to read-locked).
> > - * This should normally NOT be called manually from other places.
> > - * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > - * *all* VMA write locks, including ones from further up the stack.
> > - */
> > -static inline void vma_end_write_all(struct mm_struct *mm)
> > +static inline void mm_lock_seqcount_init(struct mm_struct *mm)
> >  {
> > -       mmap_assert_write_locked(mm);
> > -       /*
> > -        * Nobody can concurrently modify mm->mm_lock_seq due to exclus=
ive
> > -        * mmap_lock being held.
> > -        * We need RELEASE semantics here to ensure that preceding stor=
es into
> > -        * the VMA take effect before we unlock it with this store.
> > -        * Pairs with ACQUIRE semantics in vma_start_read().
> > -        */
> > -       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +       seqcount_init(&mm->mm_lock_seq);
> > +}
> > +
> > +static inline void mm_lock_seqcount_begin(struct mm_struct *mm)
> > +{
> > +       do_raw_write_seqcount_begin(&mm->mm_lock_seq);
> > +}
> > +
> > +static inline void mm_lock_seqcount_end(struct mm_struct *mm)
> > +{
> > +       do_raw_write_seqcount_end(&mm->mm_lock_seq);
> >  }
> > +
> >  #else
> > -static inline void vma_end_write_all(struct mm_struct *mm) {}
> > +static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> > +static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
> > +static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
> >  #endif
> >
> >  static inline void mmap_init_lock(struct mm_struct *mm)
> >  {
> >         init_rwsem(&mm->mmap_lock);
> > +       mm_lock_seqcount_init(mm);
> >  }
> >
> >  static inline void mmap_write_lock(struct mm_struct *mm)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write(&mm->mmap_lock);
> > +       mm_lock_seqcount_begin(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
> >
> > @@ -111,6 +110,7 @@ static inline void mmap_write_lock_nested(struct mm=
_struct *mm, int subclass)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write_nested(&mm->mmap_lock, subclass);
> > +       mm_lock_seqcount_begin(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
> >
> > @@ -120,10 +120,30 @@ static inline int mmap_write_lock_killable(struct=
 mm_struct *mm)
> >
> >         __mmap_lock_trace_start_locking(mm, true);
> >         ret =3D down_write_killable(&mm->mmap_lock);
> > +       if (!ret)
> > +               mm_lock_seqcount_begin(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
> >         return ret;
> >  }
> >
> > +/*
> > + * Drop all currently-held per-VMA locks.
> > + * This is called from the mmap_lock implementation directly before re=
leasing
> > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > + * This should normally NOT be called manually from other places.
> > + * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > + * *all* VMA write locks, including ones from further up the stack.
> > + */
> > +static inline void vma_end_write_all(struct mm_struct *mm)
> > +{
> > +       mmap_assert_write_locked(mm);
> > +       /*
> > +        * Nobody can concurrently modify mm->mm_lock_seq due to exclus=
ive
> > +        * mmap_lock being held.
> > +        */
> > +       mm_lock_seqcount_end(mm);
> > +}
> > +
> >  static inline void mmap_write_unlock(struct mm_struct *mm)
> >  {
> >         __mmap_lock_trace_released(mm, true);
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index fd528fb5e305..0cae6fc651f0 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -447,7 +447,7 @@ static bool vma_lock_alloc(struct vm_area_struct *v=
ma)
> >                 return false;
> >
> >         init_rwsem(&vma->vm_lock->lock);
> > -       vma->vm_lock_seq =3D -1;
> > +       vma->vm_lock_seq =3D UINT_MAX;
> >
> >         return true;
> >  }
> > @@ -1260,9 +1260,6 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >         seqcount_init(&mm->write_protect_seq);
> >         mmap_init_lock(mm);
> >         INIT_LIST_HEAD(&mm->mmlist);
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -       mm->mm_lock_seq =3D 0;
> > -#endif
> >         mm_pgtables_bytes_init(mm);
> >         mm->map_count =3D 0;
> >         mm->locked_vm =3D 0;
> > diff --git a/mm/init-mm.c b/mm/init-mm.c
> > index 24c809379274..6af3ad675930 100644
> > --- a/mm/init-mm.c
> > +++ b/mm/init-mm.c
> > @@ -40,7 +40,7 @@ struct mm_struct init_mm =3D {
> >         .arg_lock       =3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
> >         .mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
> >  #ifdef CONFIG_PER_VMA_LOCK
> > -       .mm_lock_seq    =3D 0,
> > +       .mm_lock_seq    =3D SEQCNT_ZERO(init_mm.mm_lock_seq),
> >  #endif
> >         .user_ns        =3D &init_user_ns,
> >         .cpu_bitmap     =3D CPU_BITS_NONE,
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index 8fab5e13c7c3..9bcf1736bf18 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
> > @@ -89,7 +89,7 @@ static struct vm_area_struct *alloc_and_link_vma(stru=
ct mm_struct *mm,
> >          * begun. Linking to the tree will have caused this to be incre=
mented,
> >          * which means we will get a false positive otherwise.
> >          */
> > -       vma->vm_lock_seq =3D -1;
> > +       vma->vm_lock_seq =3D UINT_MAX;
> >
> >         return vma;
> >  }
> > @@ -214,7 +214,7 @@ static bool vma_write_started(struct vm_area_struct=
 *vma)
> >         int seq =3D vma->vm_lock_seq;
> >
> >         /* We reset after each check. */
> > -       vma->vm_lock_seq =3D -1;
> > +       vma->vm_lock_seq =3D UINT_MAX;
> >
> >         /* The vma_start_write() stub simply increments this value. */
> >         return seq > -1;
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index e76ff579e1fd..1d9fc97b8e80 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -241,7 +241,7 @@ struct vm_area_struct {
> >          * counter reuse can only lead to occasional unnecessary use of=
 the
> >          * slowpath.
> >          */
> > -       int vm_lock_seq;
> > +       unsigned int vm_lock_seq;
> >         struct vma_lock *vm_lock;
> >  #endif
> >
> > @@ -416,7 +416,7 @@ static inline bool vma_lock_alloc(struct vm_area_st=
ruct *vma)
> >                 return false;
> >
> >         init_rwsem(&vma->vm_lock->lock);
> > -       vma->vm_lock_seq =3D -1;
> > +       vma->vm_lock_seq =3D UINT_MAX;
> >
> >         return true;
> >  }
> >
> > base-commit: 9c111059234a949a4d3442a413ade19cc65ab927
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >

