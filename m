Return-Path: <linux-kernel+bounces-349770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85398FB62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7AB1F23493
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D328E8;
	Fri,  4 Oct 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7Jv1tZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337C1849;
	Fri,  4 Oct 2024 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000286; cv=none; b=FZSzr8YInlNVXiX0TAYt4xEtX7Bjsj1Iz+BjV+2iKitd4s8xc7xc8luaK85oe3mjsD42jIJ6XUOLCojQCs4cGDRkOgVEP+wL6Mni6V9BTUMbtkLqJEjYfTojtPd0tIcrUU1dyrEvwOp9f2NjVwu6545n6suo0P01chz7k2VwvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000286; c=relaxed/simple;
	bh=lhoaVc7qSnymcgP1B8/4MMCarOpcklf6p668zfKRuzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgkYbSn8RL42fOvOwfUs+3M4Z+fPh1/i3MlJcX/TBJxboHrLr0n9eiXK5DpoEyKoMa2WHzVZJiXSFI3L/tpBB+Q/Oe14dtW+YjhJuaS+aEHee6i1W5I/VoQE46M50auMUoDxH/SxM6qUQEju2w0eJw/IZdB+DEUvJ1eA1Keh+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7Jv1tZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38165C4CEC5;
	Fri,  4 Oct 2024 00:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000286;
	bh=lhoaVc7qSnymcgP1B8/4MMCarOpcklf6p668zfKRuzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=c7Jv1tZdZM/fnHdpzoFFCVRifsAK0UoqstaXwCyipWYiQ9uadjQY/WcOBB6o5fuMF
	 8J7mD9s0jAXUe2kbK2VPV998nGZHwQxaQ+ncy3C+63icgHCU1owiAeUGFcekADCiug
	 bWlOYyMRUbJk0lLlr/eFpwbYpN5uTmppZV4NoAh3sJhKLrbL+5cum9VQVJ5Z4Gjrod
	 woUKLGoos7Efhtt7ZMGUooDDFIKNeK3QK0C+KzVAfp3BQc4L1jvBER7t8a1jkgW/G/
	 BBnTHEN1rxsghfRnDg4UoQNhQYZ5WBRnvv9tcu8fqyCfPz5a2i03f8yRt8mAsKK3sI
	 57SCuYYwPpAIw==
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.12
Date: Fri,  4 Oct 2024 02:03:49 +0200
Message-ID: <20241004000349.675431-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust.

They have all been in linux-next for at least a couple rounds, and most
for a week.

You will probably notice a non-tag base -- I used the Rust merge because
there was a trivial issue in the merge resolution so I added the fix on
top of that one without waiting for v6.12-rc1. Please let me know if you
prefer something else (e.g. I considered sending you that patch directly
to you).

No conflicts expected.

You also already merged a fix for a Rust driver (qt2025) via netdev.

Thanks!

Cheers,
Miguel

The following changes since commit 570172569238c66a482ec3eb5d766cc9cf255f69:

  Merge tag 'rust-6.12' of https://github.com/Rust-for-Linux/linux (2024-09-25 10:25:40 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12

for you to fetch changes up to 05cef2c4a421ca09ab9761a95e61423e59e5bfb1:

  rust: kunit: use C-string literals to clean warning (2024-10-01 23:46:42 +0200)

----------------------------------------------------------------
Rust fixes for v6.12

Toolchain and infrastructure:

 - Fix/improve a couple 'depends on' on the newly added CFI/KASAN
   suppport to avoid build errors/warnings.

 - Fix ARCH_SLAB_MINALIGN multiple definition error for RISC-V under
   !CONFIG_MMU.

 - Clean upcoming (Rust 1.83.0) Clippy warnings.

'kernel' crate:

 - 'sync' module: fix soundness issue by requiring 'T: Sync' for
   'LockedBy::access'; and fix helpers build error under PREEMPT_RT.

 - Fix trivial sorting issue ('rustfmtcheck') on the v6.12 Rust merge.

----------------------------------------------------------------
Alice Ryhl (3):
      rust: sync: require `T: Sync` for `LockedBy::access`
      rust: KASAN+RETHUNK requires rustc 1.83.0
      cfi: encode cfi normalized integers + kasan/gcov bug in Kconfig

Dirk Behme (1):
      rust: mutex: fix __mutex_init() usage in case of PREEMPT_RT

Gary Guo (1):
      rust: fix `ARCH_SLAB_MINALIGN` multiple definition error

Miguel Ojeda (3):
      rust: kernel: sort Rust modules
      rust: cfi: fix `patchable-function-entry` starting version
      rust: kunit: use C-string literals to clean warning

 arch/Kconfig                  | 18 +++++++++++++++++-
 init/Kconfig                  |  5 +++--
 rust/bindgen_parameters       |  5 +++++
 rust/helpers/mutex.c          |  6 ++++++
 rust/kernel/kunit.rs          |  4 ++--
 rust/kernel/lib.rs            |  2 +-
 rust/kernel/sync/locked_by.rs | 18 ++++++++++++++----
 7 files changed, 48 insertions(+), 10 deletions(-)

