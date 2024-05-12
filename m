Return-Path: <linux-kernel+bounces-177001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBB98C385B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B30C2815FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828B5381A;
	Sun, 12 May 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B72AO/uo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A820DC3;
	Sun, 12 May 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715545429; cv=none; b=hwgtohV6MOaowA0YpGc37Il53UNi4K3S5UiJoHAsPgIdV8Tj02RO86z6QMWbfj3hAR9z4SzmdmEVT6I2rjWmi+AbKr0stIH82SLqvEzswcTHzMv0iD7BgdXEnJejl8Ds9ZnghvH0F1bdHv3PIHcAmGzHGBWdSO+bVMJ5nkrjlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715545429; c=relaxed/simple;
	bh=j507y5C/La6NO82bSXcA9zpwefRJk9WhjjOLafJAwqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBuMkdN8fIVs+70KGD46YF/8kOsjg+lxD1OdJyuhYqgaWP9fa+fv0BVdCTMIgNFYSS/PtNsM5liPvsNgPACMut5KahpQV/6i6JycmxLIsV2wPME3ifswx4cXGnAw7JCIorM7020RQXYjN8qgIR3bm3F/kqbweQe8jRY/XVZvMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B72AO/uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD3C116B1;
	Sun, 12 May 2024 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715545428;
	bh=j507y5C/La6NO82bSXcA9zpwefRJk9WhjjOLafJAwqU=;
	h=From:To:Cc:Subject:Date:From;
	b=B72AO/uox60ibF+aGPIKuNFLNgx1jKkRU3Q/xTWPmvzgBEmDcyGIbwBv6CXDz0/2o
	 NzaDcxaT3+zHpJEFVr/WGYlKVI8G0j70d1xzSVeIorjK7EWlkBZ+LnnAsVxD1h3aqu
	 2er3FJg3tKkQg8OcPOXDkCeeGUW6Zw87kOOtX8QgTQg5AzPdQKNYq6L+dR5BatsWUr
	 qnswJBpKR7z7QFgsvrmFruGTRZ9g68XEkMkCHZ+U7d6iIg8G6tYWNkXfVHwxF/giim
	 NccpbqSFjVeloH7bc5wg/Zen2K0kyWPplEBGlVG9CEfwC6eWIbDIvzchqI5laXLAkI
	 PV/2oSQNHYlCg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.10
Date: Sun, 12 May 2024 22:22:15 +0200
Message-ID: <20240512202215.67763-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

All the commits have been in linux-next for a week or more, except for
the fix on top, which has been in 3 linux-next tags.

A simple conflict with the Kbuild pull expected. It is resolved in
linux-next. No changes to the C side.

You will likely get initial Rust support for 64-bit RISC-V, as well as
an abstraction for `ktime_t` (together with a small cleanup) and updates
to the Chinese docs translation through their respective trees.

Please pull for v6.10 -- thanks!

Cheers,
Miguel

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.10

for you to fetch changes up to 97ab3e8eec0ce79d9e265e6c9e4c480492180409:

  rust: alloc: fix dangling pointer in VecExt<T>::reserve() (2024-05-08 00:43:30 +0200)

----------------------------------------------------------------
Rust changes for v6.10

The most notable change is the drop of the 'alloc' in-tree fork. This
is nicely reflected in the diffstat as a ~10k lines drop. In turn, this
makes the version upgrades way simpler and smaller in the future, e.g.
the latest one in commit 56f64b370612 ("rust: upgrade to Rust 1.78.0").

More importantly, this increases the chances that a newer compiler
version just works, which in turn means supporting several compiler
versions is easier now. Thus we will look into finally setting a minimum
version in the near future.

Toolchain and infrastructure:

 - Upgrade to Rust 1.78.0.

   This time around, due to how the kernel and Rust schedules have
   aligned, there are two upgrades in fact. These allow us to remove one
   more unstable feature ('offset_of') from the list, among other
   improvements.

 - Drop 'alloc' in-tree fork of the standard library crate, which means
   all the unstable features used by 'alloc' (~30 language ones, ~60
   library ones) are not a concern anymore.

 - Support DWARFv5 via the '-Zdwarf-version' flag.

 - Support zlib and zstd debuginfo compression via the
   '-Zdebuginfo-compression' flag.

