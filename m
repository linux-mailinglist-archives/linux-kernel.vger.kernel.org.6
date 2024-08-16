Return-Path: <linux-kernel+bounces-288735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2770953E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D8B244DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4A1877;
	Fri, 16 Aug 2024 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgsYE1Mm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2804372;
	Fri, 16 Aug 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767147; cv=none; b=BwQsnWWFnOPv7BqIq6kAp7BQerWx3wDTaNEXfUNloPrO53SiMyYHtUZp3AaisLVX8leULn2KUMZWyWZJx+wemrfkbPKTJpGnvdMecWhElQXFWqF4k7DhfO6vJ8qliDjqnX4PVJta511HvyjAvgzTYBnY2hoeCYGO1kf/JGhnCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767147; c=relaxed/simple;
	bh=GvB4H22h4QOyHHefP0mnM9E2EBFfbvQezXUvW6AQ6SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHFVVsbPT9VXn/lPIcKA3W/iL1sQe+lx7O0RUSGK09juLSB0R2GCfJw8VKzNsuF7UUcwVO5YDBiv4OQ9s1qK3ZSdTrFTeTqm0CL7QJwRjZKtep101to/iOd0EU3KAEebAqpbqKIzXMKMx8rFscwNF9t+YnR+MXkBgqiByP0XI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgsYE1Mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F35C32786;
	Fri, 16 Aug 2024 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767145;
	bh=GvB4H22h4QOyHHefP0mnM9E2EBFfbvQezXUvW6AQ6SA=;
	h=From:To:Cc:Subject:Date:From;
	b=sgsYE1Mmtxil7/a6m3cG2btLqmK6ozsLre3AI7CyeIiHtX9LBN44IKFRbbVzuesFM
	 m91KQjAnMURXZHVKLcJd5TAuc56RLjMB6AYtnLgNTd8S39gtk2qcf4JH41EXoony4i
	 KJIYCrAHG/so0u3tM/DTzlKwc8sLq6pYIlD6ReygtL88wPLqV17g7/pc1iQucBvc2w
	 R7Sctawot6rvBA0e9bF3floY/7x69IZcXXFgh6TfaVvTK48aCpR/VfH563Xfur4NJI
	 OzZ2IgoLxZBM72horxdefwdBcnPpdJYBd7NVBxN8nKew0NJHSz0jkrPLg460NnI5Ex
	 XGfyXeGFi55eg==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 00/26] Generic `Allocator` support for Rust
Date: Fri, 16 Aug 2024 02:10:42 +0200
Message-ID: <20240816001216.26575-1-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds generic kernel allocator support for Rust, which so far
is limited to `kmalloc` allocations.

In order to abstain from (re-)adding unstable Rust features to the kernel, this
patch series does not extend the `Allocator` trait from Rust's `alloc` crate,
nor does it extend the `BoxExt` and `VecExt` extensions.

Instead, this series introduces a kernel specific `Allocator` trait, which is
implemented by the `Kmalloc`, `Vmalloc` and `KVmalloc` allocators, also
implemented in the context of this series.

As a consequence we need our own kernel `Box<T, A>` and `Vec<T, A>` types.
Additionally, this series adds the following type aliases:

```
pub type KBox<T> = Box<T, Kmalloc>;
pub type VBox<T> = Box<T, Vmalloc>;
pub type KVBox<T> = Box<T, KVmalloc>;


pub type KVec<T> = Vec<T, Kmalloc>;
pub type VVec<T> = Vec<T, Vmalloc>;
pub type KVVec<T> = Vec<T, KVmalloc>;
```

With that, we can start using the kernel `Box` and `Vec` types throughout the
tree and remove the now obolete extensions `BoxExt` and `VecExt`.

For a final cleanup, this series removes the last minor dependencies to Rust's
`alloc` crate and removes it from the entire kernel build.

The series ensures not to break the `rusttest` make target by implementing the
`allocator_test` module providing a stub implementation for all kernel
`Allocator`s.

