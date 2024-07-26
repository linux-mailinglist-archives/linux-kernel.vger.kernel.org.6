Return-Path: <linux-kernel+bounces-263689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7476993D95C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007561F240B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239E2D05D;
	Fri, 26 Jul 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KilrkHnF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C873502B1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023872; cv=none; b=Mnzylgj3GTFY/Je85oVKv9GS+fWzfkVbhuJ4jCUg4WV5Aco4FJOONIQOmJzuU5tWZBhQCDLDqWwo1UzordkectjUNV4Gj0ggK1T4kYrEbKfZBoJVfn8x8Jjgb4DXbebK7B6wZs6QAnnq7tqAnV9l/A6MqABFn6BggWiJMx/9S54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023872; c=relaxed/simple;
	bh=E77E5mIDGm4qZh6PUHc4KUGKQRSehUq8Cs/FFyDQ1Oo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e+wQEyuxSHidKFF1PpPSlBfcpDXT3pzDKtKI/3T7J51b/fktcdP8rToPlRpunvDcTLvOCdm48iQsTuSXYHPcX5BgEhJVjDGO2TC5qPOgEcNJ8PPEdTFoZ1YbAl8zwW3BNvNTE30QQYQm4TQ3+YJdBC78KW2NWsTW0jn9LIzU3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KilrkHnF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05d72f044cso91241276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722023870; x=1722628670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXPPzh2U9G8T92DAUFjg+1YE0kXQrDKqkwKIOH4C0JU=;
        b=KilrkHnFvuOE4IXvCU85aAZqA27YXM12gEdSt8cAaHqfaAlfaSLQ4v0lWg5pt204Fl
         Af+1xIVJacHLTHezQB16JbCa1D8jPtj7UOQpsjFWb0sKwAo7BRV8YC+ZAkj3yAAFIMCV
         OV0gDo92yOa4mH+8HtaLonXoco8/r1FZKvYQfwHg82u5P4M6kNMLyoWEHYiZEaO4B+tm
         mx4UeyuYhqN8UBBS2RE/urKDTml4PsMOXbu/kvezgWaGmCA2RW2mnO/DJ3I/oQXOhJHr
         2NF+mgJDzJ/V1i2EvoZxjvSDUWSdG8YoGosNIWLBWY0gLXIL1DLlD2LfZ5HJJv2BQ1cV
         iciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023870; x=1722628670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXPPzh2U9G8T92DAUFjg+1YE0kXQrDKqkwKIOH4C0JU=;
        b=XR2Okasku/SX+N6/yltRtXUOII2C/QbDQfNwQ2T2YMSP38QHv2rYbQ+y/Vkmj1Sy/m
         Ljz6zf3M6/TYN8adiymydj3RAsJdmxN9il+KPHQcgb0kpoj6oZn1sokENwRB2po4Vo68
         Gr/IPyK6DpJr3S+nKdVe13pPH1Hhkn7TaPRGdUZUNrSIi2RHj3W97wWCQthM66XGkitH
         JzI8YSJHycwmTz+h6sTKuzo/ydj0L1uK9nM+gNJO2Lre41aPADP374A/7aRQ09RMJ8IS
         o3BzCXgVgpOEI5zLbQg52eTZjtryle3/+Ayv/JC1Rki6xdhQyX0C6JSFpuS6gwaud2oM
         bvTg==
X-Forwarded-Encrypted: i=1; AJvYcCXat9xMsxfyWi8KQv3i/ivKJWhx3wfonMebWsE4egDGJGD0jEqD4tYXAbL7S4+peDNyX88RuaL49Ww9v5PL1z0rpwM7f0gKzUQkT5Jg
X-Gm-Message-State: AOJu0YwIVl3Wt/sq12/2P7StWVOkQBvFvdTDw71I3IFKRYHPrfFKDDcL
	wdAR1AV13vFzx4wophtlbg8eK46WyB4uBiI7bpiwG/Sm3wbdkky2c9A4T+qniy07bWSie/tX56L
	lf38jqZe+oQTJ8vGvQ5UKxCYheQ==
X-Google-Smtp-Source: AGHT+IFPGPT/M8BEQbpd+ttAfK5/o/1pOjgp3eJsKQiL8LivITx72gX3hiImgLkRZQrhcm1s+Le5kIuoaxUkRMF2ed4=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:2b8f:b0:e03:5b06:6db2 with
 SMTP id 3f1490d57ef6-e0b543b7dbcmr1369276.3.1722023870069; Fri, 26 Jul 2024
 12:57:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:57:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALP/o2YC/23QwW7DIAwG4FepOI/JxoQkO+09ph2AmBRpKxWpo
 k1V3n3QS6iy42/5+yX7LhbOkRfxdrqLzGtcYrqU0L+chD/by8wyTiULBYpQQSedltndMrO0zqE
 FNAEsiLJ/zRziz6Pr47Pkc1xuKf8+qles09qi4bllRQlyHDsmZqbBw/uc0vzFrz59i1qzqobi2
 FJVKDhEstYRwXSgtFONQ0upUFLESJpG8HygeqcGqKW6UhhY02SsC/5Au5aalnb1VhO4/I3H/p9 bzU57xJaaQlE7DmgHPzn7RLdt+wPyj+QiygEAAA==
