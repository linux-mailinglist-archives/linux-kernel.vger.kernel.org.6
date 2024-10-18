Return-Path: <linux-kernel+bounces-372524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578939A49C7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAB1F24D47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DC19068E;
	Fri, 18 Oct 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev2nPpuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA37485;
	Fri, 18 Oct 2024 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729292046; cv=none; b=WhcheYc3URgDB9P2ex0y50wbAkY4CRAOhhnmTPOxFTFThpgPgnIFuc+jYCHpZE2Go0Aw9U68RSN34jYsl3h217qbj62XUIAWEKb1AoyV6/MaAlZuIU9+vtwr0+wmEFldVY9DRUHPXfaKcZaHkaFxY1G8CArkUFnqcCyp7oLkABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729292046; c=relaxed/simple;
	bh=WWg0Abc/FBNbUuiw6Nf9RCj1QjsTIpCrigZZ6kZY3no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXD1h6RVgjGqAcnbqKMIiUZDtsvijdWL12Jsms69M+vD49t9xdUdm9wAD7GL+pn7lyvoD4RtxU9TM7aEv1aWcqJ5bF6wi7gHIyRjZX9JHGDPqyQ38h9F1gPiHIGDVRpP9URMdafRB6cPvOOd7SJdPajKR89Iw0zDQLgwU73EFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev2nPpuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27207C4CEC3;
	Fri, 18 Oct 2024 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729292046;
	bh=WWg0Abc/FBNbUuiw6Nf9RCj1QjsTIpCrigZZ6kZY3no=;
	h=From:To:Cc:Subject:Date:From;
	b=ev2nPpuBh6/l0ej0BsUe+OH92SfCAdnS8vsa7rNoPM41dhxZs2/FuszNYw1BkDJQO
	 Ow/S6/FF+iuSE1s5u1rs21sExJPf042EnSqlBAwQHDHD79mRTOs5Mi3OPqq0PAm81T
	 wuY+PR6Di5y1koa12xouYm2KAfWDlB9tp14q/XBt9j5k705dDjs5y8zYMCbWupCYPG
	 /QWCtkTn4VEQYv33MLfsMOgQvm4KgH7MYW2wjOLtmCTssDJ4+fB+pBFe2KFv+hw6i7
	 bet65eDmLSruwW5msBsE6a0Xwaxie5ade6xrDfmniLYttLsc8vRg1RSpJB4fWD2F43
	 ZKyTT6lkgf67Q==
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
Subject: [GIT PULL] Rust fixes for 6.12 (2nd)
Date: Sat, 19 Oct 2024 00:53:29 +0200
Message-ID: <20241018225329.235175-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust (second round).

They have all been in linux-next for a week.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12-2

for you to fetch changes up to 8b8ca9c25fe69c2162e3235c7d6c341127abeed6:

  cfi: fix conditions for HAVE_CFI_ICALL_NORMALIZE_INTEGERS (2024-10-13 22:23:13 +0200)

----------------------------------------------------------------
Rust fixes for v6.12 (2nd)

Toolchain and infrastructure:

 - Fix several issues with the 'rustc-option' macro. It includes a
   refactor from Masahiro of three '{cc,rust}-*' macros, which is not
   a fix but avoids repeating the same commands (which would be several
   lines in the case of 'rustc-option').

 - Fix conditions for 'CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS'. It
   includes the addition of 'CONFIG_RUSTC_LLVM_VERSION', which is not a
   fix but is needed for the actual fix.

And a trivial grammar fix.

----------------------------------------------------------------
Alice Ryhl (2):
      kbuild: fix issues with rustc-option
      cfi: fix conditions for HAVE_CFI_ICALL_NORMALIZE_INTEGERS

Gary Guo (1):
      kbuild: rust: add `CONFIG_RUSTC_LLVM_VERSION`

Masahiro Yamada (1):
      kbuild: refactor cc-option-yn, cc-disable-warning, rust-option-yn macros

Timo Grautstueck (1):
      lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW

 arch/Kconfig                  | 26 ++++++++++++--------------
 init/Kconfig                  |  8 ++++++--
 lib/Kconfig.debug             |  2 +-
 scripts/Kconfig.include       |  3 +++
 scripts/Makefile.compiler     | 14 +++++++-------
 scripts/rustc-llvm-version.sh | 22 ++++++++++++++++++++++
 6 files changed, 51 insertions(+), 24 deletions(-)
 create mode 100755 scripts/rustc-llvm-version.sh

