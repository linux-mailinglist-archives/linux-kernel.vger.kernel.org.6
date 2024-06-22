Return-Path: <linux-kernel+bounces-225860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072291362E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F91C21918
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507176EEA;
	Sat, 22 Jun 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OivEMamj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AF5EE80;
	Sat, 22 Jun 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093367; cv=none; b=VbB4nDJ/ky1IiqT2Px1VobuARzXyN74HSDaQW6nBrjE9HkGBNAafJS+QIluoWlh1YStY8wvcjJjh7aJIApv2ND0Tr2te0fxOrmkYVdAbQjZFokrMAsP/3+sag+GO8levN1lZOPDODBTnSojL1A6iKmxdvUHMPB0Z7OnlU/zqAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093367; c=relaxed/simple;
	bh=sf98jSdXelohYzpNFAkZ2dct/moamDBOc/lFtl2cWJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6QU0eZ6LVEpWs+fjQZRmh5plULZ+YOoXr1EncJirymyNFtXqBzFAugozybcIaoW7+h8GftIrIjrbLXdbTn+Bq0w7xNNg3wY1DaM0z0zZV7oPC89g/l1DwF9WiAkNQpAqHaqIOrt2hh3CayGcZTt2OHVQIpahwAhq18DXsK5/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OivEMamj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCB1C3277B;
	Sat, 22 Jun 2024 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719093366;
	bh=sf98jSdXelohYzpNFAkZ2dct/moamDBOc/lFtl2cWJo=;
	h=From:To:Cc:Subject:Date:From;
	b=OivEMamjoZx3r3dCQaicsY+uUmMZxfLQ1Rz89s3I6skgavz/PNjMn71DXa1DAmaqM
	 h2TR9WqAp3zY0Jj26vdaD6bMAin0jTd7QZxQr3rYrgTE+WzBupHtv0IGtQ14gXfxNB
	 3Wd4S2KwWBMeZ/Du71CX4of1qez7Jd26JvfTjBJBzvH4D8PpQADZxYMFXRdsv6gGPY
	 /jJyMjKOOKIQhpK/bft0CxvIckiIs5uHu4MoRHStTqHt45T2g9KkeIyFyk9MQeHrM7
	 KO/td4q9jTrKl4TDvmTHg4jpMUJJUfdWyHe2H5+UQOdacXizss7XwbDSdvjifE08qy
	 tDZEUWG/WpOnQ==
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
Subject: [GIT PULL] Rust fixes for 6.10
Date: Sat, 22 Jun 2024 23:55:18 +0200
Message-ID: <20240622215518.198080-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull this fix for Rust.

It has been in linux-next for more than a week.

No conflicts expected. No changes to the C side.

Thanks!

Cheers,
Miguel

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.10

for you to fetch changes up to a126eca844353360ebafa9088d22865cb8e022e3:

  rust: avoid unused import warning in `rusttest` (2024-06-11 23:33:28 +0200)

----------------------------------------------------------------
Rust fixes for v6.10

 - Avoid unused import warning in 'rusttest'.

----------------------------------------------------------------
Miguel Ojeda (1):
      rust: avoid unused import warning in `rusttest`

 rust/kernel/alloc/vec_ext.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

