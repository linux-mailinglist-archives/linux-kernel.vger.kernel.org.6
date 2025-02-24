Return-Path: <linux-kernel+bounces-529161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6AA42082
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F5316FB65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726D254856;
	Mon, 24 Feb 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbEAof/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4F19D8BE;
	Mon, 24 Feb 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403404; cv=none; b=bj7RsplyDKtLwsPow3Qr4smY4IqmqTJvOl+vy8WahxIqERYHf+7fKgZ1a+OxENyiC8XsOpgK9fQ6am8Y2jceRJDeo0WmRvzwPOrh6gvWNDJ79otcZlJssESleE0ZTgfvscgccMmsgexYTvaC4xK4AypOPbSv3Wldi1l/bvUoCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403404; c=relaxed/simple;
	bh=ptshdJ9W8RoWqYF6hzDh8LiiYC3BXhTXePhli/+4wFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L8fxD1BRzKlzV2Ul0KPZ1CY8AS4c+f4lHBSG+u42cYnvGYdU3YuFZWugOvALMvLZe3w1zsf8sBcHhIyd2q4jPir+DpGwRzDG6sVRIEIaG0HH0clUo8WOIYAJrwcOIBbUA4yKytvdGflgtc9YNc8Z+y/1a10MRGHBf+xtnjTgI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbEAof/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D6C4CEE6;
	Mon, 24 Feb 2025 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403403;
	bh=ptshdJ9W8RoWqYF6hzDh8LiiYC3BXhTXePhli/+4wFg=;
	h=From:Subject:Date:To:Cc:From;
	b=NbEAof/NqkKJq/GASHeJIg1jZ/TQJQrfoEsDKsxSqY6nZu0fIacz05H0YZ0HsuZua
	 8vnG9HabAC9FxsDhEthc6q+PHFVoHVmknQskbCnyBPTtGCkTBrsHeRpjanEnlyg0WL
	 qpUGNG1v2f4/PHaysiWROIDOhtX/MFdGQh3T5/aABqi8M5BZ+scY1O2VG58OIugPTX
	 g3XTkNX2cAFCFB5JzRlahQUdgrKNJTm5EnV9bF0fcvLMgAJlGU2zvT7ybxiZeR3h5d
	 b339IrPr0sk5X2Kjo6jMfR9koOvuTd4glhCgAfrjASvk9HAqeypa/5pHR1Vobtcvr1
	 VTRDk1fdljNBQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v4 0/4] rust: configfs abstractions
Date: Mon, 24 Feb 2025 14:21:50 +0100
Message-Id: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG5yvGcC/2WOQW7DIBBFr2KxLhEDBCZe9R5VFxgGG7WxE3CtV
 pHvXuIs6irLP5r3/r+xQjlRYW1zY5mWVNI01qBfGuYHN/bEU6iZSSGPAhRwP40x9bHwDhF9QBl
 QO1bfL5li+t5Ub++PnOn6VY3z48gubvZD9bWNUB66GDXGIDWhCqBQ0QkjGoNKCDLmSJ2ju7dzh
 Wrr+ZzmtlnMATTPHti9YkhlnvLPNn6BreN55wJccLQnbQ2AFuBfPyiP9HmYcr9ZFvlHSmF3pKx
 ktM6ITuqgkJ5ItSMBd6SqpCAtvLAWAe0/cl3XX0v8XR14AQAA
X-Change-ID: 20250131-configfs-b888cd82d84a
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3841; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ptshdJ9W8RoWqYF6hzDh8LiiYC3BXhTXePhli/+4wFg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvHJyXeYnA1KfgWgRveZJUmW4uOmvS+/OKQNIM
 DcyFYS98L6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xycgAKCRDhuBo+eShj
 dz6GD/4myzPJQiz9Tcn8hqX2HTgDWhxJf1lylb835qafgRYSrUkZATMCw5mHUqKmTD+NPRAt7EO
 JFvzYJJ1QLT2Ng1zlsFykPZo2IiLU5HQREaJWAaW3EsmLSwwZZaekhRoUO4FqGPGoMXZhDJiMjr
 WqrXY+Z5QZAD79TWD1RhcvycXVwN/bi709uIjru6CgT3C4YDZNKHYEFzQ3ALAt4BBdWu1U6UAl9
 X6WYc5xkuX8q4IuIYS5icQFEV/0PfBA/fgzNAzf87wNUW8eU0ITw/6AUsASk0EwSDomlgQN1bl4
 hwhwWPr/sn6rKIID73ZzTckOb8nJvNTkc/gNUKibZd4aKO59QKe6FRNTGrM+HTOam8bqKOkFTld
 MvITgG+f4nnI8PIL5dFQLH96/l8pUcPJ3gnZyPxqjtODxzoUsQFH2P6a+zrKdjnhoEnXoRCdmmt
 61gH4chwyqfiBrBs2qVX5GmlZuVYqsAElgwrrBEJ1tgvdFXNLtbt8VT7KEcuw5itTYRzfrE4adE
 8/wE6X1i3S35OyVulb1nhFlsZH5y+BPUg5JtzaoK0T5cie9AyySdwIL42D4pXwgcHcbiU16unnd
 l4Ng7MSDGkn83UxX6ClpYrcMj2CSZP/BzerhyStsCNQAK5/bYnGSUPFzOVajDpBJCSs+7HKlrCo
 Oml60HVP43k3trQ==
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

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
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
prerequisite-patch-id: 03c1bff48fd24e83d1383e98f8668300e665ebae

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



