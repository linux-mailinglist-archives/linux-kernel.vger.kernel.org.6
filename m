Return-Path: <linux-kernel+bounces-536295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42449A47DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AFE16C787
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81822F163;
	Thu, 27 Feb 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpuJH55j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A222D4F9;
	Thu, 27 Feb 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659793; cv=none; b=hngGM6D74zWKbH5BVUcXwIX1g9rBOxJnGP6Y43+J6530GPHZjpa06KVekRFORlwOUbmxgEbYkz8bTn4qN+xx+takwgEVBz6WRnQlpa+FPxmfNmZ4rd3OKDvt+VLmYDWjBBpG7dwuUkPD6/yC/vfk7byfaJnUwpdJCc73qJcCe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659793; c=relaxed/simple;
	bh=wzTHXJ//HL7pmE1Lj3YbpsgFTshC2pUcvkKt3jPODSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CAsPQ82i7E5NXBFkFVGEWxAYOlRi9zRva8X/JmvDCyeoAIXLq9wYA5y9A61ZFbfR4e83v/N2bMdKDs1iqium0hzq2r6IGrvbXv/HIU7pKjwLKIIc59RGp0tLvzisw5S1r4dBjkTOa8njIEfOt8Tj+qET3g2qht0djUPGMRgXrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpuJH55j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB06C4CEDD;
	Thu, 27 Feb 2025 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740659793;
	bh=wzTHXJ//HL7pmE1Lj3YbpsgFTshC2pUcvkKt3jPODSI=;
	h=From:Subject:Date:To:Cc:From;
	b=kpuJH55jVv3h5LOryr4Hs3TBPAVGq8H77r5KzX87OuBQSogVI8I+NbQvArJY5mj7U
	 WYXZbUyI0Q7PhNPo+PD1QRQl6dvOcdUPgRM/AQAZMImdOuDA92tM3QCD09AWp2+aGi
	 G1x5OQ9cPAYcPWd0ON/2Sjj0GrRgwduGcrh59aVFmUsS7SNYY49GBuWmp2KdWLQ0nF
	 vdfbImhZYQD6/OE8SV7HMe8P1FllnUC/TRn4QHJboukxr4YqRY6WSRX3kA6qRC24V/
	 UTDi2GyEMFpxQ7tkRyenyDVE+Zb3ioyGgf/rqzPzG0vMEjDU4dBlF5EJ3GZqmzv19c
	 qz59N2GIgsTTg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v5 0/4] rust: configfs abstractions
Date: Thu, 27 Feb 2025 13:35:09 +0100
Message-Id: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1bwGcC/2XOTW6DMBAF4Ksgr0vksY09sOo9qi78MyZWG0gMR
 a0i7l6HLErF8ln+3rw7mygnmlhX3VmmJU1pHEpoXirmz3boqU6hZCa4aDhIqP04xNTHqXaI6AO
 KgMqy8v2aKabvrert/Zkz3b5K4/x8ZFc7+3Pp6youPbgYFcYgFKEMIFFSixG1Rsk5ad2Qs/Tod
 XaicvVySXNXLfoEqs4e2OPEOU3zmH+28QtsN447F6h5jaZVRgMoDv71g/JAn6cx91vLIv6k4GY
 nRZHRWM2dUEEiHaTcScCdlEVyUtxzYxDQHKTaSaF2UhXZ2ti6hsreqP/JdV1/AQSu+LqyAQAA
X-Change-ID: 20250131-configfs-b888cd82d84a
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4610; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=wzTHXJ//HL7pmE1Lj3YbpsgFTshC2pUcvkKt3jPODSI=;
 b=kA0DAAgB4bgaPnkoY3cByyZiAGfAXAGh1/jH1Snm6W2b3FACy33uwmIS1JBI+Ia3V6VkxucAH
 okCMwQAAQgAHRYhBBLB+UdWv3wqFdbAEuG4Gj55KGN3BQJnwFwBAAoJEOG4Gj55KGN3bnEP/Rgv
 TOfLYbyRTi0wMtqUGVEt9oK038r4khG5JfKTz7BN55c/CPImoR4H4nLOdEgXBfdBvU14A0Kayyi
 IxOxjhnNjccZkPhas1DWu9DLT0vOfiUnT3jSoaJ7WtrlH4i91yjOOvtjGph3NFN2gE88rdDtEVV
 9qUuI5Kg42cBzIBqiNX/f7eKIoXzE76jdlw1JtcKkNjTPd72tp9k2FYapeRun7YJpttf6LQolNM
 XLljkosqcjewyMMkF+cuA8atLm065iC1KuoNK/qLzOGF0b0y8jLR1x2SnoGsGEG7khgDKcUyUB+
 DTsOwTAgi7uhv/Wq+/D+0Z6FSIbtebkdDBDkJTcUpSGr8CN2qx1snHwuPiK8RYst/v4arNXX7c/
 QhC2TcqAEb96fdzqCLYtPio9bbUHikuziNdaQWONDiKOn/del5e37uxFzqSOQqrBQY2BdcP6PIv
 0+mzIfpgVYBkfOEc7R85DTqdM8YVJ5Iw3R0pPLRRMKd2bKcVDqIihDMIVuR3ZG2NaDUMZjkWntq
 hqml2cCzHiWJSaFwlbHYK1eAtin0XqyvTXSmx4na86qkfvB5Hl1PQePCs276EFuMtVYq99aI49H
 2J6Wr1tLvdaeRLZPcTHX1NPL9FzDG3GAN06fSAI4La/mAbxzKnWx1vcMLyKbhBwAGvCvTBAsE+X
 Y1apR
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a safe Rust API that allows Rust modules to interface the `configfs`
machinery.

