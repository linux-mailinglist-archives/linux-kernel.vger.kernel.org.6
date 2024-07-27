Return-Path: <linux-kernel+bounces-264269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8793E0EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BF91F21776
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01923D966;
	Sat, 27 Jul 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1wf15ox5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B60208B0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722112256; cv=none; b=AepPfBS5gSTF7Ly7wf4qWkPFadJUnZq5pWP3vQOg2vih+jLrg2XLvILZCO8R2d9g/9YDqIrtN1fcZvA0S8b4gjhQkXNUNAU3PkgiDl9c5+tdkOuOXStdfgJ2aAoYyGxJ+9FNfw0CMXjq+YE57EArNKzA8PxkSZTUMQbFC7f8mWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722112256; c=relaxed/simple;
	bh=ol8yMUHYdxk0eaGfzFCR+OIokuJ26t8SNULwd7TYEM0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=swHJcacrHbZyW7UBp4U9L+PN9WAnAKcF75RPfHtVhtBPmn6+rLEzi0QW5fH7MkMyddDNfzOBflu6yxK+roQGjo96Xs76aoB8PoMYwqe2fh2U/KrX4c2eHK8JzyGtNd74Aj9+tNAZNko7/BFE3ZU2B1PkcblMZ9N1zK07Htt8y0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wf15ox5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b28f23a28so1602075276.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722112253; x=1722717053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cSKWxaKZQofKx1RyVRotZETYguVPUaZB2mNr86tB8V0=;
        b=1wf15ox5U0B9CjE6fgbhrTCJtF+3vSZ+Zrf0tV534LIkq5rzcHH5NuJLC4HJr5F/ps
         uptMt1JPEcG/IAhZXUUr0tADL6jWgjiIwCTiepwyaVkbldpgUgHws0Dj5nJqlnFHUFLX
         roWWEk9WFh83ABbZSRo6GdiwLuWaOiKOCoyomr8mikYsJnkPdaT5e3Pyq8NRc+JeEbZF
         NL3iGY35gCvaSJ8hElqiA/VN1aXXdwTDxrjXZnHfeb27nptc1+TYLE3LbepeEbJSKSpC
         39uou06J9nmYX276qrilb74bLMC32592p9e+D9JuyZyyulsvm/QWyKIcXQ+SKTKOqsg3
         9o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722112253; x=1722717053;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSKWxaKZQofKx1RyVRotZETYguVPUaZB2mNr86tB8V0=;
        b=Q4gAA76YRfyjdv+6e+Ca445O0olZ2Bp5m8L7GRunFceXmQRNZOKsaOKUsw4kIxmarl
         10WtpReFjsxi2kk19ZK6JDOfUcWFDtlOBbLgqQtASX9uJ7zgh3QJSdFKZejXr/gnlgH7
         sOVJ/3gbOrZimbDnBW0js2AJuHDqux6we9XrXcJS3jveRhCTN4x/VBA9S/H5t6VhbDCa
         Srx1klQoLYwE6/0VFEdeDxbZyPTSPQXfKvGTg15dnVU4Wvz01sx+eziioHEfDa6AGjOT
         FZgmXetsc5wYHBrOU8nr6nl8NWSxbSNXcNXGlnA8hvbaRTdfAdUhENoHTrArKHnousTl
         9lrA==
X-Forwarded-Encrypted: i=1; AJvYcCVYCtMW86mxa3Dwxxw0X5hkq9iqZToIzqyyPVifLjyRw1sy1bA3XqDpjXKUkqdZWzNtoHHf1Ir3gKTcHG9rEC1jZlCHzu9sF2OpxcR9
X-Gm-Message-State: AOJu0Ywibzgj9HAFKadtq03js1BY1UiZOSTv029uRBEQHCw3OwVyAqxd
	vlF6KtG9lveC4R+C4v0qpDHbeMvaPEDJNB/fvsbZqgWmYcDVtiN923/zqCPmeIE/A3q8WYAKRvv
	RQgOVdDujaw4PNWhcTzq2BV8/9Q==
X-Google-Smtp-Source: AGHT+IHTl3sfyDu1yNHktJR09a85dnJJVearjw1LxX4KKTYzgabvSGQgjGJlmzn2okerqsuTS8lInGVOTA0hScA4wIE=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:854e:0:b0:e05:6e45:84b6 with SMTP
 id 3f1490d57ef6-e0b5455d8cfmr6334276.8.1722112252598; Sat, 27 Jul 2024
 13:30:52 -0700 (PDT)
Date: Sat, 27 Jul 2024 20:30:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPVYpWYC/23QwW7DIAwG4FepOI/JxoSQnfYe0w6GmDbS1lSki
 jZVefeRXkKUHX/E91v2Q02SB5nU2+mhsszDNIzXEvzLScULX8+ih75kZcAQGmh0sDqHexbRHAI
 yoEvAoMr/W5Y0/Dy7Pj5LvgzTfcy/z+oZ19e1xcK+ZUYNuusaIREhH+H9PI7nL3mN47daa2ZTU
 exqagqFgEjMgQj6A6WNWvQ1pULJkCBZ6iDKgdqNOqCa2pWCF0u945DigTY1dTVt1l1dknI36dp /dnUbbRFr6gpFGyQh+9gHPtC2omY3tS2URbyPzKmM3dFlWf4AuaT96QUCAAA=
X-Mailer: b4 0.13.0
Message-ID: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
Subject: [PATCH v8 0/6] Red-black tree abstraction needed by Rust Binder
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
 rust/kernel/rbtree.rs        | 1288 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1319 insertions(+), 1 deletion(-)
---
base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


