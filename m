Return-Path: <linux-kernel+bounces-445882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F029D9F1D10
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BB1886F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44713212B;
	Sat, 14 Dec 2024 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdQZO7aw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFB3A268;
	Sat, 14 Dec 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734159152; cv=none; b=hdF/CF1N3y95GsX+xgvfgCYRjiZg4wKWYq8OnO7O3BJRN20gNXnBJ5yCdd8moYW2WotVZxZ4ytDll+G5D7OzS8v913DAwebEuOdQTzat9FiYN7QV1TQaXmSDla7DEKir8AAaLC3KMY79MCKPEp5MsjGFD+u2tgff6XcoGhKfM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734159152; c=relaxed/simple;
	bh=ec2V6TnLzPmUFH2BYVk8Zz7aOR5068XysL2akhFaXns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxoiveiyZ+UVGvljHiiqrQ7Se3UwmtYty0txYwHma7vyKqJ9cOvUCgsKcRVi9TCCb01Ujpu/FGqUr+xziCkN8AdxFu8nyTQfGH6ay5qciwQlJv4a+YRuOLe8Yp7PDaMEwuvsx9lMwqFI1Is99OiFzQY1SX9+JYNLsrG9LAH5TFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdQZO7aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E866C4CED1;
	Sat, 14 Dec 2024 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734159152;
	bh=ec2V6TnLzPmUFH2BYVk8Zz7aOR5068XysL2akhFaXns=;
	h=From:To:Cc:Subject:Date:From;
	b=UdQZO7awDdHq3fGlnIfRX6x+roZuXEiK6cqmJMr20DeJt5OUaYqCfLXyvg8ADSZda
	 AVVuTABWQt6w+lT71j+FvvPHqhuUBT6kl/QVIdrqt/RPvjDXUtZtacyH27chdMy5qk
	 XTE0bYYljE6sHHJtkcJPGFyCq168SWaO5tUvRGyviRXToQSfGRse2UlWeDx9CjaFMA
	 IsfB4a/rTRVjC+dFCSjuZxFpridv0rSWWOYRqSUHCcTiZ0C7QlCJInP0bbI0nIq11t
	 eCCqMHvrsdKtyC6YEKxa+spowOz3Gf1YYMlq/rNXBQ7nfTFmbfTmL81eAZ8+iXZ+Pf
	 FHparH/8rERWg==
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
Subject: [GIT PULL] Rust fixes for 6.13
Date: Sat, 14 Dec 2024 07:52:17 +0100
Message-ID: <20241214065217.195385-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these two fixes for Rust.

They have both been in linux-next for three rounds this week.

No conflicts expected.

I picked a DRM fix, but they will eventually pick them on their side.

Thanks!

Cheers,
Miguel

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.13

for you to fetch changes up to 7a5f93ea5862da91488975acaa0c7abd508f192b:

  rust: kbuild: set `bindgen`'s Rust target version (2024-12-10 01:06:10 +0100)

----------------------------------------------------------------
Rust fixes for v6.13

Toolchain and infrastructure:

 - Set bindgen's Rust target version to prevent issues when pairing
   older rustc releases with newer bindgen releases, such as
   bindgen >= 0.71.0 and rustc < 1.82 due to unsafe_extern_blocks.

drm/panic:

 - Remove spurious empty line detected by a new Clippy warning.

----------------------------------------------------------------
Miguel Ojeda (2):
      drm/panic: remove spurious empty line to clean warning
      rust: kbuild: set `bindgen`'s Rust target version

 drivers/gpu/drm/drm_panic_qr.rs |  1 -
 rust/Makefile                   | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

