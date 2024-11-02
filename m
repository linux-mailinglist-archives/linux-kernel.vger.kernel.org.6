Return-Path: <linux-kernel+bounces-393118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E49B9C0D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D51F21D3B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D742E630;
	Sat,  2 Nov 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbKMz0FQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6E42A83
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730511978; cv=none; b=ggmLSjuKeY+O157PH3nJCpLKu7qwqOuXypIEKhuyXI4JOlQ2iO7S7dOH6KKxkJ0fUeV8aeh+ggUtrY7FrCXbyzRVTKj93/VEp59vwVt66lO52WlIebXc6vt06eu8cATW+7desfkWsz+uA1KayT44WLaGcLjgCTpXdpiP8gWAV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730511978; c=relaxed/simple;
	bh=I8fG7+DtlAP8uwh+V7kyYLcapVyeaK7zd/CbSX7SZ+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8+Ugs0K9Ofgt/8737yV8x9gSJ0sjvsTdTsgWQpDL+lU/ru5bhfae3MsNp+xV5EoGkqObWYG17e0JV//ZOrOAL6Xmy8FXO2YRtz3JWQWwEbRAE2ochh8RW+9nXZREJ3LaQUtv+rbo5dbaNR73kqRn2JTaCFW0bsaLWxl2SNCypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbKMz0FQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso203a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 18:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730511973; x=1731116773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOGnQ566b4NCMbghN9rWa1p6AcTXQiLYm/kdvKZdoLU=;
        b=WbKMz0FQZ1FLcz2kHKUykwkKxZ+PpHVm45Ma8BCUQsj22maNBYHz0m4PknlVVDtoUj
         DGxriDP1SHur+dCe49PUaVsukRDfJ+G/gX5qxVKs6mhB++fzoLn5FVs6PezxiQZBxCBf
         ROatK80Qd6gmiu+SeLsBW8xbLjZcJlmz+uGGvyrKVvUb1kYXVQsmE+3YX4SdgCqxgZB0
         EJXiIezJ9mtlGK9uLgUBSUgt3Z6bQOlkR7vdqUnshiz62VBIhqJn4G3IG9cZLWkUwFgx
         K7NlFkDqEjYVFzabr243B9pcp/lRvsZ0+o/JcdfiLKBhxOH8u6PYx+KUa/BVMWFYZhko
         pKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730511973; x=1731116773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOGnQ566b4NCMbghN9rWa1p6AcTXQiLYm/kdvKZdoLU=;
        b=nt5yo6XvioW3p9WHQkok8PY/XL+KjUPRbbArxWCpG4914I0fhb4A46l95EggzRn8Ak
         +N9dgpxBHkmMsUgHMcfDLZ1mrYUpj8TroHll/hyckbL6iGj+9lItnbt32XtjcqBQGvRT
         YLnk8N53Fn/w+bidob1xz/zOPDS6I6T4WK4OuN0NS+OvotfkhTDHqsjxg3d1qe8RoyEK
         ZEudq9YoSYVajttwTxHyt6HwW7+Klc1QRo2FQN879t35MYXQ6TSIgRwGSBcf0c9bx3HE
         85seZ0D5tGn+1O/X8u0zE5WMKjkwbUzet4b4fI1qMfO/DrZCN4CWGmAXUjyHd5ADckEe
         Zhvw==
X-Forwarded-Encrypted: i=1; AJvYcCULZYjBtIordkfW8zRwGgQjh1LG8pQWIGGYpPOUhvFL2udommV63NsJLJLIEOzN4lJWClpqyGcoZdoagrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6T7tohh1p33YFBHuRHgDnA/5jNpxUkdvQUSxx4/E6JhKBNgx
	/uJ9oW+AdurN+0xWFb0CIk9x4WBa30cdX4iENjs4ShoaNyD7i7VAUA9XPSM+X8R6yFpPQ9aYuSh
	lB1I0t/Y9TYd9NpPMpFLU7+VuqAEa9ICSDPsW
X-Gm-Gg: ASbGncugJGJPHFP5P77mAdIcJaGdMYjdtxvmLrzLx9ybYtgaFHNBDgo7AwkynBwBJfG
	gShsZwzVSrmGVxBW8uyvNkLqR2fxoW1xkyykd36kCgyobbYKlqTplZq43ELSD
X-Google-Smtp-Source: AGHT+IGYI48ksBA/z+QSeOrFxbwQadM2OzPqMyD2JtW3PBQzjvvpglIsv+PbZaZJB9HGaGolnbbQL9N6D/R86mOnYG0=
X-Received: by 2002:a05:6402:d4e:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5cec941e480mr2712a12.4.1730511972819; Fri, 01 Nov 2024 18:46:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 2 Nov 2024 02:45:35 +0100
Message-ID: <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
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

