Return-Path: <linux-kernel+bounces-395562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA69BBFE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C01B20B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DC1FCC6A;
	Mon,  4 Nov 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JohbOOu8"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55821FCC56
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755231; cv=none; b=h5J2+KnjMt5Z9juvzoOlFzQjAqAMwlFRg3HN85ZhLpqTHbhTI4ft3BS2quNRgzXBAQXJOUKOKVR2CLtA0EjMXCNylAzJcXDDoWuQRl5lSxyIGc4eVQ1TFMkyu0j9Q6f4TqHqO53IjWcYjnMzEA8UjJpyO2iYEl0migG2n5fQpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755231; c=relaxed/simple;
	bh=xQ6aEheb3272nuqp9dj/MoRurkG8c0+nxRkScQJGt58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwZRVGY9oAs4YnGEQt0kWIWx567kCdB2GCDvUHUinIYrOEuTWQ15d8WL9BfHm6whSBFO/GxcFoJ675Z3WH73WK8SGforzL71H3bEGLPz+ILH19EUQymrf5tUtN5wzxRb6d3PNfU2JyK69ISDTMG9TEwySZWsIjR0YRFHAJ+LFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JohbOOu8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so21815ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730755227; x=1731360027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VkGkFH0co4eK4MdAfq1nKBH+dSxBnxWr9fbz+JsDZQ=;
        b=JohbOOu8jebu4DzpXCflOY75RgWI+owqBzi6uMSt4TdJxuiBRm47tIH8NIloWaFg0f
         qx2eigLIlwLmQesGcqJ80GsJC7zle4EisB30DrmgelQKetlqyRMr06FEDX5OFgjDFKmt
         0qtVKbuDRghxmUA4lA2KQolHOfB9GvS+u38XceALVe4SFmFxTF2AwkvEeaozK4k+1l5h
         hXJ0jCuGemW1CGrgzejOpBNYVO92X6nmidXsm6pH7fnVgM+q+zv0xrS7n9saRIfCEJXy
         z+rZm/purMcH/+OA4pN+ZtZSAFUaqXSAaLN6S6q6Ui4ANg9FWF1z4N0y+lTDH14LgYqM
         dMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755227; x=1731360027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VkGkFH0co4eK4MdAfq1nKBH+dSxBnxWr9fbz+JsDZQ=;
        b=HGgRRIDBncQMEkwumZSnciXtFEz6YOaUSRen8/sfvHogVfNamlMgKM7rUYM7erHLJC
         Ziwbg2XTRWetciwqgECqPoL5XtVPhbwwOyXAUdaKPDPyZUhDjkrxMDdPsdUP7MwXRrhB
         uNdey0YgdVh6G12k2T6ZXkQv/IZGvmBadXZLTSwlPuSdY8nGLdHwRY92d9g/KUGfCpTp
         HVcblpFY1MHlH3CzI3+kWREWOZDabWnl5HSS/2HzcePIYkSgSPNmWDTpBlo2qT1EpxAs
         crNqX6mnLwM+n5vtFP4LxC+Fn5E83t0gt5wJ434GUhG9xh3Pns4aJURF4RiuUeFqNNwe
         7S2w==
X-Forwarded-Encrypted: i=1; AJvYcCXxbmYfXLfHrDT8t3jIE0QOH92zROdJxAKhdW9dH7T5zTUBigqloIhjlj4UrBlV/hyP73+bI/7fV6da0xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygq4nA3kcNXNDdzTrGlhKLM7ZSf0oicsi6kZoyCIKDxoNaJkVU
	IZ9tG7VJdJivYFGJh/9A57sxs7wBDIgKZQT9oJemsUOA69nMEO1jZad+8PqAwa8R0necm9Dy/46
	RCv35dNJQTJpQuDsgQkgHybDdouhsHGoeSdkM
X-Gm-Gg: ASbGncvgmE5vPToFtDQgC7Xbyi09oiaSDtBqtUNaAqsh+JGBVvXn3Ao0mOyPRgn3cEx
	wgwBh+M1KaR1HKaC/3rY8h9+fMDuoHqQ=
X-Google-Smtp-Source: AGHT+IGOvx2FVeKonp6cA0TMRtPXfzWK2i8jdPUqT0McPVO69hjd3hGEftCmOwltJuwiwElOjOuCwIuocjKAM72W7Gs=
X-Received: by 2002:a05:6e02:1aa7:b0:3a5:8896:6e66 with SMTP id
 e9e14a558f8ab-3a6da89f65cmr1208075ab.0.1730755226218; Mon, 04 Nov 2024
 13:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAJuCfpEo2RyBLpariVgKBjQrZxdHuhMCgOGYfESZsYOPMD5vBw@mail.gmail.com> <03cc76df-8814-4d0a-83a6-447212ef2370@lucifer.local>
