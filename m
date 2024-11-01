Return-Path: <linux-kernel+bounces-392897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD89B9962
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F051282525
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580011D9667;
	Fri,  1 Nov 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjtccf3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144B1D4340;
	Fri,  1 Nov 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492604; cv=none; b=ZKEldKdCBC4svcRD9riSXQJCqnKlaOuQKDgHfce4ez8c8TC/bfYXLFtSqSgd/TwgdU8mlRi8TBD76/hRZ8LkU26O/3VcQ3Se0bkYoFEnDLYWG3pw+M7tCNsYbBFokE7YZwJ9W1gDUHuZx67jn8osy4J31Q6iBHCG3uzxbgQDtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492604; c=relaxed/simple;
	bh=rjQsU760vVenrLSu/Vn1ggSBcTJllqE14feveYBKU+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ+LJYj0XYFvPrDolHbaGfnHocH9ICX+dxLROI4RQAYe9T/bEw9s1WWt27nBNJMDbrunEDtiXgF4wkTEWoeQvoxHFIo9eD9i5Q7VkEqoMr/cGVTKiBaqglHvPhcNdYi6f/HQZojpXd4Yh5HaQkD12sglIc4x1mdM0icf/nGqq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjtccf3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555DEC4CECD;
	Fri,  1 Nov 2024 20:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730492604;
	bh=rjQsU760vVenrLSu/Vn1ggSBcTJllqE14feveYBKU+A=;
	h=From:To:Cc:Subject:Date:From;
	b=Mjtccf3AsW8PP6rSRxTPP/AsNU7RMU/1RU5f1P94kAmWBYgNkSaBXz9bS4L1LZpAb
	 yLsPnnMBWFL1HmKUxE4lprSH18vhhsFLPkRwoH4ZCgTHupOyVdVzGY8xXbfW0+3lFo
	 SI+ZJpkUOU3ZHjWZDwt1AWLmNlhaTBfFn4t6zaxsra09MFltcCRZIzZ0doprQReVDV
	 ot+/SRyLSxtna6KgRBM7RMa2aM1R+LMzuFQqtTYW3KJv33YBbAWt00BZWFa9IyzhYS
	 fUhPCgGFlGeyMhdgQQphi/UWCrBcpk2X1+uTyCcDvpXOeAVDQuMSYVxCWhiKpidHmH
	 KUlgaoa+KJNuw==
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
Subject: [GIT PULL] Rust fixes for 6.12 (3nd)
Date: Fri,  1 Nov 2024 21:22:58 +0100
Message-ID: <20241101202258.233057-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust (third round).

The last commit has been in linux-next for a round.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12-3

for you to fetch changes up to 2313ab74c3004089ecac5f0f91f7274829f3825b:

  cfi: tweak llvm version for HAVE_CFI_ICALL_NORMALIZE_INTEGERS (2024-10-31 00:41:37 +0100)

----------------------------------------------------------------
Rust fixes for v6.12 (3nd)

Toolchain and infrastructure:

 - Avoid build errors with old 'rustc's without LLVM patch version
   (important since it impacts people that do not even enable Rust).

 - Update LLVM version for 'HAVE_CFI_ICALL_NORMALIZE_INTEGERS' in
   'depends on' condition (the fix was eventually backported rather than
   land in LLVM 19).

----------------------------------------------------------------
Alice Ryhl (1):
      cfi: tweak llvm version for HAVE_CFI_ICALL_NORMALIZE_INTEGERS

Miguel Ojeda (1):
      kbuild: rust: avoid errors with old `rustc`s without LLVM patch version

 arch/Kconfig                  | 4 ++--
 scripts/rustc-llvm-version.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

