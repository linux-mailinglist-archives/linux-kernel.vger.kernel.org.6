Return-Path: <linux-kernel+bounces-337679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8DF984D71
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9E01C20E39
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00833146D76;
	Tue, 24 Sep 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2srPkut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157036E614;
	Tue, 24 Sep 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215865; cv=none; b=VKTVjQZGWFeOx72hZu+JhkIalmEe/p3CIw366far64SLo+xh5j+X9dugPvwsvWMf4dctVaJtBgIDxbUJ2hYzbbPpkkm2BMOdZ9q8g29aLH+oSaswKm5ga4u2/O1XC1HHY2RfiQ0XBB8NkKuKdgHolDRbGynmi7J4pyDM9462v80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215865; c=relaxed/simple;
	bh=Yt/sMjEffMjjPuTPQdKdC6kHuAqr5rF7lMy0jLkO11M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mta2CkegbVi7CQ095/KDgt6bWQNfkhjxvy1wAfRpsx02z2Qf4DDOfbMBhAgiJ38b7AP1oeG7X4/+MRiQuIC+N2JbTByTnCpRb4fAbmAih6FqOPjhkqlBkEhJsYAbjSRocYattSfeesDxVtsLs8y+G2fj8I7CC4BeZYyNQyfqt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2srPkut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB5CC4CEC4;
	Tue, 24 Sep 2024 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727215864;
	bh=Yt/sMjEffMjjPuTPQdKdC6kHuAqr5rF7lMy0jLkO11M=;
	h=From:To:Cc:Subject:Date:From;
	b=R2srPkut3uBbw7TBjeI7pX6Mha/C6MoKdaWsXAN/tSnz0IAl968PzSd5yzrAoF4d7
	 /6hB1wRqsfnIrheRblV9xN8unkRp2dGNnDZg2dmmz1+pkYXfYV9s+agtOmZE4yzs/o
	 Mi0A6D2nlhunULg4ZkJFbjI8ydV7qoC7bABo3qV+u3cqi0jg0QWvPEWBWR6HCGAeIy
	 r25ugSGol0o24dHKrckTuY+7w/vS4Xt8mSimnXODUXTk7PNb84jIf3vsiQxiKI1SiH
	 RtXQM+v21ODVhbDG09gDn10E1Lcd/xETf6fU16u59QVmYoxbf6L9Utf0frrcvUxL3I
	 Ze3s8rnEcJDIw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.12
Date: Wed, 25 Sep 2024 00:10:23 +0200
Message-ID: <20240924221023.197610-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

Quite late, but all the commits have been in linux-next for at least a
week (most have been for a few weeks).

This PR is a bit more involved than the usual ones -- the relevant
maintainers were OK with us carrying the patches since there were a few
interdependencies.

Three simple conflicts expected. Please note that akpm and I carried
the same patch ("kasan: simplify and clarify Makefile").

Regarding Rust-related things: you already merged the QR code panic
screen via DRM, the Applied Micro QT2025 PHY driver (with a new `sizes`
module) via netdev, a `k{v,}realloc()` patch via mm and two selftest
config fixes. You have also got a firmware code doc fix via asoc.

Please pull for v6.12 -- thanks!

Cheers,
Miguel

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.12

for you to fetch changes up to a2f11547052001bd448ccec81dd1e68409078fbb:

  kasan: rust: Add KASAN smoke test via UAF (2024-09-16 18:04:37 +0200)

----------------------------------------------------------------
Rust changes for v6.12

Toolchain and infrastructure:

 - Support 'MITIGATION_{RETHUNK,RETPOLINE,SLS}' (which cleans up objtool
   warnings), teach objtool about 'noreturn' Rust symbols and mimic
   '___ADDRESSABLE()' for 'module_{init,exit}'. With that, we should be
   objtool-warning-free, so enable it to run for all Rust object files.

 - KASAN (no 'SW_TAGS'), KCFI and shadow call sanitizer support.

 - Support 'RUSTC_VERSION', including re-config and re-build on change.

 - Split helpers file into several files in a folder, to avoid conflicts
   in it. Eventually those files will be moved to the right places with
   the new build system. In addition, remove the need to manually export
   the symbols defined there, reusing existing machinery for that.

 - Relax restriction on configurations with Rust + GCC plugins to just
   the RANDSTRUCT plugin.

