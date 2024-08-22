Return-Path: <linux-kernel+bounces-297656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92995BC13
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8AA1F20172
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10681CCEF6;
	Thu, 22 Aug 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ub1WDO5r"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AB1EB5B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344683; cv=none; b=aeUnee1uaWoAwqRi3Qm0wch0JE1VnMJqTtBCm8QhtLvqeAeyk0Ft2AbDiaedIjIWFcjfOiiGf7IErxqSVbGOy/HYHnxuoaBLMhVnKUtz7hoyGnt7alH1LrLkwi1KRUpFOJ7lYP2q3rU24p/+h//HDJQWZauU2EB0aGIt+Jp4Xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344683; c=relaxed/simple;
	bh=boH9DiVHHh9n49/gKpx7tX3Sq1XXSoYcGI3Bl+z1Ivo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jaAjM6F7IW3gr78aThj7KUjJ0QphfuTPpLO45a0XaLf901EgszxX9qpl39wzvhvOO/g/v+MsuN3cOgKh1qtEvpolLj0Xp0Uv2J8iOFBuzA49eRJejUffJMI2FC0cS92wbXq01sOafrDlgqszDjMr1NbJu476/hfASxQA30cRW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ub1WDO5r; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7a1e9a383d1so127268785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724344679; x=1724949479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVzXt96H5P6RLbsz+QdDQh4G+mrg+8IkJohzzh0JIv0=;
        b=Ub1WDO5rEsMfV+OaGpwUF41J8cpLMdk8udPmy/4Wk9zmvMxpv1HuSnTQkrVeYMNv9O
         2gKgT5h5EgjGPNeoa7L/KIrQrJUED7SIebblgO0V/plI3ftZTVVh3NxEdpgwUggbxQqe
         HQeMiERtySndYDdq12N9gpamOC9UzXmAG1hhTiWFvqL+biHK045oDB+IHsYWLRUk1XFD
         1ngtWV4Uyzow7/3jbrHJk0LVaudGemvw2nG9UYlx25gokTY8Eu+M4Q35IGozrbcTEIb4
         27wAvmGqODY/jIw0ydNX26Mw+dD9o5PAnHoS/Otdd8wdjtQZk2B/XwkNzd7VFqVzyU55
         5DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344679; x=1724949479;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVzXt96H5P6RLbsz+QdDQh4G+mrg+8IkJohzzh0JIv0=;
        b=LP6zPgBrwLn2OIftEjeJ2CJKJOvD0Yad71MdJxeoHCZdajKez4CtzIvuKEn9ZjQ65V
         eutI2n8FzcrL6FDumnE/1v7F2hSURlm2f+CfdscJTrzvsSz+25evpw82Qu/AQgG93Z6G
         a3lfBAN3vL9w8k5AzX+ENTbPALHQV3L/iq6UeRmaXlYRBsR1BLncSSHoJjbIo7P1zIXf
         ielqdC6DhuFJYKWOadquBLJN7AVYP8+86X3TUUXXFovTOvXrw6EP+SOY4nXZefGcql1X
         ZrDgNxoWxx2xG1Lo617aqJSe2vptxGIkaPCu45sfnO+YfgourDVL6kKNZzjpmYQ3FRi/
         xkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWaFcfvkUxljjY7M9xmfOOwn7SzvunEoFF46jAJBo1/pefz19s8YBArFzBZEFrOH+/HGX+xBdGODfhlkjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztO7tvrXApEmbWsOtO/eINEDf/bwyPsJMrJ4vHq+Lw09bPWYvB
	t2Jf1yaP25ESMu1ti5Ca78mfm/36JNBGgDiPSwirCxRvI7G5jI8SWZ5MQQT6Klq+wr9qdEL33Zf
	+gu/HYGo/kctwzMpzOoilCY00yQ==
X-Google-Smtp-Source: AGHT+IFMgVJK+HuwAXeTtH1ydSyn4VGbJloHaPmZXdI0D+Ndjft0XofXon7O2yv1olSGNPpDGSGHUvB0SU1u9wiKXJo=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:620a:14bc:b0:7a5:196:8864 with
 SMTP id af79cd13be357-7a6740d137amr1007985a.12.1724344679406; Thu, 22 Aug
 2024 09:37:59 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:37:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGBpx2YC/23SwW7DIAwG4Fepcl4mGxMgO+09ph0MmDbStkxJF
 W2q+u6DXkLEjiC+39hw61ZZJlm7l9OtW2Sb1mn+ygtUT6cuXPjrLP0U80anQBEqGHqv+8VfF5G
 evUcGNAkYunz+e5E0/TzC3t7z+jKt13n5fWRvWHZLioZjyoY99OM4CIkIuQCv53k+f8hzmD+7E
 rOpiuJYU5UpeERi9kQQG0o71ehqSpmSIkHSNEKQhuqdGqCa6kLBiaZo2KfQ0KGmpqZD6dUkyXO
 T0f7Tq9mpRaypyRS1l4TsQvTcUFtRdahqM2UR5wJzymUb6mpqa+rKhQc0ABxZk27ouFOHh6pjp
 loNXmvFycrQUITaHh4WoczYk1dBR0ucWlx9KKcOk8Lyo1SMwZikzGjVAd/v9z+tamBX9gIAAA= =
X-Mailer: b4 0.13.0
Message-ID: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
Subject: [PATCH v12 0/5] Red-black tree abstraction needed by Rust Binder
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
Changes in v12:
- Address feedback from v11 (superfluous INVARIANT comments in patch 4)
- Link to v11: https://lore.kernel.org/r/20240821-b4-rbtree-v11-0-2ddc66f26972@google.com

Changes in v11:
- Address feedback from v10
- Link to v10: https://lore.kernel.org/r/20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com

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
 rust/kernel/rbtree.rs  | 1279 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1290 insertions(+)
---
base-commit: 68ad5e31ad2ccab128468e829f53191cf60f601f
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


