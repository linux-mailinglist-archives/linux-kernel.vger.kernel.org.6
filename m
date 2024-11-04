Return-Path: <linux-kernel+bounces-395581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8A9BC014
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644FB2828D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581E1CDFBE;
	Mon,  4 Nov 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zf3zqZJK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2468171D2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755828; cv=none; b=QF06kmNXv8QoBxq8fsu6adGXHPtAUyd7IqfjBY2w93SYxCWk5+xVqo/O5mqFYBDDyxiLKn4NmqAWS8sEGuUFWAYa5RFUumq1mSmHHMqgYzmwvD+uK1oPVRdvzzg2UoUR8j2bq4RuV6fJSiwR9xf14VKphyuG7sfYeoZgd3brWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755828; c=relaxed/simple;
	bh=8hFr2zE7kjA4JQ1h+/hoF7nQLxhXHFDx09rwX2NDJ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVO9Wc+TyOCd6ivqkdep4MW+NMNvMIqk30/I6NBApElQoXGvlyC4uz7d6hiH1NPn/iJgTXe+qxns/6d+h/msZS//becKz0Jop+fYyhWhprONnrh6JYXFk577YsLduTEOyeYhJpvS9tlICZLfvLnIjcQtbtwqPriL1YaXL2Kd5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zf3zqZJK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so68735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730755824; x=1731360624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrZQ8odHz7T5pJ1yUykc5cF0G0mFDa/60nkt90A3Dgk=;
        b=zf3zqZJKDFfgtveV12cl5o5gRGSDe+orrEPF1BG1ed8YW2wy8JlLPr3F5jyTKD0Hb7
         SJvc86mSjKbkjYiIZv9H7vKmWWhHlJhar1byOCxVONu1rn8Ppyy07ZdDQgSB1QupQQrk
         fxUAEyy7fxpAOoiSSp0NJ2zY8sLcAKm80nQ4KC7rBPLXnAgnIeMN/jNOu29Zjxh8qWGP
         7+MuJ0hrWKej+XDZGjiKV6mbL6jq2D/584PMaRB0AkpKKzeLZ7x50XJVh3y62NNDUYxL
         Q7rhL39fMimfd9NHwJ7kwH9PP3h+HIPBz6mk4EUyJfvQ397F33Jj/2xSIVG83oLjYcu8
         xvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755824; x=1731360624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrZQ8odHz7T5pJ1yUykc5cF0G0mFDa/60nkt90A3Dgk=;
        b=M9tmTCnnO36uM6NyP5eBWLyBfJVBwxe+OyUbwLjqDPaQzICHQEHjp+sY7xCHUMEn0+
         NIhmcgJB+pnO0IEg8frb96w6MTtA5v0TRZBr5JhsozQZ9jWnVBSeUbnB7qVPCkjof2KU
         toTOQwVi9GK/An1mF4BGMtIZ+HzFPu1hBkHLyZf1xukoO5XoOmhnWr9NH1/PUTD7sKHs
         b0isEoPCzvT6rB2n49v5GpzJV6WIFuXTnL8Zq/xMCxi5Y8JUHSDhZSgnHPkyisNPGsPe
         X4IzhU38+8ravkKJrtluqkLNhB4wamx4my3d0VQx16A4+/oH2Wd/ZG2ln+qgbSZ9nsYl
         +CJw==
X-Forwarded-Encrypted: i=1; AJvYcCXzPY73+ElMUroCbLORn6vS1q1wpOtCCx63zJ0wdzBkf3xjDJ2IdI3df1c8wosU++a8pxJjTZ/eWyrRUDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvQn4y5ohygzEeWTKoPajvRr6RnWKXJfAmWQHcWS9lhni8Nir
	D3Kpff0qCEXgRYUnoEjj2zEmP6WR3LLjEjHQcSreQBI8MHomg/7oBJXI2ElO96TzyZ0rjcxmBJA
	jxeCMdPTPHmRayGgf7Jy0QHjUBD+rFSa8DKbN
X-Gm-Gg: ASbGncvX/6SdyZSmqWxKvG2dOoRF82GeQFmoA2TLF59UA0hKaAdlyseNnBzkEVQ//8/
	XoXsG1qj7Pyrufq9a6egm1LcEc1KAEd2M3sCa2/t6em8z0AK+5Kr4BUOo0/I=
