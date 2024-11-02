Return-Path: <linux-kernel+bounces-393233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05609B9E14
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E597283097
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7EA158A31;
	Sat,  2 Nov 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icv5JFv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE328614E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730538265; cv=none; b=BgZZQIqJr+BDjetuiErdhAyWMGXBvF1xVbaIj4MG2fXM+lPwqX1kR+ehIqj2QFOx9Tc4UB9o+aIFwl9W9x8X7ginda5PPfikBeHhukjoPcPZkDZI2+5GGxEvkbQ+hYQUukfTFlphdi8mQVDtppCOlDFWt/kYqRMhScAa/8R5lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730538265; c=relaxed/simple;
	bh=tWIb8+Ux+RetKTX0RSFILN7F2Iu2P7Fyagvq1RBQHbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pORQ0VX9wDTPgnXzD26uDw+TWmh8se4T+yeQPwnVqXKg0D42uB5L29ZAsPeImCQSV2uFoDl9hXyIntxWjzk+5oiUutmj0w+Ve+euh3QtIIqpdBc4MozmygVVEx7OE/kkHSdPvffoxr42o2jgC0sokH06wy3KhlvFoE+lYbLk76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icv5JFv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBACC4CEC3;
	Sat,  2 Nov 2024 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730538264;
	bh=tWIb8+Ux+RetKTX0RSFILN7F2Iu2P7Fyagvq1RBQHbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icv5JFv3l6vNkQpoLEMS4umrYpyf4M9zSA2vBpIbwwM29JInxphsWpuc24fn+B6Ys
	 m8x3K3Fq+NAgNl5rvNPdwORo5ryT1i4xGjgKsIcfjRkJUS8My2SKzucbuvnFOf9c96
	 ql0e3p3lItd3h4/D2tzQ1+tsqA3zUeyPOdi13EPIvhuIFSl/9OjmZZKEEUgXTASL+b
	 XgzjJhblJYgtkXvP1CN8wfHh/ulF7AZ4dxPFPgiIpXGai0BH9LV8EPct9z+p2OpNSF
	 VuGT42knUH8FLY8rj7swGx5WAG7JEVJn2THdg7anSdfSJ8KGj7zOb7IWmPFNoleNnT
	 hJa2Dipi8nmoA==
Date: Sat, 2 Nov 2024 11:00:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <ZyXqJNIqIx97Y0To@kernel.org>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>

On Fri, Nov 01, 2024 at 06:50:33PM +0000, Lorenzo Stoakes wrote:
> Locking around VMAs is complicated and confusing. While we have a number of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documenting
> how locks are expected to be interacted with when it comes to interacting
> with mm_struct and vm_area_struct objects.
> 
> This is especially pertinent as regards efforts to find sensible
> abstractions for these fundamental objects within the kernel rust
> abstraction whose compiler strictly requires some means of expressing these
> rules (and through this expression can help self-document these
> requirements as well as enforce them which is an exciting concept).
> 
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and relies
> upon us handling these correctly).
> 
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardown.
> 
> The document also provides some VMA lock internals, which are up to date
> and inclusive of recent changes to recent sequence number changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
> 
> REVIEWERS NOTES:
>    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
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

Please keep the TOC sorted alphabetically.

> diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_locks.rst
> new file mode 100644
> index 000000000000..52b9d484376a
> --- /dev/null
> +++ b/Documentation/mm/vma_locks.rst
> @@ -0,0 +1,527 @@
> +VMA Locking
> +===========
> +
> +Overview
> +--------
> +
> +Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
> +'VMA's of type `struct vm_area_struct`.
> +
> +Each VMA describes a virtually contiguous memory range with identical
> +attributes, each of which described by a `struct vm_area_struct`
> +object. Userland access outside of VMAs is invalid except in the case where an
> +adjacent stack VMA could be extended to contain the accessed address.
> +
> +All VMAs are contained within one and only one virtual address space, described
> +by a `struct mm_struct` object which is referenced by all tasks (that is,
> +threads) which share the virtual address space. We refer to this as the `mm`.
> +
> +Each mm object contains a maple tree data structure which describes all VMAs
> +within the virtual address space.
> +
> +The kernel is designed to be highly scalable against concurrent access to
> +userland memory,

"and concurrent changes to the virtual address space layoyt"?