X-Mailer: b4 0.13.0
Message-ID: <20240726-b4-rbtree-v7-0-aee88caaf97c@google.com>
Subject: [PATCH v7 0/6] Red-black tree abstraction needed by Rust Binder
From: Matt Gilbride <mattgilbride@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains the red-black tree abstractions needed by the Rust
implementation of the Binder driver.

Binder driver benefits from O(log n) search/insertion/deletion of
key/value mappings in various places, including `process.rs` and
`range_alloc.rs`.  In `range_alloc.rs`, the ability to store and
search by a generic key type is also useful.

Please see the Rust Binder RFC for usage examples [1]. Note that
the `container_of` macro is currently used only by `rbtree` itself.

Users of "rust: rbtree: add red-black tree implementation backed by the C version"
    [PATCH RFC 03/20] rust_binder: add threading support
    [PATCH RFC 05/20] rust_binder: add nodes and context managers
    [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: rbtree: add iterator"
    [PATCH RFC 17/20] rust_binder: add oneway spam detection

Users of "rust: rbtree: add mutable iterator"
    [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: rbtree: add `RBTreeCursor`"
    [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: rbtree: add RBTree::entry"
    Not used in the original RFC, but introduced after further
    code review.  See: https://r.android.com/2849906

The Rust Binder RFC addresses the upstream deprecation of red-black
tree. Quoted here for convenience:

"This RFC uses the kernel's red-black tree for key/value mappings, but we
are aware that the red-black tree is deprecated. We did this to make the
performance comparison more fair, since C binder also uses rbtree for
this. We intend to replace these with XArrays instead. That said, we
don't think that XArray is a good fit for the range allocator, and we
propose to continue using the red-black tree for the range allocator."

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
Changes in v7:
- make `RawVacantEntry.rbtree` a raw pointer like
  `RawVacantEntry.child_field_of_parent`, since the latter can
  technically point at a field of the former. We prefer that the
  implementation be explicit about the safety guarantees of both because
  of the relationship between them.
- Link to v6: https://lore.kernel.org/r/20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com

Changes in v6:
- Minimize usage of `*mut bindings::rb_node`, replacing with
  `NonNull<bindings::rb_node>`. Specifically, changing
  `RBTreeCursor.current` to be `NonNull<bindings::rb_node>` and updating
  the corresponding functions.
- Update `RBTreeCursor:to_key_value` helpers to have their own lifetime
  (they are not instance methods, using a different lifetime than that
  of the `impl` block they are in makes things more clear.
- Fix misplaced semicolon in `cursor_lower_bound`.
- Link to v5: https://lore.kernel.org/r/20240606-b4-rbtree-v5-0-96fe1a0e97c0@google.com

Changes in v5:
- Used `Box::write` in `RBTreeNodeReservation::into_node`, removing
  unnecessary `unsafe` blocks.
- Updated `RBTreeCursor::remove_current` to return the removed node.
- Link to v4: https://lore.kernel.org/r/20240603-b4-rbtree-v4-0-308e43d6abfc@google.com

Changes in v4:
- rebased onto the tip of rust-for-linux/rust-next (97ab3e8eec0ce79d9e265e6c9e4c480492180409)
- addressed comments from draft PR on GitHub: https://github.com/Rust-for-Linux/linux/pull/1081
- Link to v3: https://lore.kernel.org/r/20240418-b4-rbtree-v3-0-323e134390ce@google.com

Changes in v3:
- Address various feedback re: SAFETY and INVARIANT comments from v2.
- Update variable naming and add detailed comments for the `RBTree::insert` (later moved to
  `RBTree::raw_entry`) implementation.
- Link to v2: https://lore.kernel.org/r/20240219-b4-rbtree-v2-0-0b113aab330d@google.com

Changes in v2:
- Update documentation link to the C header file
- Use `core::convert::Infallible` in try_reserve_node
- Link to v1: https://lore.kernel.org/r/20240205-b4-rbtree-v1-0-995e3eee38c0@google.com

---
Alice Ryhl (1):
      rust: rbtree: add `RBTree::entry`

Benno Lossin (1):
      rust: kernel: add `drop_contents` to `BoxExt`

Matt Gilbride (1):
      rust: rbtree: add `RBTreeCursor`

Wedson Almeida Filho (3):
      rust: rbtree: add red-black tree implementation backed by the C version
      rust: rbtree: add iterator
      rust: rbtree: add mutable iterator

 rust/helpers.c               |    7 +
 rust/kernel/alloc/box_ext.rs |   24 +-
 rust/kernel/lib.rs           |    1 +
 rust/kernel/rbtree.rs        | 1290 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1321 insertions(+), 1 deletion(-)
---
base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