In-Reply-To: <03cc76df-8814-4d0a-83a6-447212ef2370@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Nov 2024 13:20:14 -0800
Message-ID: <CAJuCfpGtxMmzG6SswnonFcyaF9LJOot6NR8kh2Re3FxWebWfug@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:04=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Nov 04, 2024 at 09:01:46AM -0800, Suren Baghdasaryan wrote:
> > On Fri, Nov 1, 2024 at 11:51=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Locking around VMAs is complicated and confusing. While we have a num=
ber of
> > > disparate comments scattered around the place, we seem to be reaching=
 a
> > > level of complexity that justifies a serious effort at clearly docume=
nting
> > > how locks are expected to be interacted with when it comes to interac=
ting
> > > with mm_struct and vm_area_struct objects.
> > >
> > > This is especially pertinent as regards efforts to find sensible
> > > abstractions for these fundamental objects within the kernel rust
> > > abstraction whose compiler strictly requires some means of expressing=
 these
> > > rules (and through this expression can help self-document these
> > > requirements as well as enforce them which is an exciting concept).
> > >
> > > The document limits scope to mmap and VMA locks and those that are
> > > immediately adjacent and relevant to them - so additionally covers pa=
ge
> > > table locking as this is so very closely tied to VMA operations (and =
relies
> > > upon us handling these correctly).
> > >
> > > The document tries to cover some of the nastier and more confusing ed=
ge
> > > cases and concerns especially around lock ordering and page table tea=
rdown.
> > >
> > > The document also provides some VMA lock internals, which are up to d=
ate
> > > and inclusive of recent changes to recent sequence number changes.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Thanks for documenting this, Lorenzo!
>
> No worries, I feel it's very important to document this at this stage.
>
> > Just heads-up, I'm working on changing some of the implementation
> > details (removing vma->detached, moving vm_lock into vm_area_struct,
> > etc.). I should be able to post those changes sometime later this week
> > if testing does not reveal any issues.
>
> Ack yeah we can update as we go, as for removing vma->detached, how are w=
e able
> to do this?
>
> My understanding is that detached VMAs are ones that are being removed (d=
ue
> to e.g.  merge/MAP_FIXED mmap()/munmap()) that are due to be RCU freed (a=
s
> vm_area_free() does this via call_rcu() so delays until grace period), bu=
t
> which have been VMA unlocked prior to the grace period so
> lock_vma_under_rcu() might grab but shouldn't do anything with + retry.
>
> Will there be a new means of determining this?
>
> Anyway... we can update as we go :)
>
> >
> > > ---
> > >
> > > REVIEWERS NOTES:
> > >    You can speed up doc builds by running `make SPHINXDIRS=3Dmm htmld=
ocs`. I
> > >    also uploaded a copy of this to my website at
> > >    https://ljs.io/output/mm/vma_locks to make it easier to have a qui=
ck
> > >    read through. Thanks!
> > >
> > >
> > >  Documentation/mm/index.rst     |   1 +
> > >  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 528 insertions(+)
> > >  create mode 100644 Documentation/mm/vma_locks.rst
> > >
> > > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > > index 0be1c7503a01..da5f30acaca5 100644
> > > --- a/Documentation/mm/index.rst
> > > +++ b/Documentation/mm/index.rst
> > > @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purp=
ose.
> > >     vmemmap_dedup
> > >     z3fold
> > >     zsmalloc
> > > +   vma_locks
> > > diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_lo=
cks.rst
> > > new file mode 100644
> > > index 000000000000..52b9d484376a
> > > --- /dev/null
> > > +++ b/Documentation/mm/vma_locks.rst
> > > @@ -0,0 +1,527 @@
> > > +VMA Locking
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Overview
> > > +--------
> > > +
> > > +Userland memory ranges are tracked by the kernel via Virtual Memory =
Areas or
> > > +'VMA's of type `struct vm_area_struct`.
> > > +
> > > +Each VMA describes a virtually contiguous memory range with identica=
l
> > > +attributes, each of which described by a `struct vm_area_struct`
> > > +object. Userland access outside of VMAs is invalid except in the cas=
e where an
> > > +adjacent stack VMA could be extended to contain the accessed address=
.
> > > +
> > > +All VMAs are contained within one and only one virtual address space=
, described
> > > +by a `struct mm_struct` object which is referenced by all tasks (tha=
t is,
> > > +threads) which share the virtual address space. We refer to this as =
the `mm`.
> > > +
> > > +Each mm object contains a maple tree data structure which describes =
all VMAs
> > > +within the virtual address space.
> > > +
> > > +The kernel is designed to be highly scalable against concurrent acce=
ss to
> > > +userland memory, so a complicated set of locks are required to ensur=
e no data
> > > +races or memory corruption occurs.
> > > +
> > > +This document explores this locking in detail.
> > > +
> > > +.. note::
> > > +
> > > +   There are three different things that a user might want to achiev=
e via
> > > +   locks - the first of which is **stability**. That is - ensuring t=
hat the VMA
> > > +   won't be freed or modified in any way from underneath us.
> > > +
> > > +   All MM and VMA locks ensure stability.
> > > +
> > > +   Secondly we have locks which allow **reads** but not writes (and =
which might
> > > +   be held concurrent with other CPUs who also hold the read lock).
> > > +
> > > +   Finally, we have locks which permit exclusive access to the VMA t=
o allow for
> > > +   **writes** to the VMA.
> > > +
> > > +MM and VMA locks
> > > +----------------
> > > +
> > > +There are two key classes of lock utilised when reading and manipula=
ting VMAs -
> > > +the `mmap_lock` which is a read/write semaphore maintained at the `m=
m_struct`
> > > +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA l=
ock at the
> > > +VMA level of granularity.
> > > +
> > > +.. note::
> > > +
> > > +   Generally speaking, a read/write semaphore is a class of lock whi=
ch permits
> > > +   concurrent readers. However a write lock can only be obtained onc=
e all
> > > +   readers have left the critical region (and pending readers made t=
o wait).
> > > +
> > > +   This renders read locks on a read/write semaphore concurrent with=
 other
