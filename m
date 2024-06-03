Return-Path: <linux-kernel+bounces-199406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FAC8D86E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B03B228C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDF3135A69;
	Mon,  3 Jun 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqQfM5x4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B13C2D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430728; cv=none; b=dhHxRWLV00j+R6f6LDa3Narx0Km1ZWTR1qXuVMKR7FaFMxnRIkolmLMt2dkNo1cY/KJUPX7CX7VqtRhui7Z2mALLbl+QSViwRobfDjWKisIBrYkB0OCM0C/SrMgI+MlBwRKuFlUBcin4TF6rU5hzDyTgGL6XXNcygK+KezQV57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430728; c=relaxed/simple;
	bh=l5Sj3lxRWfk0XbHE+F1X72EAMcWezz/9Eep9qLPQEKc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LMvcwemBnNKHEtDeAZceoEA58NgZ869Ih6bUqx70TP7+KyETEuhY7nwfiUhgdL23qyGu4+3PM2Q/0iuhF5M7P6aB6C047x60i/ZFfvlBAOjcw+0PdtgfrTZpzjPtqzgKrTEjozvHuOoYh8eX6AJrpdj05AySZGNNP6ZiTjBszTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqQfM5x4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso2583366276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717430725; x=1718035525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RncEJdeszyiLUwbc9/gvhzsxiXteWPzB4eFyiRN0N8=;
        b=ZqQfM5x4Vpyb/oAFPQ4cIQozWOU9wFiP/UMqckh5MiBeF0k7LrsWBVaqkD/v+mXo3F
         aJOJe8zkh1JCqpJaO/8SCHAZ0Tmv5iG315Y6B8b++PCy/8wIqslSXaEL1RjCZ5np7gSP
         ExmPangvnCnjrO1uWEzQn6IK4meiqP+pWdqLS/mYvP6GlNnDNrDAOS6XnRSIbPge4iEN
         A32Rj/9MFGiSNiasPSIfyNkM8KNhUqstdiLOfTRbKwbK/+N6QbO9EFz7RJLfSrHdkCKU
         SZlL4m9KXh1P+pgu+LjrLLciIkbp9kAndchca3gsQ8PgK9CruKBpAIKMkPtji8PbGXd2
         71IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430725; x=1718035525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RncEJdeszyiLUwbc9/gvhzsxiXteWPzB4eFyiRN0N8=;
        b=afMJSAL3/JG1iHeaWF71UcY6+wUdtLjfZcEW8dsua+lPXXWl5dFUn9ZUyNbIgnvMV0
         zC+K2ngbF21WXHLVRxnWSFCE6m2iF3CyG2J82EQSCTwnjbNWUfm1vITiqT73Me3vPQIT
         zEQoUc0bpVB7iEKy4TtfDhzjBn1TQGxJGRqGzgVndp3rWn3KrAIO2qsa0mL3xhvA+FyP
         Qdv3IRPOO4+Jebc1Bezg2FN6mjcKWUYgd77YsDi5iUesDf8D2PVHyapQt1zoXTfygNBI
         xBQPXO8kZjUSH/N7ruczL5LCYuOUo9RE15BgS7ZF98up/Pg2maDLlMnIXYBzCxGxKa44
         fuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa9DdpUGFQRakHEPKtQRe81cjD74nOSWrjWAawQ58G1WFbiNyJ1hdNB/oUh+HPxj/eNRib5eFBlxu02U2S7FlVWvXrLFt9XHE47lEJ
X-Gm-Message-State: AOJu0YzLLi8+oRn6zBIegpHbvuoA9WCvGhGXcJ44bvyVh5gjhWPNL0wy
	kpwpVSy0LFeOKLF4tLK8yzZLff43LA9YkcB20BoNUmq/DHKqTXObFhQrWOfgHEKOjPp4ompThTf
	qkSbG6WtTxPpOqA1ZrtYNBR994A==
X-Google-Smtp-Source: AGHT+IEF46odfivoyPM2DQFm1oNxtmDXUHZTym+yTOPzz6LNosEPi+jZFXbQWp4sCSEPT2Gmodf8a3z9vvaEKJ/Ac1k=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:d6d8:0:b0:de5:a44c:25af with SMTP
 id 3f1490d57ef6-dfab8ba28f9mr2748276.5.1717430725042; Mon, 03 Jun 2024
 09:05:25 -0700 (PDT)
Date: Mon, 03 Jun 2024 16:05:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALvpXWYC/2XMQQ6CMBCF4auQrq2Z6RRDXXkP46KFAZqoNYU0G
 sLdLWyEuHyT+f5JDBw9D+JcTCJy8oMPzzz0oRB1b58dS9/kLRQoQgWldFpGN0ZmaZ1DC3hqwYL
 I/6/IrX+vrest794PY4ifNZ1wuS4VDftKQgnSmJKJmamq4dKF0N35WIeHWDJJbSiaLVWZgkMka x0RNH+UflRjtaWUKSliJE0Gat7ReZ6/8LtFvBkBAAA=
X-Mailer: b4 0.12.4
Message-ID: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
Subject: [PATCH v4 0/6] Red-black tree abstraction needed by Rust Binder
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
 rust/kernel/rbtree.rs        | 1278 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1309 insertions(+), 1 deletion(-)
---
base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


