Return-Path: <linux-kernel+bounces-317893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7F96E525
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB161F23ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B011B12DA;
	Thu,  5 Sep 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZEs4gy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCC1AF4CC;
	Thu,  5 Sep 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572090; cv=none; b=u668QYYw9/9enr8ljuC8hE/3DmcSXQzaegII/DIKOxBhxs2MQtqlFrPEKqfjFvEvi33fhVr3ihGr1zp0muzx8115muNUXcuZ9HmX+iIcOZbB511k2RjlnZTYRJmHIX0K2mU6Xte4+gZOqyN3aytNiIeXL4R6giPYUt9ZrPw5FUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572090; c=relaxed/simple;
	bh=JHR1ZLB8RoCJiIFs10W+O4pcCxTZ8Kn+9ppYo7Nqk+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAkSgLdkdZImMdITVQZlWlcsGCTS2lsFly/ubYWNp0bCofO9oAsHP2STYiDd5FKjujRkqI5D2YJ3fFJK0S+jv22ZtLyz6hus0z0wFZjv6FYi95cu4TI941G8YxJfjBWRTJZQTQZwNLASKAVrMYsiGQALSH6wpQCY6SnaZTgGlms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZEs4gy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCF5C4CEC3;
	Thu,  5 Sep 2024 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725572090;
	bh=JHR1ZLB8RoCJiIFs10W+O4pcCxTZ8Kn+9ppYo7Nqk+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WZEs4gy8plJ+j403b8gYbKuBoci8PqWEscTH2rHTXFSVzV4rDsQVOvLzl11VRAim/
	 pHCEhaU4JGLH029B7oaFDnc45BgVEqZgd4BLr+rXP1kuSo1fe37hz7v7XON2M+9tgX
	 xoa7W3jHpNIkbX6otZvkxYBSsjiEzjICocK+3S59TeZbXXNukfrRAsAEIdzUFKjwJW
	 G6ehAg++HXLfes0TSx/BBCCk0fZm6EfMCvjKeeT0woAPG1EaMHGp/FpScJVnGSNICj
	 cuXWaI6m+960u+/VzMdmHsEjis5ArZ2QJMrWBRXzDkhzxQftVAmwhza0BdkP7GBjSR
	 Ni521KASB9oTg==
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
Subject: [GIT PULL] Rust fixes for 6.11 (2nd)
Date: Thu,  5 Sep 2024 23:34:25 +0200
Message-ID: <20240905213425.253828-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust (second round).

They have all been in linux-next for at least a couple rounds.

No conflicts expected. No changes to the C side.

Thanks!

Cheers,
Miguel

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.11-2

for you to fetch changes up to cff56ff737e2da095ca9f228e2c5afc903bfca69:

  MAINTAINERS: update Andreas Hindborg's email address (2024-09-03 23:48:20 +0200)

----------------------------------------------------------------
Rust fixes for v6.11 (2nd)

Toolchain and infrastructure:

 - Fix builds for nightly compiler users now that 'new_uninit' was split
   into new features by using an alternative approach for the code that
   used what is now called the 'box_uninit_write' feature.

 - Allow the 'stable_features' lint to preempt upcoming warnings about
   them, since soon there will be unstable features that will become
   stable in nightly compilers.

 - Export bss symbols too.

'kernel' crate:

 - 'block' module: fix wrong usage of lockdep API.

'macros' crate:

 - Provide correct provenance when constructing 'THIS_MODULE'.

Documentation:

 - Remove unintended indentation (blockquotes) in generated output.

 - Fix a couple typos.

MAINTAINERS:

 - Remove Wedson as Rust maintainer.

 - Update Andreas' email.

----------------------------------------------------------------
Andreas Hindborg (3):
      rust: kbuild: fix export of bss symbols
      rust: block: fix wrong usage of lockdep API
      MAINTAINERS: update Andreas Hindborg's email address

Boqun Feng (1):
      rust: macros: provide correct provenance when constructing THIS_MODULE

Jon Mulder (1):
      docs: rust: remove unintended blockquote in Quick Start

Jubilee Young (1):
      rust: alloc: eschew `Box<MaybeUninit<T>>::write`

Michael Vetter (1):
      rust: kernel: fix typos in code comments

Miguel Ojeda (1):
      rust: allow `stable_features` lint

Vincent Woltmann (1):
      docs: rust: remove unintended blockquote in Coding Guidelines

Wedson Almeida Filho (1):
      MAINTAINERS: Remove Wedson as Rust maintainer

 .mailmap                                 |  1 +
 Documentation/rust/coding-guidelines.rst | 38 ++++++++++++++++----------------
 Documentation/rust/quick-start.rst       |  6 ++---
 MAINTAINERS                              |  5 ++---
 Makefile                                 |  1 +
 rust/Makefile                            |  2 +-
 rust/kernel/alloc/box_ext.rs             |  6 +++--
 rust/kernel/block/mq/gen_disk.rs         |  6 ++---
 rust/kernel/init/macros.rs               |  4 ++--
 rust/kernel/net/phy.rs                   |  2 +-
 rust/macros/module.rs                    |  6 ++++-
 11 files changed, 41 insertions(+), 36 deletions(-)