> > > +   readers and write locks exclusive against all others holding the =
semaphore.
> > > +
> > > +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple=
 - a write
> > > +mmap lock gives you exclusive write access to a VMA, and a read lock=
 gives you
> > > +concurrent read-only access.
> > > +
> > > +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are m=
ore
> > > +complicated. In this instance, a write semaphore is no longer enough=
 to gain
> > > +exclusive access to a VMA, a VMA write lock is also required.
> >
> > I think "exclusive access to a VMA" should be "exclusive access to mm"
> > if you are talking about mmap_lock.
>
> Right, but in the past an mm write lock was sufficient to gain exclusive
> access to a _vma_. I will adjust to say 'write semaphore on the mm'.
>
> >
> > I think it's worth adding here:
> > 1. to take a VMA write-lock you need to be holding an mmap_lock;
> > 2. write-unlocking mmap_lock drops all VMA write locks in that mm.
> >
> > I see that you touch on this in the below "Note" section but that's
> > not an implementation detail but the designed behavior, so I think
> > these should not be mere side-notes.
>
> Right yeah I do mention both of these, but perhaps it's worth explicitly
> saying this right at the top. Will add.
>
> >
> > > +
> > > +The VMA lock is implemented via the use of both a read/write semapho=
re and
> > > +per-VMA and per-mm sequence numbers. We go into detail on this in th=
e VMA lock
> > > +internals section below, so for the time being it is important only =
to note that
> > > +we can obtain either a VMA read or write lock.
> > > +
> > > +.. note::
> > > +
> > > +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_=
rcu()`
> > > +   function, and **no** existing mmap or VMA lock must be held, This=
 function
> >
> > "no existing mmap or VMA lock must be held" did you mean to say "no
> > exclusive mmap or VMA locks must be held"? Because one can certainly
> > hold a read-lock on them.
>
> Hmm really? You can hold an mmap read lock and obtain a VMA read lock too
> irrespective of that?
>
> OK, my mistake will update this and the table below to reflect this,
> thanks!
>
> Also I see that this part that was in a 'note' section is probably a bit
> wordy, which somewhat takes away from the key messages, will try to trim =
a
> bit or separate out to make things clearer.
>
> >
> > > +   either returns a read-locked VMA, or NULL if the lock could not b=
e
> > > +   acquired. As the name suggests, the VMA will be acquired under RC=
U, though
> > > +   once obtained, remains stable.
> > > +
> > > +   This kind of locking is entirely optimistic - if the lock is cont=
ended or a
> > > +   competing write has started, then we do not obtain a read lock.
> > > +
> > > +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()`=
 to ensure
