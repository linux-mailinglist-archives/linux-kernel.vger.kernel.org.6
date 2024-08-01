Return-Path: <linux-kernel+bounces-270005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D143D9439E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F26B20D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420E441F;
	Thu,  1 Aug 2024 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXUJelO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEE1113;
	Thu,  1 Aug 2024 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470812; cv=none; b=ovoMamErVk3tb0sIX8zVDCj9XPpAt2qhruZiqdv1eYLfp2sRZvVql5vkoZbewARUYw5QQ/6Sh6bpsV5NmuWcd/D8jYfdxhSynA98dnpOZr9Duti4rdRHU5SmMUAk+Eezz7+ob61cU+RaEVm0kM7L67V0K5w0eO+WlZ6z1OpSh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470812; c=relaxed/simple;
	bh=IRxbzLwh8BnLAQZ/qRxPBDb50SXvHiJg+HVmjPu4N+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZ/ZLGwpYnzmbv85qyYxENZd5cTqWvC6SLVZ31+4vs7JV4U5ktoLMnczQU3A/i24J7M5SCVz/6jLhXSMDQfVOfBeAMnEIVdsHov+qeINZOLtsIe69uSqXZ81es3hWywYSotiNMpEIjtXmeUBbOF65nmQelzU9AbeqkR45GsmdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXUJelO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCDBC116B1;
	Thu,  1 Aug 2024 00:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470812;
	bh=IRxbzLwh8BnLAQZ/qRxPBDb50SXvHiJg+HVmjPu4N+0=;
	h=From:To:Cc:Subject:Date:From;
	b=TXUJelO7b8OtoI20SuAqbmQV/LqtOEo8lq2/2feGq7apkml4s2IHHa5ENEPIqkfdz
	 e5twvtWtJRVKJyFn2mRKfMXD4Vl5y2H0BwSDRprZTjRAMeq8+Hkh6I1JO1I+Vv5gVN
	 NP+byJIReArdl38kN6/RXgw7GimUynSKtBRNHTN/rphFZZcmlutcINQ82lYPzrPyQi
	 G0HUfv9Uwm251cjDejh8plkETYDeAcJA7u4Y1/74l/FYlOoqCa1tpQIloKto5uWt+e
	 wrLJWpThG4j2JVkTudldKKtKIM2YBcabVthknRvOmxeROLu2597KpQ6giJZYusqwob
	 ku30/KQ8AQUHA==
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
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 00/25] Generic `Allocator` support for Rust
Date: Thu,  1 Aug 2024 02:01:59 +0200
Message-ID: <20240801000641.1882-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
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

Danilo Krummrich (25):
  rust: alloc: add `Allocator` trait
  rust: alloc: separate `aligned_size` from `krealloc_aligned`
  rust: alloc: rename `KernelAllocator` to `Kmalloc`
  rust: alloc: implement `Allocator` for `Kmalloc`
  rust: alloc: add module `allocator_test`
  rust: alloc: implement `Vmalloc` allocator
  rust: alloc: implement `KVmalloc` allocator
  rust: types: implement `Unique<T>`
  rust: alloc: implement kernel `Box`
  rust: treewide: switch to our kernel `Box` type
  rust: alloc: remove `BoxExt` extension
  rust: alloc: add `Box` to prelude
  rust: alloc: import kernel `Box` type in types.rs
  rust: alloc: import kernel `Box` type in init.rs
  rust: alloc: implement kernel `Vec` type
  rust: alloc: implement `IntoIterator` for `Vec`
  rust: alloc: implement `collect` for `IntoIter`
  rust: treewide: switch to the kernel `Vec` type
  rust: alloc: remove `VecExt` extension
  rust: alloc: add `Vec` to prelude
  rust: alloc: remove `GlobalAlloc` and `krealloc_aligned`
  rust: error: use `core::alloc::LayoutError`
  rust: str: test: replace `alloc::format`
  rust: alloc: update module comment of alloc.rs
  kbuild: rust: remove the `alloc` crate

 rust/Makefile                       |  44 +-
 rust/exports.c                      |   1 -
 rust/helpers.c                      |  15 +
 rust/kernel/alloc.rs                | 101 +++-
 rust/kernel/alloc/allocator.rs      | 147 +++--
 rust/kernel/alloc/allocator_test.rs |  21 +
 rust/kernel/alloc/box_ext.rs        |  56 --
 rust/kernel/alloc/kbox.rs           | 340 +++++++++++
 rust/kernel/alloc/kvec.rs           | 847 ++++++++++++++++++++++++++++
 rust/kernel/alloc/vec_ext.rs        | 185 ------
 rust/kernel/error.rs                |   2 +-
 rust/kernel/init.rs                 |  56 +-
 rust/kernel/init/__internal.rs      |   2 +-
 rust/kernel/lib.rs                  |   1 -
 rust/kernel/prelude.rs              |   5 +-
 rust/kernel/str.rs                  |  78 ++-
 rust/kernel/sync/arc.rs             |  17 +-
 rust/kernel/sync/condvar.rs         |   4 +-
 rust/kernel/sync/lock/mutex.rs      |   2 +-
 rust/kernel/sync/lock/spinlock.rs   |   2 +-
 rust/kernel/sync/locked_by.rs       |   2 +-
 rust/kernel/types.rs                | 192 ++++++-
 rust/kernel/uaccess.rs              |  15 +-
 rust/kernel/workqueue.rs            |  20 +-
 samples/rust/rust_minimal.rs        |   4 +-
 scripts/Makefile.build              |   7 +-
 26 files changed, 1735 insertions(+), 431 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs
 delete mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/kbox.rs
 create mode 100644 rust/kernel/alloc/kvec.rs
 delete mode 100644 rust/kernel/alloc/vec_ext.rs


base-commit: c0d669a6bbe161a3afa26dea3d8491863e352e59
-- 
2.45.2


