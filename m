Return-Path: <linux-kernel+bounces-519438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B725A39CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8E2176AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278026A0C9;
	Tue, 18 Feb 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPEjECNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116A2417CF;
	Tue, 18 Feb 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883752; cv=none; b=lTHTa70S9pd3O8UnCHxjiIUguEhP6MjPIz+3xpAaFiYRakwr/fuvLGeLwW/PV+cw/NFrEfogxDOV33DsxTY2wXP+r0OnL7y2epLBfWoNxFttFNZH1nnf5mDRj7NcdhEM6v48E132WAmz2XdCXMatKpkv+NbZ3QXAVHTOV8f5xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883752; c=relaxed/simple;
	bh=D0VtLbSmaYFpjlfRBVq6AysntobeoKWy+aKbu1SseDI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=krUJk4yNr6atCjstNKjbb99cklx2Jlnits+GScyAH9kn7W4IlKrWMePaPe3Shiftolnkx/q/m79ZIjbN5CMEDsw2RYkUgs6LrKp91Wxr/qNkqaVjmb9s3t91H29zf+uXcLQgPh4a4E6OahOfmSoLUD0GxhYm5LtiPkRkIOZ3x9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPEjECNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E309C4CEE9;
	Tue, 18 Feb 2025 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883752;
	bh=D0VtLbSmaYFpjlfRBVq6AysntobeoKWy+aKbu1SseDI=;
	h=From:Subject:Date:To:Cc:From;
	b=GPEjECNB+MGP558zSF3d46ATFtDQ7vUlFOZ97OumY8zzPObaV8ro0enC+Ff74u4fl
	 kyPtPLtBtbvVjdCYZZ6AiNDwWxKvJn+k0y0WooF/Av09ZnYOZ2107GUALFakzEFk66
	 LLGKaOK49pexhdWFWJ2aUmVFvjiKaSagAgeGcpJyqi761oXIrP59abbUSgKLOdWhLe
	 EdnILg6jq2qPmUM9QaDmgNRW67p6y8WavIIJfF7ZQrypIx4986z8mT7xylqLZApWMj
	 3tmyOB5k88p5Dc8hODm62FxjjIof0AVubwZGQ3XM/Ib2/TpvpBygtXXs7cqRMQl18F
	 C41oNfQc0Q+pg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v3 0/4] rust: configfs abstractions
Date: Tue, 18 Feb 2025 13:57:15 +0100
Message-Id: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKuDtGcC/2WOQW7DIBBFr2KxLhEM2Iy96j2qLjAMNmpjJ+CiV
 pHvXuIs2qrLP5r3/r+xTClSZkNzY4lKzHFdalBPDXOzXSbi0dfMQEArpJLcrUuIU8h8RETnETx
 qy+r7JVGIn4fq5fWRE10/qnF7HNnFbm6uvqEB01IgJIGoelJWeAIkDx2hJxQj9djWRn33jjZTb
 T2f4zY0pTtJzZOT7F4xx7yt6esYX+TR8X9nkVxwNL02nZRaSPf8Rmmh99OapsNS4IcEYX6RUMl
 gbCdG0F4h/SH3ff8GZhFRHT4BAAA=
X-Change-ID: 20250131-configfs-b888cd82d84a
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4561; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=D0VtLbSmaYFpjlfRBVq6AysntobeoKWy+aKbu1SseDI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIO6FSvw+j1YHK7QapmOFlrBia8zcZ3Q/5S9x
 /+OmDh0QueJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SDugAKCRDhuBo+eShj
 d7TID/0fV/h7AtAIdlnZHn7I2Whho8a5xhUycXvBxonP3IZ3BCNPtuRmGDLksGpePOl3vRmNIVs
 v3BlX1L8wezPkhDkyFRye0htVI7m6XZp1ZnblnrBxQqHe6qn7bAbyfb/DoA6ptl/ilCc9UIDKwL
 ua/s8kY+aAgCeBDkktlpQux53ElnkWmq1eThUTkDx6eartFYTlrJqXpPl4vy9RhrquLClzN0DnG
 KGq8Zsmoyy6L/Y4jLsDb3YcKxx/fOCzxXgpOnls0WI1Gq1mvuEilqBe3fnz2/gC+fwno52+epoU
 5yUwMxJIOf2AATYXZQ/HJmooDz0ZGY3YLIEWYBc7850Y33Qc3spnlZqX1XaLYdq2N5AVn9Oohpf
 I4fgNZ83oKqLvV1Th4q1nn7ISqMt0PJKaOi2dMM7e2gRjb0UwMQRAlzuqHzHVKlB/930+2x9fjD
 k2faOlswcgeX3eHAC/8LoKm3cc6vB3TjRP+7okj/6srbP0RbtYLW3QOJXRe5N36y988JTQEGvoK
 G5NCQWLbnicIrL7XvKLkpjZBbXfb9itkN66tVv23J3kySMhuw3FwmQhDan3drnGbalgytP2zspu
 eJPTfrgbR9MYQGkakmqJAQxiOH0NFel5UWf4/6X1TdWVLNxaEuFm1UIhrHuZzs8qnELUSd0QhgO
 0b6l41SEH4F2GnQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series adds a safe Rust API that allows Rust modules to interface
the `configfs` machinery.

The series contains an example for the samples folder to demonstrate
usage of the API. As such, there is no inline example in the
documentation.

The last patch adds a maintainer entry for the Rust configfs
abstractions, to make it absolutely clear that I will commit to maintain
these abstractions, if required. Feel free to drop this patch if this is
not required.

The series is a dependency of `rnull`, the Rust null block driver.
Please see [1] for initial `configfs` support in `rnull`.

[1] https://github.com/metaspace/linux/tree/9ac53130f5fb05b9b3074fa261b445b8fde547dd/drivers/block/rnull

---
Joel, Christoph: please let me know how you would like to proceed with
maintenance and whether you would like to pick these patches through the
configfs tree or not.

To: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Alex Gaynor <alex.gaynor@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <benno.lossin@proton.me>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Joel Becker <jlbec@evilplan.org>
To: Christoph Hellwig <hch@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Will Deacon <will@kernel.org>
To: Waiman Long <longman@redhat.com>
To: Fiona Behrens <me@kloenk.dev>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
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

 MAINTAINERS                     |   7 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/mutex.c            |   5 +
 rust/kernel/configfs.rs         | 938 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/sync/arc.rs         |  21 +-
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_configfs.rs   | 179 ++++++++
 9 files changed, 1160 insertions(+), 5 deletions(-)
---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20250131-configfs-b888cd82d84a
prerequisite-patch-id: 275efe8e08839e3a0de28ed26e8de80be9852024

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