> > > +   that the VMA is acquired in an RCU critical section, then attempt=
s to VMA
> > > +   lock it via `vma_start_read()`, before releasing the RCU lock via
> > > +   `rcu_read_unlock()`.
> > > +
> > > +   VMA read locks hold the a read lock on the `vma->vm_lock` semapho=
re for their
> > > +   duration and the caller of `lock_vma_under_rcu()` must release it=
 via
> > > +   `vma_end_read()`.
> > > +
> > > +   VMA **write** locks are acquired via `vma_start_write()` in insta=
nces where a
> > > +   VMA is about to be modified, unlike `vma_start_read()` the lock i=
s always
> > > +   acquired. An mmap write lock **must** be held for the duration of=
 the VMA
> > > +   write lock, releasing or downgrading the mmap write lock also rel=
eases the
> > > +   VMA write lock so there is no `vma_end_write()` function.
> > > +
> > > +   Note that a semaphore write lock is not held across a VMA lock. R=
ather, a
> > > +   sequence number is used for serialisation, and the write semaphor=
e is only
> > > +   acquired at the point of write lock to update this (we explore th=
is in detail
> > > +   in the VMA lock internals section below).
> > > +
> > > +   This ensures the semantics we require - VMA write locks provide e=
xclusive
> > > +   write access to the VMA.
> > > +
> > > +Examining all valid lock state and what each implies:
> > > +
> > > +.. list-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - mmap lock
> > > +     - VMA lock
> > > +     - Stable?
> > > +     - Can read safely?
> > > +     - Can write safely?
> > > +   * - \-
> > > +     - \-
> > > +     - N
> > > +     - N
> > > +     - N
> > > +   * - R
> > > +     - \-
> > > +     - Y
> > > +     - Y
> > > +     - N
> > > +   * - \-
> > > +     - R
> > > +     - Y
> > > +     - Y
> > > +     - N
> > > +   * - W
> > > +     - \-
> > > +     - Y
> > > +     - Y
> > > +     - N
> > > +   * - W
> > > +     - W
> > > +     - Y
> > > +     - Y
> > > +     - Y
> > > +
> > > +Note that there are some exceptions to this - the `anon_vma` field i=
s permitted
> > > +to be written to under mmap read lock and is instead serialised by t=
he `struct
> > > +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
> > > +lock-specific fields are permitted to be read under RCU alone  (thou=
gh stability cannot
> > > +be expected in this instance).
> > > +
> > > +.. note::
> > > +   The most notable place to use the VMA read lock is on page table =
faults on
> > > +   the x86-64 architecture, which importantly means that without a V=
MA write
> >
> > As Jann mentioned, CONFIG_PER_VMA_LOCK is supported on many more archit=
ectures.
>
> Yes, have updated to say so already. Sorry I was behind on how much this
> had progressed :>)
>
> >
> > > +   lock, page faults can race against you even if you hold an mmap w=
rite lock.
> > > +
> > > +VMA Fields
> > > +----------
> > > +
> > > +We examine each field of the `struct vm_area_struct` type in detail =
in the table
> > > +below.
> > > +
> > > +Reading of each field requires either an mmap read lock or a VMA rea=
d lock to be
> > > +held, except where 'unstable RCU read' is specified, in which case u=
nstable
> > > +access to the field is permitted under RCU alone.
> > > +
> > > +The table specifies which write locks must be held to write to the f=
ield.
> > > +
> > > +.. list-table::
> > > +   :widths: 20 10 22 5 20
> > > +   :header-rows: 1
> > > +
> > > +   * - Field
> > > +     - Config
> > > +     - Description
> > > +     - Unstable RCU read?
> > > +     - Write Lock
> > > +   * - vm_start
> > > +     -
> > > +     - Inclusive start virtual address of range VMA describes.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - vm_end
> > > +     -
> > > +     - Exclusive end virtual address of range VMA describes.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - vm_rcu
> > > +     - vma lock
> > > +     - RCU list head, in union with vma_start, vma_end. RCU implemen=
tation detail.
> > > +     - N/A
> > > +     - N/A
> > > +   * - vm_mm
> > > +     -
> > > +     - Containing mm_struct.
> > > +     - Y
> > > +     - (Static)
> > > +   * - vm_page_prot
> > > +     -
> > > +     - Architecture-specific page table protection bits determined f=
rom VMA
> > > +       flags
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - vm_flags
> > > +     -
> > > +     - Read-only access to VMA flags describing attributes of VMA, i=
n union with
> > > +       private writable `__vm_flags`.
> > > +     -
> > > +     - N/A
> > > +   * - __vm_flags
> > > +     -
> > > +     - Private, writable access to VMA flags field, updated by vm_fl=
ags_*()
> > > +       functions.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - detached
> > > +     - vma lock
> > > +     - VMA lock implementation detail - indicates whether the VMA ha=
s been
> > > +       detached from the tree.
> > > +     - Y
> > > +     - mmap write, VMA write
> > > +   * - vm_lock_seq
> > > +     - vma lock
> > > +     - VMA lock implementation detail - A sequence number used to se=
rialise the
> > > +       VMA lock, see the VMA lock section below.
> > > +     - Y
> > > +     - mmap write, VMA write
> >
> > It's a bit weird to state that VMA write-lock is required when talking
> > about vm_lock_seq/vm_lock themselves being parts of that lock. I would
> > simply say N/A for both of them since they should not be modified
> > directly.
>
> Ack will adjust.
>
> >
> > > +   * - vm_lock
> > > +     - vma lock
> > > +     - VMA lock implementation detail - A pointer to the VMA lock re=
ad/write
> > > +       semaphore.
> > > +     - Y
> > > +     - None required
> > > +   * - shared.rb
> > > +     -
> > > +     - A red/black tree node used, if the mapping is file-backed, to=
 place the
> > > +       VMA in the `struct address_space->i_mmap` red/black interval =
tree.
> > > +     -
> > > +     - mmap write, VMA write, i_mmap write
> > > +   * - shared.rb_subtree_last
> > > +     -
> > > +     - Metadata used for management of the interval tree if the VMA =
is
> > > +       file-backed.
> > > +     -
> > > +     - mmap write, VMA write, i_mmap write
> > > +   * - anon_vma_chain
> > > +     -
> > > +     - List of links to forked/CoW'd `anon_vma` objects.
> > > +     -
> > > +     - mmap read or above, anon_vma write lock
> >
> > nit: I would spell it out for clarity: mmap read or write
>
> Ack will fix
>
> >
> > > +   * - anon_vma
> > > +     -
> > > +     - `anon_vma` object used by anonymous folios mapped exclusively=
 to this VMA.
> > > +     -
> > > +     - mmap read or above, page_table_lock
> > > +   * - vm_ops
> > > +     -
> > > +     - If the VMA is file-backed, then either the driver or file-sys=
tem provides
> > > +       a `struct vm_operations_struct` object describing callbacks t=
o be invoked
> > > +       on specific VMA lifetime events.
> > > +     -
> > > +     - (Static)
> > > +   * - vm_pgoff
> > > +     -
> > > +     - Describes the page offset into the file, the original page of=
fset within
> > > +       the virtual address space (prior to any `mremap()`), or PFN i=
f a PFN map.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - vm_file
> > > +     -
> > > +     - If the VMA is file-backed, points to a `struct file` object d=
escribing
> > > +       the underlying file, if anonymous then `NULL`.
> > > +     -
> > > +     - (Static)
> > > +   * - vm_private_data
> > > +     -
> > > +     - A `void *` field for driver-specific metadata.
> > > +     -
> > > +     - Driver-mandated.
> > > +   * - anon_name
> > > +     - anon name
> > > +     - A field for storing a `struct anon_vma_name` object providing=
 a name for
> > > +       anonymous mappings, or `NULL` if none is set or the VMA is fi=
le-backed.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - swap_readahead_info
> > > +     - swap
> > > +     - Metadata used by the swap mechanism to perform readahead.
> > > +     -
> > > +     - mmap read
> > > +   * - vm_region
> > > +     - nommu
> > > +     - The containing region for the VMA for architectures which do =
not
> > > +       possess an MMU.
> > > +     - N/A
> > > +     - N/A
> > > +   * - vm_policy
> > > +     - numa
> > > +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - numab_state
> > > +     - numab
> > > +     - `vma_numab_state` object which describes the current state of=
 NUMA
> > > +       balancing in relation to this VMA.
> > > +     -
> > > +     - mmap write, VMA write
> > > +   * - vm_userfaultfd_ctx
> > > +     -
> > > +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ct=
x`, either
> > > +       of zero size if userfaultfd is disabled, or containing a poin=
ter to an
> > > +       underlying `userfaultfd_ctx` object which describes userfault=
fd metadata.
> > > +     -
> > > +     - mmap write, VMA write
> > > +
> > > +.. note::
> > > +
> > > +   In the config column 'vma lock' configuration means CONFIG_PER_VM=
A_LOCK,
> > > +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP,=
 'nommu'