X-Google-Smtp-Source: AGHT+IEFec3SuZdd3Wqunl4uv5SN7O/rmx/3FcYQ4fY74ij2I8wiKIHn5MFlgQPcJwtYH0hcnYvo7tCXgWYy/NGv9DM=
X-Received: by 2002:a05:600c:6c4e:b0:426:7018:2e2f with SMTP id
 5b1f17b1804b1-432a2db56cemr108005e9.5.1730755823666; Mon, 04 Nov 2024
 13:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com> <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
In-Reply-To: <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 4 Nov 2024 22:29:47 +0100
Message-ID: <CAG48ez1eeQatc0GC_hfOM_mvwjwQ=89JDmp_U5_diLy7ycjEdQ@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 5:42=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
> > On Fri, Nov 1, 2024 at 7:50=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
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
> >
> > The gate VMA is special, on architectures that have it: Userland
> > access to its area is allowed, but the area is outside the VA range
> > managed by the normal MM code, and the gate VMA is a global object
> > (not per-MM), and only a few places in MM code can interact with it
> > (for example, page fault handling can't, but GUP can through
> > get_gate_page()).
> >
> > (I think this also has the fun consequence that vm_normal_page() can
> > get called on a VMA whose ->vm_mm is NULL, when called from
> > get_gate_page().)
>
> Yeah the gate page is weird, I'm not sure it's worth going into too much =
detail
> here, but perhaps a note explaining in effect 'except for the gate page..=
'
> unless you think it'd be valuable to go into that in more detail than a p=
assing
> 'hey of course there's an exception to this!' comment? :)

Yeah I think that's good enough.

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

(maybe also note more clearly here that "read" is talking about the
VMA metadata, so an operation that writes page table entries normally
counts as "read")

> > > +   Finally, we have locks which permit exclusive access to the VMA t=
o allow for
> > > +   **writes** to the VMA.
> >
> > Maybe also mention that there are three major paths you can follow to
> > reach a VMA? You can come through the mm's VMA tree, you can do an
> > anon page rmap walk that goes page -> anon_vma -> vma, or you can do a
> > file rmap walk from the address_space. Which is why just holding the
> > mmap lock and vma lock in write mode is not enough to permit arbitrary
> > changes to a VMA struct.
>
> I totally agree that adding something about _where_ you can come from is =
a good
> idea, will do.
>
> However, in terms of the VMA itself, mmap lock and vma lock _are_ suffici=
ent to
> prevent arbitrary _changes_ to the VMA struct right?

Yes. But the sentence "Finally, we have locks which permit exclusive
access to the VMA to allow for **writes** to the VMA" kinda sounds as
if there is a single lock you can take that allows you to write to the
VMA struct.

> It isn't sufficient to prevent _reading_ of vma metadata fields, nor walk=
ing of
> underlying page tables, so if you're going to do something that changes
> fundamentals you need to hide it from rmap.
>
> Maybe worth going over relevant fields? Or rather adding an additional 'r=
ead
> lock' column?
>
> vma->vm_mm ('static' anyway after VMA created)
> vma->vm_start (change on merge/split)

and on stack expansion :P
But I guess nowadays that's basically semantically just a special case
of merge, so no need to explicitly mention it here...

> vma->vm_end (change on merge/split)
> vma->vm_flags (can change)
> vma->vm_ops ('static' anyway after call_mmap())
>
> In any case this is absolutely _crucial_ I agree, will add.
>
> >
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
> > uffd_move_lock() calls lock_vma_under_rcu() after having already
> > VMA-locked another VMA with uffd_lock_vma().
>
> Oh uffd, how we love you...
>
> I think it might be worth adding a note for this exception. Obviously the=
y do
> some pretty careful manipulation to avoid issues here so probably worth s=
aying
> 'hey except uffd'

I guess another way to write it would be something like:

"Taking the mmap lock in read mode while you're holding a vma lock is
forbidden because it can deadlock. Calling lock_vma_under_rcu()
normally only makes sense when you're not holding the mmap lock
(otherwise it would be redundant). lock_vma_under_rcu() has trylock
semantics, and if it fails you need a plan B (which normally is to
take the mmap lock in read mode instead; notably this would get more
annoying if you were already holding another VMA lock, because then
you'd have to drop that first)."?

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
> >
> > vm_start, vm_end and vm_pgoff also require that the associated
> > address_space and anon_vma (if applicable) are write-locked, and that
> > their rbtrees are updated as needed.
>
> Surely vm_flags too...

Nah, there are a bunch of madvise() operations that change vm_flags,
and at least the simple ones don't touch rmap locks (I don't know if
maybe any of the more complex ones do). See MADV_DONTFORK, for example
- we basically just take the mmap lock in write mode, write-lock the
VMA, and overwrite the flags.

Not even do_mprotect_pkey() takes rmap locks! Just takes the mmap lock
in write mode, write-locks the VMA, changes the VM flags, and then
fixes up all the existing PTEs.

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
> >
> > I think task_numa_work() is only holding the mmap lock in read mode
> > when it sets this pointer to a non-NULL value.
>
> ugh lord... knew I'd get at least one of these wrong :P

to be fair I think task_numa_work() looks kinda dodgy ^^ I remember
spending quite a bit of time staring at it at one point (my very
sparse notes suggest I was looking in that area because I was
surprised that change_protection() can run with the mmap lock only
read-locked for some NUMA hinting fault stuff); I don't remember
whether I concluded that the ->vma_numab_state locking in
task_numa_work() is fine or just not overly terrible...

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
> > >+
> > > +Finally, modifying the contents of the PTE has special treatment, as=
 this is a
> > > +lock that we must acquire whenever we want stable and exclusive acce=
ss to
> > > +entries pointing to data pages within a PTE, especially when we wish=
 to modify
> > > +them.
> >
> > I guess one other perspective on this would be to focus on the
> > circumstances under which you're allowed to write entries:
> >
> > 0. page tables can be concurrently read by hardware and GUP-fast, so
> > writes must always be appropriately atomic
>
> Yeah I definitely need to mention GUP-fast considerations (and consequent=
ly
> the pXX_lockless..() functions). Thanks for raising that,  important one.
>
> > 1. changing a page table entry always requires locking the containing
> > page table (except when the write is an A/D update by hardware)
>
> I think we can ignore the hardware writes altogether, though I think wort=
h
> adding a 'note' to explain this can happen outside of this framework
> altogether.

I think it's important to know about the existence of hardware writes
because it means you need atomic operations when making changes to
page tables. Like, for example, in many cases when changing a present
PTE, you can't even use READ_ONCE()/WRITE_ONCE() for PTEs and need
atomic RMW operations instead - see for example ptep_get_and_clear(),
which is basically implemented in arch code as an atomic xchg so that
it can't miss concurrent A/D bit updates.

(The non-SMP version of that on X86 doesn't use atomics, I have no
idea if that is actually correct or just mostly-working. Either way, I
guess the !SMP build doesn't matter very much nowadays.)

> > 2. in page tables higher than PMD level, page table entries that point
> > to page tables can only be changed to point to something else when
> > holding all the relevant high-level locks leading to the VMA in
> > exclusive mode: mmap lock (unless the VMA is detached), VMA lock,
> > anon_vma, address_space
>
> Right this seems mremap()-specific when you say 'change' here :) and of
> course, we have code that explicitly does this (take_rmap_locks() +
> drop_rmap_locks()).

munmap and mremap, yes. Basically what I'm trying to express with this
is "as a reader, you can assume that higher page tables are stable
just by having some kind of read lock on the VMA or its rmaps".

(IIRC back when this was the rule for all page table levels,
khugepaged used to do this too, write-locking both the rmap and the
mm.)

> > 3. PMD entries that point to page tables can be changed while holding
> > the page table spinlocks for the entry and the table it points to
>
> Hm wut? When you say 'entry' what do you mean? Obviously a page table in

By "PMD entry" I mean a pmd_t (located in a Page Middle Directory),
and by "that point to page tables" I mean "that point to a PTE-level
page table".

In other words, from the reader perspective (as I think you already
mentioned further down):