Add an example for the samples folder to demonstrate usage of the API.

Add a maintainer entry for the Rust configfs abstractions in the last patch, to
make it absolutely clear that I will commit to maintain these abstractions, if
required.

The series is a dependency of `rnull`, the Rust null block driver.
Please see [1] for initial `configfs` support in `rnull`.

[1] https://github.com/metaspace/linux/tree/9ac53130f5fb05b9b3074fa261b445b8fde547dd/drivers/block/rnull

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v5:
- Remove `as _` casts.
- Document `ID` type parameter of `AttributeOperations`.
- Add documentation at macro call sites in example.
- Add example expansion of `configfs_attrs!`.
- Move trait bound in `AttributeList::add`
- Improve safety requirement for `AttributeList::new`.
- Fix a copy/paste error in print in sample.
- Clarify use of `{}` for empty struct in sample.
- Improve documentation for `AttributeList`.
- Remove `kernel::` prefix from `container_of!` invocation.
- Reword safety comment in `get_group_data`.
- Correct commit message in relation to unstable feature additions.
- Use imperative language in commit messages.
- Consistently capitalize the word "Rust" in commit messages.
- Explain that "drop" in `GroupOperations::drop_item` is not related to Rust
  drop.
- Link to v4: https://lore.kernel.org/r/20250224-configfs-v4-0-9af9b5e611f6@kernel.org

Changes in v4:
- Fix a build issue by depending on v18 of "rust: types: add `ForeignOwnable::PointedTo`"
- Link to v3: https://lore.kernel.org/r/20250218-configfs-v3-0-0e40c0778187@kernel.org

Changes in v3:
- Allow trailing commas in invocation of `configfs_attrs!`.
- Use a more suitable C initialization function when initializing `Subsystem`.
- Split sample into separate patch.
- Add an inline example.

The remaining changes in this version are style fixes, documentation
improvements and typo fixes. They are enumerated below:
- Consolidate `paste` macro calls.
- Do not hard code page size in example.
- Remove prefix of `c_str!` in sample.
- Use a more descriptive variable name in `into_foreign`.
- Improve code formatting in macros invocations.
- Add comment related to null terminator in `configfs_attrs!`
- Move attributes below docstrings.
- Remove a rogue todo.
- Remove trait bound from struct definition `GroupOperationsVTable`.
- Remove `as _` casts.
- Remove `GroupOprations::Parent` associated type.
- General documentation improvements.
- Explicitly use `ArcBorrow` for `drop_item` parameter type.
- Add a comment describing expansion to a call to `Attribute::add`.
- Add a comment explaining bound check in `Attribute::add`.
- Link to v2: https://lore.kernel.org/r/20250207-configfs-v2-0-f7a60b24d38e@kernel.org

Changes in v2:
- Remove generalization over pointer type and enforce use of `Arc`.
- Use type system to enforce connection between `ItemType` and
  `Subsystem` or `Group`. Differentiate construction of vtables on this
  type difference.
- Move drop logic of child nodes from parent to child.
- Pick `ForeignOwnable::PointedTo` patch as dependency instead of
  including it here.
- Fix some rustdoc warnings.
- Use CamelCase for generic type parameter declaration.
- Destroy mutex in `Subsystem::drop`.
- Move `GroupOperationsVTable` struct definition next to implementation.
- Rebase on v6.14-rc1.
- Link to v1: https://lore.kernel.org/r/20250131-configfs-v1-0-87947611401c@kernel.org

---
Andreas Hindborg (4):
      rust: sync: change `<Arc<T> as ForeignOwnable>::PointedTo` to `T`
      rust: configfs: introduce rust support for configfs
      rust: configfs: add a sample demonstrating configfs usage
      MAINTAINERS: add entry for configfs Rust abstractions

 MAINTAINERS                     |    7 +
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/mutex.c            |    5 +
 rust/kernel/configfs.rs         | 1054 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    2 +
 rust/kernel/sync/arc.rs         |   21 +-
 samples/rust/Kconfig            |   11 +
 samples/rust/Makefile           |    1 +
 samples/rust/rust_configfs.rs   |  192 +++++++
 9 files changed, 1289 insertions(+), 5 deletions(-)
---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20250131-configfs-b888cd82d84a
prerequisite-patch-id: 03c1bff48fd24e83d1383e98f8668300e665ebae

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



