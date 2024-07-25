Return-Path: <linux-kernel+bounces-261638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B593BA34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F18283410
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD987482;
	Thu, 25 Jul 2024 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGdaW9B/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C063A9;
	Thu, 25 Jul 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871195; cv=none; b=j4wLANvzBjSaU4r3KYVzSyyo90e9tcFGo0pth9xQK6RyqLquA3pNdim5X3N9yuN0fYzKxPoRrhAnWo4iU/Rwav5x+UFbPnxCvgfS8VUIwzABz8KygD4Fh9E5pqe9mvUvWEdyhpUlF87PQjhA+3+eV5EDo2Dir9RfQXmSWT/acuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871195; c=relaxed/simple;
	bh=1nim2j8M0Yrs0+ovLhARcsZmGWpL0I38dTS9kWUc5qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAjmTVkNbMp5fju1ck9zmRPR+Tm+2vIvsLK7jwO4x7epHFtxk8IMPsgIVDIcDj9pK2hcejPS7C2oXr/J/QPqun7YO4JaxV/0CKxKbYNA5fo3dESxvfAa3HwCmbnH7OG114egcovrOSFaQL31w5vxme1mlZk6HX47rov0oZLx0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGdaW9B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC2CC32781;
	Thu, 25 Jul 2024 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721871195;
	bh=1nim2j8M0Yrs0+ovLhARcsZmGWpL0I38dTS9kWUc5qY=;
	h=From:To:Cc:Subject:Date:From;
	b=MGdaW9B/JyElUwCITobjSzYQCrtnkGd0vcwO75HD57Cvg3pzBb1lwZCqwWS6mqFQL
	 Ab6awp3AJ+C8KCzIey5NRQOPjCJFyrnrviwwhgin0l/CyYW8SQAvFzTB9EAxB+us56
	 7lT1gcsEjzINxVilbzmpgtI2hr0SCTnEVrpszELMkRVOCeO4V4CaFBrCa+ZMrh06eG
	 V9cDf7rkiCipy1Pw7RijZVSvCa77loEzWk4LjJVECgB00TGNE62EIAJ7Nl5XEemxvS
	 dwfG8adtOA0GtQV3/qOarAsXziVkg6g7zy7f6AbK+qpWcKV2whLRf0ugw0EvPMUomH
	 hIcsau0v3sIrw==
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
	linux-kernel@vger.kernel.org,
	Niko Matsakis <niko@alum.mit.edu>,
	Sid Askary <saskary@futurewei.com>,
	=?UTF-8?q?Emilio=20Cobos=20=C3=81lvarez?= <emilio@crisal.io>
Subject: [GIT PULL] Rust for 6.11
Date: Thu, 25 Jul 2024 03:32:44 +0200
Message-ID: <20240725013244.69532-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

Later than usual, but all the commits have been in linux-next for about
2 weeks.

A trivial conflict with the block pull you already merged expected
(resolved in linux -next). In addition, there is a small change to the
C side from Arnd that akpm ack'ed.

Please pull for v6.11 -- thanks!

Cheers,
Miguel

The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.11

for you to fetch changes up to b1263411112305acf2af728728591465becb45b0:

  docs: rust: quick-start: add section on Linux distributions (2024-07-10 10:29:55 +0200)

----------------------------------------------------------------
Rust changes for v6.11

The highlight is the establishment of a minimum version for the Rust
toolchain, including 'rustc' (and bundled tools) and 'bindgen'.

The initial minimum will be the pinned version we currently have, i.e.
we are just widening the allowed versions. That covers 3 stable Rust
releases: 1.78.0, 1.79.0, 1.80.0 (getting released tomorrow), plus beta,
plus nightly.

This should already be enough for kernel developers in distributions
that provide recent Rust compiler versions routinely, such as Arch
Linux, Debian Unstable (outside the freeze period), Fedora Linux,
Gentoo Linux (especially the testing channel), Nix (unstable) and
openSUSE Slowroll and Tumbleweed.

In addition, the kernel is now being built-tested by Rust's pre-merge
CI. That is, every change that is attempting to land into the Rust
compiler is tested against the kernel, and it is merged only if it
passes. Similarly, the bindgen tool has agreed to build the kernel in
their CI too.

Thus, with the pre-merge CI in place, both projects hope to avoid
unintentional changes to Rust that break the kernel. This means that,
in general, apart from intentional changes on their side (that we
will need to workaround conditionally on our side), the upcoming Rust
compiler versions should generally work.

In addition, the Rust project has proposed getting the kernel into
stable Rust (at least solving the main blockers) as one of its three
flagship goals for 2024H2 [1].

