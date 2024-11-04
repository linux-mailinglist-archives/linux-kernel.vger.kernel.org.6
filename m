Return-Path: <linux-kernel+bounces-395251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD69BBAEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BED1F220D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2991C7274;
	Mon,  4 Nov 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xb7YmW/A"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C81C07C0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739721; cv=none; b=GjXDckCjY0GPuMX6rUUufzbnPN9qJxduWxVI00dQzah8AiYRQBI1MIAd/gWSLANDtYyvfz4npUj0ISMePr6+H1JP+T6GEC80mNLDDmR0w1c+C/aq30X4qYhcmfotW9XgU9+Mmmse0FUOKerzykv6Haf9tIGDInFAiEw2/ztpJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739721; c=relaxed/simple;
	bh=4Nqu0IyUGrdo/TMqsYqphr44ZurJx1aGk59RRt/I34s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrqFD8cSInoQKHuYTzwsjq1D8KMcN+kfcysK4uAiRi75HNSwzRaFuT5ZR8hTtMOodFN6fnZXhivBvOA61A+FY1zRXvboawGiJNAdCCKJWUP08Nx+yWWry6UlVvqtw7sJP+lV+oRlreKenRNG9gf2NbS0+Rdo2T0mLyENuZVtaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xb7YmW/A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso322835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730739719; x=1731344519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qjsI9ftlsbJhkwV12cYtnTjEQSLD/1hzV3fXCn877I=;
        b=xb7YmW/A6HWOi99eFSDAQ30Lw3tfhDNqdLqPZy6525PnNmc9s+syKcKkqAQHcft+kC
         QciDu6/qY4C8Xh04OdyWilpK3ZDzHeYUcN7KThxCxk0Aol/cOqdAILxpxd1dGrglcizY
         8STN6afcR5h7cFfVlMHGPrG2VzuFU6vVmt6Rtqa/CRDVN3EDVuHXnewHKQeKvWlrtgRf
         DQnafssXJvfaty8jWA/Pyd7SP+csaSj5GtjwxkRZN2mHbvLCUET8pl71RxxMkvv+prBV
         aJ9HMcj8OE9ZgJI+4M1N9VMyLkudqDTGHT3ikltkM93DfPZMPhsT5tEjjQ80rZDfTSQl
         zCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739719; x=1731344519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qjsI9ftlsbJhkwV12cYtnTjEQSLD/1hzV3fXCn877I=;
        b=khTEByOjvwCaBJvCjpRdELtd8SG4CNxRMAv8m6dViH0N5ipQEDEu+CPzNmp3bbNUhX
         TmMmCCQmHVkuX0fssgU48AB6krz9jRKef9DcuH6tP2YJ2OKi/m/tJHb9iedvrdjipicE
         abO4u/hnE5nEB5TIhACksqRTV0YDYaG/yoLoDePog8qhZQhe+yicAy+K1jbfABrEJEro
         HJDcKeU+N1iDLe3OZ1O2BwGZdRu7nAZwxP2H4x1qN9jMXN7rjteLOxD/5d/i5nhePtu1
         tDXexH3z/WlD0GOB9mYhysMS6gZ6drTzbVcNdP0P5inM1rSKasILmdh+qdmhKKNVpaJ/
         IO3w==
X-Forwarded-Encrypted: i=1; AJvYcCU1UeR+oM7b32vdF5H5nGAzyfDvmdsN3o/LWCTpdmiKyt7qfD1f3KJ2/Quxzldk34PAPPm2rEg0SMmY7Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHgabPlCc0EeWgqBdTk1hWHoI9YzGJAQ+uIrfLFnGC2F9lWyq
	KH5mU4307Qz+9KkmNtO6nKGkREN4m4bhjZNspOh6EoFRlPXHDlpJN5Kx+wuks6WZu66tMHb2DXd
	xWigowJ15C8j4kJLEV+33iYIh52zz1qK0NQN5
X-Gm-Gg: ASbGnctg0eRGrajcirs77L79SHuMs9tpLiPuh+4MyhvEbluEmiK9D28efG6hiiqDFed
	x0s5JQLa0jgd3VqVHE9JB9dIzSVJZIh4=
