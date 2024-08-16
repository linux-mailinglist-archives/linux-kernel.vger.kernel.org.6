Return-Path: <linux-kernel+bounces-290133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7C954FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95E61F2599B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4E1C0DE8;
	Fri, 16 Aug 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1oehXc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB42BB0D;
	Fri, 16 Aug 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828598; cv=none; b=b854dXrbh86To50I//YvXYd1voQDm8x0g6h8tfOMNtDNYblLrGUhKe+TszipoqG2S8FDRTgF+ENP8arIff4k0OMoAa0B6UySuewdN27JMWZ/C2qaXFPJIpZRLaTlFPsbTWnL0Ki5GqfGhG8fpmw7YBbuUs19D9wRAdNV7t34z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828598; c=relaxed/simple;
	bh=sPYv0g/AfzPWZIknl7bScophvQHJynMsFyJ6W+w2qAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O80T8HKdUBPQPk19jHLvdtfM8lYiWAZ1ZLED5t+s486e643B6qgRkvnLy0V+EhNLrL003CaL53HTvElXBnY5I2+4y/rKkxo3/LCx4p/uc4L6WWHSEGHSmOKLnY3Otnb/b6Ccj7ECJdZNuBjU++bJfVBeD+EJgZeOz7vdxmygNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1oehXc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91D8C32782;
	Fri, 16 Aug 2024 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828597;
	bh=sPYv0g/AfzPWZIknl7bScophvQHJynMsFyJ6W+w2qAk=;
	h=From:To:Cc:Subject:Date:From;
	b=h1oehXc0icqnbRuhYTxwoipafHAMcIFWAt+/LTGkWtx+ahATF/4cGnt9zalvD4/tY
	 R1nw+CoFVY3J3mTreehIsXZeoHui6Pli6oLwvNsBLOILELl3MyC3En1AmTpJJe8ey2
	 WQyYvaD+pYQWmAELTJfZRFSgCPCRoca04cW+whsFNM0n8N+ET8M1dd/ueJtzulEPbc
	 FNDufldoFxk5VLuoXsRy/kREw5Dd959xrfpxaoprpsxnOTU/vDkpbCnp0r6FDrVE3O
	 tMQanumzcsjhdnXNcwWYbi39+f184REI66iJCuf8Mlzwg41ugqEbQfEhMAFpj2bFYH
	 4xsZdNJ6KNYgg==
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
Subject: [GIT PULL] Rust fixes for 6.11
Date: Fri, 16 Aug 2024 19:16:22 +0200
Message-ID: <20240816171622.41357-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust.

They have been in linux-next for a week or more.

No conflicts expected. No changes to the C side.

Thanks!

Cheers,
Miguel

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.11

for you to fetch changes up to 0eba65f0310d3c7d5516c7fd4c172d0bfa8b285b:

  rust: x86: remove `-3dnow{,a}` from target features (2024-08-10 00:05:10 +0200)

----------------------------------------------------------------
Rust fixes for v6.11

 - Fix '-Os' Rust 1.80.0+ builds adding more intrinsics (also tweaked
   in upstream Rust for the upcoming 1.82.0).

 - Fix support for the latest version of rust-analyzer due to a change
   on rust-analyzer config file semantics (considered a fix since most
   developers use the latest version of the tool, which is the only one
   actually supported by upstream). I am discussing stability of the
   config file with upstream -- they may be able to start versioning it.

 - Fix GCC 14 builds due to '-fmin-function-alignment' not skipped for
   libclang (bindgen).

 - A couple Kconfig fixes around '{RUSTC,BINDGEN}_VERSION_TEXT' to
   suppress error messages in a foreign architecture chroot and to use a
   proper default format.

 - Clean 'rust-analyzer' target warning due to missing recursive make
   invocation mark.

 - Clean Clippy warning due to missing indentation in docs.

 - Clean LLVM 19 build warning due to removed 3dnow feature upstream.

----------------------------------------------------------------
Masahiro Yamada (2):
      rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
      rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT

Miguel Ojeda (4):
      rust: macros: indent list item in `module!`'s docs
      rust: add intrinsics to fix `-Os` builds
      kbuild: rust-analyzer: mark `rust_is_available.sh` invocation as recursive
      rust: x86: remove `-3dnow{,a}` from target features

Sarthak Singh (1):
      rust: Support latest version of `rust-analyzer`

Zehui Xu (1):
      kbuild: rust: skip -fmin-function-alignment in bindgen flags

 Makefile                          | 2 +-
 init/Kconfig                      | 4 ++--
 rust/Makefile                     | 8 ++++----
 rust/compiler_builtins.rs         | 3 +++
 rust/macros/lib.rs                | 2 +-
 scripts/generate_rust_analyzer.py | 6 +++++-
 scripts/generate_rust_target.rs   | 4 ++--
 7 files changed, 18 insertions(+), 11 deletions(-)