I would like to thank Niko, Sid, Emilio et al. for their help promoting
the collaboration between Rust and the kernel.

[1] https://rust-lang.github.io/rust-project-goals/2024h2/index.html#flagship-goals

Toolchain and infrastructure:

 - Support several Rust toolchain versions.

 - Support several bindgen versions.

 - Remove 'cargo' requirement and simplify 'rusttest', thanks to 'alloc'
   having been dropped last cycle.

 - Provide proper error reporting for the 'rust-analyzer' target.

'kernel' crate:

 - Add 'uaccess' module with a safe userspace pointers abstraction.

 - Add 'page' module with a 'struct page' abstraction.

 - Support more complex generics in workqueue's 'impl_has_work!' macro.

'macros' crate:

 - Add 'firmware' field support to the 'module!' macro.

 - Improve 'module!' macro documentation.

Documentation:

 - Provide instructions on what packages should be installed to build
   the kernel in some popular Linux distributions.

 - Introduce the new kernel.org LLVM+Rust toolchains.

 - Explain '#[no_std]'.

And a few other small bits.

----------------------------------------------------------------
Alice Ryhl (4):
      rust: alloc: fix typo in docs for GFP_NOWAIT
      rust: alloc: add __GFP_HIGHMEM flag
      rust: uaccess: add typed accessors for userspace pointers
      rust: add abstraction for `struct page`

Arnd Bergmann (1):
      uaccess: always export _copy_[from|to]_user with CONFIG_RUST

Aswin Unnikrishnan (2):
      rust: add example for `alias` argument in `module` macro documentation
      rust: fix datatype in docs for `module` macro arguments

Dirk Behme (1):
      docs: rust: no_std is used

FUJITA Tomonori (1):
      rust: add 'firmware' field support to module! macro

John Hubbard (2):
      kbuild: rust-analyzer: better error handling
      kbuild: rust-analyzer: improve comment documentation

Miguel Ojeda (12):
      kbuild: rust: remove now-unneeded `rusttest` custom sysroot handling
      rust: macros: indent list item in `paste!`'s docs
      rust: init: simplify from `map_err` to `inspect_err`
      rust: allow `dead_code` for never constructed bindings
      rust: relax most deny-level lints to warnings
      rust: simplify Clippy warning flags set
      rust: start supporting several compiler versions
      rust: avoid assuming a particular `bindgen` build
      rust: work around `bindgen` 0.69.0 issue
      rust: start supporting several `bindgen` versions
      rust: warn about `bindgen` versions 0.66.0 and 0.66.1
      docs: rust: quick-start: add section on Linux distributions

Nathan Chancellor (1):
      docs: rust: introduce the new kernel.org LLVM+Rust toolchains

Roland Xu (1):
      rust: kernel: make impl_has_work compatible with more generics

Wedson Almeida Filho (1):
      rust: uaccess: add userspace pointers

 Documentation/process/changes.rst          |   9 +-
 Documentation/rust/general-information.rst |   8 +
 Documentation/rust/quick-start.rst         | 143 +++++++----
 Documentation/rust/testing.rst             |   5 +-
 Makefile                                   |  30 +--
 include/linux/uaccess.h                    |  46 ++--
 init/Kconfig                               |   5 +-
 lib/usercopy.c                             |  30 +--
 rust/Makefile                              |  74 +-----
 rust/bindings/bindings_helper.h            |   2 +
 rust/bindings/lib.rs                       |   1 +
 rust/helpers.c                             |  34 +++
 rust/kernel/alloc.rs                       |  17 +-
 rust/kernel/init.rs                        |  13 +-
 rust/kernel/lib.rs                         |   2 +
 rust/kernel/page.rs                        | 250 +++++++++++++++++++
 rust/kernel/types.rs                       |  64 +++++
 rust/kernel/uaccess.rs                     | 388 +++++++++++++++++++++++++++++
 rust/kernel/workqueue.rs                   |  16 +-
 rust/macros/lib.rs                         |  45 +++-
 rust/macros/module.rs                      |  18 +-
 rust/uapi/lib.rs                           |   1 +
 scripts/rust_is_available.sh               |  33 +--
 scripts/rust_is_available_bindgen_0_66.h   |   2 +
 scripts/rust_is_available_test.py          |  59 +++--
 25 files changed, 1059 insertions(+), 236 deletions(-)
 create mode 100644 rust/kernel/page.rs
 create mode 100644 rust/kernel/uaccess.rs
 create mode 100644 scripts/rust_is_available_bindgen_0_66.h

