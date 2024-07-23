Return-Path: <linux-kernel+bounces-260271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC5093A545
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418C3B21B60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7992E158862;
	Tue, 23 Jul 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgmy56LJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38013B5B4;
	Tue, 23 Jul 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758253; cv=none; b=rFM5p/TLtJMSoMDqP6GTEDrMD4h7EMk+aSqo3laZs0Xz5f6e8D4bV1qNB7uqLjmjRBzjpS4IuKfGOmR+COIJrsodUjRPqMwtkaU+TJYemoqF4GD/DIl4ZFfU4ORfgs4Ip4R03zh9iiCRIWnmFWy8gkboXaJG+PZcihiNOSNV3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758253; c=relaxed/simple;
	bh=ki5xi3wh309ewAEmvFrHMp8ZsNfUwPpdMts9frlaya8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/5djHt5ooPu5fD/YJ6EV1ljcYKdhLoPSesNYGX8CNquvDeJWyxZl4r1UY8Kpfy8P3OMLMYsigIDRarkHVGljlh3VPxR4AbEa3dBOrhjZOkP1JIUMM9/czrbhdk3w5ujz85jQAlXgxjDbLitLxfr76uvd5DdyVgnNlBFqXZsAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgmy56LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13310C4AF09;
	Tue, 23 Jul 2024 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758253;
	bh=ki5xi3wh309ewAEmvFrHMp8ZsNfUwPpdMts9frlaya8=;
	h=From:To:Cc:Subject:Date:From;
	b=mgmy56LJp97CUmhcB329aE9XUHwKBkmDtwij09R2LbuKlj+gBKG9zIFzHZkdsoZXL
	 JUcsnCBgpliWD6Hj9VoQJ/+yJiZylAmIykvtzIXbVvjt9XET5mdGBibKSMAqns783F
	 LnpxzQFZTzZBqgjwp4maGofG0exKc/6gn+P9Il2kIVpy4DBOl5fkwgSZ87jd2c3Bxu
	 OkVvoyNVQflbtb9F3jfLC3Dn6Wub+l9TWALhoV1AskwZH0TXohxSarBNnLcSO8s1on
	 6yt+g/C7txLZD0BKH5V6FDkTP4Kzn+p4UUAvlXP/+jT2eQKuXEEYcIT+A5nJQCDNyt
	 lhZu9ySAcoCbw==
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
Subject: [PATCH v2 00/23] Generic `Allocator` support for Rust
Date: Tue, 23 Jul 2024 20:09:49 +0200
Message-ID: <20240723181024.21168-1-dakr@kernel.org>
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

This series is based in [1], which just hit -mm/mm-unstable, and is also
available in [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm

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

Danilo Krummrich (23):
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
  rust: alloc: implement kernel `Vec` type
  rust: alloc: implement `IntoIterator` for `Vec`
  rust: alloc: implement `collect` for `IntoIter`
  rust: treewide: switch to the kernel `Vec` type
  rust: alloc: remove `VecExt` extension
  rust: alloc: add `Vec` to prelude
  rust: alloc: remove `GlobalAlloc` and `krealloc_aligned`
  rust: error: use `core::alloc::LayoutError`
  rust: str: test: replace `alloc::format`
  kbuild: rust: remove the `alloc` crate

 rust/Makefile                       |  44 +-
 rust/exports.c                      |   1 -
 rust/helpers.c                      |  15 +
 rust/kernel/alloc.rs                |  99 +++-
 rust/kernel/alloc/allocator.rs      | 147 +++--
 rust/kernel/alloc/allocator_test.rs |  23 +
 rust/kernel/alloc/box_ext.rs        |  56 --
 rust/kernel/alloc/kbox.rs           | 344 ++++++++++++
 rust/kernel/alloc/kvec.rs           | 831 ++++++++++++++++++++++++++++
 rust/kernel/alloc/vec_ext.rs        | 185 -------
 rust/kernel/error.rs                |   2 +-
 rust/kernel/init.rs                 |  49 +-
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
 rust/kernel/workqueue.rs            |  20 +-
 samples/rust/rust_minimal.rs        |   4 +-
 scripts/Makefile.build              |   7 +-
 25 files changed, 1713 insertions(+), 419 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs
 delete mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/kbox.rs
 create mode 100644 rust/kernel/alloc/kvec.rs
 delete mode 100644 rust/kernel/alloc/vec_ext.rs


base-commit: d270beaca6818349b2aed7e6034b800a777087cc
-- 
2.45.2