On Fri, Nov 1, 2024 at 7:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
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

Thanks for doing this!

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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

The gate VMA is special, on architectures that have it: Userland
access to its area is allowed, but the area is outside the VA range
managed by the normal MM code, and the gate VMA is a global object
(not per-MM), and only a few places in MM code can interact with it
(for example, page fault handling can't, but GUP can through
get_gate_page()).

(I think this also has the fun consequence that vm_normal_page() can
get called on a VMA whose ->vm_mm is NULL, when called from
get_gate_page().)

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

Maybe also mention that there are three major paths you can follow to
reach a VMA? You can come through the mm's VMA tree, you can do an
anon page rmap walk that goes page -> anon_vma -> vma, or you can do a
file rmap walk from the address_space. Which is why just holding the
mmap lock and vma lock in write mode is not enough to permit arbitrary
changes to a VMA struct.

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

uffd_move_lock() calls lock_vma_under_rcu() after having already
VMA-locked another VMA with uffd_lock_vma().

> +   either returns a read-locked VMA, or NULL if the lock could not be
> +   acquired. As the name suggests, the VMA will be acquired under RCU, t=
hough
> +   once obtained, remains stable.
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

nit: s/ the a / a /

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

Hm, we really ought to add some smp_store_release() and READ_ONCE(),
or something along those lines, around our ->anon_vma accesses...
especially the "vma->anon_vma =3D anon_vma" assignment in
__anon_vma_prepare() looks to me like, on architectures like arm64
with write-write reordering, we could theoretically end up making a
new anon_vma pointer visible to a concurrent page fault before the
anon_vma has been initialized? Though I have no idea if that is
practically possible, stuff would have to be reordered quite a bit for
that to happen...

> +lock-specific fields are permitted to be read under RCU alone  (though s=
tability cannot
> +be expected in this instance).
> +
> +.. note::
> +   The most notable place to use the VMA read lock is on page table faul=
ts on

s/page table faults/page faults/?

> +   the x86-64 architecture, which importantly means that without a VMA w=
rite

it's wired up to a bunch of architectures at this point - arm, arm64,
powerpc, riscv, s390, x86 all use lock_vma_under_rcu().

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

vm_start, vm_end and vm_pgoff also require that the associated
address_space and anon_vma (if applicable) are write-locked, and that
their rbtrees are updated as needed.

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

I think "mmap write" is accurate, but "VMA write" is inaccurate -
you'd need to have already written to the vm_lock_seq in order to have
a VMA write lock.

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

Ooh, right, I had forgotten about this quirk, and I think I never
fully understood these rules... it's a PFN if the VMA is
private+maywrite+pfnmap. And the vma->vm_pgoff is set in
remap_pfn_range_internal() under those conditions.

Huh, so for example, if you are in an environment where usbdev_mmap()
uses remap_pfn_range() (which depends on hardware - it seems to work
inside QEMU but not on real machine), and you have at least read
access to a device at /dev/bus/usb/*/* (which are normally
world-readable), you can actually do this:

user@vm:/tmp$ cat usb-get-physaddr.c
#include <err.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#define SYSCHK(x) ({          \
  typeof(x) __res =3D (x);      \
  if (__res =3D=3D (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})
int main(int argc, char **argv) {
  if (argc !=3D 2)
    errx(1, "expect one argument (usbdev path)");
  int fd =3D SYSCHK(open(argv[1], O_RDONLY));
  SYSCHK(mmap((void*)0x10000, 0x1000, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED_NOREPLACE, fd, 0));
  system("head -n1 /proc/$PPID/maps");
}
user@vm:/tmp$ gcc -o usb-get-physaddr usb-get-physaddr.c
user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
00010000-00011000 rw-p 0103f000 00:06 135
  /dev/bus/usb/001/001
user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
00010000-00011000 rw-p 0103f000 00:06 135
  /dev/bus/usb/001/001
user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
00010000-00011000 rw-p 0107e000 00:06 135
  /dev/bus/usb/001/001
user@vm:/tmp$ ./usb-get-physaddr /dev/bus/usb/001/001
00010000-00011000 rw-p 010bd000 00:06 135
  /dev/bus/usb/001/001
user@vm:/tmp$

and see physical addresses in the offset field in /proc/*/maps...
that's not great. And pointless on architectures with
CONFIG_ARCH_HAS_PTE_SPECIAL, from what I can tell.


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

