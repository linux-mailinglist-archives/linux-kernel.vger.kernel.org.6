Return-Path: <linux-kernel+bounces-449578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC99F50FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1461881EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163A1F63DB;
	Tue, 17 Dec 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFdWVT87"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1561E3DF7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452882; cv=none; b=oAMW8xlpk/12Rg7EyA0fWtLvYZWTWHrrCUhnJ4+3IpXashFeQeZD5XplVuMo7i/r1IbbhhooLOROPM9IX8LWzW9Bl+xeUGhXbxnKYsIRAp7E6YwuMagfBkooNqcXnkDcSkcBMaHy1jg8+EAU2iFPYx8Ql4nKJ1w3h7wv7WNHYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452882; c=relaxed/simple;
	bh=9rBZcYZ084sYIdjiTH/H0LSpih0Tm9ZtINLwUoKZpbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHW/IDa43l07beT/Sym5O14R3+b4iG4Mw8ajN1iFLOfriUqZE/KQvOwyPkxKSAyVv0HKL1SFXxwLP8bwytDWNn3k4/mIrlLcJCaQza03Qq1UX4ST+JIhNReW8jXiAay8QJu7BVaIGJSS0vFFg11ILb12z9mWbvfWTpNN+qhGZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qFdWVT87; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678c9310afso274351cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734452878; x=1735057678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT/vkq1/V1NDu2ah/NePQKYf8DEcNklX6cXh0MMNAZU=;
        b=qFdWVT87E7O0hEHVQHTLCVaIB/kbeAfe2WLvHdkEzjdPSxvWZmfx1ui0zETxjeg6CD
         eS9XzcYKpkFmQ41jGI5d14/5kRXyIPhtMK8d46uD5qBqLHweYLdR9Q1MOO/ORe489XFt
         pgRM3wOxlstYla1qmaEKFzAknsSJxXsv/V+fQzSxOjzwweYNp9aIcbSuRGHyh7fSgf1M
         AU1PLALDbIXH4uyaSE5Vt7Wm0YwO0ZkzuR6DaynxFCast/YfoWjOsYFFbumVhkaXdoL9
         saEUCUCU6Gl9jALlSkdAhEuIf86rXg2Ad+CkczaUZLtImElnaIa2n97FipDSz69ywmNw
         nCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452878; x=1735057678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT/vkq1/V1NDu2ah/NePQKYf8DEcNklX6cXh0MMNAZU=;
        b=i0pxBRtTf4wr/EcF9eqz2S4JdUGs7lmAoF5fkzebU4h3d5NxojUJAGQwx9/F2B4QlC
         4uDcianGQbLHmG2Ud6ukjzivtX4IZaYc1rzqCtsKI6i1CGI3yw0Zy3eGGbZjGUje155y
         XAZvVmSPf01sbjvC+Xlxsi88azHtwj7duUFk/l6DLn7Dj+F2q+6RzMnYs2NPWzxvywJv
         BzC5/HX9V3kwu93wLEeKYdU6KtZEt3MjWMXpZvS2RKcthHod6aqh4SL/akH9dJf0UkF4
         jGSCteX85A65hUZveppmMDk5YczCh+1PqHIvROjGhg9wtVzEh+9Nukse0wW8RA0VCjhq
         kAcg==
X-Forwarded-Encrypted: i=1; AJvYcCWXgPCg5UmYrt6iCbrbRPWNO/4NZ4MSyLZOSoUB8EiEap8bUA87SHpEIoPvlI0Z4qBgRx7a6fHMHPluUag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw69uOYfPRDtDF+cYPQlh8AoPqdW3kEhCs/P2384kYGs6SlFw4
	ICN3fe13nRINqp92uBOhRyUJIHY2yBCJiveFSaCGOnHOYfgFuRsTJYLgemSvL+Q6bzAvWmnDX+0
	8SQ8fIL5O4moNDjpp9ybe0B1309c8DZpv005s