> so a complicated set of locks are required to ensure no data
> +races or memory corruption occurs.
> +
> +This document explores this locking in detail.
> +
> +.. note::
> +
> +   There are three different things that a user might want to achieve via
> +   locks - the first of which is **stability**. That is - ensuring that the VMA
> +   won't be freed or modified in any way from underneath us.
> +
> +   All MM and VMA locks ensure stability.
> +
> +   Secondly we have locks which allow **reads** but not writes (and which might
> +   be held concurrent with other CPUs who also hold the read lock).

I think it should be clarified here that *reads* are from data structures
rather than user memory.

> +
> +   Finally, we have locks which permit exclusive access to the VMA to allow for

                                                                      ^ object
> +   **writes** to the VMA.
> +
> +MM and VMA locks
> +----------------
> +
> +There are two key classes of lock utilised when reading and manipulating VMAs -
> +the `mmap_lock` which is a read/write semaphore maintained at the `mm_struct`
> +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock at the
> +VMA level of granularity.
> +
> +.. note::
> +
> +   Generally speaking, a read/write semaphore is a class of lock which permits
> +   concurrent readers. However a write lock can only be obtained once all
> +   readers have left the critical region (and pending readers made to wait).
> +
> +   This renders read locks on a read/write semaphore concurrent with other
> +   readers and write locks exclusive against all others holding the semaphore.
> +
> +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a write
> +mmap lock gives you exclusive write access to a VMA, and a read lock gives you
> +concurrent read-only access.
> +
> +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> +complicated. In this instance, a write semaphore is no longer enough to gain
> +exclusive access to a VMA, a VMA write lock is also required.
> +
> +The VMA lock is implemented via the use of both a read/write semaphore and
> +per-VMA and per-mm sequence numbers. We go into detail on this in the VMA lock
> +internals section below, so for the time being it is important only to note that
> +we can obtain either a VMA read or write lock.
> +
> +.. note::

I don't think the below text should be a "note", I'd just keep at
continuation of the section

> +
> +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu()`
> +   function, and **no** existing mmap or VMA lock must be held, This function
> +   either returns a read-locked VMA, or NULL if the lock could not be
> +   acquired. As the name suggests, the VMA will be acquired under RCU, though
> +   once obtained, remains stable.
> +
> +   This kind of locking is entirely optimistic - if the lock is contended or a
> +   competing write has started, then we do not obtain a read lock.
> +
> +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()` to ensure
> +   that the VMA is acquired in an RCU critical section, then attempts to VMA
> +   lock it via `vma_start_read()`, before releasing the RCU lock via
> +   `rcu_read_unlock()`.
> +
> +   VMA read locks hold the a read lock on the `vma->vm_lock` semaphore for their

                         ^ no idea if it should be 'a' or 'the', but surely
not both :)

> +   duration and the caller of `lock_vma_under_rcu()` must release it via
> +   `vma_end_read()`.
> +
> +   VMA **write** locks are acquired via `vma_start_write()` in instances where a
> +   VMA is about to be modified, unlike `vma_start_read()` the lock is always
> +   acquired. An mmap write lock **must** be held for the duration of the VMA
> +   write lock, releasing or downgrading the mmap write lock also releases the
> +   VMA write lock so there is no `vma_end_write()` function.
> +
> +   Note that a semaphore write lock is not held across a VMA lock. Rather, a
> +   sequence number is used for serialisation, and the write semaphore is only
> +   acquired at the point of write lock to update this (we explore this in detail
> +   in the VMA lock internals section below).
> +
> +   This ensures the semantics we require - VMA write locks provide exclusive
> +   write access to the VMA.
> +
> +Examining all valid lock state and what each implies:
> +
> +.. list-table::
> +   :header-rows: 1

Can we make it just .. table:

.. table::

    ========= ======== ======= ================ =================
    mmap lock VMA lock Stable? Can read safely? Can write safely?
    ========= ======== ======= ================ =================
    \-        \-       N       N                N
    R         \-       Y       Y                N
    \-        R        Y       Y                N
    W         \-       Y       Y                N
    W         W        Y       Y                Y
    ========= ======== ======= ================ =================

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
> +Note that there are some exceptions to this - the `anon_vma` field is permitted
> +to be written to under mmap read lock and is instead serialised by the `struct
> +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
> +lock-specific fields are permitted to be read under RCU alone  (though stability cannot
> +be expected in this instance).
> +
> +.. note::
> +   The most notable place to use the VMA read lock is on page table faults on
> +   the x86-64 architecture, which importantly means that without a VMA write
> +   lock, page faults can race against you even if you hold an mmap write lock.
> +
> +VMA Fields
> +----------
> +
> +We examine each field of the `struct vm_area_struct` type in detail in the table
> +below.
> +
> +Reading of each field requires either an mmap read lock or a VMA read lock to be
> +held, except where 'unstable RCU read' is specified, in which case unstable
> +access to the field is permitted under RCU alone.
> +
> +The table specifies which write locks must be held to write to the field.
> +
> +.. list-table::
> +   :widths: 20 10 22 5 20
> +   :header-rows: 1

And use .. table here as well, e.g

.. table::

    ======== ======== ========================== ================== ==========
    Field    Config   Description                Unstable RCU read? Write lock
    ======== ======== ========================== ================== ==========
    vm_start          Inclusive start virtual                       mmap write,
                      address of range VMA                          VMA write
		      describes

    vm_end            Exclusive end virtual                         mmap write,
                      address of range VMA                          VMA write
		      describes

    vm_rcu   vma_lock RCU list head, in union    N/A                N/A
                      with vma_start, vma_end.
		      RCU implementation detail
    ======== ======== ========================== ================== ==========


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
> +     - RCU list head, in union with vma_start, vma_end. RCU implementation detail.
> +     - N/A
> +     - N/A
> +   * - vm_mm
> +     -
> +     - Containing mm_struct.
> +     - Y
> +     - (Static)
> +   * - vm_page_prot
> +     -
> +     - Architecture-specific page table protection bits determined from VMA
> +       flags
> +     -
> +     - mmap write, VMA write
> +   * - vm_flags
> +     -
> +     - Read-only access to VMA flags describing attributes of VMA, in union with
> +       private writable `__vm_flags`.
> +     -
> +     - N/A
> +   * - __vm_flags
> +     -
> +     - Private, writable access to VMA flags field, updated by vm_flags_*()
> +       functions.
> +     -
> +     - mmap write, VMA write
> +   * - detached
> +     - vma lock
> +     - VMA lock implementation detail - indicates whether the VMA has been
> +       detached from the tree.
> +     - Y
> +     - mmap write, VMA write
> +   * - vm_lock_seq
> +     - vma lock
> +     - VMA lock implementation detail - A sequence number used to serialise the
> +       VMA lock, see the VMA lock section below.
> +     - Y
> +     - mmap write, VMA write
> +   * - vm_lock
> +     - vma lock
> +     - VMA lock implementation detail - A pointer to the VMA lock read/write
> +       semaphore.
> +     - Y
> +     - None required
> +   * - shared.rb
> +     -
> +     - A red/black tree node used, if the mapping is file-backed, to place the
> +       VMA in the `struct address_space->i_mmap` red/black interval tree.
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
> +     - `anon_vma` object used by anonymous folios mapped exclusively to this VMA.
> +     -
> +     - mmap read or above, page_table_lock
> +   * - vm_ops
> +     -
> +     - If the VMA is file-backed, then either the driver or file-system provides
> +       a `struct vm_operations_struct` object describing callbacks to be invoked
> +       on specific VMA lifetime events.
> +     -
> +     - (Static)
> +   * - vm_pgoff
> +     -
> +     - Describes the page offset into the file, the original page offset within
> +       the virtual address space (prior to any `mremap()`), or PFN if a PFN map.
> +     -
> +     - mmap write, VMA write
> +   * - vm_file
> +     -
> +     - If the VMA is file-backed, points to a `struct file` object describing
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
> +     - A field for storing a `struct anon_vma_name` object providing a name for
> +       anonymous mappings, or `NULL` if none is set or the VMA is file-backed.
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
> +     - `vma_numab_state` object which describes the current state of NUMA
> +       balancing in relation to this VMA.
> +     -
> +     - mmap write, VMA write
> +   * - vm_userfaultfd_ctx
> +     -
> +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, either
> +       of zero size if userfaultfd is disabled, or containing a pointer to an
> +       underlying `userfaultfd_ctx` object which describes userfaultfd metadata.
> +     -
> +     - mmap write, VMA write
> +
> +.. note::
> +
> +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LOCK,
> +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'nommu'
> +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab' means
> +   CONFIG_NUMA_BALANCING'.
> +
> +   In the write lock column '(Static)' means that the field is set only once
> +   upon initialisation of the VMA and not changed after this, the VMA would
> +   either have been under an mmap write and VMA write lock at the time or not
> +   yet inserted into any tree.
> +
> +Page table locks
> +----------------
> +
> +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> +
> +.. note::
> +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> +   however at the time of writing it ultimately references the
> +   `mm->page_table_lock`.
> +
> +Allocating a PTE will either use the `mm->page_table_lock` or, if
> +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> +
> +Finally, modifying the contents of the PTE has special treatment, as this is a
> +lock that we must acquire whenever we want stable and exclusive access to
> +entries pointing to data pages within a PTE, especially when we wish to modify
> +them.
> +
> +This is performed via `pte_offset_map_lock()` which carefully checks to ensure
> +that the PTE hasn't changed from under us, ultimately invoking `pte_lockptr()`
> +to obtain a spin lock at PTE granularity contained within the `struct ptdesc`
> +associated with the physical PTE page. The lock must be released via
> +`pte_unmap_unlock()`.
> +
> +.. note::
> +   There are some variants on this, such as `pte_offset_map_rw_nolock()` when we
> +   know we hold the PTE stable but for brevity we do not explore this.
> +   See the comment for `__pte_offset_map_lock()` for more details.
> +
> +When modifying data in ranges we typically only wish to allocate higher page
> +tables as necessary, using these locks to avoid races or overwriting anything,
> +and set/clear data at the PTE level as required (for instance when page faulting
> +or zapping).
> +
> +Page table teardown
> +-------------------
> +
> +Tearing down page tables themselves is something that requires significant
> +care. There must be no way that page tables designated for removal can be
> +traversed or referenced by concurrent tasks.
> +
> +It is insufficient to simply hold an mmap write lock and VMA lock (which will
> +prevent racing faults, and rmap operations), as a file-backed mapping can be
> +truncated under the `struct address_space` i_mmap_lock alone.
> +
> +As a result, no VMA which can be accessed via the reverse mapping (either
> +anon_vma or the `struct address_space->i_mmap` interval tree) can have its page
> +tables torn down.
> +
> +The operation is typically performed via `free_pgtables()`, which assumes either
> +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> +parameter), or that it the VMA is fully detached.

               "or that the VMA is..." ?

> +It carefully removes the VMA from all reverse mappings, however it's important
> +that no new ones overlap these or any route remain to permit access to addresses
> +within the range whose page tables are being torn down.
> +
> +As a result of these careful conditions, note that page table entries are
> +cleared without page table locks, as it is assumed that all of these precautions
> +have already been taken.
> +
> +mmap write lock downgrading
> +---------------------------
> +
> +While it is possible to obtain an mmap write or read lock using the
> +`mm->mmap_lock` read/write semaphore, it is also possible to **downgrade** from
> +a write lock to a read lock via `mmap_write_downgrade()`.
> +
> +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA write locks
> +via `vma_end_write_all()` (more or this behaviour in the VMA lock internals
> +section below), but importantly does not relinquish the mmap lock while
> +downgrading, therefore keeping the locked virtual address space stable.
> +
> +A subtlety here is that callers can assume, if they invoke an
> +mmap_write_downgrade() operation, that they still have exclusive access to the
> +virtual address space (excluding VMA read lock holders), as for another task to
> +have downgraded they would have had to have exclusive access to the semaphore
> +which can't be the case until the current task completes what it is doing.
> +
> +Stack expansion
> +---------------
> +
> +Stack expansion throws up additional complexities in that we cannot permit there
> +to be racing page faults, as a result we invoke `vma_start_write()` to prevent
> +this in `expand_downwards()` or `expand_upwards()`.
> +
> +Lock ordering
> +-------------
> +
> +As we have multiple locks across the kernel which may or may not be taken at the
> +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> +the **order** in which locks are acquired and released becomes very important.
> +
> +.. note::
> +
> +   Lock inversion occurs when two threads need to acquire multiple locks,
> +   but in doing so inadvertently cause a mutual deadlock.
> +
> +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> +   while thread 2 holds lock B and tries to acquire lock A.
> +
> +   Both threads are now deadlocked on each other. However, had they attempted to
> +   acquire locks in the same order, one would have waited for the other to
> +   complete its work and no deadlock would have occurred.
> +
> +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> +locks within memory management code:
> +
> +.. code-block::
> +
> +  inode->i_rwsem	(while writing or truncating, not reading or faulting)
> +    mm->mmap_lock
> +      mapping->invalidate_lock (in filemap_fault)
> +        folio_lock
> +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> +            vma_start_write
> +              mapping->i_mmap_rwsem
> +                anon_vma->rwsem
> +                  mm->page_table_lock or pte_lock
> +                    swap_lock (in swap_duplicate, swap_info_get)
> +                      mmlist_lock (in mmput, drain_mmlist and others)
> +                      mapping->private_lock (in block_dirty_folio)
> +                          i_pages lock (widely used)
> +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> +                        i_pages lock (widely used, in set_page_dirty,
> +                                  in arch-dependent flush_dcache_mmap_lock,
> +                                  within bdi.wb->list_lock in __sync_single_inode)
> +
> +Please check the current state of this comment which may have changed since the
> +time of writing of this document.
> +
> +VMA lock internals
> +------------------
> +
> +The VMA lock mechanism is designed to be a lightweight means of avoiding the use
> +of the heavily contended mmap lock. It is implemented using a combination of a
> +read/write semaphore and sequence numbers belonging to the containing `struct
> +mm_struct` and the VMA.
> +
> +Read locks are acquired via `vma_start_read()`, which is an optimistic
> +operation, i.e. it tries to acquire a read lock but returns false if it is
> +unable to do so. At the end of the read operation, `vma_end_read()` is called to
> +release the VMA read lock. This can be done under RCU alone.
> +
> +Writing requires the mmap to be write-locked and the VMA lock to be acquired via
> +`vma_start_write()`, however the write lock is released by the termination or
> +downgrade of the mmap write lock so no `vma_end_write()` is required.
> +
> +All this is achieved by the use of per-mm and per-VMA sequence counts. This is
> +used to reduce complexity, and potential especially around operations which
> +write-lock multiple VMAs at once.
> +
> +If the mm sequence count, `mm->mm_lock_seq` is equal to the VMA sequence count
> +`vma->vm_lock_seq` then the VMA is write-locked. If they differ, then they are
> +not.
> +
> +Each time an mmap write lock is acquired in `mmap_write_lock()`,
> +`mmap_write_lock_nested()`, `mmap_write_lock_killable()`, the `mm->mm_lock_seq`
> +sequence number is incremented via `mm_lock_seqcount_begin()`.
> +
> +Each time the mmap write lock is released in `mmap_write_unlock()` or
> +`mmap_write_downgrade()`, `vma_end_write_all()` is invoked which also increments
> +`mm->mm_lock_seq` via `mm_lock_seqcount_end()`.
> +
> +This way, we ensure regardless of the VMA's sequence number count, that a write
> +lock is not incorrectly indicated (since we increment the sequence counter on
> +acquiring the mmap write lock, which is required in order to obtain a VMA write
> +lock), and that when we release an mmap write lock, we efficiently release
> +**all** VMA write locks contained within the mmap at the same time.
> +
> +The exclusivity of the mmap write lock ensures this is what we want, as there
> +would never be a reason to persist per-VMA write locks across multiple mmap
> +write lock acquisitions.
> +
> +Each time a VMA read lock is acquired, we acquire a read lock on the
> +`vma->vm_lock` read/write semaphore and hold it, while checking that the
> +sequence count of the VMA does not match that of the mm.
> +
> +If it does, the read lock fails. If it does not, we hold the lock, excluding
> +writers, but permitting other readers, who will also obtain this lock under RCU.
> +
> +Importantly, maple tree operations performed in `lock_vma_under_rcu()` are also
> +RCU safe, so the whole read lock operation is guaranteed to function correctly.
> +
> +On the write side, we acquire a write lock on the `vma->vm_lock` read/write
> +semaphore, before setting the VMA's sequence number under this lock, also
> +simultaneously holding the mmap write lock.
> +
> +This way, if any read locks are in effect, `vma_start_write()` will sleep until
> +these are finished and mutual exclusion is achieved.
> +
> +After setting the VMA's sequence number, the lock is released, avoiding
> +complexity with a long-term held write lock.
> +
> +This clever combination of a read/write semaphore and sequence count allows for
> +fast RCU-based per-VMA lock acquisition (especially on x86-64 page fault, though
> +utilised elsewhere) with minimal complexity around lock ordering.
> --
> 2.47.0

-- 
Sincerely yours,
Mike.