Rule 2 means: From the perspective of a reader who is holding the VMA
lock in read mode, once you have seen that e.g. a PUD entry
(overlapping the VMA's virtual address region) points to a PMD page
table, you know that this PUD entry will keep pointing to that PMD
table.

Rule 3 means: From the perspective of a reader who is holding the VMA
lock in read mode, once you have seen that a PMD entry (overlapping
the VMA's virtual address region) points to a page table, you don't
know whether this PMD entry will keep pointing to the same page table
unless you're also holding a spinlock on either the PMD or the page
table (because khugepaged).

> theory could be changed at any point you don't have it locked and to be
> sure it hasn't you have to lock + check again.


> > 5. entries in "none" state can only be populated with leaf entries
> > while holding the mmap or vma lock (doing it through the rmap would be
> > bad because that could race with munmap() zapping data pages in the
> > region)
> > 6. leaf entries can be zapped (changed to "none") while holding any
> > one of mmap lock, vma lock, address_space lock, or anon_vma lock
>
> For both 5 and 6 - I'm not sure if we ever zap without holding the mmap
> lock do we?
>
> Unless you're including folio_mkclean() and pfn_mkclean_range()? I guess
> this is 'strike of the linux kernel terminology' once again :P
>
> Yeah in that case sure.

There are a bunch of paths that zap without taking the mmap lock, the
easiest to reach is probably the ftruncate() syscall:

do_sys_ftruncate -> do_ftruncate -> do_truncate -> notify_change ->
simple_setattr -> truncate_setsize -> truncate_pagecache ->
unmap_mapping_range -> unmap_mapping_pages -> unmap_mapping_range_tree
-> {loop over file rmap tree} -> unmap_mapping_range_vma ->
zap_page_range_single

GPU drivers and such do it too, search for "unmap_mapping_range".

But you're right, I was being imprecise - as you pointed out, it's not
just used for zapping. Maybe the right version of 6 is something like:

    Leaf entries that are not in "none" state can
    be changed while holding any one of [...].

Though I'm not sure if that is overly broad - I think in practice the
changes we make under the rmap locks are something like the following,
though that might be missing some:

 - zapping leaf entries
 - zapping PMD entries pointing to page tables
 - clearing A/D bits
 - migration

> OK so interestingly this really aligns with what Alice said as to this no=
t
> giving a clear indicator from a user's perspective as to 'what lock do I
> need to hold'.
>
> So I will absolutely address all this and try to get the fundamentals
> boiled down.
>
> Also obviously the exception to your rules are - _freeing_ of higher leve=
l
> page tables because we assume we are in a state where nothing can access
> them so no such locks are required. But I cover that below.
>
> >
> > And then the rules for readers mostly follow from that:
> > 1 =3D> holding the appropriate page table lock makes the contents of a
> > page table stable, except for A/D updates
> > 2 =3D> page table entries higher than PMD level that point to lower pag=
e
> > tables can be followed without taking page table locks
>
> Yeah this is true actually, might be worth mentioning page table walkers
> here and how they operate as they're instructive on page table locking
> requirements.
>
> > 3+4 =3D> following PMD entries pointing to page tables requires careful
> > locking, and pte_offset_map_lock() does that for you
>
> Well, pte_offset_map_lock() is obtained at the PTE level right?

pte_offset_map_lock() is given a pointer to a PMD entry, and it
follows the PMD entry to a PTE-level page table. My point here is that
you can't just simply start a "lock this PTE-level page table"
operation at the PTE level because by the time you've locked the page
table, the PMD entry may have changed, and the page table you just
locked may be empty and doomed to be deleted after RCU delay. So you
have to use __pte_offset_map_lock(), which takes a pointer to a PMD
entry, and in a loop, looks up the page table from the PMD entry,
locks the referenced page table, rechecks that the PMD entry still
points to the locked page table, and if not, retries all these steps
until it manages to lock a stable page table.

> pmd_lock() at the PMD level (pud_lock() ostensibly at PUD level but this
> amounts to an mm->page_table_lock anyway there)

> > I think something like
> > https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#overvi=
ew-documentation-comments
> > is supposed to let you include the current version of the comment into
> > the rendered documentation HTML without having to manually keep things
> > in sync. I've never used that myself, but there are a bunch of
> > examples in the tree; for example, grep for "DMA fences overview".
>
> Ah, but this isn't a kernel doc is just a raw comment :) so I'm not sure =
there
> is a great way of grabbing just that, reliably. Maybe can turn that into =
a
> kernel doc comment in a follow up patch or something?

Ah, yeah, sounds reasonable.