> > > +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'n=
umab' means
> > > +   CONFIG_NUMA_BALANCING'.
> > > +
> > > +   In the write lock column '(Static)' means that the field is set o=
nly once
> > > +   upon initialisation of the VMA and not changed after this, the VM=
A would
> > > +   either have been under an mmap write and VMA write lock at the ti=
me or not
> > > +   yet inserted into any tree.
> > > +
> > > +Page table locks
> > > +----------------
> > > +
> > > +When allocating a P4D, PUD or PMD and setting the relevant entry in =
the above
> > > +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. Thi=
s is
> > > +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` res=
pectively.
> > > +
> > > +.. note::
> > > +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()`=
 in turn,
> > > +   however at the time of writing it ultimately references the
> > > +   `mm->page_table_lock`.
> > > +
> > > +Allocating a PTE will either use the `mm->page_table_lock` or, if
> > > +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD =
physical
> > > +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptd=
esc()`
> > > +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> > > +
> > > +Finally, modifying the contents of the PTE has special treatment, as=
 this is a
> > > +lock that we must acquire whenever we want stable and exclusive acce=
ss to
> > > +entries pointing to data pages within a PTE, especially when we wish=
 to modify
> > > +them.
> > > +
> > > +This is performed via `pte_offset_map_lock()` which carefully checks=
 to ensure
> > > +that the PTE hasn't changed from under us, ultimately invoking `pte_=
lockptr()`
> > > +to obtain a spin lock at PTE granularity contained within the `struc=
t ptdesc`
> > > +associated with the physical PTE page. The lock must be released via
> > > +`pte_unmap_unlock()`.
> > > +
> > > +.. note::
> > > +   There are some variants on this, such as `pte_offset_map_rw_noloc=
k()` when we
> > > +   know we hold the PTE stable but for brevity we do not explore thi=
s.
> > > +   See the comment for `__pte_offset_map_lock()` for more details.
> > > +
> > > +When modifying data in ranges we typically only wish to allocate hig=
her page
> > > +tables as necessary, using these locks to avoid races or overwriting=
 anything,
> > > +and set/clear data at the PTE level as required (for instance when p=
age faulting
> > > +or zapping).
> > > +
> > > +Page table teardown
> > > +-------------------
> > > +
> > > +Tearing down page tables themselves is something that requires signi=
ficant
> > > +care. There must be no way that page tables designated for removal c=
an be
> > > +traversed or referenced by concurrent tasks.
> > > +
> > > +It is insufficient to simply hold an mmap write lock and VMA lock (w=
hich will
> > > +prevent racing faults, and rmap operations), as a file-backed mappin=
g can be
> > > +truncated under the `struct address_space` i_mmap_lock alone.
> > > +
> > > +As a result, no VMA which can be accessed via the reverse mapping (e=
ither
> > > +anon_vma or the `struct address_space->i_mmap` interval tree) can ha=
ve its page
> > > +tables torn down.
> > > +
> > > +The operation is typically performed via `free_pgtables()`, which as=
sumes either
> > > +the mmap write lock has been taken (as specified by its `mm_wr_locke=
d`
> > > +parameter), or that it the VMA is fully detached.
> > > +
> > > +It carefully removes the VMA from all reverse mappings, however it's=
 important
> > > +that no new ones overlap these or any route remain to permit access =
to addresses
> > > +within the range whose page tables are being torn down.
> > > +
> > > +As a result of these careful conditions, note that page table entrie=
s are
> > > +cleared without page table locks, as it is assumed that all of these=
 precautions
> > > +have already been taken.
> > > +
> > > +mmap write lock downgrading
> > > +---------------------------
> > > +
> > > +While it is possible to obtain an mmap write or read lock using the
> > > +`mm->mmap_lock` read/write semaphore, it is also possible to **downg=
rade** from
> > > +a write lock to a read lock via `mmap_write_downgrade()`.
> > > +
> > > +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA=
 write locks
> > > +via `vma_end_write_all()` (more or this behaviour in the VMA lock in=
ternals
> > > +section below), but importantly does not relinquish the mmap lock wh=
ile
> > > +downgrading, therefore keeping the locked virtual address space stab=
le.
> > > +
> > > +A subtlety here is that callers can assume, if they invoke an
> > > +mmap_write_downgrade() operation, that they still have exclusive acc=
ess to the
> > > +virtual address space (excluding VMA read lock holders), as for anot=
her task to
> > > +have downgraded they would have had to have exclusive access to the =
semaphore
> > > +which can't be the case until the current task completes what it is =
doing.
> >
> > I can't decipher the above paragraph. Could you please dumb it down
> > for the likes of me?
>
> Since you're smarter than me this indicates I am not being clear here :)
> Actually reading this again I've not expressed this correctly.
>
> This is something Jann mentioned, that I hadn't thought of before.
>
> So if you have an mmap write lock, you have exclusive access to the mmap
> (with the usual caveats about racing vma locks unless you vma write lock)=
.
>
> When you downgrade you now have a read lock - but because you were
> exclusive earlier in the function AND any new caller of the function will
> have to acquire that same write lock FIRST, they all have to wait on you
> and therefore you have exclusive access to the mmap only with a read map.
>
> So you are actually guaranteed that nobody else can be racing you _in tha=
t
> function_, and equally no other writers can arise until you're done as yo=
ur
> holding the read lock prevents that.

I guess you could simplify this description by saying that downgrading
a write-lock to read-lock still guarantees that there are no writers
until you drop that read-lock.

>
> Jann - correct me if I'm wrong or missing something here.
>
> Will correct this unless Jann tells me I'm missing something on this :)
>
> >
> > > +
> > > +Stack expansion
> > > +---------------
> > > +
> > > +Stack expansion throws up additional complexities in that we cannot =
permit there
> > > +to be racing page faults, as a result we invoke `vma_start_write()` =
to prevent
> > > +this in `expand_downwards()` or `expand_upwards()`.
> > > +
> > > +Lock ordering
> > > +-------------
> > > +
> > > +As we have multiple locks across the kernel which may or may not be =
taken at the
> > > +same time as explicit mm or VMA locks, we have to be wary of lock in=
version, and
> > > +the **order** in which locks are acquired and released becomes very =
important.
> > > +
> > > +.. note::
> > > +
> > > +   Lock inversion occurs when two threads need to acquire multiple l=
ocks,
> > > +   but in doing so inadvertently cause a mutual deadlock.
> > > +
> > > +   For example, consider thread 1 which holds lock A and tries to ac=
quire lock B,
> > > +   while thread 2 holds lock B and tries to acquire lock A.
> > > +
> > > +   Both threads are now deadlocked on each other. However, had they =
attempted to
> > > +   acquire locks in the same order, one would have waited for the ot=
her to
> > > +   complete its work and no deadlock would have occurred.
> > > +
> > > +The opening comment in `mm/rmap.c` describes in detail the required =
ordering of
> > > +locks within memory management code:
> > > +
> > > +.. code-block::
> > > +
> > > +  inode->i_rwsem       (while writing or truncating, not reading or =
faulting)
> > > +    mm->mmap_lock
> > > +      mapping->invalidate_lock (in filemap_fault)
> > > +        folio_lock
> > > +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlb=
fs below)
> > > +            vma_start_write
> > > +              mapping->i_mmap_rwsem
> > > +                anon_vma->rwsem
> > > +                  mm->page_table_lock or pte_lock
> > > +                    swap_lock (in swap_duplicate, swap_info_get)
> > > +                      mmlist_lock (in mmput, drain_mmlist and others=
)
> > > +                      mapping->private_lock (in block_dirty_folio)
> > > +                          i_pages lock (widely used)
> > > +                            lruvec->lru_lock (in folio_lruvec_lock_i=
rq)
> > > +                      inode->i_lock (in set_page_dirty's __mark_inod=
e_dirty)
> > > +                      bdi.wb->list_lock (in set_page_dirty's __mark_=
inode_dirty)
> > > +                        sb_lock (within inode_lock in fs/fs-writebac=
k.c)
> > > +                        i_pages lock (widely used, in set_page_dirty=
,
> > > +                                  in arch-dependent flush_dcache_mma=
p_lock,
> > > +                                  within bdi.wb->list_lock in __sync=
_single_inode)
> > > +
> > > +Please check the current state of this comment which may have change=
d since the
> > > +time of writing of this document.
> > > +
> > > +VMA lock internals
> > > +------------------
> > > +
> > > +The VMA lock mechanism is designed to be a lightweight means of avoi=
ding the use
> > > +of the heavily contended mmap lock. It is implemented using a combin=
ation of a
> > > +read/write semaphore and sequence numbers belonging to the containin=
g `struct
> > > +mm_struct` and the VMA.
> > > +
> > > +Read locks are acquired via `vma_start_read()`, which is an optimist=
ic
> > > +operation, i.e. it tries to acquire a read lock but returns false if=
 it is
> > > +unable to do so. At the end of the read operation, `vma_end_read()` =
is called to
> > > +release the VMA read lock. This can be done under RCU alone.
> > > +
> > > +Writing requires the mmap to be write-locked and the VMA lock to be =
acquired via
> > > +`vma_start_write()`, however the write lock is released by the termi=
nation or
> > > +downgrade of the mmap write lock so no `vma_end_write()` is required=
.
> > > +
> > > +All this is achieved by the use of per-mm and per-VMA sequence count=
s. This is
> > > +used to reduce complexity, and potential especially around operation=
s which
> >
> > potential?
>
> Yeah sorry this sentence is completely mangled, will fix!
>
> >
> > > +write-lock multiple VMAs at once.
> > > +
> > > +If the mm sequence count, `mm->mm_lock_seq` is equal to the VMA sequ=
ence count
> > > +`vma->vm_lock_seq` then the VMA is write-locked. If they differ, the=
n they are
> > > +not.
> > > +
> > > +Each time an mmap write lock is acquired in `mmap_write_lock()`,
> > > +`mmap_write_lock_nested()`, `mmap_write_lock_killable()`, the `mm->m=
m_lock_seq`
> > > +sequence number is incremented via `mm_lock_seqcount_begin()`.
> > > +
> > > +Each time the mmap write lock is released in `mmap_write_unlock()` o=
r
> > > +`mmap_write_downgrade()`, `vma_end_write_all()` is invoked which als=
o increments
> > > +`mm->mm_lock_seq` via `mm_lock_seqcount_end()`.
> > > +
> > > +This way, we ensure regardless of the VMA's sequence number count, t=
hat a write
> > > +lock is not incorrectly indicated (since we increment the sequence c=
ounter on
> > > +acquiring the mmap write lock, which is required in order to obtain =
a VMA write
> > > +lock), and that when we release an mmap write lock, we efficiently r=
elease
> > > +**all** VMA write locks contained within the mmap at the same time.
> >
> > Ok, I see that you describe some of the rules I mentioned before here.
> > Up to you where to place them.
>
> Yeah may rearrange a little in general to clear things up a bit.
>
> I wanted a bit on the internals here, but then I end up mentioning so muc=
h
> of this above that maybe it's a bit duplicative... let's see how I do on
> the respin :)
>
> >
> > > +
> > > +The exclusivity of the mmap write lock ensures this is what we want,=
 as there
> > > +would never be a reason to persist per-VMA write locks across multip=
le mmap
> > > +write lock acquisitions.
> > > +
> > > +Each time a VMA read lock is acquired, we acquire a read lock on the
> > > +`vma->vm_lock` read/write semaphore and hold it, while checking that=
 the
> > > +sequence count of the VMA does not match that of the mm.
> > > +
> > > +If it does, the read lock fails. If it does not, we hold the lock, e=
xcluding
> > > +writers, but permitting other readers, who will also obtain this loc=
k under RCU.
> > > +
> > > +Importantly, maple tree operations performed in `lock_vma_under_rcu(=
)` are also
> > > +RCU safe, so the whole read lock operation is guaranteed to function=
 correctly.
> > > +
> > > +On the write side, we acquire a write lock on the `vma->vm_lock` rea=
d/write
> > > +semaphore, before setting the VMA's sequence number under this lock,=
 also
> > > +simultaneously holding the mmap write lock.
> > > +
> > > +This way, if any read locks are in effect, `vma_start_write()` will =
sleep until
> > > +these are finished and mutual exclusion is achieved.
> > > +
> > > +After setting the VMA's sequence number, the lock is released, avoid=
ing
> > > +complexity with a long-term held write lock.
> > > +
> > > +This clever combination of a read/write semaphore and sequence count=
 allows for
> > > +fast RCU-based per-VMA lock acquisition (especially on x86-64 page f=
ault, though
> > > +utilised elsewhere) with minimal complexity around lock ordering.
> > > --
> > > 2.47.0
> > >
>
> Thanks for the review! Will try to clarify and tighten things up generall=
y
> on top of the points you and the other reviewers have raised here and
> hopefully v2 should be nice and sharp!

Sounds good! I think it would be good to separate design decisions (mm
should be write-locked before any VMA can be write-locked, all
write-locked VMAs and automatically unlocked once mm is
write-unlocked, etc) vs implementation details (lock_vma_under_rcu(),
vma->vm_lock_seq, mm->mm_lock_seq, etc). Easily said than done :)