X-Gm-Gg: ASbGncs/GB9otP3aws9qVjp56NffjueQT4+dvAFic8AiFHwU5N3gkgdqM9aRvl7ahkS
	gd2L5jGCyG7NYjkCP8uskXHwFTqdYeaSk3L36s+Tlg1nASRUNXO0lcjGNe6mRSxIqCTti
X-Google-Smtp-Source: AGHT+IFdrYrT/+JYttr7HyZfnxo0ZjpiJ1vNiTEa49+t7DbFwavsX/sY8uK5R0p1ZeEElNuT/XiNgIfB2zJmTxK8THw=
X-Received: by 2002:ac8:5816:0:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-468fb0a6adfmr3691841cf.3.1734452877654; Tue, 17 Dec 2024
 08:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-11-surenb@google.com>
 <20241216213753.GD9803@noisy.programming.kicks-ass.net> <CAJuCfpEu_rZkC+ktWXE=rA-VenFBZR9VQ-SnVkDbXUqsd3Ys_A@mail.gmail.com>
 <20241217103035.GD11133@noisy.programming.kicks-ass.net>
In-Reply-To: <20241217103035.GD11133@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Dec 2024 08:27:46 -0800
Message-ID: <CAJuCfpHzsQeejdPPbDdA6B3Wa=-KusnYRUyt1U0WnCRr8OKfGw@mail.gmail.com>
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