X-Google-Smtp-Source: AGHT+IHFp5kd55de15bGzOG33UjHfRpTsgQbFIO24bUAubuiqL6WoiQpih9q7DBWzNBEmnLr14ZAORcaZbKIk8pY+b8=
X-Received: by 2002:a17:902:ea01:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-21134d36b88mr4160945ad.21.1730739717591; Mon, 04 Nov 2024
 09:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Nov 2024 09:01:46 -0800
Message-ID: <CAJuCfpEo2RyBLpariVgKBjQrZxdHuhMCgOGYfESZsYOPMD5vBw@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 11:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Locking around VMAs is complicated and confusing. While we have a number =
of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documentin=
g
> how locks are expected to be interacted with when it comes to interacting
> with mm_struct and vm_area_struct objects.
>
> This is especially pertinent as regards efforts to find sensible
> abstractions for these fundamental objects within the kernel rust
> abstraction whose compiler strictly requires some means of expressing the=
se
> rules (and through this expression can help self-document these
> requirements as well as enforce them which is an exciting concept).
>
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and reli=
es
> upon us handling these correctly).
>
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardow=
n.
>
> The document also provides some VMA lock internals, which are up to date
> and inclusive of recent changes to recent sequence number changes.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for documenting this, Lorenzo!
Just heads-up, I'm working on changing some of the implementation
details (removing vma->detached, moving vm_lock into vm_area_struct,
etc.). I should be able to post those changes sometime later this week
if testing does not reveal any issues.

> ---
>
> REVIEWERS NOTES:
>    You can speed up doc builds by running `make SPHINXDIRS=3Dmm htmldocs`=
. I
>    also uploaded a copy of this to my website at
>    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
>    read through. Thanks!
>
>
>  Documentation/mm/index.rst     |   1 +
>  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
>  2 files changed, 528 insertions(+)
>  create mode 100644 Documentation/mm/vma_locks.rst
>
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index 0be1c7503a01..da5f30acaca5 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
>     vmemmap_dedup
>     z3fold
>     zsmalloc
> +   vma_locks
> diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_locks.=
rst
> new file mode 100644
> index 000000000000..52b9d484376a
> --- /dev/null
> +++ b/Documentation/mm/vma_locks.rst
> @@ -0,0 +1,527 @@
> +VMA Locking
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +Userland memory ranges are tracked by the kernel via Virtual Memory Area=
s or
> +'VMA's of type `struct vm_area_struct`.
> +
> +Each VMA describes a virtually contiguous memory range with identical
> +attributes, each of which described by a `struct vm_area_struct`
> +object. Userland access outside of VMAs is invalid except in the case wh=
ere an
> +adjacent stack VMA could be extended to contain the accessed address.
> +
> +All VMAs are contained within one and only one virtual address space, de=
scribed
> +by a `struct mm_struct` object which is referenced by all tasks (that is=
,
> +threads) which share the virtual address space. We refer to this as the =
`mm`.
> +
> +Each mm object contains a maple tree data structure which describes all =
VMAs
> +within the virtual address space.
> +
> +The kernel is designed to be highly scalable against concurrent access t=
o
> +userland memory, so a complicated set of locks are required to ensure no=
 data
> +races or memory corruption occurs.
> +
> +This document explores this locking in detail.
> +
> +.. note::
> +
> +   There are three different things that a user might want to achieve vi=
a
> +   locks - the first of which is **stability**. That is - ensuring that =
the VMA
> +   won't be freed or modified in any way from underneath us.
> +
> +   All MM and VMA locks ensure stability.
> +
> +   Secondly we have locks which allow **reads** but not writes (and whic=
h might
> +   be held concurrent with other CPUs who also hold the read lock).
> +
> +   Finally, we have locks which permit exclusive access to the VMA to al=
low for
> +   **writes** to the VMA.
> +
> +MM and VMA locks
> +----------------
> +
> +There are two key classes of lock utilised when reading and manipulating=
 VMAs -
