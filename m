Return-Path: <linux-kernel+bounces-516324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E698DA36FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9E13AF08D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62521EA7D1;
	Sat, 15 Feb 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psG1m8xq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1D1C6FE4;
	Sat, 15 Feb 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739639337; cv=none; b=o+8XlaEAF0/RYjvacoHP6BrBxYETO/a9q2eaIEP7VStRwGK3Mrf63zjniYKfhWC5sMi0ipK+v6DFVK34YN6izkz7k+OIjStApwfsEF8swZ1vkNSyDfAeOIAFHF8JSFKHsLfBoZZaq99MqjQuKhBGZnhST3LIlZC6rt9A0R4Gk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739639337; c=relaxed/simple;
	bh=Gff5Fb/UEHmhG3qEsrFxch0VTJF4L3wBvBHqc1Qlj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHpy+1J1C5cIEPEpKpuM768GCqEfn+OrKJCyztX8YgTuCLpArEI0sKZmmWv4X7pn/HdhvUbAJ+Ath1wMshWrhNoQO829nKvYbkJDWxleA2jhwDsZRK3CLVqFrjiltQJbpog3PL5pVvoVFpXGGxwre3BXtaO7rQwFMQvRvI9lA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psG1m8xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A7EC4CEE6;
	Sat, 15 Feb 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739639336;
	bh=Gff5Fb/UEHmhG3qEsrFxch0VTJF4L3wBvBHqc1Qlj0M=;
	h=From:To:Cc:Subject:Date:From;
	b=psG1m8xquWHXiS4JqkvZE7SKTenQSi0pbhl+OdWfDkgrs9rpeBMrmnd8buVuWFW0O
	 wKVMOJRkTKeQHSb1NNbV4HoSz+jECcZme+vA+wopDdJx0w+dEBHFLeC59agsUg9csa
	 arXpWIaJsTVQGweY1aPSvZEGuNPs2Jk26q/of18Ej/+ldFT1EBt5KHXzPD950qNNRc
	 aqcW8RFmG3MMTLSFFnzIBIc5waKK2DqQAx5Y27aBS5cvBtcFKovr4ydcWBlp5k+owU
	 DBHK44zKuMGsJWBfdJUNliG42hWV2lYJtDvxYbgNB585ccr3rVy/xZGv4Hyw5RHXrf
	 xbw8++R1hSA1A==
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
Subject: [GIT PULL] Rust fixes for 6.14 (2nd)
Date: Sat, 15 Feb 2025 18:08:45 +0100
Message-ID: <20250215170845.80764-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust (second round).

They have been in linux-next for a few days.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.14-2

for you to fetch changes up to 2e4f982cf392af2f1282b5537a72144e064799e3:

  rust: rbtree: fix overindented list item (2025-02-12 23:26:55 +0100)

----------------------------------------------------------------
Rust fixes for v6.14 (2nd)

Toolchain and infrastructure:

 - Fix objtool warning due to future Rust 1.85.0 (to be released in
   a few days).

 - Clean future Rust 1.86.0 (to be released 2025-04-03) Clippy warning.

----------------------------------------------------------------
Miguel Ojeda (2):
      objtool/rust: add one more `noreturn` Rust function
      rust: rbtree: fix overindented list item

 rust/kernel/rbtree.rs | 2 +-
 tools/objtool/check.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

