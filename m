Return-Path: <linux-kernel+bounces-292345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3647956E39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A421F2359C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050B176228;
	Mon, 19 Aug 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHF9ANO7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C16175D21
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080047; cv=none; b=PIR5Fa9JgZREdDnCzko/ByStgmeGM7s+aW4qFKnqDqn2oaqRDSvr2jfc9EpK3zFvjcxaEpoqs7hDOms4QjzhXtl5VGxj36+pItSI68J4eaN7TFqnebjctxe5TWnmIAk98fe9lvL0grEWmTtzQibjTs9IWTjqil3qSWlIW+CGOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080047; c=relaxed/simple;
	bh=6kW8AYYCWP3ufR3YlSMeExz9YYVDuDgOKPqUzm3mH4o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uxg/MnJWBep/kPhclnLYc4myfQIp4eiKUNvN/At3b1d0lNnjM6o4CsP3n4Mvhm9w2sfniGblSrMDJlIKZv9GFkXiMHPvFjTn/WRlmhhIf8yIVuftXWB4oMrP4yFc/U+MtDjuV8D9ujeF/JEcJKLom3On+0R1K36/N27ycKre4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHF9ANO7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so1511685276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080044; x=1724684844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4+2AG0Iai4wf1y7eH8SZY8Ixcpu6vGbJhMMkPQ7XpHk=;
        b=hHF9ANO7nld4oOrFxQdRPDp86lj3/Fv+Rv/kBGaoAgwMfsQVWf5lVQO7vYvFa9VRHx
         inQ2oytQ+fQVNwv4fPuUtxkYrh6TiCoLFiUtZsch6wtRyXFU+BoU0KhTGiDk1cr3jbEf
         u0L1j0avsM7X0c2mQv51jkhFvuyZZpAPlVLsUKg0bp5EEbW1BYnvMAA1pd95SSZOGsE9
         pjizsmoyYgmk/hKUnt11tE59Y81ZfFz08WAkjc9+LBCPw4M6EFLvEEBlVn5FPhtu9efr
         Ptw/WiOScwCcrid5Fh4fviLcKDN5LOzty9u4XAUOGmurwM99MubNfzRX9fVxt32BBeg+
         JN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080044; x=1724684844;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+2AG0Iai4wf1y7eH8SZY8Ixcpu6vGbJhMMkPQ7XpHk=;
        b=QSnoic4an8Fe3IXyLuIzhyEphDTafJ8JhS0OpN8HwRVybM8Bio0P8hrc9QVxktM1hl
         jPepQgkuRvRxVn8bD7O0IQ6MrF/3j4r8YBgzfDB5F9KPqcJyazPYSpYXAK77Mfycpbm+
         y6RaIEcaT7ZuBBmB12kBRkDP/jkV11J1gojkvvT32Pz3mhNtFdF+EAHd/yUdPNyXiT4p
         5pXUD44kjJpYcYAFFahv4Bm4qGyuLLqzUevuOXBuQ1+RyPeFGZzGoYzgpfLOuMwch6IQ
         p8vmm3RmgdxPBeIJN5E252veyOr3pwPzSpkV2zCmNPzrapbS3BCVC4sr+KWtV8go0YgY
         HNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8JiowLDK9NKEYpXhjE7ef7k6LLU5h4utnwRirgJbmgT3mgA4mhaFuzhPK7/tWkdBRR3L2SDsMxdb/uoUA8Y4rel/bFTnuSsMddD4U
X-Gm-Message-State: AOJu0YwG1H7lpo8Z3QKYlQVITAT6YwIqPgP6/lLTDLvhmC7GvzONqC8d
	nMqk24V3M29XmlTm36nj3SFcCtKTv7E4ZTUrKJPrc8iDZ/O87A2S8M7XzeZmXbHzi2R7OOFTd+i
	KMEdPi821se6t+uZu/81LecpRKA==
X-Google-Smtp-Source: AGHT+IG8reWiym1vF9SnvqEOXs2T/EiuX/n+VTXgI430aQ7EltPpaOJwdA6DQTxRvZ3VUouKI5/qGBixbFMnWmALP00=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:3282:b0:e13:ca63:f17c with
 SMTP id 3f1490d57ef6-e13ca63f294mr123678276.1.1724080044031; Mon, 19 Aug 2024
 08:07:24 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:07:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJxfw2YC/23QwW7DIAwG4FepOC+TjYHATnuPaQdDTBtpa6qki
 jZVefeRXkKUHW3x/cZ+qEnGXib1dnqoUeZ+6odrKRBeTipd+HqWpu9KQ2nQhBpsE00zxvso0nC
 MyIAuA4Mq72+j5P7nGfbxWepLP92H8feZPePaXVMM7FNmbKAJwQqJCPkE7+dhOH/Jaxq+1Roz6
 4piqKkuFCIiMUci6A6UNmrQ15QKJU2CZChAkgM1G3VANTUrBS+GOscxpwO1NXU1teuuLku5m4T
 2n13dRlvEmrpC0UTJyD51kQ+0rajeTW0LZRHvE3MuYw/U17StqV8/bNEBcMeGzIGGjXrcTQ2FG m2jMZpzK3ZHl2X5A3m2zsR8AgAA
X-Mailer: b4 0.13.0
Message-ID: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com>
Subject: [PATCH v10 0/5] Red-black tree abstraction needed by Rust Binder
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
Changes in v10:
- Rebase on top of rust-for-linux/rust-next (e26fa546042add70944d018b930530d16b3cf626)
  - Adapt to changes from "rust: kbuild: split up helpers.c"
    (876346536c1b59a5b1b5e44477b1b3ece77647fd)
- Rebase on top of "rust: kernel: add `drop_contents` to `BoxExt`" instead of including it in the patch series
  - https://lore.kernel.org/all/CAH5fLgj2urZ6OD2ki6E=6EuPqW3Z8BGg8jd6Bgo4OOrNiptnDw@mail.gmail.com/
- Link to v9: https://lore.kernel.org/r/20240816-b4-rbtree-v9-0-425b442af7e5@google.com

Changes in v9:
- Rebase on top of Linux 6.11-rc2
- Address feedback from v8
- Link to v8: https://lore.kernel.org/r/20240727-b4-rbtree-v8-0-951600ada434@google.com

Changes in v8:
- Fix small style nit (use ? operator)
- Fix doc comment pointing at a private item
- Link to v7: https://lore.kernel.org/r/20240726-b4-rbtree-v7-0-aee88caaf97c@google.com

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

Matt Gilbride (1):
      rust: rbtree: add cursor

Wedson Almeida Filho (3):
      rust: rbtree: add red-black tree implementation backed by the C version
      rust: rbtree: add iterator
      rust: rbtree: add mutable iterator

 rust/helpers/helpers.c |    1 +
 rust/helpers/rbtree.c  |    9 +
 rust/kernel/lib.rs     |    1 +
 rust/kernel/rbtree.rs  | 1303 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1314 insertions(+)
---
base-commit: 68ad5e31ad2ccab128468e829f53191cf60f601f
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