> +the `mmap_lock` which is a read/write semaphore maintained at the `mm_st=
ruct`
> +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock =
at the
> +VMA level of granularity.
> +
> +.. note::
> +
> +   Generally speaking, a read/write semaphore is a class of lock which p=
ermits
> +   concurrent readers. However a write lock can only be obtained once al=
l
> +   readers have left the critical region (and pending readers made to wa=
it).
> +
> +   This renders read locks on a read/write semaphore concurrent with oth=
er
> +   readers and write locks exclusive against all others holding the sema=
phore.
> +
> +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a=
 write
> +mmap lock gives you exclusive write access to a VMA, and a read lock giv=
es you
> +concurrent read-only access.
> +
> +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> +complicated. In this instance, a write semaphore is no longer enough to =
gain
> +exclusive access to a VMA, a VMA write lock is also required.

I think "exclusive access to a VMA" should be "exclusive access to mm"
if you are talking about mmap_lock.

I think it's worth adding here:
1. to take a VMA write-lock you need to be holding an mmap_lock;
2. write-unlocking mmap_lock drops all VMA write locks in that mm.

I see that you touch on this in the below "Note" section but that's
not an implementation detail but the designed behavior, so I think
these should not be mere side-notes.

> +
> +The VMA lock is implemented via the use of both a read/write semaphore a=
nd
> +per-VMA and per-mm sequence numbers. We go into detail on this in the VM=
A lock
> +internals section below, so for the time being it is important only to n=
ote that
> +we can obtain either a VMA read or write lock.
> +
> +.. note::
> +
> +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu(=
)`
> +   function, and **no** existing mmap or VMA lock must be held, This fun=
ction

"no existing mmap or VMA lock must be held" did you mean to say "no
exclusive mmap or VMA locks must be held"? Because one can certainly
hold a read-lock on them.

> +   either returns a read-locked VMA, or NULL if the lock could not be
> +   acquired. As the name suggests, the VMA will be acquired under RCU, t=
hough
> +   once obtained, remains stable.
> +
> +   This kind of locking is entirely optimistic - if the lock is contende=
d or a
> +   competing write has started, then we do not obtain a read lock.
> +
> +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()` to =
ensure
> +   that the VMA is acquired in an RCU critical section, then attempts to=
 VMA
> +   lock it via `vma_start_read()`, before releasing the RCU lock via
> +   `rcu_read_unlock()`.
> +
> +   VMA read locks hold the a read lock on the `vma->vm_lock` semaphore f=
or their
> +   duration and the caller of `lock_vma_under_rcu()` must release it via
> +   `vma_end_read()`.
> +
> +   VMA **write** locks are acquired via `vma_start_write()` in instances=
 where a
> +   VMA is about to be modified, unlike `vma_start_read()` the lock is al=
ways
> +   acquired. An mmap write lock **must** be held for the duration of the=
 VMA
> +   write lock, releasing or downgrading the mmap write lock also release=
s the
> +   VMA write lock so there is no `vma_end_write()` function.
> +
> +   Note that a semaphore write lock is not held across a VMA lock. Rathe=
r, a
> +   sequence number is used for serialisation, and the write semaphore is=
 only