'kernel' crate:

 - New 'list' module: doubly-linked linked list for use with reference
   counted values, which is heavily used by the upcoming Rust Binder.
   This includes 'ListArc' (a wrapper around 'Arc' that is guaranteed
   unique for the given ID), 'AtomicTracker' (tracks whether a 'ListArc'
   exists using an atomic), 'ListLinks' (the prev/next pointers for an
   item in a linked list), 'List' (the linked list itself), 'Iter' (an
   iterator over a 'List'), 'Cursor' (a cursor into a 'List' that allows
   to remove elements), 'ListArcField' (a field exclusively owned by a
   'ListArc'), as well as support for heterogeneous lists.

 - New 'rbtree' module: red-black tree abstractions used by the upcoming
   Rust Binder. This includes 'RBTree' (the red-black tree itself),
   'RBTreeNode' (a node), 'RBTreeNodeReservation' (a memory reservation
   for a node), 'Iter' and 'IterMut' (immutable and mutable iterators),
   'Cursor' (bidirectional cursor that allows to remove elements), as
   well as an entry API similar to the Rust standard library one.

 - 'init' module: add 'write_[pin_]init' methods and the 'InPlaceWrite'
   trait. Add the 'assert_pinned!' macro.

 - 'sync' module: implement the 'InPlaceInit' trait for 'Arc' by
   introducing an associated type in the trait.

 - 'alloc' module: add 'drop_contents' method to 'BoxExt'.

 - 'types' module: implement the 'ForeignOwnable' trait for
   'Pin<Box<T>>' and improve the trait's documentation. In addition,
   add the 'into_raw' method to the 'ARef' type.

 - 'error' module: in preparation for the upcoming Rust support for
   32-bit architectures, like arm, locally allow Clippy lint for those.

Documentation:

 - https://rust.docs.kernel.org has been announced, so link to it.

 - Enable rustdoc's "jump to definition" feature, making its output a
   bit closer to the experience in a cross-referencer.

 - Debian Testing now also provides recent Rust releases (outside of
   the freeze period), so add it to the list.

MAINTAINERS:

 - Trevor is joining as reviewer of the "RUST" entry.

And a few other small bits.

----------------------------------------------------------------
Alex Mantel (1):
      rust: Implement the smart pointer `InPlaceInit` for `Arc`

Alice Ryhl (14):
      rust: implement ForeignOwnable for Pin<Box<T>>
      rust: sort blk includes in bindings_helper.h
      rust: list: add ListArc
      rust: list: add tracking for ListArc
      rust: list: add struct with prev/next pointers
      rust: list: add macro for implementing ListItem
      rust: list: add List
      rust: list: add iterators
      rust: list: add cursor
      rust: list: support heterogeneous lists
      rust: list: add ListArcField
      rust: rbtree: add `RBTree::entry`
      rust: support for shadow call stack sanitizer
      cfi: add CONFIG_CFI_ICALL_NORMALIZE_INTEGERS

Andreas Hindborg (1):
      rust: kbuild: split up helpers.c

Andrey Konovalov (1):
      kasan: simplify and clarify Makefile

Benno Lossin (4):
      rust: types: improve `ForeignOwnable` documentation
      rust: kernel: add `drop_contents` to `BoxExt`
      rust: init: add `write_[pin_]init` functions
      rust: init: add `assert_pinned` macro

Gary Guo (1):
      rust: kbuild: auto generate helper exports

Kartik Prajapati (1):
      rust: types: add `ARef::into_raw`

Matt Gilbride (1):
      rust: rbtree: add cursor

Matthew Maurer (6):
      rust: support arrays in target JSON
      rust: cfi: add support for CFI_CLANG with Rust
      kbuild: rust: Define probing macros for rustc
      rust: kasan: Rust does not support KHWASAN
      kbuild: rust: Enable KASAN support
      kasan: rust: Add KASAN smoke test via UAF

Michael Vetter (1):
      rust: kernel: use docs.kernel.org links in code documentation

Miguel Ojeda (19):
      rust: error: allow `useless_conversion` for 32-bit builds
      rust: module: add static pointer to `{init,cleanup}_module()`
      x86/rust: support MITIGATION_RETPOLINE
      x86/rust: support MITIGATION_RETHUNK
      x86/rust: support MITIGATION_SLS
      objtool/rust: list `noreturn` Rust functions
      objtool/kbuild/rust: enable objtool for Rust
      rust: enable bindgen's `--enable-function-attribute-detection` flag
      docs: rust: quick-start: add Debian Testing
      docs: rust: link to https://rust.docs.kernel.org
      docs: rust: improve main page introducing a "Code documentation" section
      rust: enable rustdoc's `--generate-link-to-definition`
      MAINTAINERS: add Trevor Gross as Rust reviewer
      rust: avoid `box_uninit_write` feature
      kbuild: rust: add `CONFIG_RUSTC_VERSION`
      kbuild: rust: re-run Kconfig if the version text changes
      kbuild: rust: rebuild if the version text changes
      kbuild: rust: replace proc macros dependency on `core.o` with the version text
      docs: rust: include other expressions in conditional compilation section

Neal Gompa (1):
      init/Kconfig: Only block on RANDSTRUCT for RUST

