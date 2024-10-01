Return-Path: <linux-kernel+bounces-346175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5698C0F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE36B23935
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2E42A92;
	Tue,  1 Oct 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAZxkhTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829F27448;
	Tue,  1 Oct 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794817; cv=none; b=Re7G8TIYq4TQahIhpYS7dG709xgJEBT+1TqOrNn2HbCpa9AjU5HMUyME11FKc6Lk0bqw/7Mnhyzs/IBWQ79c8ukimwd2CkFC46PDE9Heg4LOCAUQzvXMqrQl7sonRfYCQlvzuDOzhNsE5swLM+5qK/f8PAiIQ8/0RegnJZunRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794817; c=relaxed/simple;
	bh=TY5QTgWwxcJ1l0LmCJfN1EPNmFztFC3t7VJK8afO1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDh17oQc1CkcUJk/fNNv9UMiM/RtTAZo60+gYrssu6VyPLlzlYQSo9x1ERDqkyTSENEjZfJup9EOLs7S2Wc2dNd/SqhN52/TaGyCwl9FxGFUz6F1j+e8LXtKLYEXzUgAb0K42bNBdQQg+ebYk87E9TsQp4JwPEWRGYVetL057tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAZxkhTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBF2C4CEC6;
	Tue,  1 Oct 2024 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794816;
	bh=TY5QTgWwxcJ1l0LmCJfN1EPNmFztFC3t7VJK8afO1Z4=;
	h=From:To:Cc:Subject:Date:From;
	b=HAZxkhTaunlrbgHCLe+elDs5UNKXOLeVOu+fht/Oacya2f1qGfqLqczmu6kk1YHnk
	 O5a3zHsm5+SobPZHt9eg/qcFWAMxLaZqQqF46OwU142PZ2Rhz911rJCZdZE59u9zgc
	 syZ65RRR/0I2hvK4yemz0txZaoMQiLjNu71ZOxGuOPtS5J54UTs6GVYIt82ZCbsucq
	 GHTu/4jkoYu41xRQrDhWUa5AkyuPmZWg+1GnJuszce+d0oY8gS2jZ/xiHsINZj3K9+
	 K5FNN+4ltFnwBB2MKbQoLwC27kvEUN2/GZiyaVxo5lcs3D8ZlhjnitvTUuOSuyOtKv
	 +9LdfN/TeVswQ==
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
Subject: [PATCH v8 00/29] Generic `Allocator` support for Rust
Date: Tue,  1 Oct 2024 16:59:35 +0200
Message-ID: <20241001150008.183102-1-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
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

This series is based on [1], which hit -mm/mm-stable, and is also available
in [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm

Changes in v8:
  - rebase onto rust-next (v6.12-rc1), including the -mm dependencies from [1]
  - introduce `ArrayLayout` and rework the `Allocator` trait to take an
    `old_layout` argument
  - split up "rust: alloc: implement `Allocator` for `Kmalloc`" in three
    separate patches (introduce `ReallocFunc`, make allocator module public and
    implement `Kmalloc`)
  - wrap `impl_slice_eq!` pattern in `$()*`
  - couple of style changes suggested by Benno and Gary

Changes in v7:
 - rebase onto rust-next resolving recent conflicts (93dc3be19450447a3a7090bd1dfb9f3daac3e8d2)
 - documentation / safety comment changes suggested by Benno and Boqun
 - rename `ptr` to `current` in `IntoIter::next` (Alice)
 - remove unnecessary braces in `kvec!` (Benno)
 - add `debug_assert!` in `Vec::set_len` (Benno)
 - remove unused args in `impl_slice_eq!` (Benno)
 - simplify `if` statement in `Cmalloc::realloc` (Benno)

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

Benno Lossin (1):
  rust: alloc: introduce `ArrayLayout`

Danilo Krummrich (28):
  rust: alloc: add `Allocator` trait
  rust: alloc: separate `aligned_size` from `krealloc_aligned`
  rust: alloc: rename `KernelAllocator` to `Kmalloc`
  rust: alloc: implement `ReallocFunc`
  rust: alloc: make `allocator` module public
  rust: alloc: implement `Allocator` for `Kmalloc`
  rust: alloc: add module `allocator_test`
  rust: alloc: implement `Vmalloc` allocator
  rust: alloc: implement `KVmalloc` allocator
  rust: alloc: add __GFP_NOWARN to `Flags`
  rust: alloc: implement kernel `Box`
  rust: treewide: switch to our kernel `Box` type
  rust: alloc: remove extension of std's `Box`
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
 rust/Makefile                       |  43 +-
 rust/bindings/bindings_helper.h     |   1 +
 rust/exports.c                      |   1 -
 rust/helpers/helpers.c              |   1 +
 rust/helpers/slab.c                 |   6 +
 rust/helpers/vmalloc.c              |   9 +
 rust/kernel/alloc.rs                | 150 ++++-
 rust/kernel/alloc/allocator.rs      | 208 +++++--
 rust/kernel/alloc/allocator_test.rs |  95 +++
 rust/kernel/alloc/box_ext.rs        |  89 ---
 rust/kernel/alloc/kbox.rs           | 455 ++++++++++++++
 rust/kernel/alloc/kvec.rs           | 901 ++++++++++++++++++++++++++++
 rust/kernel/alloc/layout.rs         |  91 +++
 rust/kernel/alloc/vec_ext.rs        | 185 ------
 rust/kernel/error.rs                |   6 +-
 rust/kernel/init.rs                 |  95 +--
 rust/kernel/init/__internal.rs      |   2 +-
 rust/kernel/lib.rs                  |   1 -
 rust/kernel/prelude.rs              |   5 +-
 rust/kernel/rbtree.rs               |  49 +-
 rust/kernel/str.rs                  |  35 +-
 rust/kernel/sync/arc.rs             |  17 +-
 rust/kernel/sync/condvar.rs         |   4 +-
 rust/kernel/sync/lock/mutex.rs      |   2 +-
 rust/kernel/sync/lock/spinlock.rs   |   2 +-
 rust/kernel/sync/locked_by.rs       |   2 +-
 rust/kernel/types.rs                |  52 +-
 rust/kernel/uaccess.rs              |  17 +-
 rust/kernel/workqueue.rs            |  20 +-
 rust/macros/lib.rs                  |  12 +-
 samples/rust/rust_minimal.rs        |   4 +-
 scripts/Makefile.build              |   7 +-
 scripts/generate_rust_analyzer.py   |  11 +-
 35 files changed, 2009 insertions(+), 580 deletions(-)
 create mode 100644 rust/helpers/vmalloc.c
 create mode 100644 rust/kernel/alloc/allocator_test.rs
 delete mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/kbox.rs
 create mode 100644 rust/kernel/alloc/kvec.rs
 create mode 100644 rust/kernel/alloc/layout.rs
 delete mode 100644 rust/kernel/alloc/vec_ext.rs


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.46.1