'kernel' crate:

 - Support allocation flags ('GFP_*'), particularly in 'Box' (via
   'BoxExt'), 'Vec' (via 'VecExt'), 'Arc' and 'UniqueArc', as well as in
   the 'init' module APIs.

 - Remove usage of the 'allocator_api' unstable feature.

 - Remove 'try_' prefix in allocation APIs' names.

 - Add 'VecExt' (an extension trait) to be able to drop the 'alloc'
   fork.

 - Add the '{make,to}_{upper,lower}case()' methods to 'CStr'/'CString'.

 - Add the 'as_ptr' method to 'ThisModule'.

 - Add the 'from_raw' method to 'ArcBorrow'.

 - Add the 'into_unique_or_drop' method to 'Arc'.

 - Display column number in the 'dbg!' macro output by applying the
   equivalent change done to the standard library one.

 - Migrate 'Work' to '#[pin_data]' thanks to the changes in the 'macros'
   crate, which allows to remove an unsafe call in its 'new' associated
   function.

 - Prevent namespacing issues when using the '[try_][pin_]init!' macros
   by changing the generated name of guard variables.

 - Make the 'get' method in 'Opaque' const.

 - Implement the 'Default' trait for 'LockClassKey'.

 - Remove unneeded 'kernel::prelude' imports from doctests.

 - Remove redundant imports.

'macros' crate:

 - Add 'decl_generics' to 'parse_generics()' to support default values,
   and use that to allow them in '#[pin_data]'.

Helpers:

 - Trivial English grammar fix.

Documentation:

 - Add section on Rust Kselftests to the "Testing" document.

 - Expand the "Abstractions vs. bindings" section of the "General
   Information" document.

----------------------------------------------------------------
Alice Ryhl (3):
      rust: add `Module::as_ptr`
      rust: sync: add `ArcBorrow::from_raw`
      rust: sync: add `Arc::into_unique_or_drop`

Benno Lossin (4):
      rust: macros: add `decl_generics` to `parse_generics()`
      rust: macros: allow generic parameter default values in `#[pin_data]`
      rust: workqueue: add `#[pin_data]` to `Work`
      rust: init: change the generated name of guard variables

Boqun Feng (1):
      rust: types: Make Opaque::get const

Danilo Krummrich (2):
      rust: str: add {make,to}_{upper,lower}case() to CString
      rust: alloc: fix dangling pointer in VecExt<T>::reserve()

Dirk Behme (1):
      docs: rust: extend abstraction and binding documentation

Laura Nao (1):
      docs: rust: Add instructions for the Rust kselftest

Miguel Ojeda (6):
      rust: upgrade to Rust 1.77.1
      kbuild: rust: use `-Zdwarf-version` to support DWARFv5
      kbuild: rust: use `-Zdebuginfo-compression`
      rust: sync: implement `Default` for `LockClassKey`
      rust: kernel: remove redundant imports
      rust: upgrade to Rust 1.78.0

Nell Shamrell-Harrington (1):
      rust: remove unneeded `kernel::prelude` imports from doctests

Raghav Narang (1):
      rust: update `dbg!()` to format column number

Thorsten Blum (1):
      rust: helpers: Fix grammar in comment