I think task_numa_work() is only holding the mmap lock in read mode
when it sets this pointer to a non-NULL value.

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
>+
> +Finally, modifying the contents of the PTE has special treatment, as thi=
s is a
> +lock that we must acquire whenever we want stable and exclusive access t=
o
> +entries pointing to data pages within a PTE, especially when we wish to =
modify
> +them.

I guess one other perspective on this would be to focus on the
circumstances under which you're allowed to write entries:

0. page tables can be concurrently read by hardware and GUP-fast, so
writes must always be appropriately atomic
1. changing a page table entry always requires locking the containing
page table (except when the write is an A/D update by hardware)
2. in page tables higher than PMD level, page table entries that point
to page tables can only be changed to point to something else when
holding all the relevant high-level locks leading to the VMA in
exclusive mode: mmap lock (unless the VMA is detached), VMA lock,
anon_vma, address_space
3. PMD entries that point to page tables can be changed while holding
the page table spinlocks for the entry and the table it points to
4. lowest-level page tables can be in high memory, so they must be
kmapped for access, and pte_offset_map_lock() does that for you
5. entries in "none" state can only be populated with leaf entries
while holding the mmap or vma lock (doing it through the rmap would be
bad because that could race with munmap() zapping data pages in the
region)
6. leaf entries can be zapped (changed to "none") while holding any
one of mmap lock, vma lock, address_space lock, or anon_vma lock

And then the rules for readers mostly follow from that:
1 =3D> holding the appropriate page table lock makes the contents of a
page table stable, except for A/D updates
2 =3D> page table entries higher than PMD level that point to lower page
tables can be followed without taking page table locks
3+4 =3D> following PMD entries pointing to page tables requires careful
locking, and pte_offset_map_lock() does that for you

Ah, though now I see the page table teardown section below already has
some of this information.

> +This is performed via `pte_offset_map_lock()` which carefully checks to =
ensure
> +that the PTE hasn't changed from under us, ultimately invoking `pte_lock=
ptr()`
> +to obtain a spin lock at PTE granularity contained within the `struct pt=
desc`
> +associated with the physical PTE page. The lock must be released via
> +`pte_unmap_unlock()`.

Sidenote: Not your fault that the Linux terminology for this sucks,
but the way this section uses "PTE" to describe a page table rather
than a Page Table Entry is pretty confusing to me... in my head, a
pte_t is a Page Table Entry (PTE), a pte_t* is a Page Table or a Page
Table Entry Pointer (depending on context), a pmd_t is a Page Middle
Directory Entry, and a pmd_t* is a Page Middle Directory or a Page
Middle Directory Entry Pointer. (Though to make things easier I
normally think of them as L1 entry, L1 table, L2 entry, L2 table.)

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

(except by hardware or with gup_fast() which behaves roughly like a
hardware page walker and completely ignores what is happening at the
VMA layer)

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

(except last-level page tables: khugepaged already deletes those for
file mappings without using the mmap lock at all in
retract_page_tables(), and there is a pending series that will do the
same with page tables in other VMAs too, see
<https://lore.kernel.org/all/cover.1729157502.git.zhengqi.arch@bytedance.co=
m/>)

> +The operation is typically performed via `free_pgtables()`, which assume=
s either
> +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> +parameter), or that it the VMA is fully detached.

nit: s/that it the/that the/

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

Oh, I didn't realize this... interesting.

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

typo: s/or/on/

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
> +
> +Stack expansion
> +---------------
> +
> +Stack expansion throws up additional complexities in that we cannot perm=
it there
> +to be racing page faults, as a result we invoke `vma_start_write()` to p=
revent
> +this in `expand_downwards()` or `expand_upwards()`.

And this needs the mmap lock in write mode, so stack expansion is only
done in codepaths where we can reliably get that - so it happens on
fault handling, but not on GUP. This probably creates the fun quirk
that, in theory, the following scenario could happen:

1. a userspace program creates a large on-stack buffer (which exceeds
the bounds of the current stack VMA but is within the stack size
limit)
2. userspace calls something like the read() syscall on this buffer
(without writing to any deeper part of the stack - so this can't
happen when you call into a non-inlined library function for read() on
x86, but it might happen on arm64, where a function call does not
require writing to the stack)
3. the kernel read() handler is trying to do something like direct I/O
and uses GUP to pin the user-supplied pages (and does not use
copy_to_user(), which would be more common)
4. GUP fails, the read() fails

But this was probably the least bad option to deal with existing stack
expansion issues.

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

I think something like
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#overview-d=
ocumentation-comments
is supposed to let you include the current version of the comment into
the rendered documentation HTML without having to manually keep things
in sync. I've never used that myself, but there are a bunch of
examples in the tree; for example, grep for "DMA fences overview".