> +   acquired at the point of write lock to update this (we explore this i=
n detail
> +   in the VMA lock internals section below).
> +
> +   This ensures the semantics we require - VMA write locks provide exclu=
sive
> +   write access to the VMA.
> +
> +Examining all valid lock state and what each implies:
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - mmap lock
> +     - VMA lock
> +     - Stable?
> +     - Can read safely?
> +     - Can write safely?
> +   * - \-
> +     - \-
> +     - N
> +     - N
> +     - N
> +   * - R
> +     - \-
> +     - Y
> +     - Y
> +     - N
> +   * - \-
> +     - R
> +     - Y
> +     - Y
> +     - N
> +   * - W
> +     - \-
> +     - Y
> +     - Y
> +     - N
> +   * - W
> +     - W
> +     - Y
> +     - Y
> +     - Y
> +
> +Note that there are some exceptions to this - the `anon_vma` field is pe=
rmitted
> +to be written to under mmap read lock and is instead serialised by the `=
struct
> +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
> +lock-specific fields are permitted to be read under RCU alone  (though s=
tability cannot
> +be expected in this instance).
> +
> +.. note::
> +   The most notable place to use the VMA read lock is on page table faul=
ts on
> +   the x86-64 architecture, which importantly means that without a VMA w=
rite

As Jann mentioned, CONFIG_PER_VMA_LOCK is supported on many more architectu=
res.

> +   lock, page faults can race against you even if you hold an mmap write=
 lock.
> +
> +VMA Fields
> +----------
> +
> +We examine each field of the `struct vm_area_struct` type in detail in t=
he table
> +below.
> +
> +Reading of each field requires either an mmap read lock or a VMA read lo=
ck to be
> +held, except where 'unstable RCU read' is specified, in which case unsta=
ble
> +access to the field is permitted under RCU alone.
> +
> +The table specifies which write locks must be held to write to the field=
.
> +
> +.. list-table::
> +   :widths: 20 10 22 5 20
> +   :header-rows: 1
> +
> +   * - Field
> +     - Config
> +     - Description
> +     - Unstable RCU read?
> +     - Write Lock
> +   * - vm_start
> +     -
> +     - Inclusive start virtual address of range VMA describes.
> +     -
> +     - mmap write, VMA write
> +   * - vm_end
> +     -
> +     - Exclusive end virtual address of range VMA describes.
> +     -
> +     - mmap write, VMA write
> +   * - vm_rcu
> +     - vma lock
> +     - RCU list head, in union with vma_start, vma_end. RCU implementati=
on detail.
> +     - N/A
> +     - N/A
> +   * - vm_mm
> +     -
> +     - Containing mm_struct.
> +     - Y
> +     - (Static)
> +   * - vm_page_prot
> +     -
> +     - Architecture-specific page table protection bits determined from =
VMA
> +       flags
> +     -
> +     - mmap write, VMA write
> +   * - vm_flags
> +     -
> +     - Read-only access to VMA flags describing attributes of VMA, in un=
ion with
> +       private writable `__vm_flags`.
> +     -
> +     - N/A
> +   * - __vm_flags
> +     -
> +     - Private, writable access to VMA flags field, updated by vm_flags_=
*()
> +       functions.
> +     -
> +     - mmap write, VMA write
> +   * - detached
> +     - vma lock
> +     - VMA lock implementation detail - indicates whether the VMA has be=
en
> +       detached from the tree.
> +     - Y
> +     - mmap write, VMA write
> +   * - vm_lock_seq
> +     - vma lock
> +     - VMA lock implementation detail - A sequence number used to serial=
ise the
> +       VMA lock, see the VMA lock section below.
> +     - Y
> +     - mmap write, VMA write

It's a bit weird to state that VMA write-lock is required when talking
about vm_lock_seq/vm_lock themselves being parts of that lock. I would
simply say N/A for both of them since they should not be modified
directly.

> +   * - vm_lock
> +     - vma lock
> +     - VMA lock implementation detail - A pointer to the VMA lock read/w=
rite
> +       semaphore.
> +     - Y
> +     - None required
> +   * - shared.rb
> +     -
> +     - A red/black tree node used, if the mapping is file-backed, to pla=
ce the
> +       VMA in the `struct address_space->i_mmap` red/black interval tree=
.
> +     -
> +     - mmap write, VMA write, i_mmap write
> +   * - shared.rb_subtree_last
> +     -
> +     - Metadata used for management of the interval tree if the VMA is
> +       file-backed.
> +     -
> +     - mmap write, VMA write, i_mmap write
> +   * - anon_vma_chain
> +     -
> +     - List of links to forked/CoW'd `anon_vma` objects.
> +     -
> +     - mmap read or above, anon_vma write lock

nit: I would spell it out for clarity: mmap read or write

> +   * - anon_vma
> +     -
> +     - `anon_vma` object used by anonymous folios mapped exclusively to =
this VMA.
> +     -
> +     - mmap read or above, page_table_lock
> +   * - vm_ops
> +     -
> +     - If the VMA is file-backed, then either the driver or file-system =
provides
> +       a `struct vm_operations_struct` object describing callbacks to be=
 invoked
> +       on specific VMA lifetime events.
> +     -
> +     - (Static)
> +   * - vm_pgoff
> +     -
> +     - Describes the page offset into the file, the original page offset=
 within
> +       the virtual address space (prior to any `mremap()`), or PFN if a =
PFN map.
> +     -
> +     - mmap write, VMA write
> +   * - vm_file
> +     -
> +     - If the VMA is file-backed, points to a `struct file` object descr=
ibing
> +       the underlying file, if anonymous then `NULL`.
> +     -
> +     - (Static)
> +   * - vm_private_data
> +     -
> +     - A `void *` field for driver-specific metadata.
> +     -
> +     - Driver-mandated.
> +   * - anon_name
> +     - anon name
> +     - A field for storing a `struct anon_vma_name` object providing a n=
ame for
> +       anonymous mappings, or `NULL` if none is set or the VMA is file-b=
acked.
> +     -
> +     - mmap write, VMA write
> +   * - swap_readahead_info
> +     - swap
> +     - Metadata used by the swap mechanism to perform readahead.
> +     -
> +     - mmap read
> +   * - vm_region
> +     - nommu
> +     - The containing region for the VMA for architectures which do not
> +       possess an MMU.
> +     - N/A
> +     - N/A
> +   * - vm_policy
> +     - numa
> +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> +     -
> +     - mmap write, VMA write
> +   * - numab_state
> +     - numab
> +     - `vma_numab_state` object which describes the current state of NUM=
A
> +       balancing in relation to this VMA.
> +     -
> +     - mmap write, VMA write
> +   * - vm_userfaultfd_ctx
> +     -
> +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, =
either
> +       of zero size if userfaultfd is disabled, or containing a pointer =
to an
> +       underlying `userfaultfd_ctx` object which describes userfaultfd m=
etadata.
> +     -
> +     - mmap write, VMA write
> +
> +.. note::
> +
> +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LO=
CK,
> +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'no=
mmu'
> +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab=
' means
> +   CONFIG_NUMA_BALANCING'.
> +
> +   In the write lock column '(Static)' means that the field is set only =
once
> +   upon initialisation of the VMA and not changed after this, the VMA wo=
uld
> +   either have been under an mmap write and VMA write lock at the time o=
r not
> +   yet inserted into any tree.
> +
> +Page table locks
> +----------------
> +
> +When allocating a P4D, PUD or PMD and setting the relevant entry in the =
above
> +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respect=
ively.
> +
> +.. note::
> +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in =
turn,
> +   however at the time of writing it ultimately references the
> +   `mm->page_table_lock`.
> +
> +Allocating a PTE will either use the `mm->page_table_lock` or, if
> +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD phys=
ical
> +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc(=
)`
> +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> +
> +Finally, modifying the contents of the PTE has special treatment, as thi=
s is a
> +lock that we must acquire whenever we want stable and exclusive access t=
o
> +entries pointing to data pages within a PTE, especially when we wish to =
modify
> +them.
> +
> +This is performed via `pte_offset_map_lock()` which carefully checks to =
ensure
> +that the PTE hasn't changed from under us, ultimately invoking `pte_lock=
ptr()`
> +to obtain a spin lock at PTE granularity contained within the `struct pt=
desc`
> +associated with the physical PTE page. The lock must be released via
> +`pte_unmap_unlock()`.
> +
> +.. note::
> +   There are some variants on this, such as `pte_offset_map_rw_nolock()`=
 when we
> +   know we hold the PTE stable but for brevity we do not explore this.
> +   See the comment for `__pte_offset_map_lock()` for more details.
> +
> +When modifying data in ranges we typically only wish to allocate higher =
page
> +tables as necessary, using these locks to avoid races or overwriting any=
thing,
> +and set/clear data at the PTE level as required (for instance when page =
faulting
> +or zapping).
> +
> +Page table teardown
> +-------------------
> +
> +Tearing down page tables themselves is something that requires significa=
nt
> +care. There must be no way that page tables designated for removal can b=
e
> +traversed or referenced by concurrent tasks.
> +
> +It is insufficient to simply hold an mmap write lock and VMA lock (which=
 will
> +prevent racing faults, and rmap operations), as a file-backed mapping ca=
n be
> +truncated under the `struct address_space` i_mmap_lock alone.
> +
> +As a result, no VMA which can be accessed via the reverse mapping (eithe=
r
> +anon_vma or the `struct address_space->i_mmap` interval tree) can have i=
ts page
> +tables torn down.
> +
> +The operation is typically performed via `free_pgtables()`, which assume=
s either
> +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> +parameter), or that it the VMA is fully detached.
> +
> +It carefully removes the VMA from all reverse mappings, however it's imp=
ortant
> +that no new ones overlap these or any route remain to permit access to a=
ddresses
> +within the range whose page tables are being torn down.
> +
> +As a result of these careful conditions, note that page table entries ar=
e
> +cleared without page table locks, as it is assumed that all of these pre=
cautions
> +have already been taken.
> +
> +mmap write lock downgrading
> +---------------------------
> +
> +While it is possible to obtain an mmap write or read lock using the
> +`mm->mmap_lock` read/write semaphore, it is also possible to **downgrade=
** from
> +a write lock to a read lock via `mmap_write_downgrade()`.
> +
> +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA wri=
te locks
> +via `vma_end_write_all()` (more or this behaviour in the VMA lock intern=
als
> +section below), but importantly does not relinquish the mmap lock while
> +downgrading, therefore keeping the locked virtual address space stable.
> +
> +A subtlety here is that callers can assume, if they invoke an
> +mmap_write_downgrade() operation, that they still have exclusive access =
to the
> +virtual address space (excluding VMA read lock holders), as for another =
task to
> +have downgraded they would have had to have exclusive access to the sema=
phore
> +which can't be the case until the current task completes what it is doin=
g.

I can't decipher the above paragraph. Could you please dumb it down
for the likes of me?

> +
> +Stack expansion
> +---------------
> +
> +Stack expansion throws up additional complexities in that we cannot perm=
it there
> +to be racing page faults, as a result we invoke `vma_start_write()` to p=
revent
> +this in `expand_downwards()` or `expand_upwards()`.
> +
> +Lock ordering
> +-------------
> +
> +As we have multiple locks across the kernel which may or may not be take=
n at the
> +same time as explicit mm or VMA locks, we have to be wary of lock invers=
ion, and
> +the **order** in which locks are acquired and released becomes very impo=
rtant.
> +
> +.. note::
> +
> +   Lock inversion occurs when two threads need to acquire multiple locks=
,
> +   but in doing so inadvertently cause a mutual deadlock.
> +
> +   For example, consider thread 1 which holds lock A and tries to acquir=
e lock B,
> +   while thread 2 holds lock B and tries to acquire lock A.
> +
> +   Both threads are now deadlocked on each other. However, had they atte=
mpted to
> +   acquire locks in the same order, one would have waited for the other =
to
> +   complete its work and no deadlock would have occurred.
> +
> +The opening comment in `mm/rmap.c` describes in detail the required orde=
ring of
> +locks within memory management code:
> +
> +.. code-block::
> +
> +  inode->i_rwsem       (while writing or truncating, not reading or faul=
ting)
> +    mm->mmap_lock
> +      mapping->invalidate_lock (in filemap_fault)
> +        folio_lock
> +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs b=
elow)
> +            vma_start_write
> +              mapping->i_mmap_rwsem
> +                anon_vma->rwsem
> +                  mm->page_table_lock or pte_lock
> +                    swap_lock (in swap_duplicate, swap_info_get)
> +                      mmlist_lock (in mmput, drain_mmlist and others)
> +                      mapping->private_lock (in block_dirty_folio)
> +                          i_pages lock (widely used)
> +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> +                      inode->i_lock (in set_page_dirty's __mark_inode_di=
rty)
> +                      bdi.wb->list_lock (in set_page_dirty's __mark_inod=
e_dirty)
> +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> +                        i_pages lock (widely used, in set_page_dirty,
> +                                  in arch-dependent flush_dcache_mmap_lo=
ck,
> +                                  within bdi.wb->list_lock in __sync_sin=
gle_inode)
> +
> +Please check the current state of this comment which may have changed si=
nce the
> +time of writing of this document.
> +
> +VMA lock internals
> +------------------
> +
> +The VMA lock mechanism is designed to be a lightweight means of avoiding=
 the use
> +of the heavily contended mmap lock. It is implemented using a combinatio=
n of a
> +read/write semaphore and sequence numbers belonging to the containing `s=
truct
> +mm_struct` and the VMA.
> +
> +Read locks are acquired via `vma_start_read()`, which is an optimistic
> +operation, i.e. it tries to acquire a read lock but returns false if it =
is
> +unable to do so. At the end of the read operation, `vma_end_read()` is c=
alled to
> +release the VMA read lock. This can be done under RCU alone.
> +
> +Writing requires the mmap to be write-locked and the VMA lock to be acqu=
ired via
> +`vma_start_write()`, however the write lock is released by the terminati=
on or
> +downgrade of the mmap write lock so no `vma_end_write()` is required.
> +
> +All this is achieved by the use of per-mm and per-VMA sequence counts. T=
his is
> +used to reduce complexity, and potential especially around operations wh=
ich

potential?

> +write-lock multiple VMAs at once.
> +
> +If the mm sequence count, `mm->mm_lock_seq` is equal to the VMA sequence=
 count
> +`vma->vm_lock_seq` then the VMA is write-locked. If they differ, then th=
ey are
> +not.
> +
> +Each time an mmap write lock is acquired in `mmap_write_lock()`,
> +`mmap_write_lock_nested()`, `mmap_write_lock_killable()`, the `mm->mm_lo=
ck_seq`
> +sequence number is incremented via `mm_lock_seqcount_begin()`.
> +
> +Each time the mmap write lock is released in `mmap_write_unlock()` or
> +`mmap_write_downgrade()`, `vma_end_write_all()` is invoked which also in=
crements
> +`mm->mm_lock_seq` via `mm_lock_seqcount_end()`.
> +
> +This way, we ensure regardless of the VMA's sequence number count, that =
a write
> +lock is not incorrectly indicated (since we increment the sequence count=
er on
> +acquiring the mmap write lock, which is required in order to obtain a VM=
A write
> +lock), and that when we release an mmap write lock, we efficiently relea=
se
> +**all** VMA write locks contained within the mmap at the same time.

Ok, I see that you describe some of the rules I mentioned before here.
Up to you where to place them.

> +
> +The exclusivity of the mmap write lock ensures this is what we want, as =
there
> +would never be a reason to persist per-VMA write locks across multiple m=
map
> +write lock acquisitions.
> +
> +Each time a VMA read lock is acquired, we acquire a read lock on the
> +`vma->vm_lock` read/write semaphore and hold it, while checking that the
> +sequence count of the VMA does not match that of the mm.
> +
> +If it does, the read lock fails. If it does not, we hold the lock, exclu=
ding
> +writers, but permitting other readers, who will also obtain this lock un=
der RCU.
> +
> +Importantly, maple tree operations performed in `lock_vma_under_rcu()` a=
re also
> +RCU safe, so the whole read lock operation is guaranteed to function cor=
rectly.
> +
> +On the write side, we acquire a write lock on the `vma->vm_lock` read/wr=
ite
> +semaphore, before setting the VMA's sequence number under this lock, als=
o
> +simultaneously holding the mmap write lock.
> +
> +This way, if any read locks are in effect, `vma_start_write()` will slee=
p until
> +these are finished and mutual exclusion is achieved.
> +
> +After setting the VMA's sequence number, the lock is released, avoiding
> +complexity with a long-term held write lock.
> +
> +This clever combination of a read/write semaphore and sequence count all=
ows for
> +fast RCU-based per-VMA lock acquisition (especially on x86-64 page fault=
, though
> +utilised elsewhere) with minimal complexity around lock ordering.
> --
> 2.47.0
>