Wedson Almeida Filho (3):
      rust: rbtree: add red-black tree implementation backed by the C version
      rust: rbtree: add iterator
      rust: rbtree: add mutable iterator

 Documentation/rust/general-information.rst |   27 +-
 Documentation/rust/index.rst               |   18 +-
 Documentation/rust/quick-start.rst         |    4 +-
 MAINTAINERS                                |    1 +
 Makefile                                   |   19 +-
 arch/Kconfig                               |   16 +
 arch/arm64/Kconfig                         |   14 +-
 arch/arm64/Makefile                        |    3 +
 arch/riscv/Kconfig                         |    9 +-
 arch/x86/Makefile                          |   11 +-
 init/Kconfig                               |   19 +-
 mm/kasan/Makefile                          |    8 +-
 mm/kasan/kasan.h                           |    6 +
 mm/kasan/{kasan_test.c => kasan_test_c.c}  |   11 +
 mm/kasan/kasan_test_rust.rs                |   21 +
 rust/Makefile                              |   56 +-
 rust/bindings/bindings_helper.h            |    2 +-
 rust/exports.c                             |    1 +
 rust/helpers.c                             |  239 ------
 rust/helpers/blk.c                         |   14 +
 rust/helpers/bug.c                         |    8 +
 rust/helpers/build_assert.c                |   25 +
 rust/helpers/build_bug.c                   |    9 +
 rust/helpers/err.c                         |   19 +
 rust/helpers/helpers.c                     |   26 +
 rust/helpers/kunit.c                       |    9 +
 rust/helpers/mutex.c                       |    9 +
 rust/helpers/page.c                        |   19 +
 rust/helpers/rbtree.c                      |    9 +
 rust/helpers/refcount.c                    |   19 +
 rust/helpers/signal.c                      |    9 +
 rust/helpers/slab.c                        |    9 +
 rust/helpers/spinlock.c                    |   24 +
 rust/helpers/task.c                        |   19 +
 rust/helpers/uaccess.c                     |   15 +
 rust/helpers/wait.c                        |    9 +
 rust/helpers/workqueue.c                   |   15 +
 rust/kernel/alloc/box_ext.rs               |   33 +-
 rust/kernel/error.rs                       |    5 +-
 rust/kernel/init.rs                        |  191 ++++-
 rust/kernel/init/__internal.rs             |   29 +
 rust/kernel/lib.rs                         |    2 +
 rust/kernel/list.rs                        |  686 +++++++++++++++
 rust/kernel/list/arc.rs                    |  521 ++++++++++++
 rust/kernel/list/arc_field.rs              |   96 +++
 rust/kernel/list/impl_list_item_mod.rs     |  274 ++++++
 rust/kernel/prelude.rs                     |    2 +-
 rust/kernel/print.rs                       |   20 +-
 rust/kernel/rbtree.rs                      | 1278 ++++++++++++++++++++++++++++
 rust/kernel/std_vendor.rs                  |    2 +-
 rust/kernel/sync/arc.rs                    |   25 +-
 rust/kernel/types.rs                       |   63 +-
 rust/macros/lib.rs                         |    4 +
 rust/macros/module.rs                      |   12 +
 scripts/Kconfig.include                    |    8 +
 scripts/Makefile.build                     |    9 +-
 scripts/Makefile.compiler                  |   15 +
 scripts/Makefile.kasan                     |   84 +-
 scripts/Makefile.lib                       |    3 +
 scripts/generate_rust_target.rs            |   98 ++-
 scripts/rustc-version.sh                   |   26 +
 tools/objtool/check.c                      |   52 +-
 tools/objtool/noreturns.h                  |    2 +
 63 files changed, 3884 insertions(+), 407 deletions(-)
 rename mm/kasan/{kasan_test.c => kasan_test_c.c} (99%)
 create mode 100644 mm/kasan/kasan_test_rust.rs
 delete mode 100644 rust/helpers.c
 create mode 100644 rust/helpers/blk.c
 create mode 100644 rust/helpers/bug.c
 create mode 100644 rust/helpers/build_assert.c
 create mode 100644 rust/helpers/build_bug.c
 create mode 100644 rust/helpers/err.c
 create mode 100644 rust/helpers/helpers.c
 create mode 100644 rust/helpers/kunit.c
 create mode 100644 rust/helpers/mutex.c
 create mode 100644 rust/helpers/page.c
 create mode 100644 rust/helpers/rbtree.c
 create mode 100644 rust/helpers/refcount.c
 create mode 100644 rust/helpers/signal.c
 create mode 100644 rust/helpers/slab.c
 create mode 100644 rust/helpers/spinlock.c
 create mode 100644 rust/helpers/task.c
 create mode 100644 rust/helpers/uaccess.c
 create mode 100644 rust/helpers/wait.c
 create mode 100644 rust/helpers/workqueue.c
 create mode 100644 rust/kernel/list.rs
 create mode 100644 rust/kernel/list/arc.rs
 create mode 100644 rust/kernel/list/arc_field.rs
 create mode 100644 rust/kernel/list/impl_list_item_mod.rs
 create mode 100644 rust/kernel/rbtree.rs
 create mode 100755 scripts/rustc-version.sh

