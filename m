Return-Path: <linux-kernel+bounces-562765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84BA63296
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB03172CE8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B71A2545;
	Sat, 15 Mar 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNk1et1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F819CC06;
	Sat, 15 Mar 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742073766; cv=none; b=KHInpcZYDZNpRkbVgasFLhu2GM7eCDppeg7aBd/ehNitDB0NDkniVMwc82GRINnVd3uvjJGjOFbEtY6GCf6ahWeVVtapIVEISzHKair6YHjXlIwoBY72k9zqZdVudAxmdiW+g+owKsCumXEoYXIE+s19W3jP1Ldyn2+Orsa6jMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742073766; c=relaxed/simple;
	bh=mxAXTV07GI1BxRK/PFQ2TxeRjmjuhs+0fhO3LzDL5C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvAT0H4cwtvH5PRnpLNv+OnUusKCco3JSRwk6o3q2u6l87qrijbTSxgekKGyOAUvNFwHsZSmKA2KsWSd/p/8UKPOZ7l2+J9FA4jm3pw734YFmn3Yl5j43Tum8X5XkkKovwk0eyCNRYabxIN3+XYvEkXoy0q2ZUjRzJ4oO7QVOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNk1et1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E9EC4CEE5;
	Sat, 15 Mar 2025 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742073765;
	bh=mxAXTV07GI1BxRK/PFQ2TxeRjmjuhs+0fhO3LzDL5C8=;
	h=From:To:Cc:Subject:Date:From;
	b=lNk1et1ny/JjqGvrXTCgEH22Ux2mMbwccn4MNEAMAO4c4JEwk2xdpR7xyXWhpaZoV
	 bpHqz3kiFKE5puA/7IF40kOV9jD9AXEyTBt38sO7lxGXDSLPAEXJ1SglhSmgnjNtGm
	 SM3dVQuKqdnHDDS8UZzJOjY5lyAJNHF5Od8aWNv1e8kf0AVxNafDO0lV8/GZ/L2iw7
	 uTp8zXhvOEtKmOd2DIAhdd3UGEOby3/1J35ap6Z4j4lVpMLsuFPwczIJlHf+9Jd5b1
	 92pJaLCVQtTQUTw9XUbkTuLW8LvuQ95zMVQMxCFuGul58d5LOyrZ8VUSLknPDn+F+/
	 12v0qCXzKgGqw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.14 (3rd)
Date: Sat, 15 Mar 2025 22:22:32 +0100
Message-ID: <20250315212232.2360641-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust (third round).

All commits have been in linux-next for at least two rounds.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.14-3

for you to fetch changes up to a1eb95d6b5f4cf5cc7b081e85e374d1dd98a213b:

  scripts: generate_rust_analyzer: add uapi crate (2025-03-12 00:13:07 +0100)

----------------------------------------------------------------
Rust fixes for v6.14 (3rd)

Toolchain and infrastructure:

 - Disallow BTF generation with Rust + LTO.

 - Improve rust-analyzer support.

'kernel' crate:

 - 'init' module: remove 'Zeroable' implementation for a couple types
   that should not have it.

 - 'alloc' module: fix macOS failure in host test by satisfying POSIX
   alignment requirement.

 - Add missing '\n's to 'pr_*!()' calls.

And a couple other minor cleanups.

----------------------------------------------------------------
Alban Kurti (5):
      rust: docs: add missing newline to printing macro examples
      rust: error: add missing newline to pr_warn! calls
      rust: init: add missing newline to pr_info! calls
      rust: sync: add missing newline in locked_by log example
      rust: workqueue: add missing newline to pr_info! examples

Benno Lossin (1):
      rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`

Matthew Maurer (1):
      rust: Disallow BTF generation with Rust + LTO

Miguel Ojeda (1):
      rust: remove leftover mentions of the `alloc` crate

Panagiotis Foliadis (1):
      rust: task: fix `SAFETY` comment in `Task::wake_up`

Tamir Duberstein (4):
      rust: alloc: satisfy POSIX alignment requirement
      scripts: generate_rust_analyzer: add missing macros deps
      scripts: generate_rust_analyzer: add missing include_dirs
      scripts: generate_rust_analyzer: add uapi crate

 Documentation/rust/quick-start.rst  |  2 +-
 Documentation/rust/testing.rst      |  2 +-
 init/Kconfig                        |  2 +-
 rust/kernel/alloc/allocator_test.rs | 18 ++++++++++
 rust/kernel/error.rs                |  2 +-
 rust/kernel/init.rs                 | 23 ++++++------
 rust/kernel/init/macros.rs          |  6 ++--
 rust/kernel/lib.rs                  |  2 +-
 rust/kernel/sync/locked_by.rs       |  2 +-
 rust/kernel/task.rs                 |  2 +-
 rust/kernel/workqueue.rs            |  6 ++--
 scripts/generate_rust_analyzer.py   | 71 ++++++++++++++++++++++---------------
 scripts/rustdoc_test_gen.rs         |  4 +--
 13 files changed, 85 insertions(+), 57 deletions(-)