This patch series passes all KUnit tests, including the ones added by this
series. Additionally, the tests were run with `kmemleak` and `KASAN` enabled,
without any issues.

This series is based on [1], which hit -mm/mm-unstable, and is also available
in [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm

Changes in v6:
 - rebase onto rust-dev
 - keep compiler annotations for {k,v,kv}realloc()
 - documentation changes suggested by Alice, Benno
 - remove `Box::into_pin`
 - fix typo in `Send` and `Sync` for `Box` and `Vec`
 - `kvec!` changes suggested by Alice
 - free `src` after copy in `Cmalloc`
 - handle `n == 0` in `Vec::extend_with`

Changes in v5:
 - (safety) comment / documentation fixes suggested by Alice, Benno and Gary
 - remove `Unique<T>` and implement `Send` and `Sync` for `Box` and `Vec`
 - use `KMALLOC_MAX_SIZE` for `KVmalloc` test and add a `Kmalloc` test that
   expects to fail for `KMALLOC_MAX_SIZE`
 - create use constants `KREALLOC`, `VREALLOC` and `KVREALLOC` for
   `ReallocFuncs`
 - drop `Box::drop_contents` for now, will add it again, once I actually rebase
   on the original patch that introduces it
 - improve usage of `size_of_val` in `Box`
 - move `InPlaceInit` and `ForeignOwnable` impls into kbox.rs
 - fix missing `Box` conversions in rnull.rs
 - reworked `Cmalloc` to keep track of the size of memory allocations itself
 - remove `GlobalAlloc` together with the `alloc` crate to avoid a linker error
 - remove `alloc` from scripts/generate_rust_analyzer.py

Changes in v4:
 - (safety) comment fixes suggested by Alice and Boqun
 - remove `Box::from_raw_alloc` and `Box::into_raw_alloc`, we don't need them
 - in `Box::drop` call `size_of_val` before `drop_in_place`
 - implement ForeignOwnable for Pin<Box<T>> as suggested by Alice
 - in `Vec::extend_with`, iterate over `n` instead of `spare.len()`
 - for `Vmalloc` and `KVmalloc` fail allocation for alignments larger than
   PAGE_SIZE for now (will add support for larger alignments in a separate
   series)
 - implement `Cmalloc` in `allocator_test` and type alias all kernel allocator
   types to it, such that we can use the kernel's `Box` and `Vec` types in
   userspace tests (rusttest)
   - this makes patch "rust: str: test: replace `alloc::format`" rather trivial

Changes in v3:
 - Box:
   - minor documentation fixes
   - removed unnecessary imports in doc tests
   - dropeed `self` argument from some remaining `Box` methods
   - implement `InPlaceInit` for Box<T, A> rather than specifically for `KBox<T>`
 - Vec:
   - minor documentation fixes
   - removed useless `Vec::allocator` method
   - in `Vec::extend_with` use `Vec::spare_capacity_mut` instead of raw pointer operations
   - added a few missing safety comments
   - pass GFP flags to `Vec::collect`
 - fixed a rustdoc warning in alloc.rs
 - fixed the allocator_test module to implement the `Allocator` trait correctly
 - rebased to rust-next

Changes in v2:
  - preserve `impl GlobalAlloc for Kmalloc` and remove it at the end (Benno)
  - remove `&self` parameter from all `Allocator` functions (Benno)
  - various documentation fixes for `Allocator` (Benno)
  - use `NonNull<u8>` for `Allocator::free` and `Option<NonNull<u8>>` for
    `Allocator::realloc` (Benno)
  - fix leak of `IntoIter` in `Vec::collect` (Boqun)
  - always realloc (try to shrink) in `Vec::collect`, it's up the the
    `Allocator` to provide a heuristic whether it makes sense to actually shrink
  - rename `KBox<T, A>` -> `Box<T, A>` and `KVec<T, A>` -> `Vec<T, A>` and
    provide type aliases `KBox<T>`, `VBox<T>`, `KVBox<T>`, etc.
    - This allows for much cleaner code and, in combination with removing
      `&self` parameters from `Allocator`s, gets us rid of the need for
      `Box::new` and `Box::new_alloc` and all other "_alloc" postfixed
      functions.
    - Before: `KBox::new_alloc(foo, Vmalloc)?`
    - After:  `VBox::new(foo)?`, which resolves to
              `Box::<Foo,  Vmalloc>::new(foo)?;


Danilo Krummrich (26):
  rust: alloc: add `Allocator` trait
  rust: alloc: separate `aligned_size` from `krealloc_aligned`
  rust: alloc: rename `KernelAllocator` to `Kmalloc`
  rust: alloc: implement `Allocator` for `Kmalloc`
  rust: alloc: add module `allocator_test`
  rust: alloc: implement `Vmalloc` allocator
  rust: alloc: implement `KVmalloc` allocator
  rust: alloc: add __GFP_NOWARN to `Flags`
  rust: alloc: implement kernel `Box`
  rust: treewide: switch to our kernel `Box` type
  rust: alloc: remove `BoxExt` extension
  rust: alloc: add `Box` to prelude
  rust: alloc: implement kernel `Vec` type
  rust: alloc: implement `IntoIterator` for `Vec`
  rust: alloc: implement `collect` for `IntoIter`
  rust: treewide: switch to the kernel `Vec` type
  rust: alloc: remove `VecExt` extension
  rust: alloc: add `Vec` to prelude
  rust: error: use `core::alloc::LayoutError`
  rust: error: check for config `test` in `Error::name`
  rust: alloc: implement `contains` for `Flags`
  rust: alloc: implement `Cmalloc` in module allocator_test
  rust: str: test: replace `alloc::format`
  rust: alloc: update module comment of alloc.rs
  kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
  MAINTAINERS: add entry for the Rust `alloc` module

 MAINTAINERS                         |   7 +
 drivers/block/rnull.rs              |   4 +-
 rust/Makefile                       |  44 +-
 rust/bindings/bindings_helper.h     |   1 +
 rust/exports.c                      |   1 -
 rust/helpers.c                      |  15 +
 rust/kernel/alloc.rs                | 142 ++++-
 rust/kernel/alloc/allocator.rs      | 173 ++++--
 rust/kernel/alloc/allocator_test.rs | 185 ++++++
 rust/kernel/alloc/box_ext.rs        |  80 ---
 rust/kernel/alloc/kbox.rs           | 480 +++++++++++++++
 rust/kernel/alloc/kvec.rs           | 891 ++++++++++++++++++++++++++++
 rust/kernel/alloc/vec_ext.rs        | 185 ------
 rust/kernel/error.rs                |   6 +-
 rust/kernel/init.rs                 |  93 +--
 rust/kernel/init/__internal.rs      |   2 +-
 rust/kernel/lib.rs                  |   1 -
 rust/kernel/prelude.rs              |   5 +-
 rust/kernel/rbtree.rs               |  34 +-
 rust/kernel/str.rs                  |  35 +-
 rust/kernel/sync/arc.rs             |  17 +-
 rust/kernel/sync/condvar.rs         |   4 +-
 rust/kernel/sync/lock/mutex.rs      |   2 +-
 rust/kernel/sync/lock/spinlock.rs   |   2 +-
 rust/kernel/sync/locked_by.rs       |   2 +-
 rust/kernel/types.rs                |  30 +-
 rust/kernel/uaccess.rs              |  17 +-
 rust/kernel/workqueue.rs            |  20 +-
 rust/macros/lib.rs                  |  12 +-
 samples/rust/rust_minimal.rs        |   4 +-
 scripts/Makefile.build              |   7 +-
 scripts/generate_rust_analyzer.py   |  11 +-
 32 files changed, 1973 insertions(+), 539 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs
 delete mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/kbox.rs
 create mode 100644 rust/kernel/alloc/kvec.rs
 delete mode 100644 rust/kernel/alloc/vec_ext.rs


base-commit: f005c686d6c1a2e66f2f9d21179d6b6bd45b20e2
-- 
2.46.0