On Tue, Dec 17, 2024 at 2:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Dec 16, 2024 at 01:44:45PM -0800, Suren Baghdasaryan wrote:
> > On Mon, Dec 16, 2024 at 1:38=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 11:24:13AM -0800, Suren Baghdasaryan wrote:
> > > > +static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > > +{
> > > > +     int refcnt;
> > > > +
> > > > +     if (!__refcount_dec_and_test(&vma->vm_refcnt, &refcnt)) {
> > > > +             rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > > +
> > > > +             if (refcnt & VMA_STATE_LOCKED)
> > > > +                     rcuwait_wake_up(&vma->vm_mm->vma_writer_wait)=
;
> > > > +     }
> > > > +}
> > > > +
> > > >  /*
> > > >   * Try to read-lock a vma. The function is allowed to occasionally=
 yield false
> > > >   * locked result to avoid performance overhead, in which case we f=
all back to
> > > > @@ -710,6 +728,8 @@ static inline void vma_lock_init(struct vm_area=
_struct *vma)
> > > >   */
> > > >  static inline bool vma_start_read(struct vm_area_struct *vma)
> > > >  {
> > > > +     int oldcnt;
> > > > +
> > > >       /*
> > > >        * Check before locking. A race might cause false locked resu=
lt.
> > > >        * We can use READ_ONCE() for the mm_lock_seq here, and don't=
 need
> > > > @@ -720,13 +740,20 @@ static inline bool vma_start_read(struct vm_a=
rea_struct *vma)
> > > >       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->=
mm_lock_seq.sequence))
> > > >               return false;
> > > >
> > > > +
> > > > +     rwsem_acquire_read(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > > > +     /* Limit at VMA_STATE_LOCKED - 2 to leave one count for a wri=
ter */
> > > > +     if (unlikely(!__refcount_inc_not_zero_limited(&vma->vm_refcnt=
, &oldcnt,
> > > > +                                                   VMA_STATE_LOCKE=
D - 2))) {
> > > > +             rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > >               return false;
> > > > +     }
> > > > +     lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > > >
> > > >       /*
> > > > +      * Overflow of vm_lock_seq/mm_lock_seq might produce false lo=
cked result.
> > > >        * False unlocked result is impossible because we modify and =
check
> > > > +      * vma->vm_lock_seq under vma->vm_refcnt protection and mm->m=
m_lock_seq
> > > >        * modification invalidates all existing locks.
> > > >        *
> > > >        * We must use ACQUIRE semantics for the mm_lock_seq so that =
if we are
> > > > @@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_a=
rea_struct *vma)
> > > >        * after it has been unlocked.
> > > >        * This pairs with RELEASE semantics in vma_end_write_all().
> > > >        */
> > > > +     if (oldcnt & VMA_STATE_LOCKED ||
> > > > +         unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->=
vm_mm->mm_lock_seq))) {
> > > > +             vma_refcount_put(vma);
> > >
> > > Suppose we have detach race with a concurrent RCU lookup like:
> > >
> > >                                         vma =3D mas_lookup();
> > >
> > >         vma_start_write();
> > >         mas_detach();
> > >                                         vma_start_read()
> > >                                         rwsem_acquire_read()
> > >                                         inc // success
> > >         vma_mark_detach();
> > >         dec_and_test // assumes 1->0
> > >                      // is actually 2->1
> > >
> > >                                         if (vm_lock_seq =3D=3D vma->v=
m_mm_mm_lock_seq) // true
> > >                                           vma_refcount_put
> > >                                             dec_and_test() // 1->0
> > >                                               *NO* rwsem_release()
> > >
> >
> > Yes, this is possible. I think that's not a problem until we start
> > reusing the vmas and I deal with this race later in this patchset.
> > I think what you described here is the same race I mention in the
> > description of this patch:
> > https://lore.kernel.org/all/20241216192419.2970941-14-surenb@google.com=
/
> > I introduce vma_ensure_detached() in that patch to handle this case
> > and ensure that vmas are detached before they are returned into the
> > slab cache for reuse. Does that make sense?
>
> So I just replied there, and no, I don't think it makes sense. Just put
> the kmem_cache_free() in vma_refcount_put(), to be done on 0.

That's very appealing indeed and makes things much simpler. The
problem I see with that is the case when we detach a vma from the tree
to isolate it, then do some cleanup and only then free it. That's done
in vms_gather_munmap_vmas() here:
https://elixir.bootlin.com/linux/v6.12.5/source/mm/vma.c#L1240 and we
even might reattach detached vmas back:
https://elixir.bootlin.com/linux/v6.12.5/source/mm/vma.c#L1312. IOW,
detached state is not final and we can't destroy the object that
reached this state. We could change states to: 0=3Dunused (we can free
the object), 1=3Ddetached, 2=3Dattached, etc. but then vma_start_read()
should do something like refcount_inc_more_than_one() instead of
refcount_inc_not_zero(). Would you be ok with such an approach?

>
> Anyway, my point was more about the weird entanglement of lockdep and
> the refcount. Just pull the lockdep annotation out of _put() and put it
> explicitly in the vma_start_read() error paths and vma_end_read().

Ok, I think that's easy.

>
> Additionally, having vma_end_write() would allow you to put a lockdep
> annotation in vma_{start,end}_write() -- which was I think the original
> reason I proposed it a while back, that and having improved clarity when
> reading the code, since explicitly marking the end of a section is
> helpful.

The vma->vmlock_dep_map is tracking vma->vm_refcnt, not the
vma->vm_lock_seq (similar to how today vma->vm_lock has its lockdep
tracking that rw_semaphore). If I implement vma_end_write() then it
will simply be something like:

void vma_end_write(vma)
{
         vma_assert_write_locked(vma);
         vma->vm_lock_seq =3D UINT_MAX;
}

so, vmlock_dep_map would not be involved.

If you want to track vma->vm_lock_seq with a separate lockdep, that
would be more complicated. Specifically for vma_end_write_all() that
would require us to call rwsem_release() on all locked vmas, however
we currently do not track individual locked vmas. vma_end_write_all()
allows us not to worry about tracking them, knowing that once we do
mmap_write_unlock() they all will get unlocked with one increment of
mm->mm_lock_seq. If your suggestion is to replace vma_end_write_all()
with vma_end_write() and unlock vmas individually across the mm code,
that would be a sizable effort. If that is indeed your ultimate goal,
I can do that as a separate project: introduce vma_end_write(),
gradually add them in required places (not yet sure how complex that
would be), then retire vma_end_write_all() and add a lockdep for
vma->vm_lock_seq.