Wedson Almeida Filho (10):
      rust: kernel: move `allocator` module under `alloc`
      rust: alloc: introduce the `VecExt` trait
      kbuild: use the upstream `alloc` crate
      rust: alloc: remove our fork of the `alloc` crate
      rust: alloc: introduce allocation flags
      rust: alloc: introduce the `BoxExt` trait
      rust: alloc: update `VecExt` to take allocation flags
      rust: sync: update `Arc` and `UniqueArc` to take allocation flags
      rust: init: update `init` module to take allocation flags
      rust: kernel: remove usage of `allocator_api` unstable feature

 Documentation/process/changes.rst          |    2 +-
 Documentation/rust/general-information.rst |   57 +
 Documentation/rust/testing.rst             |   25 +-
 rust/Makefile                              |   16 +-
 rust/alloc/README.md                       |   36 -
 rust/alloc/alloc.rs                        |  452 ----
 rust/alloc/boxed.rs                        | 2463 -------------------
 rust/alloc/collections/mod.rs              |  160 --
 rust/alloc/lib.rs                          |  288 ---
 rust/alloc/raw_vec.rs                      |  611 -----
 rust/alloc/slice.rs                        |  890 -------
 rust/alloc/vec/drain.rs                    |  255 --
 rust/alloc/vec/extract_if.rs               |  115 -
 rust/alloc/vec/into_iter.rs                |  454 ----
 rust/alloc/vec/is_zero.rs                  |  204 --
 rust/alloc/vec/mod.rs                      | 3683 ----------------------------
 rust/alloc/vec/partial_eq.rs               |   49 -
 rust/alloc/vec/set_len_on_drop.rs          |   35 -
 rust/alloc/vec/spec_extend.rs              |  119 -
 rust/bindings/bindings_helper.h            |    3 +
 rust/helpers.c                             |    2 +-
 rust/kernel/alloc.rs                       |   73 +
 rust/kernel/{ => alloc}/allocator.rs       |   19 +-
 rust/kernel/alloc/box_ext.rs               |   56 +
 rust/kernel/alloc/vec_ext.rs               |  182 ++
 rust/kernel/error.rs                       |   14 +-
 rust/kernel/init.rs                        |   63 +-
 rust/kernel/init/macros.rs                 |   47 +-
 rust/kernel/lib.rs                         |   13 +-
 rust/kernel/net/phy.rs                     |    2 +-
 rust/kernel/prelude.rs                     |    2 +
 rust/kernel/print.rs                       |    5 -
 rust/kernel/std_vendor.rs                  |    7 +-
 rust/kernel/str.rs                         |   98 +-
 rust/kernel/sync.rs                        |    6 +
 rust/kernel/sync/arc.rs                    |  189 +-
 rust/kernel/sync/condvar.rs                |    3 +-
 rust/kernel/sync/lock.rs                   |    2 +-
 rust/kernel/sync/lock/mutex.rs             |    4 +-
 rust/kernel/sync/lock/spinlock.rs          |    4 +-
 rust/kernel/task.rs                        |    2 +-
 rust/kernel/types.rs                       |    6 +-
 rust/kernel/workqueue.rs                   |   54 +-
 rust/macros/helpers.rs                     |  122 +-
 rust/macros/pin_data.rs                    |    2 +
 rust/macros/zeroable.rs                    |    1 +
 samples/rust/rust_minimal.rs               |    6 +-
 samples/rust/rust_print.rs                 |    4 +-
 scripts/Makefile.build                     |    2 +-
 scripts/Makefile.debug                     |    8 +
 scripts/generate_rust_analyzer.py          |    2 +-
 scripts/generate_rust_target.rs            |    2 +-
 scripts/min-tool-version.sh                |    2 +-
 53 files changed, 878 insertions(+), 10043 deletions(-)
 delete mode 100644 rust/alloc/README.md
 delete mode 100644 rust/alloc/alloc.rs
 delete mode 100644 rust/alloc/boxed.rs
 delete mode 100644 rust/alloc/collections/mod.rs
 delete mode 100644 rust/alloc/lib.rs
 delete mode 100644 rust/alloc/raw_vec.rs
 delete mode 100644 rust/alloc/slice.rs
 delete mode 100644 rust/alloc/vec/drain.rs
 delete mode 100644 rust/alloc/vec/extract_if.rs
 delete mode 100644 rust/alloc/vec/into_iter.rs
 delete mode 100644 rust/alloc/vec/is_zero.rs
 delete mode 100644 rust/alloc/vec/mod.rs
 delete mode 100644 rust/alloc/vec/partial_eq.rs
 delete mode 100644 rust/alloc/vec/set_len_on_drop.rs
 delete mode 100644 rust/alloc/vec/spec_extend.rs
 create mode 100644 rust/kernel/alloc.rs
 rename rust/kernel/{ => alloc}/allocator.rs (85%)
 create mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/vec_ext.rs

